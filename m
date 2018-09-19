From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 19 Sep 2018 08:47:57 +0000
Subject: [RFC 09/14] s390/mm: Make gmap_protect_rmap EDAT1 compatible
Message-Id: <20180919084802.183381-10-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

For the upcoming large page shadowing support, let's add the
possibility to split a huge page and protect it with
gmap_protect_rmap() for shadowing purposes.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/mm/gmap.c | 87 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 67 insertions(+), 20 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index ba0425f1c2c0..c64f9a48f5f8 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1138,7 +1138,8 @@ static int gmap_protect_pmd(struct gmap *gmap, unsigned long gaddr,
  * Expected to be called with sg->mm->mmap_sem in read
  */
 static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
-			    pte_t *ptep, int prot, unsigned long bits)
+			    unsigned long vmaddr, pte_t *ptep,
+			    int prot, unsigned long bits)
 {
 	int rc;
 	unsigned long pbits = 0;
@@ -1187,7 +1188,7 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 				ptep = gmap_pte_from_pmd(gmap, pmdp, gaddr,
 							 &ptl_pte);
 				if (ptep)
-					rc = gmap_protect_pte(gmap, gaddr,
+					rc = gmap_protect_pte(gmap, gaddr, vmaddr,
 							      ptep, prot, bits);
 				else
 					rc = -ENOMEM;
@@ -1346,6 +1347,21 @@ static inline void gmap_insert_rmap(struct gmap *sg, unsigned long vmaddr,
 	}
 }
 
+static int gmap_protect_rmap_pte(struct gmap *sg, struct gmap_rmap *rmap,
+				 unsigned long paddr, unsigned long vmaddr,
+				 pte_t *ptep, int prot)
+{
+	int rc = 0;
+
+	spin_lock(&sg->guest_table_lock);
+	rc = gmap_protect_pte(sg->parent, paddr, vmaddr, ptep,
+			      prot, GMAP_NOTIFY_SHADOW);
+	if (!rc)
+		gmap_insert_rmap(sg, vmaddr, rmap);
+	spin_unlock(&sg->guest_table_lock);
+	return rc;
+}
+
 /**
  * gmap_protect_rmap - restrict access rights to memory (RO) and create an rmap
  * @sg: pointer to the shadow guest address space structure
@@ -1362,16 +1378,15 @@ static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
 	struct gmap *parent;
 	struct gmap_rmap *rmap;
 	unsigned long vmaddr;
-	spinlock_t *ptl;
+	pmd_t *pmdp;
 	pte_t *ptep;
+	spinlock_t *ptl_pmd = NULL, *ptl_pte = NULL;
+	struct page *page = NULL;
 	int rc;
 
 	BUG_ON(!gmap_is_shadow(sg));
 	parent = sg->parent;
 	while (len) {
-		vmaddr = __gmap_translate(parent, paddr);
-		if (IS_ERR_VALUE(vmaddr))
-			return vmaddr;
 		rmap = kzalloc(sizeof(*rmap), GFP_KERNEL);
 		if (!rmap)
 			return -ENOMEM;
@@ -1382,26 +1397,58 @@ static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
 			return rc;
 		}
 		rc = -EAGAIN;
-		ptep = gmap_pte_op_walk(parent, paddr, &ptl);
-		if (ptep) {
-			spin_lock(&sg->guest_table_lock);
-			rc = ptep_force_prot(parent->mm, paddr, ptep, PROT_READ,
-					     PGSTE_VSIE_BIT);
-			if (!rc)
-				gmap_insert_rmap(sg, vmaddr, rmap);
-			spin_unlock(&sg->guest_table_lock);
-			gmap_pte_op_end(ptl);
+		vmaddr = __gmap_translate(parent, paddr);
+		if (IS_ERR_VALUE(vmaddr))
+			return vmaddr;
+		vmaddr |= paddr & ~PMD_MASK;
+		pmdp = gmap_pmd_op_walk(parent, paddr, vmaddr, &ptl_pmd);
+		if (pmdp && !(pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)) {
+			if (!pmd_large(*pmdp)) {
+				ptl_pte = NULL;
+				ptep = gmap_pte_from_pmd(parent, pmdp, paddr,
+							 &ptl_pte);
+				if (ptep)
+					rc = gmap_protect_rmap_pte(sg, rmap, paddr,
+								   vmaddr, ptep,
+								   PROT_READ);
+				else
+					rc = -ENOMEM;
+				gmap_pte_op_end(ptl_pte);
+				if (!rc) {
+					paddr += PAGE_SIZE;
+					len -= PAGE_SIZE;
+				}
+			} else {
+				if (!page) {
+					/* Drop locks for allocation. */
+					gmap_pmd_op_end(ptl_pmd);
+					ptl_pmd = NULL;
+					radix_tree_preload_end();
+					kfree(rmap);
+					page = page_table_alloc_pgste(parent->mm);
+					if (!page)
+						return -ENOMEM;
+					continue;
+				} else {
+					gmap_pmd_split(parent, paddr, vmaddr,
+						       pmdp, page);
+					page = NULL;
+				}
+
+			}
+			gmap_pmd_op_end(ptl_pmd);
 		}
-		radix_tree_preload_end();
-		if (rc) {
+		if (page)
+			page_table_free_pgste(page);
+		else
+			radix_tree_preload_end();
+		if (rc)
 			kfree(rmap);
+		if (rc == -EAGAIN) {
 			rc = gmap_fixup(parent, paddr, vmaddr, PROT_READ);
 			if (rc)
 				return rc;
-			continue;
 		}
-		paddr += PAGE_SIZE;
-		len -= PAGE_SIZE;
 	}
 	return 0;
 }
-- 
2.14.3
