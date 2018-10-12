From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 12 Oct 2018 14:43:55 +0000
Subject: [GIT PULL 3/4] s390: vfio-ap: setup APCB mask using KVM dedicated function
Message-Id: <20181012144356.276260-4-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Pierre Morel <pmorel@linux.ibm.com>

We replace the vfio_ap_mdev_copy_masks() by the new
kvm_arch_crypto_set_masks() to be able to use the standard
KVM tracing system.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Message-Id: <1538728270-10340-3-git-send-email-pmorel@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 35 +++----------------------------
 1 file changed, 3 insertions(+), 32 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index d3d9eb72b0f1a..ea99165d10454 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -727,37 +727,6 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
 	NULL
 };
 
-static void vfio_ap_mdev_copy_masks(struct ap_matrix_mdev *matrix_mdev)
-{
-	int nbytes;
-	unsigned long *apm, *aqm, *adm;
-	struct kvm_s390_crypto_cb *crycb = matrix_mdev->kvm->arch.crypto.crycb;
-
-	switch (matrix_mdev->kvm->arch.crypto.crycbd & CRYCB_FORMAT_MASK) {
-	case CRYCB_FORMAT2:
-		apm = (unsigned long *)crycb->apcb1.apm;
-		aqm = (unsigned long *)crycb->apcb1.aqm;
-		adm = (unsigned long *)crycb->apcb1.adm;
-		break;
-	case CRYCB_FORMAT1:
-	case CRYCB_FORMAT0:
-		apm = (unsigned long *)crycb->apcb0.apm;
-		aqm = (unsigned long *)crycb->apcb0.aqm;
-		adm = (unsigned long *)crycb->apcb0.adm;
-		break;
-	default:
-		/* cannot happen */
-		return;
-	}
-
-	nbytes = DIV_ROUND_UP(matrix_mdev->matrix.apm_max + 1, BITS_PER_BYTE);
-	memcpy(apm, matrix_mdev->matrix.apm, nbytes);
-	nbytes = DIV_ROUND_UP(matrix_mdev->matrix.aqm_max + 1, BITS_PER_BYTE);
-	memcpy(aqm, matrix_mdev->matrix.aqm, nbytes);
-	nbytes = DIV_ROUND_UP(matrix_mdev->matrix.adm_max + 1, BITS_PER_BYTE);
-	memcpy(adm, matrix_mdev->matrix.adm, nbytes);
-}
-
 /**
  * vfio_ap_mdev_set_kvm
  *
@@ -814,7 +783,9 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
 	if (!matrix_mdev->kvm->arch.crypto.crycbd)
 		return NOTIFY_DONE;
 
-	vfio_ap_mdev_copy_masks(matrix_mdev);
+	kvm_arch_crypto_set_masks(matrix_mdev->kvm, matrix_mdev->matrix.apm,
+				  matrix_mdev->matrix.aqm,
+				  matrix_mdev->matrix.adm);
 
 	return NOTIFY_OK;
 }
-- 
2.17.0
