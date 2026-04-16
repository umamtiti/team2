;; Auto-generated. Do not edit!


(when (boundp 'sagittarius_openclaw_bridge::RunCommand)
  (if (not (find-package "SAGITTARIUS_OPENCLAW_BRIDGE"))
    (make-package "SAGITTARIUS_OPENCLAW_BRIDGE"))
  (shadow 'RunCommand (find-package "SAGITTARIUS_OPENCLAW_BRIDGE")))
(unless (find-package "SAGITTARIUS_OPENCLAW_BRIDGE::RUNCOMMAND")
  (make-package "SAGITTARIUS_OPENCLAW_BRIDGE::RUNCOMMAND"))
(unless (find-package "SAGITTARIUS_OPENCLAW_BRIDGE::RUNCOMMANDREQUEST")
  (make-package "SAGITTARIUS_OPENCLAW_BRIDGE::RUNCOMMANDREQUEST"))
(unless (find-package "SAGITTARIUS_OPENCLAW_BRIDGE::RUNCOMMANDRESPONSE")
  (make-package "SAGITTARIUS_OPENCLAW_BRIDGE::RUNCOMMANDRESPONSE"))

(in-package "ROS")





(defclass sagittarius_openclaw_bridge::RunCommandRequest
  :super ros::object
  :slots (_command _color _x _y _z _roll _pitch _yaw _use_rpy ))

(defmethod sagittarius_openclaw_bridge::RunCommandRequest
  (:init
   (&key
    ((:command __command) "")
    ((:color __color) "")
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:z __z) 0.0)
    ((:roll __roll) 0.0)
    ((:pitch __pitch) 0.0)
    ((:yaw __yaw) 0.0)
    ((:use_rpy __use_rpy) nil)
    )
   (send-super :init)
   (setq _command (string __command))
   (setq _color (string __color))
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _z (float __z))
   (setq _roll (float __roll))
   (setq _pitch (float __pitch))
   (setq _yaw (float __yaw))
   (setq _use_rpy __use_rpy)
   self)
  (:command
   (&optional __command)
   (if __command (setq _command __command)) _command)
  (:color
   (&optional __color)
   (if __color (setq _color __color)) _color)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:z
   (&optional __z)
   (if __z (setq _z __z)) _z)
  (:roll
   (&optional __roll)
   (if __roll (setq _roll __roll)) _roll)
  (:pitch
   (&optional __pitch)
   (if __pitch (setq _pitch __pitch)) _pitch)
  (:yaw
   (&optional __yaw)
   (if __yaw (setq _yaw __yaw)) _yaw)
  (:use_rpy
   (&optional (__use_rpy :null))
   (if (not (eq __use_rpy :null)) (setq _use_rpy __use_rpy)) _use_rpy)
  (:serialization-length
   ()
   (+
    ;; string _command
    4 (length _command)
    ;; string _color
    4 (length _color)
    ;; float64 _x
    8
    ;; float64 _y
    8
    ;; float64 _z
    8
    ;; float64 _roll
    8
    ;; float64 _pitch
    8
    ;; float64 _yaw
    8
    ;; bool _use_rpy
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _command
       (write-long (length _command) s) (princ _command s)
     ;; string _color
       (write-long (length _color) s) (princ _color s)
     ;; float64 _x
       (sys::poke _x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _y
       (sys::poke _y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _z
       (sys::poke _z (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _roll
       (sys::poke _roll (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _pitch
       (sys::poke _pitch (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _yaw
       (sys::poke _yaw (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; bool _use_rpy
       (if _use_rpy (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _command
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _command (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _color
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _color (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float64 _x
     (setq _x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _y
     (setq _y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _z
     (setq _z (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _roll
     (setq _roll (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _pitch
     (setq _pitch (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _yaw
     (setq _yaw (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; bool _use_rpy
     (setq _use_rpy (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass sagittarius_openclaw_bridge::RunCommandResponse
  :super ros::object
  :slots (_success _result_code _message _detected_color _target_x _target_y _target_z _detected_count _detected_colors _target_xs _target_ys _target_zs ))

(defmethod sagittarius_openclaw_bridge::RunCommandResponse
  (:init
   (&key
    ((:success __success) nil)
    ((:result_code __result_code) 0)
    ((:message __message) "")
    ((:detected_color __detected_color) "")
    ((:target_x __target_x) 0.0)
    ((:target_y __target_y) 0.0)
    ((:target_z __target_z) 0.0)
    ((:detected_count __detected_count) 0)
    ((:detected_colors __detected_colors) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:target_xs __target_xs) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:target_ys __target_ys) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:target_zs __target_zs) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _success __success)
   (setq _result_code (round __result_code))
   (setq _message (string __message))
   (setq _detected_color (string __detected_color))
   (setq _target_x (float __target_x))
   (setq _target_y (float __target_y))
   (setq _target_z (float __target_z))
   (setq _detected_count (round __detected_count))
   (setq _detected_colors __detected_colors)
   (setq _target_xs __target_xs)
   (setq _target_ys __target_ys)
   (setq _target_zs __target_zs)
   self)
  (:success
   (&optional (__success :null))
   (if (not (eq __success :null)) (setq _success __success)) _success)
  (:result_code
   (&optional __result_code)
   (if __result_code (setq _result_code __result_code)) _result_code)
  (:message
   (&optional __message)
   (if __message (setq _message __message)) _message)
  (:detected_color
   (&optional __detected_color)
   (if __detected_color (setq _detected_color __detected_color)) _detected_color)
  (:target_x
   (&optional __target_x)
   (if __target_x (setq _target_x __target_x)) _target_x)
  (:target_y
   (&optional __target_y)
   (if __target_y (setq _target_y __target_y)) _target_y)
  (:target_z
   (&optional __target_z)
   (if __target_z (setq _target_z __target_z)) _target_z)
  (:detected_count
   (&optional __detected_count)
   (if __detected_count (setq _detected_count __detected_count)) _detected_count)
  (:detected_colors
   (&optional __detected_colors)
   (if __detected_colors (setq _detected_colors __detected_colors)) _detected_colors)
  (:target_xs
   (&optional __target_xs)
   (if __target_xs (setq _target_xs __target_xs)) _target_xs)
  (:target_ys
   (&optional __target_ys)
   (if __target_ys (setq _target_ys __target_ys)) _target_ys)
  (:target_zs
   (&optional __target_zs)
   (if __target_zs (setq _target_zs __target_zs)) _target_zs)
  (:serialization-length
   ()
   (+
    ;; bool _success
    1
    ;; int32 _result_code
    4
    ;; string _message
    4 (length _message)
    ;; string _detected_color
    4 (length _detected_color)
    ;; float64 _target_x
    8
    ;; float64 _target_y
    8
    ;; float64 _target_z
    8
    ;; int32 _detected_count
    4
    ;; string[] _detected_colors
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _detected_colors)) 4
    ;; float64[] _target_xs
    (* 8    (length _target_xs)) 4
    ;; float64[] _target_ys
    (* 8    (length _target_ys)) 4
    ;; float64[] _target_zs
    (* 8    (length _target_zs)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;; int32 _result_code
       (write-long _result_code s)
     ;; string _message
       (write-long (length _message) s) (princ _message s)
     ;; string _detected_color
       (write-long (length _detected_color) s) (princ _detected_color s)
     ;; float64 _target_x
       (sys::poke _target_x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _target_y
       (sys::poke _target_y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _target_z
       (sys::poke _target_z (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; int32 _detected_count
       (write-long _detected_count s)
     ;; string[] _detected_colors
     (write-long (length _detected_colors) s)
     (dolist (elem _detected_colors)
       (write-long (length elem) s) (princ elem s)
       )
     ;; float64[] _target_xs
     (write-long (length _target_xs) s)
     (dotimes (i (length _target_xs))
       (sys::poke (elt _target_xs i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64[] _target_ys
     (write-long (length _target_ys) s)
     (dotimes (i (length _target_ys))
       (sys::poke (elt _target_ys i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64[] _target_zs
     (write-long (length _target_zs) s)
     (dotimes (i (length _target_zs))
       (sys::poke (elt _target_zs i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int32 _result_code
     (setq _result_code (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string _message
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _message (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _detected_color
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _detected_color (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float64 _target_x
     (setq _target_x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _target_y
     (setq _target_y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _target_z
     (setq _target_z (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; int32 _detected_count
     (setq _detected_count (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string[] _detected_colors
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _detected_colors (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _detected_colors i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; float64[] _target_xs
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _target_xs (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _target_xs i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     ))
   ;; float64[] _target_ys
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _target_ys (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _target_ys i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     ))
   ;; float64[] _target_zs
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _target_zs (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _target_zs i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     ))
   ;;
   self)
  )

(defclass sagittarius_openclaw_bridge::RunCommand
  :super ros::object
  :slots ())

(setf (get sagittarius_openclaw_bridge::RunCommand :md5sum-) "edabe0f39a90863c1a0eae298fff34ae")
(setf (get sagittarius_openclaw_bridge::RunCommand :datatype-) "sagittarius_openclaw_bridge/RunCommand")
(setf (get sagittarius_openclaw_bridge::RunCommand :request) sagittarius_openclaw_bridge::RunCommandRequest)
(setf (get sagittarius_openclaw_bridge::RunCommand :response) sagittarius_openclaw_bridge::RunCommandResponse)

(defmethod sagittarius_openclaw_bridge::RunCommandRequest
  (:response () (instance sagittarius_openclaw_bridge::RunCommandResponse :init)))

(setf (get sagittarius_openclaw_bridge::RunCommandRequest :md5sum-) "edabe0f39a90863c1a0eae298fff34ae")
(setf (get sagittarius_openclaw_bridge::RunCommandRequest :datatype-) "sagittarius_openclaw_bridge/RunCommandRequest")
(setf (get sagittarius_openclaw_bridge::RunCommandRequest :definition-)
      "string command
string color
float64 x
float64 y
float64 z
float64 roll
float64 pitch
float64 yaw
bool use_rpy
---
bool success
int32 result_code
string message
string detected_color
float64 target_x
float64 target_y
float64 target_z
int32 detected_count
string[] detected_colors
float64[] target_xs
float64[] target_ys
float64[] target_zs

")

(setf (get sagittarius_openclaw_bridge::RunCommandResponse :md5sum-) "edabe0f39a90863c1a0eae298fff34ae")
(setf (get sagittarius_openclaw_bridge::RunCommandResponse :datatype-) "sagittarius_openclaw_bridge/RunCommandResponse")
(setf (get sagittarius_openclaw_bridge::RunCommandResponse :definition-)
      "string command
string color
float64 x
float64 y
float64 z
float64 roll
float64 pitch
float64 yaw
bool use_rpy
---
bool success
int32 result_code
string message
string detected_color
float64 target_x
float64 target_y
float64 target_z
int32 detected_count
string[] detected_colors
float64[] target_xs
float64[] target_ys
float64[] target_zs

")



(provide :sagittarius_openclaw_bridge/RunCommand "edabe0f39a90863c1a0eae298fff34ae")


