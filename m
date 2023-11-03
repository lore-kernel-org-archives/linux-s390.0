Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C27C0018A
	for <linux-s390@archiver.kernel.org>; Fri,  3 Nov 2023 14:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377764AbjKCODv (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 3 Nov 2023 10:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbjKCODt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Nov 2023 10:03:49 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22DDD4E;
        Fri,  3 Nov 2023 07:03:46 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SMMmn4xy3zMmLd;
        Fri,  3 Nov 2023 21:59:21 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 3 Nov 2023 22:03:44 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        <linux-s390@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 04/18] mm: rmap: use mm_counter_[file]_folio()
Date:   Fri, 3 Nov 2023 22:01:05 +0800
Message-ID: <20231103140119.2306578-5-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231103140119.2306578-1-wangkefeng.wang@huawei.com>
References: <20231103140119.2306578-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Use mm_counter_folio() and mm_counter_file_folio() to save five
compound_head() calls.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/rmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 7a27a2b41802..9d77975eaa35 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1678,7 +1678,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				set_huge_pte_at(mm, address, pvmw.pte, pteval,
 						hsz);
 			} else {
-				dec_mm_counter(mm, mm_counter(&folio->page));
+				dec_mm_counter(mm, mm_counter_folio(folio));
 				set_pte_at(mm, address, pvmw.pte, pteval);
 			}
 
@@ -1693,7 +1693,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 * migration) will not expect userfaults on already
 			 * copied pages.
 			 */
-			dec_mm_counter(mm, mm_counter(&folio->page));
+			dec_mm_counter(mm, mm_counter_folio(folio));
 		} else if (folio_test_anon(folio)) {
 			swp_entry_t entry = page_swap_entry(subpage);
 			pte_t swp_pte;
@@ -1801,7 +1801,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 *
 			 * See Documentation/mm/mmu_notifier.rst
 			 */
-			dec_mm_counter(mm, mm_counter_file(&folio->page));
+			dec_mm_counter(mm, mm_counter_file_folio(folio));
 		}
 discard:
 		page_remove_rmap(subpage, vma, folio_test_hugetlb(folio));
@@ -2075,7 +2075,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 				set_huge_pte_at(mm, address, pvmw.pte, pteval,
 						hsz);
 			} else {
-				dec_mm_counter(mm, mm_counter(&folio->page));
+				dec_mm_counter(mm, mm_counter_folio(folio));
 				set_pte_at(mm, address, pvmw.pte, pteval);
 			}
 
@@ -2090,7 +2090,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			 * migration) will not expect userfaults on already
 			 * copied pages.
 			 */
-			dec_mm_counter(mm, mm_counter(&folio->page));
+			dec_mm_counter(mm, mm_counter_folio(folio));
 		} else {
 			swp_entry_t entry;
 			pte_t swp_pte;
-- 
2.27.0

