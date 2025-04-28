#include <iostream>
#include "tbcrypto.h"

#define TOSSBANK_KEY    "259A0088ACFDC94E920BE1AB92CB8C8206C3D00B2174DDD4EF1EFD6EF7C393AD"
#define TOSSBANK_IV		"764533506158694563386856796F6F75"
#define TOSSBANK_SALT   "832B15B4F9E5D2E123567A5CC95DF78A"

int main() {
	// c++
	std::cout << "-- test with C++ ---------------------------------------------------------------" << std::endl;
	std::cout << "success: " << encrypt(TOSSBANK_KEY, TOSSBANK_IV, "1234") << std::endl;
	std::cout << "success: " << decrypt(TOSSBANK_KEY, TOSSBANK_IV, "bTVHTeQP+8i8fR8kJIjDrQ==") << std::endl;
	std::cout << "success: " << hash(TOSSBANK_SALT, "2021") << std::endl;

	// exception
	try {
		std::string decrypted = decrypt(TOSSBANK_KEY, TOSSBANK_IV, "1234");
		std::cout << "success: " << decrypted << std::endl;
	}
	catch (TBCryptoException &ex) {
		std::cout << "exception: " << ex.error_code()
				  << ", " << ex.error_type()
				  << ", " << ex.what() << std::endl;
	}

	std::cout << std::endl;
	return 0;
}

