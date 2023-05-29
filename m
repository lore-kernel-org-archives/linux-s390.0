Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4DDC77B7A
	for <linux-s390@archiver.kernel.org>; Mon, 29 May 2023 06:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjE2GQv (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 29 May 2023 02:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjE2GQn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 29 May 2023 02:16:43 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E002FF
        for <linux-s390@vger.kernel.org>; Sun, 28 May 2023 23:16:22 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-ba8afcc82c0so5784316276.2
        for <linux-s390@vger.kernel.org>; Sun, 28 May 2023 23:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685340981; x=1687932981;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xPq2eB/hW7ShnFytnKcTY7aukisfg/jLLLPKQ4lP3rM=;
        b=TyhMHkB8EAAdy+hUHa48C2vLWt0oIXv3HPWA7oGBtoKurezV9dmnaHp/Ug08+YXBMJ
         q7/doDqEaB13J8DWMDOsmxCRPRcN6V2SXOTsYe+dqJjrxA7f0LVq1fNiXr9IMn2dnMMI
         ESckYbJKgJgrbJ8T+uYkbBEglbSci8JLRkQ5xTjOVaaAsg2STz0pP4v2Ide+0MWDvyHe
         y1hUI8uDpAzlLTOdYFAa9G5upyPvxazDxgjqrZ/FkHni8ZrS3oyiM+Gr8t/oORl7+XNi
         bEMYjRBzoNKzLiTXOPBKXj7pF37UgxQaCI1yMdVBb74YQf5DcZFdirdn0N62WO3feJu6
         qWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685340981; x=1687932981;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xPq2eB/hW7ShnFytnKcTY7aukisfg/jLLLPKQ4lP3rM=;
        b=awTCG/OH+YSmcY5U5GNm0oQtOtVCeGFjlxz2GT+d7euldccAklIcxUV9CJ/odYueMo
         TMV3PfVxVV5xPTQ2djlNNspSjcvYyE4XhndouFfU3aVn89QhG9w/axoTPwM4VJnFqCYG
         f67T8ggvCCUewGj0ZQm1xyYzhxFLK1BIb/pp54J/eokY4/KS1WNccgi0spgCVdwrPX7O
         vMEapdAdNJ6pyGYa35EnsQhUmICraYawxpVGcx/8YaJZO/nvDjKxWHKEQOXwC68skVJo
         GbUBjjnL4SufFkW7N+8MH6vtLzQYbvgJo0fl05anxn8CQU8DGOb1s3Ga2OGmU4paGbzZ
         gDmQ==
X-Gm-Message-State: AC+VfDxf8Hq6RcONoDvnfKVNsrPZEqvkrdr492PgKErdklKp61hgSAXA
        JXnHItdhqDneX1zv00L+9X5b6A==
X-Google-Smtp-Source: ACHHUZ5ZacpUNHnx35XFkkfr+0IABaEA7Bz0HX1XL9bgqfNu7gBbTpGfMWgF9E5JOg8lgzwGl1APAA==
X-Received: by 2002:a0d:f003:0:b0:565:a0c8:7e66 with SMTP id z3-20020a0df003000000b00565a0c87e66mr11630388ywe.0.1685340981021;
        Sun, 28 May 2023 23:16:21 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n5-20020a819c45000000b00545a081847fsm3407533ywa.15.2023.05.28.23.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 23:16:20 -0700 (PDT)
Date:   Sun, 28 May 2023 23:16:16 -0700 (PDT)
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
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 02/12] mm/pgtable: add PAE safety to __pte_offset_map()
In-Reply-To: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
Message-ID: <923480d5-35ab-7cac-79d0-343d16e29318@google.com>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

There is a faint risk that __pte_offset_map(), on a 32-bit architecture
with a 64-bit pmd_t e.g. x86-32 with CONFIG_X86_PAE=y, would succeed on
a pmdval assembled from a pmd_low and a pmd_high which never belonged
together: their combination not pointing to a page table at all, perhaps
not even a valid pfn.  pmdp_get_lockless() is not enough to prevent that.

Guard against that (on such configs) by local_irq_save() blocking TLB
flush between present updates, as linux/pgtable.h suggests.  It's only
needed around the pmdp_get_lockless() in __pte_offset_map(): a race when
__pte_offset_map_lock() repeats the pmdp_get_lockless() after getting the
lock, would just send it back to __pte_offset_map() again.

CONFIG_GUP_GET_PXX_LOW_HIGH is enabled when required by mips, sh and x86.
It is not enabled by arm-32 CONFIG_ARM_LPAE: my understanding is that
Will Deacon's 2020 enhancements to READ_ONCE() are sufficient for arm.
It is not enabled by arc, but its pmd_t is 32-bit even when pte_t 64-bit.

Limit the IRQ disablement to CONFIG_HIGHPTE?  Perhaps, but would need a
little more work, to retry if pmd_low good for page table, but pmd_high
non-zero from THP (and that might be making x86-specific assumptions).

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/pgtable-generic.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 674671835631..d28b63386cef 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -232,12 +232,32 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long address,
 #endif
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+#if defined(CONFIG_GUP_GET_PXX_LOW_HIGH) && \
+	(defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RCU))
+/*
+ * See the comment above ptep_get_lockless() in include/linux/pgtable.h:
+ * the barriers in pmdp_get_lockless() cannot guarantee that the value in
+ * pmd_high actually belongs with the value in pmd_low; but holding interrupts
+ * off blocks the TLB flush between present updates, which guarantees that a
+ * successful __pte_offset_map() points to a page from matched halves.
+ */
+#define config_might_irq_save(flags)	local_irq_save(flags)
+#define config_might_irq_restore(flags)	local_irq_restore(flags)
+#else
+#define config_might_irq_save(flags)
+#define config_might_irq_restore(flags)
+#endif
+
 pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
 {
+	unsigned long __maybe_unused flags;
 	pmd_t pmdval;
 
 	rcu_read_lock();
+	config_might_irq_save(flags);
 	pmdval = pmdp_get_lockless(pmd);
+	config_might_irq_restore(flags);
+
 	if (pmdvalp)
 		*pmdvalp = pmdval;
 	if (unlikely(pmd_none(pmdval) || is_pmd_migration_entry(pmdval)))
-- 
2.35.3

