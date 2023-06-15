Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFB4EB64DA
	for <linux-s390@archiver.kernel.org>; Thu, 15 Jun 2023 21:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjFOVJf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 15 Jun 2023 17:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjFOVJe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 15 Jun 2023 17:09:34 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A4326AA
        for <linux-s390@vger.kernel.org>; Thu, 15 Jun 2023 14:09:33 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-bb3a77abd7bso2283307276.0
        for <linux-s390@vger.kernel.org>; Thu, 15 Jun 2023 14:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686863373; x=1689455373;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CH5PYau3CTRqMPWsPTMwplApgaF/m/8/N+yxtjiLHJQ=;
        b=MSI6I7pM3GyW+MEbPvDEx3WBmqzQJQcnSFfchPDSEzpQ4yEl5ez/gnFAY3MYVcpReL
         TtQWIIP+XPkg+rrn2BH2DGlkobna2haBpFbaJ29DcsyxVt9IMXe+Sh91aSpOz22PfCMH
         YrYmU+XCw8wQ/pDD5/B05nRO6O5e1UXN3zOY7LZLQOtSw6jqixV9yT6Ak9qmVbWJpRKk
         HKnSWUnJXWlmcH1IEEOj82wuSLnCOrLeBEVkKo/m6T/CAoIt8tFnyZwlPBdkCuAEkdpm
         GDOcV8vIFu2P+G8d+b9S0P4nbGQojJM051EE6oZL2IkJPcef8QF9oOZbi40RKlSWXn0J
         sTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686863373; x=1689455373;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CH5PYau3CTRqMPWsPTMwplApgaF/m/8/N+yxtjiLHJQ=;
        b=R0MPV/AE5y+kGfZkG7KLQ8bK3VYtT1F/tjzT5KwyNCmEC7XWexOmhNoF2RfhQvz1dn
         Hz/ePlNcfjBZxxp39e88sjdsERt8abExfrMb/BR8Nm2NvVeAEecWyx8Ak2Pb3FJ0PGqC
         hgI/+A2T6UroGEhSifgVLqWJimzgQhgmLXdwhujo4IC33lnaayNz6xHkxt2RWCpHqjrg
         sG4zNCKIAANy6jw3m8Na1SMtHlsWWAvp4q+x/3EIHgea9Lwxer7+akHQ8maCKiMKrkHT
         ggQQ2XK/LnIob8RGns3ri+lbxN00wayQ/NIBpvHTuj5Pn/ZBHdb0YSa3MjcCK0tGczk+
         47Zw==
X-Gm-Message-State: AC+VfDxSMD4hhdSY4eXpBF5W4GzpsTF9RMb0kXLQ4WuOGl6rreZYejhT
        MRvZj6RdYs9eBjKQI9aZ/KBq/A==
X-Google-Smtp-Source: ACHHUZ4Hk9PbTXUaVmwwZx78XDd3LC5mJl+APSy193KWHv02zoEX+dzwYsa6jv2mPpFzcRl+eURS+g==
X-Received: by 2002:a25:b2a2:0:b0:bdd:85d:a5eb with SMTP id k34-20020a25b2a2000000b00bdd085da5ebmr99832ybj.42.1686863372876;
        Thu, 15 Jun 2023 14:09:32 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 10-20020a25060a000000b00b9def138173sm3256291ybg.1.2023.06.15.14.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 14:09:32 -0700 (PDT)
Date:   Thu, 15 Jun 2023 14:09:30 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Jason Gunthorpe <jgg@ziepe.ca>
cc:     Hugh Dickins <hughd@google.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 07/12] s390: add pte_free_defer(), with use of
 mmdrop_async()
In-Reply-To: <ZIsFQalF7rwVKXrD@ziepe.ca>
Message-ID: <422e8778-444c-d291-988c-26fc041a481@google.com>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com> <6dd63b39-e71f-2e8b-7e0-83e02f3bcb39@google.com> <175ebec8-761-c3f-2d98-6c3bd87161c8@google.com> <20230606214037.09c6b280@thinkpad-T15> <dbed4c5-1d-f278-d03a-66f5eff5e48e@google.com>
 <20230608174756.27cace18@thinkpad-T15> <a948f24b-4fe6-8bc0-221a-65e9ccc8371a@google.com> <20230614153042.43a52187@thinkpad-T15> <fc5cd62e-d85f-36c3-ba37-db87e8b625d@google.com> <ZIsFQalF7rwVKXrD@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 15 Jun 2023, Jason Gunthorpe wrote:
> On Wed, Jun 14, 2023 at 02:59:33PM -0700, Hugh Dickins wrote:
> 
> > I guess the best thing would be to modify kernel/fork.c to allow the
> > architecture to override free_mm(), and arch/s390 call_rcu to free mm.
> > But as a quick and dirty s390-end workaround, how about:
> 
> RCU callbacks are not ordered so that doesn't seem like it helps..

Thanks, that's an interesting and important point, which I need to knock
into my head better.

But can you show me where that's handled in the existing mm/mmu_gather.c
include/asm-generic/tlb.h framework?  I don't see any rcu_barrier()s
there, yet don't the pmd_huge_pte pointers point into pud page tables
freed shortly afterwards also by RCU?

> 
> synchronize_rcu would do the job since it is ordered, but I think the
> performance cost is too great to just call it from mmdrop

Yes, on x86 it proved to be a non-starter; maybe s390 doesn't have the
same limitation, but it was clear I was naive to hope that a slowdown
on the exit mm path might not be noticeable.

> 
> rcu_barrier() followed by call_rcu on the mm struct might work, but I
> don't know the cost

SLAB_TYPESAFE_BY_RCU handling has the rcu_barrier() built in,
when the slab is destroyed.

> 
> A per-cpu refcount scheme might also do the job reasonably
> 
> Making the page frag pool global (per-cpu global I guess) would also
> remove the need to reach back to the freeable mm_struct and reduce the
> need for struct page memory. This views it as a special kind of
> kmemcache.

I haven't thought in that direction at all.  Hmm.  Or did I think of
it once, but discarded for accounting reasons - IIRC (haven't rechecked)
page table pages are charged to memcg, and counted for meminfo and other(?)
purposes: if the fragments are all lumped into a global pool, we lose that.
I think I decided: maybe a good idea, but not a change I should make to
get me out of this particular hole.

> 
> Another approach is to not use a rcu_head in the ptdesc at all.
> 
> With a global kmemcache-like-thing we could probably also organize
> something where you don't use a rcu_head in the ptdesc, but instead
> just a naked 'next' pointer. This would give enough space to have two
> next pointers and the next pointers can be re-used for the normal free
> list as well.
> 
> In this flow you'd thread the free'd frags onto a waterfall of global
> per-cpu lists:
>  - RCU free the next cycle
>  - RCU free this cycle
>  - Actually free
> 
> Where a single rcu_head and single call_rcu frees the entire 2nd list
> to the 3rd list and then schedules the 1st list to be RCU'd next. This
> eliminates the need to store a function pointer in the ptdesc at
> all.
> 
> It requires some global per-cpu lock on the free/alloc paths however,
> but this is basically what every other arch does as it frees the page
> back to the page allocator.
> 
> I suspect that two next pointers would also eliminate pt_frag_refcount
> entirely as we can encode that information in the low bits of the next
> pointers.

This scheme is clearer in your head than it is in mine.  It may be the
best solution, but I don't see it clearly enough to judge.  I'll carry
on with my way, then you can replace it later on.
> 
> > (Funnily enough, there's no problem when the stored mm gets re-used for
> > a different mm, once past its spin_lock_init(&mm->context.lock);
> > because
> 
> We do that have really weird "type safe by rcu" thing in the
> allocators, but I don't quite know how it works.

I'm quite familiar with it, since I invented it (SLAB_DESTROY_BY_RCU
in 2.6.9 to solve the locking for anon_vma): so it does tend to be my
tool of choice when appropriate.  It's easy: but you cannot reinitialize
the structure on each kmem_cache_alloc(), in particular the spinlocks of
the new allocation may have to serve a tail of use from a previous
allocation at the same address.

> 
> > Powerpc is like that.  I have no idea how much gets wasted that way.
> > I was keen not to degrade what s390 does: which is definitely superior,
> > but possibly not worth the effort.
> 
> Yeah, it would be good to understand if this is really sufficiently
> beneficial..
> 
> > I'll look into it, once I understand c2c224932fd0.  But may have to write
> > to Vishal first, or get the v2 of my series out: if only I could work out
> > a safe and easy way of unbreaking s390...

My latest notion is, just for getting v2 series out, a global spinlock:
to be replaced before reaching an actual release.

> 
> Can arches opt in to RCU freeing page table support and still keep
> your series sane?

Yes, or perhaps we mean different things: I thought most architectures
are already freeing page tables by RCU.  s390 included.
"git grep MMU_GATHER_RCU_TABLE_FREE" shows plenty of selects.

> 
> Honestly, I feel like trying to RCU enable page tables should be its
> own series. It is a sufficiently tricky subject on its own right.

Puzzled,
Hugh
