From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 3/8] s390/kvm: rename RCP_xxx defines to PGSTE_xxx
Date: Fri, 17 May 2013 14:41:33 +0200
Message-ID: <1368794498-2051-4-git-send-email-borntraeger@de.ibm.com>
References: <1368794498-2051-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1368794498-2051-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tossati <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The RCP byte is a part of the PGSTE value, the existing RCP_xxx names
are inaccurate. As the defines describe bits and pieces of the PGSTE,
the names should start with PGSTE_. The KVM_UR_BIT and KVM_UC_BIT are
part of the PGSTE as well, give them better names as well.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/pgtable.h | 82 ++++++++++++++++++++---------------------
 arch/s390/mm/pgtable.c          |  2 +-
 2 files changed, 40 insertions(+), 44 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 0f0de30..1fc68d9 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -299,18 +299,16 @@ extern unsigned long MODULES_END;
 #define _SEGMENT_ENTRY_EMPTY	(_SEGMENT_ENTRY_INV)
 
 /* Page status table bits for virtualization */
-#define RCP_ACC_BITS	0xf0000000UL
-#define RCP_FP_BIT	0x08000000UL
-#define RCP_PCL_BIT	0x00800000UL
-#define RCP_HR_BIT	0x00400000UL
-#define RCP_HC_BIT	0x00200000UL
-#define RCP_GR_BIT	0x00040000UL
-#define RCP_GC_BIT	0x00020000UL
-#define RCP_IN_BIT	0x00002000UL	/* IPTE notify bit */
-
-/* User dirty / referenced bit for KVM's migration feature */
-#define KVM_UR_BIT	0x00008000UL
-#define KVM_UC_BIT	0x00004000UL
+#define PGSTE_ACC_BITS	0xf0000000UL
+#define PGSTE_FP_BIT	0x08000000UL
+#define PGSTE_PCL_BIT	0x00800000UL
+#define PGSTE_HR_BIT	0x00400000UL
+#define PGSTE_HC_BIT	0x00200000UL
+#define PGSTE_GR_BIT	0x00040000UL
+#define PGSTE_GC_BIT	0x00020000UL
+#define PGSTE_UR_BIT	0x00008000UL
+#define PGSTE_UC_BIT	0x00004000UL	/* user dirty (migration) */
+#define PGSTE_IN_BIT	0x00002000UL	/* IPTE notify bit */
 
 #else /* CONFIG_64BIT */
 
@@ -367,18 +365,16 @@ extern unsigned long MODULES_END;
 				 | _SEGMENT_ENTRY_SPLIT | _SEGMENT_ENTRY_CO)
 
 /* Page status table bits for virtualization */
-#define RCP_ACC_BITS	0xf000000000000000UL
-#define RCP_FP_BIT	0x0800000000000000UL
-#define RCP_PCL_BIT	0x0080000000000000UL
-#define RCP_HR_BIT	0x0040000000000000UL
-#define RCP_HC_BIT	0x0020000000000000UL
-#define RCP_GR_BIT	0x0004000000000000UL
-#define RCP_GC_BIT	0x0002000000000000UL
-#define RCP_IN_BIT	0x0000200000000000UL	/* IPTE notify bit */
-
-/* User dirty / referenced bit for KVM's migration feature */
-#define KVM_UR_BIT	0x0000800000000000UL
-#define KVM_UC_BIT	0x0000400000000000UL
+#define PGSTE_ACC_BITS	0xf000000000000000UL
+#define PGSTE_FP_BIT	0x0800000000000000UL
+#define PGSTE_PCL_BIT	0x0080000000000000UL
+#define PGSTE_HR_BIT	0x0040000000000000UL
+#define PGSTE_HC_BIT	0x0020000000000000UL
+#define PGSTE_GR_BIT	0x0004000000000000UL
+#define PGSTE_GC_BIT	0x0002000000000000UL
+#define PGSTE_UR_BIT	0x0000800000000000UL
+#define PGSTE_UC_BIT	0x0000400000000000UL	/* user dirty (migration) */
+#define PGSTE_IN_BIT	0x0000200000000000UL	/* IPTE notify bit */
 
 #endif /* CONFIG_64BIT */
 
@@ -618,8 +614,8 @@ static inline pgste_t pgste_get_lock(pte_t *ptep)
 	asm(
 		"	lg	%0,%2\n"
 		"0:	lgr	%1,%0\n"
-		"	nihh	%0,0xff7f\n"	/* clear RCP_PCL_BIT in old */
-		"	oihh	%1,0x0080\n"	/* set RCP_PCL_BIT in new */
+		"	nihh	%0,0xff7f\n"	/* clear PCL bit in old */
+		"	oihh	%1,0x0080\n"	/* set PCL bit in new */
 		"	csg	%0,%1,%2\n"
 		"	jl	0b\n"
 		: "=&d" (old), "=&d" (new), "=Q" (ptep[PTRS_PER_PTE])
@@ -632,7 +628,7 @@ static inline void pgste_set_unlock(pte_t *ptep, pgste_t pgste)
 {
 #ifdef CONFIG_PGSTE
 	asm(
-		"	nihh	%1,0xff7f\n"	/* clear RCP_PCL_BIT */
+		"	nihh	%1,0xff7f\n"	/* clear PCL bit */
 		"	stg	%1,%0\n"
 		: "=Q" (ptep[PTRS_PER_PTE])
 		: "d" (pgste_val(pgste)), "Q" (ptep[PTRS_PER_PTE]) : "cc");
@@ -657,14 +653,14 @@ static inline pgste_t pgste_update_all(pte_t *ptep, pgste_t pgste)
 	else if (bits)
 		page_reset_referenced(address);
 	/* Transfer page changed & referenced bit to guest bits in pgste */
-	pgste_val(pgste) |= bits << 48;		/* RCP_GR_BIT & RCP_GC_BIT */
+	pgste_val(pgste) |= bits << 48;		/* GR bit & GC bit */
 	/* Get host changed & referenced bits from pgste */
-	bits |= (pgste_val(pgste) & (RCP_HR_BIT | RCP_HC_BIT)) >> 52;
+	bits |= (pgste_val(pgste) & (PGSTE_HR_BIT | PGSTE_HC_BIT)) >> 52;
 	/* Transfer page changed & referenced bit to kvm user bits */
-	pgste_val(pgste) |= bits << 45;		/* KVM_UR_BIT & KVM_UC_BIT */
+	pgste_val(pgste) |= bits << 45;		/* PGSTE_UR_BIT & PGSTE_UC_BIT */
 	/* Clear relevant host bits in pgste. */
-	pgste_val(pgste) &= ~(RCP_HR_BIT | RCP_HC_BIT);
-	pgste_val(pgste) &= ~(RCP_ACC_BITS | RCP_FP_BIT);
+	pgste_val(pgste) &= ~(PGSTE_HR_BIT | PGSTE_HC_BIT);
+	pgste_val(pgste) &= ~(PGSTE_ACC_BITS | PGSTE_FP_BIT);
 	/* Copy page access key and fetch protection bit to pgste */
 	pgste_val(pgste) |=
 		(unsigned long) (skey & (_PAGE_ACC_BITS | _PAGE_FP_BIT)) << 56;
@@ -685,15 +681,15 @@ static inline pgste_t pgste_update_young(pte_t *ptep, pgste_t pgste)
 	/* Get referenced bit from storage key */
 	young = page_reset_referenced(pte_val(*ptep) & PAGE_MASK);
 	if (young)
-		pgste_val(pgste) |= RCP_GR_BIT;
+		pgste_val(pgste) |= PGSTE_GR_BIT;
 	/* Get host referenced bit from pgste */
-	if (pgste_val(pgste) & RCP_HR_BIT) {
-		pgste_val(pgste) &= ~RCP_HR_BIT;
+	if (pgste_val(pgste) & PGSTE_HR_BIT) {
+		pgste_val(pgste) &= ~PGSTE_HR_BIT;
 		young = 1;
 	}
 	/* Transfer referenced bit to kvm user bits and pte */
 	if (young) {
-		pgste_val(pgste) |= KVM_UR_BIT;
+		pgste_val(pgste) |= PGSTE_UR_BIT;
 		pte_val(*ptep) |= _PAGE_SWR;
 	}
 #endif
@@ -712,7 +708,7 @@ static inline void pgste_set_key(pte_t *ptep, pgste_t pgste, pte_t entry)
 	okey = nkey = page_get_storage_key(address);
 	nkey &= ~(_PAGE_ACC_BITS | _PAGE_FP_BIT);
 	/* Set page access key and fetch protection bit from pgste */
-	nkey |= (pgste_val(pgste) & (RCP_ACC_BITS | RCP_FP_BIT)) >> 56;
+	nkey |= (pgste_val(pgste) & (PGSTE_ACC_BITS | PGSTE_FP_BIT)) >> 56;
 	if (okey != nkey)
 		page_set_storage_key(address, nkey, 0);
 #endif
@@ -801,8 +797,8 @@ static inline pgste_t pgste_ipte_notify(struct mm_struct *mm,
 					pte_t *ptep, pgste_t pgste)
 {
 #ifdef CONFIG_PGSTE
-	if (pgste_val(pgste) & RCP_IN_BIT) {
-		pgste_val(pgste) &= ~RCP_IN_BIT;
+	if (pgste_val(pgste) & PGSTE_IN_BIT) {
+		pgste_val(pgste) &= ~PGSTE_IN_BIT;
 		gmap_do_ipte_notify(mm, addr, ptep);
 	}
 #endif
@@ -970,8 +966,8 @@ static inline int ptep_test_and_clear_user_dirty(struct mm_struct *mm,
 	if (mm_has_pgste(mm)) {
 		pgste = pgste_get_lock(ptep);
 		pgste = pgste_update_all(ptep, pgste);
-		dirty = !!(pgste_val(pgste) & KVM_UC_BIT);
-		pgste_val(pgste) &= ~KVM_UC_BIT;
+		dirty = !!(pgste_val(pgste) & PGSTE_UC_BIT);
+		pgste_val(pgste) &= ~PGSTE_UC_BIT;
 		pgste_set_unlock(ptep, pgste);
 		return dirty;
 	}
@@ -990,8 +986,8 @@ static inline int ptep_test_and_clear_user_young(struct mm_struct *mm,
 	if (mm_has_pgste(mm)) {
 		pgste = pgste_get_lock(ptep);
 		pgste = pgste_update_young(ptep, pgste);
-		young = !!(pgste_val(pgste) & KVM_UR_BIT);
-		pgste_val(pgste) &= ~KVM_UR_BIT;
+		young = !!(pgste_val(pgste) & PGSTE_UR_BIT);
+		pgste_val(pgste) &= ~PGSTE_UR_BIT;
 		pgste_set_unlock(ptep, pgste);
 	}
 	return young;
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 7805ddc..5ca7568 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -690,7 +690,7 @@ int gmap_ipte_notify(struct gmap *gmap, unsigned long start, unsigned long len)
 		entry = *ptep;
 		if ((pte_val(entry) & (_PAGE_INVALID | _PAGE_RO)) == 0) {
 			pgste = pgste_get_lock(ptep);
-			pgste_val(pgste) |= RCP_IN_BIT;
+			pgste_val(pgste) |= PGSTE_IN_BIT;
 			pgste_set_unlock(ptep, pgste);
 			start += PAGE_SIZE;
 			len -= PAGE_SIZE;
-- 
1.8.1.4
