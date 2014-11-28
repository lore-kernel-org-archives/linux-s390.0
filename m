From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 08/11] KVM: s390: refactor interrupt delivery code
Date: Fri, 28 Nov 2014 14:25:36 +0100
Message-ID: <1417181139-25623-9-git-send-email-borntraeger@de.ibm.com>
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

Move delivery code for cpu-local interrupt from the huge do_deliver_interrupt()
to smaller functions which handle one type of interrupt.

Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 459 ++++++++++++++++++++++++++++------------------
 1 file changed, 282 insertions(+), 177 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 481f136..0d7f0a7 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -30,8 +30,6 @@
 #define PFAULT_DONE 0x0680
 #define VIRTIO_PARAM 0x0d00
 
-static int __must_check deliver_ckc_interrupt(struct kvm_vcpu *vcpu);
-
 static int is_ioint(u64 type)
 {
 	return ((type & 0xfffe0000u) != 0xfffe0000u);
@@ -228,12 +226,183 @@ static u16 get_ilc(struct kvm_vcpu *vcpu)
 	}
 }
 
-static int __must_check __deliver_prog_irq(struct kvm_vcpu *vcpu,
-			      struct kvm_s390_pgm_info *pgm_info)
+static int __must_check __deliver_cpu_timer(struct kvm_vcpu *vcpu)
+{
+	int rc;
+
+	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, KVM_S390_INT_CPU_TIMER,
+					 0, 0);
+
+	rc  = put_guest_lc(vcpu, EXT_IRQ_CPU_TIMER,
+			   (u16 *)__LC_EXT_INT_CODE);
+	rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
+			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+	rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
+			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+	return rc;
+}
+
+static int __must_check __deliver_ckc(struct kvm_vcpu *vcpu)
+{
+	int rc;
+
+	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, KVM_S390_INT_CLOCK_COMP,
+					 0, 0);
+
+	rc  = put_guest_lc(vcpu, EXT_IRQ_CLK_COMP,
+			   (u16 __user *)__LC_EXT_INT_CODE);
+	rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
+			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+	rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
+			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+	return rc;
+}
+
+static int __must_check __deliver_pfault_init(struct kvm_vcpu *vcpu,
+					   struct kvm_s390_interrupt_info *inti)
+{
+	struct kvm_s390_ext_info *ext = &inti->ext;
+	int rc;
+
+	VCPU_EVENT(vcpu, 4, "interrupt: pfault init parm:%x,parm64:%llx",
+		   0, ext->ext_params2);
+	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id,
+					 KVM_S390_INT_PFAULT_INIT,
+					 0, ext->ext_params2);
+
+	rc  = put_guest_lc(vcpu, EXT_IRQ_CP_SERVICE, (u16 *) __LC_EXT_INT_CODE);
+	rc |= put_guest_lc(vcpu, PFAULT_INIT, (u16 *) __LC_EXT_CPU_ADDR);
+	rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
+			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+	rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
+			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+	rc |= put_guest_lc(vcpu, ext->ext_params2, (u64 *) __LC_EXT_PARAMS2);
+	return rc;
+}
+
+static int __must_check __deliver_machine_check(struct kvm_vcpu *vcpu,
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
+			   (u64 __user *) __LC_MCCK_CODE);
+	rc |= put_guest_lc(vcpu, mchk->failing_storage_address,
+			   (u64 __user *) __LC_MCCK_FAIL_STOR_ADDR);
+	rc |= write_guest_lc(vcpu, __LC_PSW_SAVE_AREA,
+			     &mchk->fixed_logout, sizeof(mchk->fixed_logout));
+	rc |= write_guest_lc(vcpu, __LC_MCK_OLD_PSW,
+			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+	rc |= read_guest_lc(vcpu, __LC_MCK_NEW_PSW,
+			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+	return rc;
+}
+
+static int __must_check __deliver_restart(struct kvm_vcpu *vcpu)
+{
+	int rc;
+
+	VCPU_EVENT(vcpu, 4, "%s", "interrupt: cpu restart");
+	vcpu->stat.deliver_restart_signal++;
+	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, KVM_S390_RESTART, 0, 0);
+
+	rc  = write_guest_lc(vcpu,
+			     offsetof(struct _lowcore, restart_old_psw),
+			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+	rc |= read_guest_lc(vcpu, offsetof(struct _lowcore, restart_psw),
+			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+	return rc;
+}
+
+static int __must_check __deliver_stop(struct kvm_vcpu *vcpu)
+{
+	VCPU_EVENT(vcpu, 4, "%s", "interrupt: cpu stop");
+	vcpu->stat.deliver_stop_signal++;
+	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, KVM_S390_SIGP_STOP,
+					 0, 0);
+
+	__set_cpuflag(vcpu, CPUSTAT_STOP_INT);
+	return 0;
+}
+
+static int __must_check __deliver_set_prefix(struct kvm_vcpu *vcpu,
+					   struct kvm_s390_interrupt_info *inti)
+{
+	struct kvm_s390_prefix_info *prefix = &inti->prefix;
+
+	VCPU_EVENT(vcpu, 4, "interrupt: set prefix to %x", prefix->address);
+	vcpu->stat.deliver_prefix_signal++;
+	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id,
+					 KVM_S390_SIGP_SET_PREFIX,
+					 prefix->address, 0);
+
+	kvm_s390_set_prefix(vcpu, prefix->address);
+	return 0;
+}
+
+static int __must_check __deliver_emergency_signal(struct kvm_vcpu *vcpu,
+					   struct kvm_s390_interrupt_info *inti)
+{
+	struct kvm_s390_emerg_info *emerg = &inti->emerg;
+	int rc;
+
+	VCPU_EVENT(vcpu, 4, "%s", "interrupt: sigp emerg");
+	vcpu->stat.deliver_emergency_signal++;
+	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
+					 inti->emerg.code, 0);
+
+	rc  = put_guest_lc(vcpu, EXT_IRQ_EMERGENCY_SIG,
+			   (u16 *)__LC_EXT_INT_CODE);
+	rc |= put_guest_lc(vcpu, emerg->code, (u16 *)__LC_EXT_CPU_ADDR);
+	rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
+			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+	rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
+			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+	return rc;
+}
+
+static int __must_check __deliver_external_call(struct kvm_vcpu *vcpu,
+					   struct kvm_s390_interrupt_info *inti)
+{
+	struct kvm_s390_extcall_info *extcall = &inti->extcall;
+	int rc;
+
+	VCPU_EVENT(vcpu, 4, "%s", "interrupt: sigp ext call");
+	vcpu->stat.deliver_external_call++;
+	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id,
+					 KVM_S390_INT_EXTERNAL_CALL,
+					 extcall->code, 0);
+
+	rc  = put_guest_lc(vcpu, EXT_IRQ_EXTERNAL_CALL,
+			   (u16 *)__LC_EXT_INT_CODE);
+	rc |= put_guest_lc(vcpu, extcall->code, (u16 *)__LC_EXT_CPU_ADDR);
+	rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
+			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+	rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW, &vcpu->arch.sie_block->gpsw,
+			    sizeof(psw_t));
+	return rc;
+}
+
+static int __must_check __deliver_prog(struct kvm_vcpu *vcpu,
+					   struct kvm_s390_interrupt_info *inti)
 {
+	struct kvm_s390_pgm_info *pgm_info = &inti->pgm;
 	int rc = 0;
 	u16 ilc = get_ilc(vcpu);
 
+	VCPU_EVENT(vcpu, 4, "interrupt: pgm check code:%x, ilc:%x",
+		   pgm_info->code, ilc);
+	vcpu->stat.deliver_program_int++;
+	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, KVM_S390_PROGRAM_INT,
+					 pgm_info->code, 0);
+
 	switch (pgm_info->code & ~PGM_PER) {
 	case PGM_AFX_TRANSLATION:
 	case PGM_ASX_TRANSLATION:
@@ -306,202 +475,151 @@ static int __must_check __deliver_prog_irq(struct kvm_vcpu *vcpu,
 			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 	rc |= read_guest_lc(vcpu, __LC_PGM_NEW_PSW,
 			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+	return rc;
+}
+
+static int __must_check __deliver_service(struct kvm_vcpu *vcpu,
+					  struct kvm_s390_interrupt_info *inti)
+{
+	int rc;
+
+	VCPU_EVENT(vcpu, 4, "interrupt: sclp parm:%x",
+		   inti->ext.ext_params);
+	vcpu->stat.deliver_service_signal++;
+	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
+					 inti->ext.ext_params, 0);
+
+	rc  = put_guest_lc(vcpu, EXT_IRQ_SERVICE_SIG, (u16 *)__LC_EXT_INT_CODE);
+	rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
+			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+	rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
+			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+	rc |= put_guest_lc(vcpu, inti->ext.ext_params,
+			   (u32 *)__LC_EXT_PARAMS);
+	return rc;
+}
+
+static int __must_check __deliver_pfault_done(struct kvm_vcpu *vcpu,
+					   struct kvm_s390_interrupt_info *inti)
+{
+	int rc;
+
+	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id,
+					 KVM_S390_INT_PFAULT_DONE, 0,
+					 inti->ext.ext_params2);
 
+	rc  = put_guest_lc(vcpu, EXT_IRQ_CP_SERVICE, (u16 *)__LC_EXT_INT_CODE);
+	rc |= put_guest_lc(vcpu, PFAULT_DONE, (u16 *)__LC_EXT_CPU_ADDR);
+	rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
+			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+	rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
+			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+	rc |= put_guest_lc(vcpu, inti->ext.ext_params2,
+			   (u64 *)__LC_EXT_PARAMS2);
+	return rc;
+}
+
+static int __must_check __deliver_virtio(struct kvm_vcpu *vcpu,
+					 struct kvm_s390_interrupt_info *inti)
+{
+	int rc;
+
+	VCPU_EVENT(vcpu, 4, "interrupt: virtio parm:%x,parm64:%llx",
+		   inti->ext.ext_params, inti->ext.ext_params2);
+	vcpu->stat.deliver_virtio_interrupt++;
+	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
+					 inti->ext.ext_params,
+					 inti->ext.ext_params2);
+
+	rc  = put_guest_lc(vcpu, EXT_IRQ_CP_SERVICE, (u16 *)__LC_EXT_INT_CODE);
+	rc |= put_guest_lc(vcpu, VIRTIO_PARAM, (u16 *)__LC_EXT_CPU_ADDR);
+	rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
+			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+	rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
+			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+	rc |= put_guest_lc(vcpu, inti->ext.ext_params,
+			   (u32 *)__LC_EXT_PARAMS);
+	rc |= put_guest_lc(vcpu, inti->ext.ext_params2,
+			   (u64 *)__LC_EXT_PARAMS2);
+	return rc;
+}
+
+static int __must_check __deliver_io(struct kvm_vcpu *vcpu,
+				     struct kvm_s390_interrupt_info *inti)
+{
+	int rc;
+
+	VCPU_EVENT(vcpu, 4, "interrupt: I/O %llx", inti->type);
+	vcpu->stat.deliver_io_int++;
+	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
+					 ((__u32)inti->io.subchannel_id << 16) |
+						inti->io.subchannel_nr,
+					 ((__u64)inti->io.io_int_parm << 32) |
+						inti->io.io_int_word);
+
+	rc  = put_guest_lc(vcpu, inti->io.subchannel_id,
+			   (u16 *)__LC_SUBCHANNEL_ID);
+	rc |= put_guest_lc(vcpu, inti->io.subchannel_nr,
+			   (u16 *)__LC_SUBCHANNEL_NR);
+	rc |= put_guest_lc(vcpu, inti->io.io_int_parm,
+			   (u32 *)__LC_IO_INT_PARM);
+	rc |= put_guest_lc(vcpu, inti->io.io_int_word,
+			   (u32 *)__LC_IO_INT_WORD);
+	rc |= write_guest_lc(vcpu, __LC_IO_OLD_PSW,
+			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+	rc |= read_guest_lc(vcpu, __LC_IO_NEW_PSW,
+			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 	return rc;
 }
 
 static int __must_check __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 				   struct kvm_s390_interrupt_info *inti)
 {
-	const unsigned short table[] = { 2, 4, 4, 6 };
-	int rc = 0;
+	int rc;
 
 	switch (inti->type) {
 	case KVM_S390_INT_EMERGENCY:
-		VCPU_EVENT(vcpu, 4, "%s", "interrupt: sigp emerg");
-		vcpu->stat.deliver_emergency_signal++;
-		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
-						 inti->emerg.code, 0);
-		rc  = put_guest_lc(vcpu, 0x1201, (u16 *)__LC_EXT_INT_CODE);
-		rc |= put_guest_lc(vcpu, inti->emerg.code,
-				   (u16 *)__LC_EXT_CPU_ADDR);
-		rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
-				     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-		rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
-				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+		rc = __deliver_emergency_signal(vcpu, inti);
 		break;
 	case KVM_S390_INT_EXTERNAL_CALL:
-		VCPU_EVENT(vcpu, 4, "%s", "interrupt: sigp ext call");
-		vcpu->stat.deliver_external_call++;
-		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
-						 inti->extcall.code, 0);
-		rc  = put_guest_lc(vcpu, 0x1202, (u16 *)__LC_EXT_INT_CODE);
-		rc |= put_guest_lc(vcpu, inti->extcall.code,
-				   (u16 *)__LC_EXT_CPU_ADDR);
-		rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
-				     &vcpu->arch.sie_block->gpsw,
-				     sizeof(psw_t));
-		rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
-				    &vcpu->arch.sie_block->gpsw,
-				    sizeof(psw_t));
+		rc = __deliver_external_call(vcpu, inti);
 		break;
 	case KVM_S390_INT_CLOCK_COMP:
-		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
-						 0, 0);
-		rc = deliver_ckc_interrupt(vcpu);
+		rc = __deliver_ckc(vcpu);
 		break;
 	case KVM_S390_INT_CPU_TIMER:
-		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
-						 0, 0);
-		rc  = put_guest_lc(vcpu, EXT_IRQ_CPU_TIMER,
-				   (u16 *)__LC_EXT_INT_CODE);
-		rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
-				     &vcpu->arch.sie_block->gpsw,
-				     sizeof(psw_t));
-		rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
-				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+		rc = __deliver_cpu_timer(vcpu);
 		break;
 	case KVM_S390_INT_SERVICE:
-		VCPU_EVENT(vcpu, 4, "interrupt: sclp parm:%x",
-			   inti->ext.ext_params);
-		vcpu->stat.deliver_service_signal++;
-		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
-						 inti->ext.ext_params, 0);
-		rc  = put_guest_lc(vcpu, 0x2401, (u16 *)__LC_EXT_INT_CODE);
-		rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
-				     &vcpu->arch.sie_block->gpsw,
-				     sizeof(psw_t));
-		rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
-				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-		rc |= put_guest_lc(vcpu, inti->ext.ext_params,
-				   (u32 *)__LC_EXT_PARAMS);
+		rc = __deliver_service(vcpu, inti);
 		break;
 	case KVM_S390_INT_PFAULT_INIT:
-		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type, 0,
-						 inti->ext.ext_params2);
-		rc  = put_guest_lc(vcpu, EXT_IRQ_CP_SERVICE,
-				   (u16 *) __LC_EXT_INT_CODE);
-		rc |= put_guest_lc(vcpu, PFAULT_INIT, (u16 *) __LC_EXT_CPU_ADDR);
-		rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
-				     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-		rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
-				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-		rc |= put_guest_lc(vcpu, inti->ext.ext_params2,
-				   (u64 *) __LC_EXT_PARAMS2);
+		rc = __deliver_pfault_init(vcpu, inti);
 		break;
 	case KVM_S390_INT_PFAULT_DONE:
-		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type, 0,
-						 inti->ext.ext_params2);
-		rc  = put_guest_lc(vcpu, 0x2603, (u16 *)__LC_EXT_INT_CODE);
-		rc |= put_guest_lc(vcpu, PFAULT_DONE, (u16 *)__LC_EXT_CPU_ADDR);
-		rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
-				     &vcpu->arch.sie_block->gpsw,
-				     sizeof(psw_t));
-		rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
-				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-		rc |= put_guest_lc(vcpu, inti->ext.ext_params2,
-				   (u64 *)__LC_EXT_PARAMS2);
+		rc = __deliver_pfault_done(vcpu, inti);
 		break;
 	case KVM_S390_INT_VIRTIO:
-		VCPU_EVENT(vcpu, 4, "interrupt: virtio parm:%x,parm64:%llx",
-			   inti->ext.ext_params, inti->ext.ext_params2);
-		vcpu->stat.deliver_virtio_interrupt++;
-		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
-						 inti->ext.ext_params,
-						 inti->ext.ext_params2);
-		rc  = put_guest_lc(vcpu, 0x2603, (u16 *)__LC_EXT_INT_CODE);
-		rc |= put_guest_lc(vcpu, VIRTIO_PARAM, (u16 *)__LC_EXT_CPU_ADDR);
-		rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
-				     &vcpu->arch.sie_block->gpsw,
-				     sizeof(psw_t));
-		rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
-				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-		rc |= put_guest_lc(vcpu, inti->ext.ext_params,
-				   (u32 *)__LC_EXT_PARAMS);
-		rc |= put_guest_lc(vcpu, inti->ext.ext_params2,
-				   (u64 *)__LC_EXT_PARAMS2);
+		rc = __deliver_virtio(vcpu, inti);
 		break;
 	case KVM_S390_SIGP_STOP:
-		VCPU_EVENT(vcpu, 4, "%s", "interrupt: cpu stop");
-		vcpu->stat.deliver_stop_signal++;
-		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
-						 0, 0);
-		__set_intercept_indicator(vcpu, inti);
+		rc = __deliver_stop(vcpu);
 		break;
-
 	case KVM_S390_SIGP_SET_PREFIX:
-		VCPU_EVENT(vcpu, 4, "interrupt: set prefix to %x",
-			   inti->prefix.address);
-		vcpu->stat.deliver_prefix_signal++;
-		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
-						 inti->prefix.address, 0);
-		kvm_s390_set_prefix(vcpu, inti->prefix.address);
+		rc = __deliver_set_prefix(vcpu, inti);
 		break;
-
 	case KVM_S390_RESTART:
-		VCPU_EVENT(vcpu, 4, "%s", "interrupt: cpu restart");
-		vcpu->stat.deliver_restart_signal++;
-		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
-						 0, 0);
-		rc  = write_guest_lc(vcpu,
-				     offsetof(struct _lowcore, restart_old_psw),
-				     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-		rc |= read_guest_lc(vcpu, offsetof(struct _lowcore, restart_psw),
-				    &vcpu->arch.sie_block->gpsw,
-				    sizeof(psw_t));
+		rc = __deliver_restart(vcpu);
 		break;
 	case KVM_S390_PROGRAM_INT:
-		VCPU_EVENT(vcpu, 4, "interrupt: pgm check code:%x, ilc:%x",
-			   inti->pgm.code,
-			   table[vcpu->arch.sie_block->ipa >> 14]);
-		vcpu->stat.deliver_program_int++;
-		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
-						 inti->pgm.code, 0);
-		rc = __deliver_prog_irq(vcpu, &inti->pgm);
+		rc = __deliver_prog(vcpu, inti);
 		break;
-
 	case KVM_S390_MCHK:
-		VCPU_EVENT(vcpu, 4, "interrupt: machine check mcic=%llx",
-			   inti->mchk.mcic);
-		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
-						 inti->mchk.cr14,
-						 inti->mchk.mcic);
-		rc  = kvm_s390_vcpu_store_status(vcpu,
-						 KVM_S390_STORE_STATUS_PREFIXED);
-		rc |= put_guest_lc(vcpu, inti->mchk.mcic, (u64 *)__LC_MCCK_CODE);
-		rc |= write_guest_lc(vcpu, __LC_MCK_OLD_PSW,
-				     &vcpu->arch.sie_block->gpsw,
-				     sizeof(psw_t));
-		rc |= read_guest_lc(vcpu, __LC_MCK_NEW_PSW,
-				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+		rc = __deliver_machine_check(vcpu, inti);
 		break;
-
 	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
-	{
-		__u32 param0 = ((__u32)inti->io.subchannel_id << 16) |
-			inti->io.subchannel_nr;
-		__u64 param1 = ((__u64)inti->io.io_int_parm << 32) |
-			inti->io.io_int_word;
-		VCPU_EVENT(vcpu, 4, "interrupt: I/O %llx", inti->type);
-		vcpu->stat.deliver_io_int++;
-		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
-						 param0, param1);
-		rc  = put_guest_lc(vcpu, inti->io.subchannel_id,
-				   (u16 *)__LC_SUBCHANNEL_ID);
-		rc |= put_guest_lc(vcpu, inti->io.subchannel_nr,
-				   (u16 *)__LC_SUBCHANNEL_NR);
-		rc |= put_guest_lc(vcpu, inti->io.io_int_parm,
-				   (u32 *)__LC_IO_INT_PARM);
-		rc |= put_guest_lc(vcpu, inti->io.io_int_word,
-				   (u32 *)__LC_IO_INT_WORD);
-		rc |= write_guest_lc(vcpu, __LC_IO_OLD_PSW,
-				     &vcpu->arch.sie_block->gpsw,
-				     sizeof(psw_t));
-		rc |= read_guest_lc(vcpu, __LC_IO_NEW_PSW,
-				    &vcpu->arch.sie_block->gpsw,
-				    sizeof(psw_t));
+		rc = __deliver_io(vcpu, inti);
 		break;
-	}
 	default:
 		BUG();
 	}
@@ -509,19 +627,6 @@ static int __must_check __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 	return rc;
 }
 
-static int __must_check deliver_ckc_interrupt(struct kvm_vcpu *vcpu)
-{
-	int rc;
-
-	rc  = put_guest_lc(vcpu, 0x1004, (u16 __user *)__LC_EXT_INT_CODE);
-	rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
-			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-	rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
-			    &vcpu->arch.sie_block->gpsw,
-			    sizeof(psw_t));
-	return rc;
-}
-
 /* Check whether SIGP interpretation facility has an external call pending */
 int kvm_s390_si_ext_call_pending(struct kvm_vcpu *vcpu)
 {
@@ -691,7 +796,7 @@ int __must_check kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu)
 	}
 
 	if (!rc && kvm_cpu_has_pending_timer(vcpu))
-		rc = deliver_ckc_interrupt(vcpu);
+		rc = __deliver_ckc(vcpu);
 
 	if (!rc && atomic_read(&fi->active)) {
 		do {
-- 
1.9.3
