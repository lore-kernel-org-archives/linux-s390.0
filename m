Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45970 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727991AbgKJJgc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Nov 2020 04:36:32 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AA9WvdO046244
        for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2020 04:36:32 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34qksy7q8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2020 04:36:31 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AA9X37G046669
        for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2020 04:36:31 -0500
From: Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 3/3] s390/vmem: make variable and function names consistent
Date: Tue, 10 Nov 2020 10:36:23 +0100
Message-Id: <f9e09fe0e9c6b7d5ebc5c45c73b917a4ff39a24b.1605000280.git.agordeev@linux.ibm.com>
In-Reply-To: <cover.1605000280.git.agordeev@linux.ibm.com>
References: <cover.1605000280.git.agordeev@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>

Rename some variable and functions to better clarify
what they are and what they do.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/mm/vmem.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index d7f25884061f4..4bb198db6aa01 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -76,20 +76,20 @@ static void vmem_pte_free(unsigned long *table)
 
 /*
  * The unused vmemmap range, which was not yet memset(PAGE_UNUSED) ranges
- * from unused_pmd_start to next PMD_SIZE boundary.
+ * from unused_sub_pmd_start to next PMD_SIZE boundary.
  */
-static unsigned long unused_pmd_start;
+static unsigned long unused_sub_pmd_start;
 
-static void vmemmap_flush_unused_pmd(void)
+static void vmemmap_flush_unused_sub_pmd(void)
 {
-	if (!unused_pmd_start)
+	if (!unused_sub_pmd_start)
 		return;
-	memset(__va(unused_pmd_start), PAGE_UNUSED,
-	       ALIGN(unused_pmd_start, PMD_SIZE) - unused_pmd_start);
-	unused_pmd_start = 0;
+	memset(__va(unused_sub_pmd_start), PAGE_UNUSED,
+	       ALIGN(unused_sub_pmd_start, PMD_SIZE) - unused_sub_pmd_start);
+	unused_sub_pmd_start = 0;
 }
 
-static void __vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
+static void vmemmap_mark_sub_pmd_used(unsigned long start, unsigned long end)
 {
 	unsigned long size = min(end - start, sizeof(struct page));
 
@@ -108,24 +108,24 @@ static void vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
 	 * We only optimize if the new used range directly follows the
 	 * previously unused range (esp., when populating consecutive sections).
 	 */
-	if (unused_pmd_start == start) {
-		unused_pmd_start = end;
-		if (likely(IS_ALIGNED(unused_pmd_start, PMD_SIZE)))
-			unused_pmd_start = 0;
+	if (unused_sub_pmd_start == start) {
+		unused_sub_pmd_start = end;
+		if (likely(IS_ALIGNED(unused_sub_pmd_start, PMD_SIZE)))
+			unused_sub_pmd_start = 0;
 		return;
 	}
-	vmemmap_flush_unused_pmd();
-	__vmemmap_use_sub_pmd(start, end);
+	vmemmap_flush_unused_sub_pmd();
+	vmemmap_mark_sub_pmd_used(start, end);
 }
 
 static void vmemmap_use_new_sub_pmd(unsigned long start, unsigned long end)
 {
 	void *page = __va(ALIGN_DOWN(start, PMD_SIZE));
 
-	vmemmap_flush_unused_pmd();
+	vmemmap_flush_unused_sub_pmd();
 
 	/* Could be our memmap page is filled with PAGE_UNUSED already ... */
-	__vmemmap_use_sub_pmd(start, end);
+	vmemmap_mark_sub_pmd_used(start, end);
 
 	/* Mark the unused parts of the new memmap page PAGE_UNUSED. */
 	if (!IS_ALIGNED(start, PMD_SIZE))
@@ -136,7 +136,7 @@ static void vmemmap_use_new_sub_pmd(unsigned long start, unsigned long end)
 	 * unused range in the populated PMD.
 	 */
 	if (!IS_ALIGNED(end, PMD_SIZE))
-		unused_pmd_start = end;
+		unused_sub_pmd_start = end;
 }
 
 /* Returns true if the PMD is completely unused and can be freed. */
@@ -144,7 +144,7 @@ static bool vmemmap_unuse_sub_pmd(unsigned long start, unsigned long end)
 {
 	void *page = __va(ALIGN_DOWN(start, PMD_SIZE));
 
-	vmemmap_flush_unused_pmd();
+	vmemmap_flush_unused_sub_pmd();
 	memset(__va(start), PAGE_UNUSED, end - start);
 	return !memchr_inv(page, PAGE_UNUSED, PMD_SIZE);
 }
-- 
2.26.0
