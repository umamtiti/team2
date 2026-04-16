# sagittarius_openclaw_bridge

`sagittarius_openclaw_bridge` exposes the Sagittarius robotic arm as a set of task-level commands that can be called by OpenClaw or from the command line.

## Quick Start

### 1. Source the workspace

```bash
source /opt/ros/noetic/setup.bash
source ~/team2/devel/setup.bash
```

### 2. Start the backend

Default startup:

```bash
roslaunch sagittarius_openclaw_bridge openclaw_backend.launch
```

If the arm is exposed as `/dev/ttyACM0` instead of `/dev/sagittarius`:

```bash
roslaunch sagittarius_openclaw_bridge openclaw_backend.launch \
  serialname:=/dev/ttyACM0
```

Recommended startup when using the USB camera on `/dev/video0`:

```bash
roslaunch sagittarius_openclaw_bridge openclaw_backend.launch \
  serialname:=/dev/ttyACM0 \
  video_dev:=/dev/video0 \
  pixel_format:=mjpeg \
  image_width:=640 \
  image_height:=480 \
  framerate:=25
```

Useful timeout options:

```bash
roslaunch sagittarius_openclaw_bridge openclaw_backend.launch find_timeout:=60
roslaunch sagittarius_openclaw_bridge openclaw_backend.launch find_timeout:=0
```

`find_timeout:=60` waits up to 60 seconds for detection.  
`find_timeout:=0` keeps waiting until an object appears.

Enable debug image topics for perception tuning:

```bash
roslaunch sagittarius_openclaw_bridge openclaw_backend.launch \
  serialname:=/dev/ttyACM0 \
  video_dev:=/dev/video0 \
  pixel_format:=mjpeg \
  image_width:=640 \
  image_height:=480 \
  framerate:=25 \
  publish_debug_images:=true
```

When `publish_debug_images:=true`, the bridge publishes:

- `/command_bridge/debug/normalized`
- `/command_bridge/debug/overlay`
- `/command_bridge/debug/mask_red`
- `/command_bridge/debug/mask_green`
- `/command_bridge/debug/mask_blue`

## Common Commands

All commands below assume:

```bash
source /opt/ros/noetic/setup.bash
source ~/team2/devel/setup.bash
```

### System and posture commands

Check whether the backend is ready:

```bash
rosrun sagittarius_openclaw_bridge openclaw_cmd.py status
```

Move to the observation/search pose:

```bash
rosrun sagittarius_openclaw_bridge openclaw_cmd.py search
```

Move to the stay pose:

```bash
rosrun sagittarius_openclaw_bridge openclaw_cmd.py stay
```

Move to the sleep pose:

```bash
rosrun sagittarius_openclaw_bridge openclaw_cmd.py sleep
```

### Detection commands

Detect a specific color:

```bash
rosrun sagittarius_openclaw_bridge openclaw_cmd.py detect-color --color blue
```

Detect any supported visible color:

```bash
rosrun sagittarius_openclaw_bridge openclaw_cmd.py detect-color
```

Detect all stable visible colors at once:

```bash
rosrun sagittarius_openclaw_bridge openclaw_cmd.py detect-all-colors
```

Detect all visible color blocks at once and return each object's color and position:

```bash
rosrun sagittarius_openclaw_bridge openclaw_cmd.py detect-all-objects
```

### Basic manipulation commands

Pick a specified color once:

```bash
rosrun sagittarius_openclaw_bridge openclaw_cmd.py pick-once --color blue
```

Pick any detected object:

```bash
rosrun sagittarius_openclaw_bridge openclaw_cmd.py pick-any
```

Pick a color and place it at a target pose:

```bash
rosrun sagittarius_openclaw_bridge openclaw_cmd.py pick-and-place \
  --color blue \
  --x 0.16 --y 0.24 --z 0.20 \
  --pitch 1.57 --use-rpy
```

Move the end effector to a Cartesian pose:

```bash
rosrun sagittarius_openclaw_bridge openclaw_cmd.py move \
  --x 0.20 --y 0.00 --z 0.15 \
  --pitch 1.57 --use-rpy
```

Pick from a specified Cartesian pose:

```bash
rosrun sagittarius_openclaw_bridge openclaw_cmd.py pick \
  --x 0.24 --y 0.00 --z 0.02 \
  --pitch 1.57 --use-rpy
```

Place at a specified Cartesian pose:

```bash
rosrun sagittarius_openclaw_bridge openclaw_cmd.py put \
  --x 0.16 --y 0.24 --z 0.20
```

### Sorting commands

Run one fixed-rule sorting cycle:

```bash
rosrun sagittarius_openclaw_bridge openclaw_cmd.py classify-once-fixed
```

Sort all visible objects using fixed drop positions:

```bash
rosrun sagittarius_openclaw_bridge openclaw_cmd.py sort-all-fixed
```

Run one map-based classification cycle:

```bash
rosrun sagittarius_openclaw_bridge openclaw_cmd.py classify-once-map
```

## Typical Workflows

### Workflow 1: Check readiness and observe the scene

```bash
rosrun sagittarius_openclaw_bridge openclaw_cmd.py status
rosrun sagittarius_openclaw_bridge openclaw_cmd.py search
rosrun sagittarius_openclaw_bridge openclaw_cmd.py detect-color --color blue
rosrun sagittarius_openclaw_bridge openclaw_cmd.py detect-all-colors
rosrun sagittarius_openclaw_bridge openclaw_cmd.py detect-all-objects
```

### Workflow 2: Pick a blue block

```bash
rosrun sagittarius_openclaw_bridge openclaw_cmd.py pick-once --color blue
```

### Workflow 3: Pick and place a blue block

```bash
rosrun sagittarius_openclaw_bridge openclaw_cmd.py pick-and-place \
  --color blue \
  --x 0.16 --y 0.24 --z 0.20 \
  --pitch 1.57 --use-rpy
```

### Workflow 4: Sort all visible blocks

```bash
rosrun sagittarius_openclaw_bridge openclaw_cmd.py sort-all-fixed
```

## OpenClaw Service Commands

The backend exposes the `openclaw/run_command` service. Supported commands are:

- `move`
- `pick`
- `put`
- `stay`
- `sleep`
- `search`
- `detect_color`
- `detect_all_colors`
- `detect_all_objects`
- `pick_once`
- `pick_any`
- `pick_and_place`
- `classify_once_fixed`
- `sort_all_fixed`
- `classify_once_map`
- `status`

## Useful ROS Checks

Check whether the service is available:

```bash
rosservice list | rg openclaw/run_command
```

Check whether the camera is publishing images:

```bash
rostopic hz /usb_cam/image_raw
```

Check running ROS nodes:

```bash
rosnode list
```

## What the Backend Starts

Starting `openclaw_backend.launch` will typically bring up:

- `sagittarius_moveit/demo_true.launch`
- `sgr532/sgr_ctrl`
- `usb_cam`
- `command_bridge.py`
