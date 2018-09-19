From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 19 Sep 2018 08:47:51 +0000
Subject: [RFC 03/14] s390/mm: Take locking out of gmap_protect_pte
Message-Id: <20180919084802.183381-4-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Locking outside of the function gives us the freedom of ordering
locks, which will be important to not get locking issues for
gmap_protect_rmap.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/mm/gmap.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 04c24a284113..795f558c8246 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1013,25 +1013,15 @@ static int gmap_protect_pmd(struct gmap *gmap, unsigned long gaddr,
  * Expected to be called with sg->mm->mmap_sem in read
  */
 static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
-			    pmd_t *pmdp, int prot, unsigned long bits)
+			    pte_t *ptep, int prot, unsigned long bits)
 {
 	int rc;
-	pte_t *ptep;
-	spinlock_t *ptl = NULL;
 	unsigned long pbits = 0;
 
-	if (pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)
-		return -EAGAIN;
-
-	ptep = pte_alloc_map_lock(gmap->mm, pmdp, gaddr, &ptl);
-	if (!ptep)
-		return -ENOMEM;
-
 	pbits |= (bits & GMAP_NOTIFY_MPROT) ? PGSTE_IN_BIT : 0;
 	pbits |= (bits & GMAP_NOTIFY_SHADOW) ? PGSTE_VSIE_BIT : 0;
 	/* Protect and unlock. */
 	rc = ptep_force_prot(gmap->mm, gaddr, ptep, prot, pbits);
-	gmap_pte_op_end(ptl);
 	return rc;
 }
 
@@ -1052,18 +1042,26 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 			      unsigned long len, int prot, unsigned long bits)
 {
 	unsigned long vmaddr, dist;
-	spinlock_t *ptl = NULL;
+	spinlock_t *ptl_pmd = NULL, *ptl_pte = NULL;
 	pmd_t *pmdp;
+	pte_t *ptep;
 	int rc;
 
 	BUG_ON(gmap_is_shadow(gmap));
 	while (len) {
 		rc = -EAGAIN;
-		pmdp = gmap_pmd_op_walk(gmap, gaddr, &ptl);
+		pmdp = gmap_pmd_op_walk(gmap, gaddr, &ptl_pmd);
 		if (pmdp) {
 			if (!pmd_large(*pmdp)) {
-				rc = gmap_protect_pte(gmap, gaddr, pmdp, prot,
-						      bits);
+				ptl_pte = NULL;
+				ptep = pte_alloc_map_lock(gmap->mm, pmdp, gaddr,
+							  &ptl_pte);
+				if (ptep)
+					rc = gmap_protect_pte(gmap, gaddr,
+							      ptep, prot, bits);
+				else
+					rc = -ENOMEM;
+				gmap_pte_op_end(ptl_pte);
 				if (!rc) {
 					len -= PAGE_SIZE;
 					gaddr += PAGE_SIZE;
@@ -1077,7 +1075,7 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 					gaddr = (gaddr & HPAGE_MASK) + HPAGE_SIZE;
 				}
 			}
-			gmap_pmd_op_end(ptl);
+			gmap_pmd_op_end(ptl_pmd);
 		}
 		if (rc) {
 			if (rc == -EINVAL)
-- 
2.14.3
