From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 31 May 2018 21:07:56 +0000
Subject: [GIT PULL 3/7] KVM: s390: introduce defines for control registers
Message-Id: <20180531210800.137347-4-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <david@redhat.com>

In KVM code we use masks to test/set control registers.

Let's define the ones we use in arch/s390/include/asm/ctl_reg.h and
replace all occurrences in KVM code.

As we will be needing the define for Clock-comparator sign control soon,
let's also add it.

Suggested-by: Collin L. Walling <walling@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/ctl_reg.h | 12 ++++++++++++
 arch/s390/kvm/guestdbg.c        |  2 +-
 arch/s390/kvm/interrupt.c       | 20 ++++++++++----------
 arch/s390/kvm/kvm-s390.c        | 10 +++++++---
 4 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/arch/s390/include/asm/ctl_reg.h b/arch/s390/include/asm/ctl_reg.h
index 99c93d0346f9..4600453536c2 100644
--- a/arch/s390/include/asm/ctl_reg.h
+++ b/arch/s390/include/asm/ctl_reg.h
@@ -10,8 +10,20 @@
 
 #include <linux/const.h>
 
+#define CR0_CLOCK_COMPARATOR_SIGN	_BITUL(63 - 10)
+#define CR0_EMERGENCY_SIGNAL_SUBMASK	_BITUL(63 - 49)
+#define CR0_EXTERNAL_CALL_SUBMASK	_BITUL(63 - 50)
+#define CR0_CLOCK_COMPARATOR_SUBMASK	_BITUL(63 - 52)
+#define CR0_CPU_TIMER_SUBMASK		_BITUL(63 - 53)
+#define CR0_SERVICE_SIGNAL_SUBMASK	_BITUL(63 - 54)
+#define CR0_UNUSED_56			_BITUL(63 - 56)
+#define CR0_INTERRUPT_KEY_SUBMASK	_BITUL(63 - 57)
+#define CR0_MEASUREMENT_ALERT_SUBMASK	_BITUL(63 - 58)
+
 #define CR2_GUARDED_STORAGE		_BITUL(63 - 59)
 
+#define CR14_UNUSED_32			_BITUL(63 - 32)
+#define CR14_UNUSED_33			_BITUL(63 - 33)
 #define CR14_CHANNEL_REPORT_SUBMASK	_BITUL(63 - 35)
 #define CR14_RECOVERY_SUBMASK		_BITUL(63 - 36)
 #define CR14_DEGRADATION_SUBMASK	_BITUL(63 - 37)
diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
index b5f3e82006d0..394a5f53805b 100644
--- a/arch/s390/kvm/guestdbg.c
+++ b/arch/s390/kvm/guestdbg.c
@@ -153,7 +153,7 @@ void kvm_s390_patch_guest_per_regs(struct kvm_vcpu *vcpu)
 
 	if (guestdbg_sstep_enabled(vcpu)) {
 		/* disable timer (clock-comparator) interrupts */
-		vcpu->arch.sie_block->gcr[0] &= ~0x800ul;
+		vcpu->arch.sie_block->gcr[0] &= ~CR0_CLOCK_COMPARATOR_SUBMASK;
 		vcpu->arch.sie_block->gcr[9] |= PER_EVENT_IFETCH;
 		vcpu->arch.sie_block->gcr[10] = 0;
 		vcpu->arch.sie_block->gcr[11] = -1UL;
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 37d06e022238..daa09f89ca2d 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -159,7 +159,7 @@ static int psw_interrupts_disabled(struct kvm_vcpu *vcpu)
 static int ckc_interrupts_enabled(struct kvm_vcpu *vcpu)
 {
 	if (psw_extint_disabled(vcpu) ||
-	    !(vcpu->arch.sie_block->gcr[0] & 0x800ul))
+	    !(vcpu->arch.sie_block->gcr[0] & CR0_CLOCK_COMPARATOR_SUBMASK))
 		return 0;
 	if (guestdbg_enabled(vcpu) && guestdbg_sstep_enabled(vcpu))
 		/* No timer interrupts when single stepping */
@@ -172,7 +172,7 @@ static int ckc_irq_pending(struct kvm_vcpu *vcpu)
 	const u64 now = kvm_s390_get_tod_clock_fast(vcpu->kvm);
 	const u64 ckc = vcpu->arch.sie_block->ckc;
 
-	if (vcpu->arch.sie_block->gcr[0] & 0x0020000000000000ul) {
+	if (vcpu->arch.sie_block->gcr[0] & CR0_CLOCK_COMPARATOR_SIGN) {
 		if ((s64)ckc >= (s64)now)
 			return 0;
 	} else if (ckc >= now) {
@@ -184,7 +184,7 @@ static int ckc_irq_pending(struct kvm_vcpu *vcpu)
 static int cpu_timer_interrupts_enabled(struct kvm_vcpu *vcpu)
 {
 	return !psw_extint_disabled(vcpu) &&
-	       (vcpu->arch.sie_block->gcr[0] & 0x400ul);
+	       (vcpu->arch.sie_block->gcr[0] & CR0_CPU_TIMER_SUBMASK);
 }
 
 static int cpu_timer_irq_pending(struct kvm_vcpu *vcpu)
@@ -285,15 +285,15 @@ static unsigned long deliverable_irqs(struct kvm_vcpu *vcpu)
 		active_mask &= ~IRQ_PEND_IO_MASK;
 	else
 		active_mask = disable_iscs(vcpu, active_mask);
-	if (!(vcpu->arch.sie_block->gcr[0] & 0x2000ul))
+	if (!(vcpu->arch.sie_block->gcr[0] & CR0_EXTERNAL_CALL_SUBMASK))
 		__clear_bit(IRQ_PEND_EXT_EXTERNAL, &active_mask);
-	if (!(vcpu->arch.sie_block->gcr[0] & 0x4000ul))
+	if (!(vcpu->arch.sie_block->gcr[0] & CR0_EMERGENCY_SIGNAL_SUBMASK))
 		__clear_bit(IRQ_PEND_EXT_EMERGENCY, &active_mask);
-	if (!(vcpu->arch.sie_block->gcr[0] & 0x800ul))
+	if (!(vcpu->arch.sie_block->gcr[0] & CR0_CLOCK_COMPARATOR_SUBMASK))
 		__clear_bit(IRQ_PEND_EXT_CLOCK_COMP, &active_mask);
-	if (!(vcpu->arch.sie_block->gcr[0] & 0x400ul))
+	if (!(vcpu->arch.sie_block->gcr[0] & CR0_CPU_TIMER_SUBMASK))
 		__clear_bit(IRQ_PEND_EXT_CPU_TIMER, &active_mask);
-	if (!(vcpu->arch.sie_block->gcr[0] & 0x200ul))
+	if (!(vcpu->arch.sie_block->gcr[0] & CR0_SERVICE_SIGNAL_SUBMASK))
 		__clear_bit(IRQ_PEND_EXT_SERVICE, &active_mask);
 	if (psw_mchk_disabled(vcpu))
 		active_mask &= ~IRQ_PEND_MCHK_MASK;
@@ -1042,7 +1042,7 @@ int kvm_s390_vcpu_has_irq(struct kvm_vcpu *vcpu, int exclude_stop)
 	/* external call pending and deliverable */
 	if (kvm_s390_ext_call_pending(vcpu) &&
 	    !psw_extint_disabled(vcpu) &&
-	    (vcpu->arch.sie_block->gcr[0] & 0x2000ul))
+	    (vcpu->arch.sie_block->gcr[0] & CR0_EXTERNAL_CALL_SUBMASK))
 		return 1;
 
 	if (!exclude_stop && kvm_s390_is_stop_irq_pending(vcpu))
@@ -1062,7 +1062,7 @@ static u64 __calculate_sltime(struct kvm_vcpu *vcpu)
 	u64 cputm, sltime = 0;
 
 	if (ckc_interrupts_enabled(vcpu)) {
-		if (vcpu->arch.sie_block->gcr[0] & 0x0020000000000000ul) {
+		if (vcpu->arch.sie_block->gcr[0] & CR0_CLOCK_COMPARATOR_SIGN) {
 			if ((s64)now < (s64)ckc)
 				sltime = tod_to_ns((s64)ckc - (s64)now);
 		} else if (now < ckc) {
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d9799946722e..60bb3b7243d9 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2441,8 +2441,12 @@ static void kvm_s390_vcpu_initial_reset(struct kvm_vcpu *vcpu)
 	vcpu->arch.sie_block->ckc       = 0UL;
 	vcpu->arch.sie_block->todpr     = 0;
 	memset(vcpu->arch.sie_block->gcr, 0, 16 * sizeof(__u64));
-	vcpu->arch.sie_block->gcr[0]  = 0xE0UL;
-	vcpu->arch.sie_block->gcr[14] = 0xC2000000UL;
+	vcpu->arch.sie_block->gcr[0]  = CR0_UNUSED_56 |
+					CR0_INTERRUPT_KEY_SUBMASK |
+					CR0_MEASUREMENT_ALERT_SUBMASK;
+	vcpu->arch.sie_block->gcr[14] = CR14_UNUSED_32 |
+					CR14_UNUSED_33 |
+					CR14_EXTERNAL_DAMAGE_SUBMASK;
 	/* make sure the new fpc will be lazily loaded */
 	save_fpu_regs();
 	current->thread.fpu.fpc = 0;
@@ -3200,7 +3204,7 @@ static int kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu)
 		return 0;
 	if (kvm_s390_vcpu_has_irq(vcpu, 0))
 		return 0;
-	if (!(vcpu->arch.sie_block->gcr[0] & 0x200ul))
+	if (!(vcpu->arch.sie_block->gcr[0] & CR0_SERVICE_SIGNAL_SUBMASK))
 		return 0;
 	if (!vcpu->arch.gmap->pfault_enabled)
 		return 0;
-- 
2.14.2
