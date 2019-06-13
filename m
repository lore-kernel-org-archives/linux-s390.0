Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42346 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728666AbfFMLIV (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 13 Jun 2019 07:08:21 -0400
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH] s390/cio: introduce driver_override on the css bus
Date: Thu, 13 Jun 2019 13:08:15 +0200
Message-Id: <20190613110815.17251-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Sebastian Ott <sebott@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>

Sometimes, we want to control which of the matching drivers
binds to a subchannel device (e.g. for subchannels we want to
handle via vfio-ccw).

For pci devices, a mechanism to do so has been introduced in
782a985d7af2 ("PCI: Introduce new device binding path using
pci_dev.driver_override"). It makes sense to introduce the
driver_override attribute for subchannel devices as well, so
that we can easily extend the 'driverctl' tool (which makes
use of the driver_override attribute for pci).

Note that unlike pci we still require a driver override to
match the subchannel type; matching more than one subchannel
type is probably not useful anyway.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---

Lightly tested; did not yet attempt to adapt driverctl to actually
make use of it.

For some background, refer to the thread around
https://lore.kernel.org/kvm/20190612091439.3a33f17b.cohuck@redhat.com/

---
 Documentation/ABI/testing/sysfs-bus-css | 23 +++++++++++
 drivers/s390/cio/cio.h                  |  1 +
 drivers/s390/cio/css.c                  | 53 +++++++++++++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-css b/Documentation/ABI/testing/sysfs-bus-css
index 2979c40c10e9..966f8504bd7b 100644
--- a/Documentation/ABI/testing/sysfs-bus-css
+++ b/Documentation/ABI/testing/sysfs-bus-css
@@ -33,3 +33,26 @@ Description:	Contains the PIM/PAM/POM values, as reported by the
 		in sync with the values current in the channel subsystem).
 		Note: This is an I/O-subchannel specific attribute.
 Users:		s390-tools, HAL
+
+What:		/sys/bus/css/devices/.../driver_override
+Date:		June 2019
+Contact:	Cornelia Huck <cohuck@redhat.com>
+		linux-s390@vger.kernel.org
+Description:	This file allows the driver for a device to be specified. When
+		specified, only a driver with a name matching the value written
+		to driver_override will have an opportunity to bind to the
+		device. The override is specified by writing a string to the
+		driver_override file (echo vfio-ccw > driver_override) and
+		may be cleared with an empty string (echo > driver_override).
+		This returns the device to standard matching rules binding.
+		Writing to driver_override does not automatically unbind the
+		device from its current driver or make any attempt to
+		automatically load the specified driver.  If no driver with a
+		matching name is currently loaded in the kernel, the device
+		will not bind to any driver.  This also allows devices to
+		opt-out of driver binding using a driver_override name such as
+		"none".  Only a single driver may be specified in the override,
+		there is no support for parsing delimiters.
+		Note that unlike the mechanism of the same name for pci, this
+		file does not allow to override basic matching rules. I.e.,
+		the driver must still match the subchannel type of the device.
diff --git a/drivers/s390/cio/cio.h b/drivers/s390/cio/cio.h
index 06a91743335a..8c4af88f1ac3 100644
--- a/drivers/s390/cio/cio.h
+++ b/drivers/s390/cio/cio.h
@@ -113,6 +113,7 @@ struct subchannel {
 	enum sch_todo todo;
 	struct work_struct todo_work;
 	struct schib_config config;
+	char *driver_override; /* Driver name to force a match */
 } __attribute__ ((aligned(8)));
 
 DECLARE_PER_CPU_ALIGNED(struct irb, cio_irb);
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index aea502922646..f3436a17e3b5 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -165,6 +165,7 @@ static void css_subchannel_release(struct device *dev)
 
 	sch->config.intparm = 0;
 	cio_commit_config(sch);
+	kfree(sch->driver_override);
 	kfree(sch->lock);
 	kfree(sch);
 }
@@ -315,9 +316,57 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR_RO(modalias);
 
+static ssize_t driver_override_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct subchannel *sch = to_subchannel(dev);
+	char *driver_override, *old, *cp;
+
+	/* We need to keep extra room for a newline */
+	if (count >= (PAGE_SIZE - 1))
+		return -EINVAL;
+
+	driver_override = kstrndup(buf, count, GFP_KERNEL);
+	if (!driver_override)
+		return -ENOMEM;
+
+	cp = strchr(driver_override, '\n');
+	if (cp)
+		*cp = '\0';
+
+	device_lock(dev);
+	old = sch->driver_override;
+	if (strlen(driver_override)) {
+		sch->driver_override = driver_override;
+	} else {
+		kfree(driver_override);
+		sch->driver_override = NULL;
+	}
+	device_unlock(dev);
+
+	kfree(old);
+
+	return count;
+}
+
+static ssize_t driver_override_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct subchannel *sch = to_subchannel(dev);
+	ssize_t len;
+
+	device_lock(dev);
+	len = snprintf(buf, PAGE_SIZE, "%s\n", sch->driver_override);
+	device_unlock(dev);
+	return len;
+}
+static DEVICE_ATTR_RW(driver_override);
+
 static struct attribute *subch_attrs[] = {
 	&dev_attr_type.attr,
 	&dev_attr_modalias.attr,
+	&dev_attr_driver_override.attr,
 	NULL,
 };
 
@@ -1222,6 +1271,10 @@ static int css_bus_match(struct device *dev, struct device_driver *drv)
 	struct css_driver *driver = to_cssdriver(drv);
 	struct css_device_id *id;
 
+	/* When driver_override is set, only bind to the matching driver */
+	if (sch->driver_override && strcmp(sch->driver_override, drv->name))
+		return 0;
+
 	for (id = driver->subchannel_type; id->match_flags; id++) {
 		if (sch->st == id->type)
 			return 1;
-- 
2.20.1
