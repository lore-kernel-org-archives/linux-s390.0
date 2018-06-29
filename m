From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v6 15/21] s390: vfio-ap: configure the guest's AP matrix
Date: Fri, 29 Jun 2018 17:11:17 -0400
Message-ID: <1530306683-7270-16-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Tony Krowiak <akrowiak@linux.ibm.com>

Configures the AP adapters, usage domains and control domains for the
KVM guest from the matrix configured via the mediated matrix device's
sysfs attribute files.

The guest's SIE state description has a satellite structure called the
Crypto Control Block (CRYCB) containing three bitmask fields
identifying the adapters, queues (domains) and control domains
assigned to the KVM guest:

* The AP Adapter Mask (APM) field identifies the AP adapters assigned to
  the KVM guest

* The AP Queue Mask (AQM) field identifies the AP queues assigned to
  the KVM guest. Each AP queue is connected to a usage domain within
  an AP adapter.

* The AP Domain Mask (ADM) field identifies the control domains
  assigned to the KVM guest.

Each adapter, queue (usage domain) and control domain are identified by
a number from 0 to 255. The bits in each mask, from most significant to
least significant bit, correspond to the numbers 0-255. When a bit is
set, the corresponding adapter, queue (usage domain) or control domain
is assigned to the KVM guest.

This patch will set the bits in the APM, AQM and ADM fields of the
CRYCB referenced by the KVM guest's SIE state description. The process
used is:

1. Verify that the bits to be set do not exceed the maximum bit
   number for the given mask.

2. Verify that the APQNs that can be derived from the cross product
   of the bits set in the APM and AQM fields of the KVM guest's CRYCB
   are not assigned to any other KVM guest running on the same linux
   host.

3. Set the APM, AQM and ADM in the CRYCB according to the matrix
   configured for the mediated matrix device via its sysfs
   assign_adapter, assign_domain and assign_control domain attribute
   files respectively.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h  |    1 +
 drivers/s390/crypto/vfio_ap_ops.c |  201 +++++++++++++++++++++++++++++++++++++
 2 files changed, 202 insertions(+), 0 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index d44e0d5..79b2ccf 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -257,6 +257,7 @@ struct kvm_s390_sie_block {
 	__u64	tecmc;			/* 0x00e8 */
 	__u8	reservedf0[12];		/* 0x00f0 */
 #define CRYCB_FORMAT_MASK 0x00000003
+#define CRYCB_FORMAT0 0x00000000
 #define CRYCB_FORMAT1 0x00000001
 #define CRYCB_FORMAT2 0x00000003
 	__u32	crycbd;			/* 0x00fc */
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 58be495..98bd0a1 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -770,6 +770,201 @@ static int kvm_ap_validate_crypto_setup(struct kvm *kvm)
 	return -EOPNOTSUPP;
 }
 
+static inline unsigned long *
+kvm_ap_get_crycb_apm(struct ap_matrix_mdev *matrix_mdev)
+{
+	unsigned long *apm;
+	struct kvm *kvm = matrix_mdev->kvm;
+
+	switch (kvm->arch.crypto.crycbd & CRYCB_FORMAT_MASK) {
+	case CRYCB_FORMAT2:
+		apm = (unsigned long *)kvm->arch.crypto.crycb->apcb1.apm;
+		break;
+	case CRYCB_FORMAT1:
+	case CRYCB_FORMAT0:
+	default:
+		apm = (unsigned long *)kvm->arch.crypto.crycb->apcb0.apm;
+		break;
+	}
+
+	return apm;
+}
+
+static inline unsigned long *
+kvm_ap_get_crycb_aqm(struct ap_matrix_mdev *matrix_mdev)
+{
+	unsigned long *aqm;
+	struct kvm *kvm = matrix_mdev->kvm;
+
+	switch (kvm->arch.crypto.crycbd & CRYCB_FORMAT_MASK) {
+	case CRYCB_FORMAT2:
+		aqm = (unsigned long *)kvm->arch.crypto.crycb->apcb1.aqm;
+		break;
+	case CRYCB_FORMAT1:
+	case CRYCB_FORMAT0:
+	default:
+		aqm = (unsigned long *)kvm->arch.crypto.crycb->apcb0.aqm;
+		break;
+	}
+
+	return aqm;
+}
+
+static inline unsigned long *
+kvm_ap_get_crycb_adm(struct ap_matrix_mdev *matrix_mdev)
+{
+	unsigned long *adm;
+	struct kvm *kvm = matrix_mdev->kvm;
+
+	switch (kvm->arch.crypto.crycbd & CRYCB_FORMAT_MASK) {
+	case CRYCB_FORMAT2:
+		adm = (unsigned long *)kvm->arch.crypto.crycb->apcb1.adm;
+		break;
+	case CRYCB_FORMAT1:
+	case CRYCB_FORMAT0:
+	default:
+		adm = (unsigned long *)kvm->arch.crypto.crycb->apcb0.adm;
+		break;
+	}
+
+	return adm;
+}
+
+static inline void kvm_ap_clear_crycb_masks(struct ap_matrix_mdev *matrix_mdev)
+{
+	memset(&matrix_mdev->kvm->arch.crypto.crycb->apcb0, 0,
+	       sizeof(matrix_mdev->kvm->arch.crypto.crycb->apcb0));
+	memset(&matrix_mdev->kvm->arch.crypto.crycb->apcb1, 0,
+	       sizeof(matrix_mdev->kvm->arch.crypto.crycb->apcb1));
+}
+
+static void kvm_ap_set_crycb_masks(struct ap_matrix_mdev *matrix_mdev)
+{
+	int nbytes;
+	unsigned long *apm, *aqm, *adm;
+
+	kvm_ap_clear_crycb_masks(matrix_mdev);
+
+	apm = kvm_ap_get_crycb_apm(matrix_mdev);
+	aqm = kvm_ap_get_crycb_aqm(matrix_mdev);
+	adm = kvm_ap_get_crycb_adm(matrix_mdev);
+
+	nbytes = KVM_AP_MASK_BYTES(matrix_mdev->matrix.apm_max + 1);
+	memcpy(apm, matrix_mdev->matrix.apm, nbytes);
+
+	nbytes = KVM_AP_MASK_BYTES(matrix_mdev->matrix.aqm_max + 1);
+	memcpy(aqm, matrix_mdev->matrix.aqm, nbytes);
+
+	/*
+	 * Merge the AQM and ADM since the ADM is a superset of the
+	 * AQM by agreed-upon convention.
+	 */
+	bitmap_or(adm, matrix_mdev->matrix.adm, matrix_mdev->matrix.aqm,
+		  matrix_mdev->matrix.adm_max + 1);
+}
+
+static void kvm_ap_log_sharing_err(struct ap_matrix_mdev *matrix_mdev,
+				   unsigned long apid, unsigned long apqi)
+{
+	pr_err("%s: AP queue %02lx.%04lx is assigned to %s device", __func__,
+	       apid, apqi, matrix_mdev->name);
+}
+
+static int kvm_ap_find_matching_bits(unsigned long *dst, unsigned long *src1,
+				     unsigned long *src2, unsigned long nbits)
+{
+	unsigned long nbit;
+
+	for_each_set_bit_inv(nbit, src1, nbits) {
+		if (test_bit_inv(nbit, src2))
+			set_bit_inv(nbit, dst);
+	}
+
+	return find_first_bit_inv(dst, nbit) < nbits;
+}
+
+/**
+ * kvm_ap_validate_queue_sharing
+ *
+ * Verifies that the APQNs derived from the cross product of the AP adapter IDs
+ * and AP queue indexes comprising the AP matrix are not configured for
+ * another guest. AP queue sharing is not allowed.
+ *
+ * @kvm: the KVM guest
+ * @matrix: the AP matrix
+ *
+ * Returns 0 if the APQNs are valid, otherwise; returns -EBUSY.
+ */
+static int kvm_ap_validate_queue_sharing(struct ap_matrix_mdev *matrix_mdev)
+{
+	int ret;
+	struct ap_matrix_mdev *lstdev;
+	unsigned long apid, apqi;
+	unsigned long apm[BITS_TO_LONGS(matrix_mdev->matrix.apm_max + 1)];
+	unsigned long aqm[BITS_TO_LONGS(matrix_mdev->matrix.aqm_max + 1)];
+
+	spin_lock_bh(&mdev_list_lock);
+
+	list_for_each_entry(lstdev, &mdev_list, list) {
+		if (matrix_mdev == lstdev)
+			continue;
+
+		memset(apm, 0, BITS_TO_LONGS(matrix_mdev->matrix.apm_max + 1) *
+		       sizeof(unsigned long));
+		memset(aqm, 0, BITS_TO_LONGS(matrix_mdev->matrix.aqm_max + 1) *
+		       sizeof(unsigned long));
+
+		if (!kvm_ap_find_matching_bits(apm, matrix_mdev->matrix.apm,
+					       lstdev->matrix.apm,
+					       matrix_mdev->matrix.apm_max + 1))
+			continue;
+
+		if (!kvm_ap_find_matching_bits(aqm, matrix_mdev->matrix.aqm,
+					       lstdev->matrix.aqm,
+					       matrix_mdev->matrix.aqm_max + 1))
+			continue;
+
+		for_each_set_bit_inv(apid, apm, matrix_mdev->matrix.apm_max + 1)
+			for_each_set_bit_inv(apqi, aqm,
+					     matrix_mdev->matrix.aqm_max + 1)
+				kvm_ap_log_sharing_err(lstdev, apid, apqi);
+
+		ret = -EBUSY;
+		goto done;
+	}
+
+	ret = 0;
+
+done:
+	spin_unlock_bh(&mdev_list_lock);
+	return ret;
+}
+
+static int kvm_ap_configure_matrix(struct ap_matrix_mdev *matrix_mdev)
+{
+	int ret = 0;
+
+	mutex_lock(&matrix_mdev->kvm->lock);
+
+	ret = kvm_ap_validate_queue_sharing(matrix_mdev);
+	if (ret)
+		goto done;
+
+	kvm_ap_set_crycb_masks(matrix_mdev);
+
+done:
+	mutex_unlock(&matrix_mdev->kvm->lock);
+
+	return ret;
+}
+
+void kvm_ap_deconfigure_matrix(struct ap_matrix_mdev *matrix_mdev)
+{
+	mutex_lock(&matrix_mdev->kvm->lock);
+	kvm_ap_clear_crycb_masks(matrix_mdev);
+	mutex_unlock(&matrix_mdev->kvm->lock);
+}
+
 static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
 				       unsigned long action, void *data)
 {
@@ -852,6 +1047,10 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
 	if (ret)
 		goto out_kvm_err;
 
+	ret = kvm_ap_configure_matrix(matrix_mdev);
+	if (ret)
+		goto out_kvm_err;
+
 	return 0;
 
 out_kvm_err:
@@ -868,6 +1067,8 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
 {
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
+	kvm_ap_deconfigure_matrix(matrix_mdev);
+
 	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
 				 &matrix_mdev->group_notifier);
 	matrix_mdev->kvm = NULL;
-- 
1.7.1
