From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 08/16] KVM: s390: remove "from (user|kernel)" from irq injection messages
Date: Wed, 29 Jul 2015 11:05:58 +0200
Message-ID: <1438160766-108179-9-git-send-email-borntraeger@de.ibm.com>
References: <1438160766-108179-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1438160766-108179-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

The "from user"/"from kernel" part of the log/trace messages is not
always correct anymore and therefore not really helpful.

Let's remove that part from the log + trace messages. For program
interrupts, we can now move the logging/tracing part into the real
injection function, as already done for the other injection functions.

Reviewed-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c  | 33 ++++++++++++++-------------------
 arch/s390/kvm/trace-s390.h | 11 +++--------
 2 files changed, 17 insertions(+), 27 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 8b3a117..a5acacc 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -967,6 +967,10 @@ static int __inject_prog(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 
+	VCPU_EVENT(vcpu, 3, "inject: program irq code 0x%x", irq->u.pgm.code);
+	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_PROGRAM_INT,
+				   irq->u.pgm.code, 0);
+
 	li->irq.pgm = irq->u.pgm;
 	set_bit(IRQ_PEND_PROG, &li->pending_irqs);
 	return 0;
@@ -977,9 +981,6 @@ int kvm_s390_inject_program_int(struct kvm_vcpu *vcpu, u16 code)
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 	struct kvm_s390_irq irq;
 
-	VCPU_EVENT(vcpu, 3, "inject: program check %d (from kernel)", code);
-	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_PROGRAM_INT, code,
-				   0, 1);
 	spin_lock(&li->lock);
 	irq.u.pgm.code = code;
 	__inject_prog(vcpu, &irq);
@@ -995,10 +996,6 @@ int kvm_s390_inject_prog_irq(struct kvm_vcpu *vcpu,
 	struct kvm_s390_irq irq;
 	int rc;
 
-	VCPU_EVENT(vcpu, 3, "inject: prog irq %d (from kernel)",
-		   pgm_info->code);
-	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_PROGRAM_INT,
-				   pgm_info->code, 0, 1);
 	spin_lock(&li->lock);
 	irq.u.pgm = *pgm_info;
 	rc = __inject_prog(vcpu, &irq);
@@ -1015,7 +1012,7 @@ static int __inject_pfault_init(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 		   irq->u.ext.ext_params, irq->u.ext.ext_params2);
 	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_INT_PFAULT_INIT,
 				   irq->u.ext.ext_params,
-				   irq->u.ext.ext_params2, 2);
+				   irq->u.ext.ext_params2);
 
 	li->irq.ext = irq->u.ext;
 	set_bit(IRQ_PEND_PFAULT_INIT, &li->pending_irqs);
@@ -1047,7 +1044,7 @@ static int __inject_extcall(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 	VCPU_EVENT(vcpu, 3, "inject: external call source-cpu:%u",
 		   src_id);
 	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_INT_EXTERNAL_CALL,
-				   src_id, 0, 2);
+				   src_id, 0);
 
 	/* sending vcpu invalid */
 	if (src_id >= KVM_MAX_VCPUS ||
@@ -1069,10 +1066,10 @@ static int __inject_set_prefix(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 	struct kvm_s390_prefix_info *prefix = &li->irq.prefix;
 
-	VCPU_EVENT(vcpu, 3, "inject: set prefix to %x (from user)",
+	VCPU_EVENT(vcpu, 3, "inject: set prefix to %x",
 		   irq->u.prefix.address);
 	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_SIGP_SET_PREFIX,
-				   irq->u.prefix.address, 0, 2);
+				   irq->u.prefix.address, 0);
 
 	if (!is_vcpu_stopped(vcpu))
 		return -EBUSY;
@@ -1089,7 +1086,7 @@ static int __inject_sigp_stop(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 	struct kvm_s390_stop_info *stop = &li->irq.stop;
 	int rc = 0;
 
-	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_SIGP_STOP, 0, 0, 2);
+	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_SIGP_STOP, 0, 0);
 
 	if (irq->u.stop.flags & ~KVM_S390_STOP_SUPP_FLAGS)
 		return -EINVAL;
@@ -1114,7 +1111,7 @@ static int __inject_sigp_restart(struct kvm_vcpu *vcpu,
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 
 	VCPU_EVENT(vcpu, 3, "inject: restart type %llx", irq->type);
-	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_RESTART, 0, 0, 2);
+	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_RESTART, 0, 0);
 
 	set_bit(IRQ_PEND_RESTART, &li->pending_irqs);
 	return 0;
@@ -1128,7 +1125,7 @@ static int __inject_sigp_emergency(struct kvm_vcpu *vcpu,
 	VCPU_EVENT(vcpu, 3, "inject: emergency %u\n",
 		   irq->u.emerg.code);
 	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_INT_EMERGENCY,
-				   irq->u.emerg.code, 0, 2);
+				   irq->u.emerg.code, 0);
 
 	set_bit(irq->u.emerg.code, li->sigp_emerg_pending);
 	set_bit(IRQ_PEND_EXT_EMERGENCY, &li->pending_irqs);
@@ -1144,7 +1141,7 @@ static int __inject_mchk(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 	VCPU_EVENT(vcpu, 5, "inject: machine check parm64:%llx",
 		   irq->u.mchk.mcic);
 	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_MCHK, 0,
-				   irq->u.mchk.mcic, 2);
+				   irq->u.mchk.mcic);
 
 	/*
 	 * Because repressible machine checks can be indicated along with
@@ -1173,7 +1170,7 @@ static int __inject_ckc(struct kvm_vcpu *vcpu)
 
 	VCPU_EVENT(vcpu, 3, "inject: type %x", KVM_S390_INT_CLOCK_COMP);
 	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_INT_CLOCK_COMP,
-				   0, 0, 2);
+				   0, 0);
 
 	set_bit(IRQ_PEND_EXT_CLOCK_COMP, &li->pending_irqs);
 	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
@@ -1186,7 +1183,7 @@ static int __inject_cpu_timer(struct kvm_vcpu *vcpu)
 
 	VCPU_EVENT(vcpu, 3, "inject: type %x", KVM_S390_INT_CPU_TIMER);
 	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_INT_CPU_TIMER,
-				   0, 0, 2);
+				   0, 0);
 
 	set_bit(IRQ_PEND_EXT_CPU_TIMER, &li->pending_irqs);
 	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
@@ -1534,8 +1531,6 @@ static int do_inject_vcpu(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
 
 	switch (irq->type) {
 	case KVM_S390_PROGRAM_INT:
-		VCPU_EVENT(vcpu, 3, "inject: program check %d (from user)",
-			   irq->u.pgm.code);
 		rc = __inject_prog(vcpu, irq);
 		break;
 	case KVM_S390_SIGP_SET_PREFIX:
diff --git a/arch/s390/kvm/trace-s390.h b/arch/s390/kvm/trace-s390.h
index 3208d33..4f373c5 100644
--- a/arch/s390/kvm/trace-s390.h
+++ b/arch/s390/kvm/trace-s390.h
@@ -137,16 +137,14 @@ TRACE_EVENT(kvm_s390_inject_vm,
 	);
 
 TRACE_EVENT(kvm_s390_inject_vcpu,
-	    TP_PROTO(unsigned int id, __u64 type, __u32 parm, __u64 parm64, \
-		     int who),
-	    TP_ARGS(id, type, parm, parm64, who),
+	    TP_PROTO(unsigned int id, __u64 type, __u32 parm, __u64 parm64),
+	    TP_ARGS(id, type, parm, parm64),
 
 	    TP_STRUCT__entry(
 		    __field(int, id)
 		    __field(__u32, inttype)
 		    __field(__u32, parm)
 		    __field(__u64, parm64)
-		    __field(int, who)
 		    ),
 
 	    TP_fast_assign(
@@ -154,12 +152,9 @@ TRACE_EVENT(kvm_s390_inject_vcpu,
 		    __entry->inttype = type & 0x00000000ffffffff;
 		    __entry->parm = parm;
 		    __entry->parm64 = parm64;
-		    __entry->who = who;
 		    ),
 
-	    TP_printk("inject%s (vcpu %d): type:%x (%s) parm:%x parm64:%llx",
-		      (__entry->who == 1) ? " (from kernel)" :
-		      (__entry->who == 2) ? " (from user)" : "",
+	    TP_printk("inject (vcpu %d): type:%x (%s) parm:%x parm64:%llx",
 		      __entry->id, __entry->inttype,
 		      __print_symbolic(__entry->inttype, kvm_s390_int_type),
 		      __entry->parm, __entry->parm64)
-- 
2.3.0
