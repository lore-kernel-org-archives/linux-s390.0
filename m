Return-Path: <linux-kernel-owner+w=401wt.eu-S1755189AbYIKNqr@vger.kernel.org>
Message-Id: <20080911133815.176612777@de.ibm.com>
References: <20080911133538.026764388@de.ibm.com>
Date: Thu, 11 Sep 2008 15:35:42 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 4/4] kmsg: convert vmcp to kmsg api.
Content-Disposition: inline; filename=803-kmsg-vmcp.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Rusty Russell <rusty@rustcorp.com.au>, Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, Joe Perches <joe@perches.com>, Tim Hockin <thockin@hockin.org>, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, =?ISO-8859-15?q?Jochen=20Vo=DF?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>, Jan Blunck <jblunck@suse.de>, Rick Troth <rmt@casita.net>, Utz Bacher <utz.bacher@de.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/vmcp.c |   21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

Index: quilt-2.6/drivers/s390/char/vmcp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/vmcp.c
+++ quilt-2.6/drivers/s390/char/vmcp.c
@@ -17,6 +17,7 @@
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/smp_lock.h>
+#include <linux/kmsg.h>
 #include <asm/cpcmd.h>
 #include <asm/debug.h>
 #include <asm/uaccess.h>
@@ -26,7 +27,7 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Christian Borntraeger <borntraeger@de.ibm.com>");
 MODULE_DESCRIPTION("z/VM CP interface");
 
-#define PRINTK_HEADER "vmcp: "
+#define KMSG_COMPONENT "vmcp"
 
 static debug_info_t *vmcp_debug;
 
@@ -193,7 +194,8 @@ static int __init vmcp_init(void)
 	int ret;
 
 	if (!MACHINE_IS_VM) {
-		PRINT_WARN("z/VM CP interface is only available under z/VM\n");
+		kmsg_warn("The z/VM CP interface device driver cannot be "
+			     "loaded without z/VM\n");
 		return -ENODEV;
 	}
 
@@ -216,6 +218,21 @@ static int __init vmcp_init(void)
 	return 0;
 }
 
+/*?
+ * Tag: vmcp.42661a
+ * Text: "The z/VM CP interface device driver cannot be loaded without z/VM\n"
+ * Severity: Warning
+ * Description:
+ * With the z/VM CP interface you can issue z/VM CP commands from a Linux
+ * terminal session. On Linux instances that run in environments other than
+ * the z/VM hypervisor, the z/VM CP interface does not provide any useful
+ * function and the corresponding vmcp device driver cannot be loaded.
+ * User action:
+ * Load the vmcp device driver only on Linux instances that run as guest
+ * operating systems of the z/VM hypervisor. If the device driver has been
+ * compiled into the kernel, ignore this message.
+ */
+
 static void __exit vmcp_exit(void)
 {
 	misc_deregister(&vmcp_dev);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
