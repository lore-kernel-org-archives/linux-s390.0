Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgIWUBF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 23 Sep 2020 16:01:05 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E56CC0613CE
        for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2020 13:01:05 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u4so673994ljd.10
        for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2020 13:01:05 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 195sm386529lfh.250.2020.09.23.13.01.01
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 13:01:01 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id u4so673876ljd.10
        for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2020 13:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <a46e9bbef2ed4e17778f5615e818526ef848d791.camel@redhat.com>
 <20200916142806.GD7076@osiris> <20200922190350.7a0e0ca5@thinkpad> <20200923153938.5be5dd2c@thinkpad>
In-Reply-To: <20200923153938.5be5dd2c@thinkpad>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 Sep 2020 13:00:45 -0700
Message-ID: <CAHk-=wiMJu0_sLO78+nLoe=pxC-p=sSpC3moq0p5RyJc9KXC4Q@mail.gmail.com>
Subject: Re: BUG: Bad page state in process dirtyc0w_child
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Peter Xu <peterx@redhat.com>, Heiko Carstens <hca@linux.ibm.com>, Qian Cai <cai@redhat.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Sep 23, 2020 at 6:39 AM Gerald Schaefer
<gerald.schaefer@linux.ibm.com> wrote:
>
> OK, I can now reproduce this, and unfortunately also with the gup_fast
> fix, so it is something different. Bisecting is a bit hard, as it will
> not always show immediately, sometimes takes up to an hour.
>
> Still, I think I found the culprit, merge commit b25d1dc9474e "Merge
> branch 'simplify-do_wp_page'". Without those 4 patches, it works fine,
> running over night.

Odd, but I have a strong suspicion that the "do_wp_page()
simplification" only ends up removing serialization that then hides
some existing thing.

> Not sure why this only shows on s390, should not be architecture-specific,
> but we do often see subtle races earlier than others due to hypervisor
> impact.

Yeah, so if it needs very particular timing, maybe the s390 page table
handling together with the hypervisor interfaces ends up being more
likely to trigger this, and thus the different timings at do_wp_page()
then ends up showing it.

> One thing that seems strange to me is that the page flags from the
> bad page state output are (uptodate|swapbacked), see below, or
> (referenced|uptodate|dirty|swapbacked) in the original report. But IIUC,
> that should not qualify for the "PAGE_FLAGS_CHECK_AT_FREE flag(s) set"
> reason. So it seems that the flags have changed between check_free_page()
> and __dump_page(), which would be very odd. Or maybe some issue with
> compound pages, because __dump_page() looks at head->flags.

The odd thing is that all of this _should_ be serialized by the page
table lock, as far as I can tell.

From your trace, it looks very much like it's do_madvise() ->
zap_pte_range() (your stack trace only has zap_p4d_range mentioned,
but all the lower levels are inlined) that races with presumably
fast-gup.

But zap_pte_range() has the pte lock, and fast-gup is - by design -
not allowed to change the page state other than taking a reference to
it, and should do that with a "try_get" operation, so even taking the
reference should never ever race with somebody doing the final free.

IOW, the fast-GUP code does that

                page = pte_page(pte);

                head = try_grab_compound_head(page, 1, flags);
                if (!head)
                        goto pte_unmap;

                if (unlikely(pte_val(pte) != pte_val(*ptep))) {
                        put_compound_head(head, 1, flags);
                        goto pte_unmap;
                }

where the important part is that "try_grab_compound_head()" which does
the whole careful atomic "increase page count only if it wasn't zero".
See page_cache_add_speculative().

So the rule is

 - if you hold the page table lock, you can just do
"get_page(pte_page())" directly, because you know the pte cannot go
away from under you

 - if you are fast-gup, the pte *can* go away from under you, so you
need to do that very careful "get page unless it's gone" dance

but I don't see us violating that.

There's maybe some interesting memory ordering in the above case, but
it does atomic_add_unless() which is ordered, and s390 is strongly
ordered anyway, isn't it?

(Yes, and it doesn't do the atomic stuff at all if TINY_RCU is set,
but that's only set for non-preemptible UP kernels, so that doesn't
matter).

So if zap_page_range() races with fast-gup, then either
zap_page_range() wins the race and puts the page - but then fast-gup
won't touch it, or fast-gup wins and gets a reference to the page, and
then zap_page_range() will clear it and drop the ref to it, but it
won't be the final ref.

Your dump seems to show that zap_page_range() *did* drop the final
ref, but something is racing with it to the point of actually
modifying the page flags.

Odd.

And the do_wp_page() change itself shouldn't be directly involved,
because that's all done under the page table lock. But it obviously
does change the page locking a lot, and changes timing a lot.

And in fact, the zap_pte_range() code itself doesn't take the page
lock (and cannot, because it's all under the page table spinlock).

So it does smell like timing to me. But possibly with some
s390-specific twist to it.

Ooh. One thing that is *very* different about s390 is that it frees
the page directly, and doesn't batch things up to happen after the TLB
flush.

Maybe THAT is the difference? Not that I can tell why it should
matter, for all the reasons outlines above. But on x86-64, the
__tlb_remove_page() function just adds the page to the "free this
later" TLB flush structure, and if it fills up it does the TLB flush
and then does the actual batched page freeing outside the page table
lock.

And that *has* been one of the things that the fast-gup code depended
on. We even have a big comment about it:

        /*
         * Disable interrupts. The nested form is used, in order to allow
         * full, general purpose use of this routine.
         *
         * With interrupts disabled, we block page table pages from being
         * freed from under us. See struct mmu_table_batch comments in
         * include/asm-generic/tlb.h for more details.
         *
         * We do not adopt an rcu_read_lock(.) here as we also want to
         * block IPIs that come from THPs splitting.
         */

and maybe that whole thing doesn't hold true for s390 at all.

            Linus
