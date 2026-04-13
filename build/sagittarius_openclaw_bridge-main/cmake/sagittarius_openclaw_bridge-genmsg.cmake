# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "sagittarius_openclaw_bridge: 0 messages, 1 services")

set(MSG_I_FLAGS "")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(sagittarius_openclaw_bridge_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/ay/team2/src/sagittarius_openclaw_bridge-main/srv/RunCommand.srv" NAME_WE)
add_custom_target(_sagittarius_openclaw_bridge_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sagittarius_openclaw_bridge" "/home/ay/team2/src/sagittarius_openclaw_bridge-main/srv/RunCommand.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages

### Generating Services
_generate_srv_cpp(sagittarius_openclaw_bridge
  "/home/ay/team2/src/sagittarius_openclaw_bridge-main/srv/RunCommand.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sagittarius_openclaw_bridge
)

### Generating Module File
_generate_module_cpp(sagittarius_openclaw_bridge
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sagittarius_openclaw_bridge
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(sagittarius_openclaw_bridge_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(sagittarius_openclaw_bridge_generate_messages sagittarius_openclaw_bridge_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ay/team2/src/sagittarius_openclaw_bridge-main/srv/RunCommand.srv" NAME_WE)
add_dependencies(sagittarius_openclaw_bridge_generate_messages_cpp _sagittarius_openclaw_bridge_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sagittarius_openclaw_bridge_gencpp)
add_dependencies(sagittarius_openclaw_bridge_gencpp sagittarius_openclaw_bridge_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sagittarius_openclaw_bridge_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages

### Generating Services
_generate_srv_eus(sagittarius_openclaw_bridge
  "/home/ay/team2/src/sagittarius_openclaw_bridge-main/srv/RunCommand.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sagittarius_openclaw_bridge
)

### Generating Module File
_generate_module_eus(sagittarius_openclaw_bridge
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sagittarius_openclaw_bridge
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(sagittarius_openclaw_bridge_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(sagittarius_openclaw_bridge_generate_messages sagittarius_openclaw_bridge_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ay/team2/src/sagittarius_openclaw_bridge-main/srv/RunCommand.srv" NAME_WE)
add_dependencies(sagittarius_openclaw_bridge_generate_messages_eus _sagittarius_openclaw_bridge_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sagittarius_openclaw_bridge_geneus)
add_dependencies(sagittarius_openclaw_bridge_geneus sagittarius_openclaw_bridge_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sagittarius_openclaw_bridge_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages

### Generating Services
_generate_srv_lisp(sagittarius_openclaw_bridge
  "/home/ay/team2/src/sagittarius_openclaw_bridge-main/srv/RunCommand.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sagittarius_openclaw_bridge
)

### Generating Module File
_generate_module_lisp(sagittarius_openclaw_bridge
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sagittarius_openclaw_bridge
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(sagittarius_openclaw_bridge_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(sagittarius_openclaw_bridge_generate_messages sagittarius_openclaw_bridge_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ay/team2/src/sagittarius_openclaw_bridge-main/srv/RunCommand.srv" NAME_WE)
add_dependencies(sagittarius_openclaw_bridge_generate_messages_lisp _sagittarius_openclaw_bridge_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sagittarius_openclaw_bridge_genlisp)
add_dependencies(sagittarius_openclaw_bridge_genlisp sagittarius_openclaw_bridge_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sagittarius_openclaw_bridge_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages

### Generating Services
_generate_srv_nodejs(sagittarius_openclaw_bridge
  "/home/ay/team2/src/sagittarius_openclaw_bridge-main/srv/RunCommand.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sagittarius_openclaw_bridge
)

### Generating Module File
_generate_module_nodejs(sagittarius_openclaw_bridge
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sagittarius_openclaw_bridge
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(sagittarius_openclaw_bridge_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(sagittarius_openclaw_bridge_generate_messages sagittarius_openclaw_bridge_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ay/team2/src/sagittarius_openclaw_bridge-main/srv/RunCommand.srv" NAME_WE)
add_dependencies(sagittarius_openclaw_bridge_generate_messages_nodejs _sagittarius_openclaw_bridge_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sagittarius_openclaw_bridge_gennodejs)
add_dependencies(sagittarius_openclaw_bridge_gennodejs sagittarius_openclaw_bridge_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sagittarius_openclaw_bridge_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages

### Generating Services
_generate_srv_py(sagittarius_openclaw_bridge
  "/home/ay/team2/src/sagittarius_openclaw_bridge-main/srv/RunCommand.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sagittarius_openclaw_bridge
)

### Generating Module File
_generate_module_py(sagittarius_openclaw_bridge
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sagittarius_openclaw_bridge
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(sagittarius_openclaw_bridge_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(sagittarius_openclaw_bridge_generate_messages sagittarius_openclaw_bridge_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ay/team2/src/sagittarius_openclaw_bridge-main/srv/RunCommand.srv" NAME_WE)
add_dependencies(sagittarius_openclaw_bridge_generate_messages_py _sagittarius_openclaw_bridge_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sagittarius_openclaw_bridge_genpy)
add_dependencies(sagittarius_openclaw_bridge_genpy sagittarius_openclaw_bridge_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sagittarius_openclaw_bridge_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sagittarius_openclaw_bridge)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sagittarius_openclaw_bridge
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sagittarius_openclaw_bridge)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sagittarius_openclaw_bridge
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sagittarius_openclaw_bridge)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sagittarius_openclaw_bridge
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sagittarius_openclaw_bridge)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sagittarius_openclaw_bridge
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sagittarius_openclaw_bridge)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sagittarius_openclaw_bridge\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sagittarius_openclaw_bridge
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
