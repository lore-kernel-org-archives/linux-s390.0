From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 19 Sep 2018 08:47:55 +0000
Subject: [RFC 07/14] s390/mm: Add gmap_idte_global
Message-Id: <20180919084802.183381-8-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Introduce a function to do a idte global flush on a gmap pmd and
remove some code duplication.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/mm/gmap.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 70763bcd0e0b..26cc6ce19afb 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1005,6 +1005,18 @@ static pte_t *gmap_pte_from_pmd(struct gmap *gmap, pmd_t *pmdp,
 	return pte_offset_map(pmdp, addr);
 }
 
+static inline void gmap_idte_global(unsigned long asce, pmd_t *pmdp,
+				    unsigned long gaddr)
+{
+	if (MACHINE_HAS_TLB_GUEST)
+		__pmdp_idte(gaddr, pmdp, IDTE_GUEST_ASCE, asce,
+			    IDTE_GLOBAL);
+	else if (MACHINE_HAS_IDTE)
+		__pmdp_idte(gaddr, pmdp, 0, 0, IDTE_GLOBAL);
+	else
+		__pmdp_csp(pmdp);
+}
+
 /**
  * gmap_pmd_split_free - Free a split pmd's page table
  * @pmdp The split pmd that we free of its page table
@@ -2459,13 +2471,7 @@ static void gmap_pmdp_xchg(struct gmap *gmap, pmd_t *pmdp, pmd_t new,
 	pmdp_notify_gmap(gmap, pmdp, gaddr, vmaddr);
 	if (pmd_large(new))
 		pmd_val(new) &= ~GMAP_SEGMENT_NOTIFY_BITS;
-	if (MACHINE_HAS_TLB_GUEST)
-		__pmdp_idte(gaddr, pmdp, IDTE_GUEST_ASCE, gmap->asce,
-			    IDTE_GLOBAL);
-	else if (MACHINE_HAS_IDTE)
-		__pmdp_idte(gaddr, pmdp, 0, 0, IDTE_GLOBAL);
-	else
-		__pmdp_csp(pmdp);
+	gmap_idte_global(gmap->asce, pmdp, gaddr);
 	*pmdp = new;
 }
 
@@ -2578,13 +2584,7 @@ void gmap_pmdp_idte_global(struct mm_struct *mm, unsigned long vmaddr)
 			pmdp_notify_gmap(gmap, pmdp, gaddr, vmaddr);
 			if (pmd_large(*pmdp))
 				WARN_ON(*entry & GMAP_SEGMENT_NOTIFY_BITS);
-			if (MACHINE_HAS_TLB_GUEST)
-				__pmdp_idte(gaddr, pmdp, IDTE_GUEST_ASCE,
-					    gmap->asce, IDTE_GLOBAL);
-			else if (MACHINE_HAS_IDTE)
-				__pmdp_idte(gaddr, pmdp, 0, 0, IDTE_GLOBAL);
-			else
-				__pmdp_csp(pmdp);
+			gmap_idte_global(gmap->asce, pmdp, gaddr);
 			gmap_pmd_split_free(gmap, pmdp);
 			*entry = _SEGMENT_ENTRY_EMPTY;
 		}
-- 
2.14.3
