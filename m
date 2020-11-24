Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733307AbgKXVko (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Nov 2020 16:40:44 -0500
From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v12 10/17] s390/vfio-ap: initialize the guest apcb
Date: Tue, 24 Nov 2020 16:40:09 -0500
Message-Id: <20201124214016.3013-11-akrowiak@linux.ibm.com>
In-Reply-To: <20201124214016.3013-1-akrowiak@linux.ibm.com>
References: <20201124214016.3013-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>

The APCB is a control block containing the masks that specify the adapters,
domains and control domains to which a KVM guest is granted access. When
the vfio_ap device driver is notified that the KVM pointer has been set,
the guest's APCB is initialized from the AP configuration of adapters,
domains and control domains assigned to the matrix mdev. The linux device
model, however, precludes passing through to a guest any devices that
are not bound to the device driver facilitating the pass-through.
Consequently, APQNs assigned to the matrix mdev that do not reference
AP queue devices must be filtered before assigning them to the KVM guest's
APCB; however, the AP architecture precludes filtering individual APQNs, so
the APQNs will be filtered by APID. That is, if a given APQN does not
reference a queue device bound to the vfio_ap driver, its APID will not
get assigned to the guest's APCB. For example:

Queues bound to vfio_ap:
04.0004
04.0022
04.0035
05.0004
05.0022

Adapters/domains assigned to the matrix mdev:
04 0004
   0022
   0035
05 0004
   0022
   0035

APQNs assigned to APCB:
04.0004
04.0022
04.0035

The APID 05 was filtered from the matrix mdev's matrix because
queue device 05.0035 is not bound to the vfio_ap device driver.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 59 +++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index a69422d76e7f..633c61995891 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -318,6 +318,13 @@ static void vfio_ap_matrix_init(struct ap_config_info *info,
 	matrix->adm_max = info->apxa ? info->Nd : 15;
 }
 
+static void vfio_ap_copy_masks(struct ap_matrix *dst, struct ap_matrix *src)
+{
+	bitmap_copy(dst->apm, src->apm, AP_DEVICES);
+	bitmap_copy(dst->aqm, src->aqm, AP_DOMAINS);
+	bitmap_copy(dst->adm, src->adm, AP_DOMAINS);
+}
+
 static bool vfio_ap_mdev_has_crycb(struct ap_matrix_mdev *matrix_mdev)
 {
 	return (matrix_mdev->kvm && matrix_mdev->kvm->arch.crypto.crycbd);
@@ -332,6 +339,55 @@ static void vfio_ap_mdev_commit_shadow_apcb(struct ap_matrix_mdev *matrix_mdev)
 					  matrix_mdev->shadow_apcb.adm);
 }
 
+static void vfio_ap_mdev_init_apcb(struct ap_matrix_mdev *matrix_mdev)
+{
+	unsigned long apid, apqi, apqn;
+
+	vfio_ap_copy_masks(&matrix_mdev->shadow_apcb, &matrix_mdev->matrix);
+
+	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, AP_DEVICES) {
+		/*
+		 * If the APID is not assigned to the host AP configuration,
+		 * we can not assign it to the guest's AP configuration
+		 */
+		if (!test_bit_inv(apid,
+				  (unsigned long *)matrix_dev->info.apm)) {
+			clear_bit_inv(apid, matrix_mdev->shadow_apcb.apm);
+			continue;
+		}
+
+		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
+				     AP_DOMAINS) {
+			/*
+			 * If the APQI is not assigned to the host AP
+			 * configuration, then it can not be assigned to the
+			 * guest's AP configuration
+			 */
+			if (!test_bit_inv(apqi, (unsigned long *)
+					  matrix_dev->info.aqm)) {
+				clear_bit_inv(apqi,
+					      matrix_mdev->shadow_apcb.aqm);
+				continue;
+			}
+
+			/*
+			 * If the APQN is not bound to the vfio_ap device
+			 * driver, then we can't assign it to the guest's
+			 * AP configuration. The AP architecture won't
+			 * allow filtering of a single APQN, so let's filter
+			 * the APID.
+			 */
+			apqn = AP_MKQID(apid, apqi);
+
+			if (!vfio_ap_mdev_get_queue(matrix_mdev, apqn)) {
+				clear_bit_inv(apid,
+					      matrix_mdev->shadow_apcb.apm);
+				break;
+			}
+		}
+	}
+}
+
 static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
 {
 	struct ap_matrix_mdev *matrix_mdev;
@@ -1256,8 +1312,7 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
 	if (ret)
 		return NOTIFY_DONE;
 
-	memcpy(&matrix_mdev->shadow_apcb, &matrix_mdev->matrix,
-	       sizeof(matrix_mdev->shadow_apcb));
+	vfio_ap_mdev_init_apcb(matrix_mdev);
 	vfio_ap_mdev_commit_shadow_apcb(matrix_mdev);
 
 	return NOTIFY_OK;
-- 
2.21.1
