Return-Path: <linux-kernel-owner+w=401wt.eu-S1756749AbYK0Kni@vger.kernel.org>
Message-Id: <20081127103137.838937949@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:30:56 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 36/60] convert vmcp printks to pr_xxx macros.
Content-Disposition: inline; filename=151-kmsg-vmcp.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/vmcp.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: quilt-2.6/drivers/s390/char/vmcp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/vmcp.c
+++ quilt-2.6/drivers/s390/char/vmcp.c
@@ -11,6 +11,9 @@
  * The idea of this driver is based on cpint from Neale Ferguson and #CP in CMS
  */
 
+#define KMSG_COMPONENT "vmcp"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -25,8 +28,6 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Christian Borntraeger <borntraeger@de.ibm.com>");
 MODULE_DESCRIPTION("z/VM CP interface");
 
-#define PRINTK_HEADER "vmcp: "
-
 static debug_info_t *vmcp_debug;
 
 static int vmcp_open(struct inode *inode, struct file *file)
@@ -190,7 +191,8 @@ static int __init vmcp_init(void)
 	int ret;
 
 	if (!MACHINE_IS_VM) {
-		PRINT_WARN("z/VM CP interface is only available under z/VM\n");
+		pr_warning("The z/VM CP interface device driver cannot be "
+			   "loaded without z/VM\n");
 		return -ENODEV;
 	}
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
