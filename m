From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/1] KVM: halt_polling: provide a way to qualify wakeups during poll
Date: Tue,  3 May 2016 14:37:21 +0200
Message-ID: <1462279041-17028-2-git-send-email-borntraeger@de.ibm.com>
References: <1462279041-17028-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1462279041-17028-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Wanpeng Li <kernellwp@gmail.com>, David Matlack <dmatlack@google.com>
List-ID: <linux-s390.vger.kernel.org>

Some wakeups should not be considered a sucessful poll. For example on
s390 I/O interrupts are usually floating, which means that _ALL_ CPUs
would be considered runnable - letting all vCPUs poll all the time for
transactional like workload, even if one vCPU would be enough.
This can result in huge CPU usage for large guests.
This patch lets architectures provide a way to qualify wakeups if they
should be considered a good/bad wakeups in regard to polls.

For s390 the implementation will fence of halt polling for anything but
known good, single vCPU events. The s390 implementation for floating
interrupts does a wakeup for one vCPU, but the interrupt will be delivered
by whatever CPU checks first for a pending interrupt. We prefer the
woken up CPU by marking the poll of this CPU as "good" poll.
This code will also mark several other wakeup reasons like IPI or
expired timers as "good". This will of course also mark some events as
not sucessful. As  KVM on z runs always as a 2nd level hypervisor,
we prefer to not poll, unless we are really sure, though.

This patch successfully limits the CPU usage for cases like uperf 1byte
transactional ping pong workload or wakeup heavy workload like OLTP
while still providing a proper speedup.

This also introduced a new vcpu stat "halt_poll_no_tuning" that marks
wakeups that are considered not good for polling.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Matlack <dmatlack@google.com>
Cc: Wanpeng Li <kernellwp@gmail.com>
---
 arch/arm/include/asm/kvm_host.h     |  2 ++
 arch/arm64/include/asm/kvm_host.h   |  2 ++
 arch/mips/include/asm/kvm_host.h    |  1 +
 arch/mips/kvm/mips.c                |  1 +
 arch/powerpc/include/asm/kvm_host.h |  2 ++
 arch/powerpc/kvm/book3s.c           |  1 +
 arch/powerpc/kvm/booke.c            |  1 +
 arch/s390/include/asm/kvm_host.h    |  3 +++
 arch/s390/kvm/Kconfig               |  1 +
 arch/s390/kvm/interrupt.c           |  5 +++++
 arch/s390/kvm/kvm-s390.c            |  6 ++++++
 arch/x86/include/asm/kvm_host.h     |  2 ++
 arch/x86/kvm/x86.c                  |  1 +
 include/linux/kvm_host.h            | 15 +++++++++++++++
 include/trace/events/kvm.h          | 11 +++++++----
 virt/kvm/Kconfig                    |  3 +++
 virt/kvm/kvm_main.c                 |  8 ++++++--
 17 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 3850701..1db618c 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -187,6 +187,7 @@ struct kvm_vm_stat {
 struct kvm_vcpu_stat {
 	u32 halt_successful_poll;
 	u32 halt_attempted_poll;
+	u32 halt_poll_no_tuning;
 	u32 halt_wakeup;
 	u32 hvc_exit_stat;
 	u64 wfe_exit_stat;
@@ -282,6 +283,7 @@ static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
+static inline void kvm_arch_vcpu_block_finish(struct kvm_vcpu *vcpu) {}
 
 static inline void kvm_arm_init_debug(void) {}
 static inline void kvm_arm_setup_debug(struct kvm_vcpu *vcpu) {}
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index f5c6bd2..9d79394 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -293,6 +293,7 @@ struct kvm_vm_stat {
 struct kvm_vcpu_stat {
 	u32 halt_successful_poll;
 	u32 halt_attempted_poll;
+	u32 halt_poll_no_tuning;
 	u32 halt_wakeup;
 	u32 hvc_exit_stat;
 	u64 wfe_exit_stat;
@@ -357,6 +358,7 @@ static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
+static inline void kvm_arch_vcpu_block_finish(struct kvm_vcpu *vcpu) {}
 
 void kvm_arm_init_debug(void);
 void kvm_arm_setup_debug(struct kvm_vcpu *vcpu);
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index f6b1279..7f28ed2 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -812,5 +812,6 @@ static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
 static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
+static inline void kvm_arch_vcpu_block_finish(struct kvm_vcpu *vcpu) {}
 
 #endif /* __MIPS_KVM_HOST_H__ */
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 70ef1a4..bc50cbc 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -56,6 +56,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "flush_dcache", VCPU_STAT(flush_dcache_exits), KVM_STAT_VCPU },
 	{ "halt_successful_poll", VCPU_STAT(halt_successful_poll), KVM_STAT_VCPU },
 	{ "halt_attempted_poll", VCPU_STAT(halt_attempted_poll), KVM_STAT_VCPU },
+	{ "halt_poll_no_tuning", VCPU_STAT(halt_poll_no_tuning), KVM_STAT_VCPU },
 	{ "halt_wakeup",  VCPU_STAT(halt_wakeup),	 KVM_STAT_VCPU },
 	{NULL}
 };
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index d7b3431..e234871 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -113,6 +113,7 @@ struct kvm_vcpu_stat {
 	u32 ext_intr_exits;
 	u32 halt_successful_poll;
 	u32 halt_attempted_poll;
+	u32 halt_poll_no_tuning;
 	u32 halt_wakeup;
 	u32 dbell_exits;
 	u32 gdbell_exits;
@@ -724,5 +725,6 @@ static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
 static inline void kvm_arch_exit(void) {}
 static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
+static inline void kvm_arch_vcpu_block_finish(struct kvm_vcpu *vcpu) {}
 
 #endif /* __POWERPC_KVM_HOST_H__ */
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index b34220d2..2166c1f 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -54,6 +54,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "queue_intr",  VCPU_STAT(queue_intr) },
 	{ "halt_successful_poll", VCPU_STAT(halt_successful_poll), },
 	{ "halt_attempted_poll", VCPU_STAT(halt_attempted_poll), },
+	{ "halt_poll_no_tuning", VCPU_STAT(halt_poll_no_tuning) },
 	{ "halt_wakeup", VCPU_STAT(halt_wakeup) },
 	{ "pf_storage",  VCPU_STAT(pf_storage) },
 	{ "sp_storage",  VCPU_STAT(sp_storage) },
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 4d66f44..6d28d58 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -64,6 +64,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "ext_intr",   VCPU_STAT(ext_intr_exits) },
 	{ "halt_successful_poll", VCPU_STAT(halt_successful_poll) },
 	{ "halt_attempted_poll", VCPU_STAT(halt_attempted_poll) },
+	{ "halt_poll_no_tuning", VCPU_STAT(halt_poll_no_tuning) },
 	{ "halt_wakeup", VCPU_STAT(halt_wakeup) },
 	{ "doorbell", VCPU_STAT(dbell_exits) },
 	{ "guest doorbell", VCPU_STAT(gdbell_exits) },
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 6da41fa..f901a24 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -247,6 +247,7 @@ struct kvm_vcpu_stat {
 	u32 exit_instruction;
 	u32 halt_successful_poll;
 	u32 halt_attempted_poll;
+	u32 halt_poll_no_tuning;
 	u32 halt_wakeup;
 	u32 instruction_lctl;
 	u32 instruction_lctlg;
@@ -700,4 +701,6 @@ static inline void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
 
+void kvm_arch_vcpu_block_finish(struct kvm_vcpu *vcpu);
+
 #endif
diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
index 5ea5af3..ccfe6f6 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/Kconfig
@@ -28,6 +28,7 @@ config KVM
 	select HAVE_KVM_IRQCHIP
 	select HAVE_KVM_IRQFD
 	select HAVE_KVM_IRQ_ROUTING
+	select HAVE_KVM_INVALID_POLLS
 	select SRCU
 	select KVM_VFIO
 	---help---
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index e550404..5a80af7 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -977,6 +977,11 @@ no_timer:
 
 void kvm_s390_vcpu_wakeup(struct kvm_vcpu *vcpu)
 {
+	/*
+	 * We cannot move this into the if, as the CPU might be already
+	 * in kvm_vcpu_block without having the waitqueue set (polling)
+	 */
+	vcpu->valid_wakeup = true;
 	if (swait_active(&vcpu->wq)) {
 		/*
 		 * The vcpu gave up the cpu voluntarily, mark it as a good
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 668c087..ce35bf0 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -65,6 +65,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "exit_instr_and_program_int", VCPU_STAT(exit_instr_and_program) },
 	{ "halt_successful_poll", VCPU_STAT(halt_successful_poll) },
 	{ "halt_attempted_poll", VCPU_STAT(halt_attempted_poll) },
+	{ "halt_poll_no_tuning", VCPU_STAT(halt_poll_no_tuning) },
 	{ "halt_wakeup", VCPU_STAT(halt_wakeup) },
 	{ "instruction_lctlg", VCPU_STAT(instruction_lctlg) },
 	{ "instruction_lctl", VCPU_STAT(instruction_lctl) },
@@ -2971,6 +2972,11 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 	return;
 }
 
+void kvm_arch_vcpu_block_finish(struct kvm_vcpu *vcpu)
+{
+	vcpu->valid_wakeup = false;
+}
+
 static int __init kvm_s390_init(void)
 {
 	if (!sclp.has_sief2) {
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b7e3944..c8cfa2d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -804,6 +804,7 @@ struct kvm_vcpu_stat {
 	u32 halt_exits;
 	u32 halt_successful_poll;
 	u32 halt_attempted_poll;
+	u32 halt_poll_no_tuning;
 	u32 halt_wakeup;
 	u32 request_irq_exits;
 	u32 irq_exits;
@@ -1343,5 +1344,6 @@ void kvm_set_msi_irq(struct kvm_kernel_irq_routing_entry *e,
 
 static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
+static inline void kvm_arch_vcpu_block_finish(struct kvm_vcpu *vcpu) {}
 
 #endif /* _ASM_X86_KVM_HOST_H */
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9b7798c..809c40a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -161,6 +161,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "halt_exits", VCPU_STAT(halt_exits) },
 	{ "halt_successful_poll", VCPU_STAT(halt_successful_poll) },
 	{ "halt_attempted_poll", VCPU_STAT(halt_attempted_poll) },
+	{ "halt_poll_no_tuning", VCPU_STAT(halt_poll_no_tuning) },
 	{ "halt_wakeup", VCPU_STAT(halt_wakeup) },
 	{ "hypercalls", VCPU_STAT(hypercalls) },
 	{ "request_irq", VCPU_STAT(request_irq_exits) },
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5276fe0..0fac5d8 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -225,6 +225,7 @@ struct kvm_vcpu {
 	sigset_t sigset;
 	struct kvm_vcpu_stat stat;
 	unsigned int halt_poll_ns;
+	bool valid_wakeup;
 
 #ifdef CONFIG_HAS_IOMEM
 	int mmio_needed;
@@ -1179,4 +1180,18 @@ int kvm_arch_update_irqfd_routing(struct kvm *kvm, unsigned int host_irq,
 				  uint32_t guest_irq, bool set);
 #endif /* CONFIG_HAVE_KVM_IRQ_BYPASS */
 
+#ifdef CONFIG_HAVE_KVM_INVALID_POLLS
+/* If we wakeup during the poll time, was it a sucessful poll? */
+static inline bool vcpu_valid_wakeup(struct kvm_vcpu *vcpu)
+{
+	return vcpu->valid_wakeup;
+}
+
+#else
+static inline bool vcpu_valid_wakeup(struct kvm_vcpu *vcpu)
+{
+	return true;
+}
+#endif /* CONFIG_HAVE_KVM_INVALID_POLLS */
+
 #endif
diff --git a/include/trace/events/kvm.h b/include/trace/events/kvm.h
index aa69253..92e6fd6 100644
--- a/include/trace/events/kvm.h
+++ b/include/trace/events/kvm.h
@@ -38,22 +38,25 @@ TRACE_EVENT(kvm_userspace_exit,
 );
 
 TRACE_EVENT(kvm_vcpu_wakeup,
-	    TP_PROTO(__u64 ns, bool waited),
-	    TP_ARGS(ns, waited),
+	    TP_PROTO(__u64 ns, bool waited, bool tuned),
+	    TP_ARGS(ns, waited, tuned),
 
 	TP_STRUCT__entry(
 		__field(	__u64,		ns		)
 		__field(	bool,		waited		)
+		__field(	bool,		tuned		)
 	),
 
 	TP_fast_assign(
 		__entry->ns		= ns;
 		__entry->waited		= waited;
+		__entry->tuned		= tuned;
 	),
 
-	TP_printk("%s time %lld ns",
+	TP_printk("%s time %lld ns, polling %s",
 		  __entry->waited ? "wait" : "poll",
-		  __entry->ns)
+		  __entry->ns,
+		  __entry->tuned ? "changed" : "unchanged")
 );
 
 #if defined(CONFIG_HAVE_KVM_IRQFD)
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 7a79b68..4451842 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -41,6 +41,9 @@ config KVM_VFIO
 config HAVE_KVM_ARCH_TLB_FLUSH_ALL
        bool
 
+config HAVE_KVM_INVALID_POLLS
+       bool
+
 config KVM_GENERIC_DIRTYLOG_READ_PROTECT
        bool
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 4fd482f..096c655 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2028,6 +2028,8 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
 			 */
 			if (kvm_vcpu_check_block(vcpu) < 0) {
 				++vcpu->stat.halt_successful_poll;
+				if (!vcpu_valid_wakeup(vcpu))
+					++vcpu->stat.halt_poll_no_tuning;
 				goto out;
 			}
 			cur = ktime_get();
@@ -2057,7 +2059,8 @@ out:
 		if (block_ns <= vcpu->halt_poll_ns)
 			;
 		/* we had a long block, shrink polling */
-		else if (vcpu->halt_poll_ns && block_ns > halt_poll_ns)
+		else if (!vcpu_valid_wakeup(vcpu) ||
+			(vcpu->halt_poll_ns && block_ns > halt_poll_ns))
 			shrink_halt_poll_ns(vcpu);
 		/* we had a short halt and our poll time is too small */
 		else if (vcpu->halt_poll_ns < halt_poll_ns &&
@@ -2066,7 +2069,8 @@ out:
 	} else
 		vcpu->halt_poll_ns = 0;
 
-	trace_kvm_vcpu_wakeup(block_ns, waited);
+	trace_kvm_vcpu_wakeup(block_ns, waited, vcpu_valid_wakeup(vcpu));
+	kvm_arch_vcpu_block_finish(vcpu);
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_block);
 
-- 
2.3.0
