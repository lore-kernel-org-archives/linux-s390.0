From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [RFC/PATCH v3 08/16] s390/mm: Make protect_rmap EDAT1 compatible
Date: Fri,  9 Feb 2018 10:34:16 +0100
Message-ID: <1518168864-147803-9-git-send-email-frankja@linux.vnet.ibm.com>
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
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
 arch/s390/mm/gmap.c | 97 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 77 insertions(+), 20 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 5699770..66789e2 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1096,6 +1096,18 @@ static void gmap_pmdp_transfer_prot(struct mm_struct *mm, unsigned long addr,
 	*hpmdp = new;
 }
 
+static void gmap_pte_transfer_prot(struct mm_struct *mm, unsigned long addr,
+				   pte_t *gptep, pmd_t *hpmdp)
+{
+	pmd_t mpmd = __pmd(0);
+
+	if (pte_val(*gptep) & _PAGE_PROTECT)
+		pmd_val(mpmd) |= _SEGMENT_ENTRY_PROTECT;
+	if (pte_val(*gptep) & _PAGE_INVALID)
+		pmd_val(mpmd) |= _SEGMENT_ENTRY_INVALID;
+	gmap_pmdp_transfer_prot(mm, addr, &mpmd, hpmdp);
+}
+
 /*
  * gmap_protect_pmd - set pmd notification bits
  * @pmdp: pointer to the pmd to be protected
@@ -1141,7 +1153,8 @@ static int gmap_protect_pmd(struct gmap *gmap, unsigned long gaddr,
  * guest_table_lock held for shadow gmaps.
  */
 static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
-			    pmd_t *pmdp, int prot, unsigned long bits)
+			    unsigned long vmaddr, pmd_t *pmdp, pmd_t *hpmdp,
+			    int prot, unsigned long bits)
 {
 	int rc;
 	pte_t *ptep;
@@ -1157,6 +1170,8 @@ static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
 	/* Protect and unlock. */
 	rc = ptep_force_prot(gmap->mm, gaddr, ptep, prot, pbits);
 	gmap_pte_op_end(ptl);
+	if (!rc && gmap_pmd_is_split(pmdp))
+		gmap_pte_transfer_prot(gmap->mm, vmaddr, ptep, hpmdp);
 	return rc;
 }
 
@@ -1178,17 +1193,25 @@ static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
 static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 			      unsigned long len, int prot, unsigned long bits)
 {
+	spinlock_t *ptl;
 	unsigned long vmaddr;
-	pmd_t *pmdp;
+	pmd_t *pmdp, *hpmdp;
 	int rc;
 
 	while (len) {
 		rc = -EAGAIN;
+		vmaddr = __gmap_translate(gmap, gaddr);
+		hpmdp = (pmd_t *)huge_pte_offset(gmap->mm, vmaddr, HPAGE_SIZE);
+		if (!hpmdp)
+			BUG();
+		/* Do we need tests here? */
+		ptl = pmd_lock(gmap->mm, hpmdp);
+
 		pmdp = gmap_pmd_op_walk(gmap, gaddr);
 		if (pmdp && !(pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)) {
 			if (!pmd_large(*pmdp)) {
-				rc = gmap_protect_pte(gmap, gaddr, pmdp, prot,
-						      bits);
+				rc = gmap_protect_pte(gmap, gaddr, vmaddr,
+						      pmdp, hpmdp, prot, bits);
 				if (!rc) {
 					len -= PAGE_SIZE;
 					gaddr += PAGE_SIZE;
@@ -1200,6 +1223,7 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 			}
 			gmap_pmd_op_end(gmap, pmdp);
 		}
+		spin_unlock(ptl);
 		if (rc && rc != -EFAULT) {
 			vmaddr = __gmap_translate(gmap, gaddr);
 			if (IS_ERR_VALUE(vmaddr))
@@ -1268,7 +1292,7 @@ int gmap_read_table(struct gmap *gmap, unsigned long gaddr, unsigned long *val,
 		pmdp = gmap_pmd_op_walk(gmap, gaddr);
 		if (pmdp && !(pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)) {
 			if (!pmd_large(*pmdp)) {
-				ptep = pte_alloc_map_lock(gmap->mm, pmdp, gaddr, &ptl);
+				ptep = gmap_pte_from_pmd(gmap, pmdp, gaddr, &ptl);
 				if (ptep) {
 					pte = *ptep;
 					if (pte_present(pte) && (pte_val(pte) & _PAGE_READ)) {
@@ -1331,6 +1355,28 @@ static inline void gmap_insert_rmap(struct gmap *sg, unsigned long vmaddr,
 	}
 }
 
+static int gmap_protect_rmap_pte(struct gmap *sg, struct gmap_rmap *rmap,
+				 unsigned long paddr, unsigned long vmaddr,
+				 pmd_t *pmdp, pmd_t *hpmdp, int prot)
+{
+	int rc = 0;
+	pte_t *ptep = NULL;
+	spinlock_t *ptl = NULL;
+
+	ptep = gmap_pte_from_pmd(sg->parent, pmdp, paddr, &ptl);
+	if (unlikely(!ptep))
+		return -ENOMEM;
+
+	spin_lock(&sg->guest_table_lock);
+	rc = gmap_protect_pte(sg->parent, paddr, vmaddr, pmdp, hpmdp,
+			      prot, GMAP_NOTIFY_SHADOW);
+	if (!rc)
+		gmap_insert_rmap(sg, vmaddr, rmap);
+	spin_unlock(&sg->guest_table_lock);
+	gmap_pte_op_end(ptl);
+	return rc;
+}
+
 /**
  * gmap_protect_rmap - modify access rights to memory and create an rmap
  * @sg: pointer to the shadow guest address space structure
@@ -1348,8 +1394,8 @@ static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
 	struct gmap *parent;
 	struct gmap_rmap *rmap;
 	unsigned long vmaddr;
+	pmd_t *pmdp, *hpmdp;
 	spinlock_t *ptl;
-	pte_t *ptep;
 	int rc;
 
 	BUG_ON(!gmap_is_shadow(sg));
@@ -1358,36 +1404,47 @@ static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
 		vmaddr = __gmap_translate(parent, paddr);
 		if (IS_ERR_VALUE(vmaddr))
 			return vmaddr;
+		hpmdp = (pmd_t *)huge_pte_offset(parent->mm, vmaddr, HPAGE_SIZE);
+		ptl = pmd_lock(parent->mm, hpmdp);
 		rmap = kzalloc(sizeof(*rmap), GFP_KERNEL);
-		if (!rmap)
+		if (!rmap) {
+			spin_unlock(ptl);
 			return -ENOMEM;
+		}
 		rmap->raddr = raddr;
 		rc = radix_tree_preload(GFP_KERNEL);
 		if (rc) {
+			spin_unlock(ptl);
 			kfree(rmap);
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
+		if (pmdp && !(pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)) {
+			if (!pmd_large(*pmdp)) {
+				rc = gmap_protect_rmap_pte(sg, rmap, paddr,
+							   vmaddr, pmdp, hpmdp,
+							   prot);
+				if (!rc) {
+					paddr += PAGE_SIZE;
+					len -= PAGE_SIZE;
+				}
+			} else {
+				rc = gmap_pmd_split(parent, paddr, pmdp);
+				if (!rc)
+					rc = -EFAULT;
+			}
+			gmap_pmd_op_end(parent, pmdp);
 		}
+		spin_unlock(ptl);
 		radix_tree_preload_end();
-		if (rc) {
+		if (rc)
 			kfree(rmap);
+		if (rc == -EAGAIN) {
 			rc = gmap_pte_op_fixup(parent, paddr, vmaddr, prot);
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
2.7.4
