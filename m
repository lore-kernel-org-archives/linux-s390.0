From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 26 Jul 2018 19:54:10 +0000
Subject: [PATCH v7 03/22] s390/zcrypt: Show load of cards and queues in sysfs
Message-Id: <20180726195429.31960-4-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Harald Freudenberger <freude@de.ibm.com>

Show the current load value of cards and queues in sysfs.
The load value for each card and queue is maintained by
the zcrypt device driver for dispatching and load
balancing requests over the available devices.

This patch provides the load value to userspace via a
new read only sysfs attribute 'load' per card and queue.

Signed-off-by: Harald Freudenberger <freude@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/s390/crypto/zcrypt_card.c  | 12 ++++++++++++
 drivers/s390/crypto/zcrypt_queue.c | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/s390/crypto/zcrypt_card.c b/drivers/s390/crypto/zcrypt_card.c
index 233e1e695208..da2c8dfd4d74 100644
--- a/drivers/s390/crypto/zcrypt_card.c
+++ b/drivers/s390/crypto/zcrypt_card.c
@@ -83,9 +83,21 @@ static ssize_t zcrypt_card_online_store(struct device *dev,
 static DEVICE_ATTR(online, 0644, zcrypt_card_online_show,
 		   zcrypt_card_online_store);
 
+static ssize_t zcrypt_card_load_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct zcrypt_card *zc = to_ap_card(dev)->private;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", atomic_read(&zc->load));
+}
+
+static DEVICE_ATTR(load, 0444, zcrypt_card_load_show, NULL);
+
 static struct attribute *zcrypt_card_attrs[] = {
 	&dev_attr_type.attr,
 	&dev_attr_online.attr,
+	&dev_attr_load.attr,
 	NULL,
 };
 
diff --git a/drivers/s390/crypto/zcrypt_queue.c b/drivers/s390/crypto/zcrypt_queue.c
index 720434e18007..91a52f268353 100644
--- a/drivers/s390/crypto/zcrypt_queue.c
+++ b/drivers/s390/crypto/zcrypt_queue.c
@@ -75,8 +75,20 @@ static ssize_t zcrypt_queue_online_store(struct device *dev,
 static DEVICE_ATTR(online, 0644, zcrypt_queue_online_show,
 		   zcrypt_queue_online_store);
 
+static ssize_t zcrypt_queue_load_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct zcrypt_queue *zq = to_ap_queue(dev)->private;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", atomic_read(&zq->load));
+}
+
+static DEVICE_ATTR(load, 0444, zcrypt_queue_load_show, NULL);
+
 static struct attribute *zcrypt_queue_attrs[] = {
 	&dev_attr_online.attr,
+	&dev_attr_load.attr,
 	NULL,
 };
 
-- 
2.17.0
