From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 13/21] KVM: s390: only one external call may be pending at a time
Date: Thu, 15 Jan 2015 14:43:26 +0100
Message-ID: <1421329414-76826-14-git-send-email-borntraeger@de.ibm.com>
References: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Only one external call may be pending at a vcpu at a time. For this
reason, we have to detect whether the SIGP externcal call interpretation
facility is available. If so, all external calls have to be injected
using this mechanism.

SIGP EXTERNAL CALL orders have to return whether another external
call is already pending. This check was missing until now.

SIGP SENSE hasn't returned yet in all conditions whether an external
call was pending.

If a SIGP EXTERNAL CALL irq is to be injected and one is already
pending, -EBUSY is returned.

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  8 +++---
 arch/s390/kvm/intercept.c        |  8 +++---
 arch/s390/kvm/interrupt.c        | 57 +++++++++++++++++++++++++++++-----------
 arch/s390/kvm/kvm-s390.c         |  4 ++-
 arch/s390/kvm/kvm-s390.h         |  2 +-
 arch/s390/kvm/sigp.c             | 17 ++++++++----
 6 files changed, 68 insertions(+), 28 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 02e4248..4de479e 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -35,11 +35,13 @@
 #define KVM_NR_IRQCHIPS 1
 #define KVM_IRQCHIP_NUM_PINS 4096
 
-#define SIGP_CTRL_C	0x00800000
+#define SIGP_CTRL_C		0x80
+#define SIGP_CTRL_SCN_MASK	0x3f
 
 struct sca_entry {
-	atomic_t ctrl;
-	__u32	reserved;
+	__u8	reserved0;
+	__u8	sigp_ctrl;
+	__u16	reserved[3];
 	__u64	sda;
 	__u64	reserved2[2];
 } __attribute__((packed));
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 8976694..7c868a9 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -288,11 +288,13 @@ static int handle_external_interrupt(struct kvm_vcpu *vcpu)
 		irq.type = KVM_S390_INT_CPU_TIMER;
 		break;
 	case EXT_IRQ_EXTERNAL_CALL:
-		if (kvm_s390_si_ext_call_pending(vcpu))
-			return 0;
 		irq.type = KVM_S390_INT_EXTERNAL_CALL;
 		irq.u.extcall.code = vcpu->arch.sie_block->extcpuaddr;
-		break;
+		rc = kvm_s390_inject_vcpu(vcpu, &irq);
+		/* ignore if another external call is already pending */
+		if (rc == -EBUSY)
+			return 0;
+		return rc;
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 1ba9176..0ad1f75 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -19,6 +19,7 @@
 #include <linux/bitmap.h>
 #include <asm/asm-offsets.h>
 #include <asm/uaccess.h>
+#include <asm/sclp.h>
 #include "kvm-s390.h"
 #include "gaccess.h"
 #include "trace-s390.h"
@@ -735,18 +736,17 @@ static int __must_check __deliver_floating_interrupt(struct kvm_vcpu *vcpu,
 	return rc;
 }
 
-/* Check whether SIGP interpretation facility has an external call pending */
-int kvm_s390_si_ext_call_pending(struct kvm_vcpu *vcpu)
+/* Check whether an external call is pending (deliverable or not) */
+int kvm_s390_ext_call_pending(struct kvm_vcpu *vcpu)
 {
-	atomic_t *sigp_ctrl = &vcpu->kvm->arch.sca->cpu[vcpu->vcpu_id].ctrl;
+	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
+	uint8_t sigp_ctrl = vcpu->kvm->arch.sca->cpu[vcpu->vcpu_id].sigp_ctrl;
 
-	if (!psw_extint_disabled(vcpu) &&
-	    (vcpu->arch.sie_block->gcr[0] & 0x2000ul) &&
-	    (atomic_read(sigp_ctrl) & SIGP_CTRL_C) &&
-	    (atomic_read(&vcpu->arch.sie_block->cpuflags) & CPUSTAT_ECALL_PEND))
-		return 1;
+	if (!sclp_has_sigpif())
+		return test_bit(IRQ_PEND_EXT_EXTERNAL, &li->pending_irqs);
 
-	return 0;
+	return (sigp_ctrl & SIGP_CTRL_C) &&
+	       (atomic_read(&vcpu->arch.sie_block->cpuflags) & CPUSTAT_ECALL_PEND);
 }
 
 int kvm_s390_vcpu_has_irq(struct kvm_vcpu *vcpu, int exclude_stop)
@@ -770,7 +770,10 @@ int kvm_s390_vcpu_has_irq(struct kvm_vcpu *vcpu, int exclude_stop)
 	if (!rc && kvm_cpu_has_pending_timer(vcpu))
 		rc = 1;
 
-	if (!rc && kvm_s390_si_ext_call_pending(vcpu))
+	/* external call pending and deliverable */
+	if (!rc && kvm_s390_ext_call_pending(vcpu) &&
+	    !psw_extint_disabled(vcpu) &&
+	    (vcpu->arch.sie_block->gcr[0] & 0x2000ul))
 		rc = 1;
 
 	if (!rc && !exclude_stop && kvm_s390_is_stop_irq_pending(vcpu))
@@ -875,8 +878,7 @@ void kvm_s390_clear_local_irqs(struct kvm_vcpu *vcpu)
 
 	/* clear pending external calls set by sigp interpretation facility */
 	atomic_clear_mask(CPUSTAT_ECALL_PEND, li->cpuflags);
-	atomic_clear_mask(SIGP_CTRL_C,
-			  &vcpu->kvm->arch.sca->cpu[vcpu->vcpu_id].ctrl);
+	vcpu->kvm->arch.sca->cpu[vcpu->vcpu_id].sigp_ctrl = 0;
 }
 
 int __must_check kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu)
@@ -1000,18 +1002,43 @@ static int __inject_pfault_init(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 	return 0;
 }
 
+static int __inject_extcall_sigpif(struct kvm_vcpu *vcpu, uint16_t src_id)
+{
+	unsigned char new_val, old_val;
+	uint8_t *sigp_ctrl = &vcpu->kvm->arch.sca->cpu[vcpu->vcpu_id].sigp_ctrl;
+
+	new_val = SIGP_CTRL_C | (src_id & SIGP_CTRL_SCN_MASK);
+	old_val = *sigp_ctrl & ~SIGP_CTRL_C;
+	if (cmpxchg(sigp_ctrl, old_val, new_val) != old_val) {
+		/* another external call is pending */
+		return -EBUSY;
+	}
+	atomic_set_mask(CPUSTAT_ECALL_PEND, &vcpu->arch.sie_block->cpuflags);
+	return 0;
+}
+
 static int __inject_extcall(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 	struct kvm_s390_extcall_info *extcall = &li->irq.extcall;
+	uint16_t src_id = irq->u.extcall.code;
 
 	VCPU_EVENT(vcpu, 3, "inject: external call source-cpu:%u",
-		   irq->u.extcall.code);
+		   src_id);
 	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_INT_EXTERNAL_CALL,
-				   irq->u.extcall.code, 0, 2);
+				   src_id, 0, 2);
 
+	/* sending vcpu invalid */
+	if (src_id >= KVM_MAX_VCPUS ||
+	    kvm_get_vcpu(vcpu->kvm, src_id) == NULL)
+		return -EINVAL;
+
+	if (sclp_has_sigpif())
+		return __inject_extcall_sigpif(vcpu, src_id);
+
+	if (!test_and_set_bit(IRQ_PEND_EXT_EXTERNAL, &li->pending_irqs))
+		return -EBUSY;
 	*extcall = irq->u.extcall;
-	set_bit(IRQ_PEND_EXT_EXTERNAL, &li->pending_irqs);
 	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
 	return 0;
 }
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 6a5ed33..9bdc9f9 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -723,9 +723,11 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 		vcpu->arch.sie_block->ecb |= 0x10;
 
 	vcpu->arch.sie_block->ecb2  = 8;
-	vcpu->arch.sie_block->eca   = 0xD1002000U;
+	vcpu->arch.sie_block->eca   = 0xC1002000U;
 	if (sclp_has_siif())
 		vcpu->arch.sie_block->eca |= 1;
+	if (sclp_has_sigpif())
+		vcpu->arch.sie_block->eca |= 0x10000000U;
 	vcpu->arch.sie_block->fac   = (int) (long) vfacilities;
 	vcpu->arch.sie_block->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE |
 				      ICTL_TPROT;
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 2becffe..c22dce8 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -231,7 +231,7 @@ int s390int_to_s390irq(struct kvm_s390_interrupt *s390int,
 int kvm_s390_vcpu_has_irq(struct kvm_vcpu *vcpu, int exclude_stop);
 int psw_extint_disabled(struct kvm_vcpu *vcpu);
 void kvm_s390_destroy_adapters(struct kvm *kvm);
-int kvm_s390_si_ext_call_pending(struct kvm_vcpu *vcpu);
+int kvm_s390_ext_call_pending(struct kvm_vcpu *vcpu);
 extern struct kvm_device_ops kvm_flic_ops;
 int kvm_s390_is_stop_irq_pending(struct kvm_vcpu *vcpu);
 void kvm_s390_clear_stop_irq(struct kvm_vcpu *vcpu);
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 8ae4495..1524be9 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -26,15 +26,17 @@ static int __sigp_sense(struct kvm_vcpu *vcpu, struct kvm_vcpu *dst_vcpu,
 	struct kvm_s390_local_interrupt *li;
 	int cpuflags;
 	int rc;
+	int ext_call_pending;
 
 	li = &dst_vcpu->arch.local_int;
 
 	cpuflags = atomic_read(li->cpuflags);
-	if (!(cpuflags & (CPUSTAT_ECALL_PEND | CPUSTAT_STOPPED)))
+	ext_call_pending = kvm_s390_ext_call_pending(dst_vcpu);
+	if (!(cpuflags & CPUSTAT_STOPPED) && !ext_call_pending)
 		rc = SIGP_CC_ORDER_CODE_ACCEPTED;
 	else {
 		*reg &= 0xffffffff00000000UL;
-		if (cpuflags & CPUSTAT_ECALL_PEND)
+		if (ext_call_pending)
 			*reg |= SIGP_STATUS_EXT_CALL_PENDING;
 		if (cpuflags & CPUSTAT_STOPPED)
 			*reg |= SIGP_STATUS_STOPPED;
@@ -96,7 +98,7 @@ static int __sigp_conditional_emergency(struct kvm_vcpu *vcpu,
 }
 
 static int __sigp_external_call(struct kvm_vcpu *vcpu,
-				struct kvm_vcpu *dst_vcpu)
+				struct kvm_vcpu *dst_vcpu, u64 *reg)
 {
 	struct kvm_s390_irq irq = {
 		.type = KVM_S390_INT_EXTERNAL_CALL,
@@ -105,9 +107,14 @@ static int __sigp_external_call(struct kvm_vcpu *vcpu,
 	int rc;
 
 	rc = kvm_s390_inject_vcpu(dst_vcpu, &irq);
-	if (!rc)
+	if (rc == -EBUSY) {
+		*reg &= 0xffffffff00000000UL;
+		*reg |= SIGP_STATUS_EXT_CALL_PENDING;
+		return SIGP_CC_STATUS_STORED;
+	} else if (rc == 0) {
 		VCPU_EVENT(vcpu, 4, "sent sigp ext call to cpu %x",
 			   dst_vcpu->vcpu_id);
+	}
 
 	return rc ? rc : SIGP_CC_ORDER_CODE_ACCEPTED;
 }
@@ -303,7 +310,7 @@ static int handle_sigp_dst(struct kvm_vcpu *vcpu, u8 order_code,
 		break;
 	case SIGP_EXTERNAL_CALL:
 		vcpu->stat.instruction_sigp_external_call++;
-		rc = __sigp_external_call(vcpu, dst_vcpu);
+		rc = __sigp_external_call(vcpu, dst_vcpu, status_reg);
 		break;
 	case SIGP_EMERGENCY_SIGNAL:
 		vcpu->stat.instruction_sigp_emergency++;
-- 
1.9.3
