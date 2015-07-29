From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 07/16] KVM: s390: VCPU_EVENT cleanup for prefix changes
Date: Wed, 29 Jul 2015 11:05:57 +0200
Message-ID: <1438160766-108179-8-git-send-email-borntraeger@de.ibm.com>
References: <1438160766-108179-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1438160766-108179-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

SPX (SET PREFIX)  and SIGP (Set prefix) can change the prefix
register of a CPU. As sigp set prefix may be handled in user
space (KVM_CAP_S390_USER_SIGP), we would not log the changes
triggered via SIGP in that case. Let's have just one VCPU_EVENT
at the central location that tracks prefix changes.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
---
 arch/s390/kvm/interrupt.c | 1 -
 arch/s390/kvm/kvm-s390.h  | 2 ++
 arch/s390/kvm/priv.c      | 2 --
 arch/s390/kvm/sigp.c      | 3 ---
 4 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index c98d897..8b3a117 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -427,7 +427,6 @@ static int __must_check __deliver_set_prefix(struct kvm_vcpu *vcpu)
 	clear_bit(IRQ_PEND_SET_PREFIX, &li->pending_irqs);
 	spin_unlock(&li->lock);
 
-	VCPU_EVENT(vcpu, 4, "interrupt: set prefix to %x", prefix.address);
 	vcpu->stat.deliver_prefix_signal++;
 	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id,
 					 KVM_S390_SIGP_SET_PREFIX,
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 81de2af..0ee5db1 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -65,6 +65,8 @@ static inline u32 kvm_s390_get_prefix(struct kvm_vcpu *vcpu)
 
 static inline void kvm_s390_set_prefix(struct kvm_vcpu *vcpu, u32 prefix)
 {
+	VCPU_EVENT(vcpu, 3, "set prefix of cpu %03u to 0x%x", vcpu->vcpu_id,
+		   prefix);
 	vcpu->arch.sie_block->prefix = prefix >> GUEST_PREFIX_SHIFT;
 	kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
 	kvm_make_request(KVM_REQ_MMU_RELOAD, vcpu);
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 1b95d29..2658a791 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -98,8 +98,6 @@ static int handle_set_prefix(struct kvm_vcpu *vcpu)
 		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 
 	kvm_s390_set_prefix(vcpu, address);
-
-	VCPU_EVENT(vcpu, 5, "setting prefix to %x", address);
 	trace_kvm_s390_handle_prefix(vcpu, 1, address);
 	return 0;
 }
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 72e58bd..5318ea3 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -205,9 +205,6 @@ static int __sigp_set_prefix(struct kvm_vcpu *vcpu, struct kvm_vcpu *dst_vcpu,
 		*reg &= 0xffffffff00000000UL;
 		*reg |= SIGP_STATUS_INCORRECT_STATE;
 		return SIGP_CC_STATUS_STORED;
-	} else if (rc == 0) {
-		VCPU_EVENT(vcpu, 4, "set prefix of cpu %02x to %x",
-			   dst_vcpu->vcpu_id, irq.u.prefix.address);
 	}
 
 	return rc;
-- 
2.3.0
