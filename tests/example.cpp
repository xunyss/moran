#include <iostream>
#include "../src/moran.h"

#define TEST_KEY    "06C3D00B2174DDD4EF1EFD6EF7C393AD259A0088ACFDC94E920BE1AB92CB8C82"
#define TEST_IV		"63386856796F6F757645335061586945"
#define TEST_SALT   "23567A5CC95DF78A832B15B4F9E5D2E1"


int main() {
	// c++
	std::cout << "-- test with C++ ---------------------------------------------------------------" << std::endl;
	std::cout << "success: " << encrypt(TEST_KEY, TEST_IV, "1234") << std::endl;
	std::cout << "success: " << decrypt(TEST_KEY, TEST_IV, "4RP470/Uyh1m0RV2ZkO4rA==") << std::endl;
	std::cout << "success: " << hash(TEST_SALT, "2021") << std::endl;

	// exception
	try {
		std::string decrypted = decrypt(TEST_KEY, TEST_IV, "1234");
		std::cout << "success: " << decrypted << std::endl;
	}
	catch (MoranException &ex) {
		std::cout << "exception: " << ex.error_code()
				  << ", " << ex.error_type()
				  << ", " << ex.what() << std::endl;
	}

	std::cout << std::endl;
	return 0;
}

