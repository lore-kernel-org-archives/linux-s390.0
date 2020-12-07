Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30446 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725918AbgLGNNY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Dec 2020 08:13:24 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 2/6] s390/ccwgroup: use bus->dev_groups for bus-based sysfs attributes
Date: Mon,  7 Dec 2020 14:12:29 +0100
Message-Id: <20201207131233.90383-3-jwi@linux.ibm.com>
In-Reply-To: <20201207131233.90383-1-jwi@linux.ibm.com>
References: <20201207131233.90383-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Bus drivers have their own way of describing the sysfs attributes that
all devices on a bus should provide.
Switch ccwgroup_attr_groups over to use bus->dev_groups, and thus
free up dev->groups for usage by the ccwgroup device drivers.

While adjusting the attribute naming, use ATTRIBUTE_GROUPS() to get rid
of some boilerplate code.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
---
 drivers/s390/cio/ccwgroup.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/cio/ccwgroup.c b/drivers/s390/cio/ccwgroup.c
index 483a9ecfcbb1..444385da5792 100644
--- a/drivers/s390/cio/ccwgroup.c
+++ b/drivers/s390/cio/ccwgroup.c
@@ -210,18 +210,12 @@ static ssize_t ccwgroup_ungroup_store(struct device *dev,
 static DEVICE_ATTR(ungroup, 0200, NULL, ccwgroup_ungroup_store);
 static DEVICE_ATTR(online, 0644, ccwgroup_online_show, ccwgroup_online_store);
 
-static struct attribute *ccwgroup_attrs[] = {
+static struct attribute *ccwgroup_dev_attrs[] = {
 	&dev_attr_online.attr,
 	&dev_attr_ungroup.attr,
 	NULL,
 };
-static struct attribute_group ccwgroup_attr_group = {
-	.attrs = ccwgroup_attrs,
-};
-static const struct attribute_group *ccwgroup_attr_groups[] = {
-	&ccwgroup_attr_group,
-	NULL,
-};
+ATTRIBUTE_GROUPS(ccwgroup_dev);
 
 static void ccwgroup_ungroup_workfn(struct work_struct *work)
 {
@@ -384,7 +378,6 @@ int ccwgroup_create_dev(struct device *parent, struct ccwgroup_driver *gdrv,
 	}
 
 	dev_set_name(&gdev->dev, "%s", dev_name(&gdev->cdev[0]->dev));
-	gdev->dev.groups = ccwgroup_attr_groups;
 
 	if (gdrv) {
 		gdev->dev.driver = &gdrv->driver;
@@ -487,6 +480,7 @@ static void ccwgroup_shutdown(struct device *dev)
 
 static struct bus_type ccwgroup_bus_type = {
 	.name   = "ccwgroup",
+	.dev_groups = ccwgroup_dev_groups,
 	.remove = ccwgroup_remove,
 	.shutdown = ccwgroup_shutdown,
 };
-- 
2.17.1
