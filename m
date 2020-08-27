Return-Path: <linux-arch-owner@vger.kernel.org>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v3 13/13] mm/debug_vm_pgtable: populate a pte entry before fetching it
Date: Thu, 27 Aug 2020 13:34:38 +0530
Message-Id: <20200827080438.315345-14-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
References: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-mm@kvack.org, akpm@linux-foundation.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, Anshuman Khandual <anshuman.khandual@arm.com>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org, x86@kernel.org, linux-arch@vger.kernel.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Vineet Gupta <vgupta@synopsys.com>, Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>

pte_clear_tests operate on an existing pte entry. Make sure that is not a none
pte entry.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 mm/debug_vm_pgtable.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 21329c7d672f..8527ebb75f2c 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -546,7 +546,7 @@ static void __init pgd_populate_tests(struct mm_struct *mm, pgd_t *pgdp,
 static void __init pte_clear_tests(struct mm_struct *mm, pte_t *ptep,
 				   unsigned long vaddr)
 {
-	pte_t pte = ptep_get(ptep);
+	pte_t pte =  ptep_get_and_clear(mm, vaddr, ptep);
 
 	pr_debug("Validating PTE clear\n");
 	pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
@@ -944,7 +944,7 @@ static int __init debug_vm_pgtable(void)
 	p4d_t *p4dp, *saved_p4dp;
 	pud_t *pudp, *saved_pudp;
 	pmd_t *pmdp, *saved_pmdp, pmd;
-	pte_t *ptep;
+	pte_t *ptep, pte;
 	pgtable_t saved_ptep;
 	pgprot_t prot, protnone;
 	phys_addr_t paddr;
@@ -1049,6 +1049,8 @@ static int __init debug_vm_pgtable(void)
 	 */
 
 	ptep = pte_alloc_map_lock(mm, pmdp, vaddr, &ptl);
+	pte = pfn_pte(pte_aligned, prot);
+	set_pte_at(mm, vaddr, ptep, pte);
 	pte_clear_tests(mm, ptep, vaddr);
 	pte_advanced_tests(mm, vma, ptep, pte_aligned, vaddr, prot);
 	pte_unmap_unlock(ptep, ptl);
-- 
2.26.2
