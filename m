Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11380 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727345AbhAMJmW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Jan 2021 04:42:22 -0500
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH 01/14] s390/mm: Code cleanups
Date: Wed, 13 Jan 2021 09:41:00 +0000
Message-Id: <20210113094113.133668-2-frankja@linux.ibm.com>
In-Reply-To: <20210113094113.133668-1-frankja@linux.ibm.com>
References: <20210113094113.133668-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, david@redhat.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com

Let's clean up leftovers before introducing new code.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/mm/gmap.c    | 8 ++++----
 arch/s390/mm/pgtable.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 9bb2c7512cd5..f857104ca6c1 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -5,7 +5,7 @@
  *    Copyright IBM Corp. 2007, 2020
  *    Author(s): Martin Schwidefsky <schwidefsky@de.ibm.com>
  *		 David Hildenbrand <david@redhat.com>
- *		 Janosch Frank <frankja@linux.vnet.ibm.com>
+ *		 Janosch Frank <frankja@linux.ibm.com>
  */
 
 #include <linux/kernel.h>
@@ -2290,10 +2290,10 @@ static void gmap_pmdp_xchg(struct gmap *gmap, pmd_t *pmdp, pmd_t new,
 	pmdp_notify_gmap(gmap, pmdp, gaddr);
 	pmd_val(new) &= ~_SEGMENT_ENTRY_GMAP_IN;
 	if (MACHINE_HAS_TLB_GUEST)
-		__pmdp_idte(gaddr, (pmd_t *)pmdp, IDTE_GUEST_ASCE, gmap->asce,
+		__pmdp_idte(gaddr, pmdp, IDTE_GUEST_ASCE, gmap->asce,
 			    IDTE_GLOBAL);
 	else if (MACHINE_HAS_IDTE)
-		__pmdp_idte(gaddr, (pmd_t *)pmdp, 0, 0, IDTE_GLOBAL);
+		__pmdp_idte(gaddr, pmdp, 0, 0, IDTE_GLOBAL);
 	else
 		__pmdp_csp(pmdp);
 	*pmdp = new;
@@ -2523,7 +2523,7 @@ static inline void thp_split_mm(struct mm_struct *mm)
  * - This must be called after THP was enabled
  */
 static int __zap_zero_pages(pmd_t *pmd, unsigned long start,
-			   unsigned long end, struct mm_walk *walk)
+			    unsigned long end, struct mm_walk *walk)
 {
 	unsigned long addr;
 
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 18205f851c24..5915f3b725bc 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -743,7 +743,7 @@ void ptep_zap_key(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
  * Test and reset if a guest page is dirty
  */
 bool ptep_test_and_clear_uc(struct mm_struct *mm, unsigned long addr,
-		       pte_t *ptep)
+			    pte_t *ptep)
 {
 	pgste_t pgste;
 	pte_t pte;
-- 
2.27.0
