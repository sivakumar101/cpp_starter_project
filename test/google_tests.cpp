#include <gtest/gtest.h>

// GoogleTest build setup test
TEST(SetupTest, BasicAssertion)
{
    EXPECT_STREQ("OK", "OK");
}

int main(int argc, char **argv)
{
    ::testing::InitGoogleTest(&argc, argv);

    return RUN_ALL_TESTS();
}
