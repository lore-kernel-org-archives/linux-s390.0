From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 2/3] KVM: s390: Add architectural trace events.
Date: Mon, 23 Jul 2012 17:20:29 +0200
Message-ID: <1343056830-45290-3-git-send-email-cornelia.huck@de.ibm.com>
References: <1343056830-45290-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1343056830-45290-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Add trace events for several s390 architecture specifics:

- SIE entry/exit
- common intercepts
- common instructions (sigp/diagnose)

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/diag.c      |   2 +
 arch/s390/kvm/intercept.c |   8 ++
 arch/s390/kvm/kvm-s390.c  |   7 +
 arch/s390/kvm/priv.c      |   9 +-
 arch/s390/kvm/sigp.c      |   2 +
 arch/s390/kvm/trace.h     | 341 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 368 insertions(+), 1 deletion(-)
 create mode 100644 arch/s390/kvm/trace.h

diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index b23d9ac..df1cc6d 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -14,6 +14,7 @@
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
 #include "kvm-s390.h"
+#include "trace.h"
 
 static int diag_release_pages(struct kvm_vcpu *vcpu)
 {
@@ -105,6 +106,7 @@ int kvm_s390_handle_diag(struct kvm_vcpu *vcpu)
 {
 	int code = (vcpu->arch.sie_block->ipb & 0xfff0000) >> 16;
 
+	trace_kvm_s390_handle_diag(vcpu, code);
 	switch (code) {
 	case 0x10:
 		return diag_release_pages(vcpu);
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 979cbe5..af11fb0 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -19,6 +19,7 @@
 
 #include "kvm-s390.h"
 #include "gaccess.h"
+#include "trace.h"
 
 static int handle_lctlg(struct kvm_vcpu *vcpu)
 {
@@ -45,6 +46,7 @@ static int handle_lctlg(struct kvm_vcpu *vcpu)
 
 	VCPU_EVENT(vcpu, 5, "lctlg r1:%x, r3:%x,b2:%x,d2:%x", reg1, reg3, base2,
 		   disp2);
+	trace_kvm_s390_handle_lctl(vcpu, 1, reg1, reg3, useraddr);
 
 	do {
 		rc = get_guest_u64(vcpu, useraddr,
@@ -82,6 +84,7 @@ static int handle_lctl(struct kvm_vcpu *vcpu)
 
 	VCPU_EVENT(vcpu, 5, "lctl r1:%x, r3:%x,b2:%x,d2:%x", reg1, reg3, base2,
 		   disp2);
+	trace_kvm_s390_handle_lctl(vcpu, 0, reg1, reg3, useraddr);
 
 	reg = reg1;
 	do {
@@ -171,6 +174,7 @@ static int handle_validity(struct kvm_vcpu *vcpu)
 	int rc;
 
 	vcpu->stat.exit_validity++;
+	trace_kvm_s390_intercept_validity(vcpu, viwhy);
 	if (viwhy == 0x37) {
 		vmaddr = gmap_fault(vcpu->arch.sie_block->prefix,
 				    vcpu->arch.gmap);
@@ -213,6 +217,9 @@ static int handle_instruction(struct kvm_vcpu *vcpu)
 	intercept_handler_t handler;
 
 	vcpu->stat.exit_instruction++;
+	trace_kvm_s390_intercept_instruction(vcpu,
+					     vcpu->arch.sie_block->ipa,
+					     vcpu->arch.sie_block->ipb);
 	handler = instruction_handlers[vcpu->arch.sie_block->ipa >> 8];
 	if (handler)
 		return handler(vcpu);
@@ -222,6 +229,7 @@ static int handle_instruction(struct kvm_vcpu *vcpu)
 static int handle_prog(struct kvm_vcpu *vcpu)
 {
 	vcpu->stat.exit_program_interruption++;
+	trace_kvm_s390_intercept_prog(vcpu, vcpu->arch.sie_block->iprcc);
 	return kvm_s390_inject_program_int(vcpu, vcpu->arch.sie_block->iprcc);
 }
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ace9360..cdc1d05 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -32,6 +32,9 @@
 #include "kvm-s390.h"
 #include "gaccess.h"
 
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+
 #define VCPU_STAT(x) offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU
 
 struct kvm_stats_debugfs_item debugfs_entries[] = {
@@ -607,18 +610,22 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
 	local_irq_enable();
 	VCPU_EVENT(vcpu, 6, "entering sie flags %x",
 		   atomic_read(&vcpu->arch.sie_block->cpuflags));
+	trace_kvm_s390_sie_enter(vcpu,
+				 atomic_read(&vcpu->arch.sie_block->cpuflags));
 	rc = sie64a(vcpu->arch.sie_block, vcpu->run->s.regs.gprs);
 	if (rc) {
 		if (kvm_is_ucontrol(vcpu->kvm)) {
 			rc = SIE_INTERCEPT_UCONTROL;
 		} else {
 			VCPU_EVENT(vcpu, 3, "%s", "fault in sie instruction");
+			trace_kvm_s390_sie_fault(vcpu);
 			kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 			rc = 0;
 		}
 	}
 	VCPU_EVENT(vcpu, 6, "exit sie icptcode %d",
 		   vcpu->arch.sie_block->icptcode);
+	trace_kvm_s390_sie_exit(vcpu, vcpu->arch.sie_block->icptcode);
 	local_irq_disable();
 	kvm_guest_exit();
 	local_irq_enable();
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 68a6b2e..d31d04e 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -20,6 +20,7 @@
 #include <asm/sysinfo.h>
 #include "gaccess.h"
 #include "kvm-s390.h"
+#include "trace.h"
 
 static int handle_set_prefix(struct kvm_vcpu *vcpu)
 {
@@ -59,6 +60,7 @@ static int handle_set_prefix(struct kvm_vcpu *vcpu)
 	kvm_s390_set_prefix(vcpu, address);
 
 	VCPU_EVENT(vcpu, 5, "setting prefix to %x", address);
+	trace_kvm_s390_handle_prefix(vcpu, 1, address);
 out:
 	return 0;
 }
@@ -91,6 +93,7 @@ static int handle_store_prefix(struct kvm_vcpu *vcpu)
 	}
 
 	VCPU_EVENT(vcpu, 5, "storing prefix to %x", address);
+	trace_kvm_s390_handle_prefix(vcpu, 0, address);
 out:
 	return 0;
 }
@@ -119,6 +122,7 @@ static int handle_store_cpu_address(struct kvm_vcpu *vcpu)
 	}
 
 	VCPU_EVENT(vcpu, 5, "storing cpu address to %llx", useraddr);
+	trace_kvm_s390_handle_stap(vcpu, useraddr);
 out:
 	return 0;
 }
@@ -164,9 +168,11 @@ static int handle_stfl(struct kvm_vcpu *vcpu)
 			   &facility_list, sizeof(facility_list));
 	if (rc == -EFAULT)
 		kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-	else
+	else {
 		VCPU_EVENT(vcpu, 5, "store facility list value %x",
 			   facility_list);
+		trace_kvm_s390_handle_stfl(vcpu, facility_list);
+	}
 	return 0;
 }
 
@@ -278,6 +284,7 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
 		kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 		goto out_mem;
 	}
+	trace_kvm_s390_handle_stsi(vcpu, fc, sel1, sel2, operand2);
 	free_page(mem);
 	vcpu->arch.sie_block->gpsw.mask &= ~(3ul << 44);
 	vcpu->run->s.regs.gprs[0] = 0;
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 6ed8175..6ed3ab1 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -18,6 +18,7 @@
 #include <asm/sigp.h>
 #include "gaccess.h"
 #include "kvm-s390.h"
+#include "trace.h"
 
 static int __sigp_sense(struct kvm_vcpu *vcpu, u16 cpu_addr,
 			u64 *reg)
@@ -344,6 +345,7 @@ int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu)
 	else
 		parameter = vcpu->run->s.regs.gprs[r1 + 1];
 
+	trace_kvm_s390_handle_sigp(vcpu, order_code, cpu_addr, parameter);
 	switch (order_code) {
 	case SIGP_SENSE:
 		vcpu->stat.instruction_sigp_sense++;
diff --git a/arch/s390/kvm/trace.h b/arch/s390/kvm/trace.h
new file mode 100644
index 0000000..2b29e62
--- /dev/null
+++ b/arch/s390/kvm/trace.h
@@ -0,0 +1,341 @@
+#if !defined(_TRACE_KVM_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_KVM_H
+
+#include <linux/tracepoint.h>
+#include <asm/sigp.h>
+#include <asm/debug.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM kvm
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace
+
+/*
+ * Helpers for vcpu-specific tracepoints containing the same information
+ * as s390dbf VCPU_EVENTs.
+ */
+#define VCPU_PROTO_COMMON struct kvm_vcpu *vcpu
+#define VCPU_ARGS_COMMON vcpu
+#define VCPU_FIELD_COMMON __field(int, id)			\
+	__field(unsigned long, pswmask)				\
+	__field(unsigned long, pswaddr)
+#define VCPU_ASSIGN_COMMON do {						\
+	__entry->id = vcpu->vcpu_id;					\
+	__entry->pswmask = vcpu->arch.sie_block->gpsw.mask;		\
+	__entry->pswaddr = vcpu->arch.sie_block->gpsw.addr;		\
+	} while (0);
+#define VCPU_TP_PRINTK(p_str, p_args...)				\
+	TP_printk("%02d[%016lx-%016lx]: " p_str, __entry->id,		\
+		  __entry->pswmask, __entry->pswaddr, p_args)
+
+/*
+ * Tracepoints for SIE entry and exit.
+ */
+TRACE_EVENT(kvm_s390_sie_enter,
+	    TP_PROTO(VCPU_PROTO_COMMON, int cpuflags),
+	    TP_ARGS(VCPU_ARGS_COMMON, cpuflags),
+
+	    TP_STRUCT__entry(
+		    VCPU_FIELD_COMMON
+		    __field(int, cpuflags)
+		    ),
+
+	    TP_fast_assign(
+		    VCPU_ASSIGN_COMMON
+		    __entry->cpuflags = cpuflags;
+		    ),
+
+	    VCPU_TP_PRINTK("entering sie flags %x", __entry->cpuflags)
+	);
+
+TRACE_EVENT(kvm_s390_sie_fault,
+	    TP_PROTO(VCPU_PROTO_COMMON),
+	    TP_ARGS(VCPU_ARGS_COMMON),
+
+	    TP_STRUCT__entry(
+		    VCPU_FIELD_COMMON
+		    ),
+
+	    TP_fast_assign(
+		    VCPU_ASSIGN_COMMON
+		    ),
+
+	    VCPU_TP_PRINTK("%s", "fault in sie instruction")
+	);
+
+#define sie_intercept_code				\
+	{0x04, "Instruction"},				\
+	{0x08, "Program interruption"},			\
+	{0x0C, "Instruction and program interuption"},	\
+	{0x10, "External request"},			\
+	{0x14, "External interruption"},		\
+	{0x18, "I/O request"},				\
+	{0x1C, "Wait state"},				\
+	{0x20, "Validity"},				\
+	{0x28, "Stop request"}
+
+TRACE_EVENT(kvm_s390_sie_exit,
+	    TP_PROTO(VCPU_PROTO_COMMON, u8 icptcode),
+	    TP_ARGS(VCPU_ARGS_COMMON, icptcode),
+
+	    TP_STRUCT__entry(
+		    VCPU_FIELD_COMMON
+		    __field(u8, icptcode)
+		    ),
+
+	    TP_fast_assign(
+		    VCPU_ASSIGN_COMMON
+		    __entry->icptcode = icptcode;
+		    ),
+
+	    VCPU_TP_PRINTK("exit sie icptcode %d (%s)", __entry->icptcode,
+			   __print_symbolic(__entry->icptcode,
+					    sie_intercept_code))
+	);
+
+/*
+ * Trace point for intercepted instructions.
+ */
+TRACE_EVENT(kvm_s390_intercept_instruction,
+	    TP_PROTO(VCPU_PROTO_COMMON, __u16 ipa, __u32 ipb),
+	    TP_ARGS(VCPU_ARGS_COMMON, ipa, ipb),
+
+	    TP_STRUCT__entry(
+		    VCPU_FIELD_COMMON
+		    __field(__u64, instruction)
+		    __field(char, insn[8])
+		    ),
+
+	    TP_fast_assign(
+		    VCPU_ASSIGN_COMMON
+		    __entry->instruction = ((__u64)ipa << 48) |
+		    ((__u64)ipb << 16);
+		    ),
+
+	    VCPU_TP_PRINTK("intercepted instruction %016llx (%s)",
+			   __entry->instruction,
+			   insn_to_mnemonic((unsigned char *)
+					    &__entry->instruction,
+					 __entry->insn) ?
+			   "unknown" : __entry->insn)
+	);
+
+/*
+ * Trace point for intercepted program interruptions.
+ */
+TRACE_EVENT(kvm_s390_intercept_prog,
+	    TP_PROTO(VCPU_PROTO_COMMON, __u16 code),
+	    TP_ARGS(VCPU_ARGS_COMMON, code),
+
+	    TP_STRUCT__entry(
+		    VCPU_FIELD_COMMON
+		    __field(__u16, code)
+		    ),
+
+	    TP_fast_assign(
+		    VCPU_ASSIGN_COMMON
+		    __entry->code = code;
+		    ),
+
+	    VCPU_TP_PRINTK("intercepted program interruption %04x",
+			   __entry->code)
+	);
+
+/*
+ * Trace point for validity intercepts.
+ */
+TRACE_EVENT(kvm_s390_intercept_validity,
+	    TP_PROTO(VCPU_PROTO_COMMON, __u16 viwhy),
+	    TP_ARGS(VCPU_ARGS_COMMON, viwhy),
+
+	    TP_STRUCT__entry(
+		    VCPU_FIELD_COMMON
+		    __field(__u16, viwhy)
+		    ),
+
+	    TP_fast_assign(
+		    VCPU_ASSIGN_COMMON
+		    __entry->viwhy = viwhy;
+		    ),
+
+	    VCPU_TP_PRINTK("got validity intercept %04x", __entry->viwhy)
+	);
+
+/*
+ * Trace points for instructions that are of special interest.
+ */
+
+#define sigp_order_codes					\
+	{SIGP_SENSE, "sense"},					\
+	{SIGP_EXTERNAL_CALL, "external call"},			\
+	{SIGP_EMERGENCY_SIGNAL, "emergency signal"},		\
+	{SIGP_STOP, "stop"},					\
+	{SIGP_STOP_AND_STORE_STATUS, "stop and store status"},	\
+	{SIGP_SET_ARCHITECTURE, "set architecture"},		\
+	{SIGP_SET_PREFIX, "set prefix"},			\
+	{SIGP_SENSE_RUNNING, "sense running"},			\
+	{SIGP_RESTART, "restart"}
+
+TRACE_EVENT(kvm_s390_handle_sigp,
+	    TP_PROTO(VCPU_PROTO_COMMON, __u8 order_code, __u16 cpu_addr, \
+		     __u32 parameter),
+	    TP_ARGS(VCPU_ARGS_COMMON, order_code, cpu_addr, parameter),
+
+	    TP_STRUCT__entry(
+		    VCPU_FIELD_COMMON
+		    __field(__u8, order_code)
+		    __field(__u16, cpu_addr)
+		    __field(__u32, parameter)
+		    ),
+
+	    TP_fast_assign(
+		    VCPU_ASSIGN_COMMON
+		    __entry->order_code = order_code;
+		    __entry->cpu_addr = cpu_addr;
+		    __entry->parameter = parameter;
+		    ),
+
+	    VCPU_TP_PRINTK("handle sigp order %02x (%s), cpu address %04x, " \
+			   "parameter %08x", __entry->order_code,
+			   __print_symbolic(__entry->order_code,
+					    sigp_order_codes),
+			   __entry->cpu_addr, __entry->parameter)
+	);
+
+#define diagnose_codes				\
+	{0x10, "release pages"},		\
+	{0x44, "time slice end"},		\
+	{0x308, "ipl functions"},		\
+	{0x500, "kvm hypercall"},		\
+	{0x501, "kvm breakpoint"}
+
+TRACE_EVENT(kvm_s390_handle_diag,
+	    TP_PROTO(VCPU_PROTO_COMMON, __u16 code),
+	    TP_ARGS(VCPU_ARGS_COMMON, code),
+
+	    TP_STRUCT__entry(
+		    VCPU_FIELD_COMMON
+		    __field(__u16, code)
+		    ),
+
+	    TP_fast_assign(
+		    VCPU_ASSIGN_COMMON
+		    __entry->code = code;
+		    ),
+
+	    VCPU_TP_PRINTK("handle diagnose call %04x (%s)", __entry->code,
+			   __print_symbolic(__entry->code, diagnose_codes))
+	);
+
+TRACE_EVENT(kvm_s390_handle_lctl,
+	    TP_PROTO(VCPU_PROTO_COMMON, int g, int reg1, int reg3, u64 addr),
+	    TP_ARGS(VCPU_ARGS_COMMON, g, reg1, reg3, addr),
+
+	    TP_STRUCT__entry(
+		    VCPU_FIELD_COMMON
+		    __field(int, g)
+		    __field(int, reg1)
+		    __field(int, reg3)
+		    __field(u64, addr)
+		    ),
+
+	    TP_fast_assign(
+		    VCPU_ASSIGN_COMMON
+		    __entry->g = g;
+		    __entry->reg1 = reg1;
+		    __entry->reg3 = reg3;
+		    __entry->addr = addr;
+		    ),
+
+	    VCPU_TP_PRINTK("%s: loading cr %x-%x from %016llx",
+			   __entry->g ? "lctlg" : "lctl",
+			   __entry->reg1, __entry->reg3, __entry->addr)
+	);
+
+TRACE_EVENT(kvm_s390_handle_prefix,
+	    TP_PROTO(VCPU_PROTO_COMMON, int set, u32 address),
+	    TP_ARGS(VCPU_ARGS_COMMON, set, address),
+
+	    TP_STRUCT__entry(
+		    VCPU_FIELD_COMMON
+		    __field(int, set)
+		    __field(u32, address)
+		    ),
+
+	    TP_fast_assign(
+		    VCPU_ASSIGN_COMMON
+		    __entry->set = set;
+		    __entry->address = address;
+		    ),
+
+	    VCPU_TP_PRINTK("%s prefix to %08x",
+			   __entry->set ? "setting" : "storing",
+			   __entry->address)
+	);
+
+TRACE_EVENT(kvm_s390_handle_stap,
+	    TP_PROTO(VCPU_PROTO_COMMON, u64 address),
+	    TP_ARGS(VCPU_ARGS_COMMON, address),
+
+	    TP_STRUCT__entry(
+		    VCPU_FIELD_COMMON
+		    __field(u64, address)
+		    ),
+
+	    TP_fast_assign(
+		    VCPU_ASSIGN_COMMON
+		    __entry->address = address;
+		    ),
+
+	    VCPU_TP_PRINTK("storing cpu address to %016llx",
+			   __entry->address)
+	);
+
+TRACE_EVENT(kvm_s390_handle_stfl,
+	    TP_PROTO(VCPU_PROTO_COMMON, unsigned int facility_list),
+	    TP_ARGS(VCPU_ARGS_COMMON, facility_list),
+
+	    TP_STRUCT__entry(
+		    VCPU_FIELD_COMMON
+		    __field(unsigned int, facility_list)
+		    ),
+
+	    TP_fast_assign(
+		    VCPU_ASSIGN_COMMON
+		    __entry->facility_list = facility_list;
+		    ),
+
+	    VCPU_TP_PRINTK("store facility list value %08x",
+			   __entry->facility_list)
+	);
+
+TRACE_EVENT(kvm_s390_handle_stsi,
+	    TP_PROTO(VCPU_PROTO_COMMON, int fc, int sel1, int sel2, u64 addr),
+	    TP_ARGS(VCPU_ARGS_COMMON, fc, sel1, sel2, addr),
+
+	    TP_STRUCT__entry(
+		    VCPU_FIELD_COMMON
+		    __field(int, fc)
+		    __field(int, sel1)
+		    __field(int, sel2)
+		    __field(u64, addr)
+		    ),
+
+	    TP_fast_assign(
+		    VCPU_ASSIGN_COMMON
+		    __entry->fc = fc;
+		    __entry->sel1 = sel1;
+		    __entry->sel2 = sel2;
+		    __entry->addr = addr;
+		    ),
+
+	    VCPU_TP_PRINTK("STSI %d.%d.%d information stored to %016llx",
+			   __entry->fc, __entry->sel1, __entry->sel2,
+			   __entry->addr)
+	);
+
+#endif /* _TRACE_KVM_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
1.7.11.2
