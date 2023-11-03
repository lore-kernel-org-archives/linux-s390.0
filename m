Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D94C4332F
	for <linux-s390@archiver.kernel.org>; Fri,  3 Nov 2023 14:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjKCOoy (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 3 Nov 2023 10:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377812AbjKCODz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Nov 2023 10:03:55 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45563D60;
        Fri,  3 Nov 2023 07:03:51 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SMMpP5yQNz1P7pR;
        Fri,  3 Nov 2023 22:00:45 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 3 Nov 2023 22:03:46 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        <linux-s390@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 09/18] mm: memory: use a folio in do_set_pmd()
Date:   Fri, 3 Nov 2023 22:01:10 +0800
Message-ID: <20231103140119.2306578-10-wangkefeng.wang@huawei.com>
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

Use a folio in do_set_pmd(), which save one compound_head() call.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/memory.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 1f18ed4a5497..09009094a5f2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4313,12 +4313,13 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
 	pmd_t entry;
 	vm_fault_t ret = VM_FAULT_FALLBACK;
+	struct folio *folio;
 
 	if (!transhuge_vma_suitable(vma, haddr))
 		return ret;
 
-	page = compound_head(page);
-	if (compound_order(page) != HPAGE_PMD_ORDER)
+	folio = page_folio(page);
+	if (folio_order(folio) != HPAGE_PMD_ORDER)
 		return ret;
 
 	/*
@@ -4350,7 +4351,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 	if (write)
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 
-	add_mm_counter(vma->vm_mm, mm_counter_file(page), HPAGE_PMD_NR);
+	add_mm_counter(vma->vm_mm, mm_counter_file_folio(folio), HPAGE_PMD_NR);
 	page_add_file_rmap(page, vma, true);
 
 	/*
-- 
2.27.0

