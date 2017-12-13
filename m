From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [RFC/PATCH v2 14/22] s390/mm: Make protect_rmap EDAT1 compatible
Date: Wed, 13 Dec 2017 13:53:25 +0100
Message-ID: <1513169613-13509-15-git-send-email-frankja@linux.vnet.ibm.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
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
 arch/s390/mm/gmap.c | 80 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 66 insertions(+), 14 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 828eadf..d45ac26da 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1275,6 +1275,51 @@ static inline void gmap_insert_rmap(struct gmap *sg, unsigned long vmaddr,
 	}
 }
 
+static int gmap_protect_rmap_pmd(struct gmap *sg, struct gmap_rmap *rmap,
+				 unsigned long paddr, unsigned long vmaddr,
+				 pmd_t *pmdp, int prot)
+{
+	int rc = 0;
+
+	/* We have no upper segment, let's go back and fix this up. */
+	if (pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)
+		return -EAGAIN;
+
+	spin_lock(&sg->guest_table_lock);
+	rc = gmap_protect_large(sg->parent, paddr, pmdp,
+				prot, GMAP_NOTIFY_SHADOW);
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
+	ptep = pte_alloc_map_lock(sg->parent->mm, pmdp, paddr, &ptl);
+	if (ptep) {
+		spin_lock(&sg->guest_table_lock);
+		rc = ptep_force_prot(sg->parent->mm, paddr, ptep, prot,
+				     PGSTE_VSIE_BIT);
+		if (!rc)
+			gmap_insert_rmap(sg, vmaddr, rmap);
+		spin_unlock(&sg->guest_table_lock);
+		gmap_pte_op_end(ptl);
+	}
+	return rc;
+}
+
 /**
  * gmap_protect_rmap - modify access rights to memory and create an rmap
  * @sg: pointer to the shadow guest address space structure
@@ -1291,9 +1336,8 @@ static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
 {
 	struct gmap *parent;
 	struct gmap_rmap *rmap;
-	unsigned long vmaddr;
-	spinlock_t *ptl;
-	pte_t *ptep;
+	unsigned long vmaddr, dist;
+	pmd_t *pmdp;
 	int rc;
 
 	BUG_ON(!gmap_is_shadow(sg));
@@ -1312,15 +1356,25 @@ static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
 			return rc;
 		}
 		rc = -EAGAIN;
-		ptep = gmap_pte_op_walk(parent, paddr, &ptl);
-		if (ptep) {
-			spin_lock(&sg->guest_table_lock);
-			rc = ptep_force_prot(parent->mm, paddr, ptep, prot,
-					     GMAP_NOTIFY_SHADOW);
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
+				rc = gmap_protect_rmap_pmd(sg, rmap, paddr,
+							   vmaddr, pmdp, prot);
+				if (!rc) {
+					dist = HPAGE_SIZE - (paddr & ~HPAGE_MASK);
+					len = len < dist ? 0 : len - dist;
+					paddr = (paddr & HPAGE_MASK) + HPAGE_SIZE;
+				}
+			}
+			gmap_pmd_op_end(parent, pmdp);
 		}
 		radix_tree_preload_end();
 		if (rc) {
@@ -1330,8 +1384,6 @@ static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
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
