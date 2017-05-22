From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PULL 1/1] s390/vfio_ccw: make some symbols static
Date: Mon, 22 May 2017 16:21:17 +0200
Message-ID: <20170522142117.29775-2-cornelia.huck@de.ibm.com>
References: <20170522142117.29775-1-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170522142117.29775-1-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: bjsdjshi@linux.vnet.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

Make some symbols static to fix sparse warnings like:
drivers/s390/cio/vfio_ccw_ops.c:73:1: warning: symbol 'mdev_type_attr_name' was not declared. Should it be static?

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 drivers/s390/cio/vfio_ccw_ops.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index e72abbc18ee3..a66a317f3e4f 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -70,14 +70,14 @@ static ssize_t name_show(struct kobject *kobj, struct device *dev, char *buf)
 {
 	return sprintf(buf, "I/O subchannel (Non-QDIO)\n");
 }
-MDEV_TYPE_ATTR_RO(name);
+static MDEV_TYPE_ATTR_RO(name);
 
 static ssize_t device_api_show(struct kobject *kobj, struct device *dev,
 			       char *buf)
 {
 	return sprintf(buf, "%s\n", VFIO_DEVICE_API_CCW_STRING);
 }
-MDEV_TYPE_ATTR_RO(device_api);
+static MDEV_TYPE_ATTR_RO(device_api);
 
 static ssize_t available_instances_show(struct kobject *kobj,
 					struct device *dev, char *buf)
@@ -86,7 +86,7 @@ static ssize_t available_instances_show(struct kobject *kobj,
 
 	return sprintf(buf, "%d\n", atomic_read(&private->avail));
 }
-MDEV_TYPE_ATTR_RO(available_instances);
+static MDEV_TYPE_ATTR_RO(available_instances);
 
 static struct attribute *mdev_types_attrs[] = {
 	&mdev_type_attr_name.attr,
@@ -100,7 +100,7 @@ static struct attribute_group mdev_type_group = {
 	.attrs = mdev_types_attrs,
 };
 
-struct attribute_group *mdev_type_groups[] = {
+static struct attribute_group *mdev_type_groups[] = {
 	&mdev_type_group,
 	NULL,
 };
@@ -152,7 +152,7 @@ static int vfio_ccw_mdev_open(struct mdev_device *mdev)
 				      &events, &private->nb);
 }
 
-void vfio_ccw_mdev_release(struct mdev_device *mdev)
+static void vfio_ccw_mdev_release(struct mdev_device *mdev)
 {
 	struct vfio_ccw_private *private =
 		dev_get_drvdata(mdev_parent_dev(mdev));
@@ -233,7 +233,7 @@ static int vfio_ccw_mdev_get_region_info(struct vfio_region_info *info,
 	}
 }
 
-int vfio_ccw_mdev_get_irq_info(struct vfio_irq_info *info)
+static int vfio_ccw_mdev_get_irq_info(struct vfio_irq_info *info)
 {
 	if (info->index != VFIO_CCW_IO_IRQ_INDEX)
 		return -EINVAL;
-- 
2.13.0
