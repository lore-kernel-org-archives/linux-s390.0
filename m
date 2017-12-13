From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [RFC/PATCH v2 17/22] s390/mm: Add VSIE reverse fake case
Date: Wed, 13 Dec 2017 13:53:28 +0100
Message-ID: <1513169613-13509-18-git-send-email-frankja@linux.vnet.ibm.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
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
 arch/s390/kvm/gaccess.c      | 20 +++++++++++++++----
 arch/s390/mm/gmap.c          | 46 ++++++++++++++++++++++++++++++++++----------
 3 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index 5247549..d0a47d1 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -132,7 +132,7 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
 		    int fake);
 int gmap_shadow_sgt_lookup(struct gmap *sg, unsigned long saddr,
 			   unsigned long *pgt, int *dat_protection,
-			   int *fake);
+			   int *fake, int *lvl);
 int gmap_shadow_page(struct gmap *sg, unsigned long saddr, pte_t pte);
 int gmap_shadow_segment(struct gmap *sg, unsigned long saddr, pmd_t pmd);
 
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 045d12e..de40d17 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1144,10 +1144,22 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
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
@@ -1185,7 +1197,7 @@ int kvm_s390_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *sg,
 	union page_table_entry pte;
 	union segment_table_entry ste;
 	unsigned long pgt;
-	int dat_protection, fake, lvl, fc;
+	int dat_protection, fake, lvl = 0, fc;
 	int rc;
 
 	down_read(&sg->mm->mmap_sem);
@@ -1196,7 +1208,7 @@ int kvm_s390_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *sg,
 	 */
 	ipte_lock(vcpu);
 
-	rc = gmap_shadow_sgt_lookup(sg, saddr, &pgt, &dat_protection, &fake);
+	rc = gmap_shadow_sgt_lookup(sg, saddr, &pgt, &dat_protection, &fake, &lvl);
 	if (rc)
 		rc = kvm_s390_shadow_tables(sg, saddr, &pgt, &dat_protection,
 					    &fake, &lvl);
@@ -1204,7 +1216,7 @@ int kvm_s390_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *sg,
 	vaddr.addr = saddr;
 
 	/* Shadow stopped at segment level, we map pmd to pmd */
-	if (lvl) {
+	if (!rc && lvl) {
 		if (!rc)
 			rc = gmap_read_table(sg->parent, pgt + vaddr.sx * 8,
 					     &ste.val, &fc);
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index b3d01d9..8bcaa53 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1506,7 +1506,7 @@ static void __gmap_unshadow_sgt(struct gmap *sg, unsigned long raddr,
 
 	BUG_ON(!gmap_is_shadow(sg));
 	for (i = 0; i < _CRST_ENTRIES; i++, raddr += _SEGMENT_SIZE) {
-		if (!(sgt[i] & _SEGMENT_ENTRY_ORIGIN))
+		if (sgt[i] ==  _SEGMENT_ENTRY_EMPTY)
 			continue;
 
 		if (!(sgt[i] & _SEGMENT_ENTRY_LARGE)) {
@@ -2148,7 +2148,7 @@ EXPORT_SYMBOL_GPL(gmap_shadow_pgt_lookup);
 
 int gmap_shadow_sgt_lookup(struct gmap *sg, unsigned long saddr,
 			   unsigned long *pgt, int *dat_protection,
-			   int *fake)
+			   int *fake, int *lvl)
 {
 	unsigned long *sge, *r3e = NULL;
 	struct page *page;
@@ -2179,9 +2179,11 @@ int gmap_shadow_sgt_lookup(struct gmap *sg, unsigned long saddr,
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
@@ -2370,6 +2372,7 @@ int gmap_shadow_page(struct gmap *sg, unsigned long saddr, pte_t pte)
 	struct gmap_rmap *rmap;
 	unsigned long vmaddr, paddr;
 	spinlock_t *ptl;
+	pmd_t *spmdp;
 	pte_t *sptep, *tptep;
 	int prot;
 	int rc;
@@ -2394,26 +2397,43 @@ int gmap_shadow_page(struct gmap *sg, unsigned long saddr, pte_t pte)
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
+				sptep = pte_alloc_map_lock(parent->mm, spmdp, paddr, &ptl);
+				if (sptep) {
+					rc = ptep_shadow_pte(sg->mm, saddr, sptep, tptep, pte);
+					if (rc > 0) {
+						/* Success and a new mapping */
+						gmap_insert_rmap(sg, vmaddr, rmap);
+						rmap = NULL;
+						rc = 0;
+					}
+					gmap_pte_op_end(ptl);
+				}
 			}
-			gmap_pte_op_end(ptl);
 			spin_unlock(&sg->guest_table_lock);
+			gmap_pmd_op_end(parent, spmdp);
 		}
 		radix_tree_preload_end();
 		if (!rc)
@@ -2492,6 +2512,12 @@ static void gmap_shadow_notify_pmd(struct gmap *sg, unsigned long vmaddr,
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
