From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 12/52] KVM: s390: gaccess: function for preparing translation exceptions
Date: Tue, 14 Jun 2016 20:56:49 +0200
Message-ID: <1465930649-181383-13-git-send-email-borntraeger@de.ibm.com>
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

Let's provide a function trans_exc() that can be used for handling
preparation of translation exceptions on a central basis. We will use
that function to replace existing code in gaccess.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index c0da9e9..b6ccb26 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -476,6 +476,68 @@ enum {
 	FSI_FETCH   = 2  /* Exception was due to fetch operation */
 };
 
+enum prot_type {
+	PROT_TYPE_LA   = 0,
+	PROT_TYPE_KEYC = 1,
+	PROT_TYPE_ALC  = 2,
+	PROT_TYPE_DAT  = 3,
+};
+
+static int trans_exc(struct kvm_vcpu *vcpu, int code, unsigned long gva,
+		     ar_t ar, enum gacc_mode mode, enum prot_type prot)
+{
+	struct kvm_s390_pgm_info *pgm = &vcpu->arch.pgm;
+	struct trans_exc_code_bits *tec;
+
+	memset(pgm, 0, sizeof(*pgm));
+	pgm->code = code;
+	tec = (struct trans_exc_code_bits *)&pgm->trans_exc_code;
+
+	switch (code) {
+	case PGM_ASCE_TYPE:
+	case PGM_PAGE_TRANSLATION:
+	case PGM_REGION_FIRST_TRANS:
+	case PGM_REGION_SECOND_TRANS:
+	case PGM_REGION_THIRD_TRANS:
+	case PGM_SEGMENT_TRANSLATION:
+		/*
+		 * op_access_id only applies to MOVE_PAGE -> set bit 61
+		 * exc_access_id has to be set to 0 for some instructions. Both
+		 * cases have to be handled by the caller. We can always store
+		 * exc_access_id, as it is undefined for non-ar cases.
+		 */
+		tec->addr = gva >> PAGE_SHIFT;
+		tec->fsi = mode == GACC_STORE ? FSI_STORE : FSI_FETCH;
+		tec->as = psw_bits(vcpu->arch.sie_block->gpsw).as;
+		/* FALL THROUGH */
+	case PGM_ALEN_TRANSLATION:
+	case PGM_ALE_SEQUENCE:
+	case PGM_ASTE_VALIDITY:
+	case PGM_ASTE_SEQUENCE:
+	case PGM_EXTENDED_AUTHORITY:
+		pgm->exc_access_id = ar;
+		break;
+	case PGM_PROTECTION:
+		switch (prot) {
+		case PROT_TYPE_ALC:
+			tec->b60 = 1;
+			/* FALL THROUGH */
+		case PROT_TYPE_DAT:
+			tec->b61 = 1;
+			tec->addr = gva >> PAGE_SHIFT;
+			tec->fsi = mode == GACC_STORE ? FSI_STORE : FSI_FETCH;
+			tec->as = psw_bits(vcpu->arch.sie_block->gpsw).as;
+			/* exc_access_id is undefined for most cases */
+			pgm->exc_access_id = ar;
+			break;
+		default: /* LA and KEYC set b61 to 0, other params undefined */
+			break;
+		}
+		break;
+	}
+	return code;
+}
+
 static int get_vcpu_asce(struct kvm_vcpu *vcpu, union asce *asce,
 			 unsigned long ga, ar_t ar, enum gacc_mode mode)
 {
-- 
2.5.5
