From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v4 08/15] KVM: s390: interfaces to (de)configure guest's AP matrix
Date: Sun, 15 Apr 2018 17:22:18 -0400
Message-ID: <1523827345-11600-9-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Provides interfaces to assign AP adapters, usage domains
and control domains to a KVM guest.

A KVM guest is started by executing the Start Interpretive Execution (SIE)
instruction. The SIE state description is a control block that contains the
state information for a KVM guest and is supplied as input to the SIE
instruction. The SIE state description has a satellite structure called the
Crypto Control Block (CRYCB). The CRYCB contains three bitmask fields
identifying the adapters, queues (domains) and control domains assigned to
the KVM guest:

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

2. Verify that the APQNs that can be derived from the intersection
   of the bits set in the APM and AQM fields of the KVM guest's CRYCB
   are not assigned to any other KVM guest running on the same linux
   host.

3. Set the APM, AQM and ADM in the CRYCB according to the matrix
   configured for the mediated matrix device via its sysfs
   adapter, domain and control domain attribute files respectively.

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 arch/s390/include/asm/kvm-ap.h        |   79 ++++++++++
 arch/s390/kvm/kvm-ap.c                |  259 +++++++++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c     |   19 +++
 drivers/s390/crypto/vfio_ap_private.h |    4 +
 4 files changed, 361 insertions(+), 0 deletions(-)

diff --git a/arch/s390/include/asm/kvm-ap.h b/arch/s390/include/asm/kvm-ap.h
index a6c092e..a068244 100644
--- a/arch/s390/include/asm/kvm-ap.h
+++ b/arch/s390/include/asm/kvm-ap.h
@@ -12,6 +12,34 @@
 
 #include <linux/types.h>
 #include <linux/kvm_host.h>
+#include <linux/types.h>
+#include <linux/kvm_host.h>
+#include <linux/bitops.h>
+
+#define KVM_AP_MASK_BYTES(n)	DIV_ROUND_UP(n, BITS_PER_BYTE)
+
+/**
+ * The AP matrix is comprised of three bit masks identifying the adapters,
+ * queues (domains) and control domains that belong to an AP matrix. The bits in
+ * each mask, from least significant to most significant bit, correspond to IDs
+ * 0 to the maximum ID allowed for a given mask. When a bit is set, the
+ * corresponding ID belongs to the matrix.
+ *
+ * @apm_max: max number of bits in @apm
+ * @apm identifies the AP adapters in the matrix
+ * @aqm_max: max number of bits in @aqm
+ * @aqm identifies the AP queues (domains) in the matrix
+ * @adm_max: max number of bits in @adm
+ * @adm identifies the AP control domains in the matrix
+ */
+struct kvm_ap_matrix {
+	int apm_max;
+	unsigned long *apm;
+	int aqm_max;
+	unsigned long *aqm;
+	int adm_max;
+	unsigned long *adm;
+};
 
 /**
  * kvm_ap_instructions_installed()
@@ -51,4 +79,55 @@
  */
 int kvm_ap_interpret_instructions(struct kvm *kvm, bool enable);
 
+/**
+ * kvm_ap_matrix_create
+ *
+ * Create an AP matrix to hold a configuration of AP adapters, domains and
+ * control domains.
+ *
+ * @ap_matrix: holds the matrix that is created
+ *
+ * Returns 0 if the matrix is successfully created. Returns an error if an APQN
+ * derived from the cross product of the AP adapter IDs and AP queue indexes
+ * comprising the AP matrix is configured for another guest.
+ */
+int kvm_ap_matrix_create(struct kvm_ap_matrix **ap_matrix);
+
+/**
+ * kvm_ap_matrix_destroy
+ *
+ * Destroy an AP matrix by de-allocating all storage allocated by the
+ * kvm_ap_matrix_create function.
+ *
+ * @ap_matrix: the matrix to destroy
+ */
+void kvm_ap_matrix_destroy(struct kvm_ap_matrix *ap_matrix);
+
+/**
+ * kvm_ap_configure_matrix
+ *
+ * Configure the AP matrix for a KVM guest.
+ *
+ * @kvm:		 the KVM guest
+ * @matrix:		 the matrix configuration information
+ *
+ * Returns 0 if:
+ *	1. The AP instructions are installed on the guest
+ *	2. The APQNs derived from the intersection of the set of adapter
+ *	   IDs (APM) and queue indexes (AQM) in @matrix are not configured for
+ *	   any other KVM guest running on the same linux host.
+ * Otherwise returns an error code.
+ */
+int kvm_ap_configure_matrix(struct kvm *kvm, struct kvm_ap_matrix *matrix);
+
+/**
+ * kvm_ap_deconfigure_matrix
+ *
+ * Deconfigure the AP matrix for a KVM guest. Clears all of the bits in the
+ * APM, AQM and ADM in the guest's CRYCB.
+ *
+ * @kvm: the KVM guest
+ */
+void kvm_ap_deconfigure_matrix(struct kvm *kvm);
+
 #endif /* _ASM_KVM_AP */
diff --git a/arch/s390/kvm/kvm-ap.c b/arch/s390/kvm/kvm-ap.c
index 55d11b5..f7226d8 100644
--- a/arch/s390/kvm/kvm-ap.c
+++ b/arch/s390/kvm/kvm-ap.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <asm/kvm-ap.h>
 #include <asm/ap.h>
+#include <linux/bitops.h>
 
 #include "kvm-s390.h"
 
@@ -78,3 +79,261 @@ int kvm_ap_interpret_instructions(struct kvm *kvm, bool enable)
 	return ret;
 }
 EXPORT_SYMBOL(kvm_ap_interpret_instructions);
+
+static inline void kvm_ap_clear_crycb_masks(struct kvm *kvm)
+{
+	memset(&kvm->arch.crypto.crycb->apcb0, 0,
+	       sizeof(kvm->arch.crypto.crycb->apcb0));
+	memset(&kvm->arch.crypto.crycb->apcb1, 0,
+	       sizeof(kvm->arch.crypto.crycb->apcb1));
+}
+
+static inline unsigned long *kvm_ap_get_crycb_apm(struct kvm *kvm)
+{
+	unsigned long *apm;
+
+	switch (kvm->arch.crypto.crycbd & CRYCB_FORMAT_MASK) {
+	case CRYCB_FORMAT1:
+		apm = (unsigned long *)kvm->arch.crypto.crycb->apcb0.apm;
+		break;
+	case CRYCB_FORMAT2:
+		apm = (unsigned long *)kvm->arch.crypto.crycb->apcb1.apm;
+		break;
+	default:
+		apm = (unsigned long *)kvm->arch.crypto.crycb->apcb0.apm;
+		break;
+	}
+
+	return apm;
+}
+
+static inline unsigned long *kvm_ap_get_crycb_aqm(struct kvm *kvm)
+{
+	unsigned long *aqm;
+
+	switch (kvm->arch.crypto.crycbd & CRYCB_FORMAT_MASK) {
+	case CRYCB_FORMAT1:
+		aqm = (unsigned long *)kvm->arch.crypto.crycb->apcb0.aqm;
+		break;
+	case CRYCB_FORMAT2:
+		aqm = (unsigned long *)kvm->arch.crypto.crycb->apcb1.aqm;
+		break;
+	default:
+		aqm = (unsigned long *)kvm->arch.crypto.crycb->apcb0.aqm;
+		break;
+	}
+
+	return aqm;
+}
+
+static inline unsigned long *kvm_ap_get_crycb_adm(struct kvm *kvm)
+{
+	unsigned long *adm;
+
+	switch (kvm->arch.crypto.crycbd & CRYCB_FORMAT_MASK) {
+	case CRYCB_FORMAT1:
+		adm = (unsigned long *)kvm->arch.crypto.crycb->apcb0.adm;
+		break;
+	case CRYCB_FORMAT2:
+		adm = (unsigned long *)kvm->arch.crypto.crycb->apcb1.adm;
+		break;
+	default:
+		adm = (unsigned long *)kvm->arch.crypto.crycb->apcb0.adm;
+		break;
+	}
+
+	return adm;
+}
+
+static void kvm_ap_set_crycb_masks(struct kvm *kvm,
+				   struct kvm_ap_matrix *matrix)
+{
+	unsigned long *apm = kvm_ap_get_crycb_apm(kvm);
+	unsigned long *aqm = kvm_ap_get_crycb_aqm(kvm);
+	unsigned long *adm = kvm_ap_get_crycb_adm(kvm);
+
+	kvm_ap_clear_crycb_masks(kvm);
+	memcpy(apm, matrix->apm, KVM_AP_MASK_BYTES(matrix->apm_max));
+	memcpy(aqm, matrix->aqm, KVM_AP_MASK_BYTES(matrix->aqm_max));
+
+	/*
+	 * Merge the AQM and ADM since the ADM is a superset of the
+	 * AQM by agreed-upon convention.
+	 */
+	bitmap_or(adm, adm, aqm, matrix->adm_max);
+}
+
+static void kvm_ap_log_sharing_err(struct kvm *kvm, unsigned long apid,
+				   unsigned long apqi)
+{
+	pr_err("%s: AP queue %02lx.%04lx is registered to guest %s", __func__,
+	       apid, apqi, kvm->arch.dbf->name);
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
+static int kvm_ap_validate_queue_sharing(struct kvm *kvm,
+					 struct kvm_ap_matrix *matrix)
+{
+	struct kvm *vm;
+	unsigned long *apm, *aqm;
+	unsigned long apid, apqi;
+
+
+	/* No other VM may share an AP Queue with the input VM */
+	list_for_each_entry(vm, &vm_list, vm_list) {
+		if (kvm == vm)
+			continue;
+
+		apm = kvm_ap_get_crycb_apm(vm);
+		if (!bitmap_and(apm, apm, matrix->apm, matrix->apm_max))
+			continue;
+
+		aqm = kvm_ap_get_crycb_aqm(vm);
+		if (!bitmap_and(aqm, aqm, matrix->aqm, matrix->aqm_max))
+			continue;
+
+		for_each_set_bit_inv(apid, apm, matrix->apm_max)
+			for_each_set_bit_inv(apqi, aqm, matrix->aqm_max)
+				kvm_ap_log_sharing_err(kvm, apid, apqi);
+
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int kvm_ap_matrix_apm_create(struct kvm_ap_matrix *ap_matrix,
+				    struct ap_config_info *config)
+{
+	int apm_max = (config && config->apxa) ? config->Na + 1 : 16;
+
+	ap_matrix->apm = kzalloc(KVM_AP_MASK_BYTES(apm_max), GFP_KERNEL);
+	if (!ap_matrix->apm)
+		return -ENOMEM;
+
+	ap_matrix->apm_max = apm_max;
+
+	return 0;
+}
+
+static int kvm_ap_matrix_aqm_create(struct kvm_ap_matrix *ap_matrix,
+				    struct ap_config_info *config)
+{
+	int aqm_max = (config && config->apxa) ? config->Nd + 1 : 16;
+
+	ap_matrix->aqm = kzalloc(KVM_AP_MASK_BYTES(aqm_max), GFP_KERNEL);
+	if (!ap_matrix->aqm)
+		return -ENOMEM;
+
+	ap_matrix->aqm_max = aqm_max;
+
+	return 0;
+}
+
+static int kvm_ap_matrix_adm_create(struct kvm_ap_matrix *ap_matrix,
+				    struct ap_config_info *config)
+{
+	int adm_max = (config && config->apxa) ? config->Nd + 1 : 16;
+
+	ap_matrix->adm = kzalloc(KVM_AP_MASK_BYTES(adm_max), GFP_KERNEL);
+	if (!ap_matrix->adm)
+		return -ENOMEM;
+
+	ap_matrix->adm_max = adm_max;
+
+	return 0;
+}
+
+static void kvm_ap_matrix_masks_destroy(struct kvm_ap_matrix *ap_matrix)
+{
+	kfree(ap_matrix->apm);
+	kfree(ap_matrix->aqm);
+	kfree(ap_matrix->adm);
+}
+
+int kvm_ap_matrix_create(struct kvm_ap_matrix **ap_matrix)
+{
+	int ret;
+	struct kvm_ap_matrix *matrix;
+	struct ap_config_info config;
+	struct ap_config_info *config_info = NULL;
+
+	memset(&config, 0, sizeof(config));
+
+	ret = ap_query_configuration(&config);
+	if (ret) {
+		if (ret != -EOPNOTSUPP)
+			return ret;
+	} else {
+		config_info = &config;
+	}
+
+	matrix = kzalloc(sizeof(*matrix), GFP_KERNEL);
+	if (!matrix)
+		return -ENOMEM;
+
+	ret = kvm_ap_matrix_apm_create(matrix, config_info);
+	if (ret)
+		goto mask_create_err;
+
+	ret = kvm_ap_matrix_aqm_create(matrix, config_info);
+	if (ret)
+		goto mask_create_err;
+
+	ret = kvm_ap_matrix_adm_create(matrix, config_info);
+	if (ret)
+		goto mask_create_err;
+
+	*ap_matrix = matrix;
+
+	return 0;
+
+mask_create_err:
+	kvm_ap_matrix_masks_destroy(matrix);
+	kfree(matrix);
+	return ret;
+}
+EXPORT_SYMBOL(kvm_ap_matrix_create);
+
+void kvm_ap_matrix_destroy(struct kvm_ap_matrix *ap_matrix)
+{
+	kvm_ap_matrix_masks_destroy(ap_matrix);
+	kfree(ap_matrix);
+}
+EXPORT_SYMBOL(kvm_ap_matrix_destroy);
+
+int kvm_ap_configure_matrix(struct kvm *kvm, struct kvm_ap_matrix *matrix)
+{
+	int ret = 0;
+
+	mutex_lock(&kvm->lock);
+
+	ret = kvm_ap_validate_queue_sharing(kvm, matrix);
+	if (ret)
+		goto done;
+
+	kvm_ap_set_crycb_masks(kvm, matrix);
+
+done:
+	mutex_unlock(&kvm->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(kvm_ap_configure_matrix);
+
+void kvm_ap_deconfigure_matrix(struct kvm *kvm)
+{
+	kvm_ap_clear_crycb_masks(kvm);
+}
+EXPORT_SYMBOL(kvm_ap_deconfigure_matrix);
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index d41b0b8..647ea24 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -10,6 +10,7 @@
 #include <linux/device.h>
 #include <linux/list.h>
 #include <linux/ctype.h>
+#include <asm/kvm-ap.h>
 
 #include "vfio_ap_private.h"
 
@@ -18,8 +19,23 @@
 
 static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
 {
+	int ret;
+	struct ap_matrix_mdev *matrix_mdev;
 	struct ap_matrix *ap_matrix = to_ap_matrix(mdev_parent_dev(mdev));
+	struct kvm_ap_matrix *matrix;
+
+	ret = kvm_ap_matrix_create(&matrix);
+	if (ret)
+		return ret;
+
+	matrix_mdev = kzalloc(sizeof(*matrix_mdev), GFP_KERNEL);
+	if (!matrix_mdev) {
+		kvm_ap_matrix_destroy(matrix);
+		return -ENOMEM;
+	}
 
+	matrix_mdev->matrix = matrix;
+	mdev_set_drvdata(mdev, matrix_mdev);
 	ap_matrix->available_instances--;
 
 	return 0;
@@ -28,7 +44,10 @@ static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
 static int vfio_ap_mdev_remove(struct mdev_device *mdev)
 {
 	struct ap_matrix *ap_matrix = to_ap_matrix(mdev_parent_dev(mdev));
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
+	kvm_ap_matrix_destroy(matrix_mdev->matrix);
+	kfree(matrix_mdev);
 	ap_matrix->available_instances++;
 
 	return 0;
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index c47aeec..f248faf 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -29,6 +29,10 @@ struct ap_matrix {
 	int available_instances;
 };
 
+struct ap_matrix_mdev {
+	struct kvm_ap_matrix *matrix;
+};
+
 static inline struct ap_matrix *to_ap_matrix(struct device *dev)
 {
 	return container_of(dev, struct ap_matrix, device);
-- 
1.7.1
