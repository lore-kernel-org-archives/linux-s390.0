From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 06/11] KVM: s390: Add access register mode
Date: Wed, 18 Mar 2015 12:44:04 +0100
Message-ID: <1426679049-37696-7-git-send-email-borntraeger@de.ibm.com>
References: <1426679049-37696-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1426679049-37696-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Alexander Yarygin <yarygin@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Alexander Yarygin <yarygin@linux.vnet.ibm.com>

Access register mode is one of the modes that control dynamic address
translation. In this mode the address space is specified by values of
the access registers. The effective address-space-control element is
obtained from the result of the access register translation. See
the "Access-Register Introduction" section of the chapter 5 "Program
Execution" in "Principles of Operations" for more details.

Signed-off-by: Alexander Yarygin <yarygin@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.c | 234 +++++++++++++++++++++++++++++++++++++++++-------
 arch/s390/kvm/gaccess.h |   3 +-
 2 files changed, 202 insertions(+), 35 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index c74462a..ea38d71 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -10,6 +10,7 @@
 #include <asm/pgtable.h>
 #include "kvm-s390.h"
 #include "gaccess.h"
+#include <asm/switch_to.h>
 
 union asce {
 	unsigned long val;
@@ -207,6 +208,54 @@ union raddress {
 	unsigned long pfra : 52; /* Page-Frame Real Address */
 };
 
+union alet {
+	u32 val;
+	struct {
+		u32 reserved : 7;
+		u32 p        : 1;
+		u32 alesn    : 8;
+		u32 alen     : 16;
+	};
+};
+
+union ald {
+	u32 val;
+	struct {
+		u32     : 1;
+		u32 alo : 24;
+		u32 all : 7;
+	};
+};
+
+struct ale {
+	unsigned long i      : 1; /* ALEN-Invalid Bit */
+	unsigned long        : 5;
+	unsigned long fo     : 1; /* Fetch-Only Bit */
+	unsigned long p      : 1; /* Private Bit */
+	unsigned long alesn  : 8; /* Access-List-Entry Sequence Number */
+	unsigned long aleax  : 16; /* Access-List-Entry Authorization Index */
+	unsigned long        : 32;
+	unsigned long        : 1;
+	unsigned long asteo  : 25; /* ASN-Second-Table-Entry Origin */
+	unsigned long        : 6;
+	unsigned long astesn : 32; /* ASTE Sequence Number */
+} __packed;
+
+struct aste {
+	unsigned long i      : 1; /* ASX-Invalid Bit */
+	unsigned long ato    : 29; /* Authority-Table Origin */
+	unsigned long        : 1;
+	unsigned long b      : 1; /* Base-Space Bit */
+	unsigned long ax     : 16; /* Authorization Index */
+	unsigned long atl    : 12; /* Authority-Table Length */
+	unsigned long        : 2;
+	unsigned long ca     : 1; /* Controlled-ASN Bit */
+	unsigned long ra     : 1; /* Reusable-ASN Bit */
+	unsigned long asce   : 64; /* Address-Space-Control Element */
+	unsigned long ald    : 32;
+	unsigned long astesn : 32;
+	/* .. more fields there */
+} __packed;
 
 int ipte_lock_held(struct kvm_vcpu *vcpu)
 {
@@ -307,15 +356,157 @@ void ipte_unlock(struct kvm_vcpu *vcpu)
 		ipte_unlock_simple(vcpu);
 }
 
-static unsigned long get_vcpu_asce(struct kvm_vcpu *vcpu)
+static int ar_translation(struct kvm_vcpu *vcpu, union asce *asce, ar_t ar,
+			  int write)
+{
+	union alet alet;
+	struct ale ale;
+	struct aste aste;
+	unsigned long ald_addr, authority_table_addr;
+	union ald ald;
+	int eax, rc;
+	u8 authority_table;
+
+	if (ar >= NUM_ACRS)
+		return -EINVAL;
+
+	save_access_regs(vcpu->run->s.regs.acrs);
+	alet.val = vcpu->run->s.regs.acrs[ar];
+
+	if (ar == 0 || alet.val == 0) {
+		asce->val = vcpu->arch.sie_block->gcr[1];
+		return 0;
+	} else if (alet.val == 1) {
+		asce->val = vcpu->arch.sie_block->gcr[7];
+		return 0;
+	}
+
+	if (alet.reserved)
+		return PGM_ALET_SPECIFICATION;
+
+	if (alet.p)
+		ald_addr = vcpu->arch.sie_block->gcr[5];
+	else
+		ald_addr = vcpu->arch.sie_block->gcr[2];
+	ald_addr &= 0x7fffffc0;
+
+	rc = read_guest_real(vcpu, ald_addr + 16, &ald.val, sizeof(union ald));
+	if (rc)
+		return rc;
+
+	if (alet.alen / 8 > ald.all)
+		return PGM_ALEN_TRANSLATION;
+
+	if (0x7fffffff - ald.alo * 128 < alet.alen * 16)
+		return PGM_ADDRESSING;
+
+	rc = read_guest_real(vcpu, ald.alo * 128 + alet.alen * 16, &ale,
+			     sizeof(struct ale));
+	if (rc)
+		return rc;
+
+	if (ale.i == 1)
+		return PGM_ALEN_TRANSLATION;
+	if (ale.alesn != alet.alesn)
+		return PGM_ALE_SEQUENCE;
+
+	rc = read_guest_real(vcpu, ale.asteo * 64, &aste, sizeof(struct aste));
+	if (rc)
+		return rc;
+
+	if (aste.i)
+		return PGM_ASTE_VALIDITY;
+	if (aste.astesn != ale.astesn)
+		return PGM_ASTE_SEQUENCE;
+
+	if (ale.p == 1) {
+		eax = (vcpu->arch.sie_block->gcr[8] >> 16) & 0xffff;
+		if (ale.aleax != eax) {
+			if (eax / 16 > aste.atl)
+				return PGM_EXTENDED_AUTHORITY;
+
+			authority_table_addr = aste.ato * 4 + eax / 4;
+
+			rc = read_guest_real(vcpu, authority_table_addr,
+					     &authority_table,
+					     sizeof(u8));
+			if (rc)
+				return rc;
+
+			if ((authority_table & (0x40 >> ((eax & 3) * 2))) == 0)
+				return PGM_EXTENDED_AUTHORITY;
+		}
+	}
+
+	if (ale.fo == 1 && write)
+		return PGM_PROTECTION;
+
+	asce->val = aste.asce;
+	return 0;
+}
+
+struct trans_exc_code_bits {
+	unsigned long addr : 52; /* Translation-exception Address */
+	unsigned long fsi  : 2;  /* Access Exception Fetch/Store Indication */
+	unsigned long	   : 6;
+	unsigned long b60  : 1;
+	unsigned long b61  : 1;
+	unsigned long as   : 2;  /* ASCE Identifier */
+};
+
+enum {
+	FSI_UNKNOWN = 0, /* Unknown wether fetch or store */
+	FSI_STORE   = 1, /* Exception was due to store operation */
+	FSI_FETCH   = 2  /* Exception was due to fetch operation */
+};
+
+static int get_vcpu_asce(struct kvm_vcpu *vcpu, union asce *asce,
+			 ar_t ar, int write)
 {
+	int rc;
+	psw_t *psw = &vcpu->arch.sie_block->gpsw;
+	struct kvm_s390_pgm_info *pgm = &vcpu->arch.pgm;
+	struct trans_exc_code_bits *tec_bits;
+
+	memset(pgm, 0, sizeof(*pgm));
+	tec_bits = (struct trans_exc_code_bits *)&pgm->trans_exc_code;
+	tec_bits->fsi = write ? FSI_STORE : FSI_FETCH;
+	tec_bits->as = psw_bits(*psw).as;
+
+	if (!psw_bits(*psw).t) {
+		asce->val = 0;
+		asce->r = 1;
+		return 0;
+	}
+
 	switch (psw_bits(vcpu->arch.sie_block->gpsw).as) {
 	case PSW_AS_PRIMARY:
-		return vcpu->arch.sie_block->gcr[1];
+		asce->val = vcpu->arch.sie_block->gcr[1];
+		return 0;
 	case PSW_AS_SECONDARY:
-		return vcpu->arch.sie_block->gcr[7];
+		asce->val = vcpu->arch.sie_block->gcr[7];
+		return 0;
 	case PSW_AS_HOME:
-		return vcpu->arch.sie_block->gcr[13];
+		asce->val = vcpu->arch.sie_block->gcr[13];
+		return 0;
+	case PSW_AS_ACCREG:
+		rc = ar_translation(vcpu, asce, ar, write);
+		switch (rc) {
+		case PGM_ALEN_TRANSLATION:
+		case PGM_ALE_SEQUENCE:
+		case PGM_ASTE_VALIDITY:
+		case PGM_ASTE_SEQUENCE:
+		case PGM_EXTENDED_AUTHORITY:
+			vcpu->arch.pgm.exc_access_id = ar;
+			break;
+		case PGM_PROTECTION:
+			tec_bits->b60 = 1;
+			tec_bits->b61 = 1;
+			break;
+		}
+		if (rc > 0)
+			pgm->code = rc;
+		return rc;
 	}
 	return 0;
 }
@@ -519,20 +710,6 @@ static int low_address_protection_enabled(struct kvm_vcpu *vcpu,
 	return 1;
 }
 
-struct trans_exc_code_bits {
-	unsigned long addr : 52; /* Translation-exception Address */
-	unsigned long fsi  : 2;  /* Access Exception Fetch/Store Indication */
-	unsigned long	   : 7;
-	unsigned long b61  : 1;
-	unsigned long as   : 2;  /* ASCE Identifier */
-};
-
-enum {
-	FSI_UNKNOWN = 0, /* Unknown wether fetch or store */
-	FSI_STORE   = 1, /* Exception was due to store operation */
-	FSI_FETCH   = 2  /* Exception was due to fetch operation */
-};
-
 static int guest_page_range(struct kvm_vcpu *vcpu, unsigned long ga,
 			    unsigned long *pages, unsigned long nr_pages,
 			    const union asce asce, int write)
@@ -542,10 +719,7 @@ static int guest_page_range(struct kvm_vcpu *vcpu, unsigned long ga,
 	struct trans_exc_code_bits *tec_bits;
 	int lap_enabled, rc;
 
-	memset(pgm, 0, sizeof(*pgm));
 	tec_bits = (struct trans_exc_code_bits *)&pgm->trans_exc_code;
-	tec_bits->fsi = write ? FSI_STORE : FSI_FETCH;
-	tec_bits->as = psw_bits(*psw).as;
 	lap_enabled = low_address_protection_enabled(vcpu, asce);
 	while (nr_pages) {
 		ga = kvm_s390_logical_to_effective(vcpu, ga);
@@ -590,16 +764,15 @@ int access_guest(struct kvm_vcpu *vcpu, unsigned long ga, ar_t ar, void *data,
 
 	if (!len)
 		return 0;
-	/* Access register mode is not supported yet. */
-	if (psw_bits(*psw).t && psw_bits(*psw).as == PSW_AS_ACCREG)
-		return -EOPNOTSUPP;
+	rc = get_vcpu_asce(vcpu, &asce, ar, write);
+	if (rc)
+		return rc;
 	nr_pages = (((ga & ~PAGE_MASK) + len - 1) >> PAGE_SHIFT) + 1;
 	pages = pages_array;
 	if (nr_pages > ARRAY_SIZE(pages_array))
 		pages = vmalloc(nr_pages * sizeof(unsigned long));
 	if (!pages)
 		return -ENOMEM;
-	asce.val = get_vcpu_asce(vcpu);
 	need_ipte_lock = psw_bits(*psw).t && !asce.r;
 	if (need_ipte_lock)
 		ipte_lock(vcpu);
@@ -660,17 +833,12 @@ int guest_translate_address(struct kvm_vcpu *vcpu, unsigned long gva, ar_t ar,
 	union asce asce;
 	int rc;
 
-	/* Access register mode is not supported yet. */
-	if (psw_bits(*psw).t && psw_bits(*psw).as == PSW_AS_ACCREG)
-		return -EOPNOTSUPP;
-
 	gva = kvm_s390_logical_to_effective(vcpu, gva);
-	memset(pgm, 0, sizeof(*pgm));
 	tec = (struct trans_exc_code_bits *)&pgm->trans_exc_code;
-	tec->as = psw_bits(*psw).as;
-	tec->fsi = write ? FSI_STORE : FSI_FETCH;
+	rc = get_vcpu_asce(vcpu, &asce, ar, write);
 	tec->addr = gva >> PAGE_SHIFT;
-	asce.val = get_vcpu_asce(vcpu);
+	if (rc)
+		return rc;
 	if (is_low_address(gva) && low_address_protection_enabled(vcpu, asce)) {
 		if (write) {
 			rc = pgm->code = PGM_PROTECTION;
diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index 7c2866b..835e557 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -177,8 +177,7 @@ int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
  * If DAT is off data will be copied to guest real or absolute memory.
  * If DAT is on data will be copied to the address space as specified by
  * the address space bits of the PSW:
- * Primary, secondory or home space (access register mode is currently not
- * implemented).
+ * Primary, secondary, home space or access register mode.
  * The addressing mode of the PSW is also inspected, so that address wrap
  * around is taken into account for 24-, 31- and 64-bit addressing mode,
  * if the to be copied data crosses page boundaries in guest address space.
-- 
2.3.0
