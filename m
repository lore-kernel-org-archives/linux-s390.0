Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31374 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731684AbgGVJqc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 22 Jul 2020 05:46:32 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 8/9] s390/vmemmap: remember unused sub-pmd ranges
Date: Wed, 22 Jul 2020 11:45:57 +0200
Message-Id: <20200722094558.9828-9-david@redhat.com>
In-Reply-To: <20200722094558.9828-1-david@redhat.com>
References: <20200722094558.9828-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org, David Hildenbrand <david@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>

With a memmap size of 56 bytes or 72 bytes per page, the memmap for a
256 MB section won't span full PMDs. As we populate single sections and
depopulate single sections, the depopulation step would not be able to
free all vmemmap pmds anymore.

Do it similarly to x86, marking the unused memmap ranges in a special way
(pad it with 0xFD).

This allows us to add/remove sections, cleaning up all allocated
vmemmap pages even if the memmap size is not multiple of 16 bytes per page.

A 56 byte memmap can, for example, be created with !CONFIG_MEMCG and
!CONFIG_SLUB.

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/vmem.c | 51 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index e82a63de19db2..df361bbacda1b 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -72,6 +72,42 @@ static void vmem_pte_free(unsigned long *table)
 	page_table_free(&init_mm, table);
 }
 
+#define PAGE_UNUSED 0xFD
+
+static void vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
+{
+	/*
+	 * As we expect to add in the same granularity as we remove, it's
+	 * sufficient to mark only some piece used to block the memmap page from
+	 * getting removed (just in case the memmap never gets initialized,
+	 * e.g., because the memory block never gets onlined).
+	 */
+	memset(__va(start), 0, sizeof(struct page));
+}
+
+static void vmemmap_use_new_sub_pmd(unsigned long start, unsigned long end)
+{
+	void *page = __va(ALIGN_DOWN(start, PMD_SIZE));
+
+	/* Could be our memmap page is filled with PAGE_UNUSED already ... */
+	vmemmap_use_sub_pmd(start, end);
+
+	/* Mark the unused parts of the new memmap page PAGE_UNUSED. */
+	if (!IS_ALIGNED(start, PMD_SIZE))
+		memset(page, PAGE_UNUSED, start - __pa(page));
+	if (!IS_ALIGNED(end, PMD_SIZE))
+		memset(__va(end), PAGE_UNUSED, __pa(page) + PMD_SIZE - end);
+}
+
+/* Returns true if the PMD is completely unused and can be freed. */
+static bool vmemmap_unuse_sub_pmd(unsigned long start, unsigned long end)
+{
+	void *page = __va(ALIGN_DOWN(start, PMD_SIZE));
+
+	memset(__va(start), PAGE_UNUSED, end - start);
+	return !memchr_inv(page, PAGE_UNUSED, PMD_SIZE);
+}
+
 /* __ref: we'll only call vmemmap_alloc_block() via vmemmap_populate() */
 static int __ref modify_pte_table(pmd_t *pmd, unsigned long addr,
 				  unsigned long end, bool add, bool direct)
@@ -157,6 +193,11 @@ static int __ref modify_pmd_table(pud_t *pud, unsigned long addr,
 								get_order(PMD_SIZE));
 					pmd_clear(pmd);
 					pages++;
+				} else if (!direct &&
+					   vmemmap_unuse_sub_pmd(addr, next)) {
+					vmem_free_pages(pmd_deref(*pmd),
+							get_order(PMD_SIZE));
+					pmd_clear(pmd);
 				}
 				continue;
 			}
@@ -182,6 +223,11 @@ static int __ref modify_pmd_table(pud_t *pud, unsigned long addr,
 							       NUMA_NO_NODE);
 				if (new_page) {
 					pmd_val(*pmd) = __pa(new_page) | prot;
+					if (!IS_ALIGNED(addr, PMD_SIZE) ||
+					    !IS_ALIGNED(next, PMD_SIZE)) {
+						vmemmap_use_new_sub_pmd(addr,
+									next);
+					}
 					continue;
 				}
 			}
@@ -189,8 +235,11 @@ static int __ref modify_pmd_table(pud_t *pud, unsigned long addr,
 			if (!pte)
 				goto out;
 			pmd_populate(&init_mm, pmd, pte);
-		} else if (pmd_large(*pmd))
+		} else if (pmd_large(*pmd)) {
+			if (!direct)
+				vmemmap_use_sub_pmd(addr, next);
 			continue;
+		}
 
 		ret = modify_pte_table(pmd, addr, next, add, direct);
 		if (ret)
-- 
2.26.2
