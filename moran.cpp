
#ifdef _WIN32
	#define DLL_EXPORTING
#endif

#include "moran.h"
#include <botan/pipe.h>
#include <botan/filters.h>
#include <botan/hex.h>

#define CIPHER_ALGORITHM	"AES-256/CBC"
#define HASH_ALGORITHM		"SHA-256"

//	#define TEST_KEY		"259A0088ACFDC94E920BE1AB92CB8C8206C3D00B2174DDD4EF1EFD6EF7C393AD"
//	#define TEST_IV			"764533506158694563386856796F6F75"
//	#define TEST_SALT		"832B15B4F9E5D2E123567A5CC95DF78A"


std::string encrypt(std::string hex_key, std::string hex_iv, std::string plain)
{
	try {
		Botan::SymmetricKey key(hex_key);
		Botan::InitializationVector iv(hex_iv);

		Botan::Pipe pipe(Botan::get_cipher(CIPHER_ALGORITHM, key, iv, Botan::ENCRYPTION), new Botan::Base64_Encoder);
		pipe.process_msg(plain);

		return pipe.read_all_as_string(0);
	}
	catch (Botan::Exception &ex) {
		throw TBCryptoException(static_cast<int>(ex.error_type()), to_string(ex.error_type()), ex.what());
	}
}

std::string decrypt(std::string hex_key, std::string hex_iv, std::string cipher)
{
	try {
		Botan::SymmetricKey key(hex_key);
		Botan::InitializationVector iv(hex_iv);

		Botan::Pipe pipe(new Botan::Base64_Decoder, Botan::get_cipher(CIPHER_ALGORITHM, key, iv, Botan::DECRYPTION));
		pipe.process_msg(cipher);

		return pipe.read_all_as_string(0);
	}
	catch (Botan::Exception &ex) {
		throw TBCryptoException(static_cast<int>(ex.error_type()), to_string(ex.error_type()), ex.what());
	}
}

std::string hash(std::string hex_salt, std::string plain)
{
	try {
		std::vector<uint8_t> message = Botan::hex_decode(hex_salt);
		message.insert(std::end(message), plain.begin(), plain.end());

		Botan::Pipe pipe(new Botan::Hash_Filter(HASH_ALGORITHM), new Botan::Base64_Encoder);
		pipe.process_msg(message);

		return pipe.read_all_as_string(0);
	}
	catch (Botan::Exception &ex) {
		throw TBCryptoException(static_cast<int>(ex.error_type()), to_string(ex.error_type()), ex.what());
	}
}


int encrypt(char* hex_key, char* hex_iv,
			 char* plain, unsigned int plain_length,
			 char* cipher, unsigned int* cipher_length)
{
	try {
		std::string input(plain, 0, plain_length);
		std::string output = encrypt(hex_key, hex_iv, input);
		std::copy(output.begin(), output.end(), cipher);
		*cipher_length = output.length();
		return CRYPTO_SUCCESS;
	}
	catch (TBCryptoException &ex) {
		return ex.error_code();
	}
}

int decrypt(char* hex_key, char* hex_iv,
			 char* cipher, unsigned int cipher_length,
			 char* plain, unsigned int* plain_length)
{
	try {
		std::string input(cipher, 0, cipher_length);
		std::string output = decrypt(hex_key, hex_iv, input);
		std::copy(output.begin(), output.end(), plain);
		*plain_length = output.length();
		return CRYPTO_SUCCESS;
	}
	catch (TBCryptoException &ex) {
		return ex.error_code();
	}
}

int hash(char* hex_salt,
		 char* plain, unsigned int plain_length,
		 char* cipher, unsigned int* cipher_length)
{
	try {
		std::string input(plain, 0, plain_length);
		std::string output = hash(hex_salt, input);
		std::copy(output.begin(), output.end(), cipher);
		*cipher_length = output.length();
		return CRYPTO_SUCCESS;
	}
	catch (TBCryptoException &ex) {
		return ex.error_code();
	}
}
