From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 4/8] KVM: s390: deliver floating interrupts in order of priority
Date: Tue, 31 Mar 2015 15:01:59 +0200
Message-ID: <1427806923-21910-5-git-send-email-borntraeger@de.ibm.com>
References: <1427806923-21910-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1427806923-21910-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jens Freimann <jfrei@linux.vnet.ibm.com>

This patch makes interrupt handling compliant to the z/Architecture
Principles of Operation with regard to interrupt priorities.

Add a bitmap for pending floating interrupts. Each bit relates to a
interrupt type and its list. A turned on bit indicates that a list
contains items (interrupts) which need to be delivered.  When delivering
interrupts on a cpu we can merge the existing bitmap for cpu-local
interrupts and floating interrupts and have a single mechanism for
delivery.
Currently we have one list for all kinds of floating interrupts and a
corresponding spin lock. This patch adds a separate list per
interrupt type. An exception to this are service signal and machine check
interrupts, as there can be only one pending interrupt at a time.

Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  30 +-
 arch/s390/kvm/interrupt.c        | 834 ++++++++++++++++++++++-----------------
 arch/s390/kvm/kvm-s390.c         |   4 +-
 arch/s390/kvm/kvm-s390.h         |   2 +-
 arch/s390/kvm/priv.c             |   9 +-
 5 files changed, 511 insertions(+), 368 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index b8d1e97..d01fc58 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -344,6 +344,11 @@ enum irq_types {
 	IRQ_PEND_COUNT
 };
 
+/* We have 2M for virtio device descriptor pages. Smallest amount of
+ * memory per page is 24 bytes (1 queue), so (2048*1024) / 24 = 87381
+ */
+#define KVM_S390_MAX_VIRTIO_IRQS 87381
+
 /*
  * Repressible (non-floating) machine check interrupts
  * subclass bits in MCIC
@@ -421,13 +426,32 @@ struct kvm_s390_local_interrupt {
 	unsigned long pending_irqs;
 };
 
+#define FIRQ_LIST_IO_ISC_0 0
+#define FIRQ_LIST_IO_ISC_1 1
+#define FIRQ_LIST_IO_ISC_2 2
+#define FIRQ_LIST_IO_ISC_3 3
+#define FIRQ_LIST_IO_ISC_4 4
+#define FIRQ_LIST_IO_ISC_5 5
+#define FIRQ_LIST_IO_ISC_6 6
+#define FIRQ_LIST_IO_ISC_7 7
+#define FIRQ_LIST_PFAULT   8
+#define FIRQ_LIST_VIRTIO   9
+#define FIRQ_LIST_COUNT   10
+#define FIRQ_CNTR_IO       0
+#define FIRQ_CNTR_SERVICE  1
+#define FIRQ_CNTR_VIRTIO   2
+#define FIRQ_CNTR_PFAULT   3
+#define FIRQ_MAX_COUNT     4
+
 struct kvm_s390_float_interrupt {
+	unsigned long pending_irqs;
 	spinlock_t lock;
-	struct list_head list;
-	atomic_t active;
+	struct list_head lists[FIRQ_LIST_COUNT];
+	int counters[FIRQ_MAX_COUNT];
+	struct kvm_s390_mchk_info mchk;
+	struct kvm_s390_ext_info srv_signal;
 	int next_rr_cpu;
 	unsigned long idle_mask[BITS_TO_LONGS(KVM_MAX_VCPUS)];
-	unsigned int irq_count;
 };
 
 struct kvm_hw_wp_info_arch {
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 65b4eee..298d63b 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -22,6 +22,7 @@
 #include <asm/dis.h>
 #include <asm/uaccess.h>
 #include <asm/sclp.h>
+#include <asm/isc.h>
 #include "kvm-s390.h"
 #include "gaccess.h"
 #include "trace-s390.h"
@@ -34,11 +35,6 @@
 #define PFAULT_DONE 0x0680
 #define VIRTIO_PARAM 0x0d00
 
-static int is_ioint(u64 type)
-{
-	return ((type & 0xfffe0000u) != 0xfffe0000u);
-}
-
 int psw_extint_disabled(struct kvm_vcpu *vcpu)
 {
 	return !(vcpu->arch.sie_block->gpsw.mask & PSW_MASK_EXT);
@@ -74,70 +70,25 @@ static int ckc_interrupts_enabled(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
-static u64 int_word_to_isc_bits(u32 int_word)
+static inline int is_ioirq(unsigned long irq_type)
 {
-	u8 isc = (int_word & 0x38000000) >> 27;
+	return ((irq_type >= IRQ_PEND_IO_ISC_0) &&
+		(irq_type <= IRQ_PEND_IO_ISC_7));
+}
 
+static uint64_t isc_to_isc_bits(int isc)
+{
 	return (0x80 >> isc) << 24;
 }
 
-static int __must_check __interrupt_is_deliverable(struct kvm_vcpu *vcpu,
-				      struct kvm_s390_interrupt_info *inti)
+static inline u8 int_word_to_isc(u32 int_word)
 {
-	switch (inti->type) {
-	case KVM_S390_INT_EXTERNAL_CALL:
-		if (psw_extint_disabled(vcpu))
-			return 0;
-		if (vcpu->arch.sie_block->gcr[0] & 0x2000ul)
-			return 1;
-		return 0;
-	case KVM_S390_INT_EMERGENCY:
-		if (psw_extint_disabled(vcpu))
-			return 0;
-		if (vcpu->arch.sie_block->gcr[0] & 0x4000ul)
-			return 1;
-		return 0;
-	case KVM_S390_INT_CLOCK_COMP:
-		return ckc_interrupts_enabled(vcpu);
-	case KVM_S390_INT_CPU_TIMER:
-		if (psw_extint_disabled(vcpu))
-			return 0;
-		if (vcpu->arch.sie_block->gcr[0] & 0x400ul)
-			return 1;
-		return 0;
-	case KVM_S390_INT_SERVICE:
-	case KVM_S390_INT_PFAULT_INIT:
-	case KVM_S390_INT_PFAULT_DONE:
-	case KVM_S390_INT_VIRTIO:
-		if (psw_extint_disabled(vcpu))
-			return 0;
-		if (vcpu->arch.sie_block->gcr[0] & 0x200ul)
-			return 1;
-		return 0;
-	case KVM_S390_PROGRAM_INT:
-	case KVM_S390_SIGP_STOP:
-	case KVM_S390_SIGP_SET_PREFIX:
-	case KVM_S390_RESTART:
-		return 1;
-	case KVM_S390_MCHK:
-		if (psw_mchk_disabled(vcpu))
-			return 0;
-		if (vcpu->arch.sie_block->gcr[14] & inti->mchk.cr14)
-			return 1;
-		return 0;
-	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
-		if (psw_ioint_disabled(vcpu))
-			return 0;
-		if (vcpu->arch.sie_block->gcr[6] &
-		    int_word_to_isc_bits(inti->io.io_int_word))
-			return 1;
-		return 0;
-	default:
-		printk(KERN_WARNING "illegal interrupt type %llx\n",
-		       inti->type);
-		BUG();
-	}
-	return 0;
+	return (int_word & 0x38000000) >> 27;
+}
+
+static inline unsigned long pending_floating_irqs(struct kvm_vcpu *vcpu)
+{
+	return vcpu->kvm->arch.float_int.pending_irqs;
 }
 
 static inline unsigned long pending_local_irqs(struct kvm_vcpu *vcpu)
@@ -145,12 +96,31 @@ static inline unsigned long pending_local_irqs(struct kvm_vcpu *vcpu)
 	return vcpu->arch.local_int.pending_irqs;
 }
 
-static unsigned long deliverable_local_irqs(struct kvm_vcpu *vcpu)
+static unsigned long disable_iscs(struct kvm_vcpu *vcpu,
+				   unsigned long active_mask)
 {
-	unsigned long active_mask = pending_local_irqs(vcpu);
+	int i;
+
+	for (i = 0; i <= MAX_ISC; i++)
+		if (!(vcpu->arch.sie_block->gcr[6] & isc_to_isc_bits(i)))
+			active_mask &= ~(1UL << (IRQ_PEND_IO_ISC_0 + i));
+
+	return active_mask;
+}
+
+static unsigned long deliverable_irqs(struct kvm_vcpu *vcpu)
+{
+	unsigned long active_mask;
+
+	active_mask = pending_local_irqs(vcpu);
+	active_mask |= pending_floating_irqs(vcpu);
 
 	if (psw_extint_disabled(vcpu))
 		active_mask &= ~IRQ_PEND_EXT_MASK;
+	if (psw_ioint_disabled(vcpu))
+		active_mask &= ~IRQ_PEND_IO_MASK;
+	else
+		active_mask = disable_iscs(vcpu, active_mask);
 	if (!(vcpu->arch.sie_block->gcr[0] & 0x2000ul))
 		__clear_bit(IRQ_PEND_EXT_EXTERNAL, &active_mask);
 	if (!(vcpu->arch.sie_block->gcr[0] & 0x4000ul))
@@ -159,8 +129,13 @@ static unsigned long deliverable_local_irqs(struct kvm_vcpu *vcpu)
 		__clear_bit(IRQ_PEND_EXT_CLOCK_COMP, &active_mask);
 	if (!(vcpu->arch.sie_block->gcr[0] & 0x400ul))
 		__clear_bit(IRQ_PEND_EXT_CPU_TIMER, &active_mask);
+	if (!(vcpu->arch.sie_block->gcr[0] & 0x200ul))
+		__clear_bit(IRQ_PEND_EXT_SERVICE, &active_mask);
 	if (psw_mchk_disabled(vcpu))
 		active_mask &= ~IRQ_PEND_MCHK_MASK;
+	if (!(vcpu->arch.sie_block->gcr[14] &
+	      vcpu->kvm->arch.float_int.mchk.cr14))
+		__clear_bit(IRQ_PEND_MCHK_REP, &active_mask);
 
 	/*
 	 * STOP irqs will never be actively delivered. They are triggered via
@@ -202,6 +177,16 @@ static void __set_cpuflag(struct kvm_vcpu *vcpu, u32 flag)
 	atomic_set_mask(flag, &vcpu->arch.sie_block->cpuflags);
 }
 
+static void set_intercept_indicators_io(struct kvm_vcpu *vcpu)
+{
+	if (!(pending_floating_irqs(vcpu) & IRQ_PEND_IO_MASK))
+		return;
+	else if (psw_ioint_disabled(vcpu))
+		__set_cpuflag(vcpu, CPUSTAT_IO_INT);
+	else
+		vcpu->arch.sie_block->lctl |= LCTL_CR6;
+}
+
 static void set_intercept_indicators_ext(struct kvm_vcpu *vcpu)
 {
 	if (!(pending_local_irqs(vcpu) & IRQ_PEND_EXT_MASK))
@@ -228,43 +213,15 @@ static void set_intercept_indicators_stop(struct kvm_vcpu *vcpu)
 		__set_cpuflag(vcpu, CPUSTAT_STOP_INT);
 }
 
-/* Set interception request for non-deliverable local interrupts */
-static void set_intercept_indicators_local(struct kvm_vcpu *vcpu)
+/* Set interception request for non-deliverable interrupts */
+static void set_intercept_indicators(struct kvm_vcpu *vcpu)
 {
+	set_intercept_indicators_io(vcpu);
 	set_intercept_indicators_ext(vcpu);
 	set_intercept_indicators_mchk(vcpu);
 	set_intercept_indicators_stop(vcpu);
 }
 
-static void __set_intercept_indicator(struct kvm_vcpu *vcpu,
-				      struct kvm_s390_interrupt_info *inti)
-{
-	switch (inti->type) {
-	case KVM_S390_INT_SERVICE:
-	case KVM_S390_INT_PFAULT_DONE:
-	case KVM_S390_INT_VIRTIO:
-		if (psw_extint_disabled(vcpu))
-			__set_cpuflag(vcpu, CPUSTAT_EXT_INT);
-		else
-			vcpu->arch.sie_block->lctl |= LCTL_CR0;
-		break;
-	case KVM_S390_MCHK:
-		if (psw_mchk_disabled(vcpu))
-			vcpu->arch.sie_block->ictl |= ICTL_LPSW;
-		else
-			vcpu->arch.sie_block->lctl |= LCTL_CR14;
-		break;
-	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
-		if (psw_ioint_disabled(vcpu))
-			__set_cpuflag(vcpu, CPUSTAT_IO_INT);
-		else
-			vcpu->arch.sie_block->lctl |= LCTL_CR6;
-		break;
-	default:
-		BUG();
-	}
-}
-
 static u16 get_ilc(struct kvm_vcpu *vcpu)
 {
 	switch (vcpu->arch.sie_block->icptcode) {
@@ -350,42 +307,72 @@ static int __must_check __deliver_pfault_init(struct kvm_vcpu *vcpu)
 
 static int __must_check __deliver_machine_check(struct kvm_vcpu *vcpu)
 {
+	struct kvm_s390_float_interrupt *fi = &vcpu->kvm->arch.float_int;
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
-	struct kvm_s390_mchk_info mchk;
+	struct kvm_s390_mchk_info mchk = {};
 	unsigned long adtl_status_addr;
-	int rc;
+	int deliver = 0;
+	int rc = 0;
 
+	spin_lock(&fi->lock);
 	spin_lock(&li->lock);
-	mchk = li->irq.mchk;
+	if (test_bit(IRQ_PEND_MCHK_EX, &li->pending_irqs) ||
+	    test_bit(IRQ_PEND_MCHK_REP, &li->pending_irqs)) {
+		/*
+		 * If there was an exigent machine check pending, then any
+		 * repressible machine checks that might have been pending
+		 * are indicated along with it, so always clear bits for
+		 * repressible and exigent interrupts
+		 */
+		mchk = li->irq.mchk;
+		clear_bit(IRQ_PEND_MCHK_EX, &li->pending_irqs);
+		clear_bit(IRQ_PEND_MCHK_REP, &li->pending_irqs);
+		memset(&li->irq.mchk, 0, sizeof(mchk));
+		deliver = 1;
+	}
 	/*
-	 * If there was an exigent machine check pending, then any repressible
-	 * machine checks that might have been pending are indicated along
-	 * with it, so always clear both bits
+	 * We indicate floating repressible conditions along with
+	 * other pending conditions. Channel Report Pending and Channel
+	 * Subsystem damage are the only two and and are indicated by
+	 * bits in mcic and masked in cr14.
 	 */
-	clear_bit(IRQ_PEND_MCHK_EX, &li->pending_irqs);
-	clear_bit(IRQ_PEND_MCHK_REP, &li->pending_irqs);
-	memset(&li->irq.mchk, 0, sizeof(mchk));
+	if (test_and_clear_bit(IRQ_PEND_MCHK_REP, &fi->pending_irqs)) {
+		mchk.mcic |= fi->mchk.mcic;
+		mchk.cr14 |= fi->mchk.cr14;
+		memset(&fi->mchk, 0, sizeof(mchk));
+		deliver = 1;
+	}
 	spin_unlock(&li->lock);
+	spin_unlock(&fi->lock);
 
-	VCPU_EVENT(vcpu, 4, "interrupt: machine check mcic=%llx",
-		   mchk.mcic);
-	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, KVM_S390_MCHK,
-					 mchk.cr14, mchk.mcic);
-
-	rc  = kvm_s390_vcpu_store_status(vcpu, KVM_S390_STORE_STATUS_PREFIXED);
-	rc |= read_guest_lc(vcpu, __LC_VX_SAVE_AREA_ADDR,
-			    &adtl_status_addr, sizeof(unsigned long));
-	rc |= kvm_s390_vcpu_store_adtl_status(vcpu, adtl_status_addr);
-	rc |= put_guest_lc(vcpu, mchk.mcic,
-			   (u64 __user *) __LC_MCCK_CODE);
-	rc |= put_guest_lc(vcpu, mchk.failing_storage_address,
-			   (u64 __user *) __LC_MCCK_FAIL_STOR_ADDR);
-	rc |= write_guest_lc(vcpu, __LC_PSW_SAVE_AREA,
-			     &mchk.fixed_logout, sizeof(mchk.fixed_logout));
-	rc |= write_guest_lc(vcpu, __LC_MCK_OLD_PSW,
-			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-	rc |= read_guest_lc(vcpu, __LC_MCK_NEW_PSW,
-			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+	if (deliver) {
+		VCPU_EVENT(vcpu, 4, "interrupt: machine check mcic=%llx",
+			   mchk.mcic);
+		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id,
+						 KVM_S390_MCHK,
+						 mchk.cr14, mchk.mcic);
+
+		rc  = kvm_s390_vcpu_store_status(vcpu,
+						 KVM_S390_STORE_STATUS_PREFIXED);
+		rc |= read_guest_lc(vcpu, __LC_VX_SAVE_AREA_ADDR,
+				    &adtl_status_addr,
+				    sizeof(unsigned long));
+		rc |= kvm_s390_vcpu_store_adtl_status(vcpu,
+						      adtl_status_addr);
+		rc |= put_guest_lc(vcpu, mchk.mcic,
+				   (u64 __user *) __LC_MCCK_CODE);
+		rc |= put_guest_lc(vcpu, mchk.failing_storage_address,
+				   (u64 __user *) __LC_MCCK_FAIL_STOR_ADDR);
+		rc |= write_guest_lc(vcpu, __LC_PSW_SAVE_AREA,
+				     &mchk.fixed_logout,
+				     sizeof(mchk.fixed_logout));
+		rc |= write_guest_lc(vcpu, __LC_MCK_OLD_PSW,
+				     &vcpu->arch.sie_block->gpsw,
+				     sizeof(psw_t));
+		rc |= read_guest_lc(vcpu, __LC_MCK_NEW_PSW,
+				    &vcpu->arch.sie_block->gpsw,
+				    sizeof(psw_t));
+	}
 	return rc ? -EFAULT : 0;
 }
 
@@ -597,16 +584,27 @@ static int __must_check __deliver_prog(struct kvm_vcpu *vcpu)
 	return rc ? -EFAULT : 0;
 }
 
-static int __must_check __deliver_service(struct kvm_vcpu *vcpu,
-					  struct kvm_s390_interrupt_info *inti)
+static int __must_check __deliver_service(struct kvm_vcpu *vcpu)
 {
-	int rc;
+	struct kvm_s390_float_interrupt *fi = &vcpu->kvm->arch.float_int;
+	struct kvm_s390_ext_info ext;
+	int rc = 0;
+
+	spin_lock(&fi->lock);
+	if (!(test_bit(IRQ_PEND_EXT_SERVICE, &fi->pending_irqs))) {
+		spin_unlock(&fi->lock);
+		return 0;
+	}
+	ext = fi->srv_signal;
+	memset(&fi->srv_signal, 0, sizeof(ext));
+	clear_bit(IRQ_PEND_EXT_SERVICE, &fi->pending_irqs);
+	spin_unlock(&fi->lock);
 
 	VCPU_EVENT(vcpu, 4, "interrupt: sclp parm:%x",
-		   inti->ext.ext_params);
+		   ext.ext_params);
 	vcpu->stat.deliver_service_signal++;
-	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
-					 inti->ext.ext_params, 0);
+	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, KVM_S390_INT_SERVICE,
+					 ext.ext_params, 0);
 
 	rc  = put_guest_lc(vcpu, EXT_IRQ_SERVICE_SIG, (u16 *)__LC_EXT_INT_CODE);
 	rc |= put_guest_lc(vcpu, 0, (u16 *)__LC_EXT_CPU_ADDR);
@@ -614,106 +612,146 @@ static int __must_check __deliver_service(struct kvm_vcpu *vcpu,
 			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 	rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
 			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-	rc |= put_guest_lc(vcpu, inti->ext.ext_params,
+	rc |= put_guest_lc(vcpu, ext.ext_params,
 			   (u32 *)__LC_EXT_PARAMS);
+
 	return rc ? -EFAULT : 0;
 }
 
-static int __must_check __deliver_pfault_done(struct kvm_vcpu *vcpu,
-					   struct kvm_s390_interrupt_info *inti)
+static int __must_check __deliver_pfault_done(struct kvm_vcpu *vcpu)
 {
-	int rc;
+	struct kvm_s390_float_interrupt *fi = &vcpu->kvm->arch.float_int;
+	struct kvm_s390_interrupt_info *inti;
+	int rc = 0;
 
-	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id,
-					 KVM_S390_INT_PFAULT_DONE, 0,
-					 inti->ext.ext_params2);
+	spin_lock(&fi->lock);
+	inti = list_first_entry_or_null(&fi->lists[FIRQ_LIST_PFAULT],
+					struct kvm_s390_interrupt_info,
+					list);
+	if (inti) {
+		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id,
+				KVM_S390_INT_PFAULT_DONE, 0,
+				inti->ext.ext_params2);
+		list_del(&inti->list);
+		fi->counters[FIRQ_CNTR_PFAULT] -= 1;
+	}
+	if (list_empty(&fi->lists[FIRQ_LIST_PFAULT]))
+		clear_bit(IRQ_PEND_PFAULT_DONE, &fi->pending_irqs);
+	spin_unlock(&fi->lock);
 
-	rc  = put_guest_lc(vcpu, EXT_IRQ_CP_SERVICE, (u16 *)__LC_EXT_INT_CODE);
-	rc |= put_guest_lc(vcpu, PFAULT_DONE, (u16 *)__LC_EXT_CPU_ADDR);
-	rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
-			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-	rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
-			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-	rc |= put_guest_lc(vcpu, inti->ext.ext_params2,
-			   (u64 *)__LC_EXT_PARAMS2);
+	if (inti) {
+		rc  = put_guest_lc(vcpu, EXT_IRQ_CP_SERVICE,
+				(u16 *)__LC_EXT_INT_CODE);
+		rc |= put_guest_lc(vcpu, PFAULT_DONE,
+				(u16 *)__LC_EXT_CPU_ADDR);
+		rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
+				&vcpu->arch.sie_block->gpsw,
+				sizeof(psw_t));
+		rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
+				&vcpu->arch.sie_block->gpsw,
+				sizeof(psw_t));
+		rc |= put_guest_lc(vcpu, inti->ext.ext_params2,
+				(u64 *)__LC_EXT_PARAMS2);
+		kfree(inti);
+	}
 	return rc ? -EFAULT : 0;
 }
 
-static int __must_check __deliver_virtio(struct kvm_vcpu *vcpu,
-					 struct kvm_s390_interrupt_info *inti)
+static int __must_check __deliver_virtio(struct kvm_vcpu *vcpu)
 {
-	int rc;
+	struct kvm_s390_float_interrupt *fi = &vcpu->kvm->arch.float_int;
+	struct kvm_s390_interrupt_info *inti;
+	int rc = 0;
 
-	VCPU_EVENT(vcpu, 4, "interrupt: virtio parm:%x,parm64:%llx",
-		   inti->ext.ext_params, inti->ext.ext_params2);
-	vcpu->stat.deliver_virtio_interrupt++;
-	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
-					 inti->ext.ext_params,
-					 inti->ext.ext_params2);
+	spin_lock(&fi->lock);
+	inti = list_first_entry_or_null(&fi->lists[FIRQ_LIST_VIRTIO],
+					struct kvm_s390_interrupt_info,
+					list);
+	if (inti) {
+		VCPU_EVENT(vcpu, 4,
+			   "interrupt: virtio parm:%x,parm64:%llx",
+			   inti->ext.ext_params, inti->ext.ext_params2);
+		vcpu->stat.deliver_virtio_interrupt++;
+		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id,
+				inti->type,
+				inti->ext.ext_params,
+				inti->ext.ext_params2);
+		list_del(&inti->list);
+		fi->counters[FIRQ_CNTR_VIRTIO] -= 1;
+	}
+	if (list_empty(&fi->lists[FIRQ_LIST_VIRTIO]))
+		clear_bit(IRQ_PEND_VIRTIO, &fi->pending_irqs);
+	spin_unlock(&fi->lock);
 
-	rc  = put_guest_lc(vcpu, EXT_IRQ_CP_SERVICE, (u16 *)__LC_EXT_INT_CODE);
-	rc |= put_guest_lc(vcpu, VIRTIO_PARAM, (u16 *)__LC_EXT_CPU_ADDR);
-	rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
-			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-	rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
-			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-	rc |= put_guest_lc(vcpu, inti->ext.ext_params,
-			   (u32 *)__LC_EXT_PARAMS);
-	rc |= put_guest_lc(vcpu, inti->ext.ext_params2,
-			   (u64 *)__LC_EXT_PARAMS2);
+	if (inti) {
+		rc  = put_guest_lc(vcpu, EXT_IRQ_CP_SERVICE,
+				(u16 *)__LC_EXT_INT_CODE);
+		rc |= put_guest_lc(vcpu, VIRTIO_PARAM,
+				(u16 *)__LC_EXT_CPU_ADDR);
+		rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
+				&vcpu->arch.sie_block->gpsw,
+				sizeof(psw_t));
+		rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
+				&vcpu->arch.sie_block->gpsw,
+				sizeof(psw_t));
+		rc |= put_guest_lc(vcpu, inti->ext.ext_params,
+				(u32 *)__LC_EXT_PARAMS);
+		rc |= put_guest_lc(vcpu, inti->ext.ext_params2,
+				(u64 *)__LC_EXT_PARAMS2);
+		kfree(inti);
+	}
 	return rc ? -EFAULT : 0;
 }
 
 static int __must_check __deliver_io(struct kvm_vcpu *vcpu,
-				     struct kvm_s390_interrupt_info *inti)
+				     unsigned long irq_type)
 {
-	int rc;
+	struct list_head *isc_list;
+	struct kvm_s390_float_interrupt *fi;
+	struct kvm_s390_interrupt_info *inti = NULL;
+	int rc = 0;
 
-	VCPU_EVENT(vcpu, 4, "interrupt: I/O %llx", inti->type);
-	vcpu->stat.deliver_io_int++;
-	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
-					 ((__u32)inti->io.subchannel_id << 16) |
-						inti->io.subchannel_nr,
-					 ((__u64)inti->io.io_int_parm << 32) |
-						inti->io.io_int_word);
-
-	rc  = put_guest_lc(vcpu, inti->io.subchannel_id,
-			   (u16 *)__LC_SUBCHANNEL_ID);
-	rc |= put_guest_lc(vcpu, inti->io.subchannel_nr,
-			   (u16 *)__LC_SUBCHANNEL_NR);
-	rc |= put_guest_lc(vcpu, inti->io.io_int_parm,
-			   (u32 *)__LC_IO_INT_PARM);
-	rc |= put_guest_lc(vcpu, inti->io.io_int_word,
-			   (u32 *)__LC_IO_INT_WORD);
-	rc |= write_guest_lc(vcpu, __LC_IO_OLD_PSW,
-			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-	rc |= read_guest_lc(vcpu, __LC_IO_NEW_PSW,
-			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-	return rc ? -EFAULT : 0;
-}
+	fi = &vcpu->kvm->arch.float_int;
 
-static int __must_check __deliver_mchk_floating(struct kvm_vcpu *vcpu,
-					   struct kvm_s390_interrupt_info *inti)
-{
-	struct kvm_s390_mchk_info *mchk = &inti->mchk;
-	int rc;
+	spin_lock(&fi->lock);
+	isc_list = &fi->lists[irq_type - IRQ_PEND_IO_ISC_0];
+	inti = list_first_entry_or_null(isc_list,
+					struct kvm_s390_interrupt_info,
+					list);
+	if (inti) {
+		VCPU_EVENT(vcpu, 4, "interrupt: I/O %llx", inti->type);
+		vcpu->stat.deliver_io_int++;
+		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id,
+				inti->type,
+				((__u32)inti->io.subchannel_id << 16) |
+				inti->io.subchannel_nr,
+				((__u64)inti->io.io_int_parm << 32) |
+				inti->io.io_int_word);
+		list_del(&inti->list);
+		fi->counters[FIRQ_CNTR_IO] -= 1;
+	}
+	if (list_empty(isc_list))
+		clear_bit(irq_type, &fi->pending_irqs);
+	spin_unlock(&fi->lock);
+
+	if (inti) {
+		rc  = put_guest_lc(vcpu, inti->io.subchannel_id,
+				(u16 *)__LC_SUBCHANNEL_ID);
+		rc |= put_guest_lc(vcpu, inti->io.subchannel_nr,
+				(u16 *)__LC_SUBCHANNEL_NR);
+		rc |= put_guest_lc(vcpu, inti->io.io_int_parm,
+				(u32 *)__LC_IO_INT_PARM);
+		rc |= put_guest_lc(vcpu, inti->io.io_int_word,
+				(u32 *)__LC_IO_INT_WORD);
+		rc |= write_guest_lc(vcpu, __LC_IO_OLD_PSW,
+				&vcpu->arch.sie_block->gpsw,
+				sizeof(psw_t));
+		rc |= read_guest_lc(vcpu, __LC_IO_NEW_PSW,
+				&vcpu->arch.sie_block->gpsw,
+				sizeof(psw_t));
+		kfree(inti);
+	}
 
-	VCPU_EVENT(vcpu, 4, "interrupt: machine check mcic=%llx",
-		   mchk->mcic);
-	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, KVM_S390_MCHK,
-					 mchk->cr14, mchk->mcic);
-
-	rc  = kvm_s390_vcpu_store_status(vcpu, KVM_S390_STORE_STATUS_PREFIXED);
-	rc |= put_guest_lc(vcpu, mchk->mcic,
-			(u64 __user *) __LC_MCCK_CODE);
-	rc |= put_guest_lc(vcpu, mchk->failing_storage_address,
-			(u64 __user *) __LC_MCCK_FAIL_STOR_ADDR);
-	rc |= write_guest_lc(vcpu, __LC_PSW_SAVE_AREA,
-			     &mchk->fixed_logout, sizeof(mchk->fixed_logout));
-	rc |= write_guest_lc(vcpu, __LC_MCK_OLD_PSW,
-			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-	rc |= read_guest_lc(vcpu, __LC_MCK_NEW_PSW,
-			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 	return rc ? -EFAULT : 0;
 }
 
@@ -721,6 +759,7 @@ typedef int (*deliver_irq_t)(struct kvm_vcpu *vcpu);
 
 static const deliver_irq_t deliver_irq_funcs[] = {
 	[IRQ_PEND_MCHK_EX]        = __deliver_machine_check,
+	[IRQ_PEND_MCHK_REP]       = __deliver_machine_check,
 	[IRQ_PEND_PROG]           = __deliver_prog,
 	[IRQ_PEND_EXT_EMERGENCY]  = __deliver_emergency_signal,
 	[IRQ_PEND_EXT_EXTERNAL]   = __deliver_external_call,
@@ -729,36 +768,11 @@ static const deliver_irq_t deliver_irq_funcs[] = {
 	[IRQ_PEND_RESTART]        = __deliver_restart,
 	[IRQ_PEND_SET_PREFIX]     = __deliver_set_prefix,
 	[IRQ_PEND_PFAULT_INIT]    = __deliver_pfault_init,
+	[IRQ_PEND_EXT_SERVICE]    = __deliver_service,
+	[IRQ_PEND_PFAULT_DONE]    = __deliver_pfault_done,
+	[IRQ_PEND_VIRTIO]         = __deliver_virtio,
 };
 
-static int __must_check __deliver_floating_interrupt(struct kvm_vcpu *vcpu,
-					   struct kvm_s390_interrupt_info *inti)
-{
-	int rc;
-
-	switch (inti->type) {
-	case KVM_S390_INT_SERVICE:
-		rc = __deliver_service(vcpu, inti);
-		break;
-	case KVM_S390_INT_PFAULT_DONE:
-		rc = __deliver_pfault_done(vcpu, inti);
-		break;
-	case KVM_S390_INT_VIRTIO:
-		rc = __deliver_virtio(vcpu, inti);
-		break;
-	case KVM_S390_MCHK:
-		rc = __deliver_mchk_floating(vcpu, inti);
-		break;
-	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
-		rc = __deliver_io(vcpu, inti);
-		break;
-	default:
-		BUG();
-	}
-
-	return rc;
-}
-
 /* Check whether an external call is pending (deliverable or not) */
 int kvm_s390_ext_call_pending(struct kvm_vcpu *vcpu)
 {
@@ -774,21 +788,9 @@ int kvm_s390_ext_call_pending(struct kvm_vcpu *vcpu)
 
 int kvm_s390_vcpu_has_irq(struct kvm_vcpu *vcpu, int exclude_stop)
 {
-	struct kvm_s390_float_interrupt *fi = vcpu->arch.local_int.float_int;
-	struct kvm_s390_interrupt_info  *inti;
 	int rc;
 
-	rc = !!deliverable_local_irqs(vcpu);
-
-	if ((!rc) && atomic_read(&fi->active)) {
-		spin_lock(&fi->lock);
-		list_for_each_entry(inti, &fi->list, list)
-			if (__interrupt_is_deliverable(vcpu, inti)) {
-				rc = 1;
-				break;
-			}
-		spin_unlock(&fi->lock);
-	}
+	rc = !!deliverable_irqs(vcpu);
 
 	if (!rc && kvm_cpu_has_pending_timer(vcpu))
 		rc = 1;
@@ -907,13 +909,10 @@ void kvm_s390_clear_local_irqs(struct kvm_vcpu *vcpu)
 int __must_check kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
-	struct kvm_s390_float_interrupt *fi = vcpu->arch.local_int.float_int;
-	struct kvm_s390_interrupt_info  *n, *inti = NULL;
 	deliver_irq_t func;
-	int deliver;
 	int rc = 0;
 	unsigned long irq_type;
-	unsigned long deliverable_irqs;
+	unsigned long irqs;
 
 	__reset_intercept_indicators(vcpu);
 
@@ -923,44 +922,27 @@ int __must_check kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu)
 		set_bit(IRQ_PEND_EXT_CLOCK_COMP, &li->pending_irqs);
 
 	do {
-		deliverable_irqs = deliverable_local_irqs(vcpu);
+		irqs = deliverable_irqs(vcpu);
 		/* bits are in the order of interrupt priority */
-		irq_type = find_first_bit(&deliverable_irqs, IRQ_PEND_COUNT);
+		irq_type = find_first_bit(&irqs, IRQ_PEND_COUNT);
 		if (irq_type == IRQ_PEND_COUNT)
 			break;
-		func = deliver_irq_funcs[irq_type];
-		if (!func) {
-			WARN_ON_ONCE(func == NULL);
-			clear_bit(irq_type, &li->pending_irqs);
-			continue;
+		if (is_ioirq(irq_type)) {
+			rc = __deliver_io(vcpu, irq_type);
+		} else {
+			func = deliver_irq_funcs[irq_type];
+			if (!func) {
+				WARN_ON_ONCE(func == NULL);
+				clear_bit(irq_type, &li->pending_irqs);
+				continue;
+			}
+			rc = func(vcpu);
 		}
-		rc = func(vcpu);
-	} while (!rc && irq_type != IRQ_PEND_COUNT);
-
-	set_intercept_indicators_local(vcpu);
+		if (rc)
+			break;
+	} while (!rc);
 
-	if (!rc && atomic_read(&fi->active)) {
-		do {
-			deliver = 0;
-			spin_lock(&fi->lock);
-			list_for_each_entry_safe(inti, n, &fi->list, list) {
-				if (__interrupt_is_deliverable(vcpu, inti)) {
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
-				rc = __deliver_floating_interrupt(vcpu, inti);
-				kfree(inti);
-			}
-		} while (!rc && deliver);
-	}
+	set_intercept_indicators(vcpu);
 
 	return rc;
 }
@@ -1195,80 +1177,182 @@ static int __inject_cpu_timer(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static struct kvm_s390_interrupt_info *get_io_int(struct kvm *kvm,
+						  int isc, u32 schid)
+{
+	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
+	struct list_head *isc_list = &fi->lists[FIRQ_LIST_IO_ISC_0 + isc];
+	struct kvm_s390_interrupt_info *iter;
+	u16 id = (schid & 0xffff0000U) >> 16;
+	u16 nr = schid & 0x0000ffffU;
 
+	spin_lock(&fi->lock);
+	list_for_each_entry(iter, isc_list, list) {
+		if (schid && (id != iter->io.subchannel_id ||
+			      nr != iter->io.subchannel_nr))
+			continue;
+		/* found an appropriate entry */
+		list_del_init(&iter->list);
+		fi->counters[FIRQ_CNTR_IO] -= 1;
+		if (list_empty(isc_list))
+			clear_bit(IRQ_PEND_IO_ISC_0 + isc, &fi->pending_irqs);
+		spin_unlock(&fi->lock);
+		return iter;
+	}
+	spin_unlock(&fi->lock);
+	return NULL;
+}
+
+/*
+ * Dequeue and return an I/O interrupt matching any of the interruption
+ * subclasses as designated by the isc mask in cr6 and the schid (if != 0).
+ */
 struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
-						    u64 cr6, u64 schid)
+						    u64 isc_mask, u32 schid)
+{
+	struct kvm_s390_interrupt_info *inti = NULL;
+	int isc;
+
+	for (isc = 0; isc <= MAX_ISC && !inti; isc++) {
+		if (isc_mask & isc_to_isc_bits(isc))
+			inti = get_io_int(kvm, isc, schid);
+	}
+	return inti;
+}
+
+#define SCCB_MASK 0xFFFFFFF8
+#define SCCB_EVENT_PENDING 0x3
+
+static int __inject_service(struct kvm *kvm,
+			     struct kvm_s390_interrupt_info *inti)
+{
+	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
+
+	spin_lock(&fi->lock);
+	fi->srv_signal.ext_params |= inti->ext.ext_params & SCCB_EVENT_PENDING;
+	/*
+	 * Early versions of the QEMU s390 bios will inject several
+	 * service interrupts after another without handling a
+	 * condition code indicating busy.
+	 * We will silently ignore those superfluous sccb values.
+	 * A future version of QEMU will take care of serialization
+	 * of servc requests
+	 */
+	if (fi->srv_signal.ext_params & SCCB_MASK)
+		goto out;
+	fi->srv_signal.ext_params |= inti->ext.ext_params & SCCB_MASK;
+	set_bit(IRQ_PEND_EXT_SERVICE, &fi->pending_irqs);
+out:
+	spin_unlock(&fi->lock);
+	kfree(inti);
+	return 0;
+}
+
+static int __inject_virtio(struct kvm *kvm,
+			    struct kvm_s390_interrupt_info *inti)
+{
+	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
+
+	spin_lock(&fi->lock);
+	if (fi->counters[FIRQ_CNTR_VIRTIO] >= KVM_S390_MAX_VIRTIO_IRQS) {
+		spin_unlock(&fi->lock);
+		return -EBUSY;
+	}
+	fi->counters[FIRQ_CNTR_VIRTIO] += 1;
+	list_add_tail(&inti->list, &fi->lists[FIRQ_LIST_VIRTIO]);
+	set_bit(IRQ_PEND_VIRTIO, &fi->pending_irqs);
+	spin_unlock(&fi->lock);
+	return 0;
+}
+
+static int __inject_pfault_done(struct kvm *kvm,
+				 struct kvm_s390_interrupt_info *inti)
+{
+	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
+
+	spin_lock(&fi->lock);
+	if (fi->counters[FIRQ_CNTR_PFAULT] >=
+		(ASYNC_PF_PER_VCPU * KVM_MAX_VCPUS)) {
+		spin_unlock(&fi->lock);
+		return -EBUSY;
+	}
+	fi->counters[FIRQ_CNTR_PFAULT] += 1;
+	list_add_tail(&inti->list, &fi->lists[FIRQ_LIST_PFAULT]);
+	set_bit(IRQ_PEND_PFAULT_DONE, &fi->pending_irqs);
+	spin_unlock(&fi->lock);
+	return 0;
+}
+
+#define CR_PENDING_SUBCLASS 28
+static int __inject_float_mchk(struct kvm *kvm,
+				struct kvm_s390_interrupt_info *inti)
+{
+	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
+
+	spin_lock(&fi->lock);
+	fi->mchk.cr14 |= inti->mchk.cr14 & (1UL << CR_PENDING_SUBCLASS);
+	fi->mchk.mcic |= inti->mchk.mcic;
+	set_bit(IRQ_PEND_MCHK_REP, &fi->pending_irqs);
+	spin_unlock(&fi->lock);
+	kfree(inti);
+	return 0;
+}
+
+static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 {
 	struct kvm_s390_float_interrupt *fi;
-	struct kvm_s390_interrupt_info *inti, *iter;
+	struct list_head *list;
+	int isc;
 
-	if ((!schid && !cr6) || (schid && cr6))
-		return NULL;
 	fi = &kvm->arch.float_int;
 	spin_lock(&fi->lock);
-	inti = NULL;
-	list_for_each_entry(iter, &fi->list, list) {
-		if (!is_ioint(iter->type))
-			continue;
-		if (cr6 &&
-		    ((cr6 & int_word_to_isc_bits(iter->io.io_int_word)) == 0))
-			continue;
-		if (schid) {
-			if (((schid & 0x00000000ffff0000) >> 16) !=
-			    iter->io.subchannel_id)
-				continue;
-			if ((schid & 0x000000000000ffff) !=
-			    iter->io.subchannel_nr)
-				continue;
-		}
-		inti = iter;
-		break;
-	}
-	if (inti) {
-		list_del_init(&inti->list);
-		fi->irq_count--;
+	if (fi->counters[FIRQ_CNTR_IO] >= KVM_S390_MAX_FLOAT_IRQS) {
+		spin_unlock(&fi->lock);
+		return -EBUSY;
 	}
-	if (list_empty(&fi->list))
-		atomic_set(&fi->active, 0);
+	fi->counters[FIRQ_CNTR_IO] += 1;
+
+	isc = int_word_to_isc(inti->io.io_int_word);
+	list = &fi->lists[FIRQ_LIST_IO_ISC_0 + isc];
+	list_add_tail(&inti->list, list);
+	set_bit(IRQ_PEND_IO_ISC_0 + isc, &fi->pending_irqs);
 	spin_unlock(&fi->lock);
-	return inti;
+	return 0;
 }
 
 static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 {
 	struct kvm_s390_local_interrupt *li;
 	struct kvm_s390_float_interrupt *fi;
-	struct kvm_s390_interrupt_info *iter;
 	struct kvm_vcpu *dst_vcpu = NULL;
 	int sigcpu;
-	int rc = 0;
+	u64 type = READ_ONCE(inti->type);
+	int rc;
 
 	fi = &kvm->arch.float_int;
-	spin_lock(&fi->lock);
-	if (fi->irq_count >= KVM_S390_MAX_FLOAT_IRQS) {
+
+	switch (type) {
+	case KVM_S390_MCHK:
+		rc = __inject_float_mchk(kvm, inti);
+		break;
+	case KVM_S390_INT_VIRTIO:
+		rc = __inject_virtio(kvm, inti);
+		break;
+	case KVM_S390_INT_SERVICE:
+		rc = __inject_service(kvm, inti);
+		break;
+	case KVM_S390_INT_PFAULT_DONE:
+		rc = __inject_pfault_done(kvm, inti);
+		break;
+	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
+		rc = __inject_io(kvm, inti);
+		break;
+	default:
 		rc = -EINVAL;
-		goto unlock_fi;
 	}
-	fi->irq_count++;
-	if (!is_ioint(inti->type)) {
-		list_add_tail(&inti->list, &fi->list);
-	} else {
-		u64 isc_bits = int_word_to_isc_bits(inti->io.io_int_word);
+	if (rc)
+		return rc;
 
-		/* Keep I/O interrupts sorted in isc order. */
-		list_for_each_entry(iter, &fi->list, list) {
-			if (!is_ioint(iter->type))
-				continue;
-			if (int_word_to_isc_bits(iter->io.io_int_word)
-			    <= isc_bits)
-				continue;
-			break;
-		}
-		list_add_tail(&inti->list, &iter->list);
-	}
-	atomic_set(&fi->active, 1);
-	if (atomic_read(&kvm->online_vcpus) == 0)
-		goto unlock_fi;
 	sigcpu = find_first_bit(fi->idle_mask, KVM_MAX_VCPUS);
 	if (sigcpu == KVM_MAX_VCPUS) {
 		do {
@@ -1280,7 +1364,7 @@ static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 	dst_vcpu = kvm_get_vcpu(kvm, sigcpu);
 	li = &dst_vcpu->arch.local_int;
 	spin_lock(&li->lock);
-	switch (inti->type) {
+	switch (type) {
 	case KVM_S390_MCHK:
 		atomic_set_mask(CPUSTAT_STOP_INT, li->cpuflags);
 		break;
@@ -1293,9 +1377,8 @@ static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 	}
 	spin_unlock(&li->lock);
 	kvm_s390_vcpu_wakeup(kvm_get_vcpu(kvm, sigcpu));
-unlock_fi:
-	spin_unlock(&fi->lock);
-	return rc;
+	return 0;
+
 }
 
 int kvm_s390_inject_vm(struct kvm *kvm,
@@ -1462,20 +1545,14 @@ int kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 	return rc;
 }
 
-void kvm_s390_clear_float_irqs(struct kvm *kvm)
+static inline void clear_irq_list(struct list_head *_list)
 {
-	struct kvm_s390_float_interrupt *fi;
-	struct kvm_s390_interrupt_info	*n, *inti = NULL;
+	struct kvm_s390_interrupt_info *inti, *n;
 
-	fi = &kvm->arch.float_int;
-	spin_lock(&fi->lock);
-	list_for_each_entry_safe(inti, n, &fi->list, list) {
+	list_for_each_entry_safe(inti, n, _list, list) {
 		list_del(&inti->list);
 		kfree(inti);
 	}
-	fi->irq_count = 0;
-	atomic_set(&fi->active, 0);
-	spin_unlock(&fi->lock);
 }
 
 static void inti_to_irq(struct kvm_s390_interrupt_info *inti,
@@ -1486,26 +1563,37 @@ static void inti_to_irq(struct kvm_s390_interrupt_info *inti,
 	case KVM_S390_INT_PFAULT_INIT:
 	case KVM_S390_INT_PFAULT_DONE:
 	case KVM_S390_INT_VIRTIO:
-	case KVM_S390_INT_SERVICE:
 		irq->u.ext = inti->ext;
 		break;
 	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
 		irq->u.io = inti->io;
 		break;
-	case KVM_S390_MCHK:
-		irq->u.mchk = inti->mchk;
-		break;
 	}
 }
 
-static int get_all_floating_irqs(struct kvm *kvm, __user u8 *usrbuf, u64 len)
+void kvm_s390_clear_float_irqs(struct kvm *kvm)
+{
+	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
+	int i;
+
+	spin_lock(&fi->lock);
+	for (i = 0; i < FIRQ_LIST_COUNT; i++)
+		clear_irq_list(&fi->lists[i]);
+	for (i = 0; i < FIRQ_MAX_COUNT; i++)
+		fi->counters[i] = 0;
+	spin_unlock(&fi->lock);
+};
+
+static int get_all_floating_irqs(struct kvm *kvm, __user __u8 *usrbuf, __u64 len)
 {
 	struct kvm_s390_interrupt_info *inti;
 	struct kvm_s390_float_interrupt *fi;
 	struct kvm_s390_irq *buf;
+	struct kvm_s390_irq *irq;
 	int max_irqs;
 	int ret = 0;
 	int n = 0;
+	int i;
 
 	if (len > KVM_S390_FLIC_MAX_BUFFER || len == 0)
 		return -EINVAL;
@@ -1523,15 +1611,41 @@ static int get_all_floating_irqs(struct kvm *kvm, __user u8 *usrbuf, u64 len)
 
 	fi = &kvm->arch.float_int;
 	spin_lock(&fi->lock);
-	list_for_each_entry(inti, &fi->list, list) {
+	for (i = 0; i < FIRQ_LIST_COUNT; i++) {
+		list_for_each_entry(inti, &fi->lists[i], list) {
+			if (n == max_irqs) {
+				/* signal userspace to try again */
+				ret = -ENOMEM;
+				goto out;
+			}
+			inti_to_irq(inti, &buf[n]);
+			n++;
+		}
+	}
+	if (test_bit(IRQ_PEND_EXT_SERVICE, &fi->pending_irqs)) {
 		if (n == max_irqs) {
 			/* signal userspace to try again */
 			ret = -ENOMEM;
-			break;
+			goto out;
 		}
-		inti_to_irq(inti, &buf[n]);
+		irq = (struct kvm_s390_irq *) &buf[n];
+		irq->type = KVM_S390_INT_SERVICE;
+		irq->u.ext = fi->srv_signal;
 		n++;
 	}
+	if (test_bit(IRQ_PEND_MCHK_REP, &fi->pending_irqs)) {
+		if (n == max_irqs) {
+				/* signal userspace to try again */
+				ret = -ENOMEM;
+				goto out;
+		}
+		irq = (struct kvm_s390_irq *) &buf[n];
+		irq->type = KVM_S390_MCHK;
+		irq->u.mchk = fi->mchk;
+		n++;
+}
+
+out:
 	spin_unlock(&fi->lock);
 	if (!ret && n > 0) {
 		if (copy_to_user((void __user *) usrbuf,
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index a130885..dbc9ca3 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -31,6 +31,7 @@
 #include <asm/pgtable.h>
 #include <asm/nmi.h>
 #include <asm/switch_to.h>
+#include <asm/isc.h>
 #include <asm/sclp.h>
 #include "kvm-s390.h"
 #include "gaccess.h"
@@ -1069,7 +1070,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 		goto out_err;
 
 	spin_lock_init(&kvm->arch.float_int.lock);
-	INIT_LIST_HEAD(&kvm->arch.float_int.list);
+	for (i = 0; i < FIRQ_LIST_COUNT; i++)
+		INIT_LIST_HEAD(&kvm->arch.float_int.lists[i]);
 	init_waitqueue_head(&kvm->arch.ipte_wq);
 	mutex_init(&kvm->arch.ipte_mutex);
 
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index c5aefef..343644a 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -178,7 +178,7 @@ int __must_check kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
 				      struct kvm_s390_irq *irq);
 int __must_check kvm_s390_inject_program_int(struct kvm_vcpu *vcpu, u16 code);
 struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
-						    u64 cr6, u64 schid);
+						    u64 isc_mask, u32 schid);
 int kvm_s390_reinject_io_int(struct kvm *kvm,
 			     struct kvm_s390_interrupt_info *inti);
 int kvm_s390_mask_adapter(struct kvm *kvm, unsigned int id, bool masked);
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 5e4658d..d22d8ee 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -294,10 +294,13 @@ reinject_interrupt:
 
 static int handle_tsch(struct kvm_vcpu *vcpu)
 {
-	struct kvm_s390_interrupt_info *inti;
+	struct kvm_s390_interrupt_info *inti = NULL;
+	const u64 isc_mask = 0xffUL << 24; /* all iscs set */
 
-	inti = kvm_s390_get_io_int(vcpu->kvm, 0,
-				   vcpu->run->s.regs.gprs[1]);
+	/* a valid schid has at least one bit set */
+	if (vcpu->run->s.regs.gprs[1])
+		inti = kvm_s390_get_io_int(vcpu->kvm, isc_mask,
+					   vcpu->run->s.regs.gprs[1]);
 
 	/*
 	 * Prepare exit to userspace.
-- 
2.3.0
