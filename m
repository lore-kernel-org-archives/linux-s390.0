Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41716 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727250AbhAMJmX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Jan 2021 04:42:23 -0500
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH 02/14] s390/mm: Improve locking for huge page backings
Date: Wed, 13 Jan 2021 09:41:01 +0000
Message-Id: <20210113094113.133668-3-frankja@linux.ibm.com>
In-Reply-To: <20210113094113.133668-1-frankja@linux.ibm.com>
References: <20210113094113.133668-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, david@redhat.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com

The gmap guest_table_lock is used to protect changes to the guest's
DAT tables from region 1 to segments. Therefore it also protects the
host to guest radix tree where each new segment mapping by gmap_link()
is tracked. Changes to ptes are synchronized through the pte lock,
which is easily retrievable, because the gmap shares the page tables
with userspace.

With huge pages the story changes. PMD tables are not shared and we're
left with the pmd lock on userspace side and the guest_table_lock on
the gmap side. Having two locks for an object is a guarantee for
locking problems.

Therefore the guest_table_lock will only be used for population of the
gmap tables and hence protecting the host_to_guest tree. While the pmd
lock will be used for all changes to the pmd from both userspace and
the gmap.

This means we need to retrieve the vmaddr to retrieve a gmap pmd,
which takes a bit longer than before. But we can now operate on
multiple pmds which are in disjoint segment tables instead of having a
global lock.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/include/asm/pgtable.h |  1 +
 arch/s390/mm/gmap.c             | 70 ++++++++++++++++++++-------------
 arch/s390/mm/pgtable.c          |  2 +-
 3 files changed, 45 insertions(+), 28 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 794746a32806..b1643afe1a00 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1519,6 +1519,7 @@ static __always_inline void __pudp_idte(unsigned long addr, pud_t *pudp,
 	}
 }
 
+pmd_t *pmd_alloc_map(struct mm_struct *mm, unsigned long addr);
 pmd_t pmdp_xchg_direct(struct mm_struct *, unsigned long, pmd_t *, pmd_t);
 pmd_t pmdp_xchg_lazy(struct mm_struct *, unsigned long, pmd_t *, pmd_t);
 pud_t pudp_xchg_direct(struct mm_struct *, unsigned long, pud_t *, pud_t);
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index f857104ca6c1..650c51749f4d 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -899,47 +899,62 @@ static void gmap_pte_op_end(spinlock_t *ptl)
 }
 
 /**
- * gmap_pmd_op_walk - walk the gmap tables, get the guest table lock
- *		      and return the pmd pointer
+ * gmap_pmd_op_walk - walk the gmap tables, get the pmd_lock if needed
+ *		      and return the pmd pointer or NULL
  * @gmap: pointer to guest mapping meta data structure
  * @gaddr: virtual address in the guest address space
  *
  * Returns a pointer to the pmd for a guest address, or NULL
  */
-static inline pmd_t *gmap_pmd_op_walk(struct gmap *gmap, unsigned long gaddr)
+static inline pmd_t *gmap_pmd_op_walk(struct gmap *gmap, unsigned long gaddr,
+				      spinlock_t **ptl)
 {
-	pmd_t *pmdp;
+	pmd_t *pmdp, *hpmdp;
+	unsigned long vmaddr;
+
 
 	BUG_ON(gmap_is_shadow(gmap));
-	pmdp = (pmd_t *) gmap_table_walk(gmap, gaddr, 1);
-	if (!pmdp)
-		return NULL;
 
-	/* without huge pages, there is no need to take the table lock */
-	if (!gmap->mm->context.allow_gmap_hpage_1m)
-		return pmd_none(*pmdp) ? NULL : pmdp;
-
-	spin_lock(&gmap->guest_table_lock);
-	if (pmd_none(*pmdp)) {
-		spin_unlock(&gmap->guest_table_lock);
-		return NULL;
+	*ptl = NULL;
+	if (gmap->mm->context.allow_gmap_hpage_1m) {
+		vmaddr = __gmap_translate(gmap, gaddr);
+		if (IS_ERR_VALUE(vmaddr))
+			return NULL;
+		hpmdp = pmd_alloc_map(gmap->mm, vmaddr);
+		if (!hpmdp)
+			return NULL;
+		*ptl = pmd_lock(gmap->mm, hpmdp);
+		if (pmd_none(*hpmdp)) {
+			spin_unlock(*ptl);
+			*ptl = NULL;
+			return NULL;
+		}
+		if (!pmd_large(*hpmdp)) {
+			spin_unlock(*ptl);
+			*ptl = NULL;
+		}
+	}
+
+	pmdp = (pmd_t *) gmap_table_walk(gmap, gaddr, 1);
+	if (!pmdp || pmd_none(*pmdp)) {
+		if (*ptl)
+			spin_unlock(*ptl);
+		pmdp = NULL;
+		*ptl = NULL;
 	}
 
-	/* 4k page table entries are locked via the pte (pte_alloc_map_lock). */
-	if (!pmd_large(*pmdp))
-		spin_unlock(&gmap->guest_table_lock);
 	return pmdp;
 }
 
 /**
- * gmap_pmd_op_end - release the guest_table_lock if needed
+ * gmap_pmd_op_end - release the pmd lock if needed
  * @gmap: pointer to the guest mapping meta data structure
  * @pmdp: pointer to the pmd
  */
-static inline void gmap_pmd_op_end(struct gmap *gmap, pmd_t *pmdp)
+static inline void gmap_pmd_op_end(spinlock_t *ptl)
 {
-	if (pmd_large(*pmdp))
-		spin_unlock(&gmap->guest_table_lock);
+	if (ptl)
+		spin_unlock(ptl);
 }
 
 /*
@@ -1041,13 +1056,14 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 			      unsigned long len, int prot, unsigned long bits)
 {
 	unsigned long vmaddr, dist;
+	spinlock_t *ptl = NULL;
 	pmd_t *pmdp;
 	int rc;
 
 	BUG_ON(gmap_is_shadow(gmap));
 	while (len) {
 		rc = -EAGAIN;
-		pmdp = gmap_pmd_op_walk(gmap, gaddr);
+		pmdp = gmap_pmd_op_walk(gmap, gaddr, &ptl);
 		if (pmdp) {
 			if (!pmd_large(*pmdp)) {
 				rc = gmap_protect_pte(gmap, gaddr, pmdp, prot,
@@ -1065,7 +1081,7 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 					gaddr = (gaddr & HPAGE_MASK) + HPAGE_SIZE;
 				}
 			}
-			gmap_pmd_op_end(gmap, pmdp);
+			gmap_pmd_op_end(ptl);
 		}
 		if (rc) {
 			if (rc == -EINVAL)
@@ -2462,9 +2478,9 @@ void gmap_sync_dirty_log_pmd(struct gmap *gmap, unsigned long bitmap[4],
 	int i;
 	pmd_t *pmdp;
 	pte_t *ptep;
-	spinlock_t *ptl;
+	spinlock_t *ptl = NULL;
 
-	pmdp = gmap_pmd_op_walk(gmap, gaddr);
+	pmdp = gmap_pmd_op_walk(gmap, gaddr, &ptl);
 	if (!pmdp)
 		return;
 
@@ -2481,7 +2497,7 @@ void gmap_sync_dirty_log_pmd(struct gmap *gmap, unsigned long bitmap[4],
 			spin_unlock(ptl);
 		}
 	}
-	gmap_pmd_op_end(gmap, pmdp);
+	gmap_pmd_op_end(ptl);
 }
 EXPORT_SYMBOL_GPL(gmap_sync_dirty_log_pmd);
 
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 5915f3b725bc..a0e674a9c70a 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -429,7 +429,7 @@ static inline pmd_t pmdp_flush_lazy(struct mm_struct *mm,
 }
 
 #ifdef CONFIG_PGSTE
-static pmd_t *pmd_alloc_map(struct mm_struct *mm, unsigned long addr)
+pmd_t *pmd_alloc_map(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
-- 
2.27.0
