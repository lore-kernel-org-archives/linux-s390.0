Return-Path: <linux-kernel-owner+w=401wt.eu-S1756392AbYFYOmS@vger.kernel.org>
Message-Id: <20080625143615.732687754@de.ibm.com>
References: <20080625143459.100139455@de.ibm.com>
Date: Wed, 25 Jun 2008 16:35:16 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 17/21] Cleanup zfcp dumper printk messages.
Content-Disposition: inline; filename=816-printk-zcore.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Michael Holzheu <holzheu@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@de.ibm.com>

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/zcore.c |   29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

Index: quilt-2.6/drivers/s390/char/zcore.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/zcore.c
+++ quilt-2.6/drivers/s390/char/zcore.c
@@ -223,12 +223,10 @@ static int __init init_cpu_info(enum arc
 	/* get info for boot cpu from lowcore, stored in the HSA */
 
 	sa = kmalloc(sizeof(*sa), GFP_KERNEL);
-	if (!sa) {
-		ERROR_MSG("kmalloc failed: %s: %i\n",__func__, __LINE__);
+	if (!sa)
 		return -ENOMEM;
-	}
 	if (memcpy_hsa_kernel(sa, sys_info.sa_base, sys_info.sa_size) < 0) {
-		ERROR_MSG("could not copy from HSA\n");
+		TRACE("could not copy from HSA\n");
 		kfree(sa);
 		return -EIO;
 	}
@@ -529,10 +527,9 @@ static int __init sys_info_init(enum arc
 		return -EINVAL;
 	}
 	sys_info.arch = arch;
-	if (init_cpu_info(arch)) {
-		ERROR_MSG("get cpu info failed\n");
-		return -ENOMEM;
-	}
+	rc = init_cpu_info(arch);
+	if (rc)
+		return rc;
 	sys_info.mem_size = real_memory_size;
 
 	return 0;
@@ -544,12 +541,12 @@ static int __init check_sdias(void)
 
 	rc = sclp_sdias_blk_count();
 	if (rc < 0) {
-		ERROR_MSG("Could not determine HSA size\n");
+		TRACE("Could not determine HSA size\n");
 		return rc;
 	}
 	act_hsa_size = (rc - 1) * PAGE_SIZE;
 	if (act_hsa_size < ZFCPDUMP_HSA_SIZE) {
-		ERROR_MSG("HSA size too small: %i\n", act_hsa_size);
+		TRACE("HSA size too small: %i\n", act_hsa_size);
 		return -EINVAL;
 	}
 	return 0;
@@ -590,16 +587,12 @@ static int __init zcore_init(void)
 		goto fail;
 
 	rc = check_sdias();
-	if (rc) {
-		ERROR_MSG("Dump initialization failed\n");
+	if (rc)
 		goto fail;
-	}
 
 	rc = memcpy_hsa_kernel(&arch, __LC_AR_MODE_ID, 1);
-	if (rc) {
-		ERROR_MSG("sdial memcpy for arch id failed\n");
+	if (rc)
 		goto fail;
-	}
 
 #ifndef __s390x__
 	if (arch == ARCH_S390X) {
@@ -610,10 +603,8 @@ static int __init zcore_init(void)
 #endif
 
 	rc = sys_info_init(arch);
-	if (rc) {
-		ERROR_MSG("arch init failed\n");
+	if (rc)
 		goto fail;
-	}
 
 	zcore_header_init(arch, &zcore_header);
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
