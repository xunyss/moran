#include <iostream>
#include <botan/hex.h>
#include <botan/base64.h>
#include <botan/cipher_mode.h>
#include <botan/hash.h>

void test_aes256_cbc();
void test_sha256_salt();


void test_aes256_cbc()
{
	const std::string algorithm = "AES-256/CBC";
	const std::vector<uint8_t> key = Botan::hex_decode("259A0088ACFDC94E920BE1AB92CB8C8206C3D00B2174DDD4EF1EFD6EF7C393AD");
	const std::vector<uint8_t> iv = Botan::hex_decode("764533506158694563386856796F6F75");


	// encryption
	const std::string str_plain = "1234";
	Botan::secure_vector<uint8_t> enc_buffer = Botan::secure_vector<uint8_t>(str_plain.begin(), str_plain.end());

	std::unique_ptr<Botan::Cipher_Mode> enc = Botan::Cipher_Mode::create(algorithm, Botan::ENCRYPTION);
	enc->set_key(key);
	enc->start(iv);
	enc->finish(enc_buffer);

	std::string str_encrypted = Botan::base64_encode(enc_buffer);
	std::cout << ">> encryption: " << enc->name() << " "
			  << str_plain << " " << str_encrypted << std::endl;


	// decryption
	const std::string str_cipher = "bTVHTeQP+8i8fR8kJIjDrQ==";
	Botan::secure_vector<uint8_t> dec_buffer = Botan::base64_decode(str_cipher);

	std::unique_ptr<Botan::Cipher_Mode> dec = Botan::Cipher_Mode::create(algorithm, Botan::DECRYPTION);
	dec->set_key(key);
	dec->start(iv);
	dec->finish(dec_buffer); dec_buffer.shrink_to_fit();

	std::string str_decrypted = std::string(dec_buffer.begin(), dec_buffer.end());
	std::cout << ">> decryption: " << dec->name() << " "
			  << str_decrypted << " " << str_cipher << std::endl;
}

void test_sha256_salt()
{
	const std::string algorithm = "SHA-256";
	const std::string salt = "832B15B4F9E5D2E123567A5CC95DF78A";

	const std::string str_plain = "2021";
	const std::string str_expected = "CiO4jpxKfKvJC62BUcgxV0VwPbQf4gWu2X2Qvi70Vo4=";
	std::vector<uint8_t> message = Botan::hex_decode(salt);
	message.insert(std::end(message), str_plain.begin(), str_plain.end());

	std::unique_ptr<Botan::HashFunction> hash(Botan::HashFunction::create(algorithm));
	hash->update(message);

	std::string str_hashed = Botan::base64_encode(hash->final());
	std::cout << ">> hash: " << hash->name() << " "
			  << str_plain << " " << str_hashed << std::endl
			  << "             expected " << str_expected << std::endl;
}


int main() {
	std::cout << "-- test Botan build.. ----------------------------------------------------------" << std::endl;
	std::cout << ">> build version "
			  << BOTAN_VERSION_MAJOR << "." << BOTAN_VERSION_MINOR << "." << BOTAN_VERSION_PATCH << std::endl;

	test_aes256_cbc();
	test_sha256_salt();

	std::cout << "botan test success.." << std::endl << std::endl;
	return 0;
}

