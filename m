Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:49486 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbfKNHi5 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 02:38:57 -0500
From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] s390/crypto: Fix unsigned variable compared with zero
Date: Thu, 14 Nov 2019 15:30:05 +0800
Message-ID: <20191114073005.47000-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: herbert@gondor.apana.org.au, davem@davemloft.net, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, freude@linux.ibm.com, ifranzki@linux.ibm.com, jschmidb@de.ibm.com
Cc: linux-crypto@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>

s390_crypto_shash_parmsize() return type is int, it
should not be stored in a unsigned variable, which
compared with zero.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 3c2eb6b76cab ("s390/crypto: Support for SHA3 via CPACF (MSA6)")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/s390/crypto/sha_common.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/s390/crypto/sha_common.c b/arch/s390/crypto/sha_common.c
index d39e0f0..686fe7a 100644
--- a/arch/s390/crypto/sha_common.c
+++ b/arch/s390/crypto/sha_common.c
@@ -74,14 +74,17 @@ int s390_sha_final(struct shash_desc *desc, u8 *out)
 	struct s390_sha_ctx *ctx = shash_desc_ctx(desc);
 	unsigned int bsize = crypto_shash_blocksize(desc->tfm);
 	u64 bits;
-	unsigned int n, mbl_offset;
+	unsigned int n;
+	int mbl_offset;
 
 	n = ctx->count % bsize;
 	bits = ctx->count * 8;
-	mbl_offset = s390_crypto_shash_parmsize(ctx->func) / sizeof(u32);
+	mbl_offset = s390_crypto_shash_parmsize(ctx->func);
 	if (mbl_offset < 0)
 		return -EINVAL;
 
+	mbl_offset = mbl_offset / sizeof(u32);
+
 	/* set total msg bit length (mbl) in CPACF parmblock */
 	switch (ctx->func) {
 	case CPACF_KLMD_SHA_1:
-- 
2.7.4
