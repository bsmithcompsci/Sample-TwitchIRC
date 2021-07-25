if (NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/ThirdParty/asio/asio/include/asio.hpp")
    message(FATAL_ERROR "Ensure that you recursively cloned this project - otherwise install https://github.com/chriskohlhoff/asio manually!")
endif()

add_library(
	asio INTERFACE
)
target_include_directories(
	asio INTERFACE
	ThirdParty/asio/asio/include
)

target_compile_definitions(
	asio
	INTERFACE ASIO_STANDALONE
)
