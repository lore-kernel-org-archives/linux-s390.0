Return-Path: <linux-kernel-owner+w=401wt.eu-S1755245AbZHNLcg@vger.kernel.org>
Message-Id: <20090814112619.375097062@de.ibm.com>
References: <20090814112517.982007860@de.ibm.com>
Date: Fri, 14 Aug 2009 13:25:46 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 29/34] add call home support
Content-Disposition: inline; filename=128-call-home.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Hans-Joachim Picht <hans@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Hans-Joachim Picht <hans@de.ibm.com>

Signed-off-by: Hans-Joachim Picht <hans@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/sysctl/kernel.txt |   16 ++
 drivers/s390/char/Kconfig       |   10 +
 drivers/s390/char/Makefile      |    1 
 drivers/s390/char/sclp.h        |    4 
 drivers/s390/char/sclp_async.c  |  224 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 254 insertions(+), 1 deletion(-)

Index: quilt-2.6/Documentation/sysctl/kernel.txt
===================================================================
--- quilt-2.6.orig/Documentation/sysctl/kernel.txt
+++ quilt-2.6/Documentation/sysctl/kernel.txt
@@ -19,6 +19,7 @@ Currently, these files might (depending 
 show up in /proc/sys/kernel:
 - acpi_video_flags
 - acct
+- callhome		     [ S390 only ]
 - auto_msgmni
 - core_pattern
 - core_uses_pid
@@ -91,6 +92,21 @@ valid for 30 seconds.
 
 ==============================================================
 
+callhome:
+
+Controls the kernel's callhome behavior in case of a kernel panic.
+
+The s390 hardware allows an operating system to send a notification
+to a service organization (callhome) in case of an operating system panic.
+
+When the value in this file is 0 (which is the default behavior)
+nothing happens in case of a kernel panic. If this value is set to "1"
+the complete kernel oops message is send to the IBM customer service
+organization in case the mainframe the Linux operating system is running
+on has a service contract with IBM.
+
+==============================================================
+
 core_pattern:
 
 core_pattern is used to specify a core dumpfile pattern name.
Index: quilt-2.6/drivers/s390/char/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/s390/char/Kconfig
+++ quilt-2.6/drivers/s390/char/Kconfig
@@ -82,6 +82,16 @@ config SCLP_CPI
 	  You should only select this option if you know what you are doing,
 	  need this feature and intend to run your kernel in LPAR.
 
+config SCLP_ASYNC
+	tristate "Support for Call Home via Asynchronous SCLP Records"
+	depends on S390
+	help
+	  This option enables the call home function, which is able to inform
+	  the service element and connected organisations about a kernel panic.
+	  You should only select this option if you know what you are doing,
+	  want for inform other people about your kernel panics,
+	  need this feature and intend to run your kernel in LPAR.
+
 config S390_TAPE
 	tristate "S/390 tape device support"
 	depends on CCW
Index: quilt-2.6/drivers/s390/char/Makefile
===================================================================
--- quilt-2.6.orig/drivers/s390/char/Makefile
+++ quilt-2.6/drivers/s390/char/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_SCLP_TTY) += sclp_tty.o
 obj-$(CONFIG_SCLP_CONSOLE) += sclp_con.o
 obj-$(CONFIG_SCLP_VT220_TTY) += sclp_vt220.o
 obj-$(CONFIG_SCLP_CPI) += sclp_cpi.o
+obj-$(CONFIG_SCLP_ASYNC) += sclp_async.o
 
 obj-$(CONFIG_ZVM_WATCHDOG) += vmwatchdog.o
 obj-$(CONFIG_VMLOGRDR) += vmlogrdr.o
Index: quilt-2.6/drivers/s390/char/sclp_async.c
===================================================================
--- /dev/null
+++ quilt-2.6/drivers/s390/char/sclp_async.c
@@ -0,0 +1,224 @@
+/*
+ * Enable Asynchronous Notification via SCLP.
+ *
+ * Copyright IBM Corp. 2009
+ * Author(s): Hans-Joachim Picht <hans@linux.vnet.ibm.com>
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/stat.h>
+#include <linux/string.h>
+#include <linux/ctype.h>
+#include <linux/kmod.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/proc_fs.h>
+#include <linux/sysctl.h>
+#include <linux/utsname.h>
+#include "sclp.h"
+
+static int callhome_enabled;
+static struct sclp_req *request;
+static struct sclp_async_sccb *sccb;
+static int sclp_async_send_wait(char *message);
+static struct ctl_table_header *callhome_sysctl_header;
+static DEFINE_SPINLOCK(sclp_async_lock);
+static char nodename[64];
+#define SCLP_NORMAL_WRITE	0x00
+
+struct async_evbuf {
+	struct evbuf_header header;
+	u64 reserved;
+	u8 rflags;
+	u8 empty;
+	u8 rtype;
+	u8 otype;
+	char comp_id[12];
+	char data[3000]; /* there is still some space left */
+} __attribute__((packed));
+
+struct sclp_async_sccb {
+	struct sccb_header header;
+	struct async_evbuf evbuf;
+} __attribute__((packed));
+
+static struct sclp_register sclp_async_register = {
+	.send_mask = EVTYP_ASYNC_MASK,
+};
+
+static int call_home_on_panic(struct notifier_block *self,
+			      unsigned long event, void *data)
+{
+		strncat(data, nodename, strlen(nodename));
+		sclp_async_send_wait(data);
+		return NOTIFY_DONE;
+}
+
+static struct notifier_block call_home_panic_nb = {
+	.notifier_call = call_home_on_panic,
+	.priority = INT_MAX,
+};
+
+static int proc_handler_callhome(ctl_table *ctl, int write, struct file *filp,
+				 void __user *buffer, size_t *count,
+				 loff_t *ppos)
+{
+	unsigned long val;
+	int len, rc;
+	char buf[2];
+
+	if (!*count | (*ppos && !write)) {
+		*count = 0;
+		return 0;
+	}
+	if (!write) {
+		len =  sprintf(buf, "%d\n", callhome_enabled);
+		buf[len] = '\0';
+		rc = copy_to_user(buffer, buf, sizeof(buf));
+		if (rc != 0)
+			return -EFAULT;
+	} else {
+		len = *count;
+		rc = copy_from_user(buf, buffer, sizeof(buf));
+		if (rc != 0)
+			return -EFAULT;
+		if (strict_strtoul(buf, 0, &val) != 0)
+			return -EINVAL;
+		if (val != 0 && val != 1)
+			return -EINVAL;
+		callhome_enabled = val;
+	}
+	*count = len;
+	*ppos += len;
+	return 0;
+}
+
+static struct ctl_table callhome_table[] = {
+	{
+		.procname	= "callhome",
+		.mode		= 0644,
+		.proc_handler	= &proc_handler_callhome,
+	},
+	{ .ctl_name = 0 }
+};
+
+static struct ctl_table kern_dir_table[] = {
+	{
+		.ctl_name	= CTL_KERN,
+		.procname	= "kernel",
+		.maxlen		= 0,
+		.mode		= 0555,
+		.child		= callhome_table,
+	},
+	{ .ctl_name = 0 }
+};
+
+/*
+ * Function used to transfer asynchronous notification
+ * records which waits for send completion
+ */
+static int sclp_async_send_wait(char *message)
+{
+	struct async_evbuf *evb;
+	int rc;
+	unsigned long flags;
+
+	if (!callhome_enabled)
+		return 0;
+	sccb->evbuf.header.type = EVTYP_ASYNC;
+	sccb->evbuf.rtype = 0xA5;
+	sccb->evbuf.otype = 0x00;
+	evb = &sccb->evbuf;
+	request->command = SCLP_CMDW_WRITE_EVENT_DATA;
+	request->sccb = sccb;
+	request->status = SCLP_REQ_FILLED;
+	strncpy(sccb->evbuf.data, message, sizeof(sccb->evbuf.data));
+	/*
+	 * Retain Queue
+	 * e.g. 5639CC140 500 Red Hat RHEL5 Linux for zSeries (RHEL AS)
+	 */
+	strncpy(sccb->evbuf.comp_id, "000000000", sizeof(sccb->evbuf.comp_id));
+	sccb->evbuf.header.length = sizeof(sccb->evbuf);
+	sccb->header.length = sizeof(sccb->evbuf) + sizeof(sccb->header);
+	sccb->header.function_code = SCLP_NORMAL_WRITE;
+	rc = sclp_add_request(request);
+	if (rc)
+		return rc;
+	spin_lock_irqsave(&sclp_async_lock, flags);
+	while (request->status != SCLP_REQ_DONE &&
+		request->status != SCLP_REQ_FAILED) {
+		 sclp_sync_wait();
+	}
+	spin_unlock_irqrestore(&sclp_async_lock, flags);
+	if (request->status != SCLP_REQ_DONE)
+		return -EIO;
+	rc = ((struct sclp_async_sccb *)
+	       request->sccb)->header.response_code;
+	if (rc != 0x0020)
+		return -EIO;
+	if (evb->header.flags != 0x80)
+		return -EIO;
+	return rc;
+}
+
+static int __init sclp_async_init(void)
+{
+	int rc;
+
+	rc = sclp_register(&sclp_async_register);
+	if (rc)
+		return rc;
+	callhome_sysctl_header = register_sysctl_table(kern_dir_table);
+	if (!callhome_sysctl_header) {
+		rc = -ENOMEM;
+		goto out_sclp;
+	}
+	if (!(sclp_async_register.sclp_receive_mask & EVTYP_ASYNC_MASK)) {
+		rc = -EOPNOTSUPP;
+		goto out_sclp;
+	}
+	rc = -ENOMEM;
+	request = kzalloc(sizeof(struct sclp_req), GFP_KERNEL);
+	if (!request)
+		goto out_sys;
+	sccb = (struct sclp_async_sccb *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	if (!sccb)
+		goto out_mem;
+	rc =  atomic_notifier_chain_register(&panic_notifier_list,
+					     &call_home_panic_nb);
+	if (rc)
+		goto out_mem;
+
+	strncpy(nodename, init_utsname()->nodename, 64);
+	return 0;
+
+out_mem:
+	kfree(request);
+	free_page((unsigned long) sccb);
+out_sys:
+	unregister_sysctl_table(callhome_sysctl_header);
+out_sclp:
+	sclp_unregister(&sclp_async_register);
+	return rc;
+
+}
+module_init(sclp_async_init);
+
+static void __exit sclp_async_exit(void)
+{
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+					 &call_home_panic_nb);
+	unregister_sysctl_table(callhome_sysctl_header);
+	sclp_unregister(&sclp_async_register);
+	free_page((unsigned long) sccb);
+	kfree(request);
+}
+module_exit(sclp_async_exit);
+
+MODULE_AUTHOR("Copyright IBM Corp. 2009");
+MODULE_AUTHOR("Hans-Joachim Picht <hans@linux.vnet.ibm.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("SCLP Asynchronous Notification Records");
Index: quilt-2.6/drivers/s390/char/sclp.h
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp.h
+++ quilt-2.6/drivers/s390/char/sclp.h
@@ -27,6 +27,7 @@
 #define EVTYP_VT220MSG		0x1A
 #define EVTYP_CONFMGMDATA	0x04
 #define EVTYP_SDIAS		0x1C
+#define EVTYP_ASYNC		0x0A
 
 #define EVTYP_OPCMD_MASK	0x80000000
 #define EVTYP_MSG_MASK		0x40000000
@@ -38,6 +39,7 @@
 #define EVTYP_VT220MSG_MASK	0x00000040
 #define EVTYP_CONFMGMDATA_MASK	0x10000000
 #define EVTYP_SDIAS_MASK	0x00000010
+#define EVTYP_ASYNC_MASK	0x00400000
 
 #define GNRLMSGFLGS_DOM		0x8000
 #define GNRLMSGFLGS_SNDALRM	0x4000
@@ -85,12 +87,12 @@ struct sccb_header {
 } __attribute__((packed));
 
 extern u64 sclp_facilities;
-
 #define SCLP_HAS_CHP_INFO	(sclp_facilities & 0x8000000000000000ULL)
 #define SCLP_HAS_CHP_RECONFIG	(sclp_facilities & 0x2000000000000000ULL)
 #define SCLP_HAS_CPU_INFO	(sclp_facilities & 0x0800000000000000ULL)
 #define SCLP_HAS_CPU_RECONFIG	(sclp_facilities & 0x0400000000000000ULL)
 
+
 struct gds_subvector {
 	u8	length;
 	u8	key;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
