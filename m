Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B79EB64DB
	for <linux-s390@archiver.kernel.org>; Tue, 20 Jun 2023 07:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjFTHs5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 20 Jun 2023 03:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjFTHsm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 20 Jun 2023 03:48:42 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1DF133
        for <linux-s390@vger.kernel.org>; Tue, 20 Jun 2023 00:48:01 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-570284c7e61so49567417b3.1
        for <linux-s390@vger.kernel.org>; Tue, 20 Jun 2023 00:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687247279; x=1689839279;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VQ3G/mOw1YDakj6K/QDY3ISJ4AmLryMvPDR0lMuqBuw=;
        b=FTDl5iE634tOzkrqSCVEu9Nf5D7hLqctOZFWgKMkQ3RqUmNsUi/5jC5UBELVK+62a/
         tppQbX64R9NP8cj1gGJ6SvM5CU9vfUE39QVPjAKeWzgQ/S5s5xCa2DCQNDmPIUw76uDU
         docHziNctEA/rKYRNqAAe9o2ycs/Al7k/GvMXYgsm/K5xYfYahKx2SHDAiqufCA//I5i
         fpqnLbMwekkTgKZJTegbsUNCWCDlJKVeWVzpAxM2KcHVartgtsYK5L6lD7NGrGn8gZ8V
         H4EcXMPG6hTq4PUDvh8MLdynIDaaJQky/EdiXCX827BTAn0GvFQ+WeIvsKvPBLKBi8Cj
         Dm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687247279; x=1689839279;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQ3G/mOw1YDakj6K/QDY3ISJ4AmLryMvPDR0lMuqBuw=;
        b=bNYECUQuv08WCPx9TbqnFTvaBqf64w239/6FYRKlJLZyKFcMpTQnVuWquLvySfGDvQ
         LSEeff6h6bs7TBdZhhZg0znxbZU+FSzB4tiGpufFdQNQJDQjVe/7qetV0WHSgtNpZIs/
         QG9uorUFG/R8oD+rmiujSHHShxhVhMjC+wGEdwIQxrcM37uA6oH2TT8lpd6vUroK1TMT
         qnrYyCRKn1BKAW6He2DuFy0AvrklBVmyNIRqia8LZ7knQjCGoY90aEgwFYckEwSXYXyZ
         oZ98hkAW2e28GmqkP5SY3ltcIy809qLdO+f4+chKwto0YDXXVi+CDJ5D9kd4m/fp21r2
         IvWQ==
X-Gm-Message-State: AC+VfDzL9U0QpG2LUJnyHjNy63c3JgxhG230ypssN2qDs3PlQwe6VPBg
        7xAGWWV/JZ8wNYfy+QgOVQ8uOA==
X-Google-Smtp-Source: ACHHUZ4S0WdBV687zylMKJcs5BTJOEB/HsGWCswlmI7GBgVKK08qTW3e1TZ6XRwEWVZtJ7HVB5KlNQ==
X-Received: by 2002:a0d:e64d:0:b0:569:74f3:f3e1 with SMTP id p74-20020a0de64d000000b0056974f3f3e1mr11385428ywe.0.1687247279055;
        Tue, 20 Jun 2023 00:47:59 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j127-20020a0df985000000b005612fc707bfsm364068ywf.120.2023.06.20.00.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 00:47:58 -0700 (PDT)
Date:   Tue, 20 Jun 2023 00:47:54 -0700 (PDT)
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
        "David Sc. Miller" <davem@davemloft.net>,
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
Subject: [PATCH v2 05/12] powerpc: add pte_free_defer() for pgtables sharing
 page
In-Reply-To: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com>
Message-ID: <5cd9f442-61da-4c3d-eca-b7f44d22aa5f@google.com>
References: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Add powerpc-specific pte_free_defer(), to call pte_free() via call_rcu().
pte_free_defer() will be called inside khugepaged's retract_page_tables()
loop, where allocating extra memory cannot be relied upon.  This precedes
the generic version to avoid build breakage from incompatible pgtable_t.

This is awkward because the struct page contains only one rcu_head, but
that page may be shared between PTE_FRAG_NR pagetables, each wanting to
use the rcu_head at the same time: account concurrent deferrals with a
heightened refcount, only the first making use of the rcu_head, but
re-deferring if more deferrals arrived during its grace period.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/powerpc/include/asm/pgalloc.h |  4 +++
 arch/powerpc/mm/pgtable-frag.c     | 51 ++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/arch/powerpc/include/asm/pgalloc.h b/arch/powerpc/include/asm/pgalloc.h
index 3360cad78ace..3a971e2a8c73 100644
--- a/arch/powerpc/include/asm/pgalloc.h
+++ b/arch/powerpc/include/asm/pgalloc.h
@@ -45,6 +45,10 @@ static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
 	pte_fragment_free((unsigned long *)ptepage, 0);
 }
 
+/* arch use pte_free_defer() implementation in arch/powerpc/mm/pgtable-frag.c */
+#define pte_free_defer pte_free_defer
+void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable);
+
 /*
  * Functions that deal with pagetables that could be at any level of
  * the table need to be passed an "index_size" so they know how to
diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
index 20652daa1d7e..e4f58c5fc2ac 100644
--- a/arch/powerpc/mm/pgtable-frag.c
+++ b/arch/powerpc/mm/pgtable-frag.c
@@ -120,3 +120,54 @@ void pte_fragment_free(unsigned long *table, int kernel)
 		__free_page(page);
 	}
 }
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define PTE_FREE_DEFERRED 0x10000 /* beyond any PTE_FRAG_NR */
+
+static void pte_free_now(struct rcu_head *head)
+{
+	struct page *page;
+	int refcount;
+
+	page = container_of(head, struct page, rcu_head);
+	refcount = atomic_sub_return(PTE_FREE_DEFERRED - 1,
+				     &page->pt_frag_refcount);
+	if (refcount < PTE_FREE_DEFERRED) {
+		pte_fragment_free((unsigned long *)page_address(page), 0);
+		return;
+	}
+	/*
+	 * One page may be shared between PTE_FRAG_NR pagetables.
+	 * At least one more call to pte_free_defer() came in while we
+	 * were already deferring, so the free must be deferred again;
+	 * but just for one grace period, however many calls came in.
+	 */
+	while (refcount >= PTE_FREE_DEFERRED + PTE_FREE_DEFERRED) {
+		refcount = atomic_sub_return(PTE_FREE_DEFERRED,
+					     &page->pt_frag_refcount);
+	}
+	/* Remove that refcount of 1 left for fragment freeing above */
+	atomic_dec(&page->pt_frag_refcount);
+	call_rcu(&page->rcu_head, pte_free_now);
+}
+
+void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
+{
+	struct page *page;
+
+	page = virt_to_page(pgtable);
+	/*
+	 * One page may be shared between PTE_FRAG_NR pagetables: only queue
+	 * it once for freeing, but note whenever the free must be deferred.
+	 *
+	 * (This would be much simpler if the struct page had an rcu_head for
+	 * each fragment, or if we could allocate a separate array for that.)
+	 *
+	 * Convert our refcount of 1 to a refcount of PTE_FREE_DEFERRED, and
+	 * proceed to call_rcu() only when the rcu_head is not already in use.
+	 */
+	if (atomic_add_return(PTE_FREE_DEFERRED - 1, &page->pt_frag_refcount) <
+			      PTE_FREE_DEFERRED + PTE_FREE_DEFERRED)
+		call_rcu(&page->rcu_head, pte_free_now);
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
-- 
2.35.3

