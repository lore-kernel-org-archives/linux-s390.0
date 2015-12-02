From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 17/23] KVM: s390: cleanup sca_add_vcpu
Date: Wed,  2 Dec 2015 12:06:18 +0100
Message-ID: <1449054384-76374-18-git-send-email-borntraeger@de.ibm.com>
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

Now that we already have kvm and the VCPU id set for the VCPU, we can
convert sda_add_vcpu to look much more like sda_del_vcpu.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 7e0092b..d9d71bb 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1276,27 +1276,26 @@ static void sca_del_vcpu(struct kvm_vcpu *vcpu)
 	read_unlock(&vcpu->kvm->arch.sca_lock);
 }
 
-static void sca_add_vcpu(struct kvm_vcpu *vcpu, struct kvm *kvm,
-			unsigned int id)
+static void sca_add_vcpu(struct kvm_vcpu *vcpu)
 {
-	read_lock(&kvm->arch.sca_lock);
-	if (kvm->arch.use_esca) {
-		struct esca_block *sca = kvm->arch.sca;
+	read_lock(&vcpu->kvm->arch.sca_lock);
+	if (vcpu->kvm->arch.use_esca) {
+		struct esca_block *sca = vcpu->kvm->arch.sca;
 
-		sca->cpu[id].sda = (__u64) vcpu->arch.sie_block;
+		sca->cpu[vcpu->vcpu_id].sda = (__u64) vcpu->arch.sie_block;
 		vcpu->arch.sie_block->scaoh = (__u32)(((__u64)sca) >> 32);
 		vcpu->arch.sie_block->scaol = (__u32)(__u64)sca & ~0x3fU;
 		vcpu->arch.sie_block->ecb2 |= 0x04U;
-		set_bit_inv(id, (unsigned long *) sca->mcn);
+		set_bit_inv(vcpu->vcpu_id, (unsigned long *) sca->mcn);
 	} else {
-		struct bsca_block *sca = kvm->arch.sca;
+		struct bsca_block *sca = vcpu->kvm->arch.sca;
 
-		sca->cpu[id].sda = (__u64) vcpu->arch.sie_block;
+		sca->cpu[vcpu->vcpu_id].sda = (__u64) vcpu->arch.sie_block;
 		vcpu->arch.sie_block->scaoh = (__u32)(((__u64)sca) >> 32);
 		vcpu->arch.sie_block->scaol = (__u32)(__u64)sca;
-		set_bit_inv(id, (unsigned long *) &sca->mcn);
+		set_bit_inv(vcpu->vcpu_id, (unsigned long *) &sca->mcn);
 	}
-	read_unlock(&kvm->arch.sca_lock);
+	read_unlock(&vcpu->kvm->arch.sca_lock);
 }
 
 /* Basic SCA to Extended SCA data copy routines */
@@ -1492,7 +1491,7 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 	mutex_unlock(&vcpu->kvm->lock);
 	if (!kvm_is_ucontrol(vcpu->kvm)) {
 		vcpu->arch.gmap = vcpu->kvm->arch.gmap;
-		sca_add_vcpu(vcpu, vcpu->kvm, vcpu->vcpu_id);
+		sca_add_vcpu(vcpu);
 	}
 
 }
-- 
2.3.0
