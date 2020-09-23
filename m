Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25618 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726265AbgIWVdW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 23 Sep 2020 17:33:22 -0400
Date: Wed, 23 Sep 2020 23:33:06 +0200
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: BUG: Bad page state in process dirtyc0w_child
Message-ID: <20200923233306.7c5666de@thinkpad>
In-Reply-To: <CAHk-=wiMJu0_sLO78+nLoe=pxC-p=sSpC3moq0p5RyJc9KXC4Q@mail.gmail.com>
References: <a46e9bbef2ed4e17778f5615e818526ef848d791.camel@redhat.com>
        <20200916142806.GD7076@osiris>
        <20200922190350.7a0e0ca5@thinkpad>
        <20200923153938.5be5dd2c@thinkpad>
        <CAHk-=wiMJu0_sLO78+nLoe=pxC-p=sSpC3moq0p5RyJc9KXC4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Heiko Carstens <hca@linux.ibm.com>, Qian Cai <cai@redhat.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, 23 Sep 2020 13:00:45 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

[...]
> 
> Ooh. One thing that is *very* different about s390 is that it frees
> the page directly, and doesn't batch things up to happen after the TLB
> flush.
> 
> Maybe THAT is the difference? Not that I can tell why it should
> matter, for all the reasons outlines above. But on x86-64, the
> __tlb_remove_page() function just adds the page to the "free this
> later" TLB flush structure, and if it fills up it does the TLB flush
> and then does the actual batched page freeing outside the page table
> lock.
> 
> And that *has* been one of the things that the fast-gup code depended
> on. We even have a big comment about it:
> 
>         /*
>          * Disable interrupts. The nested form is used, in order to allow
>          * full, general purpose use of this routine.
>          *
>          * With interrupts disabled, we block page table pages from being
>          * freed from under us. See struct mmu_table_batch comments in
>          * include/asm-generic/tlb.h for more details.
>          *
>          * We do not adopt an rcu_read_lock(.) here as we also want to
>          * block IPIs that come from THPs splitting.
>          */
> 
> and maybe that whole thing doesn't hold true for s390 at all.

Thanks, very nice walk-through, need some time to digest this. The TLB
aspect is interesting, and we do have our own __tlb_remove_page_size(),
which directly calls free_page_and_swap_cache() instead of the generic
batched approach.

I faintly remember that we also did have some batched and rcu_sched based
approach. It seems there was some rework with commit 9de7d833e370
("s390/tlb: Convert to generic mmu_gather") and discussion in
https://lore.kernel.org/linux-arch/20180918125151.31744-1-schwidefsky@de.ibm.com/

Given the comment you mentioned and also this one from mm/gup.c:

/*
 * Fast GUP
 *
 * get_user_pages_fast attempts to pin user pages by walking the page
 * tables directly and avoids taking locks. Thus the walker needs to be
 * protected from page table pages being freed from under it, and should
 * block any THP splits.
 *
 * One way to achieve this is to have the walker disable interrupts, and
 * rely on IPIs from the TLB flushing code blocking before the page table
 * pages are freed. This is unsuitable for architectures that do not need
 * to broadcast an IPI when invalidating TLBs.
 *
 * Another way to achieve this is to batch up page table containing pages
 * belonging to more than one mm_user, then rcu_sched a callback to free those
 * pages. Disabling interrupts will allow the fast_gup walker to both block
 * the rcu_sched callback, and an IPI that we broadcast for splitting THPs
 * (which is a relatively rare event). The code below adopts this strategy.

It really sounds like we might have yet another issue with (common code)
gup_fast, and non-batched freeing of pagetable pages, though I wonder how
that would have worked with the s390-specific version of gup_fast before.

Certainly worth investigating, thanks a lot for the hint!

Meanwhile, out of curiosity, while I still fail to comprehend commit
09854ba94c6a ("mm: do_wp_page() simplification") in its entirety, there
is one detail that I find most confusing: the unlock_page() has moved
behind the wp_page_reuse(), while it was the other way round before.

Does it simply not really matter, or was it done on purpose, possibly
related to the "get rid of the nasty serialization on the page lock"
description?
