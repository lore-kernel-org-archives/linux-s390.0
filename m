From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 18/52] KVM: s390: interface to query and configure cpu subfunctions
Date: Tue, 14 Jun 2016 20:56:55 +0200
Message-ID: <1465930649-181383-19-git-send-email-borntraeger@de.ibm.com>
References: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

We have certain instructions that indicate available subfunctions via
a query subfunction (crypto functions and ptff), or via a test bit
function (plo).

By exposing these "subfunction blocks" to user space, we allow user space
to
1) query available subfunctions and make sure subfunctions won't get lost
   during migration - e.g. properly indicate them via a CPU model
2) change the subfunctions to be reported to the guest (even adding
   unavailable ones)

This mechanism works just like the way we indicate the stfl(e) list to
user space.

This way, user space could even emulate some subfunctions in QEMU in the
future. If this is ever applicable, we have to make sure later on, that
unsupported subfunctions result in an intercept to QEMU.

Please note that support to indicate them to the guest is still missing
and requires hardware support. Usually, the IBC takes already care of these
subfunctions for migration safety. QEMU should make sure to always set
these bits properly according to the machine generation to be emulated.

Available subfunctions are only valid in combination with STFLE bits
retrieved via KVM_S390_VM_CPU_MACHINE and enabled via
KVM_S390_VM_CPU_PROCESSOR. If the applicable bits are available, the
indicated subfunctions are guaranteed to be correct.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/devices/vm.txt | 57 ++++++++++++++++++++
 arch/s390/include/uapi/asm/kvm.h         | 20 +++++++
 arch/s390/kvm/kvm-s390.c                 | 89 ++++++++++++++++++++++++++++++++
 3 files changed, 166 insertions(+)

diff --git a/Documentation/virtual/kvm/devices/vm.txt b/Documentation/virtual/kvm/devices/vm.txt
index 0ed6808..8a458f4 100644
--- a/Documentation/virtual/kvm/devices/vm.txt
+++ b/Documentation/virtual/kvm/devices/vm.txt
@@ -112,6 +112,63 @@ Returns:    -EFAULT if the given address is not accessible from kernel space.
 	    -EBUSY if at least one VCPU has already been defined.
 	    0 in case of success.
 
+2.5. ATTRIBUTE: KVM_S390_VM_CPU_MACHINE_SUBFUNC (r/o)
+
+Allows user space to retrieve available cpu subfunctions without any filtering
+done by a set IBC. These subfunctions are indicated to the guest VCPU via
+query or "test bit" subfunctions and used e.g. by cpacf functions, plo and ptff.
+
+A subfunction block is only valid if KVM_S390_VM_CPU_MACHINE contains the
+STFL(E) bit introducing the affected instruction. If the affected instruction
+indicates subfunctions via a "query subfunction", the response block is
+contained in the returned struct. If the affected instruction
+indicates subfunctions via a "test bit" mechanism, the subfunction codes are
+contained in the returned struct in MSB 0 bit numbering.
+
+struct kvm_s390_vm_cpu_subfunc {
+       u8 plo[32];           # always valid (ESA/390 feature)
+       u8 ptff[16];          # valid with TOD-clock steering
+       u8 kmac[16];          # valid with Message-Security-Assist
+       u8 kmc[16];           # valid with Message-Security-Assist
+       u8 km[16];            # valid with Message-Security-Assist
+       u8 kimd[16];          # valid with Message-Security-Assist
+       u8 klmd[16];          # valid with Message-Security-Assist
+       u8 pckmo[16];         # valid with Message-Security-Assist-Extension 3
+       u8 kmctr[16];         # valid with Message-Security-Assist-Extension 4
+       u8 kmf[16];           # valid with Message-Security-Assist-Extension 4
+       u8 kmo[16];           # valid with Message-Security-Assist-Extension 4
+       u8 pcc[16];           # valid with Message-Security-Assist-Extension 4
+       u8 ppno[16];          # valid with Message-Security-Assist-Extension 5
+       u8 reserved[1824];    # reserved for future instructions
+};
+
+Parameters: address of a buffer to load the subfunction blocks from.
+Returns:    -EFAULT if the given address is not accessible from kernel space.
+	    0 in case of success.
+
+2.6. ATTRIBUTE: KVM_S390_VM_CPU_PROCESSOR_SUBFUNC (r/w)
+
+Allows user space to retrieve or change cpu subfunctions to be indicated for
+all VCPUs of a VM. This attribute will only be available if kernel and
+hardware support are in place.
+
+The kernel uses the configured subfunction blocks for indication to
+the guest. A subfunction block will only be used if the associated STFL(E) bit
+has not been disabled by user space (so the instruction to be queried is
+actually available for the guest).
+
+As long as no data has been written, a read will fail. The IBC will be used
+to determine available subfunctions in this case, this will guarantee backward
+compatibility.
+
+See 2.5. for a description of the parameter struct.
+
+Parameters: address of a buffer to store/load the subfunction blocks from.
+Returns:    -EFAULT if the given address is not accessible from kernel space.
+	    -EINVAL when reading, if there was no write yet.
+	    -EBUSY if at least one VCPU has already been defined.
+	    0 in case of success.
+
 3. GROUP: KVM_S390_VM_TOD
 Architectures: s390
 
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 789c4e2..f0818d7 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -102,6 +102,26 @@ struct kvm_s390_vm_cpu_feat {
 	__u64 feat[16];
 };
 
+#define KVM_S390_VM_CPU_PROCESSOR_SUBFUNC	4
+#define KVM_S390_VM_CPU_MACHINE_SUBFUNC		5
+/* for "test bit" instructions MSB 0 bit ordering, for "query" raw blocks */
+struct kvm_s390_vm_cpu_subfunc {
+	__u8 plo[32];		/* always */
+	__u8 ptff[16];		/* with TOD-clock steering */
+	__u8 kmac[16];		/* with MSA */
+	__u8 kmc[16];		/* with MSA */
+	__u8 km[16];		/* with MSA */
+	__u8 kimd[16];		/* with MSA */
+	__u8 klmd[16];		/* with MSA */
+	__u8 pckmo[16];		/* with MSA3 */
+	__u8 kmctr[16];		/* with MSA4 */
+	__u8 kmf[16];		/* with MSA4 */
+	__u8 kmo[16];		/* with MSA4 */
+	__u8 pcc[16];		/* with MSA4 */
+	__u8 ppno[16];		/* with MSA5 */
+	__u8 reserved[1824];
+};
+
 /* kvm attributes for crypto */
 #define KVM_S390_VM_CRYPTO_ENABLE_AES_KW	0
 #define KVM_S390_VM_CRYPTO_ENABLE_DEA_KW	1
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 2b5c14d..f746a35 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -36,6 +36,8 @@
 #include <asm/switch_to.h>
 #include <asm/isc.h>
 #include <asm/sclp.h>
+#include <asm/cpacf.h>
+#include <asm/etr.h>
 #include "kvm-s390.h"
 #include "gaccess.h"
 
@@ -135,6 +137,8 @@ unsigned long kvm_s390_fac_list_mask_size(void)
 
 /* available cpu features supported by kvm */
 static DECLARE_BITMAP(kvm_s390_available_cpu_feat, KVM_S390_VM_CPU_FEAT_NR_BITS);
+/* available subfunctions indicated via query / "test bit" */
+static struct kvm_s390_vm_cpu_subfunc kvm_s390_available_subfunc;
 
 static struct gmap_notifier gmap_notifier;
 debug_info_t *kvm_s390_dbf;
@@ -198,8 +202,52 @@ static void allow_cpu_feat(unsigned long nr)
 	set_bit_inv(nr, kvm_s390_available_cpu_feat);
 }
 
+static inline int plo_test_bit(unsigned char nr)
+{
+	register unsigned long r0 asm("0") = (unsigned long) nr | 0x100;
+	int cc = 3; /* subfunction not available */
+
+	asm volatile(
+		/* Parameter registers are ignored for "test bit" */
+		"	plo	0,0,0,0(0)\n"
+		"	ipm	%0\n"
+		"	srl	%0,28\n"
+		: "=d" (cc)
+		: "d" (r0)
+		: "cc");
+	return cc == 0;
+}
+
 static void kvm_s390_cpu_feat_init(void)
 {
+	int i;
+
+	for (i = 0; i < 256; ++i) {
+		if (plo_test_bit(i))
+			kvm_s390_available_subfunc.plo[i >> 3] |= 0x80 >> (i & 7);
+	}
+
+	if (test_facility(28)) /* TOD-clock steering */
+		etr_ptff(kvm_s390_available_subfunc.ptff, ETR_PTFF_QAF);
+
+	if (test_facility(17)) { /* MSA */
+		__cpacf_query(CPACF_KMAC, kvm_s390_available_subfunc.kmac);
+		__cpacf_query(CPACF_KMC, kvm_s390_available_subfunc.kmc);
+		__cpacf_query(CPACF_KM, kvm_s390_available_subfunc.km);
+		__cpacf_query(CPACF_KIMD, kvm_s390_available_subfunc.kimd);
+		__cpacf_query(CPACF_KLMD, kvm_s390_available_subfunc.klmd);
+	}
+	if (test_facility(76)) /* MSA3 */
+		__cpacf_query(CPACF_PCKMO, kvm_s390_available_subfunc.pckmo);
+	if (test_facility(77)) { /* MSA4 */
+		__cpacf_query(CPACF_KMCTR, kvm_s390_available_subfunc.kmctr);
+		__cpacf_query(CPACF_KMF, kvm_s390_available_subfunc.kmf);
+		__cpacf_query(CPACF_KMO, kvm_s390_available_subfunc.kmo);
+		__cpacf_query(CPACF_PCC, kvm_s390_available_subfunc.pcc);
+	}
+	if (test_facility(57)) /* MSA5 */
+		__cpacf_query(CPACF_PPNO, kvm_s390_available_subfunc.ppno);
+
 	if (MACHINE_HAS_ESOP)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ESOP);
 }
@@ -717,6 +765,16 @@ static int kvm_s390_set_processor_feat(struct kvm *kvm,
 	return ret;
 }
 
+static int kvm_s390_set_processor_subfunc(struct kvm *kvm,
+					  struct kvm_device_attr *attr)
+{
+	/*
+	 * Once supported by kernel + hw, we have to store the subfunctions
+	 * in kvm->arch and remember that user space configured them.
+	 */
+	return -ENXIO;
+}
+
 static int kvm_s390_set_cpu_model(struct kvm *kvm, struct kvm_device_attr *attr)
 {
 	int ret = -ENXIO;
@@ -728,6 +786,9 @@ static int kvm_s390_set_cpu_model(struct kvm *kvm, struct kvm_device_attr *attr)
 	case KVM_S390_VM_CPU_PROCESSOR_FEAT:
 		ret = kvm_s390_set_processor_feat(kvm, attr);
 		break;
+	case KVM_S390_VM_CPU_PROCESSOR_SUBFUNC:
+		ret = kvm_s390_set_processor_subfunc(kvm, attr);
+		break;
 	}
 	return ret;
 }
@@ -801,6 +862,25 @@ static int kvm_s390_get_machine_feat(struct kvm *kvm,
 	return 0;
 }
 
+static int kvm_s390_get_processor_subfunc(struct kvm *kvm,
+					  struct kvm_device_attr *attr)
+{
+	/*
+	 * Once we can actually configure subfunctions (kernel + hw support),
+	 * we have to check if they were already set by user space, if so copy
+	 * them from kvm->arch.
+	 */
+	return -ENXIO;
+}
+
+static int kvm_s390_get_machine_subfunc(struct kvm *kvm,
+					struct kvm_device_attr *attr)
+{
+	if (copy_to_user((void __user *)attr->addr, &kvm_s390_available_subfunc,
+	    sizeof(struct kvm_s390_vm_cpu_subfunc)))
+		return -EFAULT;
+	return 0;
+}
 static int kvm_s390_get_cpu_model(struct kvm *kvm, struct kvm_device_attr *attr)
 {
 	int ret = -ENXIO;
@@ -818,6 +898,12 @@ static int kvm_s390_get_cpu_model(struct kvm *kvm, struct kvm_device_attr *attr)
 	case KVM_S390_VM_CPU_MACHINE_FEAT:
 		ret = kvm_s390_get_machine_feat(kvm, attr);
 		break;
+	case KVM_S390_VM_CPU_PROCESSOR_SUBFUNC:
+		ret = kvm_s390_get_processor_subfunc(kvm, attr);
+		break;
+	case KVM_S390_VM_CPU_MACHINE_SUBFUNC:
+		ret = kvm_s390_get_machine_subfunc(kvm, attr);
+		break;
 	}
 	return ret;
 }
@@ -903,8 +989,11 @@ static int kvm_s390_vm_has_attr(struct kvm *kvm, struct kvm_device_attr *attr)
 		case KVM_S390_VM_CPU_MACHINE:
 		case KVM_S390_VM_CPU_PROCESSOR_FEAT:
 		case KVM_S390_VM_CPU_MACHINE_FEAT:
+		case KVM_S390_VM_CPU_MACHINE_SUBFUNC:
 			ret = 0;
 			break;
+		/* configuring subfunctions is not supported yet */
+		case KVM_S390_VM_CPU_PROCESSOR_SUBFUNC:
 		default:
 			ret = -ENXIO;
 			break;
-- 
2.5.5
