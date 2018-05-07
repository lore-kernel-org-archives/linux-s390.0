From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v5 06/13] KVM: s390: interfaces to manage guest's AP matrix
Date: Mon,  7 May 2018 11:11:45 -0400
Message-ID: <1525705912-12815-7-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Provides interfaces to manage the AP adapters, usage domains
and control domains assigned to a KVM guest.

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

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 arch/s390/include/asm/kvm-ap.h   |   52 ++++++++++++
 arch/s390/include/asm/kvm_host.h |    1 +
 arch/s390/kvm/kvm-ap.c           |  161 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 214 insertions(+), 0 deletions(-)

diff --git a/arch/s390/include/asm/kvm-ap.h b/arch/s390/include/asm/kvm-ap.h
index 6af1ff8..21fe9f2 100644
--- a/arch/s390/include/asm/kvm-ap.h
+++ b/arch/s390/include/asm/kvm-ap.h
@@ -12,8 +12,33 @@
 
 #include <linux/types.h>
 #include <linux/kvm_host.h>
+#include <linux/bitops.h>
 #include <asm/ap.h>
 
+#define KVM_AP_MASK_BYTES(n)	DIV_ROUND_UP(n, BITS_PER_BYTE)
+
+/**
+ * The AP matrix is comprised of three bit masks identifying the adapters,
+ * queues (domains) and control domains that belong to an AP matrix. The bits in
+ * each mask, from least significant to most significant bit, correspond to IDs
+ * 0 to 255. When a bit is set, the corresponding ID belongs to the matrix.
+ *
+ * @apm identifies the AP adapters in the matrix
+ * @apm_max: max adapter number in @apm
+ * @aqm identifies the AP queues (domains) in the matrix
+ * @aqm_max: max domain number in @aqm
+ * @adm identifies the AP control domains in the matrix
+ * @adm_max: max domain number in @adm
+ */
+struct kvm_ap_matrix {
+	unsigned long apm_max;
+	DECLARE_BITMAP(apm, 256);
+	unsigned long aqm_max;
+	DECLARE_BITMAP(aqm, 256);
+	unsigned long adm_max;
+	DECLARE_BITMAP(adm, 256);
+};
+
 /**
  * kvm_ap_apxa_installed
  *
@@ -57,4 +82,31 @@
  */
 bool kvm_ap_instructions_available(void);
 
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
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index ef4b237..8736cde 100644
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
diff --git a/arch/s390/kvm/kvm-ap.c b/arch/s390/kvm/kvm-ap.c
index 00bcfb0..98b53c7 100644
--- a/arch/s390/kvm/kvm-ap.c
+++ b/arch/s390/kvm/kvm-ap.c
@@ -7,6 +7,7 @@
  * Author(s): Tony Krowiak <akrowia@linux.vnet.ibm.com>
  */
 #include <linux/kernel.h>
+#include <linux/bitops.h>
 #include <asm/kvm-ap.h>
 
 #include "kvm-s390.h"
@@ -81,3 +82,163 @@ int kvm_ap_apxa_installed(void)
 	return 0;
 }
 EXPORT_SYMBOL(kvm_ap_apxa_installed);
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
+static inline unsigned long *kvm_ap_get_crycb_aqm(struct kvm *kvm)
+{
+	unsigned long *aqm;
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
+static inline unsigned long *kvm_ap_get_crycb_adm(struct kvm *kvm)
+{
+	unsigned long *adm;
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
+static void kvm_ap_set_crycb_masks(struct kvm *kvm,
+				   struct kvm_ap_matrix *matrix)
+{
+	int nbytes;
+	unsigned long *apm = kvm_ap_get_crycb_apm(kvm);
+	unsigned long *aqm = kvm_ap_get_crycb_aqm(kvm);
+	unsigned long *adm = kvm_ap_get_crycb_adm(kvm);
+
+	kvm_ap_clear_crycb_masks(kvm);
+
+	nbytes = KVM_AP_MASK_BYTES(matrix->apm_max + 1);
+	memcpy(apm, matrix->apm, nbytes);
+
+	nbytes = KVM_AP_MASK_BYTES(matrix->aqm_max + 1);
+	memcpy(aqm, matrix->aqm, nbytes);
+
+	/*
+	 * Merge the AQM and ADM since the ADM is a superset of the
+	 * AQM by agreed-upon convention.
+	 */
+	bitmap_or(adm, matrix->adm, matrix->aqm, matrix->adm_max + 1);
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
+		if (!bitmap_and(apm, apm, matrix->apm, matrix->apm_max + 1))
+			continue;
+
+		aqm = kvm_ap_get_crycb_aqm(vm);
+		if (!bitmap_and(aqm, aqm, matrix->aqm, matrix->aqm_max + 1))
+			continue;
+
+		for_each_set_bit_inv(apid, apm, matrix->apm_max + 1)
+			for_each_set_bit_inv(apqi, aqm, matrix->aqm_max + 1)
+				kvm_ap_log_sharing_err(vm, apid, apqi);
+
+		return -EBUSY;
+	}
+
+	return 0;
+}
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
-- 
1.7.1
