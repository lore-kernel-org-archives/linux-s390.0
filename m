From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 10/11] KVM: s390: handle pending local interrupts via bitmap
Date: Fri, 28 Nov 2014 14:25:38 +0100
Message-ID: <1417181139-25623-11-git-send-email-borntraeger@de.ibm.com>
References: <1417181139-25623-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1417181139-25623-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jens Freimann <jfrei@linux.vnet.ibm.com>

This patch adapts handling of local interrupts to be more compliant with
the z/Architecture Principles of Operation and introduces a data
structure
which allows more efficient handling of interrupts.

* get rid of li->active flag, use bitmap instead
* Keep interrupts in a bitmap instead of a list
* Deliver interrupts in the order of their priority as defined in the
  PoP
* Use a second bitmap for sigp emergency requests, as a CPU can have
  one request pending from every other CPU in the system.

Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |   2 -
 arch/s390/kvm/intercept.c        |   4 +-
 arch/s390/kvm/interrupt.c        | 601 +++++++++++++++++++++++----------------
 arch/s390/kvm/kvm-s390.c         |  14 +-
 arch/s390/kvm/kvm-s390.h         |   5 +-
 arch/s390/kvm/sigp.c             |  36 +--
 6 files changed, 380 insertions(+), 282 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 624a821..9cba74d5 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -398,8 +398,6 @@ struct kvm_s390_irq_payload {
 
 struct kvm_s390_local_interrupt {
 	spinlock_t lock;
-	struct list_head list;
-	atomic_t active;
 	struct kvm_s390_float_interrupt *float_int;
 	wait_queue_head_t *wq;
 	atomic_t *cpuflags;
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 1d244df..81c77ab 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -257,7 +257,7 @@ static int handle_instruction_and_prog(struct kvm_vcpu *vcpu)
 static int handle_external_interrupt(struct kvm_vcpu *vcpu)
 {
 	u16 eic = vcpu->arch.sie_block->eic;
-	struct kvm_s390_interrupt irq;
+	struct kvm_s390_irq irq;
 	psw_t newpsw;
 	int rc;
 
@@ -282,7 +282,7 @@ static int handle_external_interrupt(struct kvm_vcpu *vcpu)
 		if (kvm_s390_si_ext_call_pending(vcpu))
 			return 0;
 		irq.type = KVM_S390_INT_EXTERNAL_CALL;
-		irq.parm = vcpu->arch.sie_block->extcpuaddr;
+		irq.u.extcall.code = vcpu->arch.sie_block->extcpuaddr;
 		break;
 	default:
 		return -EOPNOTSUPP;
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 0d7f0a7..1aa7f28 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -16,6 +16,7 @@
 #include <linux/mmu_context.h>
 #include <linux/signal.h>
 #include <linux/slab.h>
+#include <linux/bitmap.h>
 #include <asm/asm-offsets.h>
 #include <asm/uaccess.h>
 #include "kvm-s390.h"
@@ -136,6 +137,31 @@ static int __must_check __interrupt_is_deliverable(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+static inline unsigned long pending_local_irqs(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.local_int.pending_irqs;
+}
+
+static unsigned long deliverable_local_irqs(struct kvm_vcpu *vcpu)
+{
+	unsigned long active_mask = pending_local_irqs(vcpu);
+
+	if (psw_extint_disabled(vcpu))
+		active_mask &= ~IRQ_PEND_EXT_MASK;
+	if (!(vcpu->arch.sie_block->gcr[0] & 0x2000ul))
+		__clear_bit(IRQ_PEND_EXT_EXTERNAL, &active_mask);
+	if (!(vcpu->arch.sie_block->gcr[0] & 0x4000ul))
+		__clear_bit(IRQ_PEND_EXT_EMERGENCY, &active_mask);
+	if (!(vcpu->arch.sie_block->gcr[0] & 0x800ul))
+		__clear_bit(IRQ_PEND_EXT_CLOCK_COMP, &active_mask);
+	if (!(vcpu->arch.sie_block->gcr[0] & 0x400ul))
+		__clear_bit(IRQ_PEND_EXT_CPU_TIMER, &active_mask);
+	if (psw_mchk_disabled(vcpu))
+		active_mask &= ~IRQ_PEND_MCHK_MASK;
+
+	return active_mask;
+}
+
 static void __set_cpu_idle(struct kvm_vcpu *vcpu)
 {
 	atomic_set_mask(CPUSTAT_WAIT, &vcpu->arch.sie_block->cpuflags);
@@ -170,26 +196,45 @@ static void __set_cpuflag(struct kvm_vcpu *vcpu, u32 flag)
 	atomic_set_mask(flag, &vcpu->arch.sie_block->cpuflags);
 }
 
+static void set_intercept_indicators_ext(struct kvm_vcpu *vcpu)
+{
+	if (!(pending_local_irqs(vcpu) & IRQ_PEND_EXT_MASK))
+		return;
+	if (psw_extint_disabled(vcpu))
+		__set_cpuflag(vcpu, CPUSTAT_EXT_INT);
+	else
+		vcpu->arch.sie_block->lctl |= LCTL_CR0;
+}
+
+static void set_intercept_indicators_mchk(struct kvm_vcpu *vcpu)
+{
+	if (!(pending_local_irqs(vcpu) & IRQ_PEND_MCHK_MASK))
+		return;
+	if (psw_mchk_disabled(vcpu))
+		vcpu->arch.sie_block->ictl |= ICTL_LPSW;
+	else
+		vcpu->arch.sie_block->lctl |= LCTL_CR14;
+}
+
+/* Set interception request for non-deliverable local interrupts */
+static void set_intercept_indicators_local(struct kvm_vcpu *vcpu)
+{
+	set_intercept_indicators_ext(vcpu);
+	set_intercept_indicators_mchk(vcpu);
+}
+
 static void __set_intercept_indicator(struct kvm_vcpu *vcpu,
 				      struct kvm_s390_interrupt_info *inti)
 {
 	switch (inti->type) {
-	case KVM_S390_INT_EXTERNAL_CALL:
-	case KVM_S390_INT_EMERGENCY:
 	case KVM_S390_INT_SERVICE:
-	case KVM_S390_INT_PFAULT_INIT:
 	case KVM_S390_INT_PFAULT_DONE:
 	case KVM_S390_INT_VIRTIO:
-	case KVM_S390_INT_CLOCK_COMP:
-	case KVM_S390_INT_CPU_TIMER:
 		if (psw_extint_disabled(vcpu))
 			__set_cpuflag(vcpu, CPUSTAT_EXT_INT);
 		else
 			vcpu->arch.sie_block->lctl |= LCTL_CR0;
 		break;
-	case KVM_S390_SIGP_STOP:
-		__set_cpuflag(vcpu, CPUSTAT_STOP_INT);
-		break;
 	case KVM_S390_MCHK:
 		if (psw_mchk_disabled(vcpu))
 			vcpu->arch.sie_block->ictl |= ICTL_LPSW;
@@ -228,6 +273,7 @@ static u16 get_ilc(struct kvm_vcpu *vcpu)
 
 static int __must_check __deliver_cpu_timer(struct kvm_vcpu *vcpu)
 {
+	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 	int rc;
 
 	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, KVM_S390_INT_CPU_TIMER,
@@ -239,11 +285,13 @@ static int __must_check __deliver_cpu_timer(struct kvm_vcpu *vcpu)
 			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 	rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
 			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+	clear_bit(IRQ_PEND_EXT_CPU_TIMER, &li->pending_irqs);
 	return rc;
 }
 
 static int __must_check __deliver_ckc(struct kvm_vcpu *vcpu)
 {
+	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 	int rc;
 
 	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, KVM_S390_INT_CLOCK_COMP,
@@ -255,20 +303,27 @@ static int __must_check __deliver_ckc(struct kvm_vcpu *vcpu)
 			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 	rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
 			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+	clear_bit(IRQ_PEND_EXT_CLOCK_COMP, &li->pending_irqs);
 	return rc;
 }
 
-static int __must_check __deliver_pfault_init(struct kvm_vcpu *vcpu,
-					   struct kvm_s390_interrupt_info *inti)
+static int __must_check __deliver_pfault_init(struct kvm_vcpu *vcpu)
 {
-	struct kvm_s390_ext_info *ext = &inti->ext;
+	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
+	struct kvm_s390_ext_info ext;
 	int rc;
 
+	spin_lock(&li->lock);
+	ext = li->irq.ext;
+	clear_bit(IRQ_PEND_PFAULT_INIT, &li->pending_irqs);
+	li->irq.ext.ext_params2 = 0;
+	spin_unlock(&li->lock);
+
 	VCPU_EVENT(vcpu, 4, "interrupt: pfault init parm:%x,parm64:%llx",
-		   0, ext->ext_params2);
+		   0, ext.ext_params2);
 	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id,
 					 KVM_S390_INT_PFAULT_INIT,
-					 0, ext->ext_params2);
+					 0, ext.ext_params2);
 
 	rc  = put_guest_lc(vcpu, EXT_IRQ_CP_SERVICE, (u16 *) __LC_EXT_INT_CODE);
 	rc |= put_guest_lc(vcpu, PFAULT_INIT, (u16 *) __LC_EXT_CPU_ADDR);
@@ -276,28 +331,40 @@ static int __must_check __deliver_pfault_init(struct kvm_vcpu *vcpu,
 			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 	rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
 			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-	rc |= put_guest_lc(vcpu, ext->ext_params2, (u64 *) __LC_EXT_PARAMS2);
+	rc |= put_guest_lc(vcpu, ext.ext_params2, (u64 *) __LC_EXT_PARAMS2);
 	return rc;
 }
 
-static int __must_check __deliver_machine_check(struct kvm_vcpu *vcpu,
-					   struct kvm_s390_interrupt_info *inti)
+static int __must_check __deliver_machine_check(struct kvm_vcpu *vcpu)
 {
-	struct kvm_s390_mchk_info *mchk = &inti->mchk;
+	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
+	struct kvm_s390_mchk_info mchk;
 	int rc;
 
+	spin_lock(&li->lock);
+	mchk = li->irq.mchk;
+	/*
+	 * If there was an exigent machine check pending, then any repressible
+	 * machine checks that might have been pending are indicated along
+	 * with it, so always clear both bits
+	 */
+	clear_bit(IRQ_PEND_MCHK_EX, &li->pending_irqs);
+	clear_bit(IRQ_PEND_MCHK_REP, &li->pending_irqs);
+	memset(&li->irq.mchk, 0, sizeof(mchk));
+	spin_unlock(&li->lock);
+
 	VCPU_EVENT(vcpu, 4, "interrupt: machine check mcic=%llx",
-		   mchk->mcic);
+		   mchk.mcic);
 	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, KVM_S390_MCHK,
-					 mchk->cr14, mchk->mcic);
+					 mchk.cr14, mchk.mcic);
 
 	rc  = kvm_s390_vcpu_store_status(vcpu, KVM_S390_STORE_STATUS_PREFIXED);
-	rc |= put_guest_lc(vcpu, mchk->mcic,
+	rc |= put_guest_lc(vcpu, mchk.mcic,
 			   (u64 __user *) __LC_MCCK_CODE);
-	rc |= put_guest_lc(vcpu, mchk->failing_storage_address,
+	rc |= put_guest_lc(vcpu, mchk.failing_storage_address,
 			   (u64 __user *) __LC_MCCK_FAIL_STOR_ADDR);
 	rc |= write_guest_lc(vcpu, __LC_PSW_SAVE_AREA,
-			     &mchk->fixed_logout, sizeof(mchk->fixed_logout));
+			     &mchk.fixed_logout, sizeof(mchk.fixed_logout));
 	rc |= write_guest_lc(vcpu, __LC_MCK_OLD_PSW,
 			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 	rc |= read_guest_lc(vcpu, __LC_MCK_NEW_PSW,
@@ -307,6 +374,7 @@ static int __must_check __deliver_machine_check(struct kvm_vcpu *vcpu,
 
 static int __must_check __deliver_restart(struct kvm_vcpu *vcpu)
 {
+	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 	int rc;
 
 	VCPU_EVENT(vcpu, 4, "%s", "interrupt: cpu restart");
@@ -318,6 +386,7 @@ static int __must_check __deliver_restart(struct kvm_vcpu *vcpu)
 			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 	rc |= read_guest_lc(vcpu, offsetof(struct _lowcore, restart_psw),
 			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+	clear_bit(IRQ_PEND_RESTART, &li->pending_irqs);
 	return rc;
 }
 
@@ -329,38 +398,52 @@ static int __must_check __deliver_stop(struct kvm_vcpu *vcpu)
 					 0, 0);
 
 	__set_cpuflag(vcpu, CPUSTAT_STOP_INT);
+	clear_bit(IRQ_PEND_SIGP_STOP, &vcpu->arch.local_int.pending_irqs);
 	return 0;
 }
 
-static int __must_check __deliver_set_prefix(struct kvm_vcpu *vcpu,
-					   struct kvm_s390_interrupt_info *inti)
+static int __must_check __deliver_set_prefix(struct kvm_vcpu *vcpu)
 {
-	struct kvm_s390_prefix_info *prefix = &inti->prefix;
+	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
+	struct kvm_s390_prefix_info prefix;
+
+	spin_lock(&li->lock);
+	prefix = li->irq.prefix;
+	li->irq.prefix.address = 0;
+	clear_bit(IRQ_PEND_SET_PREFIX, &li->pending_irqs);
+	spin_unlock(&li->lock);
 
-	VCPU_EVENT(vcpu, 4, "interrupt: set prefix to %x", prefix->address);
+	VCPU_EVENT(vcpu, 4, "interrupt: set prefix to %x", prefix.address);
 	vcpu->stat.deliver_prefix_signal++;
 	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id,
 					 KVM_S390_SIGP_SET_PREFIX,
-					 prefix->address, 0);
+					 prefix.address, 0);
 
-	kvm_s390_set_prefix(vcpu, prefix->address);
+	kvm_s390_set_prefix(vcpu, prefix.address);
 	return 0;
 }
 
-static int __must_check __deliver_emergency_signal(struct kvm_vcpu *vcpu,
-					   struct kvm_s390_interrupt_info *inti)
+static int __must_check __deliver_emergency_signal(struct kvm_vcpu *vcpu)
 {
-	struct kvm_s390_emerg_info *emerg = &inti->emerg;
+	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 	int rc;
+	int cpu_addr;
+
+	spin_lock(&li->lock);
+	cpu_addr = find_first_bit(li->sigp_emerg_pending, KVM_MAX_VCPUS);
+	clear_bit(cpu_addr, li->sigp_emerg_pending);
+	if (bitmap_empty(li->sigp_emerg_pending, KVM_MAX_VCPUS))
+		clear_bit(IRQ_PEND_EXT_EMERGENCY, &li->pending_irqs);
+	spin_unlock(&li->lock);
 
 	VCPU_EVENT(vcpu, 4, "%s", "interrupt: sigp emerg");
 	vcpu->stat.deliver_emergency_signal++;
-	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
-					 inti->emerg.code, 0);
+	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, KVM_S390_INT_EMERGENCY,
+					 cpu_addr, 0);
 
 	rc  = put_guest_lc(vcpu, EXT_IRQ_EMERGENCY_SIG,
 			   (u16 *)__LC_EXT_INT_CODE);
-	rc |= put_guest_lc(vcpu, emerg->code, (u16 *)__LC_EXT_CPU_ADDR);
+	rc |= put_guest_lc(vcpu, cpu_addr, (u16 *)__LC_EXT_CPU_ADDR);
 	rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
 			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 	rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
@@ -368,21 +451,27 @@ static int __must_check __deliver_emergency_signal(struct kvm_vcpu *vcpu,
 	return rc;
 }
 
-static int __must_check __deliver_external_call(struct kvm_vcpu *vcpu,
-					   struct kvm_s390_interrupt_info *inti)
+static int __must_check __deliver_external_call(struct kvm_vcpu *vcpu)
 {
-	struct kvm_s390_extcall_info *extcall = &inti->extcall;
+	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
+	struct kvm_s390_extcall_info extcall;
 	int rc;
 
+	spin_lock(&li->lock);
+	extcall = li->irq.extcall;
+	li->irq.extcall.code = 0;
+	clear_bit(IRQ_PEND_EXT_EXTERNAL, &li->pending_irqs);
+	spin_unlock(&li->lock);
+
 	VCPU_EVENT(vcpu, 4, "%s", "interrupt: sigp ext call");
 	vcpu->stat.deliver_external_call++;
 	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id,
 					 KVM_S390_INT_EXTERNAL_CALL,
-					 extcall->code, 0);
+					 extcall.code, 0);
 
 	rc  = put_guest_lc(vcpu, EXT_IRQ_EXTERNAL_CALL,
 			   (u16 *)__LC_EXT_INT_CODE);
-	rc |= put_guest_lc(vcpu, extcall->code, (u16 *)__LC_EXT_CPU_ADDR);
+	rc |= put_guest_lc(vcpu, extcall.code, (u16 *)__LC_EXT_CPU_ADDR);
 	rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
 			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 	rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW, &vcpu->arch.sie_block->gpsw,
@@ -390,20 +479,26 @@ static int __must_check __deliver_external_call(struct kvm_vcpu *vcpu,
 	return rc;
 }
 
-static int __must_check __deliver_prog(struct kvm_vcpu *vcpu,
-					   struct kvm_s390_interrupt_info *inti)
+static int __must_check __deliver_prog(struct kvm_vcpu *vcpu)
 {
-	struct kvm_s390_pgm_info *pgm_info = &inti->pgm;
+	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
+	struct kvm_s390_pgm_info pgm_info;
 	int rc = 0;
 	u16 ilc = get_ilc(vcpu);
 
+	spin_lock(&li->lock);
+	pgm_info = li->irq.pgm;
+	clear_bit(IRQ_PEND_PROG, &li->pending_irqs);
+	memset(&li->irq.pgm, 0, sizeof(pgm_info));
+	spin_unlock(&li->lock);
+
 	VCPU_EVENT(vcpu, 4, "interrupt: pgm check code:%x, ilc:%x",
-		   pgm_info->code, ilc);
+		   pgm_info.code, ilc);
 	vcpu->stat.deliver_program_int++;
 	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, KVM_S390_PROGRAM_INT,
-					 pgm_info->code, 0);
+					 pgm_info.code, 0);
 
-	switch (pgm_info->code & ~PGM_PER) {
+	switch (pgm_info.code & ~PGM_PER) {
 	case PGM_AFX_TRANSLATION:
 	case PGM_ASX_TRANSLATION:
 	case PGM_EX_TRANSLATION:
@@ -414,7 +509,7 @@ static int __must_check __deliver_prog(struct kvm_vcpu *vcpu,
 	case PGM_PRIMARY_AUTHORITY:
 	case PGM_SECONDARY_AUTHORITY:
 	case PGM_SPACE_SWITCH:
-		rc = put_guest_lc(vcpu, pgm_info->trans_exc_code,
+		rc = put_guest_lc(vcpu, pgm_info.trans_exc_code,
 				  (u64 *)__LC_TRANS_EXC_CODE);
 		break;
 	case PGM_ALEN_TRANSLATION:
@@ -423,7 +518,7 @@ static int __must_check __deliver_prog(struct kvm_vcpu *vcpu,
 	case PGM_ASTE_SEQUENCE:
 	case PGM_ASTE_VALIDITY:
 	case PGM_EXTENDED_AUTHORITY:
-		rc = put_guest_lc(vcpu, pgm_info->exc_access_id,
+		rc = put_guest_lc(vcpu, pgm_info.exc_access_id,
 				  (u8 *)__LC_EXC_ACCESS_ID);
 		break;
 	case PGM_ASCE_TYPE:
@@ -432,44 +527,44 @@ static int __must_check __deliver_prog(struct kvm_vcpu *vcpu,
 	case PGM_REGION_SECOND_TRANS:
 	case PGM_REGION_THIRD_TRANS:
 	case PGM_SEGMENT_TRANSLATION:
-		rc = put_guest_lc(vcpu, pgm_info->trans_exc_code,
+		rc = put_guest_lc(vcpu, pgm_info.trans_exc_code,
 				  (u64 *)__LC_TRANS_EXC_CODE);
-		rc |= put_guest_lc(vcpu, pgm_info->exc_access_id,
+		rc |= put_guest_lc(vcpu, pgm_info.exc_access_id,
 				   (u8 *)__LC_EXC_ACCESS_ID);
-		rc |= put_guest_lc(vcpu, pgm_info->op_access_id,
+		rc |= put_guest_lc(vcpu, pgm_info.op_access_id,
 				   (u8 *)__LC_OP_ACCESS_ID);
 		break;
 	case PGM_MONITOR:
-		rc = put_guest_lc(vcpu, pgm_info->mon_class_nr,
+		rc = put_guest_lc(vcpu, pgm_info.mon_class_nr,
 				  (u16 *)__LC_MON_CLASS_NR);
-		rc |= put_guest_lc(vcpu, pgm_info->mon_code,
+		rc |= put_guest_lc(vcpu, pgm_info.mon_code,
 				   (u64 *)__LC_MON_CODE);
 		break;
 	case PGM_DATA:
-		rc = put_guest_lc(vcpu, pgm_info->data_exc_code,
+		rc = put_guest_lc(vcpu, pgm_info.data_exc_code,
 				  (u32 *)__LC_DATA_EXC_CODE);
 		break;
 	case PGM_PROTECTION:
-		rc = put_guest_lc(vcpu, pgm_info->trans_exc_code,
+		rc = put_guest_lc(vcpu, pgm_info.trans_exc_code,
 				  (u64 *)__LC_TRANS_EXC_CODE);
-		rc |= put_guest_lc(vcpu, pgm_info->exc_access_id,
+		rc |= put_guest_lc(vcpu, pgm_info.exc_access_id,
 				   (u8 *)__LC_EXC_ACCESS_ID);
 		break;
 	}
 
-	if (pgm_info->code & PGM_PER) {
-		rc |= put_guest_lc(vcpu, pgm_info->per_code,
+	if (pgm_info.code & PGM_PER) {
+		rc |= put_guest_lc(vcpu, pgm_info.per_code,
 				   (u8 *) __LC_PER_CODE);
-		rc |= put_guest_lc(vcpu, pgm_info->per_atmid,
+		rc |= put_guest_lc(vcpu, pgm_info.per_atmid,
 				   (u8 *)__LC_PER_ATMID);
-		rc |= put_guest_lc(vcpu, pgm_info->per_address,
+		rc |= put_guest_lc(vcpu, pgm_info.per_address,
 				   (u64 *) __LC_PER_ADDRESS);
-		rc |= put_guest_lc(vcpu, pgm_info->per_access_id,
+		rc |= put_guest_lc(vcpu, pgm_info.per_access_id,
 				   (u8 *) __LC_PER_ACCESS_ID);
 	}
 
 	rc |= put_guest_lc(vcpu, ilc, (u16 *) __LC_PGM_ILC);
-	rc |= put_guest_lc(vcpu, pgm_info->code,
+	rc |= put_guest_lc(vcpu, pgm_info.code,
 			   (u16 *)__LC_PGM_INT_CODE);
 	rc |= write_guest_lc(vcpu, __LC_PGM_OLD_PSW,
 			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
@@ -572,50 +667,63 @@ static int __must_check __deliver_io(struct kvm_vcpu *vcpu,
 	return rc;
 }
 
-static int __must_check __do_deliver_interrupt(struct kvm_vcpu *vcpu,
-				   struct kvm_s390_interrupt_info *inti)
+static int __must_check __deliver_mchk_floating(struct kvm_vcpu *vcpu,
+					   struct kvm_s390_interrupt_info *inti)
+{
+	struct kvm_s390_mchk_info *mchk = &inti->mchk;
+	int rc;
+
+	VCPU_EVENT(vcpu, 4, "interrupt: machine check mcic=%llx",
+		   mchk->mcic);
+	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, KVM_S390_MCHK,
+					 mchk->cr14, mchk->mcic);
+
+	rc  = kvm_s390_vcpu_store_status(vcpu, KVM_S390_STORE_STATUS_PREFIXED);
+	rc |= put_guest_lc(vcpu, mchk->mcic,
+			(u64 __user *) __LC_MCCK_CODE);
+	rc |= put_guest_lc(vcpu, mchk->failing_storage_address,
+			(u64 __user *) __LC_MCCK_FAIL_STOR_ADDR);
+	rc |= write_guest_lc(vcpu, __LC_PSW_SAVE_AREA,
+			     &mchk->fixed_logout, sizeof(mchk->fixed_logout));
+	rc |= write_guest_lc(vcpu, __LC_MCK_OLD_PSW,
+			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+	rc |= read_guest_lc(vcpu, __LC_MCK_NEW_PSW,
+			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+	return rc;
+}
+
+typedef int (*deliver_irq_t)(struct kvm_vcpu *vcpu);
+
+static const deliver_irq_t deliver_irq_funcs[] = {
+	[IRQ_PEND_MCHK_EX]        = __deliver_machine_check,
+	[IRQ_PEND_PROG]           = __deliver_prog,
+	[IRQ_PEND_EXT_EMERGENCY]  = __deliver_emergency_signal,
+	[IRQ_PEND_EXT_EXTERNAL]   = __deliver_external_call,
+	[IRQ_PEND_EXT_CLOCK_COMP] = __deliver_ckc,
+	[IRQ_PEND_EXT_CPU_TIMER]  = __deliver_cpu_timer,
+	[IRQ_PEND_RESTART]        = __deliver_restart,
+	[IRQ_PEND_SIGP_STOP]      = __deliver_stop,
+	[IRQ_PEND_SET_PREFIX]     = __deliver_set_prefix,
+	[IRQ_PEND_PFAULT_INIT]    = __deliver_pfault_init,
+};
+
+static int __must_check __deliver_floating_interrupt(struct kvm_vcpu *vcpu,
+					   struct kvm_s390_interrupt_info *inti)
 {
 	int rc;
 
 	switch (inti->type) {
-	case KVM_S390_INT_EMERGENCY:
-		rc = __deliver_emergency_signal(vcpu, inti);
-		break;
-	case KVM_S390_INT_EXTERNAL_CALL:
-		rc = __deliver_external_call(vcpu, inti);
-		break;
-	case KVM_S390_INT_CLOCK_COMP:
-		rc = __deliver_ckc(vcpu);
-		break;
-	case KVM_S390_INT_CPU_TIMER:
-		rc = __deliver_cpu_timer(vcpu);
-		break;
 	case KVM_S390_INT_SERVICE:
 		rc = __deliver_service(vcpu, inti);
 		break;
-	case KVM_S390_INT_PFAULT_INIT:
-		rc = __deliver_pfault_init(vcpu, inti);
-		break;
 	case KVM_S390_INT_PFAULT_DONE:
 		rc = __deliver_pfault_done(vcpu, inti);
 		break;
 	case KVM_S390_INT_VIRTIO:
 		rc = __deliver_virtio(vcpu, inti);
 		break;
-	case KVM_S390_SIGP_STOP:
-		rc = __deliver_stop(vcpu);
-		break;
-	case KVM_S390_SIGP_SET_PREFIX:
-		rc = __deliver_set_prefix(vcpu, inti);
-		break;
-	case KVM_S390_RESTART:
-		rc = __deliver_restart(vcpu);
-		break;
-	case KVM_S390_PROGRAM_INT:
-		rc = __deliver_prog(vcpu, inti);
-		break;
 	case KVM_S390_MCHK:
-		rc = __deliver_machine_check(vcpu, inti);
+		rc = __deliver_mchk_floating(vcpu, inti);
 		break;
 	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
 		rc = __deliver_io(vcpu, inti);
@@ -643,20 +751,11 @@ int kvm_s390_si_ext_call_pending(struct kvm_vcpu *vcpu)
 
 int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu)
 {
-	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 	struct kvm_s390_float_interrupt *fi = vcpu->arch.local_int.float_int;
 	struct kvm_s390_interrupt_info  *inti;
-	int rc = 0;
+	int rc;
 
-	if (atomic_read(&li->active)) {
-		spin_lock(&li->lock);
-		list_for_each_entry(inti, &li->list, list)
-			if (__interrupt_is_deliverable(vcpu, inti)) {
-				rc = 1;
-				break;
-			}
-		spin_unlock(&li->lock);
-	}
+	rc = !!deliverable_local_irqs(vcpu);
 
 	if ((!rc) && atomic_read(&fi->active)) {
 		spin_lock(&fi->lock);
@@ -748,18 +847,15 @@ enum hrtimer_restart kvm_s390_idle_wakeup(struct hrtimer *timer)
 void kvm_s390_clear_local_irqs(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
-	struct kvm_s390_interrupt_info  *n, *inti = NULL;
 
 	spin_lock(&li->lock);
-	list_for_each_entry_safe(inti, n, &li->list, list) {
-		list_del(&inti->list);
-		kfree(inti);
-	}
-	atomic_set(&li->active, 0);
+	li->pending_irqs = 0;
+	bitmap_zero(li->sigp_emerg_pending, KVM_MAX_VCPUS);
+	memset(&li->irq, 0, sizeof(li->irq));
 	spin_unlock(&li->lock);
 
 	/* clear pending external calls set by sigp interpretation facility */
-	atomic_clear_mask(CPUSTAT_ECALL_PEND, &vcpu->arch.sie_block->cpuflags);
+	atomic_clear_mask(CPUSTAT_ECALL_PEND, li->cpuflags);
 	atomic_clear_mask(SIGP_CTRL_C,
 			  &vcpu->kvm->arch.sca->cpu[vcpu->vcpu_id].ctrl);
 }
@@ -769,34 +865,35 @@ int __must_check kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu)
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 	struct kvm_s390_float_interrupt *fi = vcpu->arch.local_int.float_int;
 	struct kvm_s390_interrupt_info  *n, *inti = NULL;
+	deliver_irq_t func;
 	int deliver;
 	int rc = 0;
+	unsigned long irq_type;
+	unsigned long deliverable_irqs;
 
 	__reset_intercept_indicators(vcpu);
-	if (atomic_read(&li->active)) {
-		do {
-			deliver = 0;
-			spin_lock(&li->lock);
-			list_for_each_entry_safe(inti, n, &li->list, list) {
-				if (__interrupt_is_deliverable(vcpu, inti)) {
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
-				rc = __do_deliver_interrupt(vcpu, inti);
-				kfree(inti);
-			}
-		} while (!rc && deliver);
-	}
 
-	if (!rc && kvm_cpu_has_pending_timer(vcpu))
-		rc = __deliver_ckc(vcpu);
+	/* pending ckc conditions might have been invalidated */
+	clear_bit(IRQ_PEND_EXT_CLOCK_COMP, &li->pending_irqs);
+	if (kvm_cpu_has_pending_timer(vcpu))
+		set_bit(IRQ_PEND_EXT_CLOCK_COMP, &li->pending_irqs);
+
+	do {
+		deliverable_irqs = deliverable_local_irqs(vcpu);
+		/* bits are in the order of interrupt priority */
+		irq_type = find_first_bit(&deliverable_irqs, IRQ_PEND_COUNT);
+		if (irq_type == IRQ_PEND_COUNT)
+			break;
+		func = deliver_irq_funcs[irq_type];
+		if (!func) {
+			WARN_ON_ONCE(func == NULL);
+			clear_bit(irq_type, &li->pending_irqs);
+			continue;
+		}
+		rc = func(vcpu);
+	} while (!rc && irq_type != IRQ_PEND_COUNT);
+
+	set_intercept_indicators_local(vcpu);
 
 	if (!rc && atomic_read(&fi->active)) {
 		do {
@@ -815,7 +912,7 @@ int __must_check kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu)
 				atomic_set(&fi->active, 0);
 			spin_unlock(&fi->lock);
 			if (deliver) {
-				rc = __do_deliver_interrupt(vcpu, inti);
+				rc = __deliver_floating_interrupt(vcpu, inti);
 				kfree(inti);
 			}
 		} while (!rc && deliver);
@@ -824,33 +921,26 @@ int __must_check kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu)
 	return rc;
 }
 
-static int __inject_prog_irq(struct kvm_vcpu *vcpu,
-			     struct kvm_s390_interrupt_info *inti)
+static int __inject_prog(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 
-	list_add(&inti->list, &li->list);
-	atomic_set(&li->active, 1);
+	li->irq.pgm = irq->u.pgm;
+	__set_bit(IRQ_PEND_PROG, &li->pending_irqs);
 	return 0;
 }
 
 int kvm_s390_inject_program_int(struct kvm_vcpu *vcpu, u16 code)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
-	struct kvm_s390_interrupt_info *inti;
-
-	inti = kzalloc(sizeof(*inti), GFP_KERNEL);
-	if (!inti)
-		return -ENOMEM;
-
-	inti->type = KVM_S390_PROGRAM_INT;
-	inti->pgm.code = code;
+	struct kvm_s390_irq irq;
 
 	VCPU_EVENT(vcpu, 3, "inject: program check %d (from kernel)", code);
-	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, inti->type, code, 0, 1);
+	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_PROGRAM_INT, code,
+				   0, 1);
 	spin_lock(&li->lock);
-	list_add(&inti->list, &li->list);
-	atomic_set(&li->active, 1);
+	irq.u.pgm.code = code;
+	__inject_prog(vcpu, &irq);
 	BUG_ON(waitqueue_active(li->wq));
 	spin_unlock(&li->lock);
 	return 0;
@@ -860,151 +950,158 @@ int kvm_s390_inject_prog_irq(struct kvm_vcpu *vcpu,
 			     struct kvm_s390_pgm_info *pgm_info)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
-	struct kvm_s390_interrupt_info *inti;
+	struct kvm_s390_irq irq;
 	int rc;
 
-	inti = kzalloc(sizeof(*inti), GFP_KERNEL);
-	if (!inti)
-		return -ENOMEM;
-
 	VCPU_EVENT(vcpu, 3, "inject: prog irq %d (from kernel)",
 		   pgm_info->code);
 	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_PROGRAM_INT,
 				   pgm_info->code, 0, 1);
-
-	inti->type = KVM_S390_PROGRAM_INT;
-	memcpy(&inti->pgm, pgm_info, sizeof(inti->pgm));
 	spin_lock(&li->lock);
-	rc = __inject_prog_irq(vcpu, inti);
+	irq.u.pgm = *pgm_info;
+	rc = __inject_prog(vcpu, &irq);
 	BUG_ON(waitqueue_active(li->wq));
 	spin_unlock(&li->lock);
 	return rc;
 }
 
-static int __inject_pfault_init(struct kvm_vcpu *vcpu,
-				struct kvm_s390_interrupt *s390int,
-				struct kvm_s390_interrupt_info *inti)
+static int __inject_pfault_init(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 
-	inti->ext.ext_params2 = s390int->parm64;
-	list_add_tail(&inti->list, &li->list);
-	atomic_set(&li->active, 1);
+	VCPU_EVENT(vcpu, 3, "inject: external irq params:%x, params2:%llx",
+		   irq->u.ext.ext_params, irq->u.ext.ext_params2);
+	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_INT_PFAULT_INIT,
+				   irq->u.ext.ext_params,
+				   irq->u.ext.ext_params2, 2);
+
+	li->irq.ext = irq->u.ext;
+	set_bit(IRQ_PEND_PFAULT_INIT, &li->pending_irqs);
 	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
 	return 0;
 }
 
-static int __inject_extcall(struct kvm_vcpu *vcpu,
-			    struct kvm_s390_interrupt *s390int,
-			    struct kvm_s390_interrupt_info *inti)
+int __inject_extcall(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
+	struct kvm_s390_extcall_info *extcall = &li->irq.extcall;
 
 	VCPU_EVENT(vcpu, 3, "inject: external call source-cpu:%u",
-		   s390int->parm);
-	if (s390int->parm & 0xffff0000)
-		return -EINVAL;
-	inti->extcall.code = s390int->parm;
-	list_add_tail(&inti->list, &li->list);
-	atomic_set(&li->active, 1);
+		   irq->u.extcall.code);
+	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_INT_EXTERNAL_CALL,
+				   irq->u.extcall.code, 0, 2);
+
+	*extcall = irq->u.extcall;
+	__set_bit(IRQ_PEND_EXT_EXTERNAL, &li->pending_irqs);
 	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
 	return 0;
 }
 
-static int __inject_set_prefix(struct kvm_vcpu *vcpu,
-			       struct kvm_s390_interrupt *s390int,
-			       struct kvm_s390_interrupt_info *inti)
+static int __inject_set_prefix(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
+	struct kvm_s390_prefix_info *prefix = &li->irq.prefix;
 
 	VCPU_EVENT(vcpu, 3, "inject: set prefix to %x (from user)",
-		   s390int->parm);
-	inti->prefix.address = s390int->parm;
-	list_add_tail(&inti->list, &li->list);
-	atomic_set(&li->active, 1);
+		   prefix->address);
+	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_SIGP_SET_PREFIX,
+				   prefix->address, 0, 2);
+
+	*prefix = irq->u.prefix;
+	set_bit(IRQ_PEND_SET_PREFIX, &li->pending_irqs);
 	return 0;
 }
 
-static int __inject_sigp_stop(struct kvm_vcpu *vcpu,
-			      struct kvm_s390_interrupt *s390int,
-			      struct kvm_s390_interrupt_info *inti)
+static int __inject_sigp_stop(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 
-	list_add_tail(&inti->list, &li->list);
-	atomic_set(&li->active, 1);
+	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_SIGP_STOP, 0, 0, 2);
+
 	li->action_bits |= ACTION_STOP_ON_STOP;
+	set_bit(IRQ_PEND_SIGP_STOP, &li->pending_irqs);
 	return 0;
 }
 
 static int __inject_sigp_restart(struct kvm_vcpu *vcpu,
-				 struct kvm_s390_interrupt *s390int,
-				 struct kvm_s390_interrupt_info *inti)
+				 struct kvm_s390_irq *irq)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 
-	VCPU_EVENT(vcpu, 3, "inject: type %x", s390int->type);
-	list_add_tail(&inti->list, &li->list);
-	atomic_set(&li->active, 1);
+	VCPU_EVENT(vcpu, 3, "inject: restart type %llx", irq->type);
+	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_RESTART, 0, 0, 2);
+
+	set_bit(IRQ_PEND_RESTART, &li->pending_irqs);
 	return 0;
 }
 
 static int __inject_sigp_emergency(struct kvm_vcpu *vcpu,
-				   struct kvm_s390_interrupt *s390int,
-				   struct kvm_s390_interrupt_info *inti)
+				   struct kvm_s390_irq *irq)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
+	struct kvm_s390_emerg_info *emerg = &li->irq.emerg;
 
-	VCPU_EVENT(vcpu, 3, "inject: emergency %u\n", s390int->parm);
-	if (s390int->parm & 0xffff0000)
-		return -EINVAL;
-	inti->emerg.code = s390int->parm;
-	list_add_tail(&inti->list, &li->list);
-	atomic_set(&li->active, 1);
+	VCPU_EVENT(vcpu, 3, "inject: emergency %u\n",
+		   irq->u.emerg.code);
+	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_INT_EMERGENCY,
+				   emerg->code, 0, 2);
+
+	set_bit(emerg->code, li->sigp_emerg_pending);
+	set_bit(IRQ_PEND_EXT_EMERGENCY, &li->pending_irqs);
 	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
 	return 0;
 }
 
-static int __inject_mchk(struct kvm_vcpu *vcpu,
-			 struct kvm_s390_interrupt *s390int,
-			 struct kvm_s390_interrupt_info *inti)
+static int __inject_mchk(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
+	struct kvm_s390_mchk_info *mchk = &li->irq.mchk;
 
 	VCPU_EVENT(vcpu, 5, "inject: machine check parm64:%llx",
-		   s390int->parm64);
-	inti->mchk.mcic = s390int->parm64;
-	list_add_tail(&inti->list, &li->list);
-	atomic_set(&li->active, 1);
+		   mchk->mcic);
+	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_MCHK, 0,
+				   mchk->mcic, 2);
+
+	/*
+	 * Combine mcic with previously injected machine checks and
+	 * indicate them all together as described in the Principles
+	 * of Operation, Chapter 11, Interruption action
+	 */
+	mchk->mcic |= irq->u.mchk.mcic;
+	if (mchk->mcic & MCHK_EX_MASK)
+		set_bit(IRQ_PEND_MCHK_EX, &li->pending_irqs);
+	else if (mchk->mcic & MCHK_REP_MASK)
+		set_bit(IRQ_PEND_MCHK_REP,  &li->pending_irqs);
 	return 0;
 }
 
-static int __inject_ckc(struct kvm_vcpu *vcpu,
-			struct kvm_s390_interrupt *s390int,
-			struct kvm_s390_interrupt_info *inti)
+static int __inject_ckc(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 
-	VCPU_EVENT(vcpu, 3, "inject: type %x", s390int->type);
-	list_add_tail(&inti->list, &li->list);
-	atomic_set(&li->active, 1);
+	VCPU_EVENT(vcpu, 3, "inject: type %x", KVM_S390_INT_CLOCK_COMP);
+	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_INT_CLOCK_COMP,
+				   0, 0, 2);
+
+	set_bit(IRQ_PEND_EXT_CLOCK_COMP, &li->pending_irqs);
 	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
 	return 0;
 }
 
-static int __inject_cpu_timer(struct kvm_vcpu *vcpu,
-			      struct kvm_s390_interrupt *s390int,
-			      struct kvm_s390_interrupt_info *inti)
+static int __inject_cpu_timer(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 
-	VCPU_EVENT(vcpu, 3, "inject: type %x", s390int->type);
-	list_add_tail(&inti->list, &li->list);
-	atomic_set(&li->active, 1);
+	VCPU_EVENT(vcpu, 3, "inject: type %x", KVM_S390_INT_CPU_TIMER);
+	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_INT_CPU_TIMER,
+				   0, 0, 2);
+
+	set_bit(IRQ_PEND_EXT_CPU_TIMER, &li->pending_irqs);
 	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
 	return 0;
 }
 
+
 struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
 						    u64 cr6, u64 schid)
 {
@@ -1169,58 +1266,74 @@ void kvm_s390_reinject_io_int(struct kvm *kvm,
 	__inject_vm(kvm, inti);
 }
 
-int kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
-			 struct kvm_s390_interrupt *s390int)
+int s390int_to_s390irq(struct kvm_s390_interrupt *s390int,
+		       struct kvm_s390_irq *irq)
+{
+	irq->type = s390int->type;
+	switch (irq->type) {
+	case KVM_S390_PROGRAM_INT:
+		if (s390int->parm & 0xffff0000)
+			return -EINVAL;
+		irq->u.pgm.code = s390int->parm;
+		break;
+	case KVM_S390_SIGP_SET_PREFIX:
+		irq->u.prefix.address = s390int->parm;
+		break;
+	case KVM_S390_INT_EXTERNAL_CALL:
+		if (irq->u.extcall.code & 0xffff0000)
+			return -EINVAL;
+		irq->u.extcall.code = s390int->parm;
+		break;
+	case KVM_S390_INT_EMERGENCY:
+		if (irq->u.emerg.code & 0xffff0000)
+			return -EINVAL;
+		irq->u.emerg.code = s390int->parm;
+		break;
+	case KVM_S390_MCHK:
+		irq->u.mchk.mcic = s390int->parm64;
+		break;
+	}
+	return 0;
+}
+
+int kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
-	struct kvm_s390_interrupt_info *inti;
 	int rc;
 
-	inti = kzalloc(sizeof(*inti), GFP_KERNEL);
-	if (!inti)
-		return -ENOMEM;
-
-	inti->type = s390int->type;
-
-	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, s390int->type,
-				   s390int->parm, 0, 2);
 	spin_lock(&li->lock);
-	switch (inti->type) {
+	switch (irq->type) {
 	case KVM_S390_PROGRAM_INT:
 		VCPU_EVENT(vcpu, 3, "inject: program check %d (from user)",
-			   s390int->parm);
-		inti->pgm.code = s390int->parm;
-		if (s390int->parm & 0xffff0000)
-			rc = -EINVAL;
-		else
-			rc = __inject_prog_irq(vcpu, inti);
+			   irq->u.pgm.code);
+		rc = __inject_prog(vcpu, irq);
 		break;
 	case KVM_S390_SIGP_SET_PREFIX:
-		rc = __inject_set_prefix(vcpu, s390int, inti);
+		rc = __inject_set_prefix(vcpu, irq);
 		break;
 	case KVM_S390_SIGP_STOP:
-		rc = __inject_sigp_stop(vcpu, s390int, inti);
+		rc = __inject_sigp_stop(vcpu, irq);
 		break;
 	case KVM_S390_RESTART:
-		rc = __inject_sigp_restart(vcpu, s390int, inti);
+		rc = __inject_sigp_restart(vcpu, irq);
 		break;
 	case KVM_S390_INT_CLOCK_COMP:
-		rc = __inject_ckc(vcpu, s390int, inti);
+		rc = __inject_ckc(vcpu);
 		break;
 	case KVM_S390_INT_CPU_TIMER:
-		rc = __inject_cpu_timer(vcpu, s390int, inti);
+		rc = __inject_cpu_timer(vcpu);
 		break;
 	case KVM_S390_INT_EXTERNAL_CALL:
-		rc = __inject_extcall(vcpu, s390int, inti);
+		rc = __inject_extcall(vcpu, irq);
 		break;
 	case KVM_S390_INT_EMERGENCY:
-		rc = __inject_sigp_emergency(vcpu, s390int, inti);
+		rc = __inject_sigp_emergency(vcpu, irq);
 		break;
 	case KVM_S390_MCHK:
-		rc = __inject_mchk(vcpu, s390int, inti);
+		rc = __inject_mchk(vcpu, irq);
 		break;
 	case KVM_S390_INT_PFAULT_INIT:
-		rc = __inject_pfault_init(vcpu, s390int, inti);
+		rc = __inject_pfault_init(vcpu, irq);
 		break;
 	case KVM_S390_INT_VIRTIO:
 	case KVM_S390_INT_SERVICE:
@@ -1231,8 +1344,6 @@ int kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
 	spin_unlock(&li->lock);
 	if (!rc)
 		kvm_s390_vcpu_wakeup(vcpu);
-	else
-		kfree(inti);
 	return rc;
 }
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 06878bd..f66591e 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -719,7 +719,6 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
 	}
 
 	spin_lock_init(&vcpu->arch.local_int.lock);
-	INIT_LIST_HEAD(&vcpu->arch.local_int.list);
 	vcpu->arch.local_int.float_int = &kvm->arch.float_int;
 	vcpu->arch.local_int.wq = &vcpu->wq;
 	vcpu->arch.local_int.cpuflags = &vcpu->arch.sie_block->cpuflags;
@@ -1122,13 +1121,15 @@ static void __kvm_inject_pfault_token(struct kvm_vcpu *vcpu, bool start_token,
 				      unsigned long token)
 {
 	struct kvm_s390_interrupt inti;
-	inti.parm64 = token;
+	struct kvm_s390_irq irq;
 
 	if (start_token) {
-		inti.type = KVM_S390_INT_PFAULT_INIT;
-		WARN_ON_ONCE(kvm_s390_inject_vcpu(vcpu, &inti));
+		irq.u.ext.ext_params2 = token;
+		irq.type = KVM_S390_INT_PFAULT_INIT;
+		WARN_ON_ONCE(kvm_s390_inject_vcpu(vcpu, &irq));
 	} else {
 		inti.type = KVM_S390_INT_PFAULT_DONE;
+		inti.parm64 = token;
 		WARN_ON_ONCE(kvm_s390_inject_vm(vcpu->kvm, &inti));
 	}
 }
@@ -1622,11 +1623,14 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	switch (ioctl) {
 	case KVM_S390_INTERRUPT: {
 		struct kvm_s390_interrupt s390int;
+		struct kvm_s390_irq s390irq;
 
 		r = -EFAULT;
 		if (copy_from_user(&s390int, argp, sizeof(s390int)))
 			break;
-		r = kvm_s390_inject_vcpu(vcpu, &s390int);
+		if (s390int_to_s390irq(&s390int, &s390irq))
+			return -EINVAL;
+		r = kvm_s390_inject_vcpu(vcpu, &s390irq);
 		break;
 	}
 	case KVM_S390_STORE_STATUS:
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index ff8d977..a8f3d9b 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -142,7 +142,7 @@ void kvm_s390_clear_float_irqs(struct kvm *kvm);
 int __must_check kvm_s390_inject_vm(struct kvm *kvm,
 				    struct kvm_s390_interrupt *s390int);
 int __must_check kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
-				      struct kvm_s390_interrupt *s390int);
+				      struct kvm_s390_irq *irq);
 int __must_check kvm_s390_inject_program_int(struct kvm_vcpu *vcpu, u16 code);
 struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
 						    u64 cr6, u64 schid);
@@ -224,6 +224,9 @@ static inline int kvm_s390_inject_prog_cond(struct kvm_vcpu *vcpu, int rc)
 	return kvm_s390_inject_prog_irq(vcpu, &vcpu->arch.pgm);
 }
 
+int s390int_to_s390irq(struct kvm_s390_interrupt *s390int,
+			struct kvm_s390_irq *s390irq);
+
 /* implemented in interrupt.c */
 int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu);
 int psw_extint_disabled(struct kvm_vcpu *vcpu);
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index f7cd3f7..6651f9f 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -49,13 +49,13 @@ static int __sigp_sense(struct kvm_vcpu *vcpu, struct kvm_vcpu *dst_vcpu,
 static int __inject_sigp_emergency(struct kvm_vcpu *vcpu,
 				    struct kvm_vcpu *dst_vcpu)
 {
-	struct kvm_s390_interrupt s390int = {
+	struct kvm_s390_irq irq = {
 		.type = KVM_S390_INT_EMERGENCY,
-		.parm = vcpu->vcpu_id,
+		.u.emerg.code = vcpu->vcpu_id,
 	};
 	int rc = 0;
 
-	rc = kvm_s390_inject_vcpu(dst_vcpu, &s390int);
+	rc = kvm_s390_inject_vcpu(dst_vcpu, &irq);
 	if (!rc)
 		VCPU_EVENT(vcpu, 4, "sent sigp emerg to cpu %x",
 			   dst_vcpu->vcpu_id);
@@ -98,13 +98,13 @@ static int __sigp_conditional_emergency(struct kvm_vcpu *vcpu,
 static int __sigp_external_call(struct kvm_vcpu *vcpu,
 				struct kvm_vcpu *dst_vcpu)
 {
-	struct kvm_s390_interrupt s390int = {
+	struct kvm_s390_irq irq = {
 		.type = KVM_S390_INT_EXTERNAL_CALL,
-		.parm = vcpu->vcpu_id,
+		.u.extcall.code = vcpu->vcpu_id,
 	};
 	int rc;
 
-	rc = kvm_s390_inject_vcpu(dst_vcpu, &s390int);
+	rc = kvm_s390_inject_vcpu(dst_vcpu, &irq);
 	if (!rc)
 		VCPU_EVENT(vcpu, 4, "sent sigp ext call to cpu %x",
 			   dst_vcpu->vcpu_id);
@@ -115,29 +115,20 @@ static int __sigp_external_call(struct kvm_vcpu *vcpu,
 static int __inject_sigp_stop(struct kvm_vcpu *dst_vcpu, int action)
 {
 	struct kvm_s390_local_interrupt *li = &dst_vcpu->arch.local_int;
-	struct kvm_s390_interrupt_info *inti;
 	int rc = SIGP_CC_ORDER_CODE_ACCEPTED;
 
-	inti = kzalloc(sizeof(*inti), GFP_ATOMIC);
-	if (!inti)
-		return -ENOMEM;
-	inti->type = KVM_S390_SIGP_STOP;
-
 	spin_lock(&li->lock);
 	if (li->action_bits & ACTION_STOP_ON_STOP) {
 		/* another SIGP STOP is pending */
-		kfree(inti);
 		rc = SIGP_CC_BUSY;
 		goto out;
 	}
 	if ((atomic_read(li->cpuflags) & CPUSTAT_STOPPED)) {
-		kfree(inti);
 		if ((action & ACTION_STORE_ON_STOP) != 0)
 			rc = -ESHUTDOWN;
 		goto out;
 	}
-	list_add_tail(&inti->list, &li->list);
-	atomic_set(&li->active, 1);
+	set_bit(IRQ_PEND_SIGP_STOP, &li->pending_irqs);
 	li->action_bits |= action;
 	atomic_set_mask(CPUSTAT_STOP_INT, li->cpuflags);
 	kvm_s390_vcpu_wakeup(dst_vcpu);
@@ -207,7 +198,6 @@ static int __sigp_set_prefix(struct kvm_vcpu *vcpu, struct kvm_vcpu *dst_vcpu,
 			     u32 address, u64 *reg)
 {
 	struct kvm_s390_local_interrupt *li;
-	struct kvm_s390_interrupt_info *inti;
 	int rc;
 
 	li = &dst_vcpu->arch.local_int;
@@ -224,25 +214,17 @@ static int __sigp_set_prefix(struct kvm_vcpu *vcpu, struct kvm_vcpu *dst_vcpu,
 		return SIGP_CC_STATUS_STORED;
 	}
 
-	inti = kzalloc(sizeof(*inti), GFP_KERNEL);
-	if (!inti)
-		return SIGP_CC_BUSY;
-
 	spin_lock(&li->lock);
 	/* cpu must be in stopped state */
 	if (!(atomic_read(li->cpuflags) & CPUSTAT_STOPPED)) {
 		*reg &= 0xffffffff00000000UL;
 		*reg |= SIGP_STATUS_INCORRECT_STATE;
 		rc = SIGP_CC_STATUS_STORED;
-		kfree(inti);
 		goto out_li;
 	}
 
-	inti->type = KVM_S390_SIGP_SET_PREFIX;
-	inti->prefix.address = address;
-
-	list_add_tail(&inti->list, &li->list);
-	atomic_set(&li->active, 1);
+	li->irq.prefix.address = address;
+	set_bit(IRQ_PEND_SET_PREFIX, &li->pending_irqs);
 	kvm_s390_vcpu_wakeup(dst_vcpu);
 	rc = SIGP_CC_ORDER_CODE_ACCEPTED;
 
-- 
1.9.3
