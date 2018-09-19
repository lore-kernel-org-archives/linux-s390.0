From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 19 Sep 2018 08:48:01 +0000
Subject: [RFC 13/14] s390/mm: Pull pmd invalid check in gmap_pmd_op_walk
Message-Id: <20180919084802.183381-14-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Not yet sure if I'll keep this.

The walk should only walk and not check I, but then it looks way
nicer.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/mm/gmap.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 0220a32aa2b9..8d5ce51637eb 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -952,7 +952,8 @@ static inline pmd_t *gmap_pmd_op_walk(struct gmap *gmap, unsigned long gaddr,
 	}
 
 	pmdp = (pmd_t *) gmap_table_walk(gmap, gaddr, 1);
-	if (!pmdp || pmd_none(*pmdp)) {
+	if (!pmdp || pmd_none(*pmdp) ||
+	    pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID) {
 		if (*ptl)
 			spin_unlock(*ptl);
 		pmdp = NULL;
@@ -1161,7 +1162,7 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 			return vmaddr;
 		vmaddr |= gaddr & ~PMD_MASK;
 		pmdp = gmap_pmd_op_walk(gmap, gaddr, vmaddr, &ptl_pmd);
-		if (pmdp && !(pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)) {
+		if (pmdp) {
 			if (!pmd_large(*pmdp)) {
 				ptep = gmap_pte_from_pmd(gmap, pmdp, gaddr,
 							 &ptl_pte);
@@ -1266,7 +1267,7 @@ int gmap_read_table(struct gmap *gmap, unsigned long gaddr, unsigned long *val)
 		if (IS_ERR_VALUE(vmaddr))
 			return vmaddr;
 		pmdp = gmap_pmd_op_walk(gmap, gaddr, vmaddr, &ptl_pmd);
-		if (pmdp && !(pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)) {
+		if (pmdp) {
 			if (!pmd_large(*pmdp)) {
 				ptep = gmap_pte_from_pmd(gmap, pmdp, vmaddr, &ptl_pte);
 				if (ptep) {
@@ -1380,7 +1381,7 @@ static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
 			return vmaddr;
 		vmaddr |= paddr & ~PMD_MASK;
 		pmdp = gmap_pmd_op_walk(parent, paddr, vmaddr, &ptl_pmd);
-		if (pmdp && !(pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)) {
+		if (pmdp) {
 			if (!pmd_large(*pmdp)) {
 				ptl_pte = NULL;
 				ptep = gmap_pte_from_pmd(parent, pmdp, paddr,
@@ -2362,8 +2363,7 @@ int gmap_shadow_segment(struct gmap *sg, unsigned long saddr, pmd_t pmd)
 				break;
 			}
 			spmd = *spmdp;
-			if (!(pmd_val(spmd) & _SEGMENT_ENTRY_INVALID) &&
-			    !((pmd_val(spmd) & _SEGMENT_ENTRY_PROTECT) &&
+			if (!((pmd_val(spmd) & _SEGMENT_ENTRY_PROTECT) &&
 			      !(pmd_val(pmd) & _SEGMENT_ENTRY_PROTECT))) {
 
 				pmd_val(*spmdp) |= _SEGMENT_ENTRY_GMAP_VSIE;
@@ -2436,7 +2436,7 @@ int gmap_shadow_page(struct gmap *sg, unsigned long saddr, pte_t pte)
 			break;
 		rc = -EAGAIN;
 		spmdp = gmap_pmd_op_walk(parent, paddr, vmaddr, &ptl_pmd);
-		if (spmdp && !(pmd_val(*spmdp) & _SEGMENT_ENTRY_INVALID)) {
+		if (spmdp) {
 			/* Get page table pointer */
 			tptep = (pte_t *) gmap_table_walk(sg, saddr, 0);
 			if (!tptep) {
@@ -2869,9 +2869,6 @@ EXPORT_SYMBOL_GPL(gmap_pmdp_idte_global);
 bool gmap_test_and_clear_dirty_pmd(struct gmap *gmap, pmd_t *pmdp,
 				   unsigned long gaddr, unsigned long vmaddr)
 {
-	if (pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)
-		return false;
-
 	/* Already protected memory, which did not change is clean */
 	if (pmd_val(*pmdp) & _SEGMENT_ENTRY_PROTECT &&
 	    !(pmd_val(*pmdp) & _SEGMENT_ENTRY_GMAP_UC))
-- 
2.14.3
