From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 14 Jun 2016 18:56:47 +0000
Subject: [GIT PULL 10/52] KVM: s390: forward ESOP if available
Message-Id: <201606141857.u5EIs1W0090467@mx0a-001b2d01.pphosted.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

ESOP guarantees that during a protection exception, bit 61 of real location
168-175 will only be set to 1 if it was because of ALCP or DATP. If the
exception is due to LAP or KCP, the bit will always be set to 0.

The old SOP definition allowed bit 61 to be unpredictable in case of LAP
or KCP in some conditions. So ESOP replaces this unpredictability by
a guarantee.

Therefore, we can directly forward ESOP if it is available on our machine.
We don't have to do anything when ESOP is disabled - the guest will simply
expect unpredictable values. Our guest access functions are already
handling ESOP properly.

Please note that future functionality in KVM will require knowledge about
ESOP being enabled for a guest or not.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/uapi/asm/kvm.h |  1 +
 arch/s390/kvm/kvm-s390.c         | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index a8559f2..789c4e2 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -97,6 +97,7 @@ struct kvm_s390_vm_cpu_machine {
 #define KVM_S390_VM_CPU_MACHINE_FEAT	3
 
 #define KVM_S390_VM_CPU_FEAT_NR_BITS	1024
+#define KVM_S390_VM_CPU_FEAT_ESOP	0
 struct kvm_s390_vm_cpu_feat {
 	__u64 feat[16];
 };
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 6960468..2b5c14d 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -193,6 +193,17 @@ void kvm_arch_hardware_unsetup(void)
 					 &kvm_clock_notifier);
 }
 
+static void allow_cpu_feat(unsigned long nr)
+{
+	set_bit_inv(nr, kvm_s390_available_cpu_feat);
+}
+
+static void kvm_s390_cpu_feat_init(void)
+{
+	if (MACHINE_HAS_ESOP)
+		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ESOP);
+}
+
 int kvm_arch_init(void *opaque)
 {
 	kvm_s390_dbf = debug_register("kvm-trace", 32, 1, 7 * sizeof(long));
@@ -204,6 +215,8 @@ int kvm_arch_init(void *opaque)
 		return -ENOMEM;
 	}
 
+	kvm_s390_cpu_feat_init();
+
 	/* Register floating interrupt controller interface. */
 	return kvm_register_device_ops(&kvm_flic_ops, KVM_DEV_TYPE_FLIC);
 }
-- 
2.5.5
