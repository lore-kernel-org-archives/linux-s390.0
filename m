From: Adam Borowski <kilobyte@angband.pl>
Date: Fri,  9 Nov 2018 20:02:48 +0100
Message-Id: <20181109190304.8573-1-kilobyte@angband.pl>
In-Reply-To: <20181109185953.xwyelyqnygbskkxk@angband.pl>
References: <20181109185953.xwyelyqnygbskkxk@angband.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [PATCH 01/17] lib: Add support for ZSTD-compressed kernel
Return-Path: <kilobyte@angband.pl>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
To: linux-kernel@vger.kernel.org, Nick Terrell <terrelln@fb.com>, Russell King <linux@armlinux.org.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org
List-ID: <linux-s390.vger.kernel.org>

From: Nick Terrell <terrelln@fb.com>

Add support for extracting ZSTD-compressed kernel images, as well as
ZSTD-compressed ramdisk images in the kernel boot process.

When neither `fill' nor `flush' are used, the decompression function
requires a constant amount of memory (192 KB is sufficient). When either
is used the decompression function requires memory proportional to the
window size used during compression, which is limited to 8 MB. The maximum
memory usage is just over 8 MB.

Fix up lib/zstd and lib/xxhash.c for the preboot environment. They avoid
declaring themselves as modules. A memcpy() call needs to be a
__builtin_memcpy() for performance. The gcc-7.1 bug in ZSTD_wildcopy() was
fixed in gcc-7.2, so it can be gated, since it hurts performance.

Signed-off-by: Nick Terrell <terrelln@fb.com>
---
 include/linux/decompress/unzstd.h |  26 +++
 init/Kconfig                      |  14 +-
 lib/Kconfig                       |   4 +
 lib/Makefile                      |   1 +
 lib/decompress.c                  |   5 +
 lib/decompress_unzstd.c           | 341 ++++++++++++++++++++++++++++++
 lib/xxhash.c                      |  21 +-
 lib/zstd/decompress.c             |   2 +
 lib/zstd/fse_decompress.c         |   9 +-
 lib/zstd/zstd_internal.h          |  10 +-
 scripts/Makefile.lib              |  15 ++
 usr/Kconfig                       |  22 ++
 12 files changed, 451 insertions(+), 19 deletions(-)
 create mode 100644 include/linux/decompress/unzstd.h
 create mode 100644 lib/decompress_unzstd.c

diff --git a/include/linux/decompress/unzstd.h b/include/linux/decompress/unzstd.h
new file mode 100644
index 000000000000..6f3022cd0955
--- /dev/null
+++ b/include/linux/decompress/unzstd.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (C) 2017 Facebook
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public
+ * License v2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ */
+
+#ifndef LINUX_DECOMPRESS_UNZSTD_H
+#define LINUX_DECOMPRESS_UNZSTD_H
+
+int unzstd(unsigned char *inbuf, long len,
+	   long (*fill)(void*, unsigned long),
+	   long (*flush)(void*, unsigned long),
+	   unsigned char *output,
+	   long *pos,
+	   void (*error_fn)(char *x));
+#endif
diff --git a/init/Kconfig b/init/Kconfig
index a4112e95724a..ffa5ae4abc88 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -134,13 +134,16 @@ config HAVE_KERNEL_LZO
 config HAVE_KERNEL_LZ4
 	bool
 
+config HAVE_KERNEL_ZSTD
+	bool
+
 config HAVE_KERNEL_UNCOMPRESSED
 	bool
 
 choice
 	prompt "Kernel compression mode"
 	default KERNEL_GZIP
-	depends on HAVE_KERNEL_GZIP || HAVE_KERNEL_BZIP2 || HAVE_KERNEL_LZMA || HAVE_KERNEL_XZ || HAVE_KERNEL_LZO || HAVE_KERNEL_LZ4 || HAVE_KERNEL_UNCOMPRESSED
+	depends on HAVE_KERNEL_GZIP || HAVE_KERNEL_BZIP2 || HAVE_KERNEL_LZMA || HAVE_KERNEL_XZ || HAVE_KERNEL_LZO || HAVE_KERNEL_LZ4 || HAVE_KERNEL_ZSTD || HAVE_KERNEL_UNCOMPRESSED
 	help
 	  The linux kernel is a kind of self-extracting executable.
 	  Several compression algorithms are available, which differ
@@ -219,6 +222,15 @@ config KERNEL_LZ4
 	  is about 8% bigger than LZO. But the decompression speed is
 	  faster than LZO.
 
+config KERNEL_ZSTD
+	bool "ZSTD"
+	depends on HAVE_KERNEL_ZSTD
+	help
+	  ZSTD is a compression algorithm targeting intermediate compression
+	  with fast decompression speed. It will compress better than GZIP and
+	  decompress around the same speed as LZO, but slower than LZ4. You
+	  will need at least 192 KB RAM or more for booting.
+
 config KERNEL_UNCOMPRESSED
 	bool "None"
 	depends on HAVE_KERNEL_UNCOMPRESSED
diff --git a/lib/Kconfig b/lib/Kconfig
index a9965f4af4dd..e7ab43fd5461 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -304,6 +304,10 @@ config DECOMPRESS_LZ4
 	select LZ4_DECOMPRESS
 	tristate
 
+config DECOMPRESS_ZSTD
+	select ZSTD_DECOMPRESS
+	tristate
+
 #
 # Generic allocator support is selected if needed
 #
diff --git a/lib/Makefile b/lib/Makefile
index db06d1237898..58b48993f48a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -139,6 +139,7 @@ lib-$(CONFIG_DECOMPRESS_LZMA) += decompress_unlzma.o
 lib-$(CONFIG_DECOMPRESS_XZ) += decompress_unxz.o
 lib-$(CONFIG_DECOMPRESS_LZO) += decompress_unlzo.o
 lib-$(CONFIG_DECOMPRESS_LZ4) += decompress_unlz4.o
+lib-$(CONFIG_DECOMPRESS_ZSTD) += decompress_unzstd.o
 
 obj-$(CONFIG_TEXTSEARCH) += textsearch.o
 obj-$(CONFIG_TEXTSEARCH_KMP) += ts_kmp.o
diff --git a/lib/decompress.c b/lib/decompress.c
index 857ab1af1ef3..ab3fc90ffc64 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -13,6 +13,7 @@
 #include <linux/decompress/inflate.h>
 #include <linux/decompress/unlzo.h>
 #include <linux/decompress/unlz4.h>
+#include <linux/decompress/unzstd.h>
 
 #include <linux/types.h>
 #include <linux/string.h>
@@ -37,6 +38,9 @@
 #ifndef CONFIG_DECOMPRESS_LZ4
 # define unlz4 NULL
 #endif
+#ifndef CONFIG_DECOMPRESS_ZSTD
+# define unzstd NULL
+#endif
 
 struct compress_format {
 	unsigned char magic[2];
@@ -52,6 +56,7 @@ static const struct compress_format compressed_formats[] __initconst = {
 	{ {0xfd, 0x37}, "xz", unxz },
 	{ {0x89, 0x4c}, "lzo", unlzo },
 	{ {0x02, 0x21}, "lz4", unlz4 },
+	{ {0x28, 0xb5}, "zstd", unzstd },
 	{ {0, 0}, NULL, NULL }
 };
 
diff --git a/lib/decompress_unzstd.c b/lib/decompress_unzstd.c
new file mode 100644
index 000000000000..84315dc9bf24
--- /dev/null
+++ b/lib/decompress_unzstd.c
@@ -0,0 +1,341 @@
+/*
+ * Copyright (C) 2017 Facebook
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public
+ * License v2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Important notes about in-place decompression
+ *
+ * At least on x86, the kernel is decompressed in place: the compressed data
+ * is placed to the end of the output buffer, and the decompressor overwrites
+ * most of the compressed data. There must be enough safety margin to
+ * guarantee that the write position is always behind the read position.
+ *
+ * The safety margin for ZSTD with a 128 KB block size is calculated below.
+ * Note that the margin with ZSTD is bigger than with GZIP or XZ!
+ *
+ * The worst case for in-place decompression is that the beginning of
+ * the file is compressed extremely well, and the rest of the file is
+ * uncompressible. Thus, we must look for worst-case expansion when the
+ * compressor is encoding uncompressible data.
+ *
+ * The structure of the .zst file in case of a compresed kernel is as follows.
+ * Maximum sizes (as bytes) of the fields are in parenthesis.
+ *
+ *    Frame Header: (18)
+ *    Blocks: (N)
+ *    Checksum: (4)
+ *
+ * The frame header and checksum overhead is at most 22 bytes.
+ *
+ * ZSTD stores the data in blocks. Each block has a header whose size is
+ * a 3 bytes. After the block header, there is up to 128 KB of payload.
+ * The maximum uncompressed size of the payload is 128 KB. The minimum
+ * uncompressed size of the payload is never less than the payload size
+ * (excluding the block header).
+ *
+ * The assumption, that the uncompressed size of the payload is never
+ * smaller than the payload itself, is valid only when talking about
+ * the payload as a whole. It is possible that the payload has parts where
+ * the decompressor consumes more input than it produces output. Calculating
+ * the worst case for this would be tricky. Instead of trying to do that,
+ * let's simply make sure that the decompressor never overwrites any bytes
+ * of the payload which it is currently reading.
+ *
+ * Now we have enough information to calculate the safety margin. We need
+ *   - 22 bytes for the .zst file format headers;
+ *   - 3 bytes per every 128 KiB of uncompressed size (one block header per
+ *     block); and
+ *   - 128 KiB (biggest possible zstd block size) to make sure that the
+ *     decompressor never overwrites anything from the block it is currently
+ *     reading.
+ *
+ * We get the following formula:
+ *
+ *    safety_margin = 22 + uncompressed_size * 3 / 131072 + 131072
+ *                 <= 22 + (uncompressed_size >> 15) + 131072
+ */
+
+#ifdef STATIC
+	/* Preboot environments #include "path/to/decompress_unzstd.c".
+	 * All of the source files we depend on must be #included.
+	 * zstd's only source dependeny is xxhash, which has no source
+	 * dependencies.
+	 *
+	 * zstd and xxhash both avoid declaring themselves as modules
+	 * when PREBOOT is defined.
+	 */
+#	define PREBOOT
+#	include "xxhash.c"
+#	include "zstd/entropy_common.c"
+#	include "zstd/fse_decompress.c"
+#	include "zstd/huf_decompress.c"
+#	include "zstd/zstd_common.c"
+#	include "zstd/decompress.c"
+#endif
+
+#include <linux/decompress/mm.h>
+#include <linux/kernel.h>
+#include <linux/zstd.h>
+
+/* 8 MB maximum window size */
+#define ZSTD_WINDOWSIZE_MAX	(1 << 23)
+/* Size of the input and output buffers in multi-call mdoe */
+#define ZSTD_IOBUF_SIZE		4096
+
+static int INIT handle_zstd_error(size_t ret, void (*error)(char *x))
+{
+	const int err = ZSTD_getErrorCode(ret);
+
+	if (!ZSTD_isError(ret))
+		return 0;
+
+	switch (err) {
+	case ZSTD_error_memory_allocation:
+		error("ZSTD decompressor ran out of memory");
+		break;
+	case ZSTD_error_prefix_unknown:
+		error("Input is not in the ZSTD format (wrong magic bytes)");
+		break;
+	case ZSTD_error_dstSize_tooSmall:
+	case ZSTD_error_corruption_detected:
+	case ZSTD_error_checksum_wrong:
+		error("ZSTD-compressed data is corrupt");
+		break;
+	default:
+		error("ZSTD-compressed data is probably corrupt");
+		break;
+	}
+	return -1;
+}
+
+/* Handle the case where we have the entire input and output in one segment.
+ * We can allocate less memory (no circular buffer for the sliding window),
+ * and avoid some memcpy() calls.
+ */
+static int INIT decompress_single(const u8 *in_buf, long in_len, u8 *out_buf,
+				  long out_len, long *in_pos,
+				  void (*error)(char *x))
+{
+	const size_t wksp_size = ZSTD_DCtxWorkspaceBound();
+	void *wksp = large_malloc(wksp_size);
+	ZSTD_DCtx *dctx = ZSTD_initDCtx(wksp, wksp_size);
+	int err;
+	size_t ret;
+
+	if (dctx == NULL) {
+		error("Out of memory while allocating ZSTD_DCtx");
+		err = -1;
+		goto out;
+	}
+	/* Find out how large the frame actually is, there may be junk at
+	 * the end of the frame that ZSTD_decompressDCtx() can't handle.
+	 */
+	ret = ZSTD_findFrameCompressedSize(in_buf, in_len);
+	err = handle_zstd_error(ret, error);
+	if (err)
+		goto out;
+	in_len = (long)ret;
+
+	ret = ZSTD_decompressDCtx(dctx, out_buf, out_len, in_buf, in_len);
+	err = handle_zstd_error(ret, error);
+	if (err)
+		goto out;
+
+	if (in_pos != NULL)
+		*in_pos = in_len;
+
+	err = 0;
+out:
+	if (wksp != NULL)
+		large_free(wksp);
+	return err;
+}
+
+static int INIT __unzstd(unsigned char *in_buf, long in_len,
+			 long (*fill)(void*, unsigned long),
+			 long (*flush)(void*, unsigned long),
+			 unsigned char *out_buf, long out_len,
+			 long *in_pos,
+			 void (*error)(char *x))
+{
+	ZSTD_inBuffer in;
+	ZSTD_outBuffer out;
+	ZSTD_frameParams params;
+	void *in_allocated = NULL;
+	void *out_allocated = NULL;
+	void *wksp = NULL;
+	size_t wksp_size;
+	ZSTD_DStream *dstream;
+	int err;
+	size_t ret;
+
+	if (out_len == 0)
+		out_len = LONG_MAX; /* no limit */
+
+	if (fill == NULL && flush == NULL)
+		/* We can decompress faster and with less memory when we have a
+		 * single chunk.
+		 */
+		return decompress_single(in_buf, in_len, out_buf, out_len,
+					 in_pos, error);
+
+	/* If in_buf is not provided, we must be using fill(), so allocate
+	 * a large enough buffer. If it is provided, it must be at least
+	 * ZSTD_IOBUF_SIZE large.
+	 */
+	if (in_buf == NULL) {
+		in_allocated = malloc(ZSTD_IOBUF_SIZE);
+		if (in_allocated == NULL) {
+			error("Out of memory while allocating input buffer");
+			err = -1;
+			goto out;
+		}
+		in_buf = in_allocated;
+		in_len = 0;
+	}
+	/* Read the first chunk, since we need to decode the frame header */
+	if (fill != NULL)
+		in_len = fill(in_buf, ZSTD_IOBUF_SIZE);
+	if (in_len < 0) {
+		error("ZSTD-compressed data is truncated");
+		err = -1;
+		goto out;
+	}
+	/* Set the first non-empty input buffer */
+	in.src = in_buf;
+	in.pos = 0;
+	in.size = in_len;
+	/* Allocate the output buffer if we are using flush(). */
+	if (flush != NULL) {
+		out_allocated = malloc(ZSTD_IOBUF_SIZE);
+		if (out_allocated == NULL) {
+			error("Out of memory while allocating output buffer");
+			err = -1;
+			goto out;
+		}
+		out_buf = out_allocated;
+		out_len = ZSTD_IOBUF_SIZE;
+	}
+	/* Set the output buffer */
+	out.dst = out_buf;
+	out.pos = 0;
+	out.size = out_len;
+
+	/* We need to know the window size to allocate the ZSTD_DStream.
+	 * Since we are streaming, we need to allocate a buffer for the sliding
+	 * window. The window size varies from 1 KB to ZSTD_WINDOWSIZE_MAX
+	 * (8 MB), so it is important to use the actual value so as not to
+	 * waste memory when it is smaller.
+	 */
+	ret = ZSTD_getFrameParams(&params, in.src, in.size);
+	err = handle_zstd_error(ret, error);
+	if (err)
+		goto out;
+	if (ret != 0) {
+		error("ZSTD-compressed data has an incomplete frame header");
+		err = -1;
+		goto out;
+	}
+	if (params.windowSize > ZSTD_WINDOWSIZE_MAX) {
+		error("ZSTD-compressed data has too large a window size");
+		err = -1;
+		goto out;
+	}
+
+	/* Allocate the ZSTD_DStream now that we know how much memory is
+	 * required.
+	 */
+	wksp_size = ZSTD_DStreamWorkspaceBound(params.windowSize);
+	wksp = large_malloc(wksp_size);
+	dstream = ZSTD_initDStream(params.windowSize, wksp, wksp_size);
+	if (dstream == NULL) {
+		error("Out of memory while allocating ZSTD_DStream");
+		err = -1;
+		goto out;
+	}
+	/* Decompression loop:
+	 * Read more data if necessary (error if no more data can be read).
+	 * Call the decompression function, which returns 0 when finished.
+	 * Flush any data produced if using flush().
+	 */
+	if (in_pos != NULL)
+		*in_pos = 0;
+	do {
+		/* If we need to reload data, either we have fill() and can
+		 * try to get more data, or we don't and the input is truncated.
+		 */
+		if (in.pos == in.size) {
+			if (in_pos != NULL)
+				*in_pos += in.pos;
+			in_len = fill ? fill(in_buf, ZSTD_IOBUF_SIZE) : -1;
+			if (in_len < 0) {
+				error("ZSTD-compressed data is truncated");
+				err = -1;
+				goto out;
+			}
+			in.pos = 0;
+			in.size = in_len;
+		}
+		/* Returns zero when the frame is complete */
+		ret = ZSTD_decompressStream(dstream, &out, &in);
+		err = handle_zstd_error(ret, error);
+		if (err)
+			goto out;
+		/* Flush all of the data produced if using flush() */
+		if (flush != NULL && out.pos > 0) {
+			if (out.pos != flush(out.dst, out.pos)) {
+				error("Failed to flush()");
+				err = -1;
+				goto out;
+			}
+			out.pos = 0;
+		}
+	} while (ret != 0);
+
+	if (in_pos != NULL)
+		*in_pos += in.pos;
+
+	err = 0;
+out:
+	if (in_allocated != NULL)
+		free(in_allocated);
+	if (out_allocated != NULL)
+		free(out_allocated);
+	if (wksp != NULL)
+		large_free(wksp);
+	return err;
+}
+
+#ifndef PREBOOT
+STATIC int INIT unzstd(unsigned char *buf, long len,
+		       long (*fill)(void*, unsigned long),
+		       long (*flush)(void*, unsigned long),
+		       unsigned char *out_buf,
+		       long *pos,
+		       void (*error)(char *x))
+{
+	return __unzstd(buf, len, fill, flush, out_buf, 0, pos, error);
+}
+#else
+STATIC int INIT __decompress(unsigned char *buf, long len,
+			     long (*fill)(void*, unsigned long),
+			     long (*flush)(void*, unsigned long),
+			     unsigned char *out_buf, long out_len,
+			     long *pos,
+			     void (*error)(char *x))
+{
+	return __unzstd(buf, len, fill, flush, out_buf, out_len, pos, error);
+}
+#endif
diff --git a/lib/xxhash.c b/lib/xxhash.c
index aa61e2a3802f..7f1d3cb01729 100644
--- a/lib/xxhash.c
+++ b/lib/xxhash.c
@@ -80,13 +80,11 @@ void xxh32_copy_state(struct xxh32_state *dst, const struct xxh32_state *src)
 {
 	memcpy(dst, src, sizeof(*dst));
 }
-EXPORT_SYMBOL(xxh32_copy_state);
 
 void xxh64_copy_state(struct xxh64_state *dst, const struct xxh64_state *src)
 {
 	memcpy(dst, src, sizeof(*dst));
 }
-EXPORT_SYMBOL(xxh64_copy_state);
 
 /*-***************************
  * Simple Hash Functions
@@ -151,7 +149,6 @@ uint32_t xxh32(const void *input, const size_t len, const uint32_t seed)
 
 	return h32;
 }
-EXPORT_SYMBOL(xxh32);
 
 static uint64_t xxh64_round(uint64_t acc, const uint64_t input)
 {
@@ -234,7 +231,6 @@ uint64_t xxh64(const void *input, const size_t len, const uint64_t seed)
 
 	return h64;
 }
-EXPORT_SYMBOL(xxh64);
 
 /*-**************************************************
  * Advanced Hash Functions
@@ -251,7 +247,6 @@ void xxh32_reset(struct xxh32_state *statePtr, const uint32_t seed)
 	state.v4 = seed - PRIME32_1;
 	memcpy(statePtr, &state, sizeof(state));
 }
-EXPORT_SYMBOL(xxh32_reset);
 
 void xxh64_reset(struct xxh64_state *statePtr, const uint64_t seed)
 {
@@ -265,7 +260,6 @@ void xxh64_reset(struct xxh64_state *statePtr, const uint64_t seed)
 	state.v4 = seed - PRIME64_1;
 	memcpy(statePtr, &state, sizeof(state));
 }
-EXPORT_SYMBOL(xxh64_reset);
 
 int xxh32_update(struct xxh32_state *state, const void *input, const size_t len)
 {
@@ -334,7 +328,6 @@ int xxh32_update(struct xxh32_state *state, const void *input, const size_t len)
 
 	return 0;
 }
-EXPORT_SYMBOL(xxh32_update);
 
 uint32_t xxh32_digest(const struct xxh32_state *state)
 {
@@ -372,7 +365,6 @@ uint32_t xxh32_digest(const struct xxh32_state *state)
 
 	return h32;
 }
-EXPORT_SYMBOL(xxh32_digest);
 
 int xxh64_update(struct xxh64_state *state, const void *input, const size_t len)
 {
@@ -439,7 +431,6 @@ int xxh64_update(struct xxh64_state *state, const void *input, const size_t len)
 
 	return 0;
 }
-EXPORT_SYMBOL(xxh64_update);
 
 uint64_t xxh64_digest(const struct xxh64_state *state)
 {
@@ -494,7 +485,19 @@ uint64_t xxh64_digest(const struct xxh64_state *state)
 
 	return h64;
 }
+
+#ifndef PREBOOT
+EXPORT_SYMBOL(xxh32_copy_state);
+EXPORT_SYMBOL(xxh64_copy_state);
+EXPORT_SYMBOL(xxh32);
+EXPORT_SYMBOL(xxh64);
+EXPORT_SYMBOL(xxh32_reset);
+EXPORT_SYMBOL(xxh64_reset);
+EXPORT_SYMBOL(xxh32_update);
+EXPORT_SYMBOL(xxh32_digest);
+EXPORT_SYMBOL(xxh64_update);
 EXPORT_SYMBOL(xxh64_digest);
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DESCRIPTION("xxHash");
+#endif
diff --git a/lib/zstd/decompress.c b/lib/zstd/decompress.c
index b17846725ca0..b7b6599be69e 100644
--- a/lib/zstd/decompress.c
+++ b/lib/zstd/decompress.c
@@ -2487,6 +2487,7 @@ size_t ZSTD_decompressStream(ZSTD_DStream *zds, ZSTD_outBuffer *output, ZSTD_inB
 	}
 }
 
+#ifndef PREBOOT
 EXPORT_SYMBOL(ZSTD_DCtxWorkspaceBound);
 EXPORT_SYMBOL(ZSTD_initDCtx);
 EXPORT_SYMBOL(ZSTD_decompressDCtx);
@@ -2526,3 +2527,4 @@ EXPORT_SYMBOL(ZSTD_insertBlock);
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DESCRIPTION("Zstd Decompressor");
+#endif
diff --git a/lib/zstd/fse_decompress.c b/lib/zstd/fse_decompress.c
index a84300e5a013..0b353530fb3f 100644
--- a/lib/zstd/fse_decompress.c
+++ b/lib/zstd/fse_decompress.c
@@ -47,6 +47,7 @@
 ****************************************************************/
 #include "bitstream.h"
 #include "fse.h"
+#include "zstd_internal.h"
 #include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/string.h> /* memcpy, memset */
@@ -60,14 +61,6 @@
 		enum { FSE_static_assert = 1 / (int)(!!(c)) }; \
 	} /* use only *after* variable declarations */
 
-/* check and forward error code */
-#define CHECK_F(f)                  \
-	{                           \
-		size_t const e = f; \
-		if (FSE_isError(e)) \
-			return e;   \
-	}
-
 /* **************************************************************
 *  Templates
 ****************************************************************/
diff --git a/lib/zstd/zstd_internal.h b/lib/zstd/zstd_internal.h
index 1a79fab9e13a..40026c0da892 100644
--- a/lib/zstd/zstd_internal.h
+++ b/lib/zstd/zstd_internal.h
@@ -127,7 +127,13 @@ static const U32 OF_defaultNormLog = OF_DEFAULTNORMLOG;
 *  Shared functions to include for inlining
 *********************************************/
 ZSTD_STATIC void ZSTD_copy8(void *dst, const void *src) {
-	memcpy(dst, src, 8);
+	/* zstd relies heavily on gcc being able to analyze and inline this
+	 * memcpy() call, since it is called in a tight loop. Preboot mode
+	 * is compiled in freestanding mode, which stops gcc from analyzing
+	 * memcpy(). Use __builtin_memcpy() to tell gcc to analyze this as a
+	 * regular memcpy().
+	 */
+	__builtin_memcpy(dst, src, 8);
 }
 /*! ZSTD_wildcopy() :
 *   custom version of memcpy(), can copy up to 7 bytes too many (8 bytes if length==0) */
@@ -137,6 +143,7 @@ ZSTD_STATIC void ZSTD_wildcopy(void *dst, const void *src, ptrdiff_t length)
 	const BYTE* ip = (const BYTE*)src;
 	BYTE* op = (BYTE*)dst;
 	BYTE* const oend = op + length;
+#if GCC_VERSION >= 70000 && GCC_VERSION < 70200
 	/* Work around https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81388.
 	 * Avoid the bad case where the loop only runs once by handling the
 	 * special case separately. This doesn't trigger the bug because it
@@ -144,6 +151,7 @@ ZSTD_STATIC void ZSTD_wildcopy(void *dst, const void *src, ptrdiff_t length)
 	 */
 	if (length <= 8)
 		return ZSTD_copy8(dst, src);
+#endif
 	do {
 		ZSTD_copy8(op, ip);
 		op += 8;
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 8fe4468f9bda..e79bb1444b29 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -389,6 +389,21 @@ cmd_xzmisc = (cat $(filter-out FORCE,$^) | \
 	xz --check=crc32 --lzma2=dict=1MiB) > $@ || \
 	(rm -f $@ ; false)
 
+# ZSTD
+# ---------------------------------------------------------------------------
+# Appends the uncompressed size of the data using size_append. The .zst
+# format has the size information available at the beginning of the file too,
+# but it's in a more complex format and it's good to avoid changing the part
+# of the boot code that reads the uncompressed size.
+# Note that the bytes added by size_append will make the zstd tool think that
+# the file is corrupt. This is expected.
+
+quiet_cmd_zstd = ZSTD    $@
+cmd_zstd = (cat $(filter-out FORCE,$^) | \
+	zstd -19 && \
+        $(call size_append, $(filter-out FORCE,$^))) > $@ || \
+	(rm -f $@ ; false)
+
 # ASM offsets
 # ---------------------------------------------------------------------------
 
diff --git a/usr/Kconfig b/usr/Kconfig
index 43658b8a975e..5ff529b75ee1 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -106,6 +106,15 @@ config RD_LZ4
 	  Support loading of a LZ4 encoded initial ramdisk or cpio buffer
 	  If unsure, say N.
 
+config RD_ZSTD
+	bool "Support initial ramdisk/ramfs compressed using ZSTD"
+	default y
+	depends on BLK_DEV_INITRD
+	select DECOMPRESS_ZSTD
+	help
+	  Support loading of a ZSTD encoded initial ramdisk or cpio buffer.
+	  If unsure, say N.
+
 choice
 	prompt "Built-in initramfs compression mode"
 	depends on INITRAMFS_SOURCE!=""
@@ -214,6 +223,17 @@ config INITRAMFS_COMPRESSION_LZ4
 	  If you choose this, keep in mind that most distros don't provide lz4
 	  by default which could cause a build failure.
 
+config INITRAMFS_COMPRESSION_ZSTD
+	bool "ZSTD"
+	depends on RD_ZSTD
+	help
+	  ZSTD is a compression algorithm targeting intermediate compression
+	  with fast decompression speed. It will compress better than GZIP and
+	  decompress around the same speed as LZO, but slower than LZ4.
+
+	  If you choose this, keep in mind that you may need to install the zstd
+	  tool to be able to compress the initram.
+
 endchoice
 
 config INITRAMFS_COMPRESSION
@@ -226,10 +246,12 @@ config INITRAMFS_COMPRESSION
 	default ".xz"   if INITRAMFS_COMPRESSION_XZ
 	default ".lzo"  if INITRAMFS_COMPRESSION_LZO
 	default ".lz4"  if INITRAMFS_COMPRESSION_LZ4
+	default ".zst"  if INITRAMFS_COMPRESSION_ZSTD
 	default ".gz"   if RD_GZIP
 	default ".lz4"  if RD_LZ4
 	default ".lzo"  if RD_LZO
 	default ".xz"   if RD_XZ
 	default ".lzma" if RD_LZMA
 	default ".bz2"  if RD_BZIP2
+	default ".zst"  if RD_ZSTD
 	default ""
-- 
2.19.1
