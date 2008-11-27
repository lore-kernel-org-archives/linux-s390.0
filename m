Return-Path: <linux-kernel-owner+w=401wt.eu-S1756231AbYK0Ksy@vger.kernel.org>
Message-Id: <20081127103144.336918316@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:31:19 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 59/60] provide documentation for hvc_iucv printk & kernel parameter.
Content-Disposition: inline; filename=174-kmsg-iucv-hvc.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/kernel-parameters.txt |    3 ++
 Documentation/kmsg/s390/hvc_iucv    |   50 ++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

Index: quilt-2.6/Documentation/kernel-parameters.txt
===================================================================
--- quilt-2.6.orig/Documentation/kernel-parameters.txt
+++ quilt-2.6/Documentation/kernel-parameters.txt
@@ -811,6 +811,9 @@ and is between 256 and 4096 characters. 
 
 	hlt		[BUGS=ARM,SH]
 
+	hvc_iucv=	[S390] Number of z/VM IUCV Hypervisor console (HVC)
+			       back-ends. Valid parameters: 0..8
+
 	i8042.debug	[HW] Toggle i8042 debug mode
 	i8042.direct	[HW] Put keyboard port into non-translated mode
 	i8042.dumbkbd	[HW] Pretend that controller can only read data from
Index: quilt-2.6/Documentation/kmsg/s390/hvc_iucv
===================================================================
--- /dev/null
+++ quilt-2.6/Documentation/kmsg/s390/hvc_iucv
@@ -0,0 +1,50 @@
+/*?
+ * Text: "The z/VM IUCV Hypervisor console cannot be used without z/VM.\n"
+ * Severity: Warning
+ * Description:
+ * On Linux instances that run in environments other than the z/VM hypervisor,
+ * z/VM IUCV is not available and the z/VM IUCV Hypervisor console cannot be
+ * used.
+ * User action:
+ * If the system does not run on a z/VM guest virtual machine,
+ * ignore this message.
+ */
+
+/*?
+ * Text: "Could not create new z/VM IUCV HVC backend rc=%d.\n"
+ * Severity: Error
+ * Parameter:
+ *   @1: Return code of the operation that has failed.
+ * Description:
+ * The driver initialization has failed to allocate a new z/VM IUCV HVC
+ * back-end. A common cause might be that there are not sufficient memory
+ * available.
+ * User action:
+ * Enure that the z/VM guest virtual machine has sufficient memory.
+ */
+
+/*?
+ * Text: "Could not register iucv handler (rc=%d).\n"
+ * Severity: Error
+ * Parameter:
+ *   @1: Return code from the IUCV registration.
+ * Description:
+ * The driver initialization has failed to register its z/VM IUCV callbacks to
+ * handle z/VM IUCV connections, and sending/receiving of IUCV messages.
+ * User action:
+ * Typically there might be additional IUCV error messages at the Linux kernel
+ * startup. Check the system log files.
+ */
+
+/*?
+ * Text: "Not enough memory for driver initialization (rs=%d).\n"
+ * Severity: Error
+ * Parameter:
+ *   @1: Memory allocation has failed: 1 = kmem_cache; and 2 = mempool.
+ * Description:
+ * The z/VM IUCV Hypervisor console back-end initialization has faild, because
+ * of a general memory allocation failure.
+ * User action:
+ * Ensure that the z/VM guest virtual machine has sufficient memory.
+ * See the your Linux distributor manuals for minimum system requirements.
+ */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
