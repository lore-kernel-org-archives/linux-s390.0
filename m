From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 2/5] KVM: s390: Adding skey bit to mmu context
Date: Wed,  2 Apr 2014 11:24:45 +0200
Message-ID: <1396430688-53629-3-git-send-email-borntraeger@de.ibm.com>
References: <1396430688-53629-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1396430688-53629-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Dominik Dingel <dingel@linux.vnet.ibm.com>

For lazy storage key handling, we need a mechanism to track if the
process ever issued a storage key operation.

This patch adds the basic infrastructure for making the storage
key handling optional, but still leaves it enabled for now by default.

Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/mmu.h         |  2 ++
 arch/s390/include/asm/mmu_context.h |  1 +
 arch/s390/include/asm/pgtable.h     | 41 ++++++++++++++++++++++++-------------
 3 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/arch/s390/include/asm/mmu.h b/arch/s390/include/asm/mmu.h
index ff132ac..665cfb3 100644
--- a/arch/s390/include/asm/mmu.h
+++ b/arch/s390/include/asm/mmu.h
@@ -14,6 +14,8 @@ typedef struct {
 	unsigned long vdso_base;
 	/* The mmu context has extended page tables. */
 	unsigned int has_pgste:1;
+	/* The mmu context uses storage keys. */
+	unsigned int use_skey:1;
 } mm_context_t;
 
 #define INIT_MM_CONTEXT(name)						      \
diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index 5d1f950..c913486 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -22,6 +22,7 @@ static inline int init_new_context(struct task_struct *tsk,
 	mm->context.asce_bits |= _ASCE_TYPE_REGION3;
 #endif
 	mm->context.has_pgste = 0;
+	mm->context.use_skey = 1;
 	mm->context.asce_limit = STACK_TOP_MAX;
 	crst_table_init((unsigned long *) mm->pgd, pgd_entry_type(mm));
 	return 0;
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 8d23a15..a82678e 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -466,6 +466,16 @@ static inline int mm_has_pgste(struct mm_struct *mm)
 #endif
 	return 0;
 }
+
+static inline int mm_use_skey(struct mm_struct *mm)
+{
+#ifdef CONFIG_PGSTE
+	if (mm->context.use_skey)
+		return 1;
+#endif
+	return 0;
+}
+
 /*
  * pgd/pmd/pte query functions
  */
@@ -699,12 +709,13 @@ static inline void pgste_set(pte_t *ptep, pgste_t pgste)
 #endif
 }
 
-static inline pgste_t pgste_update_all(pte_t *ptep, pgste_t pgste)
+static inline pgste_t pgste_update_all(pte_t *ptep, pgste_t pgste,
+				       struct mm_struct *mm)
 {
 #ifdef CONFIG_PGSTE
 	unsigned long address, bits, skey;
 
-	if (pte_val(*ptep) & _PAGE_INVALID)
+	if (!mm_use_skey(mm) || pte_val(*ptep) & _PAGE_INVALID)
 		return pgste;
 	address = pte_val(*ptep) & PAGE_MASK;
 	skey = (unsigned long) page_get_storage_key(address);
@@ -729,10 +740,11 @@ static inline pgste_t pgste_update_all(pte_t *ptep, pgste_t pgste)
 
 }
 
-static inline pgste_t pgste_update_young(pte_t *ptep, pgste_t pgste)
+static inline pgste_t pgste_update_young(pte_t *ptep, pgste_t pgste,
+					 struct mm_struct *mm)
 {
 #ifdef CONFIG_PGSTE
-	if (pte_val(*ptep) & _PAGE_INVALID)
+	if (!mm_use_skey(mm) || pte_val(*ptep) & _PAGE_INVALID)
 		return pgste;
 	/* Get referenced bit from storage key */
 	if (page_reset_referenced(pte_val(*ptep) & PAGE_MASK))
@@ -741,13 +753,14 @@ static inline pgste_t pgste_update_young(pte_t *ptep, pgste_t pgste)
 	return pgste;
 }
 
-static inline void pgste_set_key(pte_t *ptep, pgste_t pgste, pte_t entry)
+static inline void pgste_set_key(pte_t *ptep, pgste_t pgste, pte_t entry,
+				 struct mm_struct *mm)
 {
 #ifdef CONFIG_PGSTE
 	unsigned long address;
 	unsigned long nkey;
 
-	if (pte_val(entry) & _PAGE_INVALID)
+	if (!mm_use_skey(mm) || pte_val(entry) & _PAGE_INVALID)
 		return;
 	VM_BUG_ON(!(pte_val(*ptep) & _PAGE_INVALID));
 	address = pte_val(entry) & PAGE_MASK;
@@ -871,7 +884,7 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 	if (mm_has_pgste(mm)) {
 		pgste = pgste_get_lock(ptep);
 		pgste_val(pgste) &= ~_PGSTE_GPS_ZERO;
-		pgste_set_key(ptep, pgste, entry);
+		pgste_set_key(ptep, pgste, entry, mm);
 		pgste_set_pte(ptep, entry);
 		pgste_set_unlock(ptep, pgste);
 	} else {
@@ -1029,7 +1042,7 @@ static inline int ptep_test_and_clear_user_dirty(struct mm_struct *mm,
 
 	if (mm_has_pgste(mm)) {
 		pgste = pgste_get_lock(ptep);
-		pgste = pgste_update_all(ptep, pgste);
+		pgste = pgste_update_all(ptep, pgste, mm);
 		dirty = !!(pgste_val(pgste) & PGSTE_HC_BIT);
 		pgste_val(pgste) &= ~PGSTE_HC_BIT;
 		pgste_set_unlock(ptep, pgste);
@@ -1049,7 +1062,7 @@ static inline int ptep_test_and_clear_user_young(struct mm_struct *mm,
 
 	if (mm_has_pgste(mm)) {
 		pgste = pgste_get_lock(ptep);
-		pgste = pgste_update_young(ptep, pgste);
+		pgste = pgste_update_young(ptep, pgste, mm);
 		young = !!(pgste_val(pgste) & PGSTE_HR_BIT);
 		pgste_val(pgste) &= ~PGSTE_HR_BIT;
 		pgste_set_unlock(ptep, pgste);
@@ -1149,7 +1162,7 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 	pte_val(*ptep) = _PAGE_INVALID;
 
 	if (mm_has_pgste(mm)) {
-		pgste = pgste_update_all(&pte, pgste);
+		pgste = pgste_update_all(&pte, pgste, mm);
 		pgste_set_unlock(ptep, pgste);
 	}
 	return pte;
@@ -1173,7 +1186,7 @@ static inline pte_t ptep_modify_prot_start(struct mm_struct *mm,
 	pte_val(*ptep) |= _PAGE_INVALID;
 
 	if (mm_has_pgste(mm)) {
-		pgste = pgste_update_all(&pte, pgste);
+		pgste = pgste_update_all(&pte, pgste, mm);
 		pgste_set(ptep, pgste);
 	}
 	return pte;
@@ -1187,7 +1200,7 @@ static inline void ptep_modify_prot_commit(struct mm_struct *mm,
 
 	if (mm_has_pgste(mm)) {
 		pgste = pgste_get(ptep);
-		pgste_set_key(ptep, pgste, pte);
+		pgste_set_key(ptep, pgste, pte, mm);
 		pgste_set_pte(ptep, pte);
 		pgste_set_unlock(ptep, pgste);
 	} else
@@ -1214,7 +1227,7 @@ static inline pte_t ptep_clear_flush(struct vm_area_struct *vma,
 		if ((pgste_val(pgste) & _PGSTE_GPS_USAGE_MASK) ==
 		    _PGSTE_GPS_USAGE_UNUSED)
 			pte_val(pte) |= _PAGE_UNUSED;
-		pgste = pgste_update_all(&pte, pgste);
+		pgste = pgste_update_all(&pte, pgste, vma->vm_mm);
 		pgste_set_unlock(ptep, pgste);
 	}
 	return pte;
@@ -1246,7 +1259,7 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
 	pte_val(*ptep) = _PAGE_INVALID;
 
 	if (!full && mm_has_pgste(mm)) {
-		pgste = pgste_update_all(&pte, pgste);
+		pgste = pgste_update_all(&pte, pgste, mm);
 		pgste_set_unlock(ptep, pgste);
 	}
 	return pte;
-- 
1.8.4.2
