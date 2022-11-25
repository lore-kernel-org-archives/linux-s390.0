Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1A7C433FE
	for <linux-s390@archiver.kernel.org>; Fri, 25 Nov 2022 03:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiKYDpQ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 24 Nov 2022 22:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKYDpQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 24 Nov 2022 22:45:16 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98C471F628;
        Thu, 24 Nov 2022 19:45:15 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8ED0C23A;
        Thu, 24 Nov 2022 19:45:21 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.44.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A131B3F73D;
        Thu, 24 Nov 2022 19:45:11 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390/mm: Use pmd_pgtable_page() helper in __gmap_segment_gaddr()
Date:   Fri, 25 Nov 2022 09:15:02 +0530
Message-Id: <20221125034502.1559986-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

In __gmap_segment_gaddr() pmd level page table page is being extracted from
the pmd pointer, similar to pmd_pgtable_page() implementation. This reduces
some redundancy by directly using pmd_pgtable_page() instead,  though first
making it available.

Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.1-rc6 but after the following patch. Build tested for
s390 plaform (defconfig).

https://lore.kernel.org/all/20221124131641.1523772-1-anshuman.khandual@arm.com/

 arch/s390/mm/gmap.c | 5 ++---
 include/linux/mm.h  | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 02d15c8dc92e..8947451ae021 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -336,12 +336,11 @@ static int gmap_alloc_table(struct gmap *gmap, unsigned long *table,
 static unsigned long __gmap_segment_gaddr(unsigned long *entry)
 {
 	struct page *page;
-	unsigned long offset, mask;
+	unsigned long offset;
 
 	offset = (unsigned long) entry / sizeof(unsigned long);
 	offset = (offset & (PTRS_PER_PMD - 1)) * PMD_SIZE;
-	mask = ~(PTRS_PER_PMD * sizeof(pmd_t) - 1);
-	page = virt_to_page((void *)((unsigned long) entry & mask));
+	page = pmd_pgtable_page((pmd_t *) entry);
 	return page->index + offset;
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index e9e387caffac..5ead9e997510 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2403,7 +2403,7 @@ static inline void pgtable_pte_page_dtor(struct page *page)
 
 #if USE_SPLIT_PMD_PTLOCKS
 
-static struct page *pmd_pgtable_page(pmd_t *pmd)
+static inline struct page *pmd_pgtable_page(pmd_t *pmd)
 {
 	unsigned long mask = ~(PTRS_PER_PMD * sizeof(pmd_t) - 1);
 	return virt_to_page((void *)((unsigned long) pmd & mask));
-- 
2.25.1

