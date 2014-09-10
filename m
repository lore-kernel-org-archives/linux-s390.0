From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/7] KVM: s390: add __must_check to interrupt deliver functions
Date: Wed, 10 Sep 2014 15:53:49 +0200
Message-ID: <1410357234-8937-3-git-send-email-borntraeger@de.ibm.com>
References: <1410357234-8937-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1410357234-8937-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

We now propagate interrupt injection errors back to the ioctl. We
should mark functions that might fail with __must_check.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
---
 arch/s390/kvm/interrupt.c | 12 ++++++------
 arch/s390/kvm/kvm-s390.h  |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 60a5cf4..d56da1d 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -28,7 +28,7 @@
 #define IOINT_AI_MASK 0x04000000
 #define PFAULT_INIT 0x0600
 
-static int deliver_ckc_interrupt(struct kvm_vcpu *vcpu);
+static int __must_check deliver_ckc_interrupt(struct kvm_vcpu *vcpu);
 
 static int is_ioint(u64 type)
 {
@@ -77,7 +77,7 @@ static u64 int_word_to_isc_bits(u32 int_word)
 	return (0x80 >> isc) << 24;
 }
 
-static int __interrupt_is_deliverable(struct kvm_vcpu *vcpu,
+static int __must_check __interrupt_is_deliverable(struct kvm_vcpu *vcpu,
 				      struct kvm_s390_interrupt_info *inti)
 {
 	switch (inti->type) {
@@ -225,7 +225,7 @@ static u16 get_ilc(struct kvm_vcpu *vcpu)
 	}
 }
 
-static int __deliver_prog_irq(struct kvm_vcpu *vcpu,
+static int __must_check __deliver_prog_irq(struct kvm_vcpu *vcpu,
 			      struct kvm_s390_pgm_info *pgm_info)
 {
 	int rc = 0;
@@ -307,7 +307,7 @@ static int __deliver_prog_irq(struct kvm_vcpu *vcpu,
 	return rc;
 }
 
-static int __do_deliver_interrupt(struct kvm_vcpu *vcpu,
+static int __must_check __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 				   struct kvm_s390_interrupt_info *inti)
 {
 	const unsigned short table[] = { 2, 4, 4, 6 };
@@ -508,7 +508,7 @@ static int __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 	return rc;
 }
 
-static int deliver_ckc_interrupt(struct kvm_vcpu *vcpu)
+static int __must_check deliver_ckc_interrupt(struct kvm_vcpu *vcpu)
 {
 	int rc;
 
@@ -657,7 +657,7 @@ void kvm_s390_clear_local_irqs(struct kvm_vcpu *vcpu)
 			  &vcpu->kvm->arch.sca->cpu[vcpu->vcpu_id].ctrl);
 }
 
-int kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu)
+int __must_check kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 	struct kvm_s390_float_interrupt *fi = vcpu->arch.local_int.float_int;
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 99abcb5..b1a7766 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -138,7 +138,7 @@ static inline int kvm_s390_user_cpu_state_ctrl(struct kvm *kvm)
 int kvm_s390_handle_wait(struct kvm_vcpu *vcpu);
 void kvm_s390_vcpu_wakeup(struct kvm_vcpu *vcpu);
 enum hrtimer_restart kvm_s390_idle_wakeup(struct hrtimer *timer);
-int kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu);
+int __must_check kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu);
 void kvm_s390_clear_local_irqs(struct kvm_vcpu *vcpu);
 void kvm_s390_clear_float_irqs(struct kvm *kvm);
 int __must_check kvm_s390_inject_vm(struct kvm *kvm,
-- 
1.8.4.2
