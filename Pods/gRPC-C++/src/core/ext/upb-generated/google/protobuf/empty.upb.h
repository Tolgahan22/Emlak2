/* This file was generated by upbc (the upb compiler) from the input
 * file:
 *
 *     google/protobuf/empty.proto
 *
 * Do not edit -- your changes will be discarded when the file is
 * regenerated. */

#ifndef GOOGLE_PROTOBUF_EMPTY_PROTO_UPB_H_
#define GOOGLE_PROTOBUF_EMPTY_PROTO_UPB_H_

#include "upb/msg_internal.h"
#include "upb/decode.h"
#include "upb/decode_fast.h"
#include "upb/encode.h"

#include "upb/port_def.inc"

#ifdef __cplusplus
extern "C" {
#endif

struct google_protobuf_Empty;
typedef struct google_protobuf_Empty google_protobuf_Empty;
extern const upb_msglayout google_protobuf_Empty_msginit;


/* google.protobuf.Empty */

UPB_INLINE google_protobuf_Empty *google_protobuf_Empty_new(upb_arena *arena) {
  return (google_protobuf_Empty *)_upb_msg_new(&google_protobuf_Empty_msginit, arena);
}
UPB_INLINE google_protobuf_Empty *google_protobuf_Empty_parse(const char *buf, size_t size,
                        upb_arena *arena) {
  google_protobuf_Empty *ret = google_protobuf_Empty_new(arena);
  if (!ret) return NULL;
  if (!upb_decode(buf, size, ret, &google_protobuf_Empty_msginit, arena)) return NULL;
  return ret;
}
UPB_INLINE google_protobuf_Empty *google_protobuf_Empty_parse_ex(const char *buf, size_t size,
                           const upb_extreg *extreg, int options,
                           upb_arena *arena) {
  google_protobuf_Empty *ret = google_protobuf_Empty_new(arena);
  if (!ret) return NULL;
  if (!_upb_decode(buf, size, ret, &google_protobuf_Empty_msginit, extreg, options, arena)) {
    return NULL;
  }
  return ret;
}
UPB_INLINE char *google_protobuf_Empty_serialize(const google_protobuf_Empty *msg, upb_arena *arena, size_t *len) {
  return upb_encode(msg, &google_protobuf_Empty_msginit, arena, len);
}



extern const upb_msglayout_file google_protobuf_empty_proto_upb_file_layout;

#ifdef __cplusplus
}  /* extern "C" */
#endif

#include "upb/port_undef.inc"

#endif  /* GOOGLE_PROTOBUF_EMPTY_PROTO_UPB_H_ */
