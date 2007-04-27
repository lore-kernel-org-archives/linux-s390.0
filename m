Return-Path: <linux-kernel-owner+w=401wt.eu-S1755896AbXD0OLJ@vger.kernel.org>
Message-Id: <20070427140519.148445656@de.ibm.com>
References: <20070427140503.087958775@de.ibm.com>
Date: Fri, 27 Apr 2007 16:05:34 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 31/38] crypto: cleanup.
Content-Disposition: inline; filename=134-crypto.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Jan Glauber <jan.glauber@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jan Glauber <jan.glauber@de.ibm.com>

Cleanup code and remove obsolete documentation.

Signed-off-by: Jan Glauber <jan.glauber@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/s390/crypto/crypto-API.txt |   79 -------------------
 arch/s390/crypto/sha1_s390.c             |  127 +++++++++++++++----------------
 arch/s390/crypto/sha256_s390.c           |   38 +++------
 3 files changed, 80 insertions(+), 164 deletions(-)

Index: quilt-2.6/arch/s390/crypto/sha1_s390.c
===================================================================
--- quilt-2.6.orig/arch/s390/crypto/sha1_s390.c	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/arch/s390/crypto/sha1_s390.c	2007-04-27 16:05:00.000000000 +0200
@@ -25,99 +25,100 @@
  */
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/mm.h>
 #include <linux/crypto.h>
-#include <asm/scatterlist.h>
-#include <asm/byteorder.h>
+
 #include "crypt_s390.h"
 
 #define SHA1_DIGEST_SIZE	20
 #define SHA1_BLOCK_SIZE		64
 
-struct crypt_s390_sha1_ctx {
-	u64 count;
+struct s390_sha1_ctx {
+	u64 count;		/* message length */
 	u32 state[5];
-	u32 buf_len;
-	u8 buffer[2 * SHA1_BLOCK_SIZE];
+	u8 buf[2 * SHA1_BLOCK_SIZE];
 };
 
 static void sha1_init(struct crypto_tfm *tfm)
 {
-	struct crypt_s390_sha1_ctx *ctx = crypto_tfm_ctx(tfm);
-
-	ctx->state[0] = 0x67452301;
-	ctx->state[1] =	0xEFCDAB89;
-	ctx->state[2] =	0x98BADCFE;
-	ctx->state[3] = 0x10325476;
-	ctx->state[4] =	0xC3D2E1F0;
+	struct s390_sha1_ctx *sctx = crypto_tfm_ctx(tfm);
 
-	ctx->count = 0;
-	ctx->buf_len = 0;
+	sctx->state[0] = 0x67452301;
+	sctx->state[1] = 0xEFCDAB89;
+	sctx->state[2] = 0x98BADCFE;
+	sctx->state[3] = 0x10325476;
+	sctx->state[4] = 0xC3D2E1F0;
+	sctx->count = 0;
 }
 
 static void sha1_update(struct crypto_tfm *tfm, const u8 *data,
 			unsigned int len)
 {
-	struct crypt_s390_sha1_ctx *sctx;
-	long imd_len;
-
-	sctx = crypto_tfm_ctx(tfm);
-	sctx->count += len * 8; /* message bit length */
-
-	/* anything in buffer yet? -> must be completed */
-	if (sctx->buf_len && (sctx->buf_len + len) >= SHA1_BLOCK_SIZE) {
-		/* complete full block and hash */
-		memcpy(sctx->buffer + sctx->buf_len, data,
-		       SHA1_BLOCK_SIZE - sctx->buf_len);
-		crypt_s390_kimd(KIMD_SHA_1, sctx->state, sctx->buffer,
-				SHA1_BLOCK_SIZE);
-		data += SHA1_BLOCK_SIZE - sctx->buf_len;
-		len -= SHA1_BLOCK_SIZE - sctx->buf_len;
-		sctx->buf_len = 0;
+	struct s390_sha1_ctx *sctx = crypto_tfm_ctx(tfm);
+	unsigned int index;
+	int ret;
+
+	/* how much is already in the buffer? */
+	index = sctx->count & 0x3f;
+
+	sctx->count += len;
+
+	if (index + len < SHA1_BLOCK_SIZE)
+		goto store;
+
+	/* process one stored block */
+	if (index) {
+		memcpy(sctx->buf + index, data, SHA1_BLOCK_SIZE - index);
+		ret = crypt_s390_kimd(KIMD_SHA_1, sctx->state, sctx->buf,
+				      SHA1_BLOCK_SIZE);
+		BUG_ON(ret != SHA1_BLOCK_SIZE);
+		data += SHA1_BLOCK_SIZE - index;
+		len -= SHA1_BLOCK_SIZE - index;
 	}
 
-	/* rest of data contains full blocks? */
-	imd_len = len & ~0x3ful;
-	if (imd_len) {
-		crypt_s390_kimd(KIMD_SHA_1, sctx->state, data, imd_len);
-		data += imd_len;
-		len -= imd_len;
-	}
-	/* anything left? store in buffer */
-	if (len) {
-		memcpy(sctx->buffer + sctx->buf_len , data, len);
-		sctx->buf_len += len;
+	/* process as many blocks as possible */
+	if (len >= SHA1_BLOCK_SIZE) {
+		ret = crypt_s390_kimd(KIMD_SHA_1, sctx->state, data,
+				      len & ~(SHA1_BLOCK_SIZE - 1));
+		BUG_ON(ret != (len & ~(SHA1_BLOCK_SIZE - 1)));
+		data += ret;
+		len -= ret;
 	}
-}
 
+store:
+	/* anything left? */
+	if (len)
+		memcpy(sctx->buf + index , data, len);
+}
 
-static void pad_message(struct crypt_s390_sha1_ctx* sctx)
+/* Add padding and return the message digest. */
+static void sha1_final(struct crypto_tfm *tfm, u8 *out)
 {
-	int index;
+	struct s390_sha1_ctx *sctx = crypto_tfm_ctx(tfm);
+	u64 bits;
+	unsigned int index, end;
+	int ret;
+
+	/* must perform manual padding */
+	index = sctx->count & 0x3f;
+	end =  (index < 56) ? SHA1_BLOCK_SIZE : (2 * SHA1_BLOCK_SIZE);
 
-	index = sctx->buf_len;
-	sctx->buf_len = (sctx->buf_len < 56) ?
-			 SHA1_BLOCK_SIZE:2 * SHA1_BLOCK_SIZE;
 	/* start pad with 1 */
-	sctx->buffer[index] = 0x80;
+	sctx->buf[index] = 0x80;
+
 	/* pad with zeros */
 	index++;
-	memset(sctx->buffer + index, 0x00, sctx->buf_len - index);
-	/* append length */
-	memcpy(sctx->buffer + sctx->buf_len - 8, &sctx->count,
-	       sizeof sctx->count);
-}
+	memset(sctx->buf + index, 0x00, end - index - 8);
 
-/* Add padding and return the message digest. */
-static void sha1_final(struct crypto_tfm *tfm, u8 *out)
-{
-	struct crypt_s390_sha1_ctx *sctx = crypto_tfm_ctx(tfm);
+	/* append message length */
+	bits = sctx->count * 8;
+	memcpy(sctx->buf + end - 8, &bits, sizeof(bits));
+
+	ret = crypt_s390_kimd(KIMD_SHA_1, sctx->state, sctx->buf, end);
+	BUG_ON(ret != end);
 
-	/* must perform manual padding */
-	pad_message(sctx);
-	crypt_s390_kimd(KIMD_SHA_1, sctx->state, sctx->buffer, sctx->buf_len);
 	/* copy digest to out */
 	memcpy(out, sctx->state, SHA1_DIGEST_SIZE);
+
 	/* wipe context */
 	memset(sctx, 0, sizeof *sctx);
 }
@@ -128,7 +129,7 @@
 	.cra_priority	=	CRYPT_S390_PRIORITY,
 	.cra_flags	=	CRYPTO_ALG_TYPE_DIGEST,
 	.cra_blocksize	=	SHA1_BLOCK_SIZE,
-	.cra_ctxsize	=	sizeof(struct crypt_s390_sha1_ctx),
+	.cra_ctxsize	=	sizeof(struct s390_sha1_ctx),
 	.cra_module	=	THIS_MODULE,
 	.cra_list	=	LIST_HEAD_INIT(alg.cra_list),
 	.cra_u		=	{ .digest = {
Index: quilt-2.6/arch/s390/crypto/sha256_s390.c
===================================================================
--- quilt-2.6.orig/arch/s390/crypto/sha256_s390.c	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/arch/s390/crypto/sha256_s390.c	2007-04-27 16:05:00.000000000 +0200
@@ -26,7 +26,7 @@
 #define SHA256_BLOCK_SIZE	64
 
 struct s390_sha256_ctx {
-	u64 count;
+	u64 count;		/* message length */
 	u32 state[8];
 	u8 buf[2 * SHA256_BLOCK_SIZE];
 };
@@ -54,10 +54,9 @@
 	int ret;
 
 	/* how much is already in the buffer? */
-	index = sctx->count / 8 & 0x3f;
+	index = sctx->count & 0x3f;
 
-	/* update message bit length */
-	sctx->count += len * 8;
+	sctx->count += len;
 
 	if ((index + len) < SHA256_BLOCK_SIZE)
 		goto store;
@@ -87,12 +86,17 @@
 		memcpy(sctx->buf + index , data, len);
 }
 
-static void pad_message(struct s390_sha256_ctx* sctx)
+/* Add padding and return the message digest */
+static void sha256_final(struct crypto_tfm *tfm, u8 *out)
 {
-	int index, end;
+	struct s390_sha256_ctx *sctx = crypto_tfm_ctx(tfm);
+	u64 bits;
+	unsigned int index, end;
+	int ret;
 
-	index = sctx->count / 8 & 0x3f;
-	end = index < 56 ? SHA256_BLOCK_SIZE : 2 * SHA256_BLOCK_SIZE;
+	/* must perform manual padding */
+	index = sctx->count & 0x3f;
+	end = (index < 56) ? SHA256_BLOCK_SIZE : (2 * SHA256_BLOCK_SIZE);
 
 	/* start pad with 1 */
 	sctx->buf[index] = 0x80;
@@ -102,21 +106,11 @@
 	memset(sctx->buf + index, 0x00, end - index - 8);
 
 	/* append message length */
-	memcpy(sctx->buf + end - 8, &sctx->count, sizeof sctx->count);
-
-	sctx->count = end * 8;
-}
-
-/* Add padding and return the message digest */
-static void sha256_final(struct crypto_tfm *tfm, u8 *out)
-{
-	struct s390_sha256_ctx *sctx = crypto_tfm_ctx(tfm);
-
-	/* must perform manual padding */
-	pad_message(sctx);
+	bits = sctx->count * 8;
+	memcpy(sctx->buf + end - 8, &bits, sizeof(bits));
 
-	crypt_s390_kimd(KIMD_SHA_256, sctx->state, sctx->buf,
-			sctx->count / 8);
+	ret = crypt_s390_kimd(KIMD_SHA_256, sctx->state, sctx->buf, end);
+	BUG_ON(ret != end);
 
 	/* copy digest to out */
 	memcpy(out, sctx->state, SHA256_DIGEST_SIZE);
Index: quilt-2.6/Documentation/s390/crypto/crypto-API.txt
===================================================================
--- quilt-2.6.orig/Documentation/s390/crypto/crypto-API.txt	2007-04-27 16:01:49.000000000 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,83 +0,0 @@
-crypto-API support for z990 Message Security Assist (MSA) instructions
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-AUTHOR:	Thomas Spatzier (tspat@de.ibm.com)
-
-
-1. Introduction crypto-API
-~~~~~~~~~~~~~~~~~~~~~~~~~~
-See Documentation/crypto/api-intro.txt for an introduction/description of the
-kernel crypto API.
-According to api-intro.txt support for z990 crypto instructions has been added
-in the algorithm api layer of the crypto API. Several files containing z990
-optimized implementations of crypto algorithms are placed in the
-arch/s390/crypto directory.
-
-
-2. Probing for availability of MSA
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-It should be possible to use Kernels with the z990 crypto implementations both
-on machines with MSA available and on those without MSA (pre z990 or z990
-without MSA). Therefore a simple probing mechanism has been implemented:
-In the init function of each crypto module the availability of MSA and of the
-respective crypto algorithm in particular will be tested. If the algorithm is
-available the module will load and register its algorithm with the crypto API.
-
-If the respective crypto algorithm is not available, the init function will
-return -ENOSYS. In that case a fallback to the standard software implementation
-of the crypto algorithm must be taken ( -> the standard crypto modules are
-also built when compiling the kernel).
-
-
-3. Ensuring z990 crypto module preference
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-If z990 crypto instructions are available the optimized modules should be
-preferred instead of standard modules.
-
-3.1. compiled-in modules
-~~~~~~~~~~~~~~~~~~~~~~~~
-For compiled-in modules it has to be ensured that the z990 modules are linked
-before the standard crypto modules. Then, on system startup the init functions
-of z990 crypto modules will be called first and query for availability of z990
-crypto instructions. If instruction is available, the z990 module will register
-its crypto algorithm implementation -> the load of the standard module will fail
-since the algorithm is already registered.
-If z990 crypto instruction is not available the load of the z990 module will
-fail -> the standard module will load and register its algorithm.
-
-3.2. dynamic modules
-~~~~~~~~~~~~~~~~~~~~
-A system administrator has to take care of giving preference to z990 crypto
-modules. If MSA is available appropriate lines have to be added to
-/etc/modprobe.conf.
-
-Example:	z990 crypto instruction for SHA1 algorithm is available
-
-		add the following line to /etc/modprobe.conf (assuming the
-		z990 crypto modules for SHA1 is called sha1_z990):
-
-		alias sha1 sha1_z990
-
-		-> when the sha1 algorithm is requested through the crypto API
-		(which has a module autoloader) the z990 module will be loaded.
-
-TBD:	a userspace module probing mechanism
-	something like 'probe sha1 sha1_z990 sha1' in modprobe.conf
-	-> try module sha1_z990, if it fails to load standard module sha1
-	the 'probe' statement is currently not supported in modprobe.conf
-
-
-4. Currently implemented z990 crypto algorithms
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-The following crypto algorithms with z990 MSA support are currently implemented.
-The name of each algorithm under which it is registered in crypto API and the
-name of the respective module is given in square brackets.
-
-- SHA1 Digest Algorithm [sha1 -> sha1_z990]
-- DES Encrypt/Decrypt Algorithm (64bit key) [des -> des_z990]
-- Triple DES Encrypt/Decrypt Algorithm (128bit key) [des3_ede128 -> des_z990]
-- Triple DES Encrypt/Decrypt Algorithm (192bit key) [des3_ede -> des_z990]
-
-In order to load, for example, the sha1_z990 module when the sha1 algorithm is
-requested (see 3.2.) add 'alias sha1 sha1_z990' to /etc/modprobe.conf.
-

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
