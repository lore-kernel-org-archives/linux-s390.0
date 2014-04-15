From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 39/47] KVM: s390: emulate stctl and stctg
Date: Tue, 15 Apr 2014 14:00:42 +0200
Message-ID: <1397563250-3089-40-git-send-email-borntraeger@de.ibm.com>
References: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Introduce the methods to emulate the stctl and stctg instruction. Added tracing
code.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  2 ++
 arch/s390/kvm/intercept.c        |  1 +
 arch/s390/kvm/kvm-s390.c         |  2 ++
 arch/s390/kvm/kvm-s390.h         |  1 +
 arch/s390/kvm/priv.c             | 73 ++++++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/trace.h            | 25 ++++++++++++++
 6 files changed, 104 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 5e5a14d..5d96489 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -175,6 +175,8 @@ struct kvm_vcpu_stat {
 	u32 exit_instruction;
 	u32 instruction_lctl;
 	u32 instruction_lctlg;
+	u32 instruction_stctl;
+	u32 instruction_stctg;
 	u32 exit_program_interruption;
 	u32 exit_instr_and_program;
 	u32 deliver_external_call;
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 4c3311e..c0e6b49 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -29,6 +29,7 @@ static const intercept_handler_t instruction_handlers[256] = {
 	[0x83] = kvm_s390_handle_diag,
 	[0xae] = kvm_s390_handle_sigp,
 	[0xb2] = kvm_s390_handle_b2,
+	[0xb6] = kvm_s390_handle_stctl,
 	[0xb7] = kvm_s390_handle_lctl,
 	[0xb9] = kvm_s390_handle_b9,
 	[0xe5] = kvm_s390_handle_e5,
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ae7c126..7ae8c26 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -52,6 +52,8 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "exit_instr_and_program_int", VCPU_STAT(exit_instr_and_program) },
 	{ "instruction_lctlg", VCPU_STAT(instruction_lctlg) },
 	{ "instruction_lctl", VCPU_STAT(instruction_lctl) },
+	{ "instruction_stctl", VCPU_STAT(instruction_stctl) },
+	{ "instruction_stctg", VCPU_STAT(instruction_stctg) },
 	{ "deliver_emergency_signal", VCPU_STAT(deliver_emergency_signal) },
 	{ "deliver_external_call", VCPU_STAT(deliver_external_call) },
 	{ "deliver_service_signal", VCPU_STAT(deliver_service_signal) },
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index dc506f3..5f00fc1 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -147,6 +147,7 @@ int kvm_s390_handle_e5(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_01(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_b9(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu);
+int kvm_s390_handle_stctl(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_lctl(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_eb(struct kvm_vcpu *vcpu);
 
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 5fb503a..27f9051 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -789,6 +789,42 @@ int kvm_s390_handle_lctl(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+int kvm_s390_handle_stctl(struct kvm_vcpu *vcpu)
+{
+	int reg1 = (vcpu->arch.sie_block->ipa & 0x00f0) >> 4;
+	int reg3 = vcpu->arch.sie_block->ipa & 0x000f;
+	u64 ga;
+	u32 val;
+	int reg, rc;
+
+	vcpu->stat.instruction_stctl++;
+
+	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
+		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
+
+	ga = kvm_s390_get_base_disp_rs(vcpu);
+
+	if (ga & 3)
+		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+
+	VCPU_EVENT(vcpu, 5, "stctl r1:%x, r3:%x, addr:%llx", reg1, reg3, ga);
+	trace_kvm_s390_handle_stctl(vcpu, 0, reg1, reg3, ga);
+
+	reg = reg1;
+	do {
+		val = vcpu->arch.sie_block->gcr[reg] &  0x00000000fffffffful;
+		rc = write_guest(vcpu, ga, &val, sizeof(val));
+		if (rc)
+			return kvm_s390_inject_prog_cond(vcpu, rc);
+		ga += 4;
+		if (reg == reg3)
+			break;
+		reg = (reg + 1) % 16;
+	} while (1);
+
+	return 0;
+}
+
 static int handle_lctlg(struct kvm_vcpu *vcpu)
 {
 	int reg1 = (vcpu->arch.sie_block->ipa & 0x00f0) >> 4;
@@ -825,8 +861,45 @@ static int handle_lctlg(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static int handle_stctg(struct kvm_vcpu *vcpu)
+{
+	int reg1 = (vcpu->arch.sie_block->ipa & 0x00f0) >> 4;
+	int reg3 = vcpu->arch.sie_block->ipa & 0x000f;
+	u64 ga, val;
+	int reg, rc;
+
+	vcpu->stat.instruction_stctg++;
+
+	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
+		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
+
+	ga = kvm_s390_get_base_disp_rsy(vcpu);
+
+	if (ga & 7)
+		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+
+	reg = reg1;
+
+	VCPU_EVENT(vcpu, 5, "stctg r1:%x, r3:%x, addr:%llx", reg1, reg3, ga);
+	trace_kvm_s390_handle_stctl(vcpu, 1, reg1, reg3, ga);
+
+	do {
+		val = vcpu->arch.sie_block->gcr[reg];
+		rc = write_guest(vcpu, ga, &val, sizeof(val));
+		if (rc)
+			return kvm_s390_inject_prog_cond(vcpu, rc);
+		ga += 8;
+		if (reg == reg3)
+			break;
+		reg = (reg + 1) % 16;
+	} while (1);
+
+	return 0;
+}
+
 static const intercept_handler_t eb_handlers[256] = {
 	[0x2f] = handle_lctlg,
+	[0x25] = handle_stctg,
 };
 
 int kvm_s390_handle_eb(struct kvm_vcpu *vcpu)
diff --git a/arch/s390/kvm/trace.h b/arch/s390/kvm/trace.h
index a4bf7d7..abf6ba5 100644
--- a/arch/s390/kvm/trace.h
+++ b/arch/s390/kvm/trace.h
@@ -315,6 +315,31 @@ TRACE_EVENT(kvm_s390_handle_lctl,
 			   __entry->reg1, __entry->reg3, __entry->addr)
 	);
 
+TRACE_EVENT(kvm_s390_handle_stctl,
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
+	    VCPU_TP_PRINTK("%s: storing cr %x-%x to %016llx",
+			   __entry->g ? "stctg" : "stctl",
+			   __entry->reg1, __entry->reg3, __entry->addr)
+	);
+
 TRACE_EVENT(kvm_s390_handle_prefix,
 	    TP_PROTO(VCPU_PROTO_COMMON, int set, u32 address),
 	    TP_ARGS(VCPU_ARGS_COMMON, set, address),
-- 
1.8.4.2
