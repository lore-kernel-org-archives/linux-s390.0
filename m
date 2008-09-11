Return-Path: <linux-kernel-owner+w=401wt.eu-S1754066AbYIKNpc@vger.kernel.org>
Message-Id: <20080911133813.858636188@de.ibm.com>
References: <20080911133538.026764388@de.ibm.com>
Date: Thu, 11 Sep 2008 15:35:39 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 1/4] kmsg: Kernel message catalog macros.
Content-Disposition: inline; filename=800-kmsg-macros.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Rusty Russell <rusty@rustcorp.com.au>, Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, Joe Perches <joe@perches.com>, Tim Hockin <thockin@hockin.org>, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, =?ISO-8859-15?q?Jochen=20Vo=DF?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>, Jan Blunck <jblunck@suse.de>, Rick Troth <rmt@casita.net>, Utz Bacher <utz.bacher@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>
From: Michael Holzheu <holzheu@de.ibm.com>

Introduce a new family of printk macros which prefixes each kmsg message
with a component name and allows to tag the message with a 24 bit hash of
the message text. The kmsg component name is defined per source file with
the KMSG_COMPONENT macro.

If the message hash will be printed to the console / syslog at all depends
on CONFIG_MSG_IDS. If it is "n" then a kmsg_xxx call is just another
printk wrapper. These macros are intended to be used uniformly in the
s390 architecture and the s390 device drivers.

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Kconfig    |    9 ++++++++
 include/linux/kmsg.h |   54 +++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/printk.c      |   24 ++++++++++++++++++++++
 3 files changed, 87 insertions(+)

Index: quilt-2.6/arch/s390/Kconfig
===================================================================
--- quilt-2.6.orig/arch/s390/Kconfig
+++ quilt-2.6/arch/s390/Kconfig
@@ -571,6 +571,15 @@ bool "s390 guest support (EXPERIMENTAL)"
 	select VIRTIO_CONSOLE
 	help
 	  Select this option if you want to run the kernel under s390 linux
+
+config KMSG_IDS
+	bool "Kernel message numbers"
+	default y
+	help
+	  Select this option if you want to include a message number to the
+	  prefix for kernel messages issued by the s390 architecture and
+	  driver code. See "Documentation/s390/kmsg.txt" for more details.
+
 endmenu
 
 source "net/Kconfig"
Index: quilt-2.6/include/linux/kmsg.h
===================================================================
--- /dev/null
+++ quilt-2.6/include/linux/kmsg.h
@@ -0,0 +1,54 @@
+#ifndef _LINUX_KMSG_H
+#define _LINUX_KMSG_H
+
+int kmsg_printk(char *prefix, char *fmt, ...);
+
+#if defined(__KMSG_CHECKER)
+#define KMSG_ID KMSG_COMPONENT ".%06x"
+#define KMSG_FMT(fmt) _$_(fmt)_$_
+#define kmsg_printk __KMSG_CHECK
+#elif defined(CONFIG_KMSG_IDS)
+#define KMSG_ID KMSG_COMPONENT ".%06x"
+#define KMSG_FMT(fmt) fmt
+#else /* !defined(CONFIG_KMSG_IDS) */
+#define KMSG_ID KMSG_COMPONENT
+#define KMSG_FMT(fmt) fmt
+#define kmsg_printk(prefix, fmt, ...) printk(prefix # fmt, ##__VA_ARGS__)
+#endif
+
+#define kmsg_alert(fmt, ...) \
+	kmsg_printk(KERN_ALERT KMSG_ID ": ", KMSG_FMT(fmt), ##__VA_ARGS__)
+
+#define kmsg_err(fmt, ...) \
+	kmsg_printk(KERN_ERR KMSG_ID ": ", KMSG_FMT(fmt), ##__VA_ARGS__)
+
+#define kmsg_warn(fmt, ...) \
+	kmsg_printk(KERN_WARNING KMSG_ID ": ", KMSG_FMT(fmt), ##__VA_ARGS__)
+
+#define kmsg_info(fmt, ...) \
+	kmsg_printk(KERN_INFO KMSG_ID ": ", KMSG_FMT(fmt), ##__VA_ARGS__)
+
+#define kmsg_notice(fmt, ...) \
+	kmsg_printk(KERN_NOTICE KMSG_ID ": ", KMSG_FMT(fmt), ##__VA_ARGS__)
+
+#define kmsg_dev_alert(dev, fmt, ...) \
+	kmsg_printk(KERN_ALERT KMSG_ID ":%s: ", KMSG_FMT(fmt), \
+		    dev_name(dev), ##__VA_ARGS__)
+
+#define kmsg_dev_err(dev, fmt, ...) \
+	kmsg_printk(KERN_ERR KMSG_ID ":%s: ", KMSG_FMT(fmt), \
+		    dev_name(dev), ##__VA_ARGS__)
+
+#define kmsg_dev_warn(dev, fmt, ...) \
+	kmsg_printk(KERN_WARNING KMSG_ID ":%s: ", KMSG_FMT(fmt), \
+		    dev_name(dev), ##__VA_ARGS__)
+
+#define kmsg_dev_info(dev, fmt, ...) \
+	kmsg_printk(KERN_INFO KMSG_ID ":%s: ", KMSG_FMT(fmt), \
+		    dev_name(dev), ##__VA_ARGS__)
+
+#define kmsg_dev_notice(dev, fmt, ...) \
+	kmsg_printk(KERN_NOTICE KMSG_ID ":%s: ", KMSG_FMT(fmt), \
+		    dev_name(dev), ##__VA_ARGS__)
+
+#endif /* _LINUX_KMSG_H */
Index: quilt-2.6/kernel/printk.c
===================================================================
--- quilt-2.6.orig/kernel/printk.c
+++ quilt-2.6/kernel/printk.c
@@ -32,6 +32,7 @@
 #include <linux/security.h>
 #include <linux/bootmem.h>
 #include <linux/syscalls.h>
+#include <linux/jhash.h>
 
 #include <asm/uaccess.h>
 
@@ -1343,3 +1344,26 @@ bool printk_timed_ratelimit(unsigned lon
 }
 EXPORT_SYMBOL(printk_timed_ratelimit);
 #endif
+
+#if defined CONFIG_PRINTK && defined CONFIG_KMSG_IDS
+
+/**
+ * kmsg_printk - print a kernel message with a message id
+ * @fmt: format string
+ * @hfmt: revelant part of the format string included in the hash
+ */
+asmlinkage int kmsg_printk(const char *prefix, const char *fmt, ...)
+{
+	va_list args;
+	int r;
+
+	r = printk(prefix, jhash(fmt, strlen(fmt), 0) & 0xffffff);
+	va_start(args, fmt);
+	r += vprintk(fmt, args);
+	va_end(args);
+
+	return r;
+}
+EXPORT_SYMBOL(kmsg_printk);
+
+#endif

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
