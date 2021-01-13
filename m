Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51690 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727342AbhAMJmX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Jan 2021 04:42:23 -0500
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH 05/14] s390/mm: Split huge pages when migrating
Date: Wed, 13 Jan 2021 09:41:04 +0000
Message-Id: <20210113094113.133668-6-frankja@linux.ibm.com>
In-Reply-To: <20210113094113.133668-1-frankja@linux.ibm.com>
References: <20210113094113.133668-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, david@redhat.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com

Right now we mark the huge page that is being written to as dirty
although only a single byte may have changed. This means we have to
migrate 1MB although only a very limited amount of memory in that
range might be dirty.

To speed up migration this patch splits up write protected huge pages
into normal pages. The protection for the normal pages is only removed
for the page that caused the fault.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/mm/gmap.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 41a5bbbc59e6..d8c9b295294b 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -532,6 +532,9 @@ void gmap_unlink(struct mm_struct *mm, unsigned long *table,
 static void gmap_pmdp_xchg(struct gmap *gmap, pmd_t *old, pmd_t new,
 			   unsigned long gaddr);
 
+static void gmap_pmd_split(struct gmap *gmap, unsigned long gaddr,
+			   pmd_t *pmdp, struct page *page);
+
 /**
  * gmap_link - set up shadow page tables to connect a host to a guest address
  * @gmap: pointer to guest mapping meta data structure
@@ -547,12 +550,12 @@ int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
 {
 	struct mm_struct *mm;
 	unsigned long *table;
+	struct page *page = NULL;
 	spinlock_t *ptl;
 	pgd_t *pgd;
 	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
-	u64 unprot;
 	pte_t *ptep;
 	int rc;
 
@@ -600,6 +603,7 @@ int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
 	/* Are we allowed to use huge pages? */
 	if (pmd_large(*pmd) && !gmap->mm->context.allow_gmap_hpage_1m)
 		return -EFAULT;
+retry_split:
 	/* Link gmap segment table entry location to page table. */
 	rc = radix_tree_preload(GFP_KERNEL_ACCOUNT);
 	if (rc)
@@ -627,10 +631,25 @@ int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
 		spin_unlock(&gmap->guest_table_lock);
 	} else if (*table & _SEGMENT_ENTRY_PROTECT &&
 		   !(pmd_val(*pmd) & _SEGMENT_ENTRY_PROTECT)) {
-		unprot = (u64)*table;
-		unprot &= ~_SEGMENT_ENTRY_PROTECT;
-		unprot |= _SEGMENT_ENTRY_GMAP_UC;
-		gmap_pmdp_xchg(gmap, (pmd_t *)table, __pmd(unprot), gaddr);
+		if (page) {
+			gmap_pmd_split(gmap, gaddr, (pmd_t *)table, page);
+			page = NULL;
+		} else {
+			spin_unlock(ptl);
+			ptl = NULL;
+			radix_tree_preload_end();
+			page = page_table_alloc_pgste(mm);
+			if (!page)
+				rc = -ENOMEM;
+			else
+				goto retry_split;
+		}
+		/*
+		 * The split moves over the protection, so we still
+		 * need to unprotect.
+		 */
+		ptep = pte_offset_map((pmd_t *)table, vmaddr);
+		ptep_remove_protection_split(mm, ptep, vmaddr);
 	} else if (gmap_pmd_is_split((pmd_t *)table)) {
 		/*
 		 * Split pmds are somewhere in-between a normal and a
@@ -642,7 +661,10 @@ int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
 		if (pte_val(*ptep) & _PAGE_PROTECT)
 			ptep_remove_protection_split(mm, ptep, vmaddr);
 	}
-	spin_unlock(ptl);
+	if (page)
+		page_table_free_pgste(page);
+	if (ptl)
+		spin_unlock(ptl);
 	radix_tree_preload_end();
 	return rc;
 }
-- 
2.27.0
