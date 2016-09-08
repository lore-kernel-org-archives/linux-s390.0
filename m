From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 07/11] KVM: s390: gaccess: simplify translation exception handling
Date: Thu,  8 Sep 2016 14:00:19 +0200
Message-ID: <1473336023-15522-8-git-send-email-borntraeger@de.ibm.com>
References: <1473336023-15522-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1473336023-15522-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Janosch Frank <frankja@linux.vnet.ibm.com>

The payload data for protection exceptions is a superset of the
payload of other translation exceptions. Let's set the additional
flags and use a fall through to minimize code duplication.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 5420020..4aa8a7e 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -495,6 +495,18 @@ static int trans_exc(struct kvm_vcpu *vcpu, int code, unsigned long gva,
 	tec = (struct trans_exc_code_bits *)&pgm->trans_exc_code;
 
 	switch (code) {
+	case PGM_PROTECTION:
+		switch (prot) {
+		case PROT_TYPE_ALC:
+			tec->b60 = 1;
+			/* FALL THROUGH */
+		case PROT_TYPE_DAT:
+			tec->b61 = 1;
+			break;
+		default: /* LA and KEYC set b61 to 0, other params undefined */
+			return code;
+		}
+		/* FALL THROUGH */
 	case PGM_ASCE_TYPE:
 	case PGM_PAGE_TRANSLATION:
 	case PGM_REGION_FIRST_TRANS:
@@ -504,8 +516,7 @@ static int trans_exc(struct kvm_vcpu *vcpu, int code, unsigned long gva,
 		/*
 		 * op_access_id only applies to MOVE_PAGE -> set bit 61
 		 * exc_access_id has to be set to 0 for some instructions. Both
-		 * cases have to be handled by the caller. We can always store
-		 * exc_access_id, as it is undefined for non-ar cases.
+		 * cases have to be handled by the caller.
 		 */
 		tec->addr = gva >> PAGE_SHIFT;
 		tec->fsi = mode == GACC_STORE ? FSI_STORE : FSI_FETCH;
@@ -516,25 +527,13 @@ static int trans_exc(struct kvm_vcpu *vcpu, int code, unsigned long gva,
 	case PGM_ASTE_VALIDITY:
 	case PGM_ASTE_SEQUENCE:
 	case PGM_EXTENDED_AUTHORITY:
+		/*
+		 * We can always store exc_access_id, as it is
+		 * undefined for non-ar cases. It is undefined for
+		 * most DAT protection exceptions.
+		 */
 		pgm->exc_access_id = ar;
 		break;
-	case PGM_PROTECTION:
-		switch (prot) {
-		case PROT_TYPE_ALC:
-			tec->b60 = 1;
-			/* FALL THROUGH */
-		case PROT_TYPE_DAT:
-			tec->b61 = 1;
-			tec->addr = gva >> PAGE_SHIFT;
-			tec->fsi = mode == GACC_STORE ? FSI_STORE : FSI_FETCH;
-			tec->as = psw_bits(vcpu->arch.sie_block->gpsw).as;
-			/* exc_access_id is undefined for most cases */
-			pgm->exc_access_id = ar;
-			break;
-		default: /* LA and KEYC set b61 to 0, other params undefined */
-			break;
-		}
-		break;
 	}
 	return code;
 }
-- 
2.5.5
