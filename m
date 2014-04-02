From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 3/5] KVM: s390: Clear storage keys
Date: Wed,  2 Apr 2014 11:24:46 +0200
Message-ID: <1396430688-53629-4-git-send-email-borntraeger@de.ibm.com>
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

page_table_reset_pgste() already does a complete page table walk to
reset the pgste. Enhance it to initialize the storage keys to
PAGE_DEFAULT_KEY if requested by the caller.

The current caller, the config device will not make use of this right
now, but this will be used by lazy sske handling.

Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/pgalloc.h |  3 ++-
 arch/s390/mm/pgtable.c          | 38 +++++++++++++++++++++++++++-----------
 2 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
index 14d43c7..82f7d12 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -22,7 +22,8 @@ unsigned long *page_table_alloc(struct mm_struct *, unsigned long);
 void page_table_free(struct mm_struct *, unsigned long *);
 void page_table_free_rcu(struct mmu_gather *, unsigned long *);
 
-void page_table_reset_pgste(struct mm_struct *, unsigned long, unsigned long);
+void page_table_reset_pgste(struct mm_struct *, unsigned long, unsigned long,
+			    bool init_skey);
 int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 			  unsigned long key, bool nq);
 
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 9c26b7a..02a3575 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -879,8 +879,8 @@ static inline void page_table_free_pgste(unsigned long *table)
 	__free_page(page);
 }
 
-static inline unsigned long page_table_reset_pte(struct mm_struct *mm,
-			pmd_t *pmd, unsigned long addr, unsigned long end)
+static inline unsigned long page_table_reset_pte(struct mm_struct *mm, pmd_t *pmd,
+			unsigned long addr, unsigned long end, bool init_skey)
 {
 	pte_t *start_pte, *pte;
 	spinlock_t *ptl;
@@ -891,6 +891,22 @@ static inline unsigned long page_table_reset_pte(struct mm_struct *mm,
 	do {
 		pgste = pgste_get_lock(pte);
 		pgste_val(pgste) &= ~_PGSTE_GPS_USAGE_MASK;
+		if (init_skey) {
+			unsigned long address;
+
+			pgste_val(pgste) &= ~(PGSTE_ACC_BITS | PGSTE_FP_BIT |
+					      PGSTE_GR_BIT | PGSTE_GC_BIT);
+
+			/* skip invalid and not writable pages */
+			if (pte_val(*pte) & _PAGE_INVALID ||
+			    !(pte_val(*pte) & _PAGE_WRITE)) {
+				pgste_set_unlock(pte, pgste);
+				continue;
+			}
+
+			address = pte_val(*pte) & PAGE_MASK;
+			page_set_storage_key(address, PAGE_DEFAULT_KEY, 1);
+		}
 		pgste_set_unlock(pte, pgste);
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	pte_unmap_unlock(start_pte, ptl);
@@ -898,8 +914,8 @@ static inline unsigned long page_table_reset_pte(struct mm_struct *mm,
 	return addr;
 }
 
-static inline unsigned long page_table_reset_pmd(struct mm_struct *mm,
-			pud_t *pud, unsigned long addr, unsigned long end)
+static inline unsigned long page_table_reset_pmd(struct mm_struct *mm, pud_t *pud,
+			unsigned long addr, unsigned long end, bool init_skey)
 {
 	unsigned long next;
 	pmd_t *pmd;
@@ -909,14 +925,14 @@ static inline unsigned long page_table_reset_pmd(struct mm_struct *mm,
 		next = pmd_addr_end(addr, end);
 		if (pmd_none_or_clear_bad(pmd))
 			continue;
-		next = page_table_reset_pte(mm, pmd, addr, next);
+		next = page_table_reset_pte(mm, pmd, addr, next, init_skey);
 	} while (pmd++, addr = next, addr != end);
 
 	return addr;
 }
 
-static inline unsigned long page_table_reset_pud(struct mm_struct *mm,
-			pgd_t *pgd, unsigned long addr, unsigned long end)
+static inline unsigned long page_table_reset_pud(struct mm_struct *mm, pgd_t *pgd,
+			unsigned long addr, unsigned long end, bool init_skey)
 {
 	unsigned long next;
 	pud_t *pud;
@@ -926,14 +942,14 @@ static inline unsigned long page_table_reset_pud(struct mm_struct *mm,
 		next = pud_addr_end(addr, end);
 		if (pud_none_or_clear_bad(pud))
 			continue;
-		next = page_table_reset_pmd(mm, pud, addr, next);
+		next = page_table_reset_pmd(mm, pud, addr, next, init_skey);
 	} while (pud++, addr = next, addr != end);
 
 	return addr;
 }
 
-void page_table_reset_pgste(struct mm_struct *mm,
-			unsigned long start, unsigned long end)
+void page_table_reset_pgste(struct mm_struct *mm, unsigned long start,
+			    unsigned long end, bool init_skey)
 {
 	unsigned long addr, next;
 	pgd_t *pgd;
@@ -945,7 +961,7 @@ void page_table_reset_pgste(struct mm_struct *mm,
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
-		next = page_table_reset_pud(mm, pgd, addr, next);
+		next = page_table_reset_pud(mm, pgd, addr, next, init_skey);
 	} while (pgd++, addr = next, addr != end);
 	up_read(&mm->mmap_sem);
 }
-- 
1.8.4.2
