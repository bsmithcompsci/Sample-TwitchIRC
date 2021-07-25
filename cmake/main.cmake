include(cmake/options.cmake)
include(cmake/compiler.cmake)
include(cmake/thirdparty.cmake)

# Now we can add the main executable.
add_executable( TwitchIRC-Example
    src/main.cpp
)

# Link the TwitchIRC SDK to our sample project.
target_link_libraries( TwitchIRC-Example TwitchIRCSDK )

# Set this as our startup project, so we can immediately start working with it.
# Note: This only applies to Visual Studio.
set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT TwitchIRC-Example)

# Set the current working directory to where the build is... this helps when trying to test compiles from the editor.
# Note: This only applies to Visual Studio.
set_target_properties(
    TwitchIRC-Example PROPERTIES
    VS_DEBUGGER_WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/.Intermediate/Build/${CMAKE_SYSTEM_NAME}/")