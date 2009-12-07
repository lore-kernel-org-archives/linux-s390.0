Return-Path: <linux-kernel-owner+w=401wt.eu-S935057AbZLGN34@vger.kernel.org>
Message-ID: <4B1D0399.2070307@gmail.com>
Date: Mon, 07 Dec 2009 14:31:05 +0100
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
Subject: [PATCH] s390: PTR_ERR return of wrong pointer in fallback_init_cip()
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Return the PTR_ERR of the correct pointer.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 arch/s390/crypto/aes_s390.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
index 6118890..6be4503 100644
--- a/arch/s390/crypto/aes_s390.c
+++ b/arch/s390/crypto/aes_s390.c
@@ -174,7 +174,7 @@ static int fallback_init_cip(struct crypto_tfm *tfm)
 	if (IS_ERR(sctx->fallback.cip)) {
 		pr_err("Allocating AES fallback algorithm %s failed\n",
 		       name);
-		return PTR_ERR(sctx->fallback.blk);
+		return PTR_ERR(sctx->fallback.cip);
 	}
 
 	return 0;
