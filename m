From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 31 Jul 2018 08:44:05 +0000
Subject: [GIT PULL 19/19] KVM: s390: Add huge page enablement control
Message-Id: <20180731084405.28953-20-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Janosch Frank <frankja@linux.ibm.com>

General KVM huge page support on s390 has to be enabled via the
kvm.hpage module parameter. Either nested or hpage can be enabled, as
we currently do not support vSIE for huge backed guests. Once the vSIE
support is added we will either drop the parameter or enable it as
default.

For a guest the feature has to be enabled through the new
KVM_CAP_S390_HPAGE_1M capability and the hpage module
parameter. Enabling it means that cmm can't be enabled for the vm and
disables pfmf and storage key interpretation.

This is due to the fact that in some cases, in upcoming patches, we
have to split huge pages in the guest mapping to be able to set more
granular memory protection on 4k pages. These split pages have fake
page tables that are not visible to the Linux memory management which
subsequently will not manage its PGSTEs, while the SIE will. Disabling
these features lets us manage PGSTE data in a consistent matter and
solve that problem.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 Documentation/virtual/kvm/api.txt | 16 ++++++++++++
 arch/s390/kvm/kvm-s390.c          | 42 +++++++++++++++++++++++++++++--
 include/uapi/linux/kvm.h          |  1 +
 3 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index d10944e619d3..cb8db4f9d097 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -4391,6 +4391,22 @@ all such vmexits.
 
 Do not enable KVM_FEATURE_PV_UNHALT if you disable HLT exits.
 
+7.14 KVM_CAP_S390_HPAGE_1M
+
+Architectures: s390
+Parameters: none
+Returns: 0 on success, -EINVAL if hpage module parameter was not set
+	 or cmma is enabled
+
+With this capability the KVM support for memory backing with 1m pages
+through hugetlbfs can be enabled for a VM. After the capability is
+enabled, cmma can't be enabled anymore and pfmfi and the storage key
+interpretation are disabled. If cmma has already been enabled or the
+hpage module parameter is not set to 1, -EINVAL is returned.
+
+While it is generally possible to create a huge page backed VM without
+this capability, the VM will not be able to run.
+
 8. Other capabilities.
 ----------------------
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 662f4d8046db..f9d90337e64a 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -172,6 +172,10 @@ static int nested;
 module_param(nested, int, S_IRUGO);
 MODULE_PARM_DESC(nested, "Nested virtualization support");
 
+/* allow 1m huge page guest backing, if !nested */
+static int hpage;
+module_param(hpage, int, 0444);
+MODULE_PARM_DESC(hpage, "1m huge page backing support");
 
 /*
  * For now we handle at most 16 double words as this is what the s390 base
@@ -475,6 +479,11 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_S390_AIS_MIGRATION:
 		r = 1;
 		break;
+	case KVM_CAP_S390_HPAGE_1M:
+		r = 0;
+		if (hpage)
+			r = 1;
+		break;
 	case KVM_CAP_S390_MEM_OP:
 		r = MEM_OP_MAX_SIZE;
 		break;
@@ -678,6 +687,27 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
 		VM_EVENT(kvm, 3, "ENABLE: CAP_S390_GS %s",
 			 r ? "(not available)" : "(success)");
 		break;
+	case KVM_CAP_S390_HPAGE_1M:
+		mutex_lock(&kvm->lock);
+		if (kvm->created_vcpus)
+			r = -EBUSY;
+		else if (!hpage || kvm->arch.use_cmma)
+			r = -EINVAL;
+		else {
+			r = 0;
+			kvm->mm->context.allow_gmap_hpage_1m = 1;
+			/*
+			 * We might have to create fake 4k page
+			 * tables. To avoid that the hardware works on
+			 * stale PGSTEs, we emulate these instructions.
+			 */
+			kvm->arch.use_skf = 0;
+			kvm->arch.use_pfmfi = 0;
+		}
+		mutex_unlock(&kvm->lock);
+		VM_EVENT(kvm, 3, "ENABLE: CAP_S390_HPAGE %s",
+			 r ? "(not available)" : "(success)");
+		break;
 	case KVM_CAP_S390_USER_STSI:
 		VM_EVENT(kvm, 3, "%s", "ENABLE: CAP_S390_USER_STSI");
 		kvm->arch.user_stsi = 1;
@@ -725,10 +755,13 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 		if (!sclp.has_cmma)
 			break;
 
-		ret = -EBUSY;
 		VM_EVENT(kvm, 3, "%s", "ENABLE: CMMA support");
 		mutex_lock(&kvm->lock);
-		if (!kvm->created_vcpus) {
+		if (kvm->created_vcpus)
+			ret = -EBUSY;
+		else if (kvm->mm->context.allow_gmap_hpage_1m)
+			ret = -EINVAL;
+		else {
 			kvm->arch.use_cmma = 1;
 			/* Not compatible with cmma. */
 			kvm->arch.use_pfmfi = 0;
@@ -4102,6 +4135,11 @@ static int __init kvm_s390_init(void)
 		return -ENODEV;
 	}
 
+	if (nested && hpage) {
+		pr_info("nested (vSIE) and hpage (huge page backing) can currently not be activated concurrently");
+		return -EINVAL;
+	}
+
 	for (i = 0; i < 16; i++)
 		kvm_s390_fac_base[i] |=
 			S390_lowcore.stfle_fac_list[i] & nonhyp_mask(i);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index b6270a3b38e9..b955b986b341 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -949,6 +949,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_GET_MSR_FEATURES 153
 #define KVM_CAP_HYPERV_EVENTFD 154
 #define KVM_CAP_HYPERV_TLBFLUSH 155
+#define KVM_CAP_S390_HPAGE_1M 156
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.17.0
