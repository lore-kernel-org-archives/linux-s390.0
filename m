From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 3/9] KVM: s390: implement instruction execution protection for emulated ifetch
Date: Wed, 28 Jun 2017 19:30:38 +0200
Message-ID: <1498671044-81240-4-git-send-email-borntraeger@de.ibm.com>
References: <1498671044-81240-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1498671044-81240-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

While currently only used to fetch the original instruction on failure
for getting the instruction length code, we should make the page table
walking code future proof.

Suggested-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/ctl_reg.h |  4 +++-
 arch/s390/kvm/gaccess.c         | 39 +++++++++++++++++++++++++++++----------
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/arch/s390/include/asm/ctl_reg.h b/arch/s390/include/asm/ctl_reg.h
index d0441ad..e508dff 100644
--- a/arch/s390/include/asm/ctl_reg.h
+++ b/arch/s390/include/asm/ctl_reg.h
@@ -59,7 +59,9 @@ union ctlreg0 {
 		unsigned long lap  : 1; /* Low-address-protection control */
 		unsigned long	   : 4;
 		unsigned long edat : 1; /* Enhanced-DAT-enablement control */
-		unsigned long	   : 4;
+		unsigned long	   : 2;
+		unsigned long iep  : 1; /* Instruction-Execution-Protection */
+		unsigned long	   : 1;
 		unsigned long afp  : 1; /* AFP-register control */
 		unsigned long vx   : 1; /* Vector enablement control */
 		unsigned long	   : 7;
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 9da243d..6fda095 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -89,7 +89,7 @@ struct region3_table_entry_fc1 {
 	unsigned long f  : 1; /* Fetch-Protection Bit */
 	unsigned long fc : 1; /* Format-Control */
 	unsigned long p  : 1; /* DAT-Protection Bit */
-	unsigned long co : 1; /* Change-Recording Override */
+	unsigned long iep: 1; /* Instruction-Execution-Protection */
 	unsigned long	 : 2;
 	unsigned long i  : 1; /* Region-Invalid Bit */
 	unsigned long cr : 1; /* Common-Region Bit */
@@ -131,7 +131,7 @@ struct segment_entry_fc1 {
 	unsigned long f  : 1; /* Fetch-Protection Bit */
 	unsigned long fc : 1; /* Format-Control */
 	unsigned long p  : 1; /* DAT-Protection Bit */
-	unsigned long co : 1; /* Change-Recording Override */
+	unsigned long iep: 1; /* Instruction-Execution-Protection */
 	unsigned long	 : 2;
 	unsigned long i  : 1; /* Segment-Invalid Bit */
 	unsigned long cs : 1; /* Common-Segment Bit */
@@ -168,7 +168,8 @@ union page_table_entry {
 		unsigned long z  : 1; /* Zero Bit */
 		unsigned long i  : 1; /* Page-Invalid Bit */
 		unsigned long p  : 1; /* DAT-Protection Bit */
-		unsigned long	 : 9;
+		unsigned long iep: 1; /* Instruction-Execution-Protection */
+		unsigned long	 : 8;
 	};
 };
 
@@ -485,6 +486,7 @@ enum prot_type {
 	PROT_TYPE_KEYC = 1,
 	PROT_TYPE_ALC  = 2,
 	PROT_TYPE_DAT  = 3,
+	PROT_TYPE_IEP  = 4,
 };
 
 static int trans_exc(struct kvm_vcpu *vcpu, int code, unsigned long gva,
@@ -500,6 +502,9 @@ static int trans_exc(struct kvm_vcpu *vcpu, int code, unsigned long gva,
 	switch (code) {
 	case PGM_PROTECTION:
 		switch (prot) {
+		case PROT_TYPE_IEP:
+			tec->b61 = 1;
+			/* FALL THROUGH */
 		case PROT_TYPE_LA:
 			tec->b56 = 1;
 			break;
@@ -591,6 +596,7 @@ static int deref_table(struct kvm *kvm, unsigned long gpa, unsigned long *val)
  * @gpa: points to where guest physical (absolute) address should be stored
  * @asce: effective asce
  * @mode: indicates the access mode to be used
+ * @prot: returns the type for protection exceptions
  *
  * Translate a guest virtual address into a guest absolute address by means
  * of dynamic address translation as specified by the architecture.
@@ -606,19 +612,21 @@ static int deref_table(struct kvm *kvm, unsigned long gpa, unsigned long *val)
  */
 static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
 				     unsigned long *gpa, const union asce asce,
-				     enum gacc_mode mode)
+				     enum gacc_mode mode, enum prot_type *prot)
 {
 	union vaddress vaddr = {.addr = gva};
 	union raddress raddr = {.addr = gva};
 	union page_table_entry pte;
 	int dat_protection = 0;
+	int iep_protection = 0;
 	union ctlreg0 ctlreg0;
 	unsigned long ptr;
-	int edat1, edat2;
+	int edat1, edat2, iep;
 
 	ctlreg0.val = vcpu->arch.sie_block->gcr[0];
 	edat1 = ctlreg0.edat && test_kvm_facility(vcpu->kvm, 8);
 	edat2 = edat1 && test_kvm_facility(vcpu->kvm, 78);
+	iep = ctlreg0.iep && test_kvm_facility(vcpu->kvm, 130);
 	if (asce.r)
 		goto real_address;
 	ptr = asce.origin * 4096;
@@ -702,6 +710,7 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
 			return PGM_TRANSLATION_SPEC;
 		if (rtte.fc && edat2) {
 			dat_protection |= rtte.fc1.p;
+			iep_protection = rtte.fc1.iep;
 			raddr.rfaa = rtte.fc1.rfaa;
 			goto absolute_address;
 		}
@@ -729,6 +738,7 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
 			return PGM_TRANSLATION_SPEC;
 		if (ste.fc && edat1) {
 			dat_protection |= ste.fc1.p;
+			iep_protection = ste.fc1.iep;
 			raddr.sfaa = ste.fc1.sfaa;
 			goto absolute_address;
 		}
@@ -745,12 +755,19 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
 	if (pte.z)
 		return PGM_TRANSLATION_SPEC;
 	dat_protection |= pte.p;
+	iep_protection = pte.iep;
 	raddr.pfra = pte.pfra;
 real_address:
 	raddr.addr = kvm_s390_real_to_abs(vcpu, raddr.addr);
 absolute_address:
-	if (mode == GACC_STORE && dat_protection)
+	if (mode == GACC_STORE && dat_protection) {
+		*prot = PROT_TYPE_DAT;
 		return PGM_PROTECTION;
+	}
+	if (mode == GACC_IFETCH && iep_protection && iep) {
+		*prot = PROT_TYPE_IEP;
+		return PGM_PROTECTION;
+	}
 	if (kvm_is_error_gpa(vcpu->kvm, raddr.addr))
 		return PGM_ADDRESSING;
 	*gpa = raddr.addr;
@@ -782,6 +799,7 @@ static int guest_page_range(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
 {
 	psw_t *psw = &vcpu->arch.sie_block->gpsw;
 	int lap_enabled, rc = 0;
+	enum prot_type prot;
 
 	lap_enabled = low_address_protection_enabled(vcpu, asce);
 	while (nr_pages) {
@@ -791,7 +809,7 @@ static int guest_page_range(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
 					 PROT_TYPE_LA);
 		ga &= PAGE_MASK;
 		if (psw_bits(*psw).t) {
-			rc = guest_translate(vcpu, ga, pages, asce, mode);
+			rc = guest_translate(vcpu, ga, pages, asce, mode, &prot);
 			if (rc < 0)
 				return rc;
 		} else {
@@ -800,7 +818,7 @@ static int guest_page_range(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
 				rc = PGM_ADDRESSING;
 		}
 		if (rc)
-			return trans_exc(vcpu, rc, ga, ar, mode, PROT_TYPE_DAT);
+			return trans_exc(vcpu, rc, ga, ar, mode, prot);
 		ga += PAGE_SIZE;
 		pages++;
 		nr_pages--;
@@ -886,6 +904,7 @@ int guest_translate_address(struct kvm_vcpu *vcpu, unsigned long gva, u8 ar,
 			    unsigned long *gpa, enum gacc_mode mode)
 {
 	psw_t *psw = &vcpu->arch.sie_block->gpsw;
+	enum prot_type prot;
 	union asce asce;
 	int rc;
 
@@ -900,9 +919,9 @@ int guest_translate_address(struct kvm_vcpu *vcpu, unsigned long gva, u8 ar,
 	}
 
 	if (psw_bits(*psw).t && !asce.r) {	/* Use DAT? */
-		rc = guest_translate(vcpu, gva, gpa, asce, mode);
+		rc = guest_translate(vcpu, gva, gpa, asce, mode, &prot);
 		if (rc > 0)
-			return trans_exc(vcpu, rc, gva, 0, mode, PROT_TYPE_DAT);
+			return trans_exc(vcpu, rc, gva, 0, mode, prot);
 	} else {
 		*gpa = kvm_s390_real_to_abs(vcpu, gva);
 		if (kvm_is_error_gpa(vcpu->kvm, *gpa))
-- 
2.7.4
