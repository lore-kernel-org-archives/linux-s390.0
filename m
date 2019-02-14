From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v3 5/9] s390: ap: tools to associate a queue to a matrix
Date: Thu, 14 Feb 2019 14:51:05 +0100
Message-ID: <1550152269-6317-6-git-send-email-pmorel@linux.ibm.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

We need tools to associate a queue and a matrix to be able
later to find the matrix associated with the queue for which
we got the APQN in the register 1 during a PQAP/AQIC instruction
interception.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 66 +++++++++++++++++++++++++++++++++--
 drivers/s390/crypto/vfio_ap_private.h |  1 +
 2 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 2a52c9b..1851b24 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -50,8 +50,7 @@ static int vfio_ap_check_apqn(struct device *dev, void *data)
  *
  * Returns the pointer to the associated vfio_ap_queue
  */
-static  __attribute__((unused))
-	struct vfio_ap_queue *vfio_ap_get_queue(int apqn)
+static struct vfio_ap_queue *vfio_ap_get_queue(int apqn)
 {
 	struct device *dev;
 	struct vfio_ap_queue *q;
@@ -72,7 +71,7 @@ static  __attribute__((unused))
  * put the associated device
  *
  */
-static  __attribute__((unused)) void vfio_ap_put_queue(struct vfio_ap_queue *q)
+static void vfio_ap_put_queue(struct vfio_ap_queue *q)
 {
 	put_device(q->dev);
 	q->dev = NULL;
@@ -867,6 +866,67 @@ static int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
 	return -EBUSY;
 }
 
+/**
+ * vfio_ap_dissociate_queues: Dissociate a matrix mediated device to a queue
+ *
+ * Go through all bits in the AQM and APM and dissociate the queue
+ * from the matrix device.
+ *
+ * No return value we are throwing the mediated device anyway.
+ */
+static void vfio_ap_dissociate_queues(struct ap_matrix_mdev *matrix_mdev)
+{
+	unsigned long apid, apqi;
+	struct vfio_ap_queue *q;
+
+	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm,
+			     matrix_mdev->matrix.apm_max + 1) {
+		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
+				     matrix_mdev->matrix.aqm_max + 1) {
+			q = vfio_ap_get_queue(AP_MKQID(apid, apqi));
+			if (q) {
+				vfio_ap_mdev_reset_queue(apid, apqi, 1);
+				q->matrix = NULL;
+				vfio_ap_put_queue(q);
+			} else
+				pr_err("%s: no queue for %02lx.%04lx\n",
+				       __func__, apid, apqi);
+		}
+	}
+}
+
+/**
+ * vfio_ap_associate_queues: Associate a matrix mediated device to a queue
+ *
+ * Go through all bits in the AQM and APM and calculate the APQN, and find
+ * the matching queue to associate with the matrix device.
+ *
+ * In the case a queue could not be found return -ENODEV.
+ * Otherwise return 0.
+ */
+static __attribute__((unused))
+	int vfio_ap_associate_queues(struct ap_matrix_mdev *matrix_mdev)
+{
+	unsigned long apid, apqi;
+	struct vfio_ap_queue *q;
+
+	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm,
+			     matrix_mdev->matrix.apm_max + 1) {
+		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
+				     matrix_mdev->matrix.aqm_max + 1) {
+			q = vfio_ap_get_queue(AP_MKQID(apid, apqi));
+			if (!q)
+				goto error;
+			q->matrix = matrix_mdev;
+			vfio_ap_put_queue(q);
+		}
+	}
+	return 0;
+error:
+	pr_err("%s: no queue for %02lx.%04lx\n", __func__, apid, apqi);
+	vfio_ap_dissociate_queues(matrix_mdev);
+	return -ENODEV;
+}
 static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
 {
 	int ret;
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 081f0d7..10bc8b5 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -89,5 +89,6 @@ extern void vfio_ap_mdev_unregister(void);
 struct vfio_ap_queue {
 	struct device *dev;
 	int	apqn;
+	struct ap_matrix_mdev *matrix;
 };
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.7.4
