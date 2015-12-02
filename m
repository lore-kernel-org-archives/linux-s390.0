From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 16/23] KVM: s390: always set/clear the SCA sda field
Date: Wed,  2 Dec 2015 12:06:17 +0100
Message-ID: <1449054384-76374-17-git-send-email-borntraeger@de.ibm.com>
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

Let's always set and clear the sda when enabling/disabling a VCPU.
Dealing with sda being set to something else makes no sense anymore
as we enable a VCPU in the SCA now after it has been registered at
the VM.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 2ba5978..7e0092b 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1266,14 +1266,12 @@ static void sca_del_vcpu(struct kvm_vcpu *vcpu)
 		struct esca_block *sca = vcpu->kvm->arch.sca;
 
 		clear_bit_inv(vcpu->vcpu_id, (unsigned long *) sca->mcn);
-		if (sca->cpu[vcpu->vcpu_id].sda == (__u64) vcpu->arch.sie_block)
-			sca->cpu[vcpu->vcpu_id].sda = 0;
+		sca->cpu[vcpu->vcpu_id].sda = 0;
 	} else {
 		struct bsca_block *sca = vcpu->kvm->arch.sca;
 
 		clear_bit_inv(vcpu->vcpu_id, (unsigned long *) &sca->mcn);
-		if (sca->cpu[vcpu->vcpu_id].sda == (__u64) vcpu->arch.sie_block)
-			sca->cpu[vcpu->vcpu_id].sda = 0;
+		sca->cpu[vcpu->vcpu_id].sda = 0;
 	}
 	read_unlock(&vcpu->kvm->arch.sca_lock);
 }
@@ -1285,8 +1283,7 @@ static void sca_add_vcpu(struct kvm_vcpu *vcpu, struct kvm *kvm,
 	if (kvm->arch.use_esca) {
 		struct esca_block *sca = kvm->arch.sca;
 
-		if (!sca->cpu[id].sda)
-			sca->cpu[id].sda = (__u64) vcpu->arch.sie_block;
+		sca->cpu[id].sda = (__u64) vcpu->arch.sie_block;
 		vcpu->arch.sie_block->scaoh = (__u32)(((__u64)sca) >> 32);
 		vcpu->arch.sie_block->scaol = (__u32)(__u64)sca & ~0x3fU;
 		vcpu->arch.sie_block->ecb2 |= 0x04U;
@@ -1294,8 +1291,7 @@ static void sca_add_vcpu(struct kvm_vcpu *vcpu, struct kvm *kvm,
 	} else {
 		struct bsca_block *sca = kvm->arch.sca;
 
-		if (!sca->cpu[id].sda)
-			sca->cpu[id].sda = (__u64) vcpu->arch.sie_block;
+		sca->cpu[id].sda = (__u64) vcpu->arch.sie_block;
 		vcpu->arch.sie_block->scaoh = (__u32)(((__u64)sca) >> 32);
 		vcpu->arch.sie_block->scaol = (__u32)(__u64)sca;
 		set_bit_inv(id, (unsigned long *) &sca->mcn);
-- 
2.3.0
