project(unittests)

add_executable(googletests google_tests.cpp)
#target_link_libraries(googletests PRIVATE project_warnings project_options gtest gtest_main)
target_link_libraries(googletests PRIVATE gtest gtest_main)
add_test(NAME example_unittests COMMAND googletests)
