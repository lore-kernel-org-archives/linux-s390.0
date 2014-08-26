From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 08/15] KVM: s390: return -EFAULT if lowcore is not mapped during irq delivery
Date: Tue, 26 Aug 2014 10:28:20 +0200
Message-ID: <1409041707-39938-9-git-send-email-borntraeger@de.ibm.com>
References: <1409041707-39938-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1409041707-39938-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jens Freimann <jfrei@linux.vnet.ibm.com>

Currently we just kill the userspace process and exit the thread
immediatly without making sure that we don't hold any locks etc.

Improve this by making KVM_RUN return -EFAULT if the lowcore is not
mapped during interrupt delivery. To achieve this we need to pass
the return code of guest memory access routines used in interrupt
delivery all the way back to the KVM_RUN ioctl.

Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 40 ++++++++++++++++++----------------------
 arch/s390/kvm/kvm-s390.c  |  7 +++++--
 arch/s390/kvm/kvm-s390.h  |  2 +-
 3 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 34d741e..e2f6240 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -28,7 +28,7 @@
 #define IOINT_AI_MASK 0x04000000
 #define PFAULT_INIT 0x0600
 
-static void deliver_ckc_interrupt(struct kvm_vcpu *vcpu);
+static int deliver_ckc_interrupt(struct kvm_vcpu *vcpu);
 
 static int is_ioint(u64 type)
 {
@@ -307,7 +307,7 @@ static int __deliver_prog_irq(struct kvm_vcpu *vcpu,
 	return rc;
 }
 
-static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
+static int __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 				   struct kvm_s390_interrupt_info *inti)
 {
 	const unsigned short table[] = { 2, 4, 4, 6 };
@@ -345,7 +345,7 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 	case KVM_S390_INT_CLOCK_COMP:
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
 						 inti->ext.ext_params, 0);
-		deliver_ckc_interrupt(vcpu);
+		rc = deliver_ckc_interrupt(vcpu);
 		break;
 	case KVM_S390_INT_CPU_TIMER:
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
@@ -504,14 +504,11 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 	default:
 		BUG();
 	}
-	if (rc) {
-		printk("kvm: The guest lowcore is not mapped during interrupt "
-		       "delivery, killing userspace\n");
-		do_exit(SIGKILL);
-	}
+
+	return rc;
 }
 
-static void deliver_ckc_interrupt(struct kvm_vcpu *vcpu)
+static int deliver_ckc_interrupt(struct kvm_vcpu *vcpu)
 {
 	int rc;
 
@@ -521,11 +518,7 @@ static void deliver_ckc_interrupt(struct kvm_vcpu *vcpu)
 	rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
 			    &vcpu->arch.sie_block->gpsw,
 			    sizeof(psw_t));
-	if (rc) {
-		printk("kvm: The guest lowcore is not mapped during interrupt "
-			"delivery, killing userspace\n");
-		do_exit(SIGKILL);
-	}
+	return rc;
 }
 
 /* Check whether SIGP interpretation facility has an external call pending */
@@ -664,12 +657,13 @@ void kvm_s390_clear_local_irqs(struct kvm_vcpu *vcpu)
 			  &vcpu->kvm->arch.sca->cpu[vcpu->vcpu_id].ctrl);
 }
 
-void kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu)
+int kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 	struct kvm_s390_float_interrupt *fi = vcpu->arch.local_int.float_int;
 	struct kvm_s390_interrupt_info  *n, *inti = NULL;
 	int deliver;
+	int rc = 0;
 
 	__reset_intercept_indicators(vcpu);
 	if (atomic_read(&li->active)) {
@@ -688,16 +682,16 @@ void kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu)
 				atomic_set(&li->active, 0);
 			spin_unlock(&li->lock);
 			if (deliver) {
-				__do_deliver_interrupt(vcpu, inti);
+				rc = __do_deliver_interrupt(vcpu, inti);
 				kfree(inti);
 			}
-		} while (deliver);
+		} while (!rc && deliver);
 	}
 
-	if (kvm_cpu_has_pending_timer(vcpu))
-		deliver_ckc_interrupt(vcpu);
+	if (!rc && kvm_cpu_has_pending_timer(vcpu))
+		rc = deliver_ckc_interrupt(vcpu);
 
-	if (atomic_read(&fi->active)) {
+	if (!rc && atomic_read(&fi->active)) {
 		do {
 			deliver = 0;
 			spin_lock(&fi->lock);
@@ -714,11 +708,13 @@ void kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu)
 				atomic_set(&fi->active, 0);
 			spin_unlock(&fi->lock);
 			if (deliver) {
-				__do_deliver_interrupt(vcpu, inti);
+				rc = __do_deliver_interrupt(vcpu, inti);
 				kfree(inti);
 			}
-		} while (deliver);
+		} while (!rc && deliver);
 	}
+
+	return rc;
 }
 
 int kvm_s390_inject_program_int(struct kvm_vcpu *vcpu, u16 code)
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 56193be..c2caa17 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1198,8 +1198,11 @@ static int vcpu_pre_run(struct kvm_vcpu *vcpu)
 	if (test_cpu_flag(CIF_MCCK_PENDING))
 		s390_handle_mcck();
 
-	if (!kvm_is_ucontrol(vcpu->kvm))
-		kvm_s390_deliver_pending_interrupts(vcpu);
+	if (!kvm_is_ucontrol(vcpu->kvm)) {
+		rc = kvm_s390_deliver_pending_interrupts(vcpu);
+		if (rc)
+			return rc;
+	}
 
 	rc = kvm_s390_handle_requests(vcpu);
 	if (rc)
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 54c25fd..99abcb5 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -138,7 +138,7 @@ static inline int kvm_s390_user_cpu_state_ctrl(struct kvm *kvm)
 int kvm_s390_handle_wait(struct kvm_vcpu *vcpu);
 void kvm_s390_vcpu_wakeup(struct kvm_vcpu *vcpu);
 enum hrtimer_restart kvm_s390_idle_wakeup(struct hrtimer *timer);
-void kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu);
+int kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu);
 void kvm_s390_clear_local_irqs(struct kvm_vcpu *vcpu);
 void kvm_s390_clear_float_irqs(struct kvm *kvm);
 int __must_check kvm_s390_inject_vm(struct kvm *kvm,
-- 
1.8.4.2
