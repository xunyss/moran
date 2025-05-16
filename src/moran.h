
#ifdef __cplusplus
	#define _BEGIN_STD_C extern "C" {
	#define _END_STD_C }
#else
	#define _BEGIN_STD_C
	#define _END_STD_C
#endif

#ifdef _WIN32
	#ifdef MSVC_SHARED_LIB // cmake - target_compile_definitions
		#ifdef DLL_EXPORTING
			#define API_DECLSPEC __declspec(dllexport)
		#else
			#define API_DECLSPEC __declspec(dllimport)
		#endif
	#else
		#define API_DECLSPEC
	#endif
#else
	#define API_DECLSPEC
#endif


/* ============================================================================================== */
// common
/* ---------------------------------------------------------------------------------------------- */
#define CRYPTO_SUCCESS 0
/* ---------------------------------------------------------------------------------------------- */


/* ============================================================================================== */
// for C++
/* ---------------------------------------------------------------------------------------------- */
#ifdef __cplusplus

#include <iostream>

class MoranException: public std::exception
{
private:
	int m_code;
	std::string m_type, m_msg;
public:
	explicit MoranException(const int code, const std::string& type, const std::string& msg): m_code(code), m_type(type), m_msg(msg) {}
	~MoranException() throw() {};
	int error_code() const { return m_code; }
	const char* error_type() const { return m_type.c_str(); }
	const char* what() const throw() { return m_msg.c_str(); }
};

//API_DECLSPEC std::string encrypt(std::string plain);
//API_DECLSPEC std::string decrypt(std::string cipher);
//API_DECLSPEC std::string hash(std::string plain);
API_DECLSPEC std::string encrypt(std::string hex_key, std::string hex_iv, std::string plain);
API_DECLSPEC std::string decrypt(std::string hex_key, std::string hex_iv, std::string cipher);
API_DECLSPEC std::string hash(std::string hex_salt, std::string plain);

#endif
/* ---------------------------------------------------------------------------------------------- */


/* ============================================================================================== */
// for C
/* ---------------------------------------------------------------------------------------------- */
_BEGIN_STD_C

//API_DECLSPEC void encrypt(char* plain, unsigned int plain_length, char* cipher, unsigned int* cipher_length);
//API_DECLSPEC void decrypt(char* cipher, unsigned int cipher_length, char* plain, unsigned int* plain_length);
//API_DECLSPEC void hash(char* plain, unsigned int plain_length, char* cipher, unsigned int* cipher_length);
API_DECLSPEC int encrypt(char* hex_key, char* hex_iv,
						  char* plain, unsigned int plain_length,
						  char* cipher, unsigned int* cipher_length);
API_DECLSPEC int decrypt(char* hex_key, char* hex_iv,
						  char* cipher, unsigned int cipher_length,
						  char* plain, unsigned int* plain_length);
API_DECLSPEC int hash(char* hex_salt,
					   char* plain, unsigned int plain_length,
					   char* cipher, unsigned int* cipher_length);

_END_STD_C
/* ---------------------------------------------------------------------------------------------- */

