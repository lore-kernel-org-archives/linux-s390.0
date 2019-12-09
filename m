Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Subject: [PATCH v2 3/6] lib/zlib: Add s390 hardware support for kernel zlib_inflate
Date: Mon,  9 Dec 2019 16:29:45 +0100
In-Reply-To: <20191209152948.37080-1-zaslonko@linux.ibm.com>
References: <20191209152948.37080-1-zaslonko@linux.ibm.com>
Message-Id: <20191209152948.37080-4-zaslonko@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eduard Shishkin <edward6@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, zaslonko@linux.ibm.com

Add decompression functions to zlib_dfltcc library.
Update zlib_inflate functions with the hooks for s390 hardware support
and adjust workspace structures with extra parameter lists required
for hardware inflate decompression.

Co-developed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
---
 lib/Kconfig                      |   8 ++
 lib/decompress_inflate.c         |  13 +++
 lib/zlib_dfltcc/Makefile         |   2 +-
 lib/zlib_dfltcc/dfltcc.h         |  28 ++++++
 lib/zlib_dfltcc/dfltcc_inflate.c | 143 +++++++++++++++++++++++++++++++
 lib/zlib_inflate/inflate.c       |  32 +++++--
 lib/zlib_inflate/inflate.h       |   8 ++
 lib/zlib_inflate/infutil.h       |  18 +++-
 8 files changed, 241 insertions(+), 11 deletions(-)
 create mode 100644 lib/zlib_dfltcc/dfltcc_inflate.c

diff --git a/lib/Kconfig b/lib/Kconfig
index 7ccaa54006c3..a29264d6e98d 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -292,6 +292,14 @@ config ZLIB_DFLTCC_DEFLATE
 	help
 	 Enable s390x hardware support for zlib deflate in the kernel.
 
+config ZLIB_DFLTCC_INFLATE
+	def_bool y
+	depends on ZLIB_DFLTCC && ZLIB_INFLATE
+	prompt "Enable s390x hardware support for zlib inflate functions"
+	help
+	 Enable s390x hardware support for zlib inflate in the kernel.
+
+
 config LZO_COMPRESS
 	tristate
 
diff --git a/lib/decompress_inflate.c b/lib/decompress_inflate.c
index 63b4b7eee138..523651e23c06 100644
--- a/lib/decompress_inflate.c
+++ b/lib/decompress_inflate.c
@@ -10,6 +10,10 @@
 #include "zlib_inflate/inftrees.c"
 #include "zlib_inflate/inffast.c"
 #include "zlib_inflate/inflate.c"
+#ifdef CONFIG_ZLIB_DFLTCC_INFLATE
+#include "zlib_dfltcc/dfltcc.c"
+#include "zlib_dfltcc/dfltcc_inflate.c"
+#endif
 
 #else /* STATIC */
 /* initramfs et al: linked */
@@ -76,7 +80,12 @@ STATIC int INIT __gunzip(unsigned char *buf, long len,
 	}
 
 	strm->workspace = malloc(flush ? zlib_inflate_workspacesize() :
+#ifdef CONFIG_ZLIB_DFLTCC_INFLATE
+	/* Always allocate the full workspace for DFLTCC */
+				 zlib_inflate_workspacesize());
+#else
 				 sizeof(struct inflate_state));
+#endif
 	if (strm->workspace == NULL) {
 		error("Out of memory while allocating workspace");
 		goto gunzip_nomem4;
@@ -123,10 +132,14 @@ STATIC int INIT __gunzip(unsigned char *buf, long len,
 
 	rc = zlib_inflateInit2(strm, -MAX_WBITS);
 
+#ifdef CONFIG_ZLIB_DFLTCC_INFLATE
+	/* Always keep the window for DFLTCC */
+#else
 	if (!flush) {
 		WS(strm)->inflate_state.wsize = 0;
 		WS(strm)->inflate_state.window = NULL;
 	}
+#endif
 
 	while (rc == Z_OK) {
 		if (strm->avail_in == 0) {
diff --git a/lib/zlib_dfltcc/Makefile b/lib/zlib_dfltcc/Makefile
index 863d3b37e09d..8e4d5afbbb10 100644
--- a/lib/zlib_dfltcc/Makefile
+++ b/lib/zlib_dfltcc/Makefile
@@ -8,4 +8,4 @@
 
 obj-$(CONFIG_ZLIB_DFLTCC) += zlib_dfltcc.o
 
-zlib_dfltcc-objs := dfltcc.o dfltcc_deflate.o dfltcc_syms.o
+zlib_dfltcc-objs := dfltcc.o dfltcc_deflate.o dfltcc_inflate.o dfltcc_syms.o
diff --git a/lib/zlib_dfltcc/dfltcc.h b/lib/zlib_dfltcc/dfltcc.h
index 18fed7a444bc..4782c92bb2ff 100644
--- a/lib/zlib_dfltcc/dfltcc.h
+++ b/lib/zlib_dfltcc/dfltcc.h
@@ -104,6 +104,14 @@ int dfltcc_deflate(z_streamp strm,
                    int flush,
                    block_state *result);
 void dfltcc_reset(z_streamp strm, uInt size);
+int dfltcc_can_inflate(z_streamp strm);
+typedef enum {
+    DFLTCC_INFLATE_CONTINUE,
+    DFLTCC_INFLATE_BREAK,
+    DFLTCC_INFLATE_SOFTWARE,
+} dfltcc_inflate_action;
+dfltcc_inflate_action dfltcc_inflate(z_streamp strm,
+                                     int flush, int *ret);
 
 #define DEFLATE_RESET_HOOK(strm) \
     dfltcc_reset((strm), sizeof(deflate_state))
@@ -112,4 +120,24 @@ void dfltcc_reset(z_streamp strm, uInt size);
 
 #define DEFLATE_NEED_CHECKSUM(strm) (!dfltcc_can_deflate((strm)))
 
+#define INFLATE_RESET_HOOK(strm) \
+    dfltcc_reset((strm), sizeof(struct inflate_state))
+
+#define INFLATE_TYPEDO_HOOK(strm, flush) \
+    if (dfltcc_can_inflate((strm))) { \
+        dfltcc_inflate_action action; \
+\
+        RESTORE(); \
+        action = dfltcc_inflate((strm), (flush), &ret); \
+        LOAD(); \
+        if (action == DFLTCC_INFLATE_CONTINUE) \
+            break; \
+        else if (action == DFLTCC_INFLATE_BREAK) \
+            goto inf_leave; \
+    }
+
+#define INFLATE_NEED_CHECKSUM(strm) (!dfltcc_can_inflate((strm)))
+
+#define INFLATE_NEED_UPDATEWINDOW(strm) (!dfltcc_can_inflate((strm)))
+
 #endif /* DFLTCC_H */
diff --git a/lib/zlib_dfltcc/dfltcc_inflate.c b/lib/zlib_dfltcc/dfltcc_inflate.c
new file mode 100644
index 000000000000..12a93a06bd61
--- /dev/null
+++ b/lib/zlib_dfltcc/dfltcc_inflate.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: Zlib
+
+#include "../zlib_inflate/inflate.h"
+#include "dfltcc_util.h"
+#include "dfltcc.h"
+#include <linux/zutil.h>
+
+/*
+ * Expand.
+ */
+int dfltcc_can_inflate(
+    z_streamp strm
+)
+{
+    struct inflate_state *state = (struct inflate_state *)strm->state;
+    struct dfltcc_state *dfltcc_state = GET_DFLTCC_STATE(state);
+
+    /* Unsupported compression settings */
+    if (state->wbits != HB_BITS)
+        return 0;
+
+    /* Unsupported hardware */
+    return is_bit_set(dfltcc_state->af.fns, DFLTCC_XPND) &&
+               is_bit_set(dfltcc_state->af.fmts, DFLTCC_FMT0);
+}
+
+static int dfltcc_was_inflate_used(
+    z_streamp strm
+)
+{
+    struct inflate_state *state = (struct inflate_state *)strm->state;
+    struct dfltcc_param_v0 *param = &GET_DFLTCC_STATE(state)->param;
+
+    return !param->nt;
+}
+
+static int dfltcc_inflate_disable(
+    z_streamp strm
+)
+{
+    struct inflate_state *state = (struct inflate_state *)strm->state;
+    struct dfltcc_state *dfltcc_state = GET_DFLTCC_STATE(state);
+
+    if (!dfltcc_can_inflate(strm))
+        return 0;
+    if (dfltcc_was_inflate_used(strm))
+        /* DFLTCC has already decompressed some data. Since there is not
+         * enough information to resume decompression in software, the call
+         * must fail.
+         */
+        return 1;
+    /* DFLTCC was not used yet - decompress in software */
+    memset(&dfltcc_state->af, 0, sizeof(dfltcc_state->af));
+    return 0;
+}
+
+static dfltcc_cc dfltcc_xpnd(
+    z_streamp strm
+)
+{
+    struct inflate_state *state = (struct inflate_state *)strm->state;
+    struct dfltcc_param_v0 *param = &GET_DFLTCC_STATE(state)->param;
+    size_t avail_in = strm->avail_in;
+    size_t avail_out = strm->avail_out;
+    dfltcc_cc cc;
+
+    cc = dfltcc(DFLTCC_XPND | HBT_CIRCULAR,
+                param, &strm->next_out, &avail_out,
+                &strm->next_in, &avail_in, state->window);
+    strm->avail_in = avail_in;
+    strm->avail_out = avail_out;
+    return cc;
+}
+
+dfltcc_inflate_action dfltcc_inflate(
+    z_streamp strm,
+    int flush,
+    int *ret
+)
+{
+    struct inflate_state *state = (struct inflate_state *)strm->state;
+    struct dfltcc_state *dfltcc_state = GET_DFLTCC_STATE(state);
+    struct dfltcc_param_v0 *param = &dfltcc_state->param;
+    dfltcc_cc cc;
+
+    if (flush == Z_BLOCK) {
+        /* DFLTCC does not support stopping on block boundaries */
+        if (dfltcc_inflate_disable(strm)) {
+            *ret = Z_STREAM_ERROR;
+            return DFLTCC_INFLATE_BREAK;
+        } else
+            return DFLTCC_INFLATE_SOFTWARE;
+    }
+
+    if (state->last) {
+        if (state->bits != 0) {
+            strm->next_in++;
+            strm->avail_in--;
+            state->bits = 0;
+        }
+        state->mode = CHECK;
+        return DFLTCC_INFLATE_CONTINUE;
+    }
+
+    if (strm->avail_in == 0 && !param->cf)
+        return DFLTCC_INFLATE_BREAK;
+
+    if (!state->window || state->wsize == 0) {
+        state->mode = MEM;
+        return DFLTCC_INFLATE_CONTINUE;
+    }
+
+    /* Translate stream to parameter block */
+    param->cvt = CVT_ADLER32;
+    param->sbb = state->bits;
+    param->hl = state->whave; /* Software and hardware history formats match */
+    param->ho = (state->write - state->whave) & ((1 << HB_BITS) - 1);
+    if (param->hl)
+        param->nt = 0; /* Honor history for the first block */
+    param->cv = state->flags ? REVERSE(state->check) : state->check;
+
+    /* Inflate */
+    do {
+        cc = dfltcc_xpnd(strm);
+    } while (cc == DFLTCC_CC_AGAIN);
+
+    /* Translate parameter block to stream */
+    strm->msg = oesc_msg(dfltcc_state->msg, param->oesc);
+    state->last = cc == DFLTCC_CC_OK;
+    state->bits = param->sbb;
+    state->whave = param->hl;
+    state->write = (param->ho + param->hl) & ((1 << HB_BITS) - 1);
+    state->check = state->flags ? REVERSE(param->cv) : param->cv;
+    if (cc == DFLTCC_CC_OP2_CORRUPT && param->oesc != 0) {
+        /* Report an error if stream is corrupted */
+        state->mode = BAD;
+        return DFLTCC_INFLATE_CONTINUE;
+    }
+    state->mode = TYPEDO;
+    /* Break if operands are exhausted, otherwise continue looping */
+    return (cc == DFLTCC_CC_OP1_TOO_SHORT || cc == DFLTCC_CC_OP2_TOO_SHORT) ?
+        DFLTCC_INFLATE_BREAK : DFLTCC_INFLATE_CONTINUE;
+}
diff --git a/lib/zlib_inflate/inflate.c b/lib/zlib_inflate/inflate.c
index 48f14cd58c77..59de6c18f2fc 100644
--- a/lib/zlib_inflate/inflate.c
+++ b/lib/zlib_inflate/inflate.c
@@ -15,6 +15,16 @@
 #include "inffast.h"
 #include "infutil.h"
 
+/* architecture-specific bits */
+#ifdef CONFIG_ZLIB_DFLTCC_INFLATE
+#  include "../zlib_dfltcc/dfltcc.h"
+#else
+#define INFLATE_RESET_HOOK(strm) do {} while (0)
+#define INFLATE_TYPEDO_HOOK(strm, flush) do {} while (0)
+#define INFLATE_NEED_UPDATEWINDOW(strm) 1
+#define INFLATE_NEED_CHECKSUM(strm) 1
+#endif
+
 int zlib_inflate_workspacesize(void)
 {
     return sizeof(struct inflate_workspace);
@@ -42,6 +52,7 @@ int zlib_inflateReset(z_streamp strm)
     state->write = 0;
     state->whave = 0;
 
+    INFLATE_RESET_HOOK(strm);
     return Z_OK;
 }
 
@@ -66,7 +77,15 @@ int zlib_inflateInit2(z_streamp strm, int windowBits)
         return Z_STREAM_ERROR;
     }
     state->wbits = (unsigned)windowBits;
+#ifdef CONFIG_ZLIB_DFLTCC_INFLATE
+    /*
+     * DFLTCC requires the window to be page aligned.
+     * Thus, we overallocate and take the aligned portion of the buffer.
+     */
+    state->window = PTR_ALIGN(&WS(strm)->working_window[0], PAGE_SIZE);
+#else
     state->window = &WS(strm)->working_window[0];
+#endif
 
     return zlib_inflateReset(strm);
 }
@@ -227,11 +246,6 @@ static int zlib_inflateSyncPacket(z_streamp strm)
         bits -= bits & 7; \
     } while (0)
 
-/* Reverse the bytes in a 32-bit value */
-#define REVERSE(q) \
-    ((((q) >> 24) & 0xff) + (((q) >> 8) & 0xff00) + \
-     (((q) & 0xff00) << 8) + (((q) & 0xff) << 24))
-
 /*
    inflate() uses a state machine to process as much input data and generate as
    much output data as possible before returning.  The state machine is
@@ -395,6 +409,7 @@ int zlib_inflate(z_streamp strm, int flush)
             if (flush == Z_BLOCK) goto inf_leave;
 	    /* fall through */
         case TYPEDO:
+            INFLATE_TYPEDO_HOOK(strm, flush);
             if (state->last) {
                 BYTEBITS();
                 state->mode = CHECK;
@@ -692,7 +707,7 @@ int zlib_inflate(z_streamp strm, int flush)
                 out -= left;
                 strm->total_out += out;
                 state->total += out;
-                if (out)
+                if (INFLATE_NEED_CHECKSUM(strm) && out)
                     strm->adler = state->check =
                         UPDATE(state->check, put - out, out);
                 out = left;
@@ -726,7 +741,8 @@ int zlib_inflate(z_streamp strm, int flush)
      */
   inf_leave:
     RESTORE();
-    if (state->wsize || (state->mode < CHECK && out != strm->avail_out))
+    if (INFLATE_NEED_UPDATEWINDOW(strm) &&
+            (state->wsize || (state->mode < CHECK && out != strm->avail_out)))
         zlib_updatewindow(strm, out);
 
     in -= strm->avail_in;
@@ -734,7 +750,7 @@ int zlib_inflate(z_streamp strm, int flush)
     strm->total_in += in;
     strm->total_out += out;
     state->total += out;
-    if (state->wrap && out)
+    if (INFLATE_NEED_CHECKSUM(strm) && state->wrap && out)
         strm->adler = state->check =
             UPDATE(state->check, strm->next_out - out, out);
 
diff --git a/lib/zlib_inflate/inflate.h b/lib/zlib_inflate/inflate.h
index 3d17b3d1b21f..f79337ddf98c 100644
--- a/lib/zlib_inflate/inflate.h
+++ b/lib/zlib_inflate/inflate.h
@@ -11,6 +11,8 @@
    subject to change. Applications should only use zlib.h.
  */
 
+#include "inftrees.h"
+
 /* Possible inflate modes between inflate() calls */
 typedef enum {
     HEAD,       /* i: waiting for magic header */
@@ -108,4 +110,10 @@ struct inflate_state {
     unsigned short work[288];   /* work area for code table building */
     code codes[ENOUGH];         /* space for code tables */
 };
+
+/* Reverse the bytes in a 32-bit value */
+#define REVERSE(q) \
+    ((((q) >> 24) & 0xff) + (((q) >> 8) & 0xff00) + \
+     (((q) & 0xff00) << 8) + (((q) & 0xff) << 24))
+
 #endif
diff --git a/lib/zlib_inflate/infutil.h b/lib/zlib_inflate/infutil.h
index eb1a9007bd86..0264b15c9192 100644
--- a/lib/zlib_inflate/infutil.h
+++ b/lib/zlib_inflate/infutil.h
@@ -12,14 +12,28 @@
 #define _INFUTIL_H
 
 #include <linux/zlib.h>
+#ifdef CONFIG_ZLIB_DFLTCC_INFLATE
+#include "../zlib_dfltcc/dfltcc.h"
+#include <asm/page.h>
+#endif
 
 /* memory allocation for inflation */
 
 struct inflate_workspace {
 	struct inflate_state inflate_state;
-	unsigned char working_window[1 << MAX_WBITS];
+#ifdef CONFIG_ZLIB_DFLTCC_INFLATE
+	struct dfltcc_state dfltcc_state;
+	unsigned char working_window[(1 << MAX_WBITS) + PAGE_SIZE];
+#else
+	unsigned char working_window[(1 << MAX_WBITS)];
+#endif
 };
 
-#define WS(z) ((struct inflate_workspace *)(z->workspace))
+#ifdef CONFIG_ZLIB_DFLTCC_INFLATE
+/* dfltcc_state must be doubleword aligned for DFLTCC call */
+static_assert(offsetof(struct inflate_workspace, dfltcc_state) % 8 == 0);
+#endif
+
+#define WS(strm) ((struct inflate_workspace *)(strm->workspace))
 
 #endif
-- 
2.17.1
