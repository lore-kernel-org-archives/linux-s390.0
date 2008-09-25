Return-Path: <linux-kernel-owner+w=401wt.eu-S1756442AbYIYQqa@vger.kernel.org>
Message-Id: <20080925163019.210654702@de.ibm.com>
References: <20080925162827.818261893@de.ibm.com>
Date: Thu, 25 Sep 2008 18:28:28 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 1/6] kmsg: tagged kernel messages.
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
the KMSG_COMPONENT macro. In order to use the kmsg_xxx macros KMSG_COMPONENT
has to be defined.

If the message hash will be printed to the console / syslog at all depends
on CONFIG_MSG_IDS. If it is "n" then a kmsg_xxx call is just another
printk wrapper. These macros are intended to be used uniformly in the
s390 architecture and the s390 device drivers.

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Kconfig    |    9 +++++++++
 include/linux/kmsg.h |   42 ++++++++++++++++++++++++++++++++++++++++++
 kernel/printk.c      |   24 ++++++++++++++++++++++++
 3 files changed, 75 insertions(+)

Index: kmsg-2.6/arch/s390/Kconfig
===================================================================
--- kmsg-2.6.orig/arch/s390/Kconfig
+++ kmsg-2.6/arch/s390/Kconfig
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
Index: kmsg-2.6/include/linux/kmsg.h
===================================================================
--- /dev/null
+++ kmsg-2.6/include/linux/kmsg.h
@@ -0,0 +1,42 @@
+#ifndef _LINUX_KMSG_H
+#define _LINUX_KMSG_H
+
+#define kmsg_printk(level, format, ...) \
+	printk(level KMSG_COMPONENT  ": " format, ##__VA_ARGS__)
+
+#if defined(__KMSG_CHECKER)
+/* generate magic string for scripts/kmsg-doc to parse */
+#define kmsg_printk_hash(level, format, ...) \
+	__KMSG_PRINT(level _FMT_ format _ARGS_ ##__VA_ARGS__ _END_)
+#elif defined(CONFIG_KMSG_IDS)
+int printk_hash(const char *, const char *, ...);
+#define kmsg_printk_hash(level, format, ...) \
+	printk_hash(level KMSG_COMPONENT ".%06x" ": ", format, ##__VA_ARGS__)
+#else /* !defined(CONFIG_KMSG_IDS) */
+#define kmsg_printk_hash kmsg_printk
+#endif
+
+#define kmsg_emerg(fmt, ...) \
+	kmsg_printk_hash(KERN_EMERG, fmt, ##__VA_ARGS__)
+#define kmsg_alert(fmt, ...) \
+	kmsg_printk_hash(KERN_ALERT, fmt, ##__VA_ARGS__)
+#define kmsg_crit(fmt, ...) \
+	kmsg_printk_hash(KERN_CRIT, fmt, ##__VA_ARGS__)
+#define kmsg_err(fmt, ...) \
+	kmsg_printk_hash(KERN_ERR, fmt, ##__VA_ARGS__)
+#define kmsg_warn(fmt, ...) \
+	kmsg_printk_hash(KERN_WARNING, fmt, ##__VA_ARGS__)
+#define kmsg_notice(fmt, ...) \
+	kmsg_printk_hash(KERN_NOTICE, fmt, ##__VA_ARGS__)
+#define kmsg_info(fmt, ...) \
+	kmsg_printk_hash(KERN_INFO, fmt, ##__VA_ARGS__)
+
+#ifdef DEBUG
+#define kmsg_dbg(fmt, ...) \
+	kmsg_printk(KERN_DEBUG, fmt, ##__VA_ARGS__)
+#else
+#define kmsg_dbg(fmt, ...) \
+	({ if (0) kmsg_printk(KERN_DEBUG, fmt, ##__VA_ARGS__); 0; })
+#endif
+
+#endif /* _LINUX_KMSG_H */
Index: kmsg-2.6/kernel/printk.c
===================================================================
--- kmsg-2.6.orig/kernel/printk.c
+++ kmsg-2.6/kernel/printk.c
@@ -32,6 +32,8 @@
 #include <linux/security.h>
 #include <linux/bootmem.h>
 #include <linux/syscalls.h>
+#include <linux/jhash.h>
+#include <linux/device.h>
 
 #include <asm/uaccess.h>
 
@@ -1343,3 +1345,25 @@ bool printk_timed_ratelimit(unsigned lon
 }
 EXPORT_SYMBOL(printk_timed_ratelimit);
 #endif
+
+#if defined CONFIG_PRINTK && defined CONFIG_KMSG_IDS
+
+/**
+ * printk_hash - print a kernel message include a hash over the message
+ * @prefix: message prefix including the ".%06x" for the hash
+ * @fmt: format string
+ */
+asmlinkage int printk_hash(const char *prefix, const char *fmt, ...)
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
+EXPORT_SYMBOL(printk_hash);
+#endif

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
