From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL 6/8] KVM: s390/mm: use software dirty bit detection for user dirty tracking
Date: Wed,  9 Apr 2014 12:44:56 +0200
Message-ID: <1397040298-59306-7-git-send-email-borntraeger@de.ibm.com>
References: <1397040298-59306-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397040298-59306-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Switch the user dirty bit detection used for migration from the hardware
provided host change-bit in the storage key/pgste to a fault based
detection method. Turns out that this is actually faster than the
old storage key operations.
As a bonus, this reduces the dependency of the host from the storage key
to a point where it becomes possible to enable the RCP bypass for KVM
guests. In the future this might be used for backing guests with large
pages.

The fault based dirty detection will only indicate changes caused
by accesses via the guest address space. The hardware based method
can detect all changes, even those caused by I/O or accesses via the
kernel page table. The KVM/qemu code needs to take this into account.
Dirty tracking for vhost and I/O has the same challenge on x86, so
everything is already in place (vhost log, fallback no non-dataplane..)

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
[Dominik Dingel: fixups]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/pgtable.h | 135 +++++++++++++++++-----------------------
 arch/s390/mm/pgtable.c          |   6 +-
 2 files changed, 59 insertions(+), 82 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index bc4eb35..d75eb76 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -309,7 +309,8 @@ extern unsigned long MODULES_END;
 #define PGSTE_HC_BIT	0x00200000UL
 #define PGSTE_GR_BIT	0x00040000UL
 #define PGSTE_GC_BIT	0x00020000UL
-#define PGSTE_IN_BIT	0x00008000UL	/* IPTE notify bit */
+#define PGSTE_UC_BIT	0x00008000UL	/* user dirty (migration) */
+#define PGSTE_IN_BIT	0x00004000UL	/* IPTE notify bit */
 
 #else /* CONFIG_64BIT */
 
@@ -391,7 +392,8 @@ extern unsigned long MODULES_END;
 #define PGSTE_HC_BIT	0x0020000000000000UL
 #define PGSTE_GR_BIT	0x0004000000000000UL
 #define PGSTE_GC_BIT	0x0002000000000000UL
-#define PGSTE_IN_BIT	0x0000800000000000UL	/* IPTE notify bit */
+#define PGSTE_UC_BIT	0x0000800000000000UL	/* user dirty (migration) */
+#define PGSTE_IN_BIT	0x0000400000000000UL	/* IPTE notify bit */
 
 #endif /* CONFIG_64BIT */
 
@@ -720,16 +722,6 @@ static inline pgste_t pgste_update_all(pte_t *ptep, pgste_t pgste,
 	address = pte_val(*ptep) & PAGE_MASK;
 	skey = (unsigned long) page_get_storage_key(address);
 	bits = skey & (_PAGE_CHANGED | _PAGE_REFERENCED);
-	if (!(pgste_val(pgste) & PGSTE_HC_BIT) && (bits & _PAGE_CHANGED)) {
-		/* Transfer dirty + referenced bit to host bits in pgste */
-		pgste_val(pgste) |= bits << 52;
-		page_set_storage_key(address, skey ^ bits, 0);
-	} else if (!(pgste_val(pgste) & PGSTE_HR_BIT) &&
-		   (bits & _PAGE_REFERENCED)) {
-		/* Transfer referenced bit to host bit in pgste */
-		pgste_val(pgste) |= PGSTE_HR_BIT;
-		page_reset_referenced(address);
-	}
 	/* Transfer page changed & referenced bit to guest bits in pgste */
 	pgste_val(pgste) |= bits << 48;		/* GR bit & GC bit */
 	/* Copy page access key and fetch protection bit to pgste */
@@ -740,19 +732,6 @@ static inline pgste_t pgste_update_all(pte_t *ptep, pgste_t pgste,
 
 }
 
-static inline pgste_t pgste_update_young(pte_t *ptep, pgste_t pgste,
-					 struct mm_struct *mm)
-{
-#ifdef CONFIG_PGSTE
-	if (!mm_use_skey(mm) || pte_val(*ptep) & _PAGE_INVALID)
-		return pgste;
-	/* Get referenced bit from storage key */
-	if (page_reset_referenced(pte_val(*ptep) & PAGE_MASK))
-		pgste_val(pgste) |= PGSTE_HR_BIT | PGSTE_GR_BIT;
-#endif
-	return pgste;
-}
-
 static inline void pgste_set_key(pte_t *ptep, pgste_t pgste, pte_t entry,
 				 struct mm_struct *mm)
 {
@@ -770,23 +749,30 @@ static inline void pgste_set_key(pte_t *ptep, pgste_t pgste, pte_t entry,
 	 * key C/R to 0.
 	 */
 	nkey = (pgste_val(pgste) & (PGSTE_ACC_BITS | PGSTE_FP_BIT)) >> 56;
+	nkey |= (pgste_val(pgste) & (PGSTE_GR_BIT | PGSTE_GC_BIT)) >> 48;
 	page_set_storage_key(address, nkey, 0);
 #endif
 }
 
-static inline void pgste_set_pte(pte_t *ptep, pte_t entry)
+static inline pgste_t pgste_set_pte(pte_t *ptep, pgste_t pgste, pte_t entry)
 {
-	if (!MACHINE_HAS_ESOP &&
-	    (pte_val(entry) & _PAGE_PRESENT) &&
-	    (pte_val(entry) & _PAGE_WRITE)) {
-		/*
-		 * Without enhanced suppression-on-protection force
-		 * the dirty bit on for all writable ptes.
-		 */
-		pte_val(entry) |= _PAGE_DIRTY;
-		pte_val(entry) &= ~_PAGE_PROTECT;
+	if ((pte_val(entry) & _PAGE_PRESENT) &&
+	    (pte_val(entry) & _PAGE_WRITE) &&
+	    !(pte_val(entry) & _PAGE_INVALID)) {
+		if (!MACHINE_HAS_ESOP) {
+			/*
+			 * Without enhanced suppression-on-protection force
+			 * the dirty bit on for all writable ptes.
+			 */
+			pte_val(entry) |= _PAGE_DIRTY;
+			pte_val(entry) &= ~_PAGE_PROTECT;
+		}
+		if (!(pte_val(entry) & _PAGE_PROTECT))
+			/* This pte allows write access, set user-dirty */
+			pgste_val(pgste) |= PGSTE_UC_BIT;
 	}
 	*ptep = entry;
+	return pgste;
 }
 
 /**
@@ -884,7 +870,7 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 		pgste = pgste_get_lock(ptep);
 		pgste_val(pgste) &= ~_PGSTE_GPS_ZERO;
 		pgste_set_key(ptep, pgste, entry, mm);
-		pgste_set_pte(ptep, entry);
+		pgste = pgste_set_pte(ptep, pgste, entry);
 		pgste_set_unlock(ptep, pgste);
 	} else {
 		if (!(pte_val(entry) & _PAGE_INVALID) && MACHINE_HAS_EDAT1)
@@ -1030,45 +1016,6 @@ static inline pte_t pte_mkhuge(pte_t pte)
 }
 #endif
 
-/*
- * Get (and clear) the user dirty bit for a pte.
- */
-static inline int ptep_test_and_clear_user_dirty(struct mm_struct *mm,
-						 pte_t *ptep)
-{
-	pgste_t pgste;
-	int dirty = 0;
-
-	if (mm_has_pgste(mm)) {
-		pgste = pgste_get_lock(ptep);
-		pgste = pgste_update_all(ptep, pgste, mm);
-		dirty = !!(pgste_val(pgste) & PGSTE_HC_BIT);
-		pgste_val(pgste) &= ~PGSTE_HC_BIT;
-		pgste_set_unlock(ptep, pgste);
-		return dirty;
-	}
-	return dirty;
-}
-
-/*
- * Get (and clear) the user referenced bit for a pte.
- */
-static inline int ptep_test_and_clear_user_young(struct mm_struct *mm,
-						 pte_t *ptep)
-{
-	pgste_t pgste;
-	int young = 0;
-
-	if (mm_has_pgste(mm)) {
-		pgste = pgste_get_lock(ptep);
-		pgste = pgste_update_young(ptep, pgste, mm);
-		young = !!(pgste_val(pgste) & PGSTE_HR_BIT);
-		pgste_val(pgste) &= ~PGSTE_HR_BIT;
-		pgste_set_unlock(ptep, pgste);
-	}
-	return young;
-}
-
 static inline void __ptep_ipte(unsigned long address, pte_t *ptep)
 {
 	unsigned long pto = (unsigned long) ptep;
@@ -1108,6 +1055,36 @@ static inline void ptep_flush_lazy(struct mm_struct *mm,
 	atomic_sub(0x10000, &mm->context.attach_count);
 }
 
+/*
+ * Get (and clear) the user dirty bit for a pte.
+ */
+static inline int ptep_test_and_clear_user_dirty(struct mm_struct *mm,
+						 unsigned long addr,
+						 pte_t *ptep)
+{
+	pgste_t pgste;
+	pte_t pte;
+	int dirty;
+
+	if (!mm_has_pgste(mm))
+		return 0;
+	pgste = pgste_get_lock(ptep);
+	dirty = !!(pgste_val(pgste) & PGSTE_UC_BIT);
+	pgste_val(pgste) &= ~PGSTE_UC_BIT;
+	pte = *ptep;
+	if (dirty && (pte_val(pte) & _PAGE_PRESENT)) {
+		pgste = pgste_ipte_notify(mm, ptep, pgste);
+		__ptep_ipte(addr, ptep);
+		if (MACHINE_HAS_ESOP || !(pte_val(pte) & _PAGE_WRITE))
+			pte_val(pte) |= _PAGE_PROTECT;
+		else
+			pte_val(pte) |= _PAGE_INVALID;
+		*ptep = pte;
+	}
+	pgste_set_unlock(ptep, pgste);
+	return dirty;
+}
+
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 					    unsigned long addr, pte_t *ptep)
@@ -1127,7 +1104,7 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 	pte = pte_mkold(pte);
 
 	if (mm_has_pgste(vma->vm_mm)) {
-		pgste_set_pte(ptep, pte);
+		pgste = pgste_set_pte(ptep, pgste, pte);
 		pgste_set_unlock(ptep, pgste);
 	} else
 		*ptep = pte;
@@ -1210,7 +1187,7 @@ static inline void ptep_modify_prot_commit(struct mm_struct *mm,
 	if (mm_has_pgste(mm)) {
 		pgste = pgste_get(ptep);
 		pgste_set_key(ptep, pgste, pte, mm);
-		pgste_set_pte(ptep, pte);
+		pgste = pgste_set_pte(ptep, pgste, pte);
 		pgste_set_unlock(ptep, pgste);
 	} else
 		*ptep = pte;
@@ -1291,7 +1268,7 @@ static inline pte_t ptep_set_wrprotect(struct mm_struct *mm,
 		pte = pte_wrprotect(pte);
 
 		if (mm_has_pgste(mm)) {
-			pgste_set_pte(ptep, pte);
+			pgste = pgste_set_pte(ptep, pgste, pte);
 			pgste_set_unlock(ptep, pgste);
 		} else
 			*ptep = pte;
@@ -1316,7 +1293,7 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
 	ptep_flush_direct(vma->vm_mm, address, ptep);
 
 	if (mm_has_pgste(vma->vm_mm)) {
-		pgste_set_pte(ptep, entry);
+		pgste = pgste_set_pte(ptep, pgste, entry);
 		pgste_set_unlock(ptep, pgste);
 	} else
 		*ptep = entry;
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 25e4a2a..442a266 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -827,6 +827,7 @@ void gmap_do_ipte_notify(struct mm_struct *mm, pte_t *pte)
 	}
 	spin_unlock(&gmap_notifier_lock);
 }
+EXPORT_SYMBOL_GPL(gmap_do_ipte_notify);
 
 static inline int page_table_with_pgste(struct page *page)
 {
@@ -859,8 +860,7 @@ static inline unsigned long *page_table_alloc_pgste(struct mm_struct *mm,
 	atomic_set(&page->_mapcount, 0);
 	table = (unsigned long *) page_to_phys(page);
 	clear_table(table, _PAGE_INVALID, PAGE_SIZE/2);
-	clear_table(table + PTRS_PER_PTE, PGSTE_HR_BIT | PGSTE_HC_BIT,
-		    PAGE_SIZE/2);
+	clear_table(table + PTRS_PER_PTE, 0, PAGE_SIZE/2);
 	return table;
 }
 
@@ -1000,7 +1000,7 @@ int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 	/* changing the guest storage key is considered a change of the page */
 	if ((pgste_val(new) ^ pgste_val(old)) &
 	    (PGSTE_ACC_BITS | PGSTE_FP_BIT | PGSTE_GR_BIT | PGSTE_GC_BIT))
-		pgste_val(new) |= PGSTE_HC_BIT;
+		pgste_val(new) |= PGSTE_UC_BIT;
 
 	pgste_set_unlock(ptep, new);
 	pte_unmap_unlock(*ptep, ptl);
-- 
1.8.4.2
