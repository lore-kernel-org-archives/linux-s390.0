Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA06DC001DB
	for <linux-s390@archiver.kernel.org>; Thu, 22 Jun 2023 02:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjFVCgc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 21 Jun 2023 22:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFVCgb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 21 Jun 2023 22:36:31 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A321A1
        for <linux-s390@vger.kernel.org>; Wed, 21 Jun 2023 19:36:30 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-570808d8ddeso64914467b3.0
        for <linux-s390@vger.kernel.org>; Wed, 21 Jun 2023 19:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687401389; x=1689993389;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v95kJuIKZOvwX2VyzbcG9p4WcOSZqpPbckNEDTbMqbw=;
        b=O3tP+byBHyqrVuzTTEu8WRLDc/8A9uAf+TdWk4s+4iRKfQ5KOSa7bvLkBzTYKr0W8M
         j3sRCXur+WjZ9BeHD+FncbDp1prKZ/qXqo9vRO5qA8AQSnrPS9w22qXk+xnyoij9+QY4
         Acm9ERBt0JMUlTv5p8Jp0yNYMVl5d341AvRtjPFDRxez8WAwHgXzS6SBOEkhSkDpkgzA
         FicxTEqozjAq1pC+B+ZdlXfR0aFh6Inz+lQvgqOR+F9yGjspH8iPGFbJTwEd3pnnSvO5
         lsJm1UV477OB7Dih1OhkfIqmAM0XwW9HFmiv+LGL2kzkOO0DnreoAdIjNdFX9CO4XaoS
         SsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687401389; x=1689993389;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v95kJuIKZOvwX2VyzbcG9p4WcOSZqpPbckNEDTbMqbw=;
        b=SYk+0iVW0CnK42QIOwTZpvj539YxD3v60bQALBv1PcvJpmyKxStIQAr6N0C+YsLijf
         bm0pv/w8p+NOjrgOHc4kJcMLmlpYtGXxcbYD9fzCBB2i4+WgUEtjx3fu3jFhMerpMUfE
         3jdjJRTw8sENOI1YlhU4m/Z8r32BW9VOmv8QzZYX0Gje1DgrpWyxw3VaABXZcEi2tXQD
         aK2mvxV0eazbsjsofiJM/2PhOSjAbW3QIxv9ZnQnNQ+Wxsl1BvNt1UrajPyEdWLOXbI+
         42RCbmYEFT0lgc3esoQkFAdKa6dOypXADSOXuDty/1CQhxoOgNrKLwBatdyTqDfPgNFT
         4R5A==
X-Gm-Message-State: AC+VfDwTK4RkTlLvet66WbQNKUkf0KI53nbzgilWrxBBWMxis0seaOmZ
        H3B9CpK67NNiaEoNtdCGZ07Oyg==
X-Google-Smtp-Source: ACHHUZ7nNc0KOSzPxWDeH97+s3XtTQiSXAf5QSy+8GGNP+KxVnc2GWHN4WSyWChzR7EoY+E3ZvtVZQ==
X-Received: by 2002:a0d:e6d3:0:b0:56d:ffa:f3b0 with SMTP id p202-20020a0de6d3000000b0056d0ffaf3b0mr14905560ywe.52.1687401389086;
        Wed, 21 Jun 2023 19:36:29 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e65-20020a0dc244000000b0056cffe97a11sm1564690ywd.13.2023.06.21.19.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 19:36:27 -0700 (PDT)
Date:   Wed, 21 Jun 2023 19:36:11 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Jason Gunthorpe <jgg@ziepe.ca>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
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
        Zack Rusin <zackr@vmware.com>,
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
Subject: Re: [PATCH v2 05/12] powerpc: add pte_free_defer() for pgtables
 sharing page
In-Reply-To: <ZJI7xkXWmjrE1yY3@ziepe.ca>
Message-ID: <c8284d0-91cb-b65e-4c95-bfeb627234f@google.com>
References: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com> <5cd9f442-61da-4c3d-eca-b7f44d22aa5f@google.com> <ZJGRa4zvsXfc43vB@ziepe.ca> <2ad8b6cf-692a-ff89-ecc-586c20c5e07f@google.com> <ZJI7xkXWmjrE1yY3@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 20 Jun 2023, Jason Gunthorpe wrote:
> On Tue, Jun 20, 2023 at 12:54:25PM -0700, Hugh Dickins wrote:
> > On Tue, 20 Jun 2023, Jason Gunthorpe wrote:
> > > On Tue, Jun 20, 2023 at 12:47:54AM -0700, Hugh Dickins wrote:
> > > > Add powerpc-specific pte_free_defer(), to call pte_free() via call_rcu().
> > > > pte_free_defer() will be called inside khugepaged's retract_page_tables()
> > > > loop, where allocating extra memory cannot be relied upon.  This precedes
> > > > the generic version to avoid build breakage from incompatible pgtable_t.
> > > > 
> > > > This is awkward because the struct page contains only one rcu_head, but
> > > > that page may be shared between PTE_FRAG_NR pagetables, each wanting to
> > > > use the rcu_head at the same time: account concurrent deferrals with a
> > > > heightened refcount, only the first making use of the rcu_head, but
> > > > re-deferring if more deferrals arrived during its grace period.
> > > 
> > > You didn't answer my question why we can't just move the rcu to the
> > > actual free page?
> > 
> > I thought that I had answered it, perhaps not to your satisfaction:
> > 
> > https://lore.kernel.org/linux-mm/9130acb-193-6fdd-f8df-75766e663978@google.com/
> > 
> > My conclusion then was:
> > Not very good reasons: good enough, or can you supply a better patch?
> 
> Oh, I guess I didn't read that email as answering the question..
> 
> I was saying to make pte_fragment_free() unconditionally do the
> RCU. It is the only thing that uses the page->rcu_head, and it means
> PPC would double RCU the final free on the TLB path, but that is
> probably OK for now. This means pte_free_defer() won't do anything
> special on PPC as PPC will always RCU free these things, this address
> the defer concern too, I think. Overall it is easier to reason about.
> 
> I looked at fixing the TLB stuff to avoid the double rcu but quickly
> got scared that ppc was using a kmem_cache to allocate other page
> table sizes so there is not a reliable struct page to get a rcu_head
> from. This looks like the main challenge for ppc... We'd have to teach
> the tlb code to not do its own RCU stuff for table levels that the
> arch is already RCU freeing - and that won't get us to full RCU
> freeing on PPC.

Sorry for being so dense all along: yes, your way is unquestionably
much better than mine.  I guess I must have been obsessive about
keeping pte_free_defer()+pte_free_now() "on the outside", as they
were on x86, and never perceived how much easier it is with a small
tweak inside pte_fragment_free(); and never reconsidered it since.

But I'm not so keen on the double-RCU, extending this call_rcu() to
all the normal cases, while still leaving the TLB batching in place:
here is the replacement patch I'd prefer us to go forward with now.

Many thanks!

[PATCH v3 05/12] powerpc: add pte_free_defer() for pgtables sharing page

Add powerpc-specific pte_free_defer(), to free table page via call_rcu().
pte_free_defer() will be called inside khugepaged's retract_page_tables()
loop, where allocating extra memory cannot be relied upon.  This precedes
the generic version to avoid build breakage from incompatible pgtable_t.

This is awkward because the struct page contains only one rcu_head, but
that page may be shared between PTE_FRAG_NR pagetables, each wanting to
use the rcu_head at the same time.  But powerpc never reuses a fragment
once it has been freed: so mark the page Active in pte_free_defer(),
before calling pte_fragment_free() directly; and there call_rcu() to
pte_free_now() when last fragment is freed and the page is PageActive.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/powerpc/include/asm/pgalloc.h |  4 ++++
 arch/powerpc/mm/pgtable-frag.c     | 29 ++++++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 3 deletions(-)

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
index 20652daa1d7e..0c6b68130025 100644
--- a/arch/powerpc/mm/pgtable-frag.c
+++ b/arch/powerpc/mm/pgtable-frag.c
@@ -106,6 +106,15 @@ pte_t *pte_fragment_alloc(struct mm_struct *mm, int kernel)
 	return __alloc_for_ptecache(mm, kernel);
 }
 
+static void pte_free_now(struct rcu_head *head)
+{
+	struct page *page;
+
+	page = container_of(head, struct page, rcu_head);
+	pgtable_pte_page_dtor(page);
+	__free_page(page);
+}
+
 void pte_fragment_free(unsigned long *table, int kernel)
 {
 	struct page *page = virt_to_page(table);
@@ -115,8 +124,22 @@ void pte_fragment_free(unsigned long *table, int kernel)
 
 	BUG_ON(atomic_read(&page->pt_frag_refcount) <= 0);
 	if (atomic_dec_and_test(&page->pt_frag_refcount)) {
-		if (!kernel)
-			pgtable_pte_page_dtor(page);
-		__free_page(page);
+		if (kernel)
+			__free_page(page);
+		else if (TestClearPageActive(page))
+			call_rcu(&page->rcu_head, pte_free_now);
+		else
+			pte_free_now(&page->rcu_head);
 	}
 }
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
+{
+	struct page *page;
+
+	page = virt_to_page(pgtable);
+	SetPageActive(page);
+	pte_fragment_free((unsigned long *)pgtable, 0);
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
-- 
2.35.3

