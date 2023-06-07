Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74987C7EE23
	for <linux-s390@archiver.kernel.org>; Wed,  7 Jun 2023 03:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240849AbjFGDtV (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 6 Jun 2023 23:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240666AbjFGDtT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Jun 2023 23:49:19 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEB919B7
        for <linux-s390@vger.kernel.org>; Tue,  6 Jun 2023 20:49:17 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-565e8d575cbso64310307b3.3
        for <linux-s390@vger.kernel.org>; Tue, 06 Jun 2023 20:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686109756; x=1688701756;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z7egDDp6MmQZCbbodxJ12b9UShhbnTUq6PVtm9aM+04=;
        b=Pqkuvwjf09O59UPXdhhO7tjU33/VqFu4i39Q1X5ngvz5wkjB5jztMKPW4Oy+gYaN7f
         ryMo/pvFu2ihp6hoUNLGrxxJwEg8cYMz5y/fZ40STo2ayOGik+sBKWhCpCfn0AUciN7G
         u/GoJh9IbWauEReNRcuISo1bdmXC0fxzeRJsQoJjK/V1wht50c5ITiIrEruEX8FLCjD2
         dukvUd3PuNbqeJ+lutclQGH56tlKSgwPULdPaCAne7DDEI6NLUhCoAXG+BWCQuQ+cPUd
         LuL0hGsrAkgsHjfC8Mobph1RQY6cg81EchUXYFPmRFE9lQLqL6vwX8Y9XC9AJeP/FN6P
         1U9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686109756; x=1688701756;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z7egDDp6MmQZCbbodxJ12b9UShhbnTUq6PVtm9aM+04=;
        b=YeZnGYxXsZeoXLcyKPvpOMitx51gxNb0touB7TDamWBeuZ3qAZ6FH9KYlu0jSDokjJ
         bHwu4DIFwr8HotU95wLqg41RxRLJUQly9xYOPxI+S9NT7w7akq8/ZiFHPfg3dBVJUcst
         EQ8VHWlMgnfBWObgEHvTSD2TBjZ5A2sumex9Em+KXKzoNoUYZT1YWrwRz3nA1mC5YHe/
         HwWwyOeQYpBqkuPAAjGkyEdtLsRHBNiKc+sG1L8bPaOzQp2sZnA0BNSbtNXU0W5l6hZk
         2EAsDcgrn/comsAio5QDv41C/NDvJcnMq6kmUG17fShuF9kRYDNAQGsV2f/cjc0NjMKf
         Shyg==
X-Gm-Message-State: AC+VfDzPFTKjSn836zcrD9ols8o0Bb8LsQ+i9dXnGkowXfkajKcXhUqb
        NDm68fhyRUOZiY3xtYe/q4xvsw==
X-Google-Smtp-Source: ACHHUZ6FeY70tXV92DFudQ4t5nR7rwwIAGb4bJwe8V5V4ANCDpC/kaCGZoHb9LVSkohk9DbNmeTmEg==
X-Received: by 2002:a0d:cb47:0:b0:565:c96b:f526 with SMTP id n68-20020a0dcb47000000b00565c96bf526mr4712606ywd.19.1686109756614;
        Tue, 06 Jun 2023 20:49:16 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id s11-20020a81bf4b000000b00555df877a4csm4446640ywk.102.2023.06.06.20.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 20:49:15 -0700 (PDT)
Date:   Tue, 6 Jun 2023 20:49:04 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Jason Gunthorpe <jgg@ziepe.ca>
cc:     Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
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
Subject: Re: [PATCH 05/12] powerpc: add pte_free_defer() for pgtables sharing
 page
In-Reply-To: <ZH+EMp9RuEVOjVNb@ziepe.ca>
Message-ID: <9130acb-193-6fdd-f8df-75766e663978@google.com>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com> <28eb289f-ea2c-8eb9-63bb-9f7d7b9ccc11@google.com> <ZHSwWgLWaEd+zi/g@casper.infradead.org> <ZHn6n5eVTsr4Wl8x@ziepe.ca> <4df4909f-f5dd-6f94-9792-8f2949f542b3@google.com> <ZH95oobIqN0WO5MK@ziepe.ca>
 <ZH+DAxLhIYpTlIFc@x1n> <ZH+EMp9RuEVOjVNb@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 6 Jun 2023, Jason Gunthorpe wrote:
> On Tue, Jun 06, 2023 at 03:03:31PM -0400, Peter Xu wrote:
> > On Tue, Jun 06, 2023 at 03:23:30PM -0300, Jason Gunthorpe wrote:
> > > On Mon, Jun 05, 2023 at 08:40:01PM -0700, Hugh Dickins wrote:
> > > 
> > > > diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
> > > > index 20652daa1d7e..e4f58c5fc2ac 100644
> > > > --- a/arch/powerpc/mm/pgtable-frag.c
> > > > +++ b/arch/powerpc/mm/pgtable-frag.c
> > > > @@ -120,3 +120,54 @@ void pte_fragment_free(unsigned long *table, int kernel)
> > > >  		__free_page(page);
> > > >  	}
> > > >  }
> > > > +
> > > > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > > > +#define PTE_FREE_DEFERRED 0x10000 /* beyond any PTE_FRAG_NR */
> > > > +
> > > > +static void pte_free_now(struct rcu_head *head)
> > > > +{
> > > > +	struct page *page;
> > > > +	int refcount;
> > > > +
> > > > +	page = container_of(head, struct page, rcu_head);
> > > > +	refcount = atomic_sub_return(PTE_FREE_DEFERRED - 1,
> > > > +				     &page->pt_frag_refcount);
> > > > +	if (refcount < PTE_FREE_DEFERRED) {
> > > > +		pte_fragment_free((unsigned long *)page_address(page), 0);
> > > > +		return;
> > > > +	}
> > > 
> > > From what I can tell power doesn't recycle the sub fragment into any
> > > kind of free list. It just waits for the last fragment to be unused
> > > and then frees the whole page.

Yes, it's relatively simple in that way: not as sophisticated as s390.

> > > 
> > > So why not simply go into pte_fragment_free() and do the call_rcu directly:
> > > 
> > > 	BUG_ON(atomic_read(&page->pt_frag_refcount) <= 0);
> > > 	if (atomic_dec_and_test(&page->pt_frag_refcount)) {
> > > 		if (!kernel)
> > > 			pgtable_pte_page_dtor(page);
> > > 		call_rcu(&page->rcu_head, free_page_rcu)
> > 
> > We need to be careful on the lock being freed in pgtable_pte_page_dtor(),
> > in Hugh's series IIUC we need the spinlock being there for the rcu section
> > alongside the page itself.  So even if to do so we'll need to also rcu call 
> > pgtable_pte_page_dtor() when needed.

Thanks, Peter, yes that's right.

> 
> Er yes, I botched that, the dtor and the free_page should be in a the
> rcu callback function

But it was just a botched detail, and won't have answered Jason's doubt.

I had three (or perhaps it amounts to two) reasons for doing it this way:
none of which may seem good enough reasons to you.  Certainly I'd agree
that the way it's done seems... arcane.

One, as I've indicated before, I don't actually dare to go all
the way into RCU freeing of all page tables for powerpc (or any other):
I should think it's a good idea that everyone wants in the end, but I'm
limited by my time and competence - and dread of losing my way in the
mmu_gather TLB #ifdef maze.  It's work for someone else not me.

(pte_free_defer() do as you suggest, without changing pte_fragment_free()
itself?  No, that doesn't work out when defer does, say, the decrement of
pt_frag_refcount from 2 to 1, then pte_fragment_free() does the decrement
from 1 to 0: page freed without deferral.)

Two, this was the code I'd worked out before, and was used in production,
so I had confidence in it - it was just my mistake that I'd forgotten the
single rcu_head issue, and thought I could avoid it in the initial posting.
powerpc has changed around since then, but apparently not in any way that
affects this.  And it's too easy to agree in review that something can be
simpler, without bringing back to mind why the complications are there.

Three (just an explanation of why the old code was like this), powerpc
relies on THP's page table deposit+withdraw protocol, even for shmem/
file THPs.  I've skirted that issue in this series, by sticking with
retract_page_tables(), not attempting to insert huge pmd immediately.
But if huge pmd is inserted to replace ptetable pmd, then ptetable must
be deposited: pte_free_defer() as written protects the deposited ptetable
from then being freed without deferral (rather like in the example above).

But does not protect it from being withdrawn and reused within that
grace period.  Jann has grave doubts whether that can ever be allowed
(or perhaps I should grant him certainty, and examples that it cannot).
I did convince myself, back in the day, that it was safe here: but I'll
have to put in a lot more thought to re-justify it now, and on the way
may instead be completely persuaded by Jann.

Not very good reasons: good enough, or can you supply a better patch?

Thanks,
Hugh
