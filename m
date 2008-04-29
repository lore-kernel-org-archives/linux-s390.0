Return-Path: <linux-kernel-owner+w=401wt.eu-S1760528AbYD2OQi@vger.kernel.org>
Message-Id: <20080429140248.641638615@de.ibm.com>
References: <20080429140117.631962807@de.ibm.com>
Date: Tue, 29 Apr 2008 16:01:18 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 01/15] cio: Use strict_strtoul() for attributes.
Content-Disposition: inline; filename=001-cio-strict_strtoul.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Make parsing of attribute writes handle incorrect input better.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/ccwgroup.c |    7 +++++--
 drivers/s390/cio/cmf.c      |   11 ++++++++---
 drivers/s390/cio/css.c      |   10 +++++++---
 drivers/s390/cio/device.c   |   17 +++++++++++------
 drivers/s390/cio/qdio.c     |    8 ++++----
 5 files changed, 35 insertions(+), 18 deletions(-)

Index: quilt-2.6/drivers/s390/cio/ccwgroup.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/ccwgroup.c
+++ quilt-2.6/drivers/s390/cio/ccwgroup.c
@@ -318,7 +318,7 @@ ccwgroup_online_store (struct device *de
 {
 	struct ccwgroup_device *gdev;
 	struct ccwgroup_driver *gdrv;
-	unsigned int value;
+	unsigned long value;
 	int ret;
 
 	gdev = to_ccwgroupdev(dev);
@@ -329,7 +329,9 @@ ccwgroup_online_store (struct device *de
 	if (!try_module_get(gdrv->owner))
 		return -EINVAL;
 
-	value = simple_strtoul(buf, NULL, 0);
+	ret = strict_strtoul(buf, 0, &value);
+	if (ret)
+		goto out;
 	ret = count;
 	if (value == 1)
 		ccwgroup_set_online(gdev);
@@ -337,6 +339,7 @@ ccwgroup_online_store (struct device *de
 		ccwgroup_set_offline(gdev);
 	else
 		ret = -EINVAL;
+out:
 	module_put(gdrv->owner);
 	return ret;
 }
Index: quilt-2.6/drivers/s390/cio/cmf.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cmf.c
+++ quilt-2.6/drivers/s390/cio/cmf.c
@@ -1219,16 +1219,21 @@ static ssize_t cmb_enable_store(struct d
 {
 	struct ccw_device *cdev;
 	int ret;
+	unsigned long val;
+
+	ret = strict_strtoul(buf, 16, &val);
+	if (ret)
+		return ret;
 
 	cdev = to_ccwdev(dev);
 
-	switch (buf[0]) {
-	case '0':
+	switch (val) {
+	case 0:
 		ret = disable_cmf(cdev);
 		if (ret)
 			dev_info(&cdev->dev, "disable_cmf failed (%d)\n", ret);
 		break;
-	case '1':
+	case 1:
 		ret = enable_cmf(cdev);
 		if (ret && ret != -EBUSY)
 			dev_info(&cdev->dev, "enable_cmf failed (%d)\n", ret);
Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -705,13 +705,17 @@ css_cm_enable_store(struct device *dev, 
 {
 	struct channel_subsystem *css = to_css(dev);
 	int ret;
+	unsigned long val;
 
+	ret = strict_strtoul(buf, 16, &val);
+	if (ret)
+		return ret;
 	mutex_lock(&css->mutex);
-	switch (buf[0]) {
-	case '0':
+	switch (val) {
+	case 0:
 		ret = css->cm_enabled ? chsc_secm(css, 0) : 0;
 		break;
-	case '1':
+	case 1:
 		ret = css->cm_enabled ? 0 : chsc_secm(css, 1);
 		break;
 	default:
Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c
+++ quilt-2.6/drivers/s390/cio/device.c
@@ -512,8 +512,8 @@ static ssize_t online_store (struct devi
 			     const char *buf, size_t count)
 {
 	struct ccw_device *cdev = to_ccwdev(dev);
-	int i, force;
-	char *tmp;
+	int force, ret;
+	unsigned long i;
 
 	if (atomic_cmpxchg(&cdev->private->onoff, 0, 1) != 0)
 		return -EAGAIN;
@@ -525,25 +525,30 @@ static ssize_t online_store (struct devi
 	if (!strncmp(buf, "force\n", count)) {
 		force = 1;
 		i = 1;
+		ret = 0;
 	} else {
 		force = 0;
-		i = simple_strtoul(buf, &tmp, 16);
+		ret = strict_strtoul(buf, 16, &i);
 	}
-
+	if (ret)
+		goto out;
 	switch (i) {
 	case 0:
 		online_store_handle_offline(cdev);
+		ret = count;
 		break;
 	case 1:
 		online_store_handle_online(cdev, force);
+		ret = count;
 		break;
 	default:
-		count = -EINVAL;
+		ret = -EINVAL;
 	}
+out:
 	if (cdev->drv)
 		module_put(cdev->drv->owner);
 	atomic_set(&cdev->private->onoff, 0);
-	return count;
+	return ret;
 }
 
 static ssize_t
Index: quilt-2.6/drivers/s390/cio/qdio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio.c
+++ quilt-2.6/drivers/s390/cio/qdio.c
@@ -3663,11 +3663,11 @@ qdio_performance_stats_show(struct bus_t
 static ssize_t
 qdio_performance_stats_store(struct bus_type *bus, const char *buf, size_t count)
 {
-	char *tmp;
-	int i;
+	unsigned long i;
+	int ret;
 
-	i = simple_strtoul(buf, &tmp, 16);
-	if ((i == 0) || (i == 1)) {
+	ret = strict_strtoul(buf, 16, &i);
+	if (!ret && ((i == 0) || (i == 1))) {
 		if (i == qdio_performance_stats)
 			return count;
 		qdio_performance_stats = i;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
