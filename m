From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 14/52] KVM: s390: gaccess: convert guest_translate_address()
Date: Tue, 14 Jun 2016 20:56:51 +0200
Message-ID: <1465930649-181383-15-git-send-email-borntraeger@de.ibm.com>
References: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Let's use our new function for preparing translation exceptions.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 61dc45e..ae9f9e8 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -910,37 +910,28 @@ int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
 int guest_translate_address(struct kvm_vcpu *vcpu, unsigned long gva, ar_t ar,
 			    unsigned long *gpa, enum gacc_mode mode)
 {
-	struct kvm_s390_pgm_info *pgm = &vcpu->arch.pgm;
 	psw_t *psw = &vcpu->arch.sie_block->gpsw;
-	struct trans_exc_code_bits *tec;
 	union asce asce;
 	int rc;
 
 	gva = kvm_s390_logical_to_effective(vcpu, gva);
-	tec = (struct trans_exc_code_bits *)&pgm->trans_exc_code;
 	rc = get_vcpu_asce(vcpu, &asce, gva, ar, mode);
-	tec->addr = gva >> PAGE_SHIFT;
 	if (rc)
 		return rc;
 	if (is_low_address(gva) && low_address_protection_enabled(vcpu, asce)) {
-		if (mode == GACC_STORE) {
-			rc = pgm->code = PGM_PROTECTION;
-			return rc;
-		}
+		if (mode == GACC_STORE)
+			return trans_exc(vcpu, PGM_PROTECTION, gva, 0,
+					 mode, PROT_TYPE_LA);
 	}
 
 	if (psw_bits(*psw).t && !asce.r) {	/* Use DAT? */
 		rc = guest_translate(vcpu, gva, gpa, asce, mode);
-		if (rc > 0) {
-			if (rc == PGM_PROTECTION)
-				tec->b61 = 1;
-			pgm->code = rc;
-		}
+		if (rc > 0)
+			return trans_exc(vcpu, rc, gva, 0, mode, PROT_TYPE_DAT);
 	} else {
-		rc = 0;
 		*gpa = kvm_s390_real_to_abs(vcpu, gva);
 		if (kvm_is_error_gpa(vcpu->kvm, *gpa))
-			rc = pgm->code = PGM_ADDRESSING;
+			return trans_exc(vcpu, rc, gva, PGM_ADDRESSING, mode, 0);
 	}
 
 	return rc;
-- 
2.5.5
