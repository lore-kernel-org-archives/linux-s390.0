From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 04/52] KVM: s390: Add operation exception interception handler
Date: Tue, 14 Jun 2016 20:56:41 +0200
Message-ID: <1465930649-181383-5-git-send-email-borntraeger@de.ibm.com>
References: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Janosch Frank <frankja@linux.vnet.ibm.com>

This commit introduces code that handles operation exception
interceptions. With this handler we can emulate instructions by using
illegal opcodes.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  1 +
 arch/s390/kvm/intercept.c        | 11 +++++++++++
 arch/s390/kvm/kvm-s390.c         |  1 +
 arch/s390/kvm/trace.h            | 21 +++++++++++++++++++++
 4 files changed, 34 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 37b9017..093ea14 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -255,6 +255,7 @@ struct kvm_vcpu_stat {
 	u32 instruction_stctg;
 	u32 exit_program_interruption;
 	u32 exit_instr_and_program;
+	u32 exit_operation_exception;
 	u32 deliver_external_call;
 	u32 deliver_emergency_signal;
 	u32 deliver_service_signal;
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 2e6b54e..09c13db 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -349,6 +349,15 @@ static int handle_partial_execution(struct kvm_vcpu *vcpu)
 	return -EOPNOTSUPP;
 }
 
+static int handle_operexc(struct kvm_vcpu *vcpu)
+{
+	vcpu->stat.exit_operation_exception++;
+	trace_kvm_s390_handle_operexc(vcpu, vcpu->arch.sie_block->ipa,
+				      vcpu->arch.sie_block->ipb);
+
+	return kvm_s390_inject_program_int(vcpu, PGM_OPERATION);
+}
+
 int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
 {
 	if (kvm_is_ucontrol(vcpu->kvm))
@@ -370,6 +379,8 @@ int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
 		return handle_validity(vcpu);
 	case 0x28:
 		return handle_stop(vcpu);
+	case 0x2c:
+		return handle_operexc(vcpu);
 	case 0x38:
 		return handle_partial_execution(vcpu);
 	default:
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 6d8ec3a..f0addec 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -63,6 +63,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "exit_instruction", VCPU_STAT(exit_instruction) },
 	{ "exit_program_interruption", VCPU_STAT(exit_program_interruption) },
 	{ "exit_instr_and_program_int", VCPU_STAT(exit_instr_and_program) },
+	{ "exit_operation_exception", VCPU_STAT(exit_operation_exception) },
 	{ "halt_successful_poll", VCPU_STAT(halt_successful_poll) },
 	{ "halt_attempted_poll", VCPU_STAT(halt_attempted_poll) },
 	{ "halt_poll_invalid", VCPU_STAT(halt_poll_invalid) },
diff --git a/arch/s390/kvm/trace.h b/arch/s390/kvm/trace.h
index 916834d..90d26a6 100644
--- a/arch/s390/kvm/trace.h
+++ b/arch/s390/kvm/trace.h
@@ -412,6 +412,27 @@ TRACE_EVENT(kvm_s390_handle_stsi,
 			   __entry->addr)
 	);
 
+TRACE_EVENT(kvm_s390_handle_operexc,
+	    TP_PROTO(VCPU_PROTO_COMMON, __u16 ipa, __u32 ipb),
+	    TP_ARGS(VCPU_ARGS_COMMON, ipa, ipb),
+
+	    TP_STRUCT__entry(
+		    VCPU_FIELD_COMMON
+		    __field(__u64, instruction)
+		    ),
+
+	    TP_fast_assign(
+		    VCPU_ASSIGN_COMMON
+		    __entry->instruction = ((__u64)ipa << 48) |
+		    ((__u64)ipb << 16);
+		    ),
+
+	    VCPU_TP_PRINTK("operation exception on instruction %016llx (%s)",
+			   __entry->instruction,
+			   __print_symbolic(icpt_insn_decoder(__entry->instruction),
+					    icpt_insn_codes))
+	);
+
 #endif /* _TRACE_KVM_H */
 
 /* This part must be outside protection */
-- 
2.5.5
