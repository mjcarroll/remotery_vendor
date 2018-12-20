cmake_minimum_required(VERSION 3.5)

project(RemoteryTest)

find_package(Remotery CONFIG REQUIRED)

get_cmake_property(_variableNames VARIABLES)
list (SORT _variableNames)
foreach (_variableName ${_variableNames})
    message(STATUS "${_variableName}=${${_variableName}}")
endforeach()

add_executable(${PROJECT_NAME} test.cc)
target_link_libraries(${PROJECT_NAME} ${Remotery_LIBRARIES})
