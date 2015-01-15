From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 09/21] KVM: s390: handle stop irqs without action_bits
Date: Thu, 15 Jan 2015 14:43:22 +0100
Message-ID: <1421329414-76826-10-git-send-email-borntraeger@de.ibm.com>
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

This patch removes the famous action_bits and moves the handling of
SIGP STOP AND STORE STATUS directly into the SIGP STOP interrupt.

The new local interrupt infrastructure is used to track pending stop
requests.

STOP irqs are the only irqs that don't get actively delivered. They
remain pending until the stop function is executed (=stop intercept).

If another STOP irq is already pending, -EBUSY will now be returned
(needed for the SIGP handling code).

Migration of pending SIGP STOP (AND STORE STATUS) orders should now
be supported out of the box.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  5 ---
 arch/s390/kvm/intercept.c        | 15 ++++++---
 arch/s390/kvm/interrupt.c        | 71 +++++++++++++++++++++++++---------------
 arch/s390/kvm/kvm-s390.c         |  9 ++---
 arch/s390/kvm/kvm-s390.h         |  2 ++
 arch/s390/kvm/sigp.c             | 64 ++++++++++++------------------------
 arch/s390/kvm/trace-s390.h       | 14 ++++----
 7 files changed, 88 insertions(+), 92 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 5eafe84..02e4248 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -383,10 +383,6 @@ struct kvm_s390_interrupt_info {
 	};
 };
 
-/* for local_interrupt.action_flags */
-#define ACTION_STORE_ON_STOP		(1<<0)
-#define ACTION_STOP_ON_STOP		(1<<1)
-
 struct kvm_s390_irq_payload {
 	struct kvm_s390_io_info io;
 	struct kvm_s390_ext_info ext;
@@ -403,7 +399,6 @@ struct kvm_s390_local_interrupt {
 	struct kvm_s390_float_interrupt *float_int;
 	wait_queue_head_t *wq;
 	atomic_t *cpuflags;
-	unsigned int action_bits;
 	DECLARE_BITMAP(sigp_emerg_pending, KVM_MAX_VCPUS);
 	struct kvm_s390_irq_payload irq;
 	unsigned long pending_irqs;
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 81c77ab..08e01ac 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -68,18 +68,23 @@ static int handle_noop(struct kvm_vcpu *vcpu)
 
 static int handle_stop(struct kvm_vcpu *vcpu)
 {
+	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 	int rc = 0;
-	unsigned int action_bits;
+	uint8_t flags, stop_pending;
 
 	vcpu->stat.exit_stop_request++;
-	trace_kvm_s390_stop_request(vcpu->arch.local_int.action_bits);
 
-	action_bits = vcpu->arch.local_int.action_bits;
+	/* avoid races with the injection/SIGP STOP code */
+	spin_lock(&li->lock);
+	flags = li->irq.stop.flags;
+	stop_pending = kvm_s390_is_stop_irq_pending(vcpu);
+	spin_unlock(&li->lock);
 
-	if (!(action_bits & ACTION_STOP_ON_STOP))
+	trace_kvm_s390_stop_request(stop_pending, flags);
+	if (!stop_pending)
 		return 0;
 
-	if (action_bits & ACTION_STORE_ON_STOP) {
+	if (flags & KVM_S390_STOP_FLAG_STORE_STATUS) {
 		rc = kvm_s390_vcpu_store_status(vcpu,
 						KVM_S390_STORE_STATUS_NOADDR);
 		if (rc)
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 73bafc3..1872188 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -159,6 +159,12 @@ static unsigned long deliverable_local_irqs(struct kvm_vcpu *vcpu)
 	if (psw_mchk_disabled(vcpu))
 		active_mask &= ~IRQ_PEND_MCHK_MASK;
 
+	/*
+	 * STOP irqs will never be actively delivered. They are triggered via
+	 * intercept requests and cleared when the stop intercept is performed.
+	 */
+	__clear_bit(IRQ_PEND_SIGP_STOP, &active_mask);
+
 	return active_mask;
 }
 
@@ -186,9 +192,6 @@ static void __reset_intercept_indicators(struct kvm_vcpu *vcpu)
 					       LCTL_CR10 | LCTL_CR11);
 		vcpu->arch.sie_block->ictl |= (ICTL_STCTL | ICTL_PINT);
 	}
-
-	if (vcpu->arch.local_int.action_bits & ACTION_STOP_ON_STOP)
-		atomic_set_mask(CPUSTAT_STOP_INT, &vcpu->arch.sie_block->cpuflags);
 }
 
 static void __set_cpuflag(struct kvm_vcpu *vcpu, u32 flag)
@@ -216,11 +219,18 @@ static void set_intercept_indicators_mchk(struct kvm_vcpu *vcpu)
 		vcpu->arch.sie_block->lctl |= LCTL_CR14;
 }
 
+static void set_intercept_indicators_stop(struct kvm_vcpu *vcpu)
+{
+	if (kvm_s390_is_stop_irq_pending(vcpu))
+		__set_cpuflag(vcpu, CPUSTAT_STOP_INT);
+}
+
 /* Set interception request for non-deliverable local interrupts */
 static void set_intercept_indicators_local(struct kvm_vcpu *vcpu)
 {
 	set_intercept_indicators_ext(vcpu);
 	set_intercept_indicators_mchk(vcpu);
+	set_intercept_indicators_stop(vcpu);
 }
 
 static void __set_intercept_indicator(struct kvm_vcpu *vcpu,
@@ -392,25 +402,6 @@ static int __must_check __deliver_restart(struct kvm_vcpu *vcpu)
 	return rc ? -EFAULT : 0;
 }
 
-static int __must_check __deliver_stop(struct kvm_vcpu *vcpu)
-{
-	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
-	struct kvm_s390_stop_info *stop = &li->irq.stop;
-
-	spin_lock(&li->lock);
-	stop->flags = 0;
-	clear_bit(IRQ_PEND_SIGP_STOP, &li->pending_irqs);
-	spin_unlock(&li->lock);
-
-	VCPU_EVENT(vcpu, 4, "%s", "interrupt: cpu stop");
-	vcpu->stat.deliver_stop_signal++;
-	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, KVM_S390_SIGP_STOP,
-					 0, 0);
-
-	__set_cpuflag(vcpu, CPUSTAT_STOP_INT);
-	return 0;
-}
-
 static int __must_check __deliver_set_prefix(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
@@ -712,7 +703,6 @@ static const deliver_irq_t deliver_irq_funcs[] = {
 	[IRQ_PEND_EXT_CLOCK_COMP] = __deliver_ckc,
 	[IRQ_PEND_EXT_CPU_TIMER]  = __deliver_cpu_timer,
 	[IRQ_PEND_RESTART]        = __deliver_restart,
-	[IRQ_PEND_SIGP_STOP]      = __deliver_stop,
 	[IRQ_PEND_SET_PREFIX]     = __deliver_set_prefix,
 	[IRQ_PEND_PFAULT_INIT]    = __deliver_pfault_init,
 };
@@ -783,6 +773,9 @@ int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu)
 	if (!rc && kvm_s390_si_ext_call_pending(vcpu))
 		rc = 1;
 
+	if (!rc && kvm_s390_is_stop_irq_pending(vcpu))
+		rc = 1;
+
 	return rc;
 }
 
@@ -1038,20 +1031,29 @@ static int __inject_set_prefix(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 	return 0;
 }
 
-#define KVM_S390_STOP_SUPP_FLAGS 0
+#define KVM_S390_STOP_SUPP_FLAGS (KVM_S390_STOP_FLAG_STORE_STATUS)
 static int __inject_sigp_stop(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 	struct kvm_s390_stop_info *stop = &li->irq.stop;
+	int rc = 0;
 
 	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_SIGP_STOP, 0, 0, 2);
 
 	if (irq->u.stop.flags & ~KVM_S390_STOP_SUPP_FLAGS)
 		return -EINVAL;
 
-	li->action_bits |= ACTION_STOP_ON_STOP;
+	if (is_vcpu_stopped(vcpu)) {
+		if (irq->u.stop.flags & KVM_S390_STOP_FLAG_STORE_STATUS)
+			rc = kvm_s390_store_status_unloaded(vcpu,
+						KVM_S390_STORE_STATUS_NOADDR);
+		return rc;
+	}
+
+	if (test_and_set_bit(IRQ_PEND_SIGP_STOP, &li->pending_irqs))
+		return -EBUSY;
 	stop->flags = irq->u.stop.flags;
-	set_bit(IRQ_PEND_SIGP_STOP, &li->pending_irqs);
+	__set_cpuflag(vcpu, CPUSTAT_STOP_INT);
 	return 0;
 }
 
@@ -1339,6 +1341,23 @@ int s390int_to_s390irq(struct kvm_s390_interrupt *s390int,
 	return 0;
 }
 
+int kvm_s390_is_stop_irq_pending(struct kvm_vcpu *vcpu)
+{
+	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
+
+	return test_bit(IRQ_PEND_SIGP_STOP, &li->pending_irqs);
+}
+
+void kvm_s390_clear_stop_irq(struct kvm_vcpu *vcpu)
+{
+	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
+
+	spin_lock(&li->lock);
+	li->irq.stop.flags = 0;
+	clear_bit(IRQ_PEND_SIGP_STOP, &li->pending_irqs);
+	spin_unlock(&li->lock);
+}
+
 int kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 37ef06c..b987b56 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1624,15 +1624,10 @@ void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
 	spin_lock(&vcpu->kvm->arch.start_stop_lock);
 	online_vcpus = atomic_read(&vcpu->kvm->online_vcpus);
 
-	/* Need to lock access to action_bits to avoid a SIGP race condition */
-	spin_lock(&vcpu->arch.local_int.lock);
-	atomic_set_mask(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
-
 	/* SIGP STOP and SIGP STOP AND STORE STATUS has been fully processed */
-	vcpu->arch.local_int.action_bits &=
-				 ~(ACTION_STOP_ON_STOP | ACTION_STORE_ON_STOP);
-	spin_unlock(&vcpu->arch.local_int.lock);
+	kvm_s390_clear_stop_irq(vcpu);
 
+	atomic_set_mask(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
 	__disable_ibs_on_vcpu(vcpu);
 
 	for (i = 0; i < online_vcpus; i++) {
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index a8f3d9b..d72ff62 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -233,6 +233,8 @@ int psw_extint_disabled(struct kvm_vcpu *vcpu);
 void kvm_s390_destroy_adapters(struct kvm *kvm);
 int kvm_s390_si_ext_call_pending(struct kvm_vcpu *vcpu);
 extern struct kvm_device_ops kvm_flic_ops;
+int kvm_s390_is_stop_irq_pending(struct kvm_vcpu *vcpu);
+void kvm_s390_clear_stop_irq(struct kvm_vcpu *vcpu);
 
 /* implemented in guestdbg.c */
 void kvm_s390_backup_guest_per_regs(struct kvm_vcpu *vcpu);
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 6651f9f..a251854 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -112,38 +112,19 @@ static int __sigp_external_call(struct kvm_vcpu *vcpu,
 	return rc ? rc : SIGP_CC_ORDER_CODE_ACCEPTED;
 }
 
-static int __inject_sigp_stop(struct kvm_vcpu *dst_vcpu, int action)
-{
-	struct kvm_s390_local_interrupt *li = &dst_vcpu->arch.local_int;
-	int rc = SIGP_CC_ORDER_CODE_ACCEPTED;
-
-	spin_lock(&li->lock);
-	if (li->action_bits & ACTION_STOP_ON_STOP) {
-		/* another SIGP STOP is pending */
-		rc = SIGP_CC_BUSY;
-		goto out;
-	}
-	if ((atomic_read(li->cpuflags) & CPUSTAT_STOPPED)) {
-		if ((action & ACTION_STORE_ON_STOP) != 0)
-			rc = -ESHUTDOWN;
-		goto out;
-	}
-	set_bit(IRQ_PEND_SIGP_STOP, &li->pending_irqs);
-	li->action_bits |= action;
-	atomic_set_mask(CPUSTAT_STOP_INT, li->cpuflags);
-	kvm_s390_vcpu_wakeup(dst_vcpu);
-out:
-	spin_unlock(&li->lock);
-
-	return rc;
-}
-
 static int __sigp_stop(struct kvm_vcpu *vcpu, struct kvm_vcpu *dst_vcpu)
 {
+	struct kvm_s390_irq irq = {
+		.type = KVM_S390_SIGP_STOP,
+	};
 	int rc;
 
-	rc = __inject_sigp_stop(dst_vcpu, ACTION_STOP_ON_STOP);
-	VCPU_EVENT(vcpu, 4, "sent sigp stop to cpu %x", dst_vcpu->vcpu_id);
+	rc = kvm_s390_inject_vcpu(dst_vcpu, &irq);
+	if (rc == -EBUSY)
+		rc = SIGP_CC_BUSY;
+	else if (rc == 0)
+		VCPU_EVENT(vcpu, 4, "sent sigp stop to cpu %x",
+			   dst_vcpu->vcpu_id);
 
 	return rc;
 }
@@ -151,20 +132,18 @@ static int __sigp_stop(struct kvm_vcpu *vcpu, struct kvm_vcpu *dst_vcpu)
 static int __sigp_stop_and_store_status(struct kvm_vcpu *vcpu,
 					struct kvm_vcpu *dst_vcpu, u64 *reg)
 {
+	struct kvm_s390_irq irq = {
+		.type = KVM_S390_SIGP_STOP,
+		.u.stop.flags = KVM_S390_STOP_FLAG_STORE_STATUS,
+	};
 	int rc;
 
-	rc = __inject_sigp_stop(dst_vcpu, ACTION_STOP_ON_STOP |
-					      ACTION_STORE_ON_STOP);
-	VCPU_EVENT(vcpu, 4, "sent sigp stop and store status to cpu %x",
-		   dst_vcpu->vcpu_id);
-
-	if (rc == -ESHUTDOWN) {
-		/* If the CPU has already been stopped, we still have
-		 * to save the status when doing stop-and-store. This
-		 * has to be done after unlocking all spinlocks. */
-		rc = kvm_s390_store_status_unloaded(dst_vcpu,
-						KVM_S390_STORE_STATUS_NOADDR);
-	}
+	rc = kvm_s390_inject_vcpu(dst_vcpu, &irq);
+	if (rc == -EBUSY)
+		rc = SIGP_CC_BUSY;
+	else if (rc == 0)
+		VCPU_EVENT(vcpu, 4, "sent sigp stop and store status to cpu %x",
+			   dst_vcpu->vcpu_id);
 
 	return rc;
 }
@@ -242,9 +221,7 @@ static int __sigp_store_status_at_addr(struct kvm_vcpu *vcpu,
 	int flags;
 	int rc;
 
-	spin_lock(&dst_vcpu->arch.local_int.lock);
 	flags = atomic_read(dst_vcpu->arch.local_int.cpuflags);
-	spin_unlock(&dst_vcpu->arch.local_int.lock);
 	if (!(flags & CPUSTAT_STOPPED)) {
 		*reg &= 0xffffffff00000000UL;
 		*reg |= SIGP_STATUS_INCORRECT_STATE;
@@ -291,8 +268,9 @@ static int __prepare_sigp_re_start(struct kvm_vcpu *vcpu,
 	/* handle (RE)START in user space */
 	int rc = -EOPNOTSUPP;
 
+	/* make sure we don't race with STOP irq injection */
 	spin_lock(&li->lock);
-	if (li->action_bits & ACTION_STOP_ON_STOP)
+	if (kvm_s390_is_stop_irq_pending(dst_vcpu))
 		rc = SIGP_CC_BUSY;
 	spin_unlock(&li->lock);
 
diff --git a/arch/s390/kvm/trace-s390.h b/arch/s390/kvm/trace-s390.h
index 647e9d6..653a7ec 100644
--- a/arch/s390/kvm/trace-s390.h
+++ b/arch/s390/kvm/trace-s390.h
@@ -209,19 +209,21 @@ TRACE_EVENT(kvm_s390_request_resets,
  * Trace point for a vcpu's stop requests.
  */
 TRACE_EVENT(kvm_s390_stop_request,
-	    TP_PROTO(unsigned int action_bits),
-	    TP_ARGS(action_bits),
+	    TP_PROTO(unsigned char stop_irq, unsigned char flags),
+	    TP_ARGS(stop_irq, flags),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int, action_bits)
+		    __field(unsigned char, stop_irq)
+		    __field(unsigned char, flags)
 		    ),
 
 	    TP_fast_assign(
-		    __entry->action_bits = action_bits;
+		    __entry->stop_irq = stop_irq;
+		    __entry->flags = flags;
 		    ),
 
-	    TP_printk("stop request, action_bits = %08x",
-		      __entry->action_bits)
+	    TP_printk("stop request, stop irq = %u, flags = %08x",
+		      __entry->stop_irq, __entry->flags)
 	);
 
 
-- 
1.9.3
