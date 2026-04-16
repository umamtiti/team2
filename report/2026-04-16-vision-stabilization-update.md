# 2026-04-16 视觉稳健化改动记录

## 背景

在前一阶段的测试中，`detect-color`、`detect-all-colors` 和 `detect-all-objects` 存在明显不稳定现象，主要表现为：

- 同一场景下重复检测结果波动较大
- 背景、边缘和反光区域容易产生误检
- 单帧检测容易因为轻微抖动或曝光变化而跳目标
- `detect_all_objects` 对桌面方块数量统计不稳定

这次改动的目标不是引入新的学习型模型，而是在保留传统视觉路线的前提下，把现有 HSV 检测链路做稳。

## 本次修改概览

本次主要修改了以下文件：

- [command_bridge.py](/home/ay/team2/src/sagittarius_openclaw_bridge-main/scripts/command_bridge.py)
- [vision_config.yaml](/home/ay/team2/src/sagittarius_arm_ros/sagittarius_perception/sagittarius_object_color_detector/config/vision_config.yaml)
- [openclaw_backend.launch](/home/ay/team2/src/sagittarius_openclaw_bridge-main/launch/openclaw_backend.launch)
- [README.md](/home/ay/team2/README.md)

## 核心改动

### 1. 将检测流程重构为更清晰的多阶段流水线

`command_bridge.py` 中的检测逻辑被重构为以下阶段：

1. 获取当前相机图像
2. 做亮度归一化
3. 构造每种颜色的 mask
4. 进行轮廓提取和候选过滤
5. 做多帧稳定投票
6. 将像素坐标映射到工作空间坐标

相比之前“单帧 HSV + 最大轮廓”的方案，这种分阶段结构更方便调试，也更容易插入约束和可视化输出。

### 2. 引入 `LAB + CLAHE` 亮度归一化

在进入 HSV 阈值分割之前，增加了亮度归一化：

- 将图像从 `BGR` 转为 `LAB`
- 只对 `L` 通道做 `CLAHE`
- 再转回 `BGR`
- 然后继续做 HSV 阈值检测

这样做的作用是：

- 减弱阴影和局部过亮区域对颜色判断的影响
- 降低相机自动曝光波动导致的检测不稳定
- 让同一个色块在不同帧中的颜色分布更接近

### 3. 用“候选过滤”替代“只取最大轮廓”

现在每个颜色不再直接取最大轮廓，而是先生成候选，再做过滤。

过滤条件包括：

- 面积必须落在允许范围内
- 目标长宽比必须接近桌面方块
- 候选中心必须落在桌面 ROI 内

这一步显著减少了：

- 边缘噪声误检
- 背景高亮区域误检
- 非方块形状的错误识别

### 4. 增加桌面 ROI 约束

在 `vision_config.yaml` 中新增 `DetectionTuning.roi`，只在桌面工作区内接受检测结果。

作用：

- 把画面边缘、背景和无关区域排除在外
- 降低背景干扰
- 提高可重复性

### 5. 单目标检测改为“多帧投票 + 中位数定位”

对于 `detect-color`、`pick-once`、`pick-any` 等单目标命令，不再依赖单帧结果，而是使用滚动窗口投票。

默认参数：

- `vote_window: 8`
- `vote_min_hits: 5`
- `vote_tolerance_px: 8.0`

只有最近若干帧中反复出现、且位置足够接近的目标才会被接受，最终位置取中位数，而不是最后一帧的结果。

这能有效缓解：

- 相机轻微抖动
- 单帧误检
- 目标框在相邻帧间跳动

### 6. 多目标检测改为短时序聚类

对于 `detect-all-colors` 和 `detect-all-objects`，现在会在短时间内收集多帧结果，然后按：

- `颜色`
- `中心点距离`

对目标进行聚类，只保留在多帧中反复出现的稳定目标。

这意味着：

- 桌面上所有方块的返回结果更稳定
- 某一帧临时出现的噪声不会直接被计入对象数量

### 7. 新增调试图像输出

为了便于调参，本次增加了可选 debug 话题，由 `publish_debug_images` 开关控制。

当启动时使用：

```bash
roslaunch sagittarius_openclaw_bridge openclaw_backend.launch \
  ... \
  publish_debug_images:=true
```

Bridge 会在检测流程中发布：

- `/command_bridge/debug/normalized`
- `/command_bridge/debug/overlay`
- `/command_bridge/debug/mask_red`
- `/command_bridge/debug/mask_green`
- `/command_bridge/debug/mask_blue`

说明：

- 这些话题不是持续不断发布的
- 它们会在执行 `detect-color`、`detect-all-colors`、`detect-all-objects`、`pick-once` 等视觉相关命令时发布

其中：

- `normalized` 用于观察亮度归一化效果
- `mask_*` 用于查看颜色阈值是否覆盖正确
- `overlay` 用于查看最终接受的候选框、中心点和 ROI

## 配置层改动

在 `vision_config.yaml` 中新增了 `DetectionTuning`：

- `roi`
- `min_pick_area`
- `max_pick_area`
- `aspect_ratio_min`
- `aspect_ratio_max`
- `vote_window`
- `vote_min_hits`
- `vote_tolerance_px`
- `multi_frame_count`
- `multi_min_hits`
- `multi_merge_tolerance_px`
- `clahe_clip_limit`
- `clahe_grid_size`

同时对 `red / green / blue` 的 HSV 范围做了面向当前相机配置的收紧和重调，默认假设为：

- `/dev/video0`
- `mjpeg`
- `640x480`
- `25fps`

## 为什么效果变好了

这次效果改善，不是因为某一个阈值突然“调对了”，而是因为检测链路整体变得更稳：

- 亮度先被归一化，颜色更稳定
- 工作区被限制，背景噪声更少
- 轮廓经过形状和面积过滤，误检更少
- 最终结果依赖多帧投票，而不是单帧瞬时判断

换句话说，这次提升来自“稳健化设计”，而不只是“调一个颜色阈值”。

## 已完成的工程验证

本次修改完成后，已经进行了以下验证：

- Python 语法检查通过
- `catkin_make --pkg sagittarius_openclaw_bridge` 构建通过
- `publish_debug_images` 开关已成功接入 launch
- `rqt_image_view` 已能查看 debug 话题
- 实际观察中，视觉检测表现相比改动前更稳定

## 当前仍需继续完成的工作

虽然稳定性已有改善，但还需要继续做现场调参与重复测试。

建议下一步：

1. 使用 `publish_debug_images:=true` 启动后端
2. 在 `rqt_image_view` 中联合观察：
   - `/usb_cam/image_raw`
   - `/command_bridge/debug/normalized`
   - `/command_bridge/debug/overlay`
   - `/command_bridge/debug/mask_red`
   - `/command_bridge/debug/mask_green`
   - `/command_bridge/debug/mask_blue`
3. 先收紧 ROI，使其只覆盖桌面工作区
4. 再针对红、绿、蓝分别微调 HSV 范围
5. 用 `detect-color` 和 `detect-all-objects` 做重复 10 次测试
6. 记录成功率和对象计数稳定性

## 建议的后续验收目标

- `detect-color --color red|green|blue` 在相同场景下 10 次中至少成功 8 次
- `detect-all-objects` 在桌面方块数量固定时，10 次中至少 8 次返回正确数量
- ROI 外区域的假阳性接近于 0

## 结论

本次改动完成了传统视觉路线的一次关键稳健化升级。系统仍然是基于 HSV 的轻量方案，但已经从“单帧脆弱检测”演进为“带亮度归一化、候选过滤、ROI 约束和多帧投票”的更可靠版本。

这为后续的抓取测试、实验设计和中期汇报提供了一个更稳的感知基础。
