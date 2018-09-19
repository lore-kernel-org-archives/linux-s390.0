From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 19 Sep 2018 08:47:58 +0000
Subject: [RFC 10/14] s390/mm: Add simple ptep shadow function
Message-Id: <20180919084802.183381-11-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Let's factor out setting the shadow pte, so we can reuse that function
for later huge to 4k shadows where we don't have a spte or spgste.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/include/asm/pgtable.h |  1 +
 arch/s390/mm/pgtable.c          | 24 ++++++++++++++++--------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 54d8376b7a10..547810d43fa7 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1101,6 +1101,7 @@ void ptep_zap_unused(struct mm_struct *mm, unsigned long addr,
 void ptep_zap_key(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
 int ptep_shadow_pte(struct mm_struct *mm, unsigned long saddr,
 		    pte_t *sptep, pte_t *tptep, pte_t pte);
+void ptep_shadow_set(pte_t spte, pte_t *tptep, pte_t pte);
 void ptep_unshadow_pte(struct mm_struct *mm, unsigned long saddr, pte_t *ptep);
 
 unsigned long ptep_get_and_clear_notification_bits(pte_t *ptep);
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 55855192c41f..1c1c45174394 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -625,11 +625,24 @@ int ptep_force_prot(struct mm_struct *mm, unsigned long addr,
 	return 0;
 }
 
+void ptep_shadow_set(pte_t spte, pte_t *tptep, pte_t pte)
+{
+	pte_t tpte;
+	pgste_t tpgste;
+
+	tpgste = pgste_get_lock(tptep);
+	pte_val(tpte) = (pte_val(spte) & PAGE_MASK) |
+		(pte_val(pte) & _PAGE_PROTECT);
+	/* don't touch the storage key - it belongs to parent pgste */
+	tpgste = pgste_set_pte(tptep, tpgste, tpte);
+	pgste_set_unlock(tptep, tpgste);
+}
+
 int ptep_shadow_pte(struct mm_struct *mm, unsigned long saddr,
 		    pte_t *sptep, pte_t *tptep, pte_t pte)
 {
-	pgste_t spgste, tpgste;
-	pte_t spte, tpte;
+	pgste_t spgste;
+	pte_t spte;
 	int rc = -EAGAIN;
 
 	if (!(pte_val(*tptep) & _PAGE_INVALID))
@@ -640,12 +653,7 @@ int ptep_shadow_pte(struct mm_struct *mm, unsigned long saddr,
 	    !((pte_val(spte) & _PAGE_PROTECT) &&
 	      !(pte_val(pte) & _PAGE_PROTECT))) {
 		pgste_val(spgste) |= PGSTE_VSIE_BIT;
-		tpgste = pgste_get_lock(tptep);
-		pte_val(tpte) = (pte_val(spte) & PAGE_MASK) |
-				(pte_val(pte) & _PAGE_PROTECT);
-		/* don't touch the storage key - it belongs to parent pgste */
-		tpgste = pgste_set_pte(tptep, tpgste, tpte);
-		pgste_set_unlock(tptep, tpgste);
+		ptep_shadow_set(spte, tptep, pte);
 		rc = 1;
 	}
 	pgste_set_unlock(sptep, spgste);
-- 
2.14.3
