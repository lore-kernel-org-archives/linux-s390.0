From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 22 Feb 2019 11:42:28 +0000
Subject: [GIT PULL 17/18] KVM: s390: implement subfunction processor calls
Message-Id: <1550835749-26436-18-git-send-email-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

While we will not implement interception for query functions yet, we can
and should disable functions that have a control bit based on the given
CPU model.

Let us start with enabling the subfunction interface.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 arch/s390/include/asm/kvm_host.h |  1 +
 arch/s390/kvm/kvm-s390.c         | 35 ++++++++++++++++++++++-------------
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index c5f5156..3369677 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -711,6 +711,7 @@ struct s390_io_adapter {
 struct kvm_s390_cpu_model {
 	/* facility mask supported by kvm & hosting machine */
 	__u64 fac_mask[S390_ARCH_FAC_LIST_SIZE_U64];
+	struct kvm_s390_vm_cpu_subfunc subfuncs;
 	/* facility list requested by guest (in dma page) */
 	__u64 *fac_list;
 	u64 cpuid;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 2e47c72..82a95af 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1266,11 +1266,20 @@ static int kvm_s390_set_processor_feat(struct kvm *kvm,
 static int kvm_s390_set_processor_subfunc(struct kvm *kvm,
 					  struct kvm_device_attr *attr)
 {
-	/*
-	 * Once supported by kernel + hw, we have to store the subfunctions
-	 * in kvm->arch and remember that user space configured them.
-	 */
-	return -ENXIO;
+	mutex_lock(&kvm->lock);
+	if (kvm->created_vcpus) {
+		mutex_unlock(&kvm->lock);
+		return -EBUSY;
+	}
+
+	if (copy_from_user(&kvm->arch.model.subfuncs, (void __user *)attr->addr,
+			   sizeof(struct kvm_s390_vm_cpu_subfunc))) {
+		mutex_unlock(&kvm->lock);
+		return -EFAULT;
+	}
+	mutex_unlock(&kvm->lock);
+
+	return 0;
 }
 
 static int kvm_s390_set_cpu_model(struct kvm *kvm, struct kvm_device_attr *attr)
@@ -1389,12 +1398,11 @@ static int kvm_s390_get_machine_feat(struct kvm *kvm,
 static int kvm_s390_get_processor_subfunc(struct kvm *kvm,
 					  struct kvm_device_attr *attr)
 {
-	/*
-	 * Once we can actually configure subfunctions (kernel + hw support),
-	 * we have to check if they were already set by user space, if so copy
-	 * them from kvm->arch.
-	 */
-	return -ENXIO;
+	if (copy_to_user((void __user *)attr->addr, &kvm->arch.model.subfuncs,
+	    sizeof(struct kvm_s390_vm_cpu_subfunc)))
+		return -EFAULT;
+
+	return 0;
 }
 
 static int kvm_s390_get_machine_subfunc(struct kvm *kvm,
@@ -1405,6 +1413,7 @@ static int kvm_s390_get_machine_subfunc(struct kvm *kvm,
 		return -EFAULT;
 	return 0;
 }
+
 static int kvm_s390_get_cpu_model(struct kvm *kvm, struct kvm_device_attr *attr)
 {
 	int ret = -ENXIO;
@@ -1522,10 +1531,9 @@ static int kvm_s390_vm_has_attr(struct kvm *kvm, struct kvm_device_attr *attr)
 		case KVM_S390_VM_CPU_PROCESSOR_FEAT:
 		case KVM_S390_VM_CPU_MACHINE_FEAT:
 		case KVM_S390_VM_CPU_MACHINE_SUBFUNC:
+		case KVM_S390_VM_CPU_PROCESSOR_SUBFUNC:
 			ret = 0;
 			break;
-		/* configuring subfunctions is not supported yet */
-		case KVM_S390_VM_CPU_PROCESSOR_SUBFUNC:
 		default:
 			ret = -ENXIO;
 			break;
@@ -2227,6 +2235,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 		kvm->arch.model.fac_list[i] = S390_lowcore.stfle_fac_list[i] &
 					      kvm_s390_fac_base[i];
 	}
+	kvm->arch.model.subfuncs = kvm_s390_available_subfunc;
 
 	/* we are always in czam mode - even on pre z14 machines */
 	set_kvm_facility(kvm->arch.model.fac_mask, 138);
-- 
2.7.4
