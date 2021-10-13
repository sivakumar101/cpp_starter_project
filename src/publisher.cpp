/*
 *                         Vortex OpenSplice
 *
 *   This software and documentation are Copyright 2006 to  ADLINK
 *   Technology Limited, its affiliated companies and licensors. All rights
 *   reserved.
 *
 *   Licensed under the Apache License, Version 2.0 (the "License");
 *   you may not use this file except in compliance with the License.
 *   You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 *   Unless required by applicable law or agreed to in writing, software
 *   distributed under the License is distributed on an "AS IS" BASIS,
 *   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *   See the License for the specific language governing permissions and
 *   limitations under the License.
 *
 */

#include <iostream>
#include <iterator>
#include <algorithm>

#include "implementation.h"
#include <boost/version.hpp>
#include <boost/lambda/lambda.hpp>

/**
 * @addtogroup examplesdcpsHelloWorldisocpp
 */
/** @{*/
/** @file */
/** @}*/

int EXAMPLE_MAIN (int argc, char *argv[])
{
    std::cout << "==========================================\n";
    std::cout << "Using Boost "
    << BOOST_VERSION / 100000     << "."  // major version
    << BOOST_VERSION / 100 % 1000 << "."  // minor version
    << BOOST_VERSION % 100                // patch level
    << std::endl;
    std::cout << "==========================================\n";

    std::vector<int> v{1, 3, 2, 5, 6};

    
    std::cout << "============= PRINT VECTOR VALUES ==========================\n";
    std::for_each(v.begin(), v.end(),
        std::cout << boost::lambda::_1 << "\n");

    return examples::dcps::HelloWorld::isocpp::publisher(argc, argv);
}
