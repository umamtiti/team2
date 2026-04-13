
(cl:in-package :asdf)

(defsystem "sagittarius_openclaw_bridge-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "RunCommand" :depends-on ("_package_RunCommand"))
    (:file "_package_RunCommand" :depends-on ("_package"))
  ))