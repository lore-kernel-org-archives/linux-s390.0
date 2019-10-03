Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44823 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732887AbfJCVgy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Oct 2019 17:36:54 -0400
Received: by mail-qt1-f195.google.com with SMTP id u40so5726515qth.11
        for <linux-s390@vger.kernel.org>; Thu, 03 Oct 2019 14:36:54 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
Subject: [PATCH] s390/mm: fix -Wunused-but-set-variable warnings
Date: Thu,  3 Oct 2019 17:36:36 -0400
Message-Id: <1570138596-11913-1-git-send-email-cai@lca.pw>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>

Convert two functions to static inline to get ride of W=1 GCC warnings
like,

mm/gup.c: In function 'gup_pte_range':
mm/gup.c:1816:16: warning: variable 'ptem' set but not used
[-Wunused-but-set-variable]
  pte_t *ptep, *ptem;
                ^~~~

mm/mmap.c: In function 'acct_stack_growth':
mm/mmap.c:2322:16: warning: variable 'new_start' set but not used
[-Wunused-but-set-variable]
  unsigned long new_start;
                ^~~~~~~~~

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/s390/include/asm/hugetlb.h | 9 +++++++--
 arch/s390/include/asm/pgtable.h | 3 ++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
index bb59dd964590..de8f0bf5f238 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -12,8 +12,6 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 
-
-#define is_hugepage_only_range(mm, addr, len)	0
 #define hugetlb_free_pgd_range			free_pgd_range
 #define hugepages_supported()			(MACHINE_HAS_EDAT1)
 
@@ -23,6 +21,13 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 			      unsigned long addr, pte_t *ptep);
 
+static inline bool is_hugepage_only_range(struct mm_struct *mm,
+					  unsigned long addr,
+					  unsigned long len)
+{
+	return false;
+}
+
 /*
  * If the arch doesn't supply something else, assume that hugepage
  * size aligned regions are ok without further preparation.
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 36c578c0ff96..19c2cf001df3 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1269,7 +1269,8 @@ static inline pte_t *pte_offset(pmd_t *pmd, unsigned long address)
 
 #define pte_offset_kernel(pmd, address) pte_offset(pmd, address)
 #define pte_offset_map(pmd, address) pte_offset_kernel(pmd, address)
-#define pte_unmap(pte) do { } while (0)
+
+static inline void pte_unmap(pte_t *pte) { }
 
 static inline bool gup_fast_permitted(unsigned long start, unsigned long end)
 {
-- 
1.8.3.1
