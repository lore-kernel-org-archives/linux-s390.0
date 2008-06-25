Return-Path: <linux-kernel-owner+w=401wt.eu-S1760609AbYFYOns@vger.kernel.org>
Message-Id: <20080625143614.189032014@de.ibm.com>
References: <20080625143459.100139455@de.ibm.com>
Date: Wed, 25 Jun 2008 16:35:10 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 11/21] Cleanup cpacf printk messages.
Content-Disposition: inline; filename=810-printk-cpacf.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Jan Glauber <jang@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jan Glauber <jang@linux.vnet.ibm.com>

Signed-off-by: Jan Glauber <jang@linux.vnet.ibm.com>
---

 arch/s390/crypto/prng.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

Index: quilt-2.6/arch/s390/crypto/prng.c
===================================================================
--- quilt-2.6.orig/arch/s390/crypto/prng.c
+++ quilt-2.6/arch/s390/crypto/prng.c
@@ -185,11 +185,8 @@ static int __init prng_init(void)
 	prng_seed(16);
 
 	ret = misc_register(&prng_dev);
-	if (ret) {
-		printk(KERN_WARNING
-		       "Could not register misc device for PRNG.\n");
+	if (ret)
 		goto out_buf;
-	}
 	return 0;
 
 out_buf:

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
