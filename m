From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [RFC/PATCH 17/22] s390/mm: Add VSIE reverse fake case
Date: Mon,  6 Nov 2017 23:29:55 +0100
Message-ID: <1510007400-42493-18-git-send-email-frankja@linux.vnet.ibm.com>
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The fake VSIE case lets us run huge vsie guests on small hosts by
creating fake page tables. When running a small guest on a huge host,
we need to create fake tables once again.

The fake tables are needed to make sure, that the VSIE guest is only
able to access the memory that its host mapped for it.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
---
 arch/s390/include/asm/gmap.h |  2 +-
 arch/s390/kvm/gaccess.c      | 20 +++++++++++++----
 arch/s390/mm/gmap.c          | 52 +++++++++++++++++++++++++++++++++++---------
 3 files changed, 59 insertions(+), 15 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index 2ce861f..a50dbc6 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -131,7 +131,7 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
 		    int fake);
 int gmap_shadow_sgt_lookup(struct gmap *sg, unsigned long saddr,
 			   unsigned long *pgt, int *dat_protection,
-			   int *fake);
+			   int *fake, int *lvl);
 int gmap_shadow_page(struct gmap *sg, unsigned long saddr, pte_t pte);
 int gmap_shadow_segment(struct gmap *sg, unsigned long saddr, pmd_t pmd);
 
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 60a5dda..5c6e8d8 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1143,10 +1143,22 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 				*lvl = 1;
 				*pgt = ptr;
 				return 0;
+			} else {
+				/*
+				 * Reverse fake case.
+				 * We map a huge parent to a small guest, i.e.
+				 * we need fake shadow pagetables.
+				 *
+				 * We need pagetables here, because
+				 * guests not aligned on 1M could
+				 * read/write from/to the parent or
+				 * host.
+				 */
+				*lvl = 0;
 			}
 		}
 		/* Small to small and small to huge case */
-		if (ste.fc && sg->edat_level >= 1) {
+		if (!fc && ste.fc && sg->edat_level >= 1) {
 			*fake = 1;
 			ptr = ste.fc1.sfaa * _SEGMENT_SIZE;
 			ste.val = ptr;
@@ -1184,7 +1196,7 @@ int kvm_s390_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *sg,
 	union page_table_entry pte;
 	union segment_table_entry ste;
 	unsigned long pgt;
-	int dat_protection, fake, lvl, fc;
+	int dat_protection, fake, lvl = 0, fc;
 	int rc;
 
 	down_read(&sg->mm->mmap_sem);
@@ -1195,7 +1207,7 @@ int kvm_s390_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *sg,
 	 */
 	ipte_lock(vcpu);
 
-	rc = gmap_shadow_sgt_lookup(sg, saddr, &pgt, &dat_protection, &fake);
+	rc = gmap_shadow_sgt_lookup(sg, saddr, &pgt, &dat_protection, &fake, &lvl);
 	if (rc)
 		rc = kvm_s390_shadow_tables(sg, saddr, &pgt, &dat_protection,
 					    &fake, &lvl);
@@ -1203,7 +1215,7 @@ int kvm_s390_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *sg,
 	vaddr.addr = saddr;
 
 	/* Shadow stopped at segment level, we map pmd to pmd */
-	if (lvl) {
+	if (!rc && lvl) {
 		if (!rc)
 			rc = gmap_read_table(sg->parent, pgt + vaddr.sx * 8,
 					     &ste.val, &fc);
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 75c32de..91a0824 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1527,7 +1527,7 @@ static void __gmap_unshadow_sgt(struct gmap *sg, unsigned long raddr,
 	BUG_ON(!gmap_is_shadow(sg));
 	asce = (unsigned long) sgt | _ASCE_TYPE_SEGMENT;
 	for (i = 0; i < _CRST_ENTRIES; i++, raddr += _SEGMENT_SIZE) {
-		if (!(sgt[i] & _SEGMENT_ENTRY_ORIGIN))
+		if (sgt[i] ==  _SEGMENT_ENTRY_EMPTY)
 			continue;
 
 		if (!(sgt[i] & _SEGMENT_ENTRY_LARGE)) {
@@ -2171,7 +2171,7 @@ EXPORT_SYMBOL_GPL(gmap_shadow_pgt_lookup);
 
 int gmap_shadow_sgt_lookup(struct gmap *sg, unsigned long saddr,
 			   unsigned long *pgt, int *dat_protection,
-			   int *fake)
+			   int *fake, int *lvl)
 {
 	unsigned long *sge, *r3e = NULL;
 	struct page *page;
@@ -2202,9 +2202,11 @@ int gmap_shadow_sgt_lookup(struct gmap *sg, unsigned long saddr,
 			*dat_protection = 0;
 			*fake = 0;
 		}
+		*lvl = 1;
 	} else {
 		gmap_shadow_pgt_lookup(sg, sge, saddr, pgt,
 				       dat_protection, fake);
+		*lvl = 0;
 	}
 out:
 	spin_unlock(&sg->guest_table_lock);
@@ -2392,6 +2394,7 @@ int gmap_shadow_page(struct gmap *sg, unsigned long saddr, pte_t pte)
 	struct gmap_rmap *rmap;
 	unsigned long vmaddr, paddr;
 	spinlock_t *ptl;
+	pmd_t *spmdp;
 	pte_t *sptep, *tptep;
 	int prot;
 	int rc;
@@ -2416,26 +2419,49 @@ int gmap_shadow_page(struct gmap *sg, unsigned long saddr, pte_t pte)
 		if (rc)
 			break;
 		rc = -EAGAIN;
-		sptep = gmap_pte_op_walk(parent, paddr, &ptl);
-		if (sptep) {
+		spmdp = gmap_pmd_op_walk(parent, paddr);
+		if (spmdp && !(pmd_val(*spmdp) & _SEGMENT_ENTRY_INVALID)) {
 			spin_lock(&sg->guest_table_lock);
 			/* Get page table pointer */
 			tptep = (pte_t *) gmap_table_walk(sg, saddr, 0);
 			if (!tptep) {
 				spin_unlock(&sg->guest_table_lock);
-				gmap_pte_op_end(ptl);
 				radix_tree_preload_end();
+				gmap_pmd_op_end(parent, spmdp);
 				break;
 			}
-			rc = ptep_shadow_pte(sg->mm, saddr, sptep, tptep, pte);
-			if (rc > 0) {
-				/* Success and a new mapping */
-				gmap_insert_rmap(sg, vmaddr, rmap);
+
+			if (pmd_large(*spmdp)) {
+				/* TODO: Bits and pgstes */
+				*tptep = __pte(((pmd_val(*spmdp) &
+						_SEGMENT_ENTRY_ORIGIN_LARGE)
+					       + (pte_index(paddr) << 12))
+					       | (pte_val(pte) & _PAGE_PROTECT));
+				pmd_val(*spmdp) |= _SEGMENT_ENTRY_GMAP_VSIE;
+				gmap_insert_rmap(sg, vmaddr & HPAGE_MASK, rmap);
 				rmap = NULL;
 				rc = 0;
+			} else {
+				ptl = NULL;
+				if (gmap_is_shadow(parent))
+					sptep = pte_offset_map(spmdp, paddr);
+				else
+					sptep = pte_alloc_map_lock(parent->mm, spmdp, paddr, &ptl);
+
+				if (sptep) {
+					rc = ptep_shadow_pte(sg->mm, saddr, sptep, tptep, pte);
+					if (rc > 0) {
+						/* Success and a new mapping */
+						gmap_insert_rmap(sg, vmaddr, rmap);
+						rmap = NULL;
+						rc = 0;
+					}
+					if (ptl)
+						gmap_pte_op_end(ptl);
+				}
 			}
-			gmap_pte_op_end(ptl);
 			spin_unlock(&sg->guest_table_lock);
+			gmap_pmd_op_end(parent, spmdp);
 		}
 		radix_tree_preload_end();
 		if (!rc)
@@ -2514,6 +2540,12 @@ static void gmap_shadow_notify_pmd(struct gmap *sg, unsigned long vmaddr,
 		case _SHADOW_RMAP_SEGMENT_LP:
 			gmap_unshadow_segment(sg, raddr);
 			break;
+		case _SHADOW_RMAP_SEGMENT:
+			gmap_unshadow_pgt(sg, raddr);
+			break;
+		case _SHADOW_RMAP_PGTABLE:
+			gmap_unshadow_page(sg, raddr);
+			break;
 		}
 		kfree(rmap);
 	}
-- 
2.7.4
