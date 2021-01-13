Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58382 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727396AbhAMJmZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Jan 2021 04:42:25 -0500
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH 14/14] KVM: s390: Allow the VSIE to be used with huge pages
Date: Wed, 13 Jan 2021 09:41:13 +0000
Message-Id: <20210113094113.133668-15-frankja@linux.ibm.com>
In-Reply-To: <20210113094113.133668-1-frankja@linux.ibm.com>
References: <20210113094113.133668-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, david@redhat.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com

Now that we have VSIE support for VMs with huge memory backing, let's
make both features usable at the same time.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 Documentation/virt/kvm/api.rst |  9 ++++-----
 arch/s390/kvm/kvm-s390.c       | 14 ++------------
 arch/s390/mm/gmap.c            |  1 -
 3 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index c136e254b496..c7fa31bbaa78 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -5876,15 +5876,14 @@ Do not enable KVM_FEATURE_PV_UNHALT if you disable HLT exits.
 
 :Architectures: s390
 :Parameters: none
-:Returns: 0 on success, -EINVAL if hpage module parameter was not set
-	  or cmma is enabled, or the VM has the KVM_VM_S390_UCONTROL
-	  flag set
+:Returns: 0 on success, -EINVAL if cmma is enabled, or the VM has the
+	  KVM_VM_S390_UCONTROL flag set
 
 With this capability the KVM support for memory backing with 1m pages
 through hugetlbfs can be enabled for a VM. After the capability is
 enabled, cmma can't be enabled anymore and pfmfi and the storage key
-interpretation are disabled. If cmma has already been enabled or the
-hpage module parameter is not set to 1, -EINVAL is returned.
+interpretation are disabled. If cmma has already been enabled, -EINVAL
+is returned.
 
 While it is generally possible to create a huge page backed VM without
 this capability, the VM will not be able to run.
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index dbafd057ca6a..ad4fc84bb090 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -175,11 +175,6 @@ static int nested;
 module_param(nested, int, S_IRUGO);
 MODULE_PARM_DESC(nested, "Nested virtualization support");
 
-/* allow 1m huge page guest backing, if !nested */
-static int hpage;
-module_param(hpage, int, 0444);
-MODULE_PARM_DESC(hpage, "1m huge page backing support");
-
 /* maximum percentage of steal time for polling.  >100 is treated like 100 */
 static u8 halt_poll_max_steal = 10;
 module_param(halt_poll_max_steal, byte, 0644);
@@ -551,7 +546,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		break;
 	case KVM_CAP_S390_HPAGE_1M:
 		r = 0;
-		if (hpage && !kvm_is_ucontrol(kvm))
+		if (!kvm_is_ucontrol(kvm))
 			r = 1;
 		break;
 	case KVM_CAP_S390_MEM_OP:
@@ -761,7 +756,7 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
 		mutex_lock(&kvm->lock);
 		if (kvm->created_vcpus)
 			r = -EBUSY;
-		else if (!hpage || kvm->arch.use_cmma || kvm_is_ucontrol(kvm))
+		else if (kvm->arch.use_cmma || kvm_is_ucontrol(kvm))
 			r = -EINVAL;
 		else {
 			r = 0;
@@ -5042,11 +5037,6 @@ static int __init kvm_s390_init(void)
 		return -ENODEV;
 	}
 
-	if (nested && hpage) {
-		pr_info("A KVM host that supports nesting cannot back its KVM guests with huge pages\n");
-		return -EINVAL;
-	}
-
 	for (i = 0; i < 16; i++)
 		kvm_s390_fac_base[i] |=
 			S390_lowcore.stfle_fac_list[i] & nonhyp_mask(i);
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index c4778ded8450..994688946553 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1844,7 +1844,6 @@ struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce,
 	unsigned long limit;
 	int rc;
 
-	BUG_ON(parent->mm->context.allow_gmap_hpage_1m);
 	BUG_ON(gmap_is_shadow(parent));
 	spin_lock(&parent->shadow_lock);
 	sg = gmap_find_shadow(parent, asce, edat_level);
-- 
2.27.0
