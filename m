Return-Path: <linux-kernel-owner+w=401wt.eu-S1756572AbYIYQqn@vger.kernel.org>
Message-Id: <20080925163019.750494793@de.ibm.com>
References: <20080925162827.818261893@de.ibm.com>
Date: Thu, 25 Sep 2008 18:28:29 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 2/6] kmsg: tagged device messages.
Content-Disposition: inline; filename=801-kmsg-dev.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Rusty Russell <rusty@rustcorp.com.au>, Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, Joe Perches <joe@perches.com>, Tim Hockin <thockin@hockin.org>, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, =?ISO-8859-15?q?Jochen=20Vo=DF?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>, Jan Blunck <jblunck@suse.de>, Rick Troth <rmt@casita.net>, Utz Bacher <utz.bacher@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>
From: Michael Holzheu <holzheu@de.ibm.com>

Add CONFIG_MSG_IDS support to the dev_xxx printk family. The message
tag for a device printk consists of the driver name and the 24 bit
hash over the message text. The hash is included in the printed line
if the KMSG_COMPONENT macro is defined and CONFIG_MSG_IDS=y. For
source files that do not define KMSG_COMPONENT or CONFIG_MSG_IDS=n
the dev_xxx printks use the old-style format. 

To make it possible for a script to extract the correct message tag
for the dev_xxx printks the KMSG_COMPONENT and the driver name need to
be identical for all dev_xxx printks in a source file. If a source file
is supposed to be converted to use message tags and there are dev_xxx
printks with driver names different to KMSG_COMPONENT these dev_xxx
printks need to be replaced with kmsg_xxx printks. In praxis this
should not be a problem since there are very few dev_xxx printks outside
of driver code.

In addition to the KMSG_COMPONENT changes in include/linux/device.h the
dev_xxx macros with variable arguments are converted from the gcc specific
'## arg' to the C99 variant '##__VA_ARGS__'.

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/linux/device.h |   57 ++++++++++++++++++++++++++++++-------------------
 kernel/printk.c        |   22 ++++++++++++++++++
 2 files changed, 57 insertions(+), 22 deletions(-)

Index: kmsg-2.6/include/linux/device.h
===================================================================
--- kmsg-2.6.orig/include/linux/device.h
+++ kmsg-2.6/include/linux/device.h
@@ -520,39 +520,52 @@ extern void sysdev_shutdown(void);
 
 /* debugging and troubleshooting/diagnostic helpers. */
 extern const char *dev_driver_string(const struct device *dev);
-#define dev_printk(level, dev, format, arg...)	\
+#define dev_printk(level, dev, format, ...)	\
 	printk(level "%s %s: " format , dev_driver_string(dev) , \
-	       dev_name(dev) , ## arg)
+	       dev_name(dev) , ##__VA_ARGS__)
 
-#define dev_emerg(dev, format, arg...)		\
-	dev_printk(KERN_EMERG , dev , format , ## arg)
-#define dev_alert(dev, format, arg...)		\
-	dev_printk(KERN_ALERT , dev , format , ## arg)
-#define dev_crit(dev, format, arg...)		\
-	dev_printk(KERN_CRIT , dev , format , ## arg)
-#define dev_err(dev, format, arg...)		\
-	dev_printk(KERN_ERR , dev , format , ## arg)
-#define dev_warn(dev, format, arg...)		\
-	dev_printk(KERN_WARNING , dev , format , ## arg)
-#define dev_notice(dev, format, arg...)		\
-	dev_printk(KERN_NOTICE , dev , format , ## arg)
-#define dev_info(dev, format, arg...)		\
-	dev_printk(KERN_INFO , dev , format , ## arg)
+/* dev_printk_hash for message documentation */
+#if defined(__KMSG_CHECKER) && defined(KMSG_COMPONENT)
+/* generate magic string for scripts/kmsg-doc to parse */
+#define dev_printk_hash(level, dev, format, ...) \
+	__KMSG_DEV(level _FMT_ format _ARGS_ dev, ##__VA_ARGS__ _END_)
+#elif defined(CONFIG_KMSG_IDS) && defined(KMSG_COMPONENT)
+int printk_dev_hash(const char *, const struct device *, const char *, ...);
+#define dev_printk_hash(level, dev, format, ...) \
+	printk_dev_hash(level "%s.%06x: %s: ", dev, format, ##__VA_ARGS__)
+#else /* !defined(CONFIG_KMSG_IDS) */
+#define dev_printk_hash dev_printk
+#endif
+
+#define dev_emerg(dev, format, ...)		\
+	dev_printk_hash(KERN_EMERG , dev , format , ##__VA_ARGS__)
+#define dev_alert(dev, format, ...)		\
+	dev_printk_hash(KERN_ALERT , dev , format , ##__VA_ARGS__)
+#define dev_crit(dev, format, ...)		\
+	dev_printk_hash(KERN_CRIT , dev , format , ##__VA_ARGS__)
+#define dev_err(dev, format, ...)		\
+	dev_printk_hash(KERN_ERR , dev , format , ##__VA_ARGS__)
+#define dev_warn(dev, format, ...)		\
+	dev_printk_hash(KERN_WARNING , dev , format , ##__VA_ARGS__)
+#define dev_notice(dev, format, ...)		\
+	dev_printk_hash(KERN_NOTICE , dev , format , ##__VA_ARGS__)
+#define dev_info(dev, format, ...)		\
+	dev_printk_hash(KERN_INFO , dev , format , ##__VA_ARGS__)
 
 #ifdef DEBUG
-#define dev_dbg(dev, format, arg...)		\
-	dev_printk(KERN_DEBUG , dev , format , ## arg)
+#define dev_dbg(dev, format, ...)		\
+	dev_printk(KERN_DEBUG , dev , format , ##__VA_ARGS__)
 #else
-#define dev_dbg(dev, format, arg...)		\
-	({ if (0) dev_printk(KERN_DEBUG, dev, format, ##arg); 0; })
+#define dev_dbg(dev, format, ...)		\
+	({ if (0) dev_printk(KERN_DEBUG, dev, format, ##__VA_ARGS__); 0; })
 #endif
 
 #ifdef VERBOSE_DEBUG
 #define dev_vdbg	dev_dbg
 #else
 
-#define dev_vdbg(dev, format, arg...)		\
-	({ if (0) dev_printk(KERN_DEBUG, dev, format, ##arg); 0; })
+#define dev_vdbg(dev, format, ...)		\
+	({ if (0) dev_printk(KERN_DEBUG, dev, format, ##__VA_ARGS__); 0; })
 #endif
 
 /* Create alias, so I can be autoloaded. */
Index: kmsg-2.6/kernel/printk.c
===================================================================
--- kmsg-2.6.orig/kernel/printk.c
+++ kmsg-2.6/kernel/printk.c
@@ -1366,4 +1366,26 @@ asmlinkage int printk_hash(const char *p
 	return r;
 }
 EXPORT_SYMBOL(printk_hash);
+
+/**
+ * printk_dev_hash - print a kernel message include a hash over the message
+ * @prefix: message prefix including the ".%06x" for the hash
+ * @dev: device this printk is all about
+ * @fmt: format string
+ */
+asmlinkage int printk_dev_hash(const char *prefix, const struct device *dev,
+			       const char *fmt, ...)
+{
+	va_list args;
+	int r;
+
+	r = printk(prefix, dev_driver_string(dev),
+		   jhash(fmt, strlen(fmt), 0) & 0xffffff, dev_name(dev));
+	va_start(args, fmt);
+	r += vprintk(fmt, args);
+	va_end(args);
+
+	return r;
+}
+EXPORT_SYMBOL(printk_dev_hash);
 #endif

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
