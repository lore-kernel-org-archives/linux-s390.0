Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43296 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727969AbgH0IG3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Aug 2020 04:06:29 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v3 12/13] mm/debug_vm_pgtable/hugetlb: Disable hugetlb test on ppc64
Date: Thu, 27 Aug 2020 13:34:37 +0530
Message-Id: <20200827080438.315345-13-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
References: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-mm@kvack.org, akpm@linux-foundation.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, Anshuman Khandual <anshuman.khandual@arm.com>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org, x86@kernel.org, linux-arch@vger.kernel.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Vineet Gupta <vgupta@synopsys.com>, Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>

The seems to be missing quite a lot of details w.r.t allocating
the correct pgtable_t page (huge_pte_alloc()), holding the right
lock (huge_pte_lock()) etc. The vma used is also not a hugetlb VMA.

ppc64 do have runtime checks within CONFIG_DEBUG_VM for most of these.
Hence disable the test on ppc64.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 mm/debug_vm_pgtable.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index a188b6e4e37e..21329c7d672f 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -813,6 +813,7 @@ static void __init hugetlb_basic_tests(unsigned long pfn, pgprot_t prot)
 #endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
 }
 
+#ifndef CONFIG_PPC_BOOK3S_64
 static void __init hugetlb_advanced_tests(struct mm_struct *mm,
 					  struct vm_area_struct *vma,
 					  pte_t *ptep, unsigned long pfn,
@@ -855,6 +856,7 @@ static void __init hugetlb_advanced_tests(struct mm_struct *mm,
 	pte = huge_ptep_get(ptep);
 	WARN_ON(!(huge_pte_write(pte) && huge_pte_dirty(pte)));
 }
+#endif
 #else  /* !CONFIG_HUGETLB_PAGE */
 static void __init hugetlb_basic_tests(unsigned long pfn, pgprot_t prot) { }
 static void __init hugetlb_advanced_tests(struct mm_struct *mm,
@@ -1065,7 +1067,9 @@ static int __init debug_vm_pgtable(void)
 	pud_populate_tests(mm, pudp, saved_pmdp);
 	spin_unlock(ptl);
 
+#ifndef CONFIG_PPC_BOOK3S_64
 	hugetlb_advanced_tests(mm, vma, ptep, pte_aligned, vaddr, prot);
+#endif
 
 	spin_lock(&mm->page_table_lock);
 	p4d_clear_tests(mm, p4dp);
-- 
2.26.2
