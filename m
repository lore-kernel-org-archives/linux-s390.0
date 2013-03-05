From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4/8] s390/kvm: remove explicit -EFAULT return code checking on guest access
Date: Tue,  5 Mar 2013 13:14:43 +0100
Message-ID: <1362485687-2799-5-git-send-email-borntraeger@de.ibm.com>
References: <1362485687-2799-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1362485687-2799-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tossati <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Let's change to the paradigm that every return code from guest memory
access functions that is not zero translates to -EFAULT and do not
explictly compare.
Explictly comparing the return value with -EFAULT has already shown to
be a bit fragile. In addition this is closer to the handling of
copy_to/from_user functions, which imho is in general a good idea.

Also shorten the return code handling in interrupt.c a bit.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/intercept.c |   4 +-
 arch/s390/kvm/interrupt.c | 241 +++++++++++++---------------------------------
 arch/s390/kvm/priv.c      |   6 +-
 3 files changed, 74 insertions(+), 177 deletions(-)

diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index f26ff1e..9b22047 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -45,7 +45,7 @@ static int handle_lctlg(struct kvm_vcpu *vcpu)
 	do {
 		rc = get_guest_u64(vcpu, useraddr,
 				   &vcpu->arch.sie_block->gcr[reg]);
-		if (rc == -EFAULT) {
+		if (rc) {
 			kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 			break;
 		}
@@ -79,7 +79,7 @@ static int handle_lctl(struct kvm_vcpu *vcpu)
 	reg = reg1;
 	do {
 		rc = get_guest_u32(vcpu, useraddr, &val);
-		if (rc == -EFAULT) {
+		if (rc) {
 			kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 			break;
 		}
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 37116a7..5afa931 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -180,7 +180,7 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 				   struct kvm_s390_interrupt_info *inti)
 {
 	const unsigned short table[] = { 2, 4, 4, 6 };
-	int rc, exception = 0;
+	int rc = 0;
 
 	switch (inti->type) {
 	case KVM_S390_INT_EMERGENCY:
@@ -188,74 +188,38 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 		vcpu->stat.deliver_emergency_signal++;
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
 						 inti->emerg.code, 0);
-		rc = put_guest_u16(vcpu, __LC_EXT_INT_CODE, 0x1201);
-		if (rc == -EFAULT)
-			exception = 1;
-
-		rc = put_guest_u16(vcpu, __LC_EXT_CPU_ADDR, inti->emerg.code);
-		if (rc == -EFAULT)
-			exception = 1;
-
-		rc = copy_to_guest(vcpu, __LC_EXT_OLD_PSW,
-			 &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-		if (rc == -EFAULT)
-			exception = 1;
-
-		rc = copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
-			__LC_EXT_NEW_PSW, sizeof(psw_t));
-		if (rc == -EFAULT)
-			exception = 1;
+		rc  = put_guest_u16(vcpu, __LC_EXT_INT_CODE, 0x1201);
+		rc |= put_guest_u16(vcpu, __LC_EXT_CPU_ADDR, inti->emerg.code);
+		rc |= copy_to_guest(vcpu, __LC_EXT_OLD_PSW,
+				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
+				      __LC_EXT_NEW_PSW, sizeof(psw_t));
 		break;
-
 	case KVM_S390_INT_EXTERNAL_CALL:
 		VCPU_EVENT(vcpu, 4, "%s", "interrupt: sigp ext call");
 		vcpu->stat.deliver_external_call++;
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
 						 inti->extcall.code, 0);
-		rc = put_guest_u16(vcpu, __LC_EXT_INT_CODE, 0x1202);
-		if (rc == -EFAULT)
-			exception = 1;
-
-		rc = put_guest_u16(vcpu, __LC_EXT_CPU_ADDR, inti->extcall.code);
-		if (rc == -EFAULT)
-			exception = 1;
-
-		rc = copy_to_guest(vcpu, __LC_EXT_OLD_PSW,
-			 &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-		if (rc == -EFAULT)
-			exception = 1;
-
-		rc = copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
-			__LC_EXT_NEW_PSW, sizeof(psw_t));
-		if (rc == -EFAULT)
-			exception = 1;
+		rc  = put_guest_u16(vcpu, __LC_EXT_INT_CODE, 0x1202);
+		rc |= put_guest_u16(vcpu, __LC_EXT_CPU_ADDR, inti->extcall.code);
+		rc |= copy_to_guest(vcpu, __LC_EXT_OLD_PSW,
+				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
+				      __LC_EXT_NEW_PSW, sizeof(psw_t));
 		break;
-
 	case KVM_S390_INT_SERVICE:
 		VCPU_EVENT(vcpu, 4, "interrupt: sclp parm:%x",
 			   inti->ext.ext_params);
 		vcpu->stat.deliver_service_signal++;
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
 						 inti->ext.ext_params, 0);
-		rc = put_guest_u16(vcpu, __LC_EXT_INT_CODE, 0x2401);
-		if (rc == -EFAULT)
-			exception = 1;
-
-		rc = copy_to_guest(vcpu, __LC_EXT_OLD_PSW,
-			 &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-		if (rc == -EFAULT)
-			exception = 1;
-
-		rc = copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
-			__LC_EXT_NEW_PSW, sizeof(psw_t));
-		if (rc == -EFAULT)
-			exception = 1;
-
-		rc = put_guest_u32(vcpu, __LC_EXT_PARAMS, inti->ext.ext_params);
-		if (rc == -EFAULT)
-			exception = 1;
+		rc  = put_guest_u16(vcpu, __LC_EXT_INT_CODE, 0x2401);
+		rc |= copy_to_guest(vcpu, __LC_EXT_OLD_PSW,
+				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
+				      __LC_EXT_NEW_PSW, sizeof(psw_t));
+		rc |= put_guest_u32(vcpu, __LC_EXT_PARAMS, inti->ext.ext_params);
 		break;
-
 	case KVM_S390_INT_VIRTIO:
 		VCPU_EVENT(vcpu, 4, "interrupt: virtio parm:%x,parm64:%llx",
 			   inti->ext.ext_params, inti->ext.ext_params2);
@@ -263,34 +227,16 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
 						 inti->ext.ext_params,
 						 inti->ext.ext_params2);
-		rc = put_guest_u16(vcpu, __LC_EXT_INT_CODE, 0x2603);
-		if (rc == -EFAULT)
-			exception = 1;
-
-		rc = put_guest_u16(vcpu, __LC_EXT_CPU_ADDR, 0x0d00);
-		if (rc == -EFAULT)
-			exception = 1;
-
-		rc = copy_to_guest(vcpu, __LC_EXT_OLD_PSW,
-			 &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-		if (rc == -EFAULT)
-			exception = 1;
-
-		rc = copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
-			__LC_EXT_NEW_PSW, sizeof(psw_t));
-		if (rc == -EFAULT)
-			exception = 1;
-
-		rc = put_guest_u32(vcpu, __LC_EXT_PARAMS, inti->ext.ext_params);
-		if (rc == -EFAULT)
-			exception = 1;
-
-		rc = put_guest_u64(vcpu, __LC_EXT_PARAMS2,
-				   inti->ext.ext_params2);
-		if (rc == -EFAULT)
-			exception = 1;
+		rc  = put_guest_u16(vcpu, __LC_EXT_INT_CODE, 0x2603);
+		rc |= put_guest_u16(vcpu, __LC_EXT_CPU_ADDR, 0x0d00);
+		rc |= copy_to_guest(vcpu, __LC_EXT_OLD_PSW,
+				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
+				      __LC_EXT_NEW_PSW, sizeof(psw_t));
+		rc |= put_guest_u32(vcpu, __LC_EXT_PARAMS, inti->ext.ext_params);
+		rc |= put_guest_u64(vcpu, __LC_EXT_PARAMS2,
+				    inti->ext.ext_params2);
 		break;
-
 	case KVM_S390_SIGP_STOP:
 		VCPU_EVENT(vcpu, 4, "%s", "interrupt: cpu stop");
 		vcpu->stat.deliver_stop_signal++;
@@ -313,18 +259,14 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 		vcpu->stat.deliver_restart_signal++;
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
 						 0, 0);
-		rc = copy_to_guest(vcpu, offsetof(struct _lowcore,
-		  restart_old_psw), &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-		if (rc == -EFAULT)
-			exception = 1;
-
-		rc = copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
-			offsetof(struct _lowcore, restart_psw), sizeof(psw_t));
-		if (rc == -EFAULT)
-			exception = 1;
+		rc  = copy_to_guest(vcpu,
+				    offsetof(struct _lowcore, restart_old_psw),
+				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
+				      offsetof(struct _lowcore, restart_psw),
+				      sizeof(psw_t));
 		atomic_clear_mask(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
 		break;
-
 	case KVM_S390_PROGRAM_INT:
 		VCPU_EVENT(vcpu, 4, "interrupt: pgm check code:%x, ilc:%x",
 			   inti->pgm.code,
@@ -332,24 +274,13 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 		vcpu->stat.deliver_program_int++;
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
 						 inti->pgm.code, 0);
-		rc = put_guest_u16(vcpu, __LC_PGM_INT_CODE, inti->pgm.code);
-		if (rc == -EFAULT)
-			exception = 1;
-
-		rc = put_guest_u16(vcpu, __LC_PGM_ILC,
-			table[vcpu->arch.sie_block->ipa >> 14]);
-		if (rc == -EFAULT)
-			exception = 1;
-
-		rc = copy_to_guest(vcpu, __LC_PGM_OLD_PSW,
-			 &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-		if (rc == -EFAULT)
-			exception = 1;
-
-		rc = copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
-			__LC_PGM_NEW_PSW, sizeof(psw_t));
-		if (rc == -EFAULT)
-			exception = 1;
+		rc  = put_guest_u16(vcpu, __LC_PGM_INT_CODE, inti->pgm.code);
+		rc |= put_guest_u16(vcpu, __LC_PGM_ILC,
+				    table[vcpu->arch.sie_block->ipa >> 14]);
+		rc |= copy_to_guest(vcpu, __LC_PGM_OLD_PSW,
+				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
+				      __LC_PGM_NEW_PSW, sizeof(psw_t));
 		break;
 
 	case KVM_S390_MCHK:
@@ -358,24 +289,13 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
 						 inti->mchk.cr14,
 						 inti->mchk.mcic);
-		rc = kvm_s390_vcpu_store_status(vcpu,
-						KVM_S390_STORE_STATUS_PREFIXED);
-		if (rc == -EFAULT)
-			exception = 1;
-
-		rc = put_guest_u64(vcpu, __LC_MCCK_CODE, inti->mchk.mcic);
-		if (rc == -EFAULT)
-			exception = 1;
-
-		rc = copy_to_guest(vcpu, __LC_MCK_OLD_PSW,
-				   &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-		if (rc == -EFAULT)
-			exception = 1;
-
-		rc = copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
-				     __LC_MCK_NEW_PSW, sizeof(psw_t));
-		if (rc == -EFAULT)
-			exception = 1;
+		rc  = kvm_s390_vcpu_store_status(vcpu,
+						 KVM_S390_STORE_STATUS_PREFIXED);
+		rc |= put_guest_u64(vcpu, __LC_MCCK_CODE, inti->mchk.mcic);
+		rc |= copy_to_guest(vcpu, __LC_MCK_OLD_PSW,
+				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
+				      __LC_MCK_NEW_PSW, sizeof(psw_t));
 		break;
 
 	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
@@ -388,67 +308,44 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 		vcpu->stat.deliver_io_int++;
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
 						 param0, param1);
-		rc = put_guest_u16(vcpu, __LC_SUBCHANNEL_ID,
-				   inti->io.subchannel_id);
-		if (rc == -EFAULT)
-			exception = 1;
-
-		rc = put_guest_u16(vcpu, __LC_SUBCHANNEL_NR,
-				   inti->io.subchannel_nr);
-		if (rc == -EFAULT)
-			exception = 1;
-
-		rc = put_guest_u32(vcpu, __LC_IO_INT_PARM,
-				   inti->io.io_int_parm);
-		if (rc == -EFAULT)
-			exception = 1;
-
-		rc = put_guest_u32(vcpu, __LC_IO_INT_WORD,
-				   inti->io.io_int_word);
-		if (rc == -EFAULT)
-			exception = 1;
-
-		rc = copy_to_guest(vcpu, __LC_IO_OLD_PSW,
-				   &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-		if (rc == -EFAULT)
-			exception = 1;
-
-		rc = copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
-				     __LC_IO_NEW_PSW, sizeof(psw_t));
-		if (rc == -EFAULT)
-			exception = 1;
+		rc  = put_guest_u16(vcpu, __LC_SUBCHANNEL_ID,
+				    inti->io.subchannel_id);
+		rc |= put_guest_u16(vcpu, __LC_SUBCHANNEL_NR,
+				    inti->io.subchannel_nr);
+		rc |= put_guest_u32(vcpu, __LC_IO_INT_PARM,
+				    inti->io.io_int_parm);
+		rc |= put_guest_u32(vcpu, __LC_IO_INT_WORD,
+				    inti->io.io_int_word);
+		rc |= copy_to_guest(vcpu, __LC_IO_OLD_PSW,
+				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
+				      __LC_IO_NEW_PSW, sizeof(psw_t));
 		break;
 	}
 	default:
 		BUG();
 	}
-	if (exception) {
+	if (rc) {
 		printk("kvm: The guest lowcore is not mapped during interrupt "
-			"delivery, killing userspace\n");
+		       "delivery, killing userspace\n");
 		do_exit(SIGKILL);
 	}
 }
 
 static int __try_deliver_ckc_interrupt(struct kvm_vcpu *vcpu)
 {
-	int rc, exception = 0;
+	int rc;
 
 	if (psw_extint_disabled(vcpu))
 		return 0;
 	if (!(vcpu->arch.sie_block->gcr[0] & 0x800ul))
 		return 0;
-	rc = put_guest_u16(vcpu, __LC_EXT_INT_CODE, 0x1004);
-	if (rc == -EFAULT)
-		exception = 1;
-	rc = copy_to_guest(vcpu, __LC_EXT_OLD_PSW,
-		 &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-	if (rc == -EFAULT)
-		exception = 1;
-	rc = copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
-		__LC_EXT_NEW_PSW, sizeof(psw_t));
-	if (rc == -EFAULT)
-		exception = 1;
-	if (exception) {
+	rc  = put_guest_u16(vcpu, __LC_EXT_INT_CODE, 0x1004);
+	rc |= copy_to_guest(vcpu, __LC_EXT_OLD_PSW,
+			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+	rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
+			      __LC_EXT_NEW_PSW, sizeof(psw_t));
+	if (rc) {
 		printk("kvm: The guest lowcore is not mapped during interrupt "
 			"delivery, killing userspace\n");
 		do_exit(SIGKILL);
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 75ad91e..34b42dc 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -108,7 +108,7 @@ static int handle_store_cpu_address(struct kvm_vcpu *vcpu)
 	}
 
 	rc = put_guest_u16(vcpu, useraddr, vcpu->vcpu_id);
-	if (rc == -EFAULT) {
+	if (rc) {
 		kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 		goto out;
 	}
@@ -230,7 +230,7 @@ static int handle_stfl(struct kvm_vcpu *vcpu)
 
 	rc = copy_to_guest(vcpu, offsetof(struct _lowcore, stfl_fac_list),
 			   &facility_list, sizeof(facility_list));
-	if (rc == -EFAULT)
+	if (rc)
 		kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 	else {
 		VCPU_EVENT(vcpu, 5, "store facility list value %x",
@@ -348,7 +348,7 @@ static int handle_stidp(struct kvm_vcpu *vcpu)
 	}
 
 	rc = put_guest_u64(vcpu, operand2, vcpu->arch.stidp_data);
-	if (rc == -EFAULT) {
+	if (rc) {
 		kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 		goto out;
 	}
-- 
1.8.0.1
