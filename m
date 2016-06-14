From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 14 Jun 2016 18:56:53 +0000
Subject: [GIT PULL 16/52] KVM: s390: gaccess: convert get_vcpu_asce()
Message-Id: <201606141857.u5EIs1L3090410@mx0a-001b2d01.pphosted.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Let's use our new function for preparing translation exceptions.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index ec6c91e..8e245e7 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -543,13 +543,6 @@ static int get_vcpu_asce(struct kvm_vcpu *vcpu, union asce *asce,
 {
 	int rc;
 	struct psw_bits psw = psw_bits(vcpu->arch.sie_block->gpsw);
-	struct kvm_s390_pgm_info *pgm = &vcpu->arch.pgm;
-	struct trans_exc_code_bits *tec_bits;
-
-	memset(pgm, 0, sizeof(*pgm));
-	tec_bits = (struct trans_exc_code_bits *)&pgm->trans_exc_code;
-	tec_bits->fsi = mode == GACC_STORE ? FSI_STORE : FSI_FETCH;
-	tec_bits->as = psw.as;
 
 	if (!psw.t) {
 		asce->val = 0;
@@ -572,22 +565,8 @@ static int get_vcpu_asce(struct kvm_vcpu *vcpu, union asce *asce,
 		return 0;
 	case PSW_AS_ACCREG:
 		rc = ar_translation(vcpu, asce, ar, mode);
-		switch (rc) {
-		case PGM_ALEN_TRANSLATION:
-		case PGM_ALE_SEQUENCE:
-		case PGM_ASTE_VALIDITY:
-		case PGM_ASTE_SEQUENCE:
-		case PGM_EXTENDED_AUTHORITY:
-			vcpu->arch.pgm.exc_access_id = ar;
-			break;
-		case PGM_PROTECTION:
-			tec_bits->addr = ga >> PAGE_SHIFT;
-			tec_bits->b60 = 1;
-			tec_bits->b61 = 1;
-			break;
-		}
 		if (rc > 0)
-			pgm->code = rc;
+			return trans_exc(vcpu, rc, ga, ar, mode, PROT_TYPE_ALC);
 		return rc;
 	}
 	return 0;
-- 
2.5.5
