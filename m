From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [RFC/PATCH 10/22] s390/mm: Add huge pmd storage key handling
Date: Mon,  6 Nov 2017 23:29:48 +0100
Message-ID: <1510007400-42493-11-git-send-email-frankja@linux.vnet.ibm.com>
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Storage keys for guests with huge page mappings have to directly set
the key in hardware. There are no PGSTEs for PMDs that we could use to
retain the guests's logical view of the key.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
---
 arch/s390/mm/pgtable.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 67 insertions(+), 4 deletions(-)

diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index c98fba9..5ce1232 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -765,12 +765,45 @@ EXPORT_SYMBOL_GPL(test_and_clear_guest_dirty);
 int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 			  unsigned char key, bool nq)
 {
-	unsigned long keyul;
+	unsigned long keyul, address;
 	spinlock_t *ptl;
 	pgste_t old, new;
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
 	pte_t *ptep;
 
-	ptep = get_locked_pte(mm, addr, &ptl);
+	pgd = pgd_offset(mm, addr);
+	p4d = p4d_alloc(mm, pgd, addr);
+	if (!p4d)
+		return -EFAULT;
+	pud = pud_alloc(mm, p4d, addr);
+	if (!pud)
+		return -EFAULT;
+	pmd = pmd_alloc(mm, pud, addr);
+	if (!pmd)
+		return -EFAULT;
+
+	ptl = pmd_lock(mm, pmd);
+	if (!pmd_present(*pmd)) {
+		spin_unlock(ptl);
+		return -EFAULT;
+	}
+	if (pmd_large(*pmd)) {
+		address = pmd_val(*pmd) & HPAGE_MASK;
+		address |= addr & ~HPAGE_MASK;
+		/*
+		 * Huge pmds need quiescing operations, they are
+		 * always mapped.
+		 */
+		page_set_storage_key(address, key, 1);
+		spin_unlock(ptl);
+		return 0;
+	}
+	spin_unlock(ptl);
+
+	ptep = pte_alloc_map_lock(mm, pmd, addr, &ptl);
 	if (unlikely(!ptep))
 		return -EFAULT;
 
@@ -781,7 +814,7 @@ int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 	pgste_val(new) |= (keyul & (_PAGE_CHANGED | _PAGE_REFERENCED)) << 48;
 	pgste_val(new) |= (keyul & (_PAGE_ACC_BITS | _PAGE_FP_BIT)) << 56;
 	if (!(pte_val(*ptep) & _PAGE_INVALID)) {
-		unsigned long address, bits, skey;
+		unsigned long bits, skey;
 
 		address = pte_val(*ptep) & PAGE_MASK;
 		skey = (unsigned long) page_get_storage_key(address);
@@ -876,11 +909,41 @@ EXPORT_SYMBOL(reset_guest_reference_bit);
 int get_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 			  unsigned char *key)
 {
+	unsigned long address;
 	spinlock_t *ptl;
 	pgste_t pgste;
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
 	pte_t *ptep;
 
-	ptep = get_locked_pte(mm, addr, &ptl);
+	pgd = pgd_offset(mm, addr);
+	p4d = p4d_alloc(mm, pgd, addr);
+	if (!p4d)
+		return -EFAULT;
+	pud = pud_alloc(mm, p4d, addr);
+	if (!pud)
+		return -EFAULT;
+	pmd = pmd_alloc(mm, pud, addr);
+	if (!pmd)
+		return -EFAULT;
+
+	ptl = pmd_lock(mm, pmd);
+	if (!pmd_present(*pmd)) {
+		spin_unlock(ptl);
+		return -EFAULT;
+	}
+	if (pmd_large(*pmd)) {
+		address = pmd_val(*pmd) & HPAGE_MASK;
+		address |= addr & ~HPAGE_MASK;
+		*key = page_get_storage_key(address);
+		spin_unlock(ptl);
+		return 0;
+	}
+	spin_unlock(ptl);
+
+	ptep = pte_alloc_map_lock(mm, pmd, addr, &ptl);
 	if (unlikely(!ptep))
 		return -EFAULT;
 
-- 
2.7.4
