From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 16/47] KVM: s390: convert local irqs in  __do_deliver_interrupt()
Date: Tue, 15 Apr 2014 14:00:19 +0200
Message-ID: <1397563250-3089-17-git-send-email-borntraeger@de.ibm.com>
References: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jens Freimann <jfrei@linux.vnet.ibm.com>

Convert local irqs in __do_deliver_interrupt() to new guest
access functions.

Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 81 +++++++++++++++++++++++++----------------------
 1 file changed, 43 insertions(+), 38 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index cb782e3..a1403ba 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -186,26 +186,28 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 		vcpu->stat.deliver_emergency_signal++;
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
 						 inti->emerg.code, 0);
-		rc  = put_guest(vcpu, 0x1201, (u16 __user *)__LC_EXT_INT_CODE);
-		rc |= put_guest(vcpu, inti->emerg.code,
-				(u16 __user *)__LC_EXT_CPU_ADDR);
-		rc |= copy_to_guest(vcpu, __LC_EXT_OLD_PSW,
+		rc  = put_guest_lc(vcpu, 0x1201, (u16 *)__LC_EXT_INT_CODE);
+		rc |= put_guest_lc(vcpu, inti->emerg.code,
+				   (u16 *)__LC_EXT_CPU_ADDR);
+		rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
+				     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+		rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
 				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
-				      __LC_EXT_NEW_PSW, sizeof(psw_t));
 		break;
 	case KVM_S390_INT_EXTERNAL_CALL:
 		VCPU_EVENT(vcpu, 4, "%s", "interrupt: sigp ext call");
 		vcpu->stat.deliver_external_call++;
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
 						 inti->extcall.code, 0);
-		rc  = put_guest(vcpu, 0x1202, (u16 __user *)__LC_EXT_INT_CODE);
-		rc |= put_guest(vcpu, inti->extcall.code,
-				(u16 __user *)__LC_EXT_CPU_ADDR);
-		rc |= copy_to_guest(vcpu, __LC_EXT_OLD_PSW,
-				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
-				      __LC_EXT_NEW_PSW, sizeof(psw_t));
+		rc  = put_guest_lc(vcpu, 0x1202, (u16 *)__LC_EXT_INT_CODE);
+		rc |= put_guest_lc(vcpu, inti->extcall.code,
+				   (u16 *)__LC_EXT_CPU_ADDR);
+		rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
+				     &vcpu->arch.sie_block->gpsw,
+				     sizeof(psw_t));
+		rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
+				    &vcpu->arch.sie_block->gpsw,
+				    sizeof(psw_t));
 		break;
 	case KVM_S390_INT_SERVICE:
 		VCPU_EVENT(vcpu, 4, "interrupt: sclp parm:%x",
@@ -225,14 +227,14 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 	case KVM_S390_INT_PFAULT_INIT:
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type, 0,
 						 inti->ext.ext_params2);
-		rc  = put_guest(vcpu, 0x2603, (u16 __user *) __LC_EXT_INT_CODE);
-		rc |= put_guest(vcpu, 0x0600, (u16 __user *) __LC_EXT_CPU_ADDR);
-		rc |= copy_to_guest(vcpu, __LC_EXT_OLD_PSW,
+		rc  = put_guest_lc(vcpu, 0x2603, (u16 *) __LC_EXT_INT_CODE);
+		rc |= put_guest_lc(vcpu, 0x0600, (u16 *) __LC_EXT_CPU_ADDR);
+		rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
+				     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+		rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
 				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
-				      __LC_EXT_NEW_PSW, sizeof(psw_t));
-		rc |= put_guest(vcpu, inti->ext.ext_params2,
-				(u64 __user *) __LC_EXT_PARAMS2);
+		rc |= put_guest_lc(vcpu, inti->ext.ext_params2,
+				   (u64 *) __LC_EXT_PARAMS2);
 		break;
 	case KVM_S390_INT_PFAULT_DONE:
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type, 0,
@@ -288,12 +290,12 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 		vcpu->stat.deliver_restart_signal++;
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
 						 0, 0);
-		rc  = copy_to_guest(vcpu,
-				    offsetof(struct _lowcore, restart_old_psw),
-				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
-				      offsetof(struct _lowcore, restart_psw),
-				      sizeof(psw_t));
+		rc  = write_guest_lc(vcpu,
+				     offsetof(struct _lowcore, restart_old_psw),
+				     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+		rc |= read_guest_lc(vcpu, offsetof(struct _lowcore, restart_psw),
+				    &vcpu->arch.sie_block->gpsw,
+				    sizeof(psw_t));
 		atomic_clear_mask(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
 		break;
 	case KVM_S390_PROGRAM_INT:
@@ -303,13 +305,15 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 		vcpu->stat.deliver_program_int++;
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
 						 inti->pgm.code, 0);
-		rc  = put_guest(vcpu, inti->pgm.code, (u16 __user *)__LC_PGM_INT_CODE);
-		rc |= put_guest(vcpu, table[vcpu->arch.sie_block->ipa >> 14],
-				(u16 __user *)__LC_PGM_ILC);
-		rc |= copy_to_guest(vcpu, __LC_PGM_OLD_PSW,
-				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
-				      __LC_PGM_NEW_PSW, sizeof(psw_t));
+		rc  = put_guest_lc(vcpu, inti->pgm.code,
+				   (u16 __user *)__LC_PGM_INT_CODE);
+		rc |= put_guest_lc(vcpu, table[vcpu->arch.sie_block->ipa >> 14],
+				   (u16 __user *)__LC_PGM_ILC);
+		rc |= write_guest_lc(vcpu, __LC_PGM_OLD_PSW,
+				     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+		rc |= read_guest_lc(vcpu, __LC_PGM_NEW_PSW,
+				    &vcpu->arch.sie_block->gpsw,
+				    sizeof(psw_t));
 		break;
 
 	case KVM_S390_MCHK:
@@ -372,11 +376,12 @@ static int __try_deliver_ckc_interrupt(struct kvm_vcpu *vcpu)
 		return 0;
 	if (!(vcpu->arch.sie_block->gcr[0] & 0x800ul))
 		return 0;
-	rc  = put_guest(vcpu, 0x1004, (u16 __user *)__LC_EXT_INT_CODE);
-	rc |= copy_to_guest(vcpu, __LC_EXT_OLD_PSW,
-			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-	rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
-			      __LC_EXT_NEW_PSW, sizeof(psw_t));
+	rc  = put_guest_lc(vcpu, 0x1004, (u16 __user *)__LC_EXT_INT_CODE);
+	rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
+			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+	rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
+			    &vcpu->arch.sie_block->gpsw,
+			    sizeof(psw_t));
 	if (rc) {
 		printk("kvm: The guest lowcore is not mapped during interrupt "
 			"delivery, killing userspace\n");
-- 
1.8.4.2
