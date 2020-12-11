Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27176 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388813AbgLKWXY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 11 Dec 2020 17:23:24 -0500
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v2 1/2] s390/vfio-ap: No need to disable IRQ after queue reset
Date: Fri, 11 Dec 2020 17:22:10 -0500
Message-Id: <20201211222211.20869-2-akrowiak@linux.ibm.com>
In-Reply-To: <20201211222211.20869-1-akrowiak@linux.ibm.com>
References: <20201211222211.20869-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, pbonzini@redhat.com, alex.williamson@redhat.com, pasic@linux.vnet.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>

The queues assigned to a matrix mediated device are currently reset when:

* The VFIO_DEVICE_RESET ioctl is invoked
* The mdev fd is closed by userspace (QEMU)
* The mdev is removed from sysfs.

Immediately after the reset of a queue, a call is made to disable
interrupts for the queue. This is entirely unnecessary because the reset of
a queue disables interrupts, so this will be removed.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c     |  1 -
 drivers/s390/crypto/vfio_ap_ops.c     | 40 +++++++++++++++++----------
 drivers/s390/crypto/vfio_ap_private.h |  1 -
 3 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index be2520cc010b..ca18c91afec9 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -79,7 +79,6 @@ static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
 	apid = AP_QID_CARD(q->apqn);
 	apqi = AP_QID_QUEUE(q->apqn);
 	vfio_ap_mdev_reset_queue(apid, apqi, 1);
-	vfio_ap_irq_disable(q);
 	kfree(q);
 	mutex_unlock(&matrix_dev->lock);
 }
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index e0bde8518745..c854d7ab2079 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -25,6 +25,7 @@
 #define VFIO_AP_MDEV_NAME_HWVIRT "VFIO AP Passthrough Device"
 
 static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev);
+static struct vfio_ap_queue *vfio_ap_find_queue(int apqn);
 
 static int match_apqn(struct device *dev, const void *data)
 {
@@ -49,20 +50,15 @@ static struct vfio_ap_queue *vfio_ap_get_queue(
 					int apqn)
 {
 	struct vfio_ap_queue *q;
-	struct device *dev;
 
 	if (!test_bit_inv(AP_QID_CARD(apqn), matrix_mdev->matrix.apm))
 		return NULL;
 	if (!test_bit_inv(AP_QID_QUEUE(apqn), matrix_mdev->matrix.aqm))
 		return NULL;
 
-	dev = driver_find_device(&matrix_dev->vfio_ap_drv->driver, NULL,
-				 &apqn, match_apqn);
-	if (!dev)
-		return NULL;
-	q = dev_get_drvdata(dev);
-	q->matrix_mdev = matrix_mdev;
-	put_device(dev);
+	q = vfio_ap_find_queue(apqn);
+	if (q)
+		q->matrix_mdev = matrix_mdev;
 
 	return q;
 }
@@ -1114,24 +1110,27 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-static void vfio_ap_irq_disable_apqn(int apqn)
+static struct vfio_ap_queue *vfio_ap_find_queue(int apqn)
 {
 	struct device *dev;
-	struct vfio_ap_queue *q;
+	struct vfio_ap_queue *q = NULL;
 
 	dev = driver_find_device(&matrix_dev->vfio_ap_drv->driver, NULL,
 				 &apqn, match_apqn);
 	if (dev) {
 		q = dev_get_drvdata(dev);
-		vfio_ap_irq_disable(q);
 		put_device(dev);
 	}
+
+	return q;
 }
 
 int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
 			     unsigned int retry)
 {
 	struct ap_queue_status status;
+	struct vfio_ap_queue *q;
+	int ret;
 	int retry2 = 2;
 	int apqn = AP_MKQID(apid, apqi);
 
@@ -1144,18 +1143,32 @@ int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
 				status = ap_tapq(apqn, NULL);
 			}
 			WARN_ON_ONCE(retry2 <= 0);
-			return 0;
+			ret = 0;
+			goto free_aqic_resources;
 		case AP_RESPONSE_RESET_IN_PROGRESS:
 		case AP_RESPONSE_BUSY:
 			msleep(20);
 			break;
 		default:
 			/* things are really broken, give up */
-			return -EIO;
+			ret = -EIO;
+			goto free_aqic_resources;
 		}
 	} while (retry--);
 
 	return -EBUSY;
+
+free_aqic_resources:
+	/*
+	 * In order to free the aqic resources, the queue must be linked to
+	 * the matrix_mdev to which its APQN is assigned and the KVM pointer
+	 * must be available.
+	 */
+	q = vfio_ap_find_queue(apqn);
+	if (q && q->matrix_mdev && q->matrix_mdev->kvm)
+		vfio_ap_free_aqic_resources(q);
+
+	return ret;
 }
 
 static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
@@ -1177,7 +1190,6 @@ static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
 			 */
 			if (ret)
 				rc = ret;
-			vfio_ap_irq_disable_apqn(AP_MKQID(apid, apqi));
 		}
 	}
 
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index f46dde56b464..0db6fb3d56d5 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -100,5 +100,4 @@ struct vfio_ap_queue {
 #define VFIO_AP_ISC_INVALID 0xff
 	unsigned char saved_isc;
 };
-struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q);
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.21.1
