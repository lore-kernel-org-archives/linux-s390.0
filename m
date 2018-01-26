From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [PATCH v2] mm: s390: Only notify on 4k pages
Date: Fri, 26 Jan 2018 11:34:42 +0100
Message-ID: <1516962882-86297-1-git-send-email-frankja@linux.vnet.ibm.com>
References: <86c5bd00-a552-1737-8db8-3f7b3c21057e@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <86c5bd00-a552-1737-8db8-3f7b3c21057e@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Let's try this

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
---
 arch/s390/include/asm/gmap.h |   5 +-
 arch/s390/mm/gmap.c          | 142 ++++++++-----------------------------------
 2 files changed, 28 insertions(+), 119 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index 6287aca..4120360 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -13,9 +13,8 @@
 #define GMAP_NOTIFY_SHADOW	0x2
 #define GMAP_NOTIFY_MPROT	0x1
 
-/* Status bits in huge and non-huge gmap segment entries. */
-#define _SEGMENT_ENTRY_GMAP_IN		0x0001	/* invalidation notify bit */
-#define _SEGMENT_ENTRY_GMAP_SPLIT	0x0002  /* split huge pmd */
+/* Status bit in huge and non-huge gmap segment entries. */
+#define _SEGMENT_ENTRY_GMAP_SPLIT	0x0001  /* split huge pmd */
 /* Status bits only for huge segment entries */
 #define _SEGMENT_ENTRY_GMAP_UC		0x4000	/* user dirty (migration) */
 #define _SEGMENT_ENTRY_GMAP_VSIE	0x8000	/* vsie bit */
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 66a68af..2f5c8ee 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -998,7 +998,7 @@ static void gmap_pte_transfer_prot(struct mm_struct *mm, unsigned long addr,
  * and requested access rights are incompatible.
  */
 static int gmap_pmdp_force_prot(struct gmap *gmap, unsigned long addr,
-				pmd_t *pmdp, int prot, unsigned long bits)
+				pmd_t *pmdp, int prot)
 {
 	int pmd_i = pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID;
 	int pmd_p = pmd_val(*pmdp) & _SEGMENT_ENTRY_PROTECT;
@@ -1018,7 +1018,6 @@ static int gmap_pmdp_force_prot(struct gmap *gmap, unsigned long addr,
 		pmd_val(new) |= _SEGMENT_ENTRY_PROTECT;
 		gmap_pmdp_xchg(gmap, pmdp, new, addr);
 	}
-	pmd_val(*pmdp) |=  bits;
 	return 0;
 }
 
@@ -1102,10 +1101,6 @@ static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
 	spinlock_t *ptl = NULL;
 	unsigned long pbits = 0;
 
-	/* We have no upper segment, let's go back and fix this up. */
-	if (pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)
-		return -EAGAIN;
-
 	ptep = gmap_pte_from_pmd(gmap, pmdp, gaddr, &ptl);
 	if (!ptep)
 		return -ENOMEM;
@@ -1134,30 +1129,18 @@ static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
  */
 static int gmap_protect_pmd(struct gmap *gmap, unsigned long gaddr,
 			    unsigned long vmaddr, pmd_t *pmdp, pmd_t *hpmdp,
-			    int prot, unsigned long bits)
+			    int prot)
 {
-	unsigned long sbits = 0;
 	int ret = 0;
 
-	sbits |= (bits & GMAP_NOTIFY_MPROT) ? _SEGMENT_ENTRY_GMAP_IN : 0;
-	sbits |= (bits & GMAP_NOTIFY_SHADOW) ? _SEGMENT_ENTRY_GMAP_VSIE : 0;
-
-	if (((prot != PROT_WRITE) && (bits & GMAP_NOTIFY_SHADOW))) {
-		ret = gmap_pmd_split(gmap, gaddr, pmdp);
-		if (ret)
-			return ret;
-		return -EFAULT;
-	}
-
-	/* Protect gmap pmd */
-	ret = gmap_pmdp_force_prot(gmap, gaddr, pmdp, prot, sbits);
+	/* Protect gmap pmd for dirty tracking. */
+	ret = gmap_pmdp_force_prot(gmap, gaddr, pmdp, prot);
 	/*
 	 * Transfer protection back to the host pmd, so userspace has
 	 * never more access rights than the VM.
 	 */
 	if (!ret)
 		gmap_pmdp_transfer_prot(gmap->mm, vmaddr, pmdp, hpmdp);
-
 	return ret;
 }
 
@@ -1167,7 +1150,7 @@ static int gmap_protect_pmd(struct gmap *gmap, unsigned long gaddr,
  * @gaddr: virtual address in the guest address space
  * @len: size of area
  * @prot: indicates access rights: PROT_NONE, PROT_READ or PROT_WRITE
- * @bits: pgste notification bits to set
+ * @bits: notification bits to set
  *
  * Returns 0 if successfully protected, -ENOMEM if out of memory and
  * -EFAULT if gaddr is invalid (or mapping for shadows is missing).
@@ -1180,7 +1163,7 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 			      unsigned long len, int prot, unsigned long bits)
 {
 	spinlock_t *ptl;
-	unsigned long vmaddr, dist;
+	unsigned long vmaddr;
 	pmd_t *pmdp, *hpmdp;
 	int rc = 0;
 
@@ -1194,13 +1177,8 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 		ptl = pmd_lock(gmap->mm, hpmdp);
 
 		pmdp = gmap_pmd_op_walk(gmap, gaddr);
-		if (pmdp) {
+		if (pmdp && !(pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)) {
 			if (!pmd_large(*pmdp)) {
-				if (gmap_pmd_is_split(pmdp) &&
-				    (bits & GMAP_NOTIFY_MPROT)) {
-					pmd_val(*pmdp) |= _SEGMENT_ENTRY_GMAP_IN;
-				}
-
 				rc = gmap_protect_pte(gmap, gaddr, vmaddr,
 						      pmdp, hpmdp, prot, bits);
 				if (!rc) {
@@ -1208,13 +1186,9 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 					gaddr += PAGE_SIZE;
 				}
 			} else {
-				rc =  gmap_protect_pmd(gmap, gaddr, vmaddr,
-						       pmdp, hpmdp, prot, bits);
-				if (!rc) {
-					dist = HPAGE_SIZE - (gaddr & ~HPAGE_MASK);
-					len = len < dist ? 0 : len - dist;
-					gaddr = (gaddr & HPAGE_MASK) + HPAGE_SIZE;
-				}
+				rc = gmap_pmd_split(gmap, gaddr, pmdp);
+				if (!rc)
+					rc = -EFAULT;
 			}
 			gmap_pmd_op_end(gmap, pmdp);
 		}
@@ -1357,29 +1331,9 @@ static inline void gmap_insert_rmap(struct gmap *sg, unsigned long vmaddr,
 	}
 }
 
-static int gmap_protect_rmap_pmd(struct gmap *sg, struct gmap_rmap *rmap,
-				 unsigned long paddr, unsigned long vmaddr,
-				 pmd_t *pmdp, pmd_t *hpmdp, int prot)
-{
-	int rc = 0;
-
-	/* We have no upper segment, let's go back and fix this up. */
-	if (pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)
-		return -EAGAIN;
-
-	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
-	rc = gmap_protect_pmd(sg->parent, paddr, vmaddr, pmdp, hpmdp,
-			      prot, GMAP_NOTIFY_SHADOW);
-	if (!rc)
-		gmap_insert_rmap(sg, vmaddr & HPAGE_MASK, rmap);
-
-	spin_unlock(&sg->guest_table_lock);
-	return rc;
-}
-
 static int gmap_protect_rmap_pte(struct gmap *sg, struct gmap_rmap *rmap,
 				 unsigned long paddr, unsigned long vmaddr,
-				 pmd_t *pmdp, int prot)
+				 pmd_t *pmdp, pmd_t *hpmdp, int prot)
 {
 	int rc = 0;
 	pte_t *ptep = NULL;
@@ -1392,8 +1346,8 @@ static int gmap_protect_rmap_pte(struct gmap *sg, struct gmap_rmap *rmap,
 	ptep = gmap_pte_from_pmd(sg->parent, pmdp, paddr, &ptl);
 	if (ptep) {
 		spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
-		rc = ptep_force_prot(sg->parent->mm, paddr, ptep, prot,
-				     PGSTE_VSIE_BIT);
+		rc = gmap_protect_pte(sg->parent, paddr, vmaddr, pmdp, hpmdp,
+				      prot, GMAP_NOTIFY_SHADOW);
 		if (!rc)
 			gmap_insert_rmap(sg, vmaddr, rmap);
 		spin_unlock(&sg->guest_table_lock);
@@ -1418,7 +1372,7 @@ static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
 {
 	struct gmap *parent;
 	struct gmap_rmap *rmap;
-	unsigned long vmaddr, dist;
+	unsigned long vmaddr;
 	pmd_t *pmdp, *hpmdp;
 	spinlock_t *ptl;
 	int rc;
@@ -1446,23 +1400,19 @@ static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
 		}
 		rc = -EAGAIN;
 		pmdp = gmap_pmd_op_walk(parent, paddr);
-		if (pmdp) {
+		if (pmdp && !(pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)) {
 			if (!pmd_large(*pmdp)) {
 				rc = gmap_protect_rmap_pte(sg, rmap, paddr,
-							   vmaddr, pmdp, prot);
+							   vmaddr, pmdp, hpmdp,
+							   prot);
 				if (!rc) {
 					paddr += PAGE_SIZE;
 					len -= PAGE_SIZE;
 				}
 			} else {
-				rc = gmap_protect_rmap_pmd(sg, rmap, paddr,
-							   vmaddr, pmdp,
-							   hpmdp, prot);
-				if (!rc) {
-					dist = HPAGE_SIZE - (paddr & ~HPAGE_MASK);
-					len = len < dist ? 0 : len - dist;
-					paddr = (paddr & HPAGE_MASK) + HPAGE_SIZE;
-				}
+				rc = gmap_pmd_split(parent, paddr, pmdp);
+				if (!rc)
+					rc = -EFAULT;
 			}
 			gmap_pmd_op_end(parent, pmdp);
 		}
@@ -2562,53 +2512,19 @@ static void gmap_shadow_notify_pmd(struct gmap *sg, unsigned long vmaddr,
 				   unsigned long gaddr)
 {
 	struct gmap_rmap *rmap, *rnext, *head;
-	unsigned long start, end, bits, raddr;
-
+	unsigned long bits, raddr;
 
 	BUG_ON(!gmap_is_shadow(sg));
 
 	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
-	if (sg->removed) {
-		spin_unlock(&sg->guest_table_lock);
-		return;
-	}
-	/* Check for top level table */
-	start = sg->orig_asce & _ASCE_ORIGIN;
-	end = start + ((sg->orig_asce & _ASCE_TABLE_LENGTH) + 1) * 4096;
-	if (!(sg->orig_asce & _ASCE_REAL_SPACE) && gaddr >= start &&
-	    gaddr < ((end & HPAGE_MASK) + HPAGE_SIZE - 1)) {
-		/* The complete shadow table has to go */
-		gmap_unshadow(sg);
-		spin_unlock(&sg->guest_table_lock);
-		list_del(&sg->list);
-		gmap_put(sg);
-		return;
-	}
-	/* Remove the page table tree from on specific entry */
 	head = radix_tree_delete(&sg->host_to_rmap, (vmaddr & HPAGE_MASK) >> PAGE_SHIFT);
 	gmap_for_each_rmap_safe(rmap, rnext, head) {
 		bits = rmap->raddr & _SHADOW_RMAP_MASK;
 		raddr = rmap->raddr ^ bits;
-		switch (bits) {
-		case _SHADOW_RMAP_REGION1:
-			gmap_unshadow_r2t(sg, raddr);
-			break;
-		case _SHADOW_RMAP_REGION2:
-			gmap_unshadow_r3t(sg, raddr);
-			break;
-		case _SHADOW_RMAP_REGION3:
-			gmap_unshadow_sgt(sg, raddr);
-			break;
-		case _SHADOW_RMAP_SEGMENT_LP:
+		if (bits == _SHADOW_RMAP_SEGMENT_LP)
 			gmap_unshadow_segment(sg, raddr);
-			break;
-		case _SHADOW_RMAP_SEGMENT:
-			gmap_unshadow_pgt(sg, raddr);
-			break;
-		case _SHADOW_RMAP_PGTABLE:
+		else
 			gmap_unshadow_page(sg, raddr);
-			break;
-		}
 		kfree(rmap);
 	}
 	spin_unlock(&sg->guest_table_lock);
@@ -2777,9 +2693,8 @@ static void pmdp_notify_gmap(struct gmap *gmap, unsigned long gaddr)
 	table = gmap_table_walk(gmap, gaddr, 1);
 	if (!table)
 		return;
-	bits = *table & _SEGMENT_ENTRY_GMAP_IN;
 	if (pmd_large(__pmd(*table)) && (*table & _SEGMENT_ENTRY_GMAP_VSIE))
-		bits |= _SEGMENT_ENTRY_GMAP_VSIE;
+		bits = _SEGMENT_ENTRY_GMAP_VSIE;
 	if (!bits)
 		return;
 	*table &= ~bits;
@@ -2792,8 +2707,6 @@ static void pmdp_notify_gmap(struct gmap *gmap, unsigned long gaddr)
 			gmap_shadow_notify_pmd(sg, vmaddr, gaddr);
 		spin_unlock(&gmap->shadow_lock);
 	}
-	if (bits & _SEGMENT_ENTRY_GMAP_IN)
-		gmap_call_notifier(gmap, gaddr, gaddr + HPAGE_SIZE - 1);
 }
 
 static void pmdp_notify_split(struct mm_struct *mm, unsigned long vmaddr,
@@ -2841,9 +2754,8 @@ void pmdp_notify(struct mm_struct *mm, unsigned long vmaddr)
 			continue;
 		}
 
-		bits = *table & (_SEGMENT_ENTRY_GMAP_IN);
 		if (pmd_large(__pmd(*table)) && (*table & _SEGMENT_ENTRY_GMAP_VSIE))
-			bits |= _SEGMENT_ENTRY_GMAP_VSIE;
+			bits = _SEGMENT_ENTRY_GMAP_VSIE;
 		*table &= ~bits;
 		gaddr = __gmap_segment_gaddr(table);
 		spin_unlock(&gmap->guest_table_lock);
@@ -2854,8 +2766,6 @@ void pmdp_notify(struct mm_struct *mm, unsigned long vmaddr)
 				gmap_shadow_notify_pmd(sg, vmaddr, gaddr);
 			spin_unlock(&gmap->shadow_lock);
 		}
-		if (bits & _SEGMENT_ENTRY_GMAP_IN)
-			gmap_call_notifier(gmap, gaddr, gaddr + HPAGE_SIZE - 1);
 	}
 	rcu_read_unlock();
 }
@@ -3028,7 +2938,7 @@ bool gmap_test_and_clear_dirty_segment(struct gmap *gmap, pmd_t *pmdp,
 
 	/* Clear UC indication and reset protection */
 	pmd_val(*pmdp) &= ~_SEGMENT_ENTRY_GMAP_UC;
-	gmap_protect_pmd(gmap, gaddr, vmaddr, pmdp, hpmdp, PROT_READ, 0);
+	gmap_protect_pmd(gmap, gaddr, vmaddr, pmdp, hpmdp, PROT_READ);
 	return true;
 }
 
-- 
2.7.4
