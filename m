From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/3] KVM: s390: fix guest fprs memory leak
Date: Tue, 26 Jan 2016 16:17:04 +0100
Message-ID: <1453821426-94778-2-git-send-email-borntraeger@de.ibm.com>
References: <1453821426-94778-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1453821426-94778-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

fprs is never freed, therefore resulting in a memory leak if
kvm_vcpu_init() fails or the vcpu is destroyed.

Fixes: 9977e886cbbc ("s390/kernel: lazy restore fpu registers")
Cc: stable@vger.kernel.org # v4.3+
Reported-by: Eric Farman <farman@linux.vnet.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Eric Farman <farman@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 835d60b..797dbc4 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1244,6 +1244,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 
 	if (vcpu->kvm->arch.use_cmma)
 		kvm_s390_vcpu_unsetup_cmma(vcpu);
+	kfree(vcpu->arch.guest_fpregs.fprs);
 	free_page((unsigned long)(vcpu->arch.sie_block));
 
 	kvm_vcpu_uninit(vcpu);
@@ -1661,12 +1662,14 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
 
 	rc = kvm_vcpu_init(vcpu, kvm, id);
 	if (rc)
-		goto out_free_sie_block;
+		goto out_free_fprs;
 	VM_EVENT(kvm, 3, "create cpu %d at 0x%pK, sie block at 0x%pK", id, vcpu,
 		 vcpu->arch.sie_block);
 	trace_kvm_s390_create_vcpu(id, vcpu, vcpu->arch.sie_block);
 
 	return vcpu;
+out_free_fprs:
+	kfree(vcpu->arch.guest_fpregs.fprs);
 out_free_sie_block:
 	free_page((unsigned long)(vcpu->arch.sie_block));
 out_free_cpu:
-- 
2.3.0
