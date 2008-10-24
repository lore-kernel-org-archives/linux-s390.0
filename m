Return-Path: <linux-kernel-owner+w=401wt.eu-S1755373AbYJXPu1@vger.kernel.org>
Date: Fri, 24 Oct 2008 17:50:06 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [GIT PULL/RESEND] kernel message catalog patches
Message-ID: <20081024155006.GA11696@osiris.boeblingen.de.ibm.com>
References: <1224168620.9617.14.camel@localhost> <1224230354.4631.1.camel@localhost> <20081021092148.GB4980@osiris.boeblingen.de.ibm.com> <alpine.LFD.2.00.0810230835150.3287@nehalem.linux-foundation.org> <20081023210446.GA12003@osiris.boeblingen.de.ibm.com> <alpine.LFD.2.00.0810231433380.3287@nehalem.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810231433380.3287@nehalem.linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Oct 23, 2008 at 02:37:24PM -0700, Linus Torvalds wrote:
> On Thu, 23 Oct 2008, Heiko Carstens wrote:
> > Please note that this was initially an s390 only patch set but we moved
> > the infrastructure to generic code since it looks like others want a
> > facility like this too. iirc Andrew requested the move.
> 
> I do agree that it makes no sense as a s390 feature, but quite frankly, 
> I don't think it makes sense AT ALL. It introduces the notion of fixed 
> messages and people now suddenly need to worry about the hashes of the 
> contents etc. Exactly the kind of thing that I don't personally EVER want 
> to see, and certainly not inside the kernel.
> 
> If somebody really wants this, I seriously believe it would be better done 
> as a separate out-of-kernel package. Because I don't think it's worth 
> maintaining those hashed translations in-kernel, and I'm nto going to ask 
> people to even bother.
> 
> But if it's in-kernel, other people are then going to complain about them 
> not being maintained. And quite frankly, I'm neither willing nor 
> interested in hearing those complaints or making them more "valid".

Ok, I agree that if people need to worry about hashes things become more
difficult. Also I don't think keeping the message descriptions external to
the kernel source would be too much of a burden for us.

More background for this patch series: on s390 sys admins want to have
descriptions for kernel messages. They are used to that, because all other
operating systems on that platform like z/OS, z/VM or z/VSE have message
catalogs with detailed descriptions about the semantics of the messages.

So how about if we just merge the infrastructure (= new printk wrappers)
upstream and convert our drivers to use these? The message catalog itself
would be out of the kernel tree and it would be our problem if hashes get
out of sync.

See below for the simple approach. I just added a single converted driver
for ease of review. The patch set is available at:

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git kmsg

Martin Schwidefsky (3):
      [S390] kmsg: tagged kernel messages.
      [S390] kmsg: tagged device messages.
      [S390] kmsg: convert xpram messages to kmsg api.

 arch/s390/Kconfig          |    9 ++++++++
 drivers/s390/block/xpram.c |   41 ++++++++++++++++++---------------------
 include/linux/device.h     |   27 +++++++++++++++++++------
 include/linux/kmsg.h       |   42 ++++++++++++++++++++++++++++++++++++++++
 kernel/printk.c            |   46 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 136 insertions(+), 29 deletions(-)
 create mode 100644 include/linux/kmsg.h

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 70b7645..5566357 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -577,6 +577,15 @@ bool "s390 guest support for KVM (EXPERIMENTAL)"
 	  the KVM hypervisor. This will add detection for KVM as well  as a
 	  virtio transport. If KVM is detected, the virtio console will be
 	  the default console.
+
+config KMSG_IDS
+	bool "Kernel message numbers"
+	default n
+	help
+	  Select this option if you want to include a message number to the
+	  prefix for kernel messages issued by the s390 architecture and
+	  driver code.
+
 endmenu
 
 source "net/Kconfig"
diff --git a/drivers/s390/block/xpram.c b/drivers/s390/block/xpram.c
index 0391698..9bc4ae1 100644
--- a/drivers/s390/block/xpram.c
+++ b/drivers/s390/block/xpram.c
@@ -25,6 +25,8 @@
  *   generic hard disk support to replace ad-hoc partitioning
  */
 
+#define KMSG_COMPONENT "xpram"
+
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/ctype.h>  /* isdigit, isxdigit */
@@ -36,18 +38,13 @@
 #include <linux/hdreg.h>  /* HDIO_GETGEO */
 #include <linux/sysdev.h>
 #include <linux/bio.h>
+#include <linux/kmsg.h>
 #include <asm/uaccess.h>
 
 #define XPRAM_NAME	"xpram"
 #define XPRAM_DEVS	1	/* one partition */
 #define XPRAM_MAX_DEVS	32	/* maximal number of devices (partitions) */
 
-#define PRINT_DEBUG(x...)	printk(KERN_DEBUG XPRAM_NAME " debug:" x)
-#define PRINT_INFO(x...)	printk(KERN_INFO XPRAM_NAME " info:" x)
-#define PRINT_WARN(x...)	printk(KERN_WARNING XPRAM_NAME " warning:" x)
-#define PRINT_ERR(x...)		printk(KERN_ERR XPRAM_NAME " error:" x)
-
-
 typedef struct {
 	unsigned int	size;		/* size of xpram segment in pages */
 	unsigned int	offset;		/* start page of xpram segment */
@@ -264,7 +261,7 @@ static int __init xpram_setup_sizes(unsigned long pages)
 
 	/* Check number of devices. */
 	if (devs <= 0 || devs > XPRAM_MAX_DEVS) {
-		PRINT_ERR("invalid number %d of devices\n",devs);
+		kmsg_err("%d is not a valid number of XPRAM devices\n",devs);
 		return -EINVAL;
 	}
 	xpram_devs = devs;
@@ -295,22 +292,22 @@ static int __init xpram_setup_sizes(unsigned long pages)
 			mem_auto_no++;
 	}
 	
-	PRINT_INFO("  number of devices (partitions): %d \n", xpram_devs);
+	kmsg_info("  number of devices (partitions): %d \n", xpram_devs);
 	for (i = 0; i < xpram_devs; i++) {
 		if (xpram_sizes[i])
-			PRINT_INFO("  size of partition %d: %u kB\n",
-				   i, xpram_sizes[i]);
+			kmsg_info("  size of partition %d: %u kB\n",
+				  i, xpram_sizes[i]);
 		else
-			PRINT_INFO("  size of partition %d to be set "
-				   "automatically\n",i);
+			kmsg_info("  size of partition %d to be set "
+				  "automatically\n",i);
 	}
-	PRINT_DEBUG("  memory needed (for sized partitions): %lu kB\n",
-		    mem_needed);
-	PRINT_DEBUG("  partitions to be sized automatically: %d\n",
-		    mem_auto_no);
+	kmsg_info("  memory needed (for sized partitions): %lu kB\n",
+		  mem_needed);
+	kmsg_info("  partitions to be sized automatically: %d\n",
+		  mem_auto_no);
 
 	if (mem_needed > pages * 4) {
-		PRINT_ERR("Not enough expanded memory available\n");
+		kmsg_err("Not enough expanded memory available\n");
 		return -EINVAL;
 	}
 
@@ -322,8 +319,8 @@ static int __init xpram_setup_sizes(unsigned long pages)
 	 */
 	if (mem_auto_no) {
 		mem_auto = ((pages - mem_needed / 4) / mem_auto_no) * 4;
-		PRINT_INFO("  automatically determined "
-			   "partition size: %lu kB\n", mem_auto);
+		kmsg_info("  automatically determined "
+			  "partition size: %lu kB\n", mem_auto);
 		for (i = 0; i < xpram_devs; i++)
 			if (xpram_sizes[i] == 0)
 				xpram_sizes[i] = mem_auto;
@@ -405,12 +402,12 @@ static int __init xpram_init(void)
 
 	/* Find out size of expanded memory. */
 	if (xpram_present() != 0) {
-		PRINT_WARN("No expanded memory available\n");
+		kmsg_err("No expanded memory available\n");
 		return -ENODEV;
 	}
 	xpram_pages = xpram_highest_page_index() + 1;
-	PRINT_INFO("  %u pages expanded memory found (%lu KB).\n",
-		   xpram_pages, (unsigned long) xpram_pages*4);
+	kmsg_info("  %u pages expanded memory found (%lu KB).\n",
+		  xpram_pages, (unsigned long) xpram_pages*4);
 	rc = xpram_setup_sizes(xpram_pages);
 	if (rc)
 		return rc;
diff --git a/include/linux/device.h b/include/linux/device.h
index 1a3686d..588cf90 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -538,20 +538,33 @@ extern const char *dev_driver_string(const struct device *dev);
 	printk(level "%s %s: " format , dev_driver_string(dev) , \
 	       dev_name(dev) , ## arg)
 
+/* dev_printk_hash for message documentation */
+#if defined(__KMSG_CHECKER) && defined(KMSG_COMPONENT)
+/* generate magic string for scripts/kmsg-doc to parse */
+#define dev_printk_hash(level, dev, format, arg...) \
+	__KMSG_DEV(level _FMT_ format _ARGS_ dev, ## arg _END_)
+#elif defined(CONFIG_KMSG_IDS) && defined(KMSG_COMPONENT)
+int printk_dev_hash(const char *, const struct device *, const char *, ...);
+#define dev_printk_hash(level, dev, format, arg...) \
+	printk_dev_hash(level "%s.%06x: %s: ", dev, format, ## arg)
+#else /* !defined(CONFIG_KMSG_IDS) */
+#define dev_printk_hash dev_printk
+#endif
+
 #define dev_emerg(dev, format, arg...)		\
-	dev_printk(KERN_EMERG , dev , format , ## arg)
+	dev_printk_hash(KERN_EMERG , dev , format , ## arg)
 #define dev_alert(dev, format, arg...)		\
-	dev_printk(KERN_ALERT , dev , format , ## arg)
+	dev_printk_hash(KERN_ALERT , dev , format , ## arg)
 #define dev_crit(dev, format, arg...)		\
-	dev_printk(KERN_CRIT , dev , format , ## arg)
+	dev_printk_hash(KERN_CRIT , dev , format , ## arg)
 #define dev_err(dev, format, arg...)		\
-	dev_printk(KERN_ERR , dev , format , ## arg)
+	dev_printk_hash(KERN_ERR , dev , format , ## arg)
 #define dev_warn(dev, format, arg...)		\
-	dev_printk(KERN_WARNING , dev , format , ## arg)
+	dev_printk_hash(KERN_WARNING , dev , format , ## arg)
 #define dev_notice(dev, format, arg...)		\
-	dev_printk(KERN_NOTICE , dev , format , ## arg)
+	dev_printk_hash(KERN_NOTICE , dev , format , ## arg)
 #define dev_info(dev, format, arg...)		\
-	dev_printk(KERN_INFO , dev , format , ## arg)
+	dev_printk_hash(KERN_INFO , dev , format , ## arg)
 
 #if defined(CONFIG_DYNAMIC_PRINTK_DEBUG)
 #define dev_dbg(dev, format, ...) do { \
diff --git a/include/linux/kmsg.h b/include/linux/kmsg.h
new file mode 100644
index 0000000..d356f77
--- /dev/null
+++ b/include/linux/kmsg.h
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
diff --git a/kernel/printk.c b/kernel/printk.c
index 6341af7..7c10b5b 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -32,6 +32,8 @@
 #include <linux/security.h>
 #include <linux/bootmem.h>
 #include <linux/syscalls.h>
+#include <linux/jhash.h>
+#include <linux/device.h>
 
 #include <asm/uaccess.h>
 
@@ -1341,3 +1343,47 @@ bool printk_timed_ratelimit(unsigned long *caller_jiffies,
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
+#endif
