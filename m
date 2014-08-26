From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 05/15] KVM: s390: no special machine check delivery
Date: Tue, 26 Aug 2014 10:28:17 +0200
Message-ID: <1409041707-39938-6-git-send-email-borntraeger@de.ibm.com>
References: <1409041707-39938-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1409041707-39938-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The load PSW handler does not have to inject pending machine checks.
This can wait until the CPU runs the generic interrupt injection code.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 56 -----------------------------------------------
 arch/s390/kvm/kvm-s390.h  |  1 -
 arch/s390/kvm/priv.c      |  9 --------
 3 files changed, 66 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 71bf7e7..34d741e 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -721,62 +721,6 @@ void kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu)
 	}
 }
 
-void kvm_s390_deliver_pending_machine_checks(struct kvm_vcpu *vcpu)
-{
-	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
-	struct kvm_s390_float_interrupt *fi = vcpu->arch.local_int.float_int;
-	struct kvm_s390_interrupt_info  *n, *inti = NULL;
-	int deliver;
-
-	__reset_intercept_indicators(vcpu);
-	if (atomic_read(&li->active)) {
-		do {
-			deliver = 0;
-			spin_lock(&li->lock);
-			list_for_each_entry_safe(inti, n, &li->list, list) {
-				if ((inti->type == KVM_S390_MCHK) &&
-				    __interrupt_is_deliverable(vcpu, inti)) {
-					list_del(&inti->list);
-					deliver = 1;
-					break;
-				}
-				__set_intercept_indicator(vcpu, inti);
-			}
-			if (list_empty(&li->list))
-				atomic_set(&li->active, 0);
-			spin_unlock(&li->lock);
-			if (deliver) {
-				__do_deliver_interrupt(vcpu, inti);
-				kfree(inti);
-			}
-		} while (deliver);
-	}
-
-	if (atomic_read(&fi->active)) {
-		do {
-			deliver = 0;
-			spin_lock(&fi->lock);
-			list_for_each_entry_safe(inti, n, &fi->list, list) {
-				if ((inti->type == KVM_S390_MCHK) &&
-				    __interrupt_is_deliverable(vcpu, inti)) {
-					list_del(&inti->list);
-					fi->irq_count--;
-					deliver = 1;
-					break;
-				}
-				__set_intercept_indicator(vcpu, inti);
-			}
-			if (list_empty(&fi->list))
-				atomic_set(&fi->active, 0);
-			spin_unlock(&fi->lock);
-			if (deliver) {
-				__do_deliver_interrupt(vcpu, inti);
-				kfree(inti);
-			}
-		} while (deliver);
-	}
-}
-
 int kvm_s390_inject_program_int(struct kvm_vcpu *vcpu, u16 code)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 3862fa2..894fa46 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -139,7 +139,6 @@ int kvm_s390_handle_wait(struct kvm_vcpu *vcpu);
 void kvm_s390_vcpu_wakeup(struct kvm_vcpu *vcpu);
 enum hrtimer_restart kvm_s390_idle_wakeup(struct hrtimer *timer);
 void kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu);
-void kvm_s390_deliver_pending_machine_checks(struct kvm_vcpu *vcpu);
 void kvm_s390_clear_local_irqs(struct kvm_vcpu *vcpu);
 void kvm_s390_clear_float_irqs(struct kvm *kvm);
 int __must_check kvm_s390_inject_vm(struct kvm *kvm,
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index f89c1cd..d806f2c 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -352,13 +352,6 @@ static int handle_stfl(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-static void handle_new_psw(struct kvm_vcpu *vcpu)
-{
-	/* Check whether the new psw is enabled for machine checks. */
-	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_MCHECK)
-		kvm_s390_deliver_pending_machine_checks(vcpu);
-}
-
 #define PSW_MASK_ADDR_MODE (PSW_MASK_EA | PSW_MASK_BA)
 #define PSW_MASK_UNASSIGNED 0xb80800fe7fffffffUL
 #define PSW_ADDR_24 0x0000000000ffffffUL
@@ -405,7 +398,6 @@ int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
 	gpsw->addr = new_psw.addr & ~PSW32_ADDR_AMODE;
 	if (!is_valid_psw(gpsw))
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-	handle_new_psw(vcpu);
 	return 0;
 }
 
@@ -427,7 +419,6 @@ static int handle_lpswe(struct kvm_vcpu *vcpu)
 	vcpu->arch.sie_block->gpsw = new_psw;
 	if (!is_valid_psw(&vcpu->arch.sie_block->gpsw))
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-	handle_new_psw(vcpu);
 	return 0;
 }
 
-- 
1.8.4.2
