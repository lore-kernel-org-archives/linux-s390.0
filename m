From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 07/22] KVM: s390: rename __set_cpuflag() to kvm_s390_set_cpuflags()
Date: Fri, 26 Jan 2018 16:53:19 +0100
Message-ID: <20180126155334.52956-8-borntraeger@de.ibm.com>
References: <20180126155334.52956-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180126155334.52956-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <david@redhat.com>

No need to make this function special. Move it to a header right away.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180123170531.13687-2-david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 29 ++++++++++++-----------------
 arch/s390/kvm/kvm-s390.h  |  5 +++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index f8eb2cfa763ac..96ea3b80b67a4 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -301,17 +301,12 @@ static void __reset_intercept_indicators(struct kvm_vcpu *vcpu)
 	}
 }
 
-static void __set_cpuflag(struct kvm_vcpu *vcpu, u32 flag)
-{
-	atomic_or(flag, &vcpu->arch.sie_block->cpuflags);
-}
-
 static void set_intercept_indicators_io(struct kvm_vcpu *vcpu)
 {
 	if (!(pending_irqs(vcpu) & IRQ_PEND_IO_MASK))
 		return;
 	else if (psw_ioint_disabled(vcpu))
-		__set_cpuflag(vcpu, CPUSTAT_IO_INT);
+		kvm_s390_set_cpuflags(vcpu, CPUSTAT_IO_INT);
 	else
 		vcpu->arch.sie_block->lctl |= LCTL_CR6;
 }
@@ -321,7 +316,7 @@ static void set_intercept_indicators_ext(struct kvm_vcpu *vcpu)
 	if (!(pending_irqs(vcpu) & IRQ_PEND_EXT_MASK))
 		return;
 	if (psw_extint_disabled(vcpu))
-		__set_cpuflag(vcpu, CPUSTAT_EXT_INT);
+		kvm_s390_set_cpuflags(vcpu, CPUSTAT_EXT_INT);
 	else
 		vcpu->arch.sie_block->lctl |= LCTL_CR0;
 }
@@ -339,7 +334,7 @@ static void set_intercept_indicators_mchk(struct kvm_vcpu *vcpu)
 static void set_intercept_indicators_stop(struct kvm_vcpu *vcpu)
 {
 	if (kvm_s390_is_stop_irq_pending(vcpu))
-		__set_cpuflag(vcpu, CPUSTAT_STOP_INT);
+		kvm_s390_set_cpuflags(vcpu, CPUSTAT_STOP_INT);
 }
 
 /* Set interception request for non-deliverable interrupts */
@@ -1227,7 +1222,7 @@ static int __inject_pfault_init(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 
 	li->irq.ext = irq->u.ext;
 	set_bit(IRQ_PEND_PFAULT_INIT, &li->pending_irqs);
-	__set_cpuflag(vcpu, CPUSTAT_EXT_INT);
+	kvm_s390_set_cpuflags(vcpu, CPUSTAT_EXT_INT);
 	return 0;
 }
 
@@ -1252,7 +1247,7 @@ static int __inject_extcall(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 	if (test_and_set_bit(IRQ_PEND_EXT_EXTERNAL, &li->pending_irqs))
 		return -EBUSY;
 	*extcall = irq->u.extcall;
-	__set_cpuflag(vcpu, CPUSTAT_EXT_INT);
+	kvm_s390_set_cpuflags(vcpu, CPUSTAT_EXT_INT);
 	return 0;
 }
 
@@ -1296,7 +1291,7 @@ static int __inject_sigp_stop(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 	if (test_and_set_bit(IRQ_PEND_SIGP_STOP, &li->pending_irqs))
 		return -EBUSY;
 	stop->flags = irq->u.stop.flags;
-	__set_cpuflag(vcpu, CPUSTAT_STOP_INT);
+	kvm_s390_set_cpuflags(vcpu, CPUSTAT_STOP_INT);
 	return 0;
 }
 
@@ -1328,7 +1323,7 @@ static int __inject_sigp_emergency(struct kvm_vcpu *vcpu,
 
 	set_bit(irq->u.emerg.code, li->sigp_emerg_pending);
 	set_bit(IRQ_PEND_EXT_EMERGENCY, &li->pending_irqs);
-	__set_cpuflag(vcpu, CPUSTAT_EXT_INT);
+	kvm_s390_set_cpuflags(vcpu, CPUSTAT_EXT_INT);
 	return 0;
 }
 
@@ -1372,7 +1367,7 @@ static int __inject_ckc(struct kvm_vcpu *vcpu)
 				   0, 0);
 
 	set_bit(IRQ_PEND_EXT_CLOCK_COMP, &li->pending_irqs);
-	__set_cpuflag(vcpu, CPUSTAT_EXT_INT);
+	kvm_s390_set_cpuflags(vcpu, CPUSTAT_EXT_INT);
 	return 0;
 }
 
@@ -1385,7 +1380,7 @@ static int __inject_cpu_timer(struct kvm_vcpu *vcpu)
 				   0, 0);
 
 	set_bit(IRQ_PEND_EXT_CPU_TIMER, &li->pending_irqs);
-	__set_cpuflag(vcpu, CPUSTAT_EXT_INT);
+	kvm_s390_set_cpuflags(vcpu, CPUSTAT_EXT_INT);
 	return 0;
 }
 
@@ -1568,13 +1563,13 @@ static void __floating_irq_kick(struct kvm *kvm, u64 type)
 	/* make the VCPU drop out of the SIE, or wake it up if sleeping */
 	switch (type) {
 	case KVM_S390_MCHK:
-		__set_cpuflag(dst_vcpu, CPUSTAT_STOP_INT);
+		kvm_s390_set_cpuflags(dst_vcpu, CPUSTAT_STOP_INT);
 		break;
 	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
-		__set_cpuflag(dst_vcpu, CPUSTAT_IO_INT);
+		kvm_s390_set_cpuflags(dst_vcpu, CPUSTAT_IO_INT);
 		break;
 	default:
-		__set_cpuflag(dst_vcpu, CPUSTAT_EXT_INT);
+		kvm_s390_set_cpuflags(dst_vcpu, CPUSTAT_EXT_INT);
 		break;
 	}
 	kvm_s390_vcpu_wakeup(dst_vcpu);
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 8877116f01595..a9f2c8d1833dd 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -47,6 +47,11 @@ do { \
 	  d_args); \
 } while (0)
 
+static inline void kvm_s390_set_cpuflags(struct kvm_vcpu *vcpu, u32 flags)
+{
+	atomic_or(flags, &vcpu->arch.sie_block->cpuflags);
+}
+
 static inline int is_vcpu_stopped(struct kvm_vcpu *vcpu)
 {
 	return atomic_read(&vcpu->arch.sie_block->cpuflags) & CPUSTAT_STOPPED;
-- 
2.13.4
