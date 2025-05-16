#include <stdio.h>
#include <string.h>
#include "../src/moran.h"

#define TEST_KEY    "06C3D00B2174DDD4EF1EFD6EF7C393AD259A0088ACFDC94E920BE1AB92CB8C82"
#define TEST_IV		"63386856796F6F757645335061586945"
#define TEST_SALT   "23567A5CC95DF78A832B15B4F9E5D2E1"


int main()
{
	// c
	printf("-- test with C -----------------------------------------------------------------\n");

	unsigned char hex_key[64+1] = { 0, }, hex_iv[32+1] = { 0, }, hex_salt[32+1] = { 0, };
	unsigned char plain[1024] = { 0, }, cipher[1024] = { 0, };
	unsigned int plain_length = 0, cipher_length = 0;

	strcpy((char*) hex_key, TEST_KEY);
	strcpy((char*) hex_iv, TEST_IV);
	strcpy((char*) hex_salt, TEST_SALT);

	strcpy((char*) plain, "1234");
	plain_length = (int) strlen((char*) plain);
	memset(cipher, 0x00, sizeof(cipher));
	encrypt((char*) hex_key, (char*) hex_iv, (char*) plain, plain_length, (char*) cipher, &cipher_length);
	printf("success: %s, %dbytes\n", cipher, cipher_length);

	strcpy((char*) cipher, "4RP470/Uyh1m0RV2ZkO4rA==");
	cipher_length = (int) strlen((char*)cipher);
	memset(plain, 0x00, sizeof(plain));
	decrypt((char*) hex_key, (char*) hex_iv, (char*) cipher, cipher_length, (char*) plain, &plain_length);
	printf("success: %s, %dbytes\n", plain, plain_length);

	strcpy((char*) plain, "2021");
	plain_length = (int) strlen((char*)plain);
	memset(cipher, 0x00, sizeof(cipher));
	hash((char*) hex_salt, (char*) plain, plain_length, (char*) cipher, &cipher_length);
	printf("success: %s, %dbytes\n", cipher, cipher_length);

	// exception
	strcpy((char*) cipher, "1234");
	cipher_length = (int) strlen((char*)cipher);
	memset(plain, 0x00, sizeof(plain));
	int error_code = decrypt((char*) hex_key, (char*) hex_iv, (char*) cipher, cipher_length, (char*) plain, &plain_length);
	if (error_code == CRYPTO_SUCCESS) {
		printf("success: %s, %dbytes\n", plain, plain_length);
	} else {
		printf("error_code: %d\n", error_code);
	}

    printf("\n");
    return 0;
}

