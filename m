Return-Path: <linux-kernel-owner+w=401wt.eu-S965525AbXLTPdq@vger.kernel.org>
Message-Id: <20071220152111.786536632@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:20:05 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 40/47] arch/s390/: Spelling fixes
Content-Disposition: inline; filename=139-spelling-arch.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Joe Perches <joe@perches.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Joe Perches <joe@perches.com>

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/crypto/prng.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: quilt-2.6/arch/s390/crypto/prng.c
===================================================================
--- quilt-2.6.orig/arch/s390/crypto/prng.c
+++ quilt-2.6/arch/s390/crypto/prng.c
@@ -90,7 +90,7 @@ static ssize_t prng_read(struct file *fi
 	int ret = 0;
 	int tmp;
 
-	/* nbytes can be arbitrary long, we spilt it into chunks */
+	/* nbytes can be arbitrary length, we split it into chunks */
 	while (nbytes) {
 		/* same as in extract_entropy_user in random.c */
 		if (need_resched()) {

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
