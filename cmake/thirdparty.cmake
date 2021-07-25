# ASIO
include(cmake/asio.cmake)               # We are taking over the asio cmakelist, because the author doesn't use it properly...
if (NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/ThirdParty/TwitchIRCSDK/CMakeLists.txt")
    message(FATAL_ERROR "Ensure that you recursively cloned this project - otherwise install https://github.com/bsmithcompsci/TwitchIRCSDK manually!")
endif()

# TwitchIRCSDK
add_subdirectory(ThirdParty/TwitchIRCSDK)
set_target_properties( TwitchIRCSDK PROPERTIES FOLDER "ThirdParty" )
