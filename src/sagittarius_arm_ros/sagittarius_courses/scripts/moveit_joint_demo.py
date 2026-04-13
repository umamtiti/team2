#!/usr/bin/env python
# -*- coding: utf-8 -*-

import rospy, sys
import moveit_commander
from geometry_msgs.msg import PoseStamped, Pose

class MoveItIkDemo:
	def __init__(self):
		moveit_commander.roscpp_initialize(sys.argv)
		rospy.init_node('moveit_ik_demo')
		arm = moveit_commander.MoveGroupCommander("sagittarius_arm")
		end_effector_link = arm.get_end_effector_link()
		reference_frame = 'world'
		arm.set_pose_reference_frame(reference_frame)
		
		arm.allow_replanning(True)
		arm.set_goal_position_tolerance(0.001)
		arm.set_goal_orientation_tolerance(0.001)
		
		arm.set_max_acceleration_scaling_factor(0.5)
		arm.set_max_velocity_scaling_factor(0.5)
		
		arm.set_named_target('home')
		arm.go()
		rospy.sleep(1)
		
		target_pose = PoseStamped()
		target_pose.header.frame_id = reference_frame
		target_pose.header.stamp = rospy.Time.now() 
		target_pose.pose.position.x = 0.2472990396168796
		target_pose.pose.position.y = 0.0006590926103004068
		target_pose.pose.position.z = 0.3456034504080325
		target_pose.pose.orientation.w = 1.0
        
		# 设置机器臂当前的状态作为运动初始状态
		arm.set_start_state_to_current_state()
		
		# 设置机械臂终端运动的目标位姿
		arm.set_pose_target(target_pose, end_effector_link)
		
		# 规划运动路径
		#traj = arm.plan()
		plan_success, traj, planning_time, error_code = arm.plan()
		
		# 按照规划的运动路径控制机械臂运动
		arm.execute(traj)
		rospy.sleep(1)

		# 控制机械臂回到初始化位置
		arm.set_named_target('sleep')
		arm.go()

		# 关闭并退出moveit
		moveit_commander.roscpp_shutdown()
		moveit_commander.os._exit(0)

if __name__ == "__main__":
    MoveItIkDemo()
