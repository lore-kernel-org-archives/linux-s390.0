From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 15/47] KVM: s390: convert __do_deliver_interrupt()
Date: Tue, 15 Apr 2014 14:00:18 +0200
Message-ID: <1397563250-3089-16-git-send-email-borntraeger@de.ibm.com>
References: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Convert __do_deliver_interrupt() to new guest access functions.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 82 +++++++++++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 38 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index a44c689..cb782e3 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -213,13 +213,14 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 		vcpu->stat.deliver_service_signal++;
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
 						 inti->ext.ext_params, 0);
-		rc  = put_guest(vcpu, 0x2401, (u16 __user *)__LC_EXT_INT_CODE);
-		rc |= copy_to_guest(vcpu, __LC_EXT_OLD_PSW,
+		rc  = put_guest_lc(vcpu, 0x2401, (u16 *)__LC_EXT_INT_CODE);
+		rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
+				     &vcpu->arch.sie_block->gpsw,
+				     sizeof(psw_t));
+		rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
 				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
-				      __LC_EXT_NEW_PSW, sizeof(psw_t));
-		rc |= put_guest(vcpu, inti->ext.ext_params,
-				(u32 __user *)__LC_EXT_PARAMS);
+		rc |= put_guest_lc(vcpu, inti->ext.ext_params,
+				   (u32 *)__LC_EXT_PARAMS);
 		break;
 	case KVM_S390_INT_PFAULT_INIT:
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type, 0,
@@ -236,14 +237,15 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 	case KVM_S390_INT_PFAULT_DONE:
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type, 0,
 						 inti->ext.ext_params2);
-		rc  = put_guest(vcpu, 0x2603, (u16 __user *) __LC_EXT_INT_CODE);
-		rc |= put_guest(vcpu, 0x0680, (u16 __user *) __LC_EXT_CPU_ADDR);
-		rc |= copy_to_guest(vcpu, __LC_EXT_OLD_PSW,
+		rc  = put_guest_lc(vcpu, 0x2603, (u16 *)__LC_EXT_INT_CODE);
+		rc |= put_guest_lc(vcpu, 0x0680, (u16 *)__LC_EXT_CPU_ADDR);
+		rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
+				     &vcpu->arch.sie_block->gpsw,
+				     sizeof(psw_t));
+		rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
 				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
-				      __LC_EXT_NEW_PSW, sizeof(psw_t));
-		rc |= put_guest(vcpu, inti->ext.ext_params2,
-				(u64 __user *) __LC_EXT_PARAMS2);
+		rc |= put_guest_lc(vcpu, inti->ext.ext_params2,
+				   (u64 *)__LC_EXT_PARAMS2);
 		break;
 	case KVM_S390_INT_VIRTIO:
 		VCPU_EVENT(vcpu, 4, "interrupt: virtio parm:%x,parm64:%llx",
@@ -252,16 +254,17 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
 						 inti->ext.ext_params,
 						 inti->ext.ext_params2);
-		rc  = put_guest(vcpu, 0x2603, (u16 __user *)__LC_EXT_INT_CODE);
-		rc |= put_guest(vcpu, 0x0d00, (u16 __user *)__LC_EXT_CPU_ADDR);
-		rc |= copy_to_guest(vcpu, __LC_EXT_OLD_PSW,
+		rc  = put_guest_lc(vcpu, 0x2603, (u16 *)__LC_EXT_INT_CODE);
+		rc |= put_guest_lc(vcpu, 0x0d00, (u16 *)__LC_EXT_CPU_ADDR);
+		rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
+				     &vcpu->arch.sie_block->gpsw,
+				     sizeof(psw_t));
+		rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
 				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
-				      __LC_EXT_NEW_PSW, sizeof(psw_t));
-		rc |= put_guest(vcpu, inti->ext.ext_params,
-				(u32 __user *)__LC_EXT_PARAMS);
-		rc |= put_guest(vcpu, inti->ext.ext_params2,
-				(u64 __user *)__LC_EXT_PARAMS2);
+		rc |= put_guest_lc(vcpu, inti->ext.ext_params,
+				   (u32 *)__LC_EXT_PARAMS);
+		rc |= put_guest_lc(vcpu, inti->ext.ext_params2,
+				   (u64 *)__LC_EXT_PARAMS2);
 		break;
 	case KVM_S390_SIGP_STOP:
 		VCPU_EVENT(vcpu, 4, "%s", "interrupt: cpu stop");
@@ -317,11 +320,12 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 						 inti->mchk.mcic);
 		rc  = kvm_s390_vcpu_store_status(vcpu,
 						 KVM_S390_STORE_STATUS_PREFIXED);
-		rc |= put_guest(vcpu, inti->mchk.mcic, (u64 __user *) __LC_MCCK_CODE);
-		rc |= copy_to_guest(vcpu, __LC_MCK_OLD_PSW,
+		rc |= put_guest_lc(vcpu, inti->mchk.mcic, (u64 *)__LC_MCCK_CODE);
+		rc |= write_guest_lc(vcpu, __LC_MCK_OLD_PSW,
+				     &vcpu->arch.sie_block->gpsw,
+				     sizeof(psw_t));
+		rc |= read_guest_lc(vcpu, __LC_MCK_NEW_PSW,
 				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
-				      __LC_MCK_NEW_PSW, sizeof(psw_t));
 		break;
 
 	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
@@ -334,18 +338,20 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 		vcpu->stat.deliver_io_int++;
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
 						 param0, param1);
-		rc  = put_guest(vcpu, inti->io.subchannel_id,
-				(u16 __user *) __LC_SUBCHANNEL_ID);
-		rc |= put_guest(vcpu, inti->io.subchannel_nr,
-				(u16 __user *) __LC_SUBCHANNEL_NR);
-		rc |= put_guest(vcpu, inti->io.io_int_parm,
-				(u32 __user *) __LC_IO_INT_PARM);
-		rc |= put_guest(vcpu, inti->io.io_int_word,
-				(u32 __user *) __LC_IO_INT_WORD);
-		rc |= copy_to_guest(vcpu, __LC_IO_OLD_PSW,
-				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
-				      __LC_IO_NEW_PSW, sizeof(psw_t));
+		rc  = put_guest_lc(vcpu, inti->io.subchannel_id,
+				   (u16 *)__LC_SUBCHANNEL_ID);
+		rc |= put_guest_lc(vcpu, inti->io.subchannel_nr,
+				   (u16 *)__LC_SUBCHANNEL_NR);
+		rc |= put_guest_lc(vcpu, inti->io.io_int_parm,
+				   (u32 *)__LC_IO_INT_PARM);
+		rc |= put_guest_lc(vcpu, inti->io.io_int_word,
+				   (u32 *)__LC_IO_INT_WORD);
+		rc |= write_guest_lc(vcpu, __LC_IO_OLD_PSW,
+				     &vcpu->arch.sie_block->gpsw,
+				     sizeof(psw_t));
+		rc |= read_guest_lc(vcpu, __LC_IO_NEW_PSW,
+				    &vcpu->arch.sie_block->gpsw,
+				    sizeof(psw_t));
 		break;
 	}
 	default:
-- 
1.8.4.2
