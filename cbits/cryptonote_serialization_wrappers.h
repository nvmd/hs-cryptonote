#ifndef _CRYPTONOTE_SERIALIZATION_WRAPPERS_H_
#define _CRYPTONOTE_SERIALIZATION_WRAPPERS_H_

#include <stddef.h>

typedef enum {OK, ERROR} serialization_result_type;

serialization_result_type cn_serialize_block_to_blob(void* block, const char* out, size_t* size);
serialization_result_type cn_serialize_tx_to_blob(void* tx, const char* out, size_t* size);

#endif
