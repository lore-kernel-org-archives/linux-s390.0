From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 15/23] KVM: s390: fix SCA related races and double use
Date: Wed,  2 Dec 2015 12:06:16 +0100
Message-ID: <1449054384-76374-16-git-send-email-borntraeger@de.ibm.com>
References: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

If something goes wrong in kvm_arch_vcpu_create, the VCPU has already
been added to the sca but will never be removed. Trying to create VCPUs
with duplicate ids (e.g. after a failed attempt) is problematic.

Also, when creating multiple VCPUs in parallel, we could theoretically
forget to set the correct SCA when the switch to ESCA happens just
before the VCPU is registered.

Let's add the VCPU to the SCA in kvm_arch_vcpu_postcreate, where we can
be sure that no duplicate VCPU with the same id is around and the VCPU
has already been registered at the VM. We also have to make sure to update
ECB at that point.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 5c58127..2ba5978 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1289,6 +1289,7 @@ static void sca_add_vcpu(struct kvm_vcpu *vcpu, struct kvm *kvm,
 			sca->cpu[id].sda = (__u64) vcpu->arch.sie_block;
 		vcpu->arch.sie_block->scaoh = (__u32)(((__u64)sca) >> 32);
 		vcpu->arch.sie_block->scaol = (__u32)(__u64)sca & ~0x3fU;
+		vcpu->arch.sie_block->ecb2 |= 0x04U;
 		set_bit_inv(id, (unsigned long *) sca->mcn);
 	} else {
 		struct bsca_block *sca = kvm->arch.sca;
@@ -1493,8 +1494,11 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 	vcpu->arch.sie_block->epoch = vcpu->kvm->arch.epoch;
 	preempt_enable();
 	mutex_unlock(&vcpu->kvm->lock);
-	if (!kvm_is_ucontrol(vcpu->kvm))
+	if (!kvm_is_ucontrol(vcpu->kvm)) {
 		vcpu->arch.gmap = vcpu->kvm->arch.gmap;
+		sca_add_vcpu(vcpu, vcpu->kvm, vcpu->vcpu_id);
+	}
+
 }
 
 static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
@@ -1558,8 +1562,6 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 		vcpu->arch.sie_block->ecb |= 0x10;
 
 	vcpu->arch.sie_block->ecb2  = 8;
-	if (vcpu->kvm->arch.use_esca)
-		vcpu->arch.sie_block->ecb2 |= 4;
 	vcpu->arch.sie_block->eca   = 0xC1002000U;
 	if (sclp.has_siif)
 		vcpu->arch.sie_block->eca |= 1;
@@ -1608,9 +1610,6 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
 	vcpu->arch.sie_block->itdba = (unsigned long) &sie_page->itdb;
 
 	vcpu->arch.sie_block->icpua = id;
-	if (!kvm_is_ucontrol(kvm))
-		sca_add_vcpu(vcpu, kvm, id);
-
 	spin_lock_init(&vcpu->arch.local_int.lock);
 	vcpu->arch.local_int.float_int = &kvm->arch.float_int;
 	vcpu->arch.local_int.wq = &vcpu->wq;
-- 
2.3.0
