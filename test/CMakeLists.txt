cmake_minimum_required(VERSION 3.5)

project(RemoteryTest)

find_package(Remotery CONFIG REQUIRED)

add_executable(${PROJECT_NAME} test.cc)
target_link_libraries(${PROJECT_NAME} ${Remotery_LIBRARIES})

add_executable(Sample sample)
target_link_libraries(Sample ${Remotery_LIBRARIES} m)
