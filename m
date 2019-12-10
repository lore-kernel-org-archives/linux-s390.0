Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 317/350] s390/crypto: Fix unsigned variable compared with zero
Date: Tue, 10 Dec 2019 16:07:02 -0500
Message-Id: <20191210210735.9077-278-sashal@kernel.org>
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: YueHaibing <yuehaibing@huawei.com>, Hulk Robot <hulkci@huawei.com>, Joerg Schmidbauer <jschmidb@linux.vnet.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Sasha Levin <sashal@kernel.org>, linux-crypto@vger.kernel.org, linux-s390@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 0398d4ab1677f7d8cd43aac2aa29a93dfcf9e2e3 ]

s390_crypto_shash_parmsize() return type is int, it
should not be stored in a unsigned variable, which
compared with zero.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 3c2eb6b76cab ("s390/crypto: Support for SHA3 via CPACF (MSA6)")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Joerg Schmidbauer <jschmidb@linux.vnet.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/crypto/sha_common.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/s390/crypto/sha_common.c b/arch/s390/crypto/sha_common.c
index d39e0f0792170..686fe7aa192f4 100644
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
2.20.1
