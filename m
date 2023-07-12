Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D9BEB64DD
	for <linux-s390@archiver.kernel.org>; Wed, 12 Jul 2023 04:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjGLEhd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 12 Jul 2023 00:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjGLEhc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 12 Jul 2023 00:37:32 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8429FE4F
        for <linux-s390@vger.kernel.org>; Tue, 11 Jul 2023 21:37:30 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-bd77424c886so7608077276.0
        for <linux-s390@vger.kernel.org>; Tue, 11 Jul 2023 21:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689136649; x=1691728649;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JyT8tmsQKzrYxiMI/rVOY2yPaVbA/RNeIBfphNdBMF4=;
        b=w4BLpHymsh+u1p3yABD7PPkGOKG9qb0kMjMuVvRnYQ5i8Gg0vx7GaXUKU8Z11taA0f
         Y4235M6bgawLW3yo0EcdaghjRbkYWx3VYEN5rlBhdKXgQyAR0H6Df5aIv3U42+ge0H0F
         7Am9Buup/0Dpi4X9uzRYEGHLpGhKSvbsAL94r8S6LMijx5+VZ1cBcWPoxL+3vjMaeqvp
         Syw06LlLqDuKwM2KmcAX8wLO81GL1X+wMS5GoRcNmiGU7mUrXq/vTwqL7+C0j6oQTqbM
         DMVJzOclqYpiwu/+ACLlh1W9ZEU8tNf6sf9FmXwoF/hxcf+swcDTLMrmftfNrY6dfBOv
         P5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689136650; x=1691728650;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JyT8tmsQKzrYxiMI/rVOY2yPaVbA/RNeIBfphNdBMF4=;
        b=g3d4zKpY4X68PRNZggXX/YaUc9bqMLGlgVWwUVszQ2sAyAZl2eLoeeiPIsRC9oWcDA
         cAH2sMKiRbOPA9ddJoqfOQZTCXXmTuK8hijGTh0nOMw/TZWxsjZHXsgvRq/b5tIrzTtm
         R6z53+n8VxJqsDhrHT/G1QHG7UNo0crgtAG30LKJARwKLC7qjG9p7/MIG39C9TKXsnYc
         Tr7SkMJ31XDZfymBXO6XciV6+a5DJFM30cRxWhEP0Y15e+VtE7V+74IdlmGCF5dDvqGf
         RTgcLKtbCPQGf/fMoVwLAEOpvjB4MjLDWTwrHofxU7XjnOY8bn183ql0xLv7KY1rir/W
         bgqA==
X-Gm-Message-State: ABy/qLYAimE5DsCFrHsHhAbMCgMrA1OauK4t55Jce7SfvaHWuPSqeJKK
        mOdoFAktMkTIcHsTQCKRHm1Rmw==
X-Google-Smtp-Source: APBJJlFmxJSV0QKRdoqMkfxLV2wHU7j1RLUd/OKPTI5wJFFgGlsPMBZVm2ZQMAKmswTDjAPHLTyqAQ==
X-Received: by 2002:a0d:d841:0:b0:577:189b:ad4 with SMTP id a62-20020a0dd841000000b00577189b0ad4mr18260881ywe.48.1689136649589;
        Tue, 11 Jul 2023 21:37:29 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c124-20020a0dc182000000b0057a05834754sm975992ywd.75.2023.07.11.21.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 21:37:29 -0700 (PDT)
Date:   Tue, 11 Jul 2023 21:37:24 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Mike Kravetz <mike.kravetz@oracle.com>,
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
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3 06/13] sparc: add pte_free_defer() for pte_t *pgtable_t
In-Reply-To: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com>
Message-ID: <dc4f318d-a66a-5622-dc44-9018ea814b37@google.com>
References: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com>
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

