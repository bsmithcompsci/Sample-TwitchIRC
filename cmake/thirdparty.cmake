include(cmake/asio.cmake)               # We are taking over the asio cmakelist, because the author doesn't use it properly...
if (NOT EXISTS "ThirdParty/TwitchIRC/CMakeLists.txt")
    message(FATAL_ERROR "Ensure that you recursively cloned this project - otherwise install https://github.com/bsmithcompsci/TwitchIRCSDK manually!")
endif()
add_subdirectory(ThirdParty/TwitchIRC)