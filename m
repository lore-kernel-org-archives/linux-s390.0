From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 06/10] KVM: s390: simplify in-kernel program irq injection
Date: Tue, 13 Oct 2015 16:06:04 +0200
Message-ID: <1444745168-21479-7-git-send-email-borntraeger@de.ibm.com>
References: <1444745168-21479-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1444745168-21479-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

The main reason to keep program injection in kernel separated until now
was that we were able to do some checking, if really only the owning
thread injects program interrupts (via waitqueue_active(li->wq)).

This BUG_ON was never triggered and the chances of really hitting it, if
another thread injected a program irq to another vcpu, were very small.

Let's drop this check and turn kvm_s390_inject_program_int() and
kvm_s390_inject_prog_irq() into simple inline functions that makes use of
kvm_s390_inject_vcpu().

__must_check can be dropped as they are implicitely given by
kvm_s390_inject_vcpu(), to avoid ugly long function prototypes.

Reviewed-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 28 ----------------------------
 arch/s390/kvm/kvm-s390.h  | 24 ++++++++++++++++++++----
 2 files changed, 20 insertions(+), 32 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 10a0e8b..f603bac 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -977,34 +977,6 @@ static int __inject_prog(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 	return 0;
 }
 
-int kvm_s390_inject_program_int(struct kvm_vcpu *vcpu, u16 code)
-{
-	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
-	struct kvm_s390_irq irq;
-
-	spin_lock(&li->lock);
-	irq.u.pgm.code = code;
-	__inject_prog(vcpu, &irq);
-	BUG_ON(waitqueue_active(li->wq));
-	spin_unlock(&li->lock);
-	return 0;
-}
-
-int kvm_s390_inject_prog_irq(struct kvm_vcpu *vcpu,
-			     struct kvm_s390_pgm_info *pgm_info)
-{
-	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
-	struct kvm_s390_irq irq;
-	int rc;
-
-	spin_lock(&li->lock);
-	irq.u.pgm = *pgm_info;
-	rc = __inject_prog(vcpu, &irq);
-	BUG_ON(waitqueue_active(li->wq));
-	spin_unlock(&li->lock);
-	return rc;
-}
-
 static int __inject_pfault_init(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index c446aab..3a368d2 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -175,6 +175,7 @@ static inline int kvm_s390_user_cpu_state_ctrl(struct kvm *kvm)
 	return kvm->arch.user_cpu_state_ctrl != 0;
 }
 
+/* implemented in interrupt.c */
 int kvm_s390_handle_wait(struct kvm_vcpu *vcpu);
 void kvm_s390_vcpu_wakeup(struct kvm_vcpu *vcpu);
 enum hrtimer_restart kvm_s390_idle_wakeup(struct hrtimer *timer);
@@ -185,7 +186,25 @@ int __must_check kvm_s390_inject_vm(struct kvm *kvm,
 				    struct kvm_s390_interrupt *s390int);
 int __must_check kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
 				      struct kvm_s390_irq *irq);
-int __must_check kvm_s390_inject_program_int(struct kvm_vcpu *vcpu, u16 code);
+static inline int kvm_s390_inject_prog_irq(struct kvm_vcpu *vcpu,
+					   struct kvm_s390_pgm_info *pgm_info)
+{
+	struct kvm_s390_irq irq = {
+		.type = KVM_S390_PROGRAM_INT,
+		.u.pgm = *pgm_info,
+	};
+
+	return kvm_s390_inject_vcpu(vcpu, &irq);
+}
+static inline int kvm_s390_inject_program_int(struct kvm_vcpu *vcpu, u16 code)
+{
+	struct kvm_s390_irq irq = {
+		.type = KVM_S390_PROGRAM_INT,
+		.u.pgm.code = code,
+	};
+
+	return kvm_s390_inject_vcpu(vcpu, &irq);
+}
 struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
 						    u64 isc_mask, u32 schid);
 int kvm_s390_reinject_io_int(struct kvm *kvm,
@@ -231,9 +250,6 @@ extern unsigned long kvm_s390_fac_list_mask[];
 
 /* implemented in diag.c */
 int kvm_s390_handle_diag(struct kvm_vcpu *vcpu);
-/* implemented in interrupt.c */
-int kvm_s390_inject_prog_irq(struct kvm_vcpu *vcpu,
-			     struct kvm_s390_pgm_info *pgm_info);
 
 static inline void kvm_s390_vcpu_block_all(struct kvm *kvm)
 {
-- 
2.4.3
