From: Sachin Sant <sachinp@in.ibm.com>
Subject: Next July 16: s390 sha1 crypro build failure.
Date: Thu, 16 Jul 2009 15:29:26 +0530
Message-ID: <4A5EF9FE.2050302@in.ibm.com>
References: <20090716172015.be5dc94b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070606080106030704050605"
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20090716172015.be5dc94b.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, herbert@gondor.apana.org.au
List-ID: <linux-s390.vger.kernel.org>

This is a multi-part message in MIME format.
--------------070606080106030704050605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Today's next tree fails to build on s390 with following errors.

arch/s390/crypto/sha1_s390.c:67: error: 'struct sha1_state' has no member named 'buf'
arch/s390/crypto/sha1_s390.c:68: error: 'struct sha1_state' has no member named 'func'

arch/s390/crypto/sha256_s390.c:64: error: 'struct sha256_state' has no member named 'func'

Probably because of commit 406f104b4172de7452702c6810807c1b0132ba22.

In sha1_/sha256_import() functions struct s390_sha_ctx *sctx should be
used instead of struct sha1_state.

The following patch fixed the issue for me.

Thanks
-Sachin



--------------070606080106030704050605
Content-Type: text/x-patch;
 name="s390-crypto-build-break-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="s390-crypto-build-break-fix.patch"

Use struct s390_sha_ctx instead of sha1/sha256_state struct to fix
s390 crypto build break.

Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
---

diff -Naurp linux//arch/s390/crypto/sha1_s390.c new//arch/s390/crypto/sha1_s390.c
--- linux//arch/s390/crypto/sha1_s390.c	2009-07-16 05:46:31.000000000 -0400
+++ new//arch/s390/crypto/sha1_s390.c	2009-07-16 05:48:10.000000000 -0400
@@ -59,7 +59,7 @@ static int sha1_export(struct shash_desc
 
 static int sha1_import(struct shash_desc *desc, const u8 *in)
 {
-	struct sha1_state *sctx = shash_desc_ctx(desc);
+	struct s390_sha_ctx *sctx = shash_desc_ctx(desc);
 	struct sha1_state *ictx = in;
 
 	sctx->count = ictx->count;
diff -Naurp linux//arch/s390/crypto/sha256_s390.c new//arch/s390/crypto/sha256_s390.c
--- linux//arch/s390/crypto/sha256_s390.c	2009-07-16 05:47:42.000000000 -0400
+++ new//arch/s390/crypto/sha256_s390.c	2009-07-16 05:46:07.000000000 -0400
@@ -55,7 +55,7 @@ static int sha256_export(struct shash_de
 
 static int sha256_import(struct shash_desc *desc, const u8 *in)
 {
-	struct sha256_state *sctx = shash_desc_ctx(desc);
+	struct s390_sha_ctx *sctx = shash_desc_ctx(desc);
 	struct sha256_state *ictx = in;
 
 	sctx->count = ictx->count;

--------------070606080106030704050605--
