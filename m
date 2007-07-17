Return-Path: <linux-kernel-owner+w=401wt.eu-S1764914AbXGQMV3@vger.kernel.org>
Message-Id: <20070717122247.758467740@de.ibm.com>
References: <20070717121747.591687140@de.ibm.com>
Date: Tue, 17 Jul 2007 14:17:51 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 4/8] vmcp cleanup
Content-Disposition: inline; filename=003-vmcp-cleanup.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

A number of small changes to vmcp:
 - Change preferred email address.
 - Use PRINT_xxx machros from debug.h like most s390 drivers, define
   "vmcp:" as PRINTK_HEADER and wrap error message at column 80.
 - Add error number to error message.
 - Update copyright, as I touched this file.
 - Small whitespace diff.
 - Use mutex instead of semaphore (Thanks Heiko for the patch)
 - Don't register debug feature on failure.
 - Check debug feature registration on init to avoid a potential oops
   on unload if the debug feature could not be registered--> 2 more
   messages.


Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/vmcp.c |   89 ++++++++++++++++++++++++++---------------------
 drivers/s390/char/vmcp.h |    4 +-
 2 files changed, 53 insertions(+), 40 deletions(-)

Index: quilt-2.6/drivers/s390/char/vmcp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/vmcp.c
+++ quilt-2.6/drivers/s390/char/vmcp.c
@@ -1,7 +1,7 @@
 /*
- * Copyright (C) 2004,2005 IBM Corporation
+ * Copyright IBM Corp. 2004,2007
  * Interface implementation for communication with the z/VM control program
- * Author(s): Christian Borntraeger <cborntra@de.ibm.com>
+ * Author(s): Christian Borntraeger <borntraeger@de.ibm.com>
  *
  *
  * z/VMs CP offers the possibility to issue commands via the diagnose code 8
@@ -22,9 +22,11 @@
 #include "vmcp.h"
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Christian Borntraeger <cborntra@de.ibm.com>");
+MODULE_AUTHOR("Christian Borntraeger <borntraeger@de.ibm.com>");
 MODULE_DESCRIPTION("z/VM CP interface");
 
+#define PRINTK_HEADER "vmcp: "
+
 static debug_info_t *vmcp_debug;
 
 static int vmcp_open(struct inode *inode, struct file *file)
@@ -40,7 +42,7 @@ static int vmcp_open(struct inode *inode
 	session->bufsize = PAGE_SIZE;
 	session->response = NULL;
 	session->resp_size = 0;
-	init_MUTEX(&session->mutex);
+	mutex_init(&session->mutex);
 	file->private_data = session;
 	return nonseekable_open(inode, file);
 }
@@ -57,37 +59,37 @@ static int vmcp_release(struct inode *in
 }
 
 static ssize_t
-vmcp_read(struct file *file, char __user * buff, size_t count, loff_t * ppos)
+vmcp_read(struct file *file, char __user *buff, size_t count, loff_t *ppos)
 {
 	size_t tocopy;
 	struct vmcp_session *session;
 
 	session = (struct vmcp_session *)file->private_data;
-	if (down_interruptible(&session->mutex))
+	if (mutex_lock_interruptible(&session->mutex))
 		return -ERESTARTSYS;
 	if (!session->response) {
-		up(&session->mutex);
+		mutex_unlock(&session->mutex);
 		return 0;
 	}
 	if (*ppos > session->resp_size) {
-		up(&session->mutex);
+		mutex_unlock(&session->mutex);
 		return 0;
 	}
 	tocopy = min(session->resp_size - (size_t) (*ppos), count);
-	tocopy = min(tocopy,session->bufsize - (size_t) (*ppos));
+	tocopy = min(tocopy, session->bufsize - (size_t) (*ppos));
 
 	if (copy_to_user(buff, session->response + (*ppos), tocopy)) {
-		up(&session->mutex);
+		mutex_unlock(&session->mutex);
 		return -EFAULT;
 	}
-	up(&session->mutex);
+	mutex_unlock(&session->mutex);
 	*ppos += tocopy;
 	return tocopy;
 }
 
 static ssize_t
-vmcp_write(struct file *file, const char __user * buff, size_t count,
-	   loff_t * ppos)
+vmcp_write(struct file *file, const char __user *buff, size_t count,
+	   loff_t *ppos)
 {
 	char *cmd;
 	struct vmcp_session *session;
@@ -103,24 +105,23 @@ vmcp_write(struct file *file, const char
 	}
 	cmd[count] = '\0';
 	session = (struct vmcp_session *)file->private_data;
-	if (down_interruptible(&session->mutex)) {
+	if (mutex_lock_interruptible(&session->mutex)) {
 		kfree(cmd);
 		return -ERESTARTSYS;
 	}
 	if (!session->response)
 		session->response = (char *)__get_free_pages(GFP_KERNEL
-						| __GFP_REPEAT 	| GFP_DMA,
+						| __GFP_REPEAT | GFP_DMA,
 						get_order(session->bufsize));
 	if (!session->response) {
-		up(&session->mutex);
+		mutex_unlock(&session->mutex);
 		kfree(cmd);
 		return -ENOMEM;
 	}
 	debug_text_event(vmcp_debug, 1, cmd);
-	session->resp_size = cpcmd(cmd, session->response,
-				     session->bufsize,
-				     &session->resp_code);
-	up(&session->mutex);
+	session->resp_size = cpcmd(cmd, session->response, session->bufsize,
+				   &session->resp_code);
+	mutex_unlock(&session->mutex);
 	kfree(cmd);
 	*ppos = 0;		/* reset the file pointer after a command */
 	return count;
@@ -145,12 +146,12 @@ static long vmcp_ioctl(struct file *file
 	int temp;
 
 	session = (struct vmcp_session *)file->private_data;
-	if (down_interruptible(&session->mutex))
+	if (mutex_lock_interruptible(&session->mutex))
 		return -ERESTARTSYS;
 	switch (cmd) {
 	case VMCP_GETCODE:
 		temp = session->resp_code;
-		up(&session->mutex);
+		mutex_unlock(&session->mutex);
 		return put_user(temp, (int __user *)arg);
 	case VMCP_SETBUF:
 		free_pages((unsigned long)session->response,
@@ -161,14 +162,14 @@ static long vmcp_ioctl(struct file *file
 			session->bufsize = PAGE_SIZE;
 			temp = -EINVAL;
 		}
-		up(&session->mutex);
+		mutex_unlock(&session->mutex);
 		return temp;
 	case VMCP_GETSIZE:
 		temp = session->resp_size;
-		up(&session->mutex);
+		mutex_unlock(&session->mutex);
 		return put_user(temp, (int __user *)arg);
 	default:
-		up(&session->mutex);
+		mutex_unlock(&session->mutex);
 		return -ENOIOCTLCMD;
 	}
 }
@@ -180,7 +181,7 @@ static const struct file_operations vmcp
 	.read		= vmcp_read,
 	.write		= vmcp_write,
 	.unlocked_ioctl	= vmcp_ioctl,
-	.compat_ioctl	= vmcp_ioctl
+	.compat_ioctl	= vmcp_ioctl,
 };
 
 static struct miscdevice vmcp_dev = {
@@ -194,26 +195,38 @@ static int __init vmcp_init(void)
 	int ret;
 
 	if (!MACHINE_IS_VM) {
-		printk(KERN_WARNING
-		       "z/VM CP interface is only available under z/VM\n");
+		PRINT_WARN("z/VM CP interface is only available under z/VM\n");
 		return -ENODEV;
 	}
-	ret = misc_register(&vmcp_dev);
-	if (!ret)
-		printk(KERN_INFO "z/VM CP interface loaded\n");
-	else
-		printk(KERN_WARNING
-		       "z/VM CP interface not loaded. Could not register misc device.\n");
 	vmcp_debug = debug_register("vmcp", 1, 1, 240);
-	debug_register_view(vmcp_debug, &debug_hex_ascii_view);
-	return ret;
+	if (!vmcp_debug) {
+		PRINT_ERR("z/VM CP interface not loaded. Could not register "
+			   "debug feature\n");
+		return -ENOMEM;
+	}
+	ret = debug_register_view(vmcp_debug, &debug_hex_ascii_view);
+	if (ret) {
+		PRINT_ERR("z/VM CP interface not loaded. Could not register "
+			  "debug feature view. Error code: %d\n", ret);
+		debug_unregister(vmcp_debug);
+		return ret;
+	}
+	ret = misc_register(&vmcp_dev);
+	if (ret) {
+		PRINT_ERR("z/VM CP interface not loaded. Could not register "
+			   "misc device. Error code: %d\n", ret);
+		debug_unregister(vmcp_debug);
+		return ret;
+	}
+	PRINT_INFO("z/VM CP interface loaded\n");
+	return 0;
 }
 
 static void __exit vmcp_exit(void)
 {
-	WARN_ON(misc_deregister(&vmcp_dev) != 0);
+	misc_deregister(&vmcp_dev);
 	debug_unregister(vmcp_debug);
-	printk(KERN_INFO "z/VM CP interface unloaded.\n");
+	PRINT_INFO("z/VM CP interface unloaded.\n");
 }
 
 module_init(vmcp_init);
Index: quilt-2.6/drivers/s390/char/vmcp.h
===================================================================
--- quilt-2.6.orig/drivers/s390/char/vmcp.h
+++ quilt-2.6/drivers/s390/char/vmcp.h
@@ -12,8 +12,8 @@
  * The idea of this driver is based on cpint from Neale Ferguson
  */
 
-#include <asm/semaphore.h>
 #include <linux/ioctl.h>
+#include <linux/mutex.h>
 
 #define VMCP_GETCODE _IOR(0x10, 1, int)
 #define VMCP_SETBUF _IOW(0x10, 2, int)
@@ -26,5 +26,5 @@ struct vmcp_session {
 	int resp_code;
 	/* As we use copy_from/to_user, which might     *
 	 * sleep and cannot use a spinlock              */
-	struct semaphore mutex;
+	struct mutex mutex;
 };

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
