Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4654 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726408AbfLIP37 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Dec 2019 10:29:59 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB9FSGk2110008
        for <linux-s390@vger.kernel.org>; Mon, 9 Dec 2019 10:29:56 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wrt116rne-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 09 Dec 2019 10:29:56 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <zaslonko@linux.ibm.com>;
        Mon, 9 Dec 2019 15:29:54 -0000
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Subject: [PATCH v2 1/6] lib/zlib: Add s390 hardware support for kernel zlib_deflate
Date: Mon,  9 Dec 2019 16:29:43 +0100
In-Reply-To: <20191209152948.37080-1-zaslonko@linux.ibm.com>
References: <20191209152948.37080-1-zaslonko@linux.ibm.com>
Message-Id: <20191209152948.37080-2-zaslonko@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eduard Shishkin <edward6@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, zaslonko@linux.ibm.com

Create zlib_dfltcc library with the s390 DEFLATE CONVERSION CALL
implementation and related compression functions.
Update zlib_deflate functions with the hooks for s390 hardware support
and adjust workspace structures with extra parameter lists required
for hardware deflate.

Co-developed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
---
 lib/Kconfig                      |  14 ++
 lib/Makefile                     |   1 +
 lib/zlib_deflate/deflate.c       |  79 ++++-----
 lib/zlib_deflate/deftree.c       |  54 ------
 lib/zlib_deflate/defutil.h       | 134 +++++++++++++--
 lib/zlib_dfltcc/Makefile         |  11 ++
 lib/zlib_dfltcc/dfltcc.c         |  52 ++++++
 lib/zlib_dfltcc/dfltcc.h         | 115 +++++++++++++
 lib/zlib_dfltcc/dfltcc_deflate.c | 274 +++++++++++++++++++++++++++++++
 lib/zlib_dfltcc/dfltcc_syms.c    |  17 ++
 lib/zlib_dfltcc/dfltcc_util.h    | 119 ++++++++++++++
 11 files changed, 768 insertions(+), 102 deletions(-)
 create mode 100644 lib/zlib_dfltcc/Makefile
 create mode 100644 lib/zlib_dfltcc/dfltcc.c
 create mode 100644 lib/zlib_dfltcc/dfltcc.h
 create mode 100644 lib/zlib_dfltcc/dfltcc_deflate.c
 create mode 100644 lib/zlib_dfltcc/dfltcc_syms.c
 create mode 100644 lib/zlib_dfltcc/dfltcc_util.h

diff --git a/lib/Kconfig b/lib/Kconfig
index 3321d04dfa5a..7ccaa54006c3 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -278,6 +278,20 @@ config ZLIB_DEFLATE
 	tristate
 	select BITREVERSE
 
+config ZLIB_DFLTCC
+	def_bool y
+	depends on S390
+	prompt "Enable s390x DEFLATE CONVERSION CALL support for zlib"
+	help
+	 Enable s390x hardware support for zlib in the kernel.
+
+config ZLIB_DFLTCC_DEFLATE
+	def_bool y
+	depends on ZLIB_DFLTCC && ZLIB_DEFLATE
+	prompt "Enable s390x hardware support for zlib deflate functions"
+	help
+	 Enable s390x hardware support for zlib deflate in the kernel.
+
 config LZO_COMPRESS
 	tristate
 
diff --git a/lib/Makefile b/lib/Makefile
index c5892807e06f..97aba321bb36 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -139,6 +139,7 @@ obj-$(CONFIG_842_COMPRESS) += 842/
 obj-$(CONFIG_842_DECOMPRESS) += 842/
 obj-$(CONFIG_ZLIB_INFLATE) += zlib_inflate/
 obj-$(CONFIG_ZLIB_DEFLATE) += zlib_deflate/
+obj-$(CONFIG_ZLIB_DFLTCC) += zlib_dfltcc/
 obj-$(CONFIG_REED_SOLOMON) += reed_solomon/
 obj-$(CONFIG_BCH) += bch.o
 obj-$(CONFIG_LZO_COMPRESS) += lzo/
diff --git a/lib/zlib_deflate/deflate.c b/lib/zlib_deflate/deflate.c
index d20ef458f137..9595b32b944a 100644
--- a/lib/zlib_deflate/deflate.c
+++ b/lib/zlib_deflate/deflate.c
@@ -52,16 +52,18 @@
 #include <linux/zutil.h>
 #include "defutil.h"
 
+/* architecture-specific bits */
+#ifdef CONFIG_ZLIB_DFLTCC_DEFLATE
+#  include "../zlib_dfltcc/dfltcc.h"
+#else
+#define DEFLATE_RESET_HOOK(strm) do {} while (0)
+#define DEFLATE_HOOK(strm, flush, bstate) 0
+#define DEFLATE_NEED_CHECKSUM(strm) 1
+#endif
 
 /* ===========================================================================
  *  Function prototypes.
  */
-typedef enum {
-    need_more,      /* block not completed, need more input or more output */
-    block_done,     /* block flush performed */
-    finish_started, /* finish started, need only more output at next deflate */
-    finish_done     /* finish done, accept no more input or output */
-} block_state;
 
 typedef block_state (*compress_func) (deflate_state *s, int flush);
 /* Compression function. Returns the block state after the call. */
@@ -72,7 +74,6 @@ static block_state deflate_fast   (deflate_state *s, int flush);
 static block_state deflate_slow   (deflate_state *s, int flush);
 static void lm_init        (deflate_state *s);
 static void putShortMSB    (deflate_state *s, uInt b);
-static void flush_pending  (z_streamp strm);
 static int read_buf        (z_streamp strm, Byte *buf, unsigned size);
 static uInt longest_match  (deflate_state *s, IPos cur_match);
 
@@ -98,6 +99,25 @@ static  void check_match (deflate_state *s, IPos start, IPos match,
  * See deflate.c for comments about the MIN_MATCH+1.
  */
 
+/* Workspace to be allocated for deflate processing */
+typedef struct deflate_workspace {
+    /* State memory for the deflator */
+    deflate_state deflate_memory;
+#ifdef CONFIG_ZLIB_DFLTCC_DEFLATE
+    /* State memory for s390 hardware deflate */
+    struct dfltcc_state dfltcc_memory;
+#endif
+    Byte *window_memory;
+    Pos *prev_memory;
+    Pos *head_memory;
+    char *overlay_memory;
+} deflate_workspace;
+
+#ifdef CONFIG_ZLIB_DFLTCC_DEFLATE
+/* dfltcc_state must be doubleword aligned for DFLTCC call */
+static_assert(offsetof(struct deflate_workspace, dfltcc_memory) % 8 == 0);
+#endif
+
 /* Values for max_lazy_match, good_match and max_chain_length, depending on
  * the desired pack level (0..9). The values given below have been tuned to
  * exclude worst case performance for pathological files. Better values may be
@@ -207,7 +227,15 @@ int zlib_deflateInit2(
      */
     next = (char *) mem;
     next += sizeof(*mem);
+#ifdef CONFIG_ZLIB_DFLTCC_DEFLATE
+    /*
+     *  DFLTCC requires the window to be page aligned.
+     *  Thus, we overallocate and take the aligned portion of the buffer.
+     */
+    mem->window_memory = (Byte *) PTR_ALIGN(next, PAGE_SIZE);
+#else
     mem->window_memory = (Byte *) next;
+#endif
     next += zlib_deflate_window_memsize(windowBits);
     mem->prev_memory = (Pos *) next;
     next += zlib_deflate_prev_memsize(windowBits);
@@ -277,6 +305,8 @@ int zlib_deflateReset(
     zlib_tr_init(s);
     lm_init(s);
 
+    DEFLATE_RESET_HOOK(strm);
+
     return Z_OK;
 }
 
@@ -294,35 +324,6 @@ static void putShortMSB(
     put_byte(s, (Byte)(b & 0xff));
 }   
 
-/* =========================================================================
- * Flush as much pending output as possible. All deflate() output goes
- * through this function so some applications may wish to modify it
- * to avoid allocating a large strm->next_out buffer and copying into it.
- * (See also read_buf()).
- */
-static void flush_pending(
-	z_streamp strm
-)
-{
-    deflate_state *s = (deflate_state *) strm->state;
-    unsigned len = s->pending;
-
-    if (len > strm->avail_out) len = strm->avail_out;
-    if (len == 0) return;
-
-    if (strm->next_out != NULL) {
-	memcpy(strm->next_out, s->pending_out, len);
-	strm->next_out += len;
-    }
-    s->pending_out += len;
-    strm->total_out += len;
-    strm->avail_out  -= len;
-    s->pending -= len;
-    if (s->pending == 0) {
-        s->pending_out = s->pending_buf;
-    }
-}
-
 /* ========================================================================= */
 int zlib_deflate(
 	z_streamp strm,
@@ -404,7 +405,8 @@ int zlib_deflate(
         (flush != Z_NO_FLUSH && s->status != FINISH_STATE)) {
         block_state bstate;
 
-	bstate = (*(configuration_table[s->level].func))(s, flush);
+	bstate = DEFLATE_HOOK(strm, flush, &bstate) ? bstate :
+		 (*(configuration_table[s->level].func))(s, flush);
 
         if (bstate == finish_started || bstate == finish_done) {
             s->status = FINISH_STATE;
@@ -503,7 +505,8 @@ static int read_buf(
 
     strm->avail_in  -= len;
 
-    if (!((deflate_state *)(strm->state))->noheader) {
+    if (!DEFLATE_NEED_CHECKSUM(strm)) {}
+    else if (!((deflate_state *)(strm->state))->noheader) {
         strm->adler = zlib_adler32(strm->adler, strm->next_in, len);
     }
     memcpy(buf, strm->next_in, len);
diff --git a/lib/zlib_deflate/deftree.c b/lib/zlib_deflate/deftree.c
index 9b1756b12743..a4a34da512fe 100644
--- a/lib/zlib_deflate/deftree.c
+++ b/lib/zlib_deflate/deftree.c
@@ -76,11 +76,6 @@ static const uch bl_order[BL_CODES]
  * probability, to avoid transmitting the lengths for unused bit length codes.
  */
 
-#define Buf_size (8 * 2*sizeof(char))
-/* Number of bits used within bi_buf. (bi_buf might be implemented on
- * more than 16 bits on some systems.)
- */
-
 /* ===========================================================================
  * Local data. These are initialized only once.
  */
@@ -147,7 +142,6 @@ static void send_all_trees (deflate_state *s, int lcodes, int dcodes,
 static void compress_block (deflate_state *s, ct_data *ltree,
                            ct_data *dtree);
 static void set_data_type  (deflate_state *s);
-static void bi_windup      (deflate_state *s);
 static void bi_flush       (deflate_state *s);
 static void copy_block     (deflate_state *s, char *buf, unsigned len,
                            int header);
@@ -169,54 +163,6 @@ static void copy_block     (deflate_state *s, char *buf, unsigned len,
  * used.
  */
 
-/* ===========================================================================
- * Send a value on a given number of bits.
- * IN assertion: length <= 16 and value fits in length bits.
- */
-#ifdef DEBUG_ZLIB
-static void send_bits      (deflate_state *s, int value, int length);
-
-static void send_bits(
-	deflate_state *s,
-	int value,  /* value to send */
-	int length  /* number of bits */
-)
-{
-    Tracevv((stderr," l %2d v %4x ", length, value));
-    Assert(length > 0 && length <= 15, "invalid length");
-    s->bits_sent += (ulg)length;
-
-    /* If not enough room in bi_buf, use (valid) bits from bi_buf and
-     * (16 - bi_valid) bits from value, leaving (width - (16-bi_valid))
-     * unused bits in value.
-     */
-    if (s->bi_valid > (int)Buf_size - length) {
-        s->bi_buf |= (value << s->bi_valid);
-        put_short(s, s->bi_buf);
-        s->bi_buf = (ush)value >> (Buf_size - s->bi_valid);
-        s->bi_valid += length - Buf_size;
-    } else {
-        s->bi_buf |= value << s->bi_valid;
-        s->bi_valid += length;
-    }
-}
-#else /* !DEBUG_ZLIB */
-
-#define send_bits(s, value, length) \
-{ int len = length;\
-  if (s->bi_valid > (int)Buf_size - len) {\
-    int val = value;\
-    s->bi_buf |= (val << s->bi_valid);\
-    put_short(s, s->bi_buf);\
-    s->bi_buf = (ush)val >> (Buf_size - s->bi_valid);\
-    s->bi_valid += len - Buf_size;\
-  } else {\
-    s->bi_buf |= (value) << s->bi_valid;\
-    s->bi_valid += len;\
-  }\
-}
-#endif /* DEBUG_ZLIB */
-
 /* ===========================================================================
  * Initialize the various 'constant' tables. In a multi-threaded environment,
  * this function may be called by two threads concurrently, but this is
diff --git a/lib/zlib_deflate/defutil.h b/lib/zlib_deflate/defutil.h
index a8c370897c9f..abf50099dfb0 100644
--- a/lib/zlib_deflate/defutil.h
+++ b/lib/zlib_deflate/defutil.h
@@ -1,5 +1,7 @@
+#ifndef DEFUTIL_H
+#define DEFUTIL_H
 
-
+#include <linux/zutil.h>
 
 #define Assert(err, str) 
 #define Trace(dummy) 
@@ -238,17 +240,13 @@ typedef struct deflate_state {
 
 } deflate_state;
 
-typedef struct deflate_workspace {
-    /* State memory for the deflator */
-    deflate_state deflate_memory;
-    Byte *window_memory;
-    Pos *prev_memory;
-    Pos *head_memory;
-    char *overlay_memory;
-} deflate_workspace;
-
+#ifdef CONFIG_ZLIB_DFLTCC_DEFLATE
+#define zlib_deflate_window_memsize(windowBits) \
+	(2 * (1 << (windowBits)) * sizeof(Byte) + PAGE_SIZE)
+#else
 #define zlib_deflate_window_memsize(windowBits) \
 	(2 * (1 << (windowBits)) * sizeof(Byte))
+#endif
 #define zlib_deflate_prev_memsize(windowBits) \
 	((1 << (windowBits)) * sizeof(Pos))
 #define zlib_deflate_head_memsize(memLevel) \
@@ -292,6 +290,24 @@ void zlib_tr_stored_type_only (deflate_state *);
     put_byte(s, (uch)((ush)(w) >> 8)); \
 }
 
+/* ===========================================================================
+ * Reverse the first len bits of a code, using straightforward code (a faster
+ * method would use a table)
+ * IN assertion: 1 <= len <= 15
+ */
+static inline unsigned  bi_reverse(
+    unsigned code, /* the value to invert */
+    int len        /* its bit length */
+)
+{
+    register unsigned res = 0;
+    do {
+        res |= code & 1;
+        code >>= 1, res <<= 1;
+    } while (--len > 0);
+    return res >> 1;
+}
+
 /* ===========================================================================
  * Flush the bit buffer, keeping at most 7 bits in it.
  */
@@ -325,3 +341,101 @@ static inline void bi_windup(deflate_state *s)
 #endif
 }
 
+typedef enum {
+    need_more,      /* block not completed, need more input or more output */
+    block_done,     /* block flush performed */
+    finish_started, /* finish started, need only more output at next deflate */
+    finish_done     /* finish done, accept no more input or output */
+} block_state;
+
+#define Buf_size (8 * 2*sizeof(char))
+/* Number of bits used within bi_buf. (bi_buf might be implemented on
+ * more than 16 bits on some systems.)
+ */
+
+/* ===========================================================================
+ * Send a value on a given number of bits.
+ * IN assertion: length <= 16 and value fits in length bits.
+ */
+#ifdef DEBUG_ZLIB
+static void send_bits      (deflate_state *s, int value, int length);
+
+static void send_bits(
+    deflate_state *s,
+    int value,  /* value to send */
+    int length  /* number of bits */
+)
+{
+    Tracevv((stderr," l %2d v %4x ", length, value));
+    Assert(length > 0 && length <= 15, "invalid length");
+    s->bits_sent += (ulg)length;
+
+    /* If not enough room in bi_buf, use (valid) bits from bi_buf and
+     * (16 - bi_valid) bits from value, leaving (width - (16-bi_valid))
+     * unused bits in value.
+     */
+    if (s->bi_valid > (int)Buf_size - length) {
+        s->bi_buf |= (value << s->bi_valid);
+        put_short(s, s->bi_buf);
+        s->bi_buf = (ush)value >> (Buf_size - s->bi_valid);
+        s->bi_valid += length - Buf_size;
+    } else {
+        s->bi_buf |= value << s->bi_valid;
+        s->bi_valid += length;
+    }
+}
+#else /* !DEBUG_ZLIB */
+
+#define send_bits(s, value, length) \
+{ int len = length;\
+  if (s->bi_valid > (int)Buf_size - len) {\
+    int val = value;\
+    s->bi_buf |= (val << s->bi_valid);\
+    put_short(s, s->bi_buf);\
+    s->bi_buf = (ush)val >> (Buf_size - s->bi_valid);\
+    s->bi_valid += len - Buf_size;\
+  } else {\
+    s->bi_buf |= (value) << s->bi_valid;\
+    s->bi_valid += len;\
+  }\
+}
+#endif /* DEBUG_ZLIB */
+
+static inline void zlib_tr_send_bits(
+    deflate_state *s,
+    int value,
+    int length
+)
+{
+    send_bits(s, value, length);
+}
+
+/* =========================================================================
+ * Flush as much pending output as possible. All deflate() output goes
+ * through this function so some applications may wish to modify it
+ * to avoid allocating a large strm->next_out buffer and copying into it.
+ * (See also read_buf()).
+ */
+static inline void flush_pending(
+	z_streamp strm
+)
+{
+    deflate_state *s = (deflate_state *) strm->state;
+    unsigned len = s->pending;
+
+    if (len > strm->avail_out) len = strm->avail_out;
+    if (len == 0) return;
+
+    if (strm->next_out != NULL) {
+	memcpy(strm->next_out, s->pending_out, len);
+	strm->next_out += len;
+    }
+    s->pending_out += len;
+    strm->total_out += len;
+    strm->avail_out  -= len;
+    s->pending -= len;
+    if (s->pending == 0) {
+        s->pending_out = s->pending_buf;
+    }
+}
+#endif /* DEFUTIL_H */
diff --git a/lib/zlib_dfltcc/Makefile b/lib/zlib_dfltcc/Makefile
new file mode 100644
index 000000000000..863d3b37e09d
--- /dev/null
+++ b/lib/zlib_dfltcc/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# This is a modified version of zlib, which does all memory
+# allocation ahead of time.
+#
+# This is the code for s390 zlib hardware support.
+#
+
+obj-$(CONFIG_ZLIB_DFLTCC) += zlib_dfltcc.o
+
+zlib_dfltcc-objs := dfltcc.o dfltcc_deflate.o dfltcc_syms.o
diff --git a/lib/zlib_dfltcc/dfltcc.c b/lib/zlib_dfltcc/dfltcc.c
new file mode 100644
index 000000000000..7f77e5bb01c6
--- /dev/null
+++ b/lib/zlib_dfltcc/dfltcc.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: Zlib
+/* dfltcc.c - SystemZ DEFLATE CONVERSION CALL support. */
+
+#include <linux/zutil.h>
+#include "dfltcc_util.h"
+#include "dfltcc.h"
+
+char *oesc_msg(
+    char *buf,
+    int oesc
+)
+{
+    if (oesc == 0x00)
+        return NULL; /* Successful completion */
+    else {
+#ifdef STATIC
+        return NULL; /* Ignore for pre-boot decompressor */
+#else
+        sprintf(buf, "Operation-Ending-Supplemental Code is 0x%.2X", oesc);
+        return buf;
+#endif
+    }
+}
+
+void dfltcc_reset(
+    z_streamp strm,
+    uInt size
+)
+{
+    struct dfltcc_state *dfltcc_state =
+        (struct dfltcc_state *)((char *)strm->state + size);
+    struct dfltcc_qaf_param *param =
+        (struct dfltcc_qaf_param *)&dfltcc_state->param;
+
+    /* Initialize available functions */
+    if (is_dfltcc_enabled()) {
+        dfltcc(DFLTCC_QAF, param, NULL, NULL, NULL, NULL, NULL);
+        memmove(&dfltcc_state->af, param, sizeof(dfltcc_state->af));
+    } else
+        memset(&dfltcc_state->af, 0, sizeof(dfltcc_state->af));
+
+    /* Initialize parameter block */
+    memset(&dfltcc_state->param, 0, sizeof(dfltcc_state->param));
+    dfltcc_state->param.nt = 1;
+
+    /* Initialize tuning parameters */
+    dfltcc_state->level_mask = DFLTCC_LEVEL_MASK;
+    dfltcc_state->block_size = DFLTCC_BLOCK_SIZE;
+    dfltcc_state->block_threshold = DFLTCC_FIRST_FHT_BLOCK_SIZE;
+    dfltcc_state->dht_threshold = DFLTCC_DHT_MIN_SAMPLE_SIZE;
+    dfltcc_state->param.ribm = DFLTCC_RIBM;
+}
diff --git a/lib/zlib_dfltcc/dfltcc.h b/lib/zlib_dfltcc/dfltcc.h
new file mode 100644
index 000000000000..18fed7a444bc
--- /dev/null
+++ b/lib/zlib_dfltcc/dfltcc.h
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: Zlib
+#ifndef DFLTCC_H
+#define DFLTCC_H
+
+#include "../zlib_deflate/defutil.h"
+
+/*
+ * Tuning parameters.
+ */
+#define DFLTCC_LEVEL_MASK 0x2 /* DFLTCC compression for level 1 only */
+#define DFLTCC_BLOCK_SIZE 1048576
+#define DFLTCC_FIRST_FHT_BLOCK_SIZE 4096
+#define DFLTCC_DHT_MIN_SAMPLE_SIZE 4096
+#define DFLTCC_RIBM 0
+
+/*
+ * Parameter Block for Query Available Functions.
+ */
+struct dfltcc_qaf_param {
+    char fns[16];
+    char reserved1[8];
+    char fmts[2];
+    char reserved2[6];
+};
+
+static_assert(sizeof(struct dfltcc_qaf_param) == 32);
+
+#define DFLTCC_FMT0 0
+
+/*
+ * Parameter Block for Generate Dynamic-Huffman Table, Compress and Expand.
+ */
+struct dfltcc_param_v0 {
+    uint16_t pbvn;                     /* Parameter-Block-Version Number */
+    uint8_t mvn;                       /* Model-Version Number */
+    uint8_t ribm;                      /* Reserved for IBM use */
+    unsigned reserved32 : 31;
+    unsigned cf : 1;                   /* Continuation Flag */
+    uint8_t reserved64[8];
+    unsigned nt : 1;                   /* New Task */
+    unsigned reserved129 : 1;
+    unsigned cvt : 1;                  /* Check Value Type */
+    unsigned reserved131 : 1;
+    unsigned htt : 1;                  /* Huffman-Table Type */
+    unsigned bcf : 1;                  /* Block-Continuation Flag */
+    unsigned bcc : 1;                  /* Block Closing Control */
+    unsigned bhf : 1;                  /* Block Header Final */
+    unsigned reserved136 : 1;
+    unsigned reserved137 : 1;
+    unsigned dhtgc : 1;                /* DHT Generation Control */
+    unsigned reserved139 : 5;
+    unsigned reserved144 : 5;
+    unsigned sbb : 3;                  /* Sub-Byte Boundary */
+    uint8_t oesc;                      /* Operation-Ending-Supplemental Code */
+    unsigned reserved160 : 12;
+    unsigned ifs : 4;                  /* Incomplete-Function Status */
+    uint16_t ifl;                      /* Incomplete-Function Length */
+    uint8_t reserved192[8];
+    uint8_t reserved256[8];
+    uint8_t reserved320[4];
+    uint16_t hl;                       /* History Length */
+    unsigned reserved368 : 1;
+    uint16_t ho : 15;                  /* History Offset */
+    uint32_t cv;                       /* Check Value */
+    unsigned eobs : 15;                /* End-of-block Symbol */
+    unsigned reserved431: 1;
+    uint8_t eobl : 4;                  /* End-of-block Length */
+    unsigned reserved436 : 12;
+    unsigned reserved448 : 4;
+    uint16_t cdhtl : 12;               /* Compressed-Dynamic-Huffman Table
+                                          Length */
+    uint8_t reserved464[6];
+    uint8_t cdht[288];
+    uint8_t reserved[32];
+    uint8_t csb[1152];
+};
+
+static_assert(sizeof(struct dfltcc_param_v0) == 1536);
+
+#define CVT_CRC32 0
+#define CVT_ADLER32 1
+#define HTT_FIXED 0
+#define HTT_DYNAMIC 1
+
+/*
+ *  Extension of inflate_state and deflate_state for DFLTCC.
+ */
+struct dfltcc_state {
+    struct dfltcc_param_v0 param;      /* Parameter block */
+    struct dfltcc_qaf_param af;        /* Available functions */
+    uLong level_mask;                  /* Levels on which to use DFLTCC */
+    uLong block_size;                  /* New block each X bytes */
+    uLong block_threshold;             /* New block after total_in > X */
+    uLong dht_threshold;               /* New block only if avail_in >= X */
+    char msg[64];                      /* Buffer for strm->msg */
+};
+
+/* Resides right after inflate_state or deflate_state */
+#define GET_DFLTCC_STATE(state) ((struct dfltcc_state *)((state) + 1))
+
+/* External functions */
+int dfltcc_can_deflate(z_streamp strm);
+int dfltcc_deflate(z_streamp strm,
+                   int flush,
+                   block_state *result);
+void dfltcc_reset(z_streamp strm, uInt size);
+
+#define DEFLATE_RESET_HOOK(strm) \
+    dfltcc_reset((strm), sizeof(deflate_state))
+
+#define DEFLATE_HOOK dfltcc_deflate
+
+#define DEFLATE_NEED_CHECKSUM(strm) (!dfltcc_can_deflate((strm)))
+
+#endif /* DFLTCC_H */
diff --git a/lib/zlib_dfltcc/dfltcc_deflate.c b/lib/zlib_dfltcc/dfltcc_deflate.c
new file mode 100644
index 000000000000..b9d16917c30a
--- /dev/null
+++ b/lib/zlib_dfltcc/dfltcc_deflate.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: Zlib
+
+#include "../zlib_deflate/defutil.h"
+#include "dfltcc_util.h"
+#include "dfltcc.h"
+#include <linux/zutil.h>
+
+/*
+ * Compress.
+ */
+int dfltcc_can_deflate(
+    z_streamp strm
+)
+{
+    deflate_state *state = (deflate_state *)strm->state;
+    struct dfltcc_state *dfltcc_state = GET_DFLTCC_STATE(state);
+
+    /* Unsupported compression settings */
+    if (!dfltcc_are_params_ok(state->level, state->w_bits, state->strategy,
+                              dfltcc_state->level_mask))
+        return 0;
+
+    /* Unsupported hardware */
+    if (!is_bit_set(dfltcc_state->af.fns, DFLTCC_GDHT) ||
+            !is_bit_set(dfltcc_state->af.fns, DFLTCC_CMPR) ||
+            !is_bit_set(dfltcc_state->af.fmts, DFLTCC_FMT0))
+        return 0;
+
+    return 1;
+}
+
+static void dfltcc_gdht(
+    z_streamp strm
+)
+{
+    deflate_state *state = (deflate_state *)strm->state;
+    struct dfltcc_param_v0 *param = &GET_DFLTCC_STATE(state)->param;
+    size_t avail_in = avail_in = strm->avail_in;
+
+    dfltcc(DFLTCC_GDHT,
+           param, NULL, NULL,
+           &strm->next_in, &avail_in, NULL);
+}
+
+static dfltcc_cc dfltcc_cmpr(
+    z_streamp strm
+)
+{
+    deflate_state *state = (deflate_state *)strm->state;
+    struct dfltcc_param_v0 *param = &GET_DFLTCC_STATE(state)->param;
+    size_t avail_in = strm->avail_in;
+    size_t avail_out = strm->avail_out;
+    dfltcc_cc cc;
+
+    cc = dfltcc(DFLTCC_CMPR | HBT_CIRCULAR,
+                param, &strm->next_out, &avail_out,
+                &strm->next_in, &avail_in, state->window);
+    strm->total_in += (strm->avail_in - avail_in);
+    strm->total_out += (strm->avail_out - avail_out);
+    strm->avail_in = avail_in;
+    strm->avail_out = avail_out;
+    return cc;
+}
+
+static void send_eobs(
+    z_streamp strm,
+    const struct dfltcc_param_v0 *param
+)
+{
+    deflate_state *state = (deflate_state *)strm->state;
+
+    zlib_tr_send_bits(
+          state,
+          bi_reverse(param->eobs >> (15 - param->eobl), param->eobl),
+          param->eobl);
+    flush_pending(strm);
+    if (state->pending != 0) {
+        /* The remaining data is located in pending_out[0:pending]. If someone
+         * calls put_byte() - this might happen in deflate() - the byte will be
+         * placed into pending_buf[pending], which is incorrect. Move the
+         * remaining data to the beginning of pending_buf so that put_byte() is
+         * usable again.
+         */
+        memmove(state->pending_buf, state->pending_out, state->pending);
+        state->pending_out = state->pending_buf;
+    }
+#ifdef ZLIB_DEBUG
+    state->compressed_len += param->eobl;
+#endif
+}
+
+int dfltcc_deflate(
+    z_streamp strm,
+    int flush,
+    block_state *result
+)
+{
+    deflate_state *state = (deflate_state *)strm->state;
+    struct dfltcc_state *dfltcc_state = GET_DFLTCC_STATE(state);
+    struct dfltcc_param_v0 *param = &dfltcc_state->param;
+    uInt masked_avail_in;
+    dfltcc_cc cc;
+    int need_empty_block;
+    int soft_bcc;
+    int no_flush;
+
+    if (!dfltcc_can_deflate(strm))
+        return 0;
+
+again:
+    masked_avail_in = 0;
+    soft_bcc = 0;
+    no_flush = flush == Z_NO_FLUSH;
+
+    /* Trailing empty block. Switch to software, except when Continuation Flag
+     * is set, which means that DFLTCC has buffered some output in the
+     * parameter block and needs to be called again in order to flush it.
+     */
+    if (flush == Z_FINISH && strm->avail_in == 0 && !param->cf) {
+        if (param->bcf) {
+            /* A block is still open, and the hardware does not support closing
+             * blocks without adding data. Thus, close it manually.
+             */
+            send_eobs(strm, param);
+            param->bcf = 0;
+        }
+        return 0;
+    }
+
+    if (strm->avail_in == 0 && !param->cf) {
+        *result = need_more;
+        return 1;
+    }
+
+    /* There is an open non-BFINAL block, we are not going to close it just
+     * yet, we have compressed more than DFLTCC_BLOCK_SIZE bytes and we see
+     * more than DFLTCC_DHT_MIN_SAMPLE_SIZE bytes. Open a new block with a new
+     * DHT in order to adapt to a possibly changed input data distribution.
+     */
+    if (param->bcf && no_flush &&
+            strm->total_in > dfltcc_state->block_threshold &&
+            strm->avail_in >= dfltcc_state->dht_threshold) {
+        if (param->cf) {
+            /* We need to flush the DFLTCC buffer before writing the
+             * End-of-block Symbol. Mask the input data and proceed as usual.
+             */
+            masked_avail_in += strm->avail_in;
+            strm->avail_in = 0;
+            no_flush = 0;
+        } else {
+            /* DFLTCC buffer is empty, so we can manually write the
+             * End-of-block Symbol right away.
+             */
+            send_eobs(strm, param);
+            param->bcf = 0;
+            dfltcc_state->block_threshold =
+                strm->total_in + dfltcc_state->block_size;
+            if (strm->avail_out == 0) {
+                *result = need_more;
+                return 1;
+            }
+        }
+    }
+
+    /* The caller gave us too much data. Pass only one block worth of
+     * uncompressed data to DFLTCC and mask the rest, so that on the next
+     * iteration we start a new block.
+     */
+    if (no_flush && strm->avail_in > dfltcc_state->block_size) {
+        masked_avail_in += (strm->avail_in - dfltcc_state->block_size);
+        strm->avail_in = dfltcc_state->block_size;
+    }
+
+    /* When we have an open non-BFINAL deflate block and caller indicates that
+     * the stream is ending, we need to close an open deflate block and open a
+     * BFINAL one.
+     */
+    need_empty_block = flush == Z_FINISH && param->bcf && !param->bhf;
+
+    /* Translate stream to parameter block */
+    param->cvt = CVT_ADLER32;
+    if (!no_flush)
+        /* We need to close a block. Always do this in software - when there is
+         * no input data, the hardware will not nohor BCC. */
+        soft_bcc = 1;
+    if (flush == Z_FINISH && !param->bcf)
+        /* We are about to open a BFINAL block, set Block Header Final bit
+         * until the stream ends.
+         */
+        param->bhf = 1;
+    /* DFLTCC-CMPR will write to next_out, so make sure that buffers with
+     * higher precedence are empty.
+     */
+    Assert(state->pending == 0, "There must be no pending bytes");
+    Assert(state->bi_valid < 8, "There must be less than 8 pending bits");
+    param->sbb = (unsigned int)state->bi_valid;
+    if (param->sbb > 0)
+        *strm->next_out = (Byte)state->bi_buf;
+    if (param->hl)
+        param->nt = 0; /* Honor history */
+    param->cv = strm->adler;
+
+    /* When opening a block, choose a Huffman-Table Type */
+    if (!param->bcf) {
+        if (strm->total_in == 0 && dfltcc_state->block_threshold > 0) {
+            param->htt = HTT_FIXED;
+        }
+        else {
+            param->htt = HTT_DYNAMIC;
+            dfltcc_gdht(strm);
+        }
+    }
+
+    /* Deflate */
+    do {
+        cc = dfltcc_cmpr(strm);
+        if (strm->avail_in < 4096 && masked_avail_in > 0)
+            /* We are about to call DFLTCC with a small input buffer, which is
+             * inefficient. Since there is masked data, there will be at least
+             * one more DFLTCC call, so skip the current one and make the next
+             * one handle more data.
+             */
+            break;
+    } while (cc == DFLTCC_CC_AGAIN);
+
+    /* Translate parameter block to stream */
+    strm->msg = oesc_msg(dfltcc_state->msg, param->oesc);
+    state->bi_valid = param->sbb;
+    if (state->bi_valid == 0)
+        state->bi_buf = 0; /* Avoid accessing next_out */
+    else
+        state->bi_buf = *strm->next_out & ((1 << state->bi_valid) - 1);
+    strm->adler = param->cv;
+
+    /* Unmask the input data */
+    strm->avail_in += masked_avail_in;
+    masked_avail_in = 0;
+
+    /* If we encounter an error, it means there is a bug in DFLTCC call */
+    Assert(cc != DFLTCC_CC_OP2_CORRUPT || param->oesc == 0, "BUG");
+
+    /* Update Block-Continuation Flag. It will be used to check whether to call
+     * GDHT the next time.
+     */
+    if (cc == DFLTCC_CC_OK) {
+        if (soft_bcc) {
+            send_eobs(strm, param);
+            param->bcf = 0;
+            dfltcc_state->block_threshold =
+                strm->total_in + dfltcc_state->block_size;
+        } else
+            param->bcf = 1;
+        if (flush == Z_FINISH) {
+            if (need_empty_block)
+                /* Make the current deflate() call also close the stream */
+                return 0;
+            else {
+                bi_windup(state);
+                *result = finish_done;
+            }
+        } else {
+            if (flush == Z_FULL_FLUSH)
+                param->hl = 0; /* Clear history */
+            *result = flush == Z_NO_FLUSH ? need_more : block_done;
+        }
+    } else {
+        param->bcf = 1;
+        *result = need_more;
+    }
+    if (strm->avail_in != 0 && strm->avail_out != 0)
+        goto again; /* deflate() must use all input or all output */
+    return 1;
+}
+
diff --git a/lib/zlib_dfltcc/dfltcc_syms.c b/lib/zlib_dfltcc/dfltcc_syms.c
new file mode 100644
index 000000000000..6f23481804c1
--- /dev/null
+++ b/lib/zlib_dfltcc/dfltcc_syms.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * linux/lib/zlib_dfltcc/dfltcc_syms.c
+ *
+ * Exported symbols for the s390 zlib dfltcc support.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/zlib.h>
+#include "dfltcc.h"
+
+EXPORT_SYMBOL(dfltcc_can_deflate);
+EXPORT_SYMBOL(dfltcc_deflate);
+EXPORT_SYMBOL(dfltcc_reset);
+MODULE_LICENSE("GPL");
diff --git a/lib/zlib_dfltcc/dfltcc_util.h b/lib/zlib_dfltcc/dfltcc_util.h
new file mode 100644
index 000000000000..1930b43c1915
--- /dev/null
+++ b/lib/zlib_dfltcc/dfltcc_util.h
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: Zlib
+#ifndef DFLTCC_UTIL_H
+#define DFLTCC_UTIL_H
+
+#include <linux/zutil.h>
+
+/*
+ * C wrapper for the DEFLATE CONVERSION CALL instruction.
+ */
+typedef enum {
+    DFLTCC_CC_OK = 0,
+    DFLTCC_CC_OP1_TOO_SHORT = 1,
+    DFLTCC_CC_OP2_TOO_SHORT = 2,
+    DFLTCC_CC_OP2_CORRUPT = 2,
+    DFLTCC_CC_AGAIN = 3,
+} dfltcc_cc;
+
+#define DFLTCC_QAF 0
+#define DFLTCC_GDHT 1
+#define DFLTCC_CMPR 2
+#define DFLTCC_XPND 4
+#define HBT_CIRCULAR (1 << 7)
+#define HB_BITS 15
+#define HB_SIZE (1 << HB_BITS)
+#define DFLTCC_FACILITY 151
+
+static inline dfltcc_cc dfltcc(
+    int fn,
+    void *param,
+    Byte **op1,
+    size_t *len1,
+    const Byte **op2,
+    size_t *len2,
+    void *hist
+)
+{
+    Byte *t2 = op1 ? *op1 : NULL;
+    size_t t3 = len1 ? *len1 : 0;
+    const Byte *t4 = op2 ? *op2 : NULL;
+    size_t t5 = len2 ? *len2 : 0;
+    register int r0 __asm__("r0") = fn;
+    register void *r1 __asm__("r1") = param;
+    register Byte *r2 __asm__("r2") = t2;
+    register size_t r3 __asm__("r3") = t3;
+    register const Byte *r4 __asm__("r4") = t4;
+    register size_t r5 __asm__("r5") = t5;
+    int cc;
+
+    __asm__ volatile(
+                     ".insn rrf,0xb9390000,%[r2],%[r4],%[hist],0\n"
+                     "ipm %[cc]\n"
+                     : [r2] "+r" (r2)
+                     , [r3] "+r" (r3)
+                     , [r4] "+r" (r4)
+                     , [r5] "+r" (r5)
+                     , [cc] "=r" (cc)
+                     : [r0] "r" (r0)
+                     , [r1] "r" (r1)
+                     , [hist] "r" (hist)
+                     : "cc", "memory");
+    t2 = r2; t3 = r3; t4 = r4; t5 = r5;
+
+    if (op1)
+        *op1 = t2;
+    if (len1)
+        *len1 = t3;
+    if (op2)
+        *op2 = t4;
+    if (len2)
+        *len2 = t5;
+    return (cc >> 28) & 3;
+}
+
+static inline int is_bit_set(
+    const char *bits,
+    int n
+)
+{
+    return bits[n / 8] & (1 << (7 - (n % 8)));
+}
+
+static inline void turn_bit_off(
+    char *bits,
+    int n
+)
+{
+    bits[n / 8] &= ~(1 << (7 - (n % 8)));
+}
+
+static inline int dfltcc_are_params_ok(
+    int level,
+    uInt window_bits,
+    int strategy,
+    uLong level_mask
+)
+{
+    return (level_mask & (1 << level)) != 0 &&
+        (window_bits == HB_BITS) &&
+        (strategy == Z_DEFAULT_STRATEGY);
+}
+
+static inline int is_dfltcc_enabled(void)
+{
+    uint64_t facilities[(DFLTCC_FACILITY / 64) + 1];
+    register char r0 __asm__("r0");
+
+    memset(facilities, 0, sizeof(facilities));
+    r0 = sizeof(facilities) / sizeof(facilities[0]) - 1;
+    __asm__ volatile("stfle %[facilities]\n"
+                     : [facilities] "=Q" (facilities)
+                     , [r0] "+r" (r0)
+                     :
+                     : "cc");
+    return is_bit_set((const char *)facilities, DFLTCC_FACILITY);
+}
+
+char *oesc_msg(char *buf, int oesc);
+
+#endif /* DFLTCC_UTIL_H */
-- 
2.17.1
