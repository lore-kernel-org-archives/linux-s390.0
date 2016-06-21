From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 08/51] s390/mm: shadow pages with real guest requested protection
Date: Tue, 21 Jun 2016 15:12:46 +0200
Message-ID: <1466514809-146638-9-git-send-email-borntraeger@de.ibm.com>
References: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

We really want to avoid manually handling protection for nested
virtualization. By shadowing pages with the protection the guest asked us
for, the SIE can handle most protection-related actions for us (e.g.
special handling for MVPG) and we can directly forward protection
exceptions to the guest.

PTEs will now always be shadowed with the correct _PAGE_PROTECT flag.
Unshadowing will take care of any guest changes to the parent PTE and
any host changes to the host PTE. If the host PTE doesn't have the
fitting access rights or is not available, we have to fix it up.

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/gmap.h    |  3 +--
 arch/s390/include/asm/pgtable.h |  2 +-
 arch/s390/kvm/gaccess.c         |  2 +-
 arch/s390/mm/gmap.c             | 12 +++++-------
 arch/s390/mm/pgtable.c          | 16 +++++++---------
 5 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index 58e65ee..4a47055 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -110,8 +110,7 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt);
 int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt);
 int gmap_shadow_pgt_lookup(struct gmap *sg, unsigned long saddr,
 			   unsigned long *pgt, int *dat_protection);
-int gmap_shadow_page(struct gmap *sg, unsigned long saddr,
-		     unsigned long paddr, int write);
+int gmap_shadow_page(struct gmap *sg, unsigned long saddr, pte_t pte);
 
 void gmap_register_pte_notifier(struct gmap_notifier *);
 void gmap_unregister_pte_notifier(struct gmap_notifier *);
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index a6e7fc8..c7ebba4 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -895,7 +895,7 @@ void ptep_zap_unused(struct mm_struct *mm, unsigned long addr,
 		     pte_t *ptep , int reset);
 void ptep_zap_key(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
 int ptep_shadow_pte(struct mm_struct *mm, unsigned long saddr,
-		    pte_t *sptep, pte_t *tptep, int write);
+		    pte_t *sptep, pte_t *tptep, pte_t pte);
 void ptep_unshadow_pte(struct mm_struct *mm, unsigned long saddr, pte_t *ptep);
 
 bool test_and_clear_guest_dirty(struct mm_struct *mm, unsigned long address);
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index ba49852..c5f79c1 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1109,7 +1109,7 @@ int kvm_s390_shadow_fault(struct gmap *sg, unsigned long saddr, int write)
 	dat_protection |= pte.p;
 	if (write && dat_protection)
 		return PGM_PROTECTION;
-	rc = gmap_shadow_page(sg, saddr, pte.pfra * 4096, write);
+	rc = gmap_shadow_page(sg, saddr, __pte(pte.val));
 	if (rc)
 		return rc;
 	return 0;
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index b02d0d0..a57a87b 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1743,8 +1743,7 @@ EXPORT_SYMBOL_GPL(gmap_shadow_pgt);
  * gmap_shadow_page - create a shadow page mapping
  * @sg: pointer to the shadow guest address space structure
  * @saddr: faulting address in the shadow gmap
- * @paddr: parent gmap address to get mapped at @saddr
- * @write: =1 map r/w, =0 map r/o
+ * @pte: pte in parent gmap address space to get shadowed
  *
  * Returns 0 if successfully shadowed or already shadowed, -EAGAIN if the
  * shadow table structure is incomplete, -ENOMEM if out of memory and
@@ -1752,12 +1751,11 @@ EXPORT_SYMBOL_GPL(gmap_shadow_pgt);
  *
  * Called with sg->mm->mmap_sem in read.
  */
-int gmap_shadow_page(struct gmap *sg, unsigned long saddr,
-		     unsigned long paddr, int write)
+int gmap_shadow_page(struct gmap *sg, unsigned long saddr, pte_t pte)
 {
 	struct gmap *parent;
 	struct gmap_rmap *rmap;
-	unsigned long vmaddr;
+	unsigned long vmaddr, paddr;
 	spinlock_t *ptl;
 	pte_t *sptep, *tptep;
 	int rc;
@@ -1771,6 +1769,7 @@ int gmap_shadow_page(struct gmap *sg, unsigned long saddr,
 	rmap->raddr = (saddr & PAGE_MASK) | _SHADOW_RMAP_PGTABLE;
 
 	while (1) {
+		paddr = pte_val(pte) & PAGE_MASK;
 		vmaddr = __gmap_translate(parent, paddr);
 		if (IS_ERR_VALUE(vmaddr)) {
 			rc = vmaddr;
@@ -1791,8 +1790,7 @@ int gmap_shadow_page(struct gmap *sg, unsigned long saddr,
 				radix_tree_preload_end();
 				break;
 			}
-			rc = ptep_shadow_pte(sg->mm, saddr,
-					     sptep, tptep, write);
+			rc = ptep_shadow_pte(sg->mm, saddr, sptep, tptep, pte);
 			if (rc > 0) {
 				/* Success and a new mapping */
 				gmap_insert_rmap(sg, vmaddr, rmap);
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 5b02583..293130b 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -463,29 +463,27 @@ int ptep_force_prot(struct mm_struct *mm, unsigned long addr,
 }
 
 int ptep_shadow_pte(struct mm_struct *mm, unsigned long saddr,
-		    pte_t *sptep, pte_t *tptep, int write)
+		    pte_t *sptep, pte_t *tptep, pte_t pte)
 {
 	pgste_t spgste, tpgste;
 	pte_t spte, tpte;
 	int rc = -EAGAIN;
 
+	if (!(pte_val(*tptep) & _PAGE_INVALID))
+		return 0;	/* already shadowed */
 	spgste = pgste_get_lock(sptep);
 	spte = *sptep;
 	if (!(pte_val(spte) & _PAGE_INVALID) &&
-	    !(pte_val(spte) & _PAGE_PROTECT)) {
-		rc = 0;
-		if (!(pte_val(*tptep) & _PAGE_INVALID))
-			/* Update existing mapping */
-			ptep_flush_direct(mm, saddr, tptep);
-		else
-			rc = 1;
+	    !((pte_val(spte) & _PAGE_PROTECT) &&
+	      !(pte_val(pte) & _PAGE_PROTECT))) {
 		pgste_val(spgste) |= PGSTE_VSIE_BIT;
 		tpgste = pgste_get_lock(tptep);
 		pte_val(tpte) = (pte_val(spte) & PAGE_MASK) |
-			(write ? 0 : _PAGE_PROTECT);
+				(pte_val(pte) & _PAGE_PROTECT);
 		/* don't touch the storage key - it belongs to parent pgste */
 		tpgste = pgste_set_pte(tptep, tpgste, tpte);
 		pgste_set_unlock(tptep, tpgste);
+		rc = 1;
 	}
 	pgste_set_unlock(sptep, spgste);
 	return rc;
-- 
2.5.5
