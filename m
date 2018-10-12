From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 12 Oct 2018 14:43:56 +0000
Subject: [GIT PULL 4/4] s390: vfio-ap: make local functions and data static
Message-Id: <20181012144356.276260-5-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

no functional change, just hygiene.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 drivers/s390/crypto/vfio_ap_drv.c |  4 ++--
 drivers/s390/crypto/vfio_ap_ops.c | 20 ++++++++++----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 8b51821d9bf75..7667b38728f01 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -112,7 +112,7 @@ static void vfio_ap_matrix_dev_destroy(void)
 	root_device_unregister(matrix_dev->device.parent);
 }
 
-int __init vfio_ap_init(void)
+static int __init vfio_ap_init(void)
 {
 	int ret;
 
@@ -146,7 +146,7 @@ int __init vfio_ap_init(void)
 	return 0;
 }
 
-void __exit vfio_ap_exit(void)
+static void __exit vfio_ap_exit(void)
 {
 	vfio_ap_mdev_unregister();
 	ap_driver_unregister(&vfio_ap_drv);
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index ea99165d10454..272ef427dcc03 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -77,7 +77,7 @@ static ssize_t name_show(struct kobject *kobj, struct device *dev, char *buf)
 	return sprintf(buf, "%s\n", VFIO_AP_MDEV_NAME_HWVIRT);
 }
 
-MDEV_TYPE_ATTR_RO(name);
+static MDEV_TYPE_ATTR_RO(name);
 
 static ssize_t available_instances_show(struct kobject *kobj,
 					struct device *dev, char *buf)
@@ -86,7 +86,7 @@ static ssize_t available_instances_show(struct kobject *kobj,
 		       atomic_read(&matrix_dev->available_instances));
 }
 
-MDEV_TYPE_ATTR_RO(available_instances);
+static MDEV_TYPE_ATTR_RO(available_instances);
 
 static ssize_t device_api_show(struct kobject *kobj, struct device *dev,
 			       char *buf)
@@ -94,7 +94,7 @@ static ssize_t device_api_show(struct kobject *kobj, struct device *dev,
 	return sprintf(buf, "%s\n", VFIO_DEVICE_API_AP_STRING);
 }
 
-MDEV_TYPE_ATTR_RO(device_api);
+static MDEV_TYPE_ATTR_RO(device_api);
 
 static struct attribute *vfio_ap_mdev_type_attrs[] = {
 	&mdev_type_attr_name.attr,
@@ -395,7 +395,7 @@ static ssize_t unassign_adapter_store(struct device *dev,
 
 	return count;
 }
-DEVICE_ATTR_WO(unassign_adapter);
+static DEVICE_ATTR_WO(unassign_adapter);
 
 static int
 vfio_ap_mdev_verify_queues_reserved_for_apqi(struct ap_matrix_mdev *matrix_mdev,
@@ -491,7 +491,7 @@ static ssize_t assign_domain_store(struct device *dev,
 
 	return ret;
 }
-DEVICE_ATTR_WO(assign_domain);
+static DEVICE_ATTR_WO(assign_domain);
 
 
 /**
@@ -537,7 +537,7 @@ static ssize_t unassign_domain_store(struct device *dev,
 
 	return count;
 }
-DEVICE_ATTR_WO(unassign_domain);
+static DEVICE_ATTR_WO(unassign_domain);
 
 /**
  * assign_control_domain_store
@@ -586,7 +586,7 @@ static ssize_t assign_control_domain_store(struct device *dev,
 
 	return count;
 }
-DEVICE_ATTR_WO(assign_control_domain);
+static DEVICE_ATTR_WO(assign_control_domain);
 
 /**
  * unassign_control_domain_store
@@ -630,7 +630,7 @@ static ssize_t unassign_control_domain_store(struct device *dev,
 
 	return count;
 }
-DEVICE_ATTR_WO(unassign_control_domain);
+static DEVICE_ATTR_WO(unassign_control_domain);
 
 static ssize_t control_domains_show(struct device *dev,
 				    struct device_attribute *dev_attr,
@@ -654,7 +654,7 @@ static ssize_t control_domains_show(struct device *dev,
 
 	return nchars;
 }
-DEVICE_ATTR_RO(control_domains);
+static DEVICE_ATTR_RO(control_domains);
 
 static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
@@ -704,7 +704,7 @@ static ssize_t matrix_show(struct device *dev, struct device_attribute *attr,
 
 	return nchars;
 }
-DEVICE_ATTR_RO(matrix);
+static DEVICE_ATTR_RO(matrix);
 
 static struct attribute *vfio_ap_mdev_attrs[] = {
 	&dev_attr_assign_adapter.attr,
-- 
2.17.0
