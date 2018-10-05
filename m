From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v1 2/2] s390: vfio-ap: setup APCB mask using KVM dedicated function
Date: Fri,  5 Oct 2018 10:31:10 +0200
Message-ID: <1538728270-10340-3-git-send-email-pmorel@linux.ibm.com>
References: <7d147350-4284-8e01-d1fa-0795d2da85c1@de.ibm.com>
 <1538728270-10340-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538728270-10340-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: borntraeger@de.ibm.com
Cc: david@redhat.com, linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

We replace the vfio_ap_mdev_copy_masks() by the new
kvm_arch_crypto_set_masks() to be able to use the standard
KVM tracing system.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 33 +++------------------------------
 1 file changed, 3 insertions(+), 30 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index a8a9984..f297779 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -726,35 +726,6 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
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
-	default:
-		apm = (unsigned long *)crycb->apcb0.apm;
-		aqm = (unsigned long *)crycb->apcb0.aqm;
-		adm = (unsigned long *)crycb->apcb0.adm;
-		break;
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
@@ -811,7 +782,9 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
 	if (!matrix_mdev->kvm->arch.crypto.crycbd)
 		return NOTIFY_DONE;
 
-	vfio_ap_mdev_copy_masks(matrix_mdev);
+	kvm_arch_crypto_set_masks(matrix_mdev->kvm, matrix_mdev->matrix.apm,
+				  matrix_mdev->matrix.aqm,
+				  matrix_mdev->matrix.adm);
 
 	return NOTIFY_OK;
 }
-- 
2.7.4
