Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 16 Jun 2020 17:03:12 -0400
From: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 00/25] mm: Page fault accounting cleanups
Message-ID: <20200616210312.GF11838@xz-x1>
References: <20200615221607.7764-1-peterx@redhat.com>
 <CAHk-=wiTjaXHu+uxMi0xCZQOm4KVr0MucECAK=Zm4p4YZZ1XEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiTjaXHu+uxMi0xCZQOm4KVr0MucECAK=Zm4p4YZZ1XEg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>, openrisc@lists.librecores.org, linux-arch <linux-arch@vger.kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Tue, Jun 16, 2020 at 11:55:17AM -0700, Linus Torvalds wrote:
> On Mon, Jun 15, 2020 at 3:16 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > This series tries to address all of them by introducing mm_fault_accounting()
> > first, so that we move all the page fault accounting into the common code base,
> > then call it properly from arch pf handlers just like handle_mm_fault().
> 
> Hmm.
> 
> So having looked at this a bit more, I'd actually like to go even
> further, and just get rid of the per-architecture code _entirely_.
> 
> Here's a straw-man patch to the generic code - the idea is mostly laid
> out in the comment that I'm just quoting here directly too:
> 
>         /*
>          * Do accounting in the common code, to avoid unnecessary
>          * architecture differences or duplicated code.
>          *
>          * We arbitrarily make the rules be:
>          *
>          *  - faults that never even got here (because the address
>          *    wasn't valid). That includes arch_vma_access_permitted()
>          *    failing above.
>          *
>          *    So this is expressly not a "this many hardware page
>          *    faults" counter. Use the hw profiling for that.
>          *
>          *  - incomplete faults (ie RETRY) do not count (see above).
>          *    They will only count once completed.
>          *
>          *  - the fault counts as a "major" fault when the final
>          *    successful fault is VM_FAULT_MAJOR, or if it was a
>          *    retry (which implies that we couldn't handle it
>          *    immediately previously).
>          *
>          *  - if the fault is done for GUP, regs wil be NULL and
>          *    no accounting will be done (but you _could_ pass in
>          *    your own regs and it would be accounted to the thread
>          *    doing the fault, not to the target!)
>          */
> 
> the code itself in the patch is
> 
>  (a) pretty trivial and self-evident
> 
>  (b) INCOMPLETE
> 
> that (b) is worth noting: this patch won't compile on its own. It
> intentionally leaves all the users without the new 'regs' argument,
> because you obviously simply need to remove all the code that
> currently tries to do any accounting.
> 
> Comments?

Looks clean to me.  The definition of "major faults" will slightly change even
for those who has done the "major |= fault & MAJOR" operations before, but at
least I can't see anything bad about that either...

To make things easier, we can use the 1st patch to introduce this change,
however pass regs==NULL at the callers to never trigger this accounting.  Then
we can still use one patch for each arch to do the final convertions.

> 
> This is a bigger change, but I think it might be worth it to _really_
> consolidate the major/minor logic.
> 
> One detail worth noting: I do wonder if we should put the
> 
>     perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
> 
> just in the arch code at the top of the fault handling, and consider
> it entirely unrelated to the major/minor fault handling. The
> major/minor faults fundamnetally are about successes. But the plain
> PERF_COUNT_SW_PAGE_FAULTS could be about things that fail, including
> things that never even get to this point at all.
> 
> I'm not convinced it's useful to have three SW events that are defined
> to be A=B+C.

IMHO it's still common to have a "total" statistics in softwares even if each
of the subsets are accounted separately.  Here it's just a bit special because
there're only two elements so the addition is so straightforward.  It seems a
trade-off on whether we'd like to do the accounting of errornous faults, or we
want to make it cleaner by put them altogether but only successful page faults.
I slightly preferred the latter due to the fact that I failed to find great
usefulness out of keeping error fault accountings, but no strong opinions..

Thanks,

-- 
Peter Xu
