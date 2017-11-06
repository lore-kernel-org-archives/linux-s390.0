From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [RFC/PATCH 14/22] s390/mm: Make protect_rmap EDAT1 compatible
Date: Mon,  6 Nov 2017 23:29:52 +0100
Message-ID: <1510007400-42493-15-git-send-email-frankja@linux.vnet.ibm.com>
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

When shadowing, we must make sure, that any changes to the GMAP inside
guest N will also be directly reflected in our shadow GMAP. This is
done by write-protecting guest N memory at the places where it stores
DAT tables for guest N + 1.

This still lacks EDAT1 support, so let's add it.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
---
 arch/s390/mm/gmap.c | 82 ++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 69 insertions(+), 13 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index c8296bc..f6a28d9 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1289,6 +1289,56 @@ static inline void gmap_insert_rmap(struct gmap *sg, unsigned long vmaddr,
 	}
 }
 
+static int gmap_protect_rmap_large(struct gmap *sg, struct gmap_rmap *rmap,
+				   unsigned long paddr, unsigned long vmaddr,
+				   pmd_t *pmdp, int prot)
+{
+	int rc = 0;
+
+	/* We have no upper segment, let's go back and fix this up. */
+	if (pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)
+		return -EAGAIN;
+
+	spin_lock(&sg->guest_table_lock);
+	rc = gmap_protect_large(sg->parent, paddr, pmdp,
+				prot, GMAP_ENTRY_VSIE);
+	if (!rc)
+		gmap_insert_rmap(sg, vmaddr & HPAGE_MASK, rmap);
+
+	spin_unlock(&sg->guest_table_lock);
+	return rc;
+}
+
+static int gmap_protect_rmap_pte(struct gmap *sg, struct gmap_rmap *rmap,
+				 unsigned long paddr, unsigned long vmaddr,
+				 pmd_t *pmdp, int prot)
+{
+	int rc = 0;
+	pte_t *ptep = NULL;
+	spinlock_t *ptl = NULL;
+
+	/* We have no upper segment, let's go back and fix this up. */
+	if (pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)
+		return -EAGAIN;
+
+	if (gmap_is_shadow(sg->parent))
+		ptep = pte_offset_map(pmdp, paddr);
+	else
+		ptep = pte_alloc_map_lock(sg->parent->mm, pmdp, paddr, &ptl);
+
+	if (ptep) {
+		spin_lock(&sg->guest_table_lock);
+		rc = ptep_force_prot(sg->parent->mm, paddr, ptep, prot,
+				     PGSTE_VSIE_BIT);
+		if (!rc)
+			gmap_insert_rmap(sg, vmaddr, rmap);
+		spin_unlock(&sg->guest_table_lock);
+		if (ptl)
+			gmap_pte_op_end(ptl);
+	}
+	return rc;
+}
+
 /**
  * gmap_protect_rmap - modify access rights to memory and create an rmap
  * @sg: pointer to the shadow guest address space structure
@@ -1306,8 +1356,7 @@ static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
 	struct gmap *parent;
 	struct gmap_rmap *rmap;
 	unsigned long vmaddr;
-	spinlock_t *ptl;
-	pte_t *ptep;
+	pmd_t *pmdp;
 	int rc;
 
 	BUG_ON(!gmap_is_shadow(sg));
@@ -1326,15 +1375,24 @@ static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
 			return rc;
 		}
 		rc = -EAGAIN;
-		ptep = gmap_pte_op_walk(parent, paddr, &ptl);
-		if (ptep) {
-			spin_lock(&sg->guest_table_lock);
-			rc = ptep_force_prot(parent->mm, paddr, ptep, prot,
-					     GMAP_ENTRY_VSIE);
-			if (!rc)
-				gmap_insert_rmap(sg, vmaddr, rmap);
-			spin_unlock(&sg->guest_table_lock);
-			gmap_pte_op_end(ptl);
+		pmdp = gmap_pmd_op_walk(parent, paddr);
+		if (pmdp) {
+			if (!pmd_large(*pmdp)) {
+				rc = gmap_protect_rmap_pte(sg, rmap, paddr,
+							   vmaddr, pmdp, prot);
+				if (!rc) {
+					paddr += PAGE_SIZE;
+					len -= PAGE_SIZE;
+				}
+			} else {
+				rc = gmap_protect_rmap_large(sg, rmap, paddr,
+							     vmaddr, pmdp, prot);
+				if (!rc) {
+					len = len < HPAGE_SIZE ? 0 : len - HPAGE_SIZE;
+					paddr = (paddr & HPAGE_MASK) + HPAGE_SIZE;
+				}
+			}
+			gmap_pmd_op_end(parent, pmdp);
 		}
 		radix_tree_preload_end();
 		if (rc) {
@@ -1344,8 +1402,6 @@ static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
 				return rc;
 			continue;
 		}
-		paddr += PAGE_SIZE;
-		len -= PAGE_SIZE;
 	}
 	return 0;
 }
-- 
2.7.4
