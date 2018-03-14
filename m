From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 14 Mar 2018 19:28:58 +0000
Subject: [GIT PULL 10/10] KVM: s390: provide counters for all interrupt injects/delivery
Message-Id: <20180314192858.172855-11-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

For testing the exitless interrupt support it turned out useful to
have separate counters for inject and delivery of I/O interrupt.
While at it do the same for all interrupt types. For timer
related interrupts (clock comparator and cpu timer) we even had
no delivery counters. Fix this as well. On this way some counters
are being renamed to have a similar name.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 arch/s390/include/asm/kvm_host.h | 25 +++++++++++++++++++++----
 arch/s390/kvm/interrupt.c        | 25 +++++++++++++++++++++----
 arch/s390/kvm/kvm-s390.c         | 24 +++++++++++++++++++++---
 3 files changed, 63 insertions(+), 11 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 77a49de9c511..81cdb6b55118 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -311,17 +311,29 @@ struct kvm_vcpu_stat {
 	u64 exit_program_interruption;
 	u64 exit_instr_and_program;
 	u64 exit_operation_exception;
+	u64 deliver_ckc;
+	u64 deliver_cputm;
 	u64 deliver_external_call;
 	u64 deliver_emergency_signal;
 	u64 deliver_service_signal;
-	u64 deliver_virtio_interrupt;
+	u64 deliver_virtio;
 	u64 deliver_stop_signal;
 	u64 deliver_prefix_signal;
 	u64 deliver_restart_signal;
-	u64 deliver_program_int;
-	u64 deliver_io_int;
+	u64 deliver_program;
+	u64 deliver_io;
 	u64 deliver_machine_check;
 	u64 exit_wait_state;
+	u64 inject_ckc;
+	u64 inject_cputm;
+	u64 inject_external_call;
+	u64 inject_emergency_signal;
+	u64 inject_mchk;
+	u64 inject_pfault_init;
+	u64 inject_program;
+	u64 inject_restart;
+	u64 inject_set_prefix;
+	u64 inject_stop_signal;
 	u64 instruction_epsw;
 	u64 instruction_gs;
 	u64 instruction_io_other;
@@ -646,7 +658,12 @@ struct kvm_vcpu_arch {
 };
 
 struct kvm_vm_stat {
-	ulong remote_tlb_flush;
+	u64 inject_io;
+	u64 inject_float_mchk;
+	u64 inject_pfault_done;
+	u64 inject_service_signal;
+	u64 inject_virtio;
+	u64 remote_tlb_flush;
 };
 
 struct kvm_arch_memory_slot {
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index bde04a6191ca..37d06e022238 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -391,6 +391,7 @@ static int __must_check __deliver_cpu_timer(struct kvm_vcpu *vcpu)
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 	int rc;
 
+	vcpu->stat.deliver_cputm++;
 	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, KVM_S390_INT_CPU_TIMER,
 					 0, 0);
 
@@ -410,6 +411,7 @@ static int __must_check __deliver_ckc(struct kvm_vcpu *vcpu)
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 	int rc;
 
+	vcpu->stat.deliver_ckc++;
 	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, KVM_S390_INT_CLOCK_COMP,
 					 0, 0);
 
@@ -711,7 +713,7 @@ static int __must_check __deliver_prog(struct kvm_vcpu *vcpu)
 	ilen = pgm_info.flags & KVM_S390_PGM_FLAGS_ILC_MASK;
 	VCPU_EVENT(vcpu, 3, "deliver: program irq code 0x%x, ilen:%d",
 		   pgm_info.code, ilen);
-	vcpu->stat.deliver_program_int++;
+	vcpu->stat.deliver_program++;
 	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, KVM_S390_PROGRAM_INT,
 					 pgm_info.code, 0);
 
@@ -900,7 +902,7 @@ static int __must_check __deliver_virtio(struct kvm_vcpu *vcpu)
 		VCPU_EVENT(vcpu, 4,
 			   "deliver: virtio parm: 0x%x,parm64: 0x%llx",
 			   inti->ext.ext_params, inti->ext.ext_params2);
-		vcpu->stat.deliver_virtio_interrupt++;
+		vcpu->stat.deliver_virtio++;
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id,
 				inti->type,
 				inti->ext.ext_params,
@@ -976,7 +978,7 @@ static int __must_check __deliver_io(struct kvm_vcpu *vcpu,
 			inti->io.subchannel_id >> 1 & 0x3,
 			inti->io.subchannel_nr);
 
-		vcpu->stat.deliver_io_int++;
+		vcpu->stat.deliver_io++;
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id,
 				inti->type,
 				((__u32)inti->io.subchannel_id << 16) |
@@ -1005,7 +1007,7 @@ static int __must_check __deliver_io(struct kvm_vcpu *vcpu,
 		VCPU_EVENT(vcpu, 4, "%s isc %u", "deliver: I/O (AI/gisa)", isc);
 		memset(&io, 0, sizeof(io));
 		io.io_int_word = isc_to_int_word(isc);
-		vcpu->stat.deliver_io_int++;
+		vcpu->stat.deliver_io++;
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id,
 			KVM_S390_INT_IO(1, 0, 0, 0),
 			((__u32)io.subchannel_id << 16) |
@@ -1269,6 +1271,7 @@ static int __inject_prog(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 
+	vcpu->stat.inject_program++;
 	VCPU_EVENT(vcpu, 3, "inject: program irq code 0x%x", irq->u.pgm.code);
 	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_PROGRAM_INT,
 				   irq->u.pgm.code, 0);
@@ -1310,6 +1313,7 @@ static int __inject_pfault_init(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 
+	vcpu->stat.inject_pfault_init++;
 	VCPU_EVENT(vcpu, 4, "inject: pfault init parameter block at 0x%llx",
 		   irq->u.ext.ext_params2);
 	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_INT_PFAULT_INIT,
@@ -1328,6 +1332,7 @@ static int __inject_extcall(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 	struct kvm_s390_extcall_info *extcall = &li->irq.extcall;
 	uint16_t src_id = irq->u.extcall.code;
 
+	vcpu->stat.inject_external_call++;
 	VCPU_EVENT(vcpu, 4, "inject: external call source-cpu:%u",
 		   src_id);
 	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_INT_EXTERNAL_CALL,
@@ -1352,6 +1357,7 @@ static int __inject_set_prefix(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 	struct kvm_s390_prefix_info *prefix = &li->irq.prefix;
 
+	vcpu->stat.inject_set_prefix++;
 	VCPU_EVENT(vcpu, 3, "inject: set prefix to %x",
 		   irq->u.prefix.address);
 	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_SIGP_SET_PREFIX,
@@ -1372,6 +1378,7 @@ static int __inject_sigp_stop(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 	struct kvm_s390_stop_info *stop = &li->irq.stop;
 	int rc = 0;
 
+	vcpu->stat.inject_stop_signal++;
 	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_SIGP_STOP, 0, 0);
 
 	if (irq->u.stop.flags & ~KVM_S390_STOP_SUPP_FLAGS)
@@ -1396,6 +1403,7 @@ static int __inject_sigp_restart(struct kvm_vcpu *vcpu,
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 
+	vcpu->stat.inject_restart++;
 	VCPU_EVENT(vcpu, 3, "%s", "inject: restart int");
 	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_RESTART, 0, 0);
 
@@ -1408,6 +1416,7 @@ static int __inject_sigp_emergency(struct kvm_vcpu *vcpu,
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 
+	vcpu->stat.inject_emergency_signal++;
 	VCPU_EVENT(vcpu, 4, "inject: emergency from cpu %u",
 		   irq->u.emerg.code);
 	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_INT_EMERGENCY,
@@ -1428,6 +1437,7 @@ static int __inject_mchk(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 	struct kvm_s390_mchk_info *mchk = &li->irq.mchk;
 
+	vcpu->stat.inject_mchk++;
 	VCPU_EVENT(vcpu, 3, "inject: machine check mcic 0x%llx",
 		   irq->u.mchk.mcic);
 	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_MCHK, 0,
@@ -1458,6 +1468,7 @@ static int __inject_ckc(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 
+	vcpu->stat.inject_ckc++;
 	VCPU_EVENT(vcpu, 3, "%s", "inject: clock comparator external");
 	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_INT_CLOCK_COMP,
 				   0, 0);
@@ -1471,6 +1482,7 @@ static int __inject_cpu_timer(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 
+	vcpu->stat.inject_cputm++;
 	VCPU_EVENT(vcpu, 3, "%s", "inject: cpu timer external");
 	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_INT_CPU_TIMER,
 				   0, 0);
@@ -1597,6 +1609,7 @@ static int __inject_service(struct kvm *kvm,
 {
 	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
 
+	kvm->stat.inject_service_signal++;
 	spin_lock(&fi->lock);
 	fi->srv_signal.ext_params |= inti->ext.ext_params & SCCB_EVENT_PENDING;
 	/*
@@ -1622,6 +1635,7 @@ static int __inject_virtio(struct kvm *kvm,
 {
 	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
 
+	kvm->stat.inject_virtio++;
 	spin_lock(&fi->lock);
 	if (fi->counters[FIRQ_CNTR_VIRTIO] >= KVM_S390_MAX_VIRTIO_IRQS) {
 		spin_unlock(&fi->lock);
@@ -1639,6 +1653,7 @@ static int __inject_pfault_done(struct kvm *kvm,
 {
 	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
 
+	kvm->stat.inject_pfault_done++;
 	spin_lock(&fi->lock);
 	if (fi->counters[FIRQ_CNTR_PFAULT] >=
 		(ASYNC_PF_PER_VCPU * KVM_MAX_VCPUS)) {
@@ -1658,6 +1673,7 @@ static int __inject_float_mchk(struct kvm *kvm,
 {
 	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
 
+	kvm->stat.inject_float_mchk++;
 	spin_lock(&fi->lock);
 	fi->mchk.cr14 |= inti->mchk.cr14 & (1UL << CR_PENDING_SUBCLASS);
 	fi->mchk.mcic |= inti->mchk.mcic;
@@ -1673,6 +1689,7 @@ static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 	struct list_head *list;
 	int isc;
 
+	kvm->stat.inject_io++;
 	isc = int_word_to_isc(inti->io.io_int_word);
 
 	if (kvm->arch.gisa && inti->type & KVM_S390_INT_IO_AI_MASK) {
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 41615c900348..64c986243018 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -57,6 +57,7 @@
 			   (KVM_MAX_VCPUS + LOCAL_IRQS))
 
 #define VCPU_STAT(x) offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU
+#define VM_STAT(x) offsetof(struct kvm, stat.x), KVM_STAT_VM
 
 struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "userspace_handled", VCPU_STAT(exit_userspace) },
@@ -79,17 +80,34 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "instruction_lctl", VCPU_STAT(instruction_lctl) },
 	{ "instruction_stctl", VCPU_STAT(instruction_stctl) },
 	{ "instruction_stctg", VCPU_STAT(instruction_stctg) },
+	{ "deliver_ckc", VCPU_STAT(deliver_ckc) },
+	{ "deliver_cputm", VCPU_STAT(deliver_cputm) },
 	{ "deliver_emergency_signal", VCPU_STAT(deliver_emergency_signal) },
 	{ "deliver_external_call", VCPU_STAT(deliver_external_call) },
 	{ "deliver_service_signal", VCPU_STAT(deliver_service_signal) },
-	{ "deliver_virtio_interrupt", VCPU_STAT(deliver_virtio_interrupt) },
+	{ "deliver_virtio", VCPU_STAT(deliver_virtio) },
 	{ "deliver_stop_signal", VCPU_STAT(deliver_stop_signal) },
 	{ "deliver_prefix_signal", VCPU_STAT(deliver_prefix_signal) },
 	{ "deliver_restart_signal", VCPU_STAT(deliver_restart_signal) },
-	{ "deliver_program_interruption", VCPU_STAT(deliver_program_int) },
-	{ "deliver_io_interrupt", VCPU_STAT(deliver_io_int) },
+	{ "deliver_program", VCPU_STAT(deliver_program) },
+	{ "deliver_io", VCPU_STAT(deliver_io) },
 	{ "deliver_machine_check", VCPU_STAT(deliver_machine_check) },
 	{ "exit_wait_state", VCPU_STAT(exit_wait_state) },
+	{ "inject_ckc", VCPU_STAT(inject_ckc) },
+	{ "inject_cputm", VCPU_STAT(inject_cputm) },
+	{ "inject_external_call", VCPU_STAT(inject_external_call) },
+	{ "inject_float_mchk", VM_STAT(inject_float_mchk) },
+	{ "inject_emergency_signal", VCPU_STAT(inject_emergency_signal) },
+	{ "inject_io", VM_STAT(inject_io) },
+	{ "inject_mchk", VCPU_STAT(inject_mchk) },
+	{ "inject_pfault_done", VM_STAT(inject_pfault_done) },
+	{ "inject_program", VCPU_STAT(inject_program) },
+	{ "inject_restart", VCPU_STAT(inject_restart) },
+	{ "inject_service_signal", VM_STAT(inject_service_signal) },
+	{ "inject_set_prefix", VCPU_STAT(inject_set_prefix) },
+	{ "inject_stop_signal", VCPU_STAT(inject_stop_signal) },
+	{ "inject_pfault_init", VCPU_STAT(inject_pfault_init) },
+	{ "inject_virtio", VM_STAT(inject_virtio) },
 	{ "instruction_epsw", VCPU_STAT(instruction_epsw) },
 	{ "instruction_gs", VCPU_STAT(instruction_gs) },
 	{ "instruction_io_other", VCPU_STAT(instruction_io_other) },
-- 
2.14.3
