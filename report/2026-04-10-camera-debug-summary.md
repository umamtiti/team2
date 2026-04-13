# 2026-04-10 相机问题排查记录

## 问题现象

在运行 OpenClaw 桥接和视觉抓取流程时，`pick-once --color blue` 一直失败，前期现象包括：

- `/usb_cam/image_raw` 话题存在，但 `rostopic hz /usb_cam/image_raw` 一直显示 `no new messages`
- `usb_cam` 节点有时直接退出
- 桥接层返回：

```text
success: false
result_code: 1002
message: No stable object was detected on /usb_cam/image_raw
```

这个报错最开始容易误判成 HSV 或手眼标定问题，但实际根因先出在相机没有正常出图。

## 根因总结

今天确认到的相机问题不是单一原因，而是多个问题叠加：

1. 原始 `usb_cam.launch` 把参数写死了  
   即使命令行传了 `pixel_format:=mjpeg`、`framerate:=25`，实际仍然按固定的 `yuyv + 640x480 + 30FPS` 启动。

2. `/dev/video0` 才是真正可用的视频流接口  
   通过 `v4l2-ctl --device=/dev/video0 --list-formats-ext` 确认：
   - `MJPG 1280x720 @ 30fps`
   - `MJPG 640x480 @ 25fps`
   - `YUYV 1280x720 @ 10fps`
   - `YUYV 640x480 @ 25fps`

3. `/dev/video1` 不是正确的视频流配置目标  
   虽然设备存在，但没有正常的格式列表，并且测试时出现：

```text
VIDIOC_G_FMT error 22, Invalid argument
```

4. `/dev/video0` 使用默认配置会失败  
   默认启动参数是 `yuyv + 640x480 + 30FPS`，而设备只支持 `YUYV 640x480 @ 25fps`，因此出现：

```text
select timeout
```

5. `/dev/video1` 早期还有权限问题  
   访问 `/dev/video1` 时出现：

```text
Cannot open '/dev/video1': 13, Permission denied
```

这说明当前用户一开始没有足够的视频设备访问权限。

## 排查过程

### 1. 先确认 Linux 是否看到了相机

执行：

```bash
ls -l /dev/usb_cam /dev/video*
```

结果确认：

- `/dev/usb_cam -> /dev/video0`
- `/dev/video0` 存在
- `/dev/video1` 存在

说明设备层已经识别到了摄像头，问题不在“没有摄像头设备”。

### 2. 检查为什么 `/usb_cam/image_raw` 没有消息

执行：

```bash
rostopic hz /usb_cam/image_raw
```

结果一直是：

```text
no new messages
```

说明 ROS 话题名存在，但没有真正视频帧发布出来。

### 3. 单独测试 `usb_cam.launch`

分别测试：

```bash
roslaunch sagittarius_object_color_detector usb_cam.launch
roslaunch sagittarius_object_color_detector usb_cam.launch video_dev:=/dev/video1
```

观察到：

- `/dev/video0` 默认配置下报 `select timeout`
- `/dev/video1` 一开始报 `Permission denied`
- 权限解决后再试 `/dev/video1`，变成 `VIDIOC_G_FMT error 22`

### 4. 用 `v4l2-ctl` 确认真实支持的格式

执行：

```bash
v4l2-ctl --device=/dev/video0 --list-formats-ext
v4l2-ctl --device=/dev/video1 --list-formats-ext
```

最终判断：

- 应该优先使用 `/dev/video0`
- `/dev/video1` 不是当前应该选的主视频流接口

### 5. 发现 launch 传参无效

尝试这样启动：

```bash
roslaunch sagittarius_object_color_detector usb_cam.launch \
  video_dev:=/dev/video0 \
  pixel_format:=mjpeg \
  image_width:=640 \
  image_height:=480 \
  framerate:=25
```

但日志仍然显示：

```text
Starting 'head_camera' (/dev/video0) at 640x480 via mmap (yuyv) at 30 FPS
```

这说明 `usb_cam.launch` 没有把这些参数做成可配置项，而是写死了默认值。

## 代码修改

今天做了以下修复：

1. 将 `usb_cam.launch` 改成可参数化  
   文件：
   [usb_cam.launch](/home/ay/team2/src/sagittarius_arm_ros/sagittarius_perception/sagittarius_object_color_detector/launch/usb_cam.launch)

   新增可传参数：

- `video_dev`
- `image_width`
- `image_height`
- `pixel_format`
- `framerate`
- `camera_frame_id`
- `io_method`

2. 将上层视觉 launch 统一透传相机参数  
   已修改这些文件：

- [hsv_params.launch](/home/ay/team2/src/sagittarius_arm_ros/sagittarius_perception/sagittarius_object_color_detector/launch/hsv_params.launch)
- [camera_calibration_hsv.launch](/home/ay/team2/src/sagittarius_arm_ros/sagittarius_perception/sagittarius_object_color_detector/launch/camera_calibration_hsv.launch)
- [object_pick.launch](/home/ay/team2/src/sagittarius_arm_ros/sagittarius_perception/sagittarius_object_color_detector/launch/object_pick.launch)
- [color_classification.launch](/home/ay/team2/src/sagittarius_arm_ros/sagittarius_perception/sagittarius_object_color_detector/launch/color_classification.launch)
- [color_classification_fixed.launch](/home/ay/team2/src/sagittarius_arm_ros/sagittarius_perception/sagittarius_object_color_detector/launch/color_classification_fixed.launch)

3. 将 OpenClaw 后端 launch 也支持透传相机参数  
   文件：
   [openclaw_backend.launch](/home/ay/team2/src/sagittarius_openclaw_bridge-main/launch/openclaw_backend.launch)

## 当前可用的测试方式

### 单独测试相机

推荐优先测试：

```bash
source /opt/ros/noetic/setup.bash
source ~/team2/devel/setup.bash
roslaunch sagittarius_object_color_detector usb_cam.launch \
  video_dev:=/dev/video0 \
  pixel_format:=mjpeg \
  image_width:=640 \
  image_height:=480 \
  framerate:=25
```

这个组合已经确认会真正生效，日志会显示：

```text
Starting 'head_camera' (/dev/video0) at 640x480 via mmap (mjpeg) at 25 FPS
```

### 启动完整 OpenClaw 后端

```bash
source /opt/ros/noetic/setup.bash
source ~/team2/devel/setup.bash
roslaunch sagittarius_openclaw_bridge openclaw_backend.launch \
  video_dev:=/dev/video0 \
  pixel_format:=mjpeg \
  image_width:=640 \
  image_height:=480 \
  framerate:=25
```

## 对 MJPEG 警告的判断

在使用 `mjpeg` 时，日志里会持续出现：

```text
[mjpeg @ ...] unable to decode APP fields: Invalid data found when processing input
```

当前判断：

- 这类信息更像 MJPEG 元数据解析警告
- 它不一定是致命错误
- 因为此时 `usb_cam` 节点并没有像之前那样直接崩溃
- 并且完整后端已经能走到：

```text
OpenClaw bridge ready on service openclaw/run_command
```

所以这类告警目前可以先视为“可接受的噪声”，关键还是看：

```bash
rostopic hz /usb_cam/image_raw
```

和：

```bash
rqt_image_view
```

是否能确认真正出图。

## 今天的最终结论

今天相机问题的主要原因和对应方法如下：

- 原因 1：相机 launch 参数写死，传参无效  
  方法：把 `usb_cam.launch` 和所有上层 launch 改成参数透传

- 原因 2：误以为 `/dev/video1` 可能是主相机  
  方法：用 `v4l2-ctl` 查看支持格式，最终确认应优先使用 `/dev/video0`

- 原因 3：默认参数不匹配摄像头支持能力  
  方法：根据 `v4l2-ctl` 结果切换到设备真实支持的组合，如 `video0 + mjpeg + 640x480 + 25fps`

- 原因 4：权限与设备接口混淆  
  方法：先确认 `/dev/video*` 和 `/dev/usb_cam` 是否存在，再区分是权限问题、格式问题还是超时问题

## 后续建议

1. 继续确认 `/usb_cam/image_raw` 是否真的在稳定发布
2. 用 `rqt_image_view` 实际查看画面
3. 如果 MJPEG 警告太多，可再尝试：

```bash
roslaunch sagittarius_object_color_detector usb_cam.launch \
  video_dev:=/dev/video0 \
  pixel_format:=yuyv \
  image_width:=640 \
  image_height:=480 \
  framerate:=25
```

4. 一旦确认稳定出图，再继续调 HSV 和 `pick-once --color blue`
