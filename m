From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 03/20] KVM: s390: fix in memory copy of facility lists
Date: Fri,  6 Mar 2015 14:16:35 +0100
Message-ID: <1425647812-61838-4-git-send-email-borntraeger@de.ibm.com>
References: <1425647812-61838-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1425647812-61838-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Michael Mueller <mimu@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.vnet.ibm.com>

The facility lists were not fully copied.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 18965f9..76894c8 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -579,7 +579,7 @@ static int kvm_s390_get_machine(struct kvm *kvm, struct kvm_device_attr *attr)
 	memcpy(&mach->fac_mask, kvm_s390_fac_list_mask,
 	       kvm_s390_fac_list_mask_size() * sizeof(u64));
 	memcpy((unsigned long *)&mach->fac_list, S390_lowcore.stfle_fac_list,
-	       S390_ARCH_FAC_LIST_SIZE_U64);
+	       S390_ARCH_FAC_LIST_SIZE_BYTE);
 	if (copy_to_user((void __user *)attr->addr, mach, sizeof(*mach)))
 		ret = -EFAULT;
 	kfree(mach);
@@ -903,7 +903,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 		goto out_nofac;
 
 	memcpy(kvm->arch.model.fac->kvm, S390_lowcore.stfle_fac_list,
-	       S390_ARCH_FAC_LIST_SIZE_U64);
+	       S390_ARCH_FAC_LIST_SIZE_BYTE);
 
 	/*
 	 * If this KVM host runs *not* in a LPAR, relax the facility bits
-- 
2.3.0
