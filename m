Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727823AbgH0IFn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Aug 2020 04:05:43 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v3 05/13] mm/debug_vm_pgtable/savedwrite: Enable savedwrite test with CONFIG_NUMA_BALANCING
Date: Thu, 27 Aug 2020 13:34:30 +0530
Message-Id: <20200827080438.315345-6-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
References: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-mm@kvack.org, akpm@linux-foundation.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, Anshuman Khandual <anshuman.khandual@arm.com>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org, x86@kernel.org, linux-arch@vger.kernel.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Vineet Gupta <vgupta@synopsys.com>, Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>

Saved write support was added to track the write bit of a pte after marking the
pte protnone. This was done so that AUTONUMA can convert a write pte to protnone
and still track the old write bit. When converting it back we set the pte write
bit correctly thereby avoiding a write fault again. Hence enable the test only
when CONFIG_NUMA_BALANCING is enabled and use protnone protflags.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 mm/debug_vm_pgtable.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 28f9d0558c20..5c0680836fe9 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -119,10 +119,14 @@ static void __init pte_savedwrite_tests(unsigned long pfn, pgprot_t prot)
 {
 	pte_t pte = pfn_pte(pfn, prot);
 
+	if (!IS_ENABLED(CONFIG_NUMA_BALANCING))
+		return;
+
 	pr_debug("Validating PTE saved write\n");
 	WARN_ON(!pte_savedwrite(pte_mk_savedwrite(pte_clear_savedwrite(pte))));
 	WARN_ON(pte_savedwrite(pte_clear_savedwrite(pte_mk_savedwrite(pte))));
 }
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static void __init pmd_basic_tests(unsigned long pfn, pgprot_t prot)
 {
@@ -235,6 +239,9 @@ static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot)
 {
 	pmd_t pmd = pfn_pmd(pfn, prot);
 
+	if (!IS_ENABLED(CONFIG_NUMA_BALANCING))
+		return;
+
 	pr_debug("Validating PMD saved write\n");
 	WARN_ON(!pmd_savedwrite(pmd_mk_savedwrite(pmd_clear_savedwrite(pmd))));
 	WARN_ON(pmd_savedwrite(pmd_clear_savedwrite(pmd_mk_savedwrite(pmd))));
@@ -1020,8 +1027,8 @@ static int __init debug_vm_pgtable(void)
 	pmd_huge_tests(pmdp, pmd_aligned, prot);
 	pud_huge_tests(pudp, pud_aligned, prot);
 
-	pte_savedwrite_tests(pte_aligned, prot);
-	pmd_savedwrite_tests(pmd_aligned, prot);
+	pte_savedwrite_tests(pte_aligned, protnone);
+	pmd_savedwrite_tests(pmd_aligned, protnone);
 
 	pte_unmap_unlock(ptep, ptl);
 
-- 
2.26.2
