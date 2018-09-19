From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 19 Sep 2018 08:47:54 +0000
Subject: [RFC 06/14] s390/mm: Provide vmaddr to pmd notification
Message-Id: <20180919084802.183381-7-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

It will be needed for shadow tables.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/mm/gmap.c | 51 ++++++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 7bc490a6fbeb..70763bcd0e0b 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -530,10 +530,10 @@ void gmap_unlink(struct mm_struct *mm, unsigned long *table,
 }
 
 static void gmap_pmdp_xchg(struct gmap *gmap, pmd_t *old, pmd_t new,
-			   unsigned long gaddr);
+			   unsigned long gaddr, unsigned long vmaddr);
 
 static void gmap_pmd_split(struct gmap *gmap, unsigned long gaddr,
-			   pmd_t *pmdp, struct page *page);
+			   unsigned long vmaddr, pmd_t *pmdp, struct page *page);
 
 /**
  * gmap_link - set up shadow page tables to connect a host to a guest address
@@ -632,7 +632,8 @@ int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
 	} else if (*table & _SEGMENT_ENTRY_PROTECT &&
 		   !(pmd_val(*pmd) & _SEGMENT_ENTRY_PROTECT)) {
 		if (page) {
-			gmap_pmd_split(gmap, gaddr, (pmd_t *)table, page);
+			gmap_pmd_split(gmap, gaddr, vmaddr,
+				       (pmd_t *)table, page);
 			page = NULL;
 		} else {
 			spin_unlock(ptl);
@@ -948,19 +949,15 @@ static void gmap_pte_op_end(spinlock_t *ptl)
  * Returns a pointer to the pmd for a guest address, or NULL
  */
 static inline pmd_t *gmap_pmd_op_walk(struct gmap *gmap, unsigned long gaddr,
-				      spinlock_t **ptl)
+				      unsigned long vmaddr, spinlock_t **ptl)
 {
 	pmd_t *pmdp, *hpmdp;
-	unsigned long vmaddr;
 
 
 	BUG_ON(gmap_is_shadow(gmap));
 
 	*ptl = NULL;
 	if (gmap->mm->context.allow_gmap_hpage_1m) {
-		vmaddr = __gmap_translate(gmap, gaddr);
-		if (IS_ERR_VALUE(vmaddr))
-			return NULL;
 		hpmdp = pmd_alloc_map(gmap->mm, vmaddr);
 		if (!hpmdp)
 			return NULL;
@@ -1043,7 +1040,7 @@ static inline void gmap_pmd_split_free(struct gmap *gmap, pmd_t *pmdp)
  * aren't tracked anywhere else.
  */
 static void gmap_pmd_split(struct gmap *gmap, unsigned long gaddr,
-			   pmd_t *pmdp, struct page *page)
+			   unsigned long vmaddr, pmd_t *pmdp, struct page *page)
 {
 	unsigned long *ptable = (unsigned long *) page_to_phys(page);
 	pmd_t new;
@@ -1065,7 +1062,7 @@ static void gmap_pmd_split(struct gmap *gmap, unsigned long gaddr,
 	spin_lock(&gmap->split_list_lock);
 	list_add(&page->lru, &gmap->split_list);
 	spin_unlock(&gmap->split_list_lock);
-	gmap_pmdp_xchg(gmap, pmdp, new, gaddr);
+	gmap_pmdp_xchg(gmap, pmdp, new, gaddr, vmaddr);
 }
 
 /*
@@ -1083,7 +1080,8 @@ static void gmap_pmd_split(struct gmap *gmap, unsigned long gaddr,
  * guest_table_lock held.
  */
 static int gmap_protect_pmd(struct gmap *gmap, unsigned long gaddr,
-			    pmd_t *pmdp, int prot, unsigned long bits)
+			    unsigned long vmaddr, pmd_t *pmdp, int prot,
+			    unsigned long bits)
 {
 	int pmd_i = pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID;
 	int pmd_p = pmd_val(*pmdp) & _SEGMENT_ENTRY_PROTECT;
@@ -1095,13 +1093,13 @@ static int gmap_protect_pmd(struct gmap *gmap, unsigned long gaddr,
 
 	if (prot == PROT_NONE && !pmd_i) {
 		pmd_val(new) |= _SEGMENT_ENTRY_INVALID;
-		gmap_pmdp_xchg(gmap, pmdp, new, gaddr);
+		gmap_pmdp_xchg(gmap, pmdp, new, gaddr, vmaddr);
 	}
 
 	if (prot == PROT_READ && !pmd_p) {
 		pmd_val(new) &= ~_SEGMENT_ENTRY_INVALID;
 		pmd_val(new) |= _SEGMENT_ENTRY_PROTECT;
-		gmap_pmdp_xchg(gmap, pmdp, new, gaddr);
+		gmap_pmdp_xchg(gmap, pmdp, new, gaddr, vmaddr);
 	}
 
 	if (bits & GMAP_NOTIFY_MPROT)
@@ -1164,10 +1162,14 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 	int rc;
 
 	BUG_ON(gmap_is_shadow(gmap));
+
 	while (len) {
 		rc = -EAGAIN;
-
-		pmdp = gmap_pmd_op_walk(gmap, gaddr, &ptl_pmd);
+		vmaddr = __gmap_translate(gmap, gaddr);
+		if (IS_ERR_VALUE(vmaddr))
+			return vmaddr;
+		vmaddr |= gaddr & ~PMD_MASK;
+		pmdp = gmap_pmd_op_walk(gmap, gaddr, vmaddr, &ptl_pmd);
 		if (pmdp && !(pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)) {
 			if (!pmd_large(*pmdp)) {
 				ptep = gmap_pte_from_pmd(gmap, pmdp, gaddr,
@@ -1192,7 +1194,7 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 						return -ENOMEM;
 					continue;
 				} else {
-					gmap_pmd_split(gmap, gaddr,
+					gmap_pmd_split(gmap, gaddr, vmaddr,
 						       pmdp, page);
 					page = NULL;
 				}
@@ -1206,9 +1208,6 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 				return rc;
 
 			/* -EAGAIN, fixup of userspace mm and gmap */
-			vmaddr = __gmap_translate(gmap, gaddr);
-			if (IS_ERR_VALUE(vmaddr))
-				return vmaddr;
 			rc = gmap_fixup(gmap, gaddr, vmaddr, prot);
 			if (rc)
 				return rc;
@@ -2432,6 +2431,7 @@ static inline void pmdp_notify_split(struct gmap *gmap, pmd_t *pmdp,
 static void pmdp_notify_gmap(struct gmap *gmap, pmd_t *pmdp,
 			     unsigned long gaddr, unsigned long vmaddr)
 {
+	BUG_ON((gaddr & ~HPAGE_MASK) || (vmaddr & ~HPAGE_MASK));
 	if (gmap_pmd_is_split(pmdp))
 		return pmdp_notify_split(gmap, pmdp, gaddr, vmaddr);
 
@@ -2452,10 +2452,11 @@ static void pmdp_notify_gmap(struct gmap *gmap, pmd_t *pmdp,
  * held.
  */
 static void gmap_pmdp_xchg(struct gmap *gmap, pmd_t *pmdp, pmd_t new,
-			   unsigned long gaddr)
+			   unsigned long gaddr, unsigned long vmaddr)
 {
 	gaddr &= HPAGE_MASK;
-	pmdp_notify_gmap(gmap, pmdp, gaddr, 0);
+	vmaddr &= HPAGE_MASK;
+	pmdp_notify_gmap(gmap, pmdp, gaddr, vmaddr);
 	if (pmd_large(new))
 		pmd_val(new) &= ~GMAP_SEGMENT_NOTIFY_BITS;
 	if (MACHINE_HAS_TLB_GUEST)
@@ -2603,7 +2604,7 @@ EXPORT_SYMBOL_GPL(gmap_pmdp_idte_global);
  * held.
  */
 bool gmap_test_and_clear_dirty_pmd(struct gmap *gmap, pmd_t *pmdp,
-				   unsigned long gaddr)
+				   unsigned long gaddr, unsigned long vmaddr)
 {
 	if (pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)
 		return false;
@@ -2615,7 +2616,7 @@ bool gmap_test_and_clear_dirty_pmd(struct gmap *gmap, pmd_t *pmdp,
 
 	/* Clear UC indication and reset protection */
 	pmd_val(*pmdp) &= ~_SEGMENT_ENTRY_GMAP_UC;
-	gmap_protect_pmd(gmap, gaddr, pmdp, PROT_READ, 0);
+	gmap_protect_pmd(gmap, gaddr, vmaddr, pmdp, PROT_READ, 0);
 	return true;
 }
 
@@ -2638,12 +2639,12 @@ void gmap_sync_dirty_log_pmd(struct gmap *gmap, unsigned long bitmap[4],
 	spinlock_t *ptl_pmd = NULL;
 	spinlock_t *ptl_pte = NULL;
 
-	pmdp = gmap_pmd_op_walk(gmap, gaddr, &ptl_pmd);
+	pmdp = gmap_pmd_op_walk(gmap, gaddr, vmaddr, &ptl_pmd);
 	if (!pmdp)
 		return;
 
 	if (pmd_large(*pmdp)) {
-		if (gmap_test_and_clear_dirty_pmd(gmap, pmdp, gaddr))
+		if (gmap_test_and_clear_dirty_pmd(gmap, pmdp, gaddr, vmaddr))
 			bitmap_fill(bitmap, _PAGE_ENTRIES);
 	} else {
 		for (i = 0; i < _PAGE_ENTRIES; i++, vmaddr += PAGE_SIZE) {
-- 
2.14.3
