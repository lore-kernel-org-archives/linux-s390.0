Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601FFEB64DB
	for <linux-s390@archiver.kernel.org>; Tue, 20 Jun 2023 07:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjFTHuL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 20 Jun 2023 03:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjFTHuK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 20 Jun 2023 03:50:10 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8413D198C
        for <linux-s390@vger.kernel.org>; Tue, 20 Jun 2023 00:49:41 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5703d12ab9aso47583207b3.2
        for <linux-s390@vger.kernel.org>; Tue, 20 Jun 2023 00:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687247379; x=1689839379;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JyT8tmsQKzrYxiMI/rVOY2yPaVbA/RNeIBfphNdBMF4=;
        b=Wlyhpqj5qzfuvutrjOa/4V6PuPsDCDOgWHtSW/4kwbuOkurc1q0KurhYLqHW1JVDng
         ocfjumMCL+5VTdlkv6JFAWzHFSaf/DQcTveKuW/F1nUw+Sj6E3jgL+8I+UQrrKTcSspC
         zGEBBcceErIi3jvfUdE8XIwgkG18lQEbl2V2HS4GGiBXkvY4t9/NkaOVpMEahcggUUzl
         u8oefzeOOrLLnM3RkTGo6WsoKQCjwWkScujGOaUdyRth+pzrlMusEw0XYP/BcTSABeYV
         rleoq5m+PuifcHOelghsbpsP6kubTOIzWI9OP98uqMngj6OJlbnVDdZn1qt2293RkTnb
         aaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687247379; x=1689839379;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JyT8tmsQKzrYxiMI/rVOY2yPaVbA/RNeIBfphNdBMF4=;
        b=DWT9drRuJ5DYk6P4nR3IfBwQULfFgI0xt78uMsrTr5BX1mpQ+EMmAyIP1pDBJgN7/p
         e0LRrJTkuI2x7UWVu6lWbpA3j9VHUaDJupVlwXgj7mrTmrlOzg7Wa2RaSCRVPLCEm8G1
         v+WgqObIoSYOmZsJP31lMx1fu+PBeUDRVeIyD8UFcUnCM3oLD+yOLjEGBhXmoXvLwLQO
         khnCI6EXitMgLkr/MpizHZ2BSaNs7owRCMOuIBP+WY29u7xj7Ms+1tVesoqejY/1dBw4
         NyQWmQ752y+KMYI/71DZ37B4tbR7xBm3lI+m48NsGMtEs3p8W/i4G7501dqKXF9N68d6
         DrIg==
X-Gm-Message-State: AC+VfDw24Tk0TTK06E+Mwb3IZui/bXyvhMAdwUaGw2wk0eEYtrfc6zP6
        /6LPxPa7zGxhgyyQkfbgO/8Y8w==
X-Google-Smtp-Source: ACHHUZ5+IOPW+qBQbjfJiBwfK7g3HrB1Jv9bM1vDxBV2sAeLMGBBrGsscHleOg916F+4k1/7bPeS5w==
X-Received: by 2002:a81:8311:0:b0:568:d63e:dd2c with SMTP id t17-20020a818311000000b00568d63edd2cmr10308263ywf.11.1687247379257;
        Tue, 20 Jun 2023 00:49:39 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o17-20020a0dcc11000000b005702597583fsm381836ywd.26.2023.06.20.00.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 00:49:38 -0700 (PDT)
Date:   Tue, 20 Jun 2023 00:49:34 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 06/12] sparc: add pte_free_defer() for pte_t *pgtable_t
In-Reply-To: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com>
Message-ID: <cb3feef8-f49e-7a54-a6d6-2e9b188f7564@google.com>
References: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Add sparc-specific pte_free_defer(), to call pte_free() via call_rcu().
pte_free_defer() will be called inside khugepaged's retract_page_tables()
loop, where allocating extra memory cannot be relied upon.  This precedes
the generic version to avoid build breakage from incompatible pgtable_t.

sparc32 supports pagetables sharing a page, but does not support THP;
sparc64 supports THP, but does not support pagetables sharing a page.
So the sparc-specific pte_free_defer() is as simple as the generic one,
except for converting between pte_t *pgtable_t and struct page *.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/sparc/include/asm/pgalloc_64.h |  4 ++++
 arch/sparc/mm/init_64.c             | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/sparc/include/asm/pgalloc_64.h b/arch/sparc/include/asm/pgalloc_64.h
index 7b5561d17ab1..caa7632be4c2 100644
--- a/arch/sparc/include/asm/pgalloc_64.h
+++ b/arch/sparc/include/asm/pgalloc_64.h
@@ -65,6 +65,10 @@ pgtable_t pte_alloc_one(struct mm_struct *mm);
 void pte_free_kernel(struct mm_struct *mm, pte_t *pte);
 void pte_free(struct mm_struct *mm, pgtable_t ptepage);
 
+/* arch use pte_free_defer() implementation in arch/sparc/mm/init_64.c */
+#define pte_free_defer pte_free_defer
+void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable);
+
 #define pmd_populate_kernel(MM, PMD, PTE)	pmd_set(MM, PMD, PTE)
 #define pmd_populate(MM, PMD, PTE)		pmd_set(MM, PMD, PTE)
 
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 04f9db0c3111..0d7fd793924c 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2930,6 +2930,22 @@ void pgtable_free(void *table, bool is_page)
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static void pte_free_now(struct rcu_head *head)
+{
+	struct page *page;
+
+	page = container_of(head, struct page, rcu_head);
+	__pte_free((pgtable_t)page_address(page));
+}
+
+void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
+{
+	struct page *page;
+
+	page = virt_to_page(pgtable);
+	call_rcu(&page->rcu_head, pte_free_now);
+}
+
 void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr,
 			  pmd_t *pmd)
 {
-- 
2.35.3

