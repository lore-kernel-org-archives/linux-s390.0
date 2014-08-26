From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 10/15] KVM: s390/mm: readd address parameter to pgste_ipte_notify
Date: Tue, 26 Aug 2014 10:28:22 +0200
Message-ID: <1409041707-39938-11-git-send-email-borntraeger@de.ibm.com>
References: <1409041707-39938-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1409041707-39938-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Revert git commit 1b7fd6952063 ("remove unecessary parameter from
pgste_ipte_notify")

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/pgtable.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index b76317c..4a64988 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -859,6 +859,7 @@ int gmap_ipte_notify(struct gmap *, unsigned long start, unsigned long len);
 void gmap_do_ipte_notify(struct mm_struct *, pte_t *);
 
 static inline pgste_t pgste_ipte_notify(struct mm_struct *mm,
+					unsigned long addr,
 					pte_t *ptep, pgste_t pgste)
 {
 #ifdef CONFIG_PGSTE
@@ -1110,7 +1111,7 @@ static inline int ptep_test_and_clear_user_dirty(struct mm_struct *mm,
 	pgste_val(pgste) &= ~PGSTE_UC_BIT;
 	pte = *ptep;
 	if (dirty && (pte_val(pte) & _PAGE_PRESENT)) {
-		pgste = pgste_ipte_notify(mm, ptep, pgste);
+		pgste = pgste_ipte_notify(mm, addr, ptep, pgste);
 		__ptep_ipte(addr, ptep);
 		if (MACHINE_HAS_ESOP || !(pte_val(pte) & _PAGE_WRITE))
 			pte_val(pte) |= _PAGE_PROTECT;
@@ -1132,7 +1133,7 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 
 	if (mm_has_pgste(vma->vm_mm)) {
 		pgste = pgste_get_lock(ptep);
-		pgste = pgste_ipte_notify(vma->vm_mm, ptep, pgste);
+		pgste = pgste_ipte_notify(vma->vm_mm, addr, ptep, pgste);
 	}
 
 	pte = *ptep;
@@ -1178,7 +1179,7 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 
 	if (mm_has_pgste(mm)) {
 		pgste = pgste_get_lock(ptep);
-		pgste = pgste_ipte_notify(mm, ptep, pgste);
+		pgste = pgste_ipte_notify(mm, address, ptep, pgste);
 	}
 
 	pte = *ptep;
@@ -1202,7 +1203,7 @@ static inline pte_t ptep_modify_prot_start(struct mm_struct *mm,
 
 	if (mm_has_pgste(mm)) {
 		pgste = pgste_get_lock(ptep);
-		pgste_ipte_notify(mm, ptep, pgste);
+		pgste_ipte_notify(mm, address, ptep, pgste);
 	}
 
 	pte = *ptep;
@@ -1239,7 +1240,7 @@ static inline pte_t ptep_clear_flush(struct vm_area_struct *vma,
 
 	if (mm_has_pgste(vma->vm_mm)) {
 		pgste = pgste_get_lock(ptep);
-		pgste = pgste_ipte_notify(vma->vm_mm, ptep, pgste);
+		pgste = pgste_ipte_notify(vma->vm_mm, address, ptep, pgste);
 	}
 
 	pte = *ptep;
@@ -1273,7 +1274,7 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
 
 	if (!full && mm_has_pgste(mm)) {
 		pgste = pgste_get_lock(ptep);
-		pgste = pgste_ipte_notify(mm, ptep, pgste);
+		pgste = pgste_ipte_notify(mm, address, ptep, pgste);
 	}
 
 	pte = *ptep;
@@ -1298,7 +1299,7 @@ static inline pte_t ptep_set_wrprotect(struct mm_struct *mm,
 	if (pte_write(pte)) {
 		if (mm_has_pgste(mm)) {
 			pgste = pgste_get_lock(ptep);
-			pgste = pgste_ipte_notify(mm, ptep, pgste);
+			pgste = pgste_ipte_notify(mm, address, ptep, pgste);
 		}
 
 		ptep_flush_lazy(mm, address, ptep);
@@ -1324,7 +1325,7 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
 		return 0;
 	if (mm_has_pgste(vma->vm_mm)) {
 		pgste = pgste_get_lock(ptep);
-		pgste = pgste_ipte_notify(vma->vm_mm, ptep, pgste);
+		pgste = pgste_ipte_notify(vma->vm_mm, address, ptep, pgste);
 	}
 
 	ptep_flush_direct(vma->vm_mm, address, ptep);
-- 
1.8.4.2
