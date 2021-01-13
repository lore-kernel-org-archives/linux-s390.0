Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47162 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727374AbhAMJmY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Jan 2021 04:42:24 -0500
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH 09/14] s390/mm: Make gmap_protect_rmap EDAT1 compatible
Date: Wed, 13 Jan 2021 09:41:08 +0000
Message-Id: <20210113094113.133668-10-frankja@linux.ibm.com>
In-Reply-To: <20210113094113.133668-1-frankja@linux.ibm.com>
References: <20210113094113.133668-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, david@redhat.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com

For the upcoming large page shadowing support, let's add the
possibility to split a huge page and protect it with
gmap_protect_rmap() for shadowing purposes.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/mm/gmap.c | 93 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 73 insertions(+), 20 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 910371dc511d..f20aa49c2791 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1142,7 +1142,8 @@ static int gmap_protect_pmd(struct gmap *gmap, unsigned long gaddr,
  * Expected to be called with sg->mm->mmap_lock in read
  */
 static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
-			    pte_t *ptep, int prot, unsigned long bits)
+			    unsigned long vmaddr, pte_t *ptep,
+			    int prot, unsigned long bits)
 {
 	int rc;
 	unsigned long pbits = 0;
@@ -1191,7 +1192,7 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 				ptep = gmap_pte_from_pmd(gmap, pmdp, gaddr,
 							 &ptl_pte);
 				if (ptep)
-					rc = gmap_protect_pte(gmap, gaddr,
+					rc = gmap_protect_pte(gmap, gaddr, vmaddr,
 							      ptep, prot, bits);
 				else
 					rc = -ENOMEM;
@@ -1354,6 +1355,21 @@ static inline void gmap_insert_rmap(struct gmap *sg, unsigned long vmaddr,
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
@@ -1370,16 +1386,15 @@ static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
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
 		rmap = kzalloc(sizeof(*rmap), GFP_KERNEL_ACCOUNT);
 		if (!rmap)
 			return -ENOMEM;
@@ -1390,26 +1405,64 @@ static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
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
+				gmap_pmd_op_end(ptl_pmd);
+				if (!rc) {
+					paddr += PAGE_SIZE;
+					len -= PAGE_SIZE;
+					radix_tree_preload_end();
+					continue;
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
+					gmap_pmd_op_end(ptl_pmd);
+					radix_tree_preload_end();
+					kfree(rmap);
+					page = NULL;
+					continue;
+				}
+
+			}
+		}
+		if (page) {
+			page_table_free_pgste(page);
+			page = NULL;
 		}
 		radix_tree_preload_end();
-		if (rc) {
-			kfree(rmap);
+		kfree(rmap);
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
2.27.0
