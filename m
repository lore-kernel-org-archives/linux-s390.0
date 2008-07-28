Return-Path: <linux-kernel-owner+w=401wt.eu-S1760046AbYG1R43@vger.kernel.org>
Message-Id: <20080728175511.989025821@de.ibm.com>
References: <20080728175355.734299984@de.ibm.com>
Date: Mon, 28 Jul 2008 19:54:00 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 05/15] kmsg: convert cpcmd to kmsg api.
Content-Disposition: inline; filename=804-kmsg-cpcmd.diff
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

 Documentation/s390/kmsg/cpcmd |   18 ++++++++++++++++++
 arch/s390/kernel/cpcmd.c      |    7 +++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

Index: quilt-2.6/arch/s390/kernel/cpcmd.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/cpcmd.c
+++ quilt-2.6/arch/s390/kernel/cpcmd.c
@@ -15,9 +15,12 @@
 #include <linux/string.h>
 #include <asm/ebcdic.h>
 #include <asm/cpcmd.h>
+#include <asm/kmsg.h>
 #include <asm/system.h>
 #include <asm/io.h>
 
+#define KMSG_COMPONENT "cpcmd"
+
 static DEFINE_SPINLOCK(cpcmd_lock);
 static char cpcmd_buf[241];
 
@@ -104,8 +107,8 @@ int cpcmd(const char *cmd, char *respons
 			(((unsigned long)response + rlen) >> 31)) {
 		lowbuf = kmalloc(rlen, GFP_KERNEL | GFP_DMA);
 		if (!lowbuf) {
-			printk(KERN_WARNING
-				"cpcmd: could not allocate response buffer\n");
+			kmsg_warn(1, "The cpcmd kernel function failed to "
+				     "allocate a response buffer\n");
 			return -ENOMEM;
 		}
 		spin_lock_irqsave(&cpcmd_lock, flags);
Index: quilt-2.6/Documentation/s390/kmsg/cpcmd
===================================================================
--- /dev/null
+++ quilt-2.6/Documentation/s390/kmsg/cpcmd
@@ -0,0 +1,18 @@
+/*?
+ * Text: "The cpcmd kernel function failed to allocate a response buffer"
+ * Tag: cpcmd.1
+ * Severity: Warning
+ * Description:
+ * IPL code, console detection, and device drivers like vmcp or vmlogrdr use
+ * the cpcmd kernel function to send commands to the z/VM control program (CP).
+ * If a program that uses the cpcmd function does not allocate a contiguous
+ * response buffer below 2 GB guest real storage, cpcmd creates a bounce buffer
+ * to be used as the response buffer. Because of low memory or memory
+ * fragmentation, cpcmd could not create the bounce buffer.
+ * User action:
+ * Look for related page allocation failure messages and at the stack trace to
+ * find out which program or operation failed. Free some memory and retry the
+ * failed operation. Consider allocating more memory to your z/VM guest virtual
+ * machine.
+ */
+

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
