From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v9 03/22] s390/zcrypt: Show load of cards and queues in sysfs
Date: Mon, 13 Aug 2018 17:48:00 -0400
Message-ID: <1534196899-16987-4-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
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
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_card.c  |   12 ++++++++++++
 drivers/s390/crypto/zcrypt_queue.c |   12 ++++++++++++
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_card.c b/drivers/s390/crypto/zcrypt_card.c
index 233e1e6..da2c8df 100644
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
index 720434e..91a52f2 100644
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
1.7.1
