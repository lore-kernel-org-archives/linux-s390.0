Return-Path: <linux-kernel-owner+w=401wt.eu-S1760584AbYG1R7t@vger.kernel.org>
Message-Id: <20080728175512.674247865@de.ibm.com>
References: <20080728175355.734299984@de.ibm.com>
Date: Mon, 28 Jul 2008 19:54:03 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 08/15] kmsg: convert cpacf printk messages to kmsg api.
Content-Disposition: inline; filename=808-kmsg-cpacf.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Jan Glauber <jang@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jan Glauber <jang@linux.vnet.ibm.com>

Signed-off-by: Jan Glauber <jang@linux.vnet.ibm.com>
---

 Documentation/s390/kmsg/aes_s390 |   32 ++++++++++++++++++++++++++++++++
 arch/s390/crypto/aes_s390.c      |   14 +++++++++-----
 2 files changed, 41 insertions(+), 5 deletions(-)

Index: quilt-2.6/arch/s390/crypto/aes_s390.c
===================================================================
--- quilt-2.6.orig/arch/s390/crypto/aes_s390.c
+++ quilt-2.6/arch/s390/crypto/aes_s390.c
@@ -22,8 +22,11 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <asm/kmsg.h>
 #include "crypt_s390.h"
 
+#define KMSG_COMPONENT "aes_s390"
+
 #define AES_KEYLEN_128		1
 #define AES_KEYLEN_192		2
 #define AES_KEYLEN_256		4
@@ -169,7 +172,8 @@ static int fallback_init_cip(struct cryp
 			CRYPTO_ALG_ASYNC | CRYPTO_ALG_NEED_FALLBACK);
 
 	if (IS_ERR(sctx->fallback.cip)) {
-		printk(KERN_ERR "Error allocating fallback algo %s\n", name);
+		kmsg_err(1, "Allocating AES fallback algorithm %s failed\n",
+			 name);
 		return PTR_ERR(sctx->fallback.blk);
 	}
 
@@ -349,7 +353,8 @@ static int fallback_init_blk(struct cryp
 			CRYPTO_ALG_ASYNC | CRYPTO_ALG_NEED_FALLBACK);
 
 	if (IS_ERR(sctx->fallback.blk)) {
-		printk(KERN_ERR "Error allocating fallback algo %s\n", name);
+		kmsg_err(1, "Allocating AES fallback algorithm %s failed\n",
+			 name);
 		return PTR_ERR(sctx->fallback.blk);
 	}
 
@@ -515,9 +520,8 @@ static int __init aes_s390_init(void)
 
 	/* z9 109 and z9 BC/EC only support 128 bit key length */
 	if (keylen_flag == AES_KEYLEN_128)
-		printk(KERN_INFO
-		       "aes_s390: hardware acceleration only available for "
-		       "128 bit keys\n");
+		kmsg_info(2, "AES hardware acceleration is only available for"
+			  " 128-bit keys\n");
 
 	ret = crypto_register_alg(&aes_alg);
 	if (ret)
Index: quilt-2.6/Documentation/s390/kmsg/aes_s390
===================================================================
--- /dev/null
+++ quilt-2.6/Documentation/s390/kmsg/aes_s390
@@ -0,0 +1,32 @@
+/*?
+ * Tag: aes_s390.1
+ * Text: "Allocating AES fallback algorithm %s failed"
+ * Severity: Error
+ * Parameter:
+ *   @1: algorithm name
+ * Description:
+ * The advanced encryption standard (AES) algorithm includes three modes with
+ * 128-bit, 192-bit, and 256-bit keys. Your hardware system only provides
+ * hardware acceleration for the 128-bit mode. The aes_s390 module failed to
+ * allocate a software fallback for the AES modes that are not supported by the
+ * hardware. A possible reason for this problem is that the aes_generic module
+ * that provides the fallback algorithms is not available.
+ * User action:
+ * Use the 128-bit mode only or ensure that the aes_generic module is available
+ * and loaded and reload the aes_s390 module.
+ */
+
+/*?
+ * Tag: aes_s390.2
+ * Text: "AES hardware acceleration is only available for 128-bit keys"
+ * Severity: Informational
+ * Description:
+ * The advanced encryption standard (AES) algorithm includes three modes with
+ * 128-bit, 192-bit, and 256-bit keys. Your hardware system only provides
+ * hardware acceleration for the 128-bit key mode. The aes_s390 module
+ * will use the less performant software fallback algorithm for the 192-bit
+ * and 256-bit key modes.
+ * User action:
+ * None.
+ */
+

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
