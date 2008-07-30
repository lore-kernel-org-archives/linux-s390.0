Return-Path: <linux-kernel-owner+w=401wt.eu-S1759831AbYG3RMh@vger.kernel.org>
Message-Id: <20080730171156.824640459@de.ibm.com>
References: <20080730165656.118280544@de.ibm.com>
Date: Wed, 30 Jul 2008 18:56:57 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 1/3] kmsg: Kernel message catalog macros.
Content-Disposition: inline; filename=800-kmsg-macros.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, Joe Perches <joe@perches.com>, =?ISO-8859-15?q?Jochen=20Vo=DF?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Introduce a new family of printk macros which prefixes each kmsg message
with a component name and allows to tag the printk with a message id.

The kmsg component name is defined per source file with the KMSG_COMPONENT
macro. The first argument of each kmsg printk is the message id. The
message id "0" is special as it will suppress the message id prefix.

If the message id will be printed to the console / syslog at all depends
on CONFIG_MSG_IDS. If it is "n" then a kmsg_xxx call is just another
printk wrapper. These macros are intended to be used uniformly in the
s390 architecture and the s390 device drivers.

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Kconfig    |    9 +++
 include/linux/kmsg.h |  124 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+)

Index: linux-2.6/arch/s390/Kconfig
===================================================================
--- linux-2.6.orig/arch/s390/Kconfig
+++ linux-2.6/arch/s390/Kconfig
@@ -568,6 +568,15 @@ bool "s390 guest support (EXPERIMENTAL)"
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
Index: linux-2.6/include/linux/kmsg.h
===================================================================
--- /dev/null
+++ linux-2.6/include/linux/kmsg.h
@@ -0,0 +1,124 @@
+#ifndef _LINUX_KMSG_H
+#define _LINUX_KMSG_H
+
+#ifndef __KMSG_CHECKER
+#define __KMSG_CHECK(level, id) KERN_##level
+#endif
+
+#if defined(__KMSG_CHECKER) || !defined(CONFIG_KMSG_IDS)
+
+#define kmsg_dev_alert(id, dev, format, arg...) \
+	printk(__KMSG_CHECK(ALERT, id) KMSG_COMPONENT \
+		": %s: " format, (dev)->bus_id , ## arg)
+
+#define kmsg_dev_err(id, dev, format, arg...) \
+	printk(__KMSG_CHECK(ERR, id) KMSG_COMPONENT \
+		": %s: " format, (dev)->bus_id , ## arg)
+
+#define kmsg_dev_warn(id, dev, format, arg...) \
+	printk(__KMSG_CHECK(WARNING, id) KMSG_COMPONENT \
+		": %s: " format, (dev)->bus_id , ## arg)
+
+#define kmsg_dev_info(id, dev, format, arg...) \
+	printk(__KMSG_CHECK(INFO, id) KMSG_COMPONENT \
+		": %s: " format, (dev)->bus_id , ## arg)
+
+#define kmsg_dev_notice(id, dev, format, arg...) \
+	printk(__KMSG_CHECK(NOTICE, id) KMSG_COMPONENT \
+		": %s: " format, (dev)->bus_id , ## arg)
+
+#define kmsg_alert(id, format, arg...) \
+	printk(__KMSG_CHECK(ALERT, id) KMSG_COMPONENT \
+		": " format, ## arg)
+
+#define kmsg_err(id, format, arg...) \
+	printk(__KMSG_CHECK(ERR, id) KMSG_COMPONENT \
+		": " format, ## arg)
+
+#define kmsg_warn(id, format, arg...) \
+	printk(__KMSG_CHECK(WARNING, id) KMSG_COMPONENT \
+		": " format, ## arg)
+
+#define kmsg_info(id, format, arg...) \
+	printk(__KMSG_CHECK(INFO, id) KMSG_COMPONENT \
+		": " format, ## arg)
+
+#define kmsg_notice(id, format, arg...) \
+	printk(__KMSG_CHECK(NOTICE, id) KMSG_COMPONENT \
+		": " format, ## arg)
+
+#else  /* __KMSG_CHECKER || !CONFIG_KMSG_IDS */
+
+#define kmsg_dev_alert(id, dev, format, arg...) \
+	(__builtin_constant_p(id) && (id) > 0) ? \
+		printk(__KMSG_CHECK(ALERT, id) KMSG_COMPONENT \
+			"." #id ": %s: " format, (dev)->bus_id , ## arg) : \
+		printk(__KMSG_CHECK(ALERT, id) KMSG_COMPONENT \
+			": %s: " format, (dev)->bus_id , ## arg)
+
+#define kmsg_dev_err(id, dev, format, arg...) \
+	(__builtin_constant_p(id) && (id) > 0) ? \
+		printk(__KMSG_CHECK(ERR, id) KMSG_COMPONENT \
+			"." #id ": %s: " format, (dev)->bus_id , ## arg) : \
+		printk(__KMSG_CHECK(ERR, id) KMSG_COMPONENT \
+			": %s: " format, (dev)->bus_id , ## arg)
+
+#define kmsg_dev_warn(id, dev, format, arg...) \
+	(__builtin_constant_p(id) && (id) > 0) ? \
+		printk(__KMSG_CHECK(WARNING, id) KMSG_COMPONENT \
+			"." #id ": %s: " format, (dev)->bus_id , ## arg) : \
+		printk(__KMSG_CHECK(WARNING, id) KMSG_COMPONENT \
+			": %s: " format, (dev)->bus_id , ## arg)
+
+#define kmsg_dev_info(id, dev, format, arg...) \
+	(__builtin_constant_p(id) && (id) > 0) ? \
+		printk(__KMSG_CHECK(INFO, id) KMSG_COMPONENT \
+			"." #id ": %s: " format, (dev)->bus_id , ## arg) : \
+		printk(__KMSG_CHECK(INFO, id) KMSG_COMPONENT \
+			": %s: " format, (dev)->bus_id , ## arg)
+
+#define kmsg_dev_notice(id, dev, format, arg...) \
+	(__builtin_constant_p(id) && (id) > 0) ? \
+		printk(__KMSG_CHECK(NOTICE, id) KMSG_COMPONENT \
+			"." #id ": %s: " format, (dev)->bus_id , ## arg) : \
+		printk(__KMSG_CHECK(NOTICE, id) KMSG_COMPONENT \
+			": %s: " format, (dev)->bus_id , ## arg)
+
+#define kmsg_alert(id, format, arg...) \
+	(__builtin_constant_p(id) && (id) > 0) ? \
+		printk(__KMSG_CHECK(ALERT, id) KMSG_COMPONENT \
+			"." #id ": " format, ## arg) : \
+		printk(__KMSG_CHECK(ALERT, id) KMSG_COMPONENT \
+			": " format, ## arg)
+
+#define kmsg_err(id, format, arg...) \
+	(__builtin_constant_p(id) && (id) > 0) ? \
+		printk(__KMSG_CHECK(ERR, id) KMSG_COMPONENT \
+			"." #id ": " format, ## arg) : \
+		printk(__KMSG_CHECK(ERR, id) KMSG_COMPONENT \
+			": " format, ## arg)
+
+#define kmsg_warn(id, format, arg...) \
+	(__builtin_constant_p(id) && (id) > 0) ? \
+		printk(__KMSG_CHECK(WARNING, id) KMSG_COMPONENT \
+			"." #id ": " format, ## arg) : \
+		printk(__KMSG_CHECK(WARNING, id) KMSG_COMPONENT \
+			": " format, ## arg)
+
+#define kmsg_info(id, format, arg...) \
+	(__builtin_constant_p(id) && (id) > 0) ? \
+		printk(__KMSG_CHECK(INFO, id) KMSG_COMPONENT \
+			"." #id ": " format, ## arg) : \
+		printk(__KMSG_CHECK(INFO, id) KMSG_COMPONENT \
+			": " format, ## arg)
+
+#define kmsg_notice(id, format, arg...) \
+	(__builtin_constant_p(id) && (id) > 0) ? \
+		printk(__KMSG_CHECK(NOTICE, id) KMSG_COMPONENT \
+			"." #id ": " format, ## arg) : \
+		printk(__KMSG_CHECK(NOTICE, id) KMSG_COMPONENT \
+			": " format, ## arg)
+
+#endif /* __KMSG_CHECKER || !CONFIG_KMSG_IDS */
+
+#endif /* _LINUX_KMSG_H */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
