From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 38/47] KVM: s390: deliver program irq parameters and use correct ilc
Date: Tue, 15 Apr 2014 14:00:41 +0200
Message-ID: <1397563250-3089-39-git-send-email-borntraeger@de.ibm.com>
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

When a program interrupt was to be delivered until now, no program interrupt
parameters were stored in the low-core of the target vcpu.

This patch enables the delivery of those program interrupt parameters, takes
care of concurrent PER events which can be injected in addition to any program
interrupt and uses the correct instruction length code (depending on the
interception code) for the injection of program interrupts.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |   6 +++
 arch/s390/kvm/interrupt.c        | 110 +++++++++++++++++++++++++++++++++++----
 2 files changed, 107 insertions(+), 9 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index b8c8081..5e5a14d 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -102,6 +102,12 @@ struct kvm_s390_sie_block {
 #define ICTL_RRBE 0x00001000
 	__u32	ictl;			/* 0x0048 */
 	__u32	eca;			/* 0x004c */
+#define ICPT_INST	0x04
+#define ICPT_PROGI	0x08
+#define ICPT_INSTPROGI	0x0C
+#define ICPT_OPEREXC	0x2C
+#define ICPT_PARTEXEC	0x38
+#define ICPT_IOINST	0x40
 	__u8	icptcode;		/* 0x0050 */
 	__u8	reserved51;		/* 0x0051 */
 	__u16	ihcpu;			/* 0x0052 */
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 1c74bb9..c49b4d4 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -174,6 +174,106 @@ static void __set_intercept_indicator(struct kvm_vcpu *vcpu,
 	}
 }
 
+static int __deliver_prog_irq(struct kvm_vcpu *vcpu,
+			      struct kvm_s390_pgm_info *pgm_info)
+{
+	const unsigned short table[] = { 2, 4, 4, 6 };
+	int rc = 0;
+
+	switch (pgm_info->code & ~PGM_PER) {
+	case PGM_AFX_TRANSLATION:
+	case PGM_ASX_TRANSLATION:
+	case PGM_EX_TRANSLATION:
+	case PGM_LFX_TRANSLATION:
+	case PGM_LSTE_SEQUENCE:
+	case PGM_LSX_TRANSLATION:
+	case PGM_LX_TRANSLATION:
+	case PGM_PRIMARY_AUTHORITY:
+	case PGM_SECONDARY_AUTHORITY:
+	case PGM_SPACE_SWITCH:
+		rc = put_guest_lc(vcpu, pgm_info->trans_exc_code,
+				  (u64 *)__LC_TRANS_EXC_CODE);
+		break;
+	case PGM_ALEN_TRANSLATION:
+	case PGM_ALE_SEQUENCE:
+	case PGM_ASTE_INSTANCE:
+	case PGM_ASTE_SEQUENCE:
+	case PGM_ASTE_VALIDITY:
+	case PGM_EXTENDED_AUTHORITY:
+		rc = put_guest_lc(vcpu, pgm_info->exc_access_id,
+				  (u8 *)__LC_EXC_ACCESS_ID);
+		break;
+	case PGM_ASCE_TYPE:
+	case PGM_PAGE_TRANSLATION:
+	case PGM_REGION_FIRST_TRANS:
+	case PGM_REGION_SECOND_TRANS:
+	case PGM_REGION_THIRD_TRANS:
+	case PGM_SEGMENT_TRANSLATION:
+		rc = put_guest_lc(vcpu, pgm_info->trans_exc_code,
+				  (u64 *)__LC_TRANS_EXC_CODE);
+		rc |= put_guest_lc(vcpu, pgm_info->exc_access_id,
+				   (u8 *)__LC_EXC_ACCESS_ID);
+		rc |= put_guest_lc(vcpu, pgm_info->op_access_id,
+				   (u8 *)__LC_OP_ACCESS_ID);
+		break;
+	case PGM_MONITOR:
+		rc = put_guest_lc(vcpu, pgm_info->mon_class_nr,
+				  (u64 *)__LC_MON_CLASS_NR);
+		rc |= put_guest_lc(vcpu, pgm_info->mon_code,
+				   (u64 *)__LC_MON_CODE);
+		break;
+	case PGM_DATA:
+		rc = put_guest_lc(vcpu, pgm_info->data_exc_code,
+				  (u32 *)__LC_DATA_EXC_CODE);
+		break;
+	case PGM_PROTECTION:
+		rc = put_guest_lc(vcpu, pgm_info->trans_exc_code,
+				  (u64 *)__LC_TRANS_EXC_CODE);
+		rc |= put_guest_lc(vcpu, pgm_info->exc_access_id,
+				   (u8 *)__LC_EXC_ACCESS_ID);
+		break;
+	}
+
+	if (pgm_info->code & PGM_PER) {
+		rc |= put_guest_lc(vcpu, pgm_info->per_code,
+				   (u8 *) __LC_PER_CODE);
+		rc |= put_guest_lc(vcpu, pgm_info->per_atmid,
+				   (u8 *)__LC_PER_ATMID);
+		rc |= put_guest_lc(vcpu, pgm_info->per_address,
+				   (u64 *) __LC_PER_ADDRESS);
+		rc |= put_guest_lc(vcpu, pgm_info->per_access_id,
+				   (u8 *) __LC_PER_ACCESS_ID);
+	}
+
+	switch (vcpu->arch.sie_block->icptcode) {
+	case ICPT_INST:
+	case ICPT_INSTPROGI:
+	case ICPT_OPEREXC:
+	case ICPT_PARTEXEC:
+	case ICPT_IOINST:
+		/* last instruction only stored for these icptcodes */
+		rc |= put_guest_lc(vcpu, table[vcpu->arch.sie_block->ipa >> 14],
+				   (u16 *) __LC_PGM_ILC);
+		break;
+	case ICPT_PROGI:
+		rc |= put_guest_lc(vcpu, vcpu->arch.sie_block->pgmilc,
+				   (u16 *) __LC_PGM_ILC);
+		break;
+	default:
+		rc |= put_guest_lc(vcpu, 0,
+				   (u16 *) __LC_PGM_ILC);
+	}
+
+	rc |= put_guest_lc(vcpu, pgm_info->code,
+			   (u16 *)__LC_PGM_INT_CODE);
+	rc |= write_guest_lc(vcpu, __LC_PGM_OLD_PSW,
+			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+	rc |= read_guest_lc(vcpu, __LC_PGM_NEW_PSW,
+			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+
+	return rc;
+}
+
 static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 				   struct kvm_s390_interrupt_info *inti)
 {
@@ -305,15 +405,7 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 		vcpu->stat.deliver_program_int++;
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
 						 inti->pgm.code, 0);
-		rc  = put_guest_lc(vcpu, inti->pgm.code,
-				   (u16 __user *)__LC_PGM_INT_CODE);
-		rc |= put_guest_lc(vcpu, table[vcpu->arch.sie_block->ipa >> 14],
-				   (u16 __user *)__LC_PGM_ILC);
-		rc |= write_guest_lc(vcpu, __LC_PGM_OLD_PSW,
-				     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-		rc |= read_guest_lc(vcpu, __LC_PGM_NEW_PSW,
-				    &vcpu->arch.sie_block->gpsw,
-				    sizeof(psw_t));
+		rc = __deliver_prog_irq(vcpu, &inti->pgm);
 		break;
 
 	case KVM_S390_MCHK:
-- 
1.8.4.2
