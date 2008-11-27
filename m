Return-Path: <linux-kernel-owner+w=401wt.eu-S1757455AbYK0KtU@vger.kernel.org>
Message-Id: <20081127103143.501023076@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:31:16 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 56/60] convert vmlogrdr printks to pr_xxx macros.
Content-Disposition: inline; filename=171-kmsg-vmlogrdr.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/vmlogrdr.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

Index: quilt-2.6/drivers/s390/char/vmlogrdr.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/vmlogrdr.c
+++ quilt-2.6/drivers/s390/char/vmlogrdr.c
@@ -10,6 +10,10 @@
  *		   Stefan Weinhuber <wein@de.ibm.com>
  *
  */
+
+#define KMSG_COMPONENT "vmlogrdr"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/errno.h>
@@ -28,8 +32,6 @@
 #include <linux/smp_lock.h>
 #include <linux/string.h>
 
-
-
 MODULE_AUTHOR
 	("(C) 2004 IBM Corporation by Xenia Tkatschow (xenia@us.ibm.com)\n"
 	 "                            Stefan Weinhuber (wein@de.ibm.com)");
@@ -174,8 +176,7 @@ static void vmlogrdr_iucv_path_severed(s
 	struct vmlogrdr_priv_t * logptr = path->private;
 	u8 reason = (u8) ipuser[8];
 
-	printk (KERN_ERR "vmlogrdr: connection severed with"
-		" reason %i\n", reason);
+	pr_err("vmlogrdr: connection severed with reason %i\n", reason);
 
 	iucv_path_sever(path, NULL);
 	kfree(path);
@@ -333,8 +334,8 @@ static int vmlogrdr_open (struct inode *
 	if (logptr->autorecording) {
 		ret = vmlogrdr_recording(logptr,1,logptr->autopurge);
 		if (ret)
-			printk (KERN_WARNING "vmlogrdr: failed to start "
-				"recording automatically\n");
+			pr_warning("vmlogrdr: failed to start "
+				   "recording automatically\n");
 	}
 
 	/* create connection to the system service */
@@ -345,9 +346,9 @@ static int vmlogrdr_open (struct inode *
 				       logptr->system_service, NULL, NULL,
 				       logptr);
 	if (connect_rc) {
-		printk (KERN_ERR "vmlogrdr: iucv connection to %s "
-			"failed with rc %i \n", logptr->system_service,
-			connect_rc);
+		pr_err("vmlogrdr: iucv connection to %s "
+		       "failed with rc %i \n",
+		       logptr->system_service, connect_rc);
 		goto out_path;
 	}
 
@@ -388,8 +389,8 @@ static int vmlogrdr_release (struct inod
 	if (logptr->autorecording) {
 		ret = vmlogrdr_recording(logptr,0,logptr->autopurge);
 		if (ret)
-			printk (KERN_WARNING "vmlogrdr: failed to stop "
-				"recording automatically\n");
+			pr_warning("vmlogrdr: failed to stop "
+				   "recording automatically\n");
 	}
 	logptr->dev_in_use = 0;
 
@@ -823,8 +824,7 @@ static int __init vmlogrdr_init(void)
 	dev_t dev;
 
 	if (! MACHINE_IS_VM) {
-		printk (KERN_ERR "vmlogrdr: not running under VM, "
-				"driver not loaded.\n");
+		pr_err("not running under VM, driver not loaded.\n");
 		return -ENODEV;
 	}
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
