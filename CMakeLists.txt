cmake_minimum_required(VERSION 3.5)

project(Remotery)

# Default to C11
if(NOT CMAKE_C_STANDARD)
  set(CMAKE_C_STANDARD 11)
endif()

# Default to C++14
if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 14)
endif()

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra)
endif()

set(
  Remotery_SRC
  Remotery/lib/Remotery.c
  Remotery/lib/Remotery.h
)

if(APPLE)
  set(
    Remotery_SRC
    ${Remotery_SRC}
    Remotery/lib/RemoteryMetal.mm
  )
endif()

set(RMT_ENABLED 1)
set(RMT_USE_TINYCRT 0)
set(RMT_USE_CUDA 0)
set(RMT_USE_D3D11 0)
set(RMT_USE_OPENGL 0)
set(RMT_USE_METAL 0)

if(UNIX OR WIN32)
  set(RMT_USE_OPENGL 1)
endif()

if(WIN32)
  set(RMT_USE_D3D11 1)
endif()

if(APPLE)
  set (RMT_USE_METAL 1)
endif()

configure_file(RemoteryConfig.h.in ${CMAKE_CURRENT_BINARY_DIR}/RemoteryConfig.h)

add_library(${PROJECT_NAME} ${Remotery_SRC})

if(UNIX)
  target_link_libraries(${PROJECT_NAME} PUBLIC pthread)
endif()

target_include_directories(${PROJECT_NAME} PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/Remotery/lib>
  $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}>
  $<INSTALL_INTERFACE:include/Remotery>
)

install(
  TARGETS ${PROJECT_NAME}
  EXPORT ${PROJECT_NAME}-export
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin
)

install(EXPORT ${PROJECT_NAME}-export
  FILE ${PROJECT_NAME}Targets.cmake
  DESTINATION lib/cmake/${PROJECT_NAME}
)

install(FILES
  RemoteryConfig.cmake
  DESTINATION lib/cmake/${PROJECT_NAME}
)

install(
  FILES
    ${CMAKE_CURRENT_BINARY_DIR}/RemoteryConfig.h
    Remotery/lib/Remotery.h
  DESTINATION include/Remotery
)

install(
  DIRECTORY Remotery/vis
  DESTINATION share/Remotery
)
