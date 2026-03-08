Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849DE33C50D
	for <linux-s390@vger.kernel.org>; Sun,  8 Mar 2026 10:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772965978; cv=none; b=oUk87g89ZMEOXqFHNhdmrdU72mVhEqSv/1XdnY9VnJwKKJoNPDJ+WxkFZGuY5fgiZdugABmYDbfNWjRpvcfNvdkH66uPMKZgBMKW9DMFU6DDh/tsyE5CtMDpeuXMRAIA+P2qULB2FDTG8+ln2eVDadpl5n0rNCmu7/lA8Tv5KsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772965978; c=relaxed/simple;
	bh=yxHji1MpNiqy3ttcGULqDjLH491+GAZJ+oICAuuNZAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d6AQpmlAeawNKt92k0rhWnmcDfkQqwRl4BjQVZY1JPyYdwZtwebzagHGO2mmZXFgMIFw63oVVZ92H0I47qya42hbEHG92wBk3ZdYKCqSZQk3F8HX7b2n5SGflWXYIYSqPpytoII5y50xYl4ls5S3IkinuAeoTDU7EVjAaiydvfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=lUfPrGbD; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="lUfPrGbD"
X-KPN-MessageId: 25f401f7-1ada-11f1-bea1-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 25f401f7-1ada-11f1-bea1-005056992ed3;
	Sun, 08 Mar 2026 11:32:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=w+wDqiHnJeMwV8v3lDZnHyjldXD3ULnCRklwps9gVGA=;
	b=lUfPrGbD9l/9GxzKREbAUV5Q138dWDrv4eXpz1BgTIJntTTV3YfW5kSchS0zwxtdWdRYe1Gnf5uPm
	 m08SkpSc5lg29IFPNvQBw8x/9178BzT8Yw74kGE9pN8f2X4PwVhjGzDPCdjhxj6GjxNBOKsHExbQlW
	 875LyPTFX9tvTHQzBfb9mlVGZ3i4knlSEwLesKPMHTVf9M0mQZh3Qz9wFrnhdmP9bIcK/K4tA9g9qr
	 vKyZ/gByIOVNC+5b0PT7ses0QkIwzBHsBhSst7agn3Va2nRbxo9U0h7yJPNP3Ba3cBz6+wqOhDhe7Y
	 ZymS9ab9GRL3C6xLuc0haWcmIz2B/EA==
X-KPN-MID: 33|6PvBCnvOVJSvsQh7od1VN+94NTZjTB+T3xeoYwi4/SzE6AQvMuRow9YRflf6Ti3
 OFsYr3zEWLIpkeGRV+/S0etUIF1EuLkcPk0EqcTnfaS0=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|YBptwsUK+K2mNX3bZ6n9crPqP+N0Yh6ucxOMTPpUdn2b1vtrvEHRV5QDqeHLExc
 9S6GupGBgoiJ06cPC0CU9yg==
Received: from daedalus.home (unknown [178.229.45.71])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 22587df4-1ada-11f1-86d4-005056998788;
	Sun, 08 Mar 2026 11:32:46 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: gregkh@linuxfoundation.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-s390@vger.kernel.org (open list:S390 ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drivers: s390: hmcdrv_dev: remove commented out code
Date: Sun,  8 Mar 2026 11:32:51 +0100
Message-ID: <20260308103255.757461-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The create_class() api is retiring in favor of class_register() (see:
https://lore.kernel.org/all/2023040244-duffel-pushpin-f738@gregkh/).
The HMCDRV_DEV_CLASS define is hiding a use of create_class(), but it is
permanently disabled as it is commented out. To avoid supporting code
that is disabled, the suggestion is to remove all code hiding be behind
any #ifdef HMCDRV_DEV_CLASS.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 drivers/s390/char/hmcdrv_dev.c | 114 +--------------------------------
 1 file changed, 1 insertion(+), 113 deletions(-)

diff --git a/drivers/s390/char/hmcdrv_dev.c b/drivers/s390/char/hmcdrv_dev.c
index 04b938c5357f..0d9c636df2c6 100644
--- a/drivers/s390/char/hmcdrv_dev.c
+++ b/drivers/s390/char/hmcdrv_dev.c
@@ -30,26 +30,12 @@
 #include "hmcdrv_dev.h"
 #include "hmcdrv_ftp.h"
 
-/* If the following macro is defined, then the HMC device creates it's own
- * separated device class (and dynamically assigns a major number). If not
- * defined then the HMC device is assigned to the "misc" class devices.
- *
-#define HMCDRV_DEV_CLASS "hmcftp"
- */
-
 #define HMCDRV_DEV_NAME  "hmcdrv"
 #define HMCDRV_DEV_BUSY_DELAY	 500 /* delay between -EBUSY trials in ms */
 #define HMCDRV_DEV_BUSY_RETRIES  3   /* number of retries on -EBUSY */
 
 struct hmcdrv_dev_node {
-
-#ifdef HMCDRV_DEV_CLASS
-	struct cdev dev; /* character device structure */
-	umode_t mode;	 /* mode of device node (unused, zero) */
-#else
 	struct miscdevice dev; /* "misc" device structure */
-#endif
-
 };
 
 static int hmcdrv_dev_open(struct inode *inode, struct file *fp);
@@ -75,38 +61,6 @@ static const struct file_operations hmcdrv_dev_fops = {
 
 static struct hmcdrv_dev_node hmcdrv_dev; /* HMC device struct (static) */
 
-#ifdef HMCDRV_DEV_CLASS
-
-static struct class *hmcdrv_dev_class; /* device class pointer */
-static dev_t hmcdrv_dev_no; /* device number (major/minor) */
-
-/**
- * hmcdrv_dev_name() - provides a naming hint for a device node in /dev
- * @dev: device for which the naming/mode hint is
- * @mode: file mode for device node created in /dev
- *
- * See: devtmpfs.c, function devtmpfs_create_node()
- *
- * Return: recommended device file name in /dev
- */
-static char *hmcdrv_dev_name(const struct device *dev, umode_t *mode)
-{
-	char *nodename = NULL;
-	const char *devname = dev_name(dev); /* kernel device name */
-
-	if (devname)
-		nodename = kasprintf(GFP_KERNEL, "%s", devname);
-
-	/* on device destroy (rmmod) the mode pointer may be NULL
-	 */
-	if (mode)
-		*mode = hmcdrv_dev.mode;
-
-	return nodename;
-}
-
-#endif	/* HMCDRV_DEV_CLASS */
-
 /*
  * open()
  */
@@ -276,67 +230,11 @@ static ssize_t hmcdrv_dev_write(struct file *fp, const char __user *ubuf,
  */
 int hmcdrv_dev_init(void)
 {
-	int rc;
-
-#ifdef HMCDRV_DEV_CLASS
-	struct device *dev;
-
-	rc = alloc_chrdev_region(&hmcdrv_dev_no, 0, 1, HMCDRV_DEV_NAME);
-
-	if (rc)
-		goto out_err;
-
-	cdev_init(&hmcdrv_dev.dev, &hmcdrv_dev_fops);
-	hmcdrv_dev.dev.owner = THIS_MODULE;
-	rc = cdev_add(&hmcdrv_dev.dev, hmcdrv_dev_no, 1);
-
-	if (rc)
-		goto out_unreg;
-
-	/* At this point the character device exists in the kernel (see
-	 * /proc/devices), but not under /dev nor /sys/devices/virtual. So
-	 * we have to create an associated class (see /sys/class).
-	 */
-	hmcdrv_dev_class = class_create(HMCDRV_DEV_CLASS);
-
-	if (IS_ERR(hmcdrv_dev_class)) {
-		rc = PTR_ERR(hmcdrv_dev_class);
-		goto out_devdel;
-	}
-
-	/* Finally a device node in /dev has to be established (as 'mkdev'
-	 * does from the command line). Notice that assignment of a device
-	 * node name/mode function is optional (only for mode != 0600).
-	 */
-	hmcdrv_dev.mode = 0; /* "unset" */
-	hmcdrv_dev_class->devnode = hmcdrv_dev_name;
-
-	dev = device_create(hmcdrv_dev_class, NULL, hmcdrv_dev_no, NULL,
-			    "%s", HMCDRV_DEV_NAME);
-	if (!IS_ERR(dev))
-		return 0;
-
-	rc = PTR_ERR(dev);
-	class_destroy(hmcdrv_dev_class);
-	hmcdrv_dev_class = NULL;
-
-out_devdel:
-	cdev_del(&hmcdrv_dev.dev);
-
-out_unreg:
-	unregister_chrdev_region(hmcdrv_dev_no, 1);
-
-out_err:
-
-#else  /* !HMCDRV_DEV_CLASS */
 	hmcdrv_dev.dev.minor = MISC_DYNAMIC_MINOR;
 	hmcdrv_dev.dev.name = HMCDRV_DEV_NAME;
 	hmcdrv_dev.dev.fops = &hmcdrv_dev_fops;
 	hmcdrv_dev.dev.mode = 0; /* finally produces 0600 */
-	rc = misc_register(&hmcdrv_dev.dev);
-#endif	/* HMCDRV_DEV_CLASS */
-
-	return rc;
+	return misc_register(&hmcdrv_dev.dev);
 }
 
 /**
@@ -344,15 +242,5 @@ int hmcdrv_dev_init(void)
  */
 void hmcdrv_dev_exit(void)
 {
-#ifdef HMCDRV_DEV_CLASS
-	if (!IS_ERR_OR_NULL(hmcdrv_dev_class)) {
-		device_destroy(hmcdrv_dev_class, hmcdrv_dev_no);
-		class_destroy(hmcdrv_dev_class);
-	}
-
-	cdev_del(&hmcdrv_dev.dev);
-	unregister_chrdev_region(hmcdrv_dev_no, 1);
-#else  /* !HMCDRV_DEV_CLASS */
 	misc_deregister(&hmcdrv_dev.dev);
-#endif	/* HMCDRV_DEV_CLASS */
 }

base-commit: d466c332e106fe666d1e2f5a24d08e308bebbfa1
-- 
2.53.0

