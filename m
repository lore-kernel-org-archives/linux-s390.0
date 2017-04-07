From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 3/9] KVM: s390: use defines for execution controls
Date: Fri,  7 Apr 2017 12:47:56 +0200
Message-ID: <1491562082-6392-4-git-send-email-borntraeger@de.ibm.com>
References: <1491562082-6392-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1491562082-6392-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <david@redhat.com>

Let's replace the bitmasks by defines. Reconstructed from code, comments
and commit messages.

Tried to keep the defines short and map them to feature names. In case
they don't completely map to features, keep them in the stye of ICTL
defines.

This effectively drops all "U" from the existing numbers. I think this
should be fine (as similarly done for e.g. ICTL defines).

I am not 100% sure about the ECA_MVPGI and ECA_PROTEXCI bits as they are
always used in pairs.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170313104828.13362-1-david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
[some renames, add one missing place]
---
 arch/s390/include/asm/kvm_host.h | 18 +++++++++++++++++-
 arch/s390/kvm/gaccess.c          |  6 +++---
 arch/s390/kvm/kvm-s390.c         | 36 ++++++++++++++++++------------------
 arch/s390/kvm/kvm-s390.h         |  2 +-
 arch/s390/kvm/priv.c             |  2 +-
 arch/s390/kvm/vsie.c             | 33 ++++++++++++++++-----------------
 6 files changed, 56 insertions(+), 41 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index a41faf3..18e9c9d 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -164,6 +164,13 @@ struct kvm_s390_sie_block {
 #define ICTL_RRBE	0x00001000
 #define ICTL_TPROT	0x00000200
 	__u32	ictl;			/* 0x0048 */
+#define ECA_CEI		0x80000000
+#define ECA_IB		0x40000000
+#define ECA_SIGPI	0x10000000
+#define ECA_MVPGI	0x01000000
+#define ECA_VX		0x00020000
+#define ECA_PROTEXCI	0x00002000
+#define ECA_SII		0x00000001
 	__u32	eca;			/* 0x004c */
 #define ICPT_INST	0x04
 #define ICPT_PROGI	0x08
@@ -182,10 +189,18 @@ struct kvm_s390_sie_block {
 	__u32	ipb;			/* 0x0058 */
 	__u32	scaoh;			/* 0x005c */
 	__u8	reserved60;		/* 0x0060 */
+#define ECB_TE		0x10
+#define ECB_SRSI	0x04
+#define ECB_HOSTPROTINT	0x02
 	__u8	ecb;			/* 0x0061 */
+#define ECB2_CMMA	0x80
+#define ECB2_IEP	0x20
+#define ECB2_PFMFI	0x08
+#define ECB2_ESCA	0x04
 	__u8    ecb2;                   /* 0x0062 */
-#define ECB3_AES 0x04
 #define ECB3_DEA 0x08
+#define ECB3_AES 0x04
+#define ECB3_RI  0x01
 	__u8    ecb3;			/* 0x0063 */
 	__u32	scaol;			/* 0x0064 */
 	__u8	reserved68[4];		/* 0x0068 */
@@ -224,6 +239,7 @@ struct kvm_s390_sie_block {
 	__u8	reserved1a4[20];	/* 0x01a4 */
 	__u64	cbrlo;			/* 0x01b8 */
 	__u8	reserved1c0[8];		/* 0x01c0 */
+#define ECD_HOSTREGMGMT	0x20000000
 	__u32	ecd;			/* 0x01c8 */
 	__u8	reserved1cc[18];	/* 0x01cc */
 	__u64	pp;			/* 0x01de */
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index d55c829..709aca9 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -262,7 +262,7 @@ struct aste {
 
 int ipte_lock_held(struct kvm_vcpu *vcpu)
 {
-	if (vcpu->arch.sie_block->eca & 1) {
+	if (vcpu->arch.sie_block->eca & ECA_SII) {
 		int rc;
 
 		read_lock(&vcpu->kvm->arch.sca_lock);
@@ -361,7 +361,7 @@ static void ipte_unlock_siif(struct kvm_vcpu *vcpu)
 
 void ipte_lock(struct kvm_vcpu *vcpu)
 {
-	if (vcpu->arch.sie_block->eca & 1)
+	if (vcpu->arch.sie_block->eca & ECA_SII)
 		ipte_lock_siif(vcpu);
 	else
 		ipte_lock_simple(vcpu);
@@ -369,7 +369,7 @@ void ipte_lock(struct kvm_vcpu *vcpu)
 
 void ipte_unlock(struct kvm_vcpu *vcpu)
 {
-	if (vcpu->arch.sie_block->eca & 1)
+	if (vcpu->arch.sie_block->eca & ECA_SII)
 		ipte_unlock_siif(vcpu);
 	else
 		ipte_unlock_simple(vcpu);
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 5fda468..976373c 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1646,7 +1646,7 @@ static void sca_add_vcpu(struct kvm_vcpu *vcpu)
 		sca->cpu[vcpu->vcpu_id].sda = (__u64) vcpu->arch.sie_block;
 		vcpu->arch.sie_block->scaoh = (__u32)(((__u64)sca) >> 32);
 		vcpu->arch.sie_block->scaol = (__u32)(__u64)sca & ~0x3fU;
-		vcpu->arch.sie_block->ecb2 |= 0x04U;
+		vcpu->arch.sie_block->ecb2 |= ECB2_ESCA;
 		set_bit_inv(vcpu->vcpu_id, (unsigned long *) sca->mcn);
 	} else {
 		struct bsca_block *sca = vcpu->kvm->arch.sca;
@@ -1700,7 +1700,7 @@ static int sca_switch_to_extended(struct kvm *kvm)
 	kvm_for_each_vcpu(vcpu_idx, vcpu, kvm) {
 		vcpu->arch.sie_block->scaoh = scaoh;
 		vcpu->arch.sie_block->scaol = scaol;
-		vcpu->arch.sie_block->ecb2 |= 0x04U;
+		vcpu->arch.sie_block->ecb2 |= ECB2_ESCA;
 	}
 	kvm->arch.sca = new_sca;
 	kvm->arch.use_esca = 1;
@@ -1939,8 +1939,8 @@ int kvm_s390_vcpu_setup_cmma(struct kvm_vcpu *vcpu)
 	if (!vcpu->arch.sie_block->cbrlo)
 		return -ENOMEM;
 
-	vcpu->arch.sie_block->ecb2 |= 0x80;
-	vcpu->arch.sie_block->ecb2 &= ~0x08;
+	vcpu->arch.sie_block->ecb2 |= ECB2_CMMA;
+	vcpu->arch.sie_block->ecb2 &= ~ECB2_PFMFI;
 	return 0;
 }
 
@@ -1970,28 +1970,28 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 
 	/* pgste_set_pte has special handling for !MACHINE_HAS_ESOP */
 	if (MACHINE_HAS_ESOP)
-		vcpu->arch.sie_block->ecb |= 0x02;
+		vcpu->arch.sie_block->ecb |= ECB_HOSTPROTINT;
 	if (test_kvm_facility(vcpu->kvm, 9))
-		vcpu->arch.sie_block->ecb |= 0x04;
+		vcpu->arch.sie_block->ecb |= ECB_SRSI;
 	if (test_kvm_facility(vcpu->kvm, 73))
-		vcpu->arch.sie_block->ecb |= 0x10;
+		vcpu->arch.sie_block->ecb |= ECB_TE;
 
 	if (test_kvm_facility(vcpu->kvm, 8) && sclp.has_pfmfi)
-		vcpu->arch.sie_block->ecb2 |= 0x08;
+		vcpu->arch.sie_block->ecb2 |= ECB2_PFMFI;
 	if (test_kvm_facility(vcpu->kvm, 130))
-		vcpu->arch.sie_block->ecb2 |= 0x20;
-	vcpu->arch.sie_block->eca = 0x1002000U;
+		vcpu->arch.sie_block->ecb2 |= ECB2_IEP;
+	vcpu->arch.sie_block->eca = ECA_MVPGI | ECA_PROTEXCI;
 	if (sclp.has_cei)
-		vcpu->arch.sie_block->eca |= 0x80000000U;
+		vcpu->arch.sie_block->eca |= ECA_CEI;
 	if (sclp.has_ib)
-		vcpu->arch.sie_block->eca |= 0x40000000U;
+		vcpu->arch.sie_block->eca |= ECA_IB;
 	if (sclp.has_siif)
-		vcpu->arch.sie_block->eca |= 1;
+		vcpu->arch.sie_block->eca |= ECA_SII;
 	if (sclp.has_sigpif)
-		vcpu->arch.sie_block->eca |= 0x10000000U;
+		vcpu->arch.sie_block->eca |= ECA_SIGPI;
 	if (test_kvm_facility(vcpu->kvm, 129)) {
-		vcpu->arch.sie_block->eca |= 0x00020000;
-		vcpu->arch.sie_block->ecd |= 0x20000000;
+		vcpu->arch.sie_block->eca |= ECA_VX;
+		vcpu->arch.sie_block->ecd |= ECD_HOSTREGMGMT;
 	}
 	vcpu->arch.sie_block->riccbd = (unsigned long) &vcpu->run->s.regs.riccb;
 	vcpu->arch.sie_block->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE;
@@ -2752,9 +2752,9 @@ static void sync_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	if ((kvm_run->kvm_dirty_regs & KVM_SYNC_RICCB) &&
 	    test_kvm_facility(vcpu->kvm, 64) &&
 	    riccb->valid &&
-	    !(vcpu->arch.sie_block->ecb3 & 0x01)) {
+	    !(vcpu->arch.sie_block->ecb3 & ECB3_RI)) {
 		VCPU_EVENT(vcpu, 3, "%s", "ENABLE: RI (sync_regs)");
-		vcpu->arch.sie_block->ecb3 |= 0x01;
+		vcpu->arch.sie_block->ecb3 |= ECB3_RI;
 	}
 	save_access_regs(vcpu->arch.host_acrs);
 	restore_access_regs(vcpu->run->s.regs.acrs);
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index af9fa91..dfdcde1 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -25,7 +25,7 @@
 typedef int (*intercept_handler_t)(struct kvm_vcpu *vcpu);
 
 /* Transactional Memory Execution related macros */
-#define IS_TE_ENABLED(vcpu)	((vcpu->arch.sie_block->ecb & 0x10))
+#define IS_TE_ENABLED(vcpu)	((vcpu->arch.sie_block->ecb & ECB_TE))
 #define TDB_FORMAT1		1
 #define IS_ITDB_VALID(vcpu)	((*(char *)vcpu->arch.sie_block->itdba == TDB_FORMAT1))
 
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 26f30ba..d42bb2d 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -38,7 +38,7 @@ static int handle_ri(struct kvm_vcpu *vcpu)
 {
 	if (test_kvm_facility(vcpu->kvm, 64)) {
 		VCPU_EVENT(vcpu, 3, "%s", "ENABLE: RI (lazy)");
-		vcpu->arch.sie_block->ecb3 |= 0x01;
+		vcpu->arch.sie_block->ecb3 |= ECB3_RI;
 		kvm_s390_retry_instr(vcpu);
 		return 0;
 	} else
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 5491be3..d91f1df 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -249,7 +249,7 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {
 	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
 	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
-	bool had_tx = scb_s->ecb & 0x10U;
+	bool had_tx = scb_s->ecb & ECB_TE;
 	unsigned long new_mso = 0;
 	int rc;
 
@@ -307,34 +307,34 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		scb_s->ihcpu = scb_o->ihcpu;
 
 	/* MVPG and Protection Exception Interpretation are always available */
-	scb_s->eca |= scb_o->eca & 0x01002000U;
+	scb_s->eca |= scb_o->eca & (ECA_MVPGI | ECA_PROTEXCI);
 	/* Host-protection-interruption introduced with ESOP */
 	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_ESOP))
-		scb_s->ecb |= scb_o->ecb & 0x02U;
+		scb_s->ecb |= scb_o->ecb & ECB_HOSTPROTINT;
 	/* transactional execution */
 	if (test_kvm_facility(vcpu->kvm, 73)) {
 		/* remap the prefix is tx is toggled on */
-		if ((scb_o->ecb & 0x10U) && !had_tx)
+		if ((scb_o->ecb & ECB_TE) && !had_tx)
 			prefix_unmapped(vsie_page);
-		scb_s->ecb |= scb_o->ecb & 0x10U;
+		scb_s->ecb |= scb_o->ecb & ECB_TE;
 	}
 	/* SIMD */
 	if (test_kvm_facility(vcpu->kvm, 129)) {
-		scb_s->eca |= scb_o->eca & 0x00020000U;
-		scb_s->ecd |= scb_o->ecd & 0x20000000U;
+		scb_s->eca |= scb_o->eca & ECA_VX;
+		scb_s->ecd |= scb_o->ecd & ECD_HOSTREGMGMT;
 	}
 	/* Run-time-Instrumentation */
 	if (test_kvm_facility(vcpu->kvm, 64))
-		scb_s->ecb3 |= scb_o->ecb3 & 0x01U;
+		scb_s->ecb3 |= scb_o->ecb3 & ECB3_RI;
 	/* Instruction Execution Prevention */
 	if (test_kvm_facility(vcpu->kvm, 130))
-		scb_s->ecb2 |= scb_o->ecb2 & 0x20U;
+		scb_s->ecb2 |= scb_o->ecb2 & ECB2_IEP;
 	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_SIIF))
-		scb_s->eca |= scb_o->eca & 0x00000001U;
+		scb_s->eca |= scb_o->eca & ECA_SII;
 	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_IB))
-		scb_s->eca |= scb_o->eca & 0x40000000U;
+		scb_s->eca |= scb_o->eca & ECA_IB;
 	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_CEI))
-		scb_s->eca |= scb_o->eca & 0x80000000U;
+		scb_s->eca |= scb_o->eca & ECA_CEI;
 
 	prepare_ibc(vcpu, vsie_page);
 	rc = shadow_crycb(vcpu, vsie_page);
@@ -406,7 +406,7 @@ static int map_prefix(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	prefix += scb_s->mso;
 
 	rc = kvm_s390_shadow_fault(vcpu, vsie_page->gmap, prefix);
-	if (!rc && (scb_s->ecb & 0x10U))
+	if (!rc && (scb_s->ecb & ECB_TE))
 		rc = kvm_s390_shadow_fault(vcpu, vsie_page->gmap,
 					   prefix + PAGE_SIZE);
 	/*
@@ -543,7 +543,7 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	}
 
 	gpa = scb_o->itdba & ~0xffUL;
-	if (gpa && (scb_s->ecb & 0x10U)) {
+	if (gpa && (scb_s->ecb & ECB_TE)) {
 		if (!(gpa & ~0x1fffU)) {
 			rc = set_validity_icpt(scb_s, 0x0080U);
 			goto unpin;
@@ -558,8 +558,7 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	}
 
 	gpa = scb_o->gvrd & ~0x1ffUL;
-	if (gpa && (scb_s->eca & 0x00020000U) &&
-	    !(scb_s->ecd & 0x20000000U)) {
+	if (gpa && (scb_s->eca & ECA_VX) && !(scb_s->ecd & ECD_HOSTREGMGMT)) {
 		if (!(gpa & ~0x1fffUL)) {
 			rc = set_validity_icpt(scb_s, 0x1310U);
 			goto unpin;
@@ -577,7 +576,7 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	}
 
 	gpa = scb_o->riccbd & ~0x3fUL;
-	if (gpa && (scb_s->ecb3 & 0x01U)) {
+	if (gpa && (scb_s->ecb3 & ECB3_RI)) {
 		if (!(gpa & ~0x1fffUL)) {
 			rc = set_validity_icpt(scb_s, 0x0043U);
 			goto unpin;
-- 
2.7.4
