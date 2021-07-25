cmake_minimum_required( VERSION 3.17 )
project( TwitchIRC-Sample VERSION 1.0.0 )

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "$<1:${CMAKE_CURRENT_SOURCE_DIR}/.Intermediate/Build/${CMAKE_SYSTEM_NAME}/Bin/>")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "$<1:${CMAKE_CURRENT_SOURCE_DIR}/.Intermediate/Build/${CMAKE_SYSTEM_NAME}/Lib/>")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "$<1:${CMAKE_CURRENT_SOURCE_DIR}/.Intermediate/Build/${CMAKE_SYSTEM_NAME}/Lib/>")


include(cmake/main.cmake)