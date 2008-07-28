Return-Path: <linux-kernel-owner+w=401wt.eu-S1758495AbYG1R7c@vger.kernel.org>
Message-Id: <20080728175511.759269403@de.ibm.com>
References: <20080728175355.734299984@de.ibm.com>
Date: Mon, 28 Jul 2008 19:53:59 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 04/15] kmsg: convert vmcp to kmsg api.
Content-Disposition: inline; filename=803-kmsg-vmcp.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/s390/kmsg/vmcp |   15 +++++++++++++++
 drivers/s390/char/vmcp.c     |    6 ++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

Index: quilt-2.6/Documentation/s390/kmsg/vmcp
===================================================================
--- /dev/null
+++ quilt-2.6/Documentation/s390/kmsg/vmcp
@@ -0,0 +1,15 @@
+/*?
+ * Tag: vmcp.1
+ * Text: "The z/VM CP interface device driver cannot be loaded without z/VM"
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
Index: quilt-2.6/drivers/s390/char/vmcp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/vmcp.c
+++ quilt-2.6/drivers/s390/char/vmcp.c
@@ -19,6 +19,7 @@
 #include <linux/smp_lock.h>
 #include <asm/cpcmd.h>
 #include <asm/debug.h>
+#include <asm/kmsg.h>
 #include <asm/uaccess.h>
 #include "vmcp.h"
 
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
+		kmsg_warn(1, "The z/VM CP interface device driver cannot be "
+			     "loaded without z/VM\n");
 		return -ENODEV;
 	}
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
