From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1] KVM: s390: use switch vs jump table in interrupt.c
Date: Tue,  6 Feb 2018 15:17:43 +0100
Message-ID: <20180206141743.24497-1-david@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Just like for the interception handlers, let's also use a switch-case
in our interrupt delivery code.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kvm/interrupt.c | 84 ++++++++++++++++++++++++++++-------------------
 1 file changed, 50 insertions(+), 34 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index aabf46f5f883..3ea9cfa31b16 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -187,12 +187,6 @@ static int cpu_timer_irq_pending(struct kvm_vcpu *vcpu)
 	return kvm_s390_get_cpu_timer(vcpu) >> 63;
 }
 
-static inline int is_ioirq(unsigned long irq_type)
-{
-	return ((irq_type >= IRQ_PEND_IO_ISC_7) &&
-		(irq_type <= IRQ_PEND_IO_ISC_0));
-}
-
 static uint64_t isc_to_isc_bits(int isc)
 {
 	return (0x80 >> isc) << 24;
@@ -1011,24 +1005,6 @@ static int __must_check __deliver_io(struct kvm_vcpu *vcpu,
 	return rc;
 }
 
-typedef int (*deliver_irq_t)(struct kvm_vcpu *vcpu);
-
-static const deliver_irq_t deliver_irq_funcs[] = {
-	[IRQ_PEND_MCHK_EX]        = __deliver_machine_check,
-	[IRQ_PEND_MCHK_REP]       = __deliver_machine_check,
-	[IRQ_PEND_PROG]           = __deliver_prog,
-	[IRQ_PEND_EXT_EMERGENCY]  = __deliver_emergency_signal,
-	[IRQ_PEND_EXT_EXTERNAL]   = __deliver_external_call,
-	[IRQ_PEND_EXT_CLOCK_COMP] = __deliver_ckc,
-	[IRQ_PEND_EXT_CPU_TIMER]  = __deliver_cpu_timer,
-	[IRQ_PEND_RESTART]        = __deliver_restart,
-	[IRQ_PEND_SET_PREFIX]     = __deliver_set_prefix,
-	[IRQ_PEND_PFAULT_INIT]    = __deliver_pfault_init,
-	[IRQ_PEND_EXT_SERVICE]    = __deliver_service,
-	[IRQ_PEND_PFAULT_DONE]    = __deliver_pfault_done,
-	[IRQ_PEND_VIRTIO]         = __deliver_virtio,
-};
-
 /* Check whether an external call is pending (deliverable or not) */
 int kvm_s390_ext_call_pending(struct kvm_vcpu *vcpu)
 {
@@ -1192,7 +1168,6 @@ void kvm_s390_clear_local_irqs(struct kvm_vcpu *vcpu)
 int __must_check kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
-	deliver_irq_t func;
 	int rc = 0;
 	unsigned long irq_type;
 	unsigned long irqs;
@@ -1212,16 +1187,57 @@ int __must_check kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu)
 	while ((irqs = deliverable_irqs(vcpu)) && !rc) {
 		/* bits are in the reverse order of interrupt priority */
 		irq_type = find_last_bit(&irqs, IRQ_PEND_COUNT);
-		if (is_ioirq(irq_type)) {
+		switch (irq_type) {
+		case IRQ_PEND_IO_ISC_0:
+		case IRQ_PEND_IO_ISC_1:
+		case IRQ_PEND_IO_ISC_2:
+		case IRQ_PEND_IO_ISC_3:
+		case IRQ_PEND_IO_ISC_4:
+		case IRQ_PEND_IO_ISC_5:
+		case IRQ_PEND_IO_ISC_6:
+		case IRQ_PEND_IO_ISC_7:
 			rc = __deliver_io(vcpu, irq_type);
-		} else {
-			func = deliver_irq_funcs[irq_type];
-			if (!func) {
-				WARN_ON_ONCE(func == NULL);
-				clear_bit(irq_type, &li->pending_irqs);
-				continue;
-			}
-			rc = func(vcpu);
+			break;
+		case IRQ_PEND_MCHK_EX:
+		case IRQ_PEND_MCHK_REP:
+			rc = __deliver_machine_check(vcpu);
+			break;
+		case IRQ_PEND_PROG:
+			rc = __deliver_prog(vcpu);
+			break;
+		case IRQ_PEND_EXT_EMERGENCY:
+			rc = __deliver_emergency_signal(vcpu);
+			break;
+		case IRQ_PEND_EXT_EXTERNAL:
+			rc = __deliver_external_call(vcpu);
+			break;
+		case IRQ_PEND_EXT_CLOCK_COMP:
+			rc = __deliver_ckc(vcpu);
+			break;
+		case IRQ_PEND_EXT_CPU_TIMER:
+			rc = __deliver_cpu_timer(vcpu);
+			break;
+		case IRQ_PEND_RESTART:
+			rc = __deliver_restart(vcpu);
+			break;
+		case IRQ_PEND_SET_PREFIX:
+			rc = __deliver_set_prefix(vcpu);
+			break;
+		case IRQ_PEND_PFAULT_INIT:
+			rc = __deliver_pfault_init(vcpu);
+			break;
+		case IRQ_PEND_EXT_SERVICE:
+			rc = __deliver_service(vcpu);
+			break;
+		case IRQ_PEND_PFAULT_DONE:
+			rc = __deliver_pfault_done(vcpu);
+			break;
+		case IRQ_PEND_VIRTIO:
+			rc = __deliver_virtio(vcpu);
+			break;
+		default:
+			WARN_ONCE(1, "Unknown pending irq type %ld", irq_type);
+			clear_bit(irq_type, &li->pending_irqs);
 		}
 	}
 
-- 
2.14.3
