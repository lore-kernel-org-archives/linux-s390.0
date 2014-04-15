From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 37/47] KVM: s390: extract irq parameters of intercepted program irqs
Date: Tue, 15 Apr 2014 14:00:40 +0200
Message-ID: <1397563250-3089-38-git-send-email-borntraeger@de.ibm.com>
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

Whenever a program interrupt is intercepted, some parameters are stored in the
sie control block. These parameters have to be extracted in order to be
reinjected correctly. This patch also takes care of intercepted PER events which
can occurr in addition to any program interrupt.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 18 +++++++++--
 arch/s390/kvm/intercept.c        | 65 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 79 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index f1ed7bd..b8c8081 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -120,9 +120,21 @@ struct kvm_s390_sie_block {
 	psw_t	gpsw;			/* 0x0090 */
 	__u64	gg14;			/* 0x00a0 */
 	__u64	gg15;			/* 0x00a8 */
-	__u8	reservedb0[30];		/* 0x00b0 */
-	__u16   iprcc;			/* 0x00ce */
-	__u8	reservedd0[48];		/* 0x00d0 */
+	__u8	reservedb0[28];		/* 0x00b0 */
+	__u16	pgmilc;			/* 0x00cc */
+	__u16	iprcc;			/* 0x00ce */
+	__u32	dxc;			/* 0x00d0 */
+	__u16	mcn;			/* 0x00d4 */
+	__u8	perc;			/* 0x00d6 */
+	__u8	peratmid;		/* 0x00d7 */
+	__u64	peraddr;		/* 0x00d8 */
+	__u8	eai;			/* 0x00e0 */
+	__u8	peraid;			/* 0x00e1 */
+	__u8	oai;			/* 0x00e2 */
+	__u8	armid;			/* 0x00e3 */
+	__u8	reservede4[4];		/* 0x00e4 */
+	__u64	tecmc;			/* 0x00e8 */
+	__u8	reservedf0[16];		/* 0x00f0 */
 	__u64	gcr[16];		/* 0x0100 */
 	__u64	gbea;			/* 0x0180 */
 	__u8	reserved188[24];	/* 0x0188 */
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index a8d8da8..4c3311e 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -109,8 +109,69 @@ static int handle_instruction(struct kvm_vcpu *vcpu)
 	return -EOPNOTSUPP;
 }
 
+static void __extract_prog_irq(struct kvm_vcpu *vcpu,
+			       struct kvm_s390_pgm_info *pgm_info)
+{
+	memset(pgm_info, 0, sizeof(struct kvm_s390_pgm_info));
+	pgm_info->code = vcpu->arch.sie_block->iprcc;
+
+	switch (vcpu->arch.sie_block->iprcc & ~PGM_PER) {
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
+		pgm_info->trans_exc_code = vcpu->arch.sie_block->tecmc;
+		break;
+	case PGM_ALEN_TRANSLATION:
+	case PGM_ALE_SEQUENCE:
+	case PGM_ASTE_INSTANCE:
+	case PGM_ASTE_SEQUENCE:
+	case PGM_ASTE_VALIDITY:
+	case PGM_EXTENDED_AUTHORITY:
+		pgm_info->exc_access_id = vcpu->arch.sie_block->eai;
+		break;
+	case PGM_ASCE_TYPE:
+	case PGM_PAGE_TRANSLATION:
+	case PGM_REGION_FIRST_TRANS:
+	case PGM_REGION_SECOND_TRANS:
+	case PGM_REGION_THIRD_TRANS:
+	case PGM_SEGMENT_TRANSLATION:
+		pgm_info->trans_exc_code = vcpu->arch.sie_block->tecmc;
+		pgm_info->exc_access_id  = vcpu->arch.sie_block->eai;
+		pgm_info->op_access_id  = vcpu->arch.sie_block->oai;
+		break;
+	case PGM_MONITOR:
+		pgm_info->mon_class_nr = vcpu->arch.sie_block->mcn;
+		pgm_info->mon_code = vcpu->arch.sie_block->tecmc;
+		break;
+	case PGM_DATA:
+		pgm_info->data_exc_code = vcpu->arch.sie_block->dxc;
+		break;
+	case PGM_PROTECTION:
+		pgm_info->trans_exc_code = vcpu->arch.sie_block->tecmc;
+		pgm_info->exc_access_id  = vcpu->arch.sie_block->eai;
+		break;
+	default:
+		break;
+	}
+
+	if (vcpu->arch.sie_block->iprcc & PGM_PER) {
+		pgm_info->per_code = vcpu->arch.sie_block->perc;
+		pgm_info->per_atmid = vcpu->arch.sie_block->peratmid;
+		pgm_info->per_address = vcpu->arch.sie_block->peraddr;
+		pgm_info->per_access_id = vcpu->arch.sie_block->peraid;
+	}
+}
+
 static int handle_prog(struct kvm_vcpu *vcpu)
 {
+	struct kvm_s390_pgm_info pgm_info;
 	struct kvm_s390_itdb *itdb;
 	int rc;
 
@@ -128,7 +189,9 @@ static int handle_prog(struct kvm_vcpu *vcpu)
 	memset(itdb, 0, sizeof(*itdb));
 skip_itdb:
 	trace_kvm_s390_intercept_prog(vcpu, vcpu->arch.sie_block->iprcc);
-	return kvm_s390_inject_program_int(vcpu, vcpu->arch.sie_block->iprcc);
+	__extract_prog_irq(vcpu, &pgm_info);
+
+	return kvm_s390_inject_prog_irq(vcpu, &pgm_info);
 }
 
 static int handle_instruction_and_prog(struct kvm_vcpu *vcpu)
-- 
1.8.4.2
