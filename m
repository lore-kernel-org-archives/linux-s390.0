From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 31 Jul 2018 08:44:00 +0000
Subject: [GIT PULL 14/19] s390/mm: Add huge pmd storage key handling
Message-Id: <20180731084405.28953-15-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Janosch Frank <frankja@linux.ibm.com>

Storage keys for guests with huge page mappings have to be managed in
hardware. There are no PGSTEs for PMDs that we could use to retain the
guests's logical view of the key.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/pgtable.c | 108 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 98 insertions(+), 10 deletions(-)

diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 684df964e345..37d68706f5aa 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -410,6 +410,24 @@ static inline pmd_t pmdp_flush_lazy(struct mm_struct *mm,
 	return old;
 }
 
+static pmd_t *pmd_alloc_map(struct mm_struct *mm, unsigned long addr)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	pgd = pgd_offset(mm, addr);
+	p4d = p4d_alloc(mm, pgd, addr);
+	if (!p4d)
+		return NULL;
+	pud = pud_alloc(mm, p4d, addr);
+	if (!pud)
+		return NULL;
+	pmd = pmd_alloc(mm, pud, addr);
+	return pmd;
+}
+
 pmd_t pmdp_xchg_direct(struct mm_struct *mm, unsigned long addr,
 		       pmd_t *pmdp, pmd_t new)
 {
@@ -734,12 +752,36 @@ EXPORT_SYMBOL_GPL(ptep_test_and_clear_uc);
 int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 			  unsigned char key, bool nq)
 {
-	unsigned long keyul;
+	unsigned long keyul, paddr;
 	spinlock_t *ptl;
 	pgste_t old, new;
+	pmd_t *pmdp;
 	pte_t *ptep;
 
-	ptep = get_locked_pte(mm, addr, &ptl);
+	pmdp = pmd_alloc_map(mm, addr);
+	if (unlikely(!pmdp))
+		return -EFAULT;
+
+	ptl = pmd_lock(mm, pmdp);
+	if (!pmd_present(*pmdp)) {
+		spin_unlock(ptl);
+		return -EFAULT;
+	}
+
+	if (pmd_large(*pmdp)) {
+		paddr = pmd_val(*pmdp) & HPAGE_MASK;
+		paddr |= addr & ~HPAGE_MASK;
+		/*
+		 * Huge pmds need quiescing operations, they are
+		 * always mapped.
+		 */
+		page_set_storage_key(paddr, key, 1);
+		spin_unlock(ptl);
+		return 0;
+	}
+	spin_unlock(ptl);
+
+	ptep = pte_alloc_map_lock(mm, pmdp, addr, &ptl);
 	if (unlikely(!ptep))
 		return -EFAULT;
 
@@ -750,14 +792,14 @@ int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 	pgste_val(new) |= (keyul & (_PAGE_CHANGED | _PAGE_REFERENCED)) << 48;
 	pgste_val(new) |= (keyul & (_PAGE_ACC_BITS | _PAGE_FP_BIT)) << 56;
 	if (!(pte_val(*ptep) & _PAGE_INVALID)) {
-		unsigned long address, bits, skey;
+		unsigned long bits, skey;
 
-		address = pte_val(*ptep) & PAGE_MASK;
-		skey = (unsigned long) page_get_storage_key(address);
+		paddr = pte_val(*ptep) & PAGE_MASK;
+		skey = (unsigned long) page_get_storage_key(paddr);
 		bits = skey & (_PAGE_CHANGED | _PAGE_REFERENCED);
 		skey = key & (_PAGE_ACC_BITS | _PAGE_FP_BIT);
 		/* Set storage key ACC and FP */
-		page_set_storage_key(address, skey, !nq);
+		page_set_storage_key(paddr, skey, !nq);
 		/* Merge host changed & referenced into pgste  */
 		pgste_val(new) |= bits << 52;
 	}
@@ -813,11 +855,32 @@ EXPORT_SYMBOL(cond_set_guest_storage_key);
 int reset_guest_reference_bit(struct mm_struct *mm, unsigned long addr)
 {
 	spinlock_t *ptl;
+	unsigned long paddr;
 	pgste_t old, new;
+	pmd_t *pmdp;
 	pte_t *ptep;
 	int cc = 0;
 
-	ptep = get_locked_pte(mm, addr, &ptl);
+	pmdp = pmd_alloc_map(mm, addr);
+	if (unlikely(!pmdp))
+		return -EFAULT;
+
+	ptl = pmd_lock(mm, pmdp);
+	if (!pmd_present(*pmdp)) {
+		spin_unlock(ptl);
+		return -EFAULT;
+	}
+
+	if (pmd_large(*pmdp)) {
+		paddr = pmd_val(*pmdp) & HPAGE_MASK;
+		paddr |= addr & ~HPAGE_MASK;
+		cc = page_reset_referenced(paddr);
+		spin_unlock(ptl);
+		return cc;
+	}
+	spin_unlock(ptl);
+
+	ptep = pte_alloc_map_lock(mm, pmdp, addr, &ptl);
 	if (unlikely(!ptep))
 		return -EFAULT;
 
@@ -826,7 +889,8 @@ int reset_guest_reference_bit(struct mm_struct *mm, unsigned long addr)
 	pgste_val(new) &= ~PGSTE_GR_BIT;
 
 	if (!(pte_val(*ptep) & _PAGE_INVALID)) {
-		cc = page_reset_referenced(pte_val(*ptep) & PAGE_MASK);
+		paddr = pte_val(*ptep) & PAGE_MASK;
+		cc = page_reset_referenced(paddr);
 		/* Merge real referenced bit into host-set */
 		pgste_val(new) |= ((unsigned long) cc << 53) & PGSTE_HR_BIT;
 	}
@@ -845,18 +909,42 @@ EXPORT_SYMBOL(reset_guest_reference_bit);
 int get_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 			  unsigned char *key)
 {
+	unsigned long paddr;
 	spinlock_t *ptl;
 	pgste_t pgste;
+	pmd_t *pmdp;
 	pte_t *ptep;
 
-	ptep = get_locked_pte(mm, addr, &ptl);
+	pmdp = pmd_alloc_map(mm, addr);
+	if (unlikely(!pmdp))
+		return -EFAULT;
+
+	ptl = pmd_lock(mm, pmdp);
+	if (!pmd_present(*pmdp)) {
+		/* Not yet mapped memory has a zero key */
+		spin_unlock(ptl);
+		*key = 0;
+		return 0;
+	}
+
+	if (pmd_large(*pmdp)) {
+		paddr = pmd_val(*pmdp) & HPAGE_MASK;
+		paddr |= addr & ~HPAGE_MASK;
+		*key = page_get_storage_key(paddr);
+		spin_unlock(ptl);
+		return 0;
+	}
+	spin_unlock(ptl);
+
+	ptep = pte_alloc_map_lock(mm, pmdp, addr, &ptl);
 	if (unlikely(!ptep))
 		return -EFAULT;
 
 	pgste = pgste_get_lock(ptep);
 	*key = (pgste_val(pgste) & (PGSTE_ACC_BITS | PGSTE_FP_BIT)) >> 56;
+	paddr = pte_val(*ptep) & PAGE_MASK;
 	if (!(pte_val(*ptep) & _PAGE_INVALID))
-		*key = page_get_storage_key(pte_val(*ptep) & PAGE_MASK);
+		*key = page_get_storage_key(paddr);
 	/* Reflect guest's logical view, not physical */
 	*key |= (pgste_val(pgste) & (PGSTE_GR_BIT | PGSTE_GC_BIT)) >> 48;
 	pgste_set_unlock(ptep, pgste);
-- 
2.17.0
