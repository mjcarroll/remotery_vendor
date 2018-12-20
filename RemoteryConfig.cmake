get_filename_component(Remotery_CMAKE_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)

message(STATUS ${Remotery_CMAKE_DIR} ${CMAKE_CURRENT_LIST_FILE})
list(APPEND CMAKE_MODULE_PATH ${Remotery_CMAKE_DIR})

if(NOT TARGET Remotery)
  include("${Remotery_CMAKE_DIR}/RemoteryTargets.cmake")
endif()

set(Remotery_LIBRARIES Remotery)
