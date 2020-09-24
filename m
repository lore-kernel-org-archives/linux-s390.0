Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 24 Sep 2020 14:06:38 +0200
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: BUG: Bad page state in process dirtyc0w_child
Message-ID: <20200924140638.7bcb7765@thinkpad>
In-Reply-To: <20200924000226.06298978@thinkpad>
References: <a46e9bbef2ed4e17778f5615e818526ef848d791.camel@redhat.com>
        <20200916142806.GD7076@osiris>
        <20200922190350.7a0e0ca5@thinkpad>
        <20200923153938.5be5dd2c@thinkpad>
        <CAHk-=wiMJu0_sLO78+nLoe=pxC-p=sSpC3moq0p5RyJc9KXC4Q@mail.gmail.com>
        <20200923233306.7c5666de@thinkpad>
        <CAHk-=wgbfGCKKn=RTX9gF9Q+FYOGn2kD1OLnQuJSD+A0Rvg9Pw@mail.gmail.com>
        <20200924000226.06298978@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Heiko Carstens <hca@linux.ibm.com>, Qian Cai <cai@redhat.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, 24 Sep 2020 00:02:26 +0200
Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:

> On Wed, 23 Sep 2020 14:50:36 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Wed, Sep 23, 2020 at 2:33 PM Gerald Schaefer
> > <gerald.schaefer@linux.ibm.com> wrote:
> > >
> > > Thanks, very nice walk-through, need some time to digest this. The TLB
> > > aspect is interesting, and we do have our own __tlb_remove_page_size(),
> > > which directly calls free_page_and_swap_cache() instead of the generic
> > > batched approach.
> > 
> > So I don't think it's the free_page_and_swap_cache() itself that is the problem.
> > 
> > As mentioned, the actual pages themselves should be handled by the
> > reference counting being atomic.
> > 
> > The interrupt disable is really about just the page *tables* being
> > free'd - not the final page level.
> > 
> > So the issue is that at least on x86-64, we have the serialization
> > that we will only free the page tables after a cross-CPU IPI has
> > flushed the TLB.
> > 
> > I think s390 just RCU-free's the page tables instead, which should fix it.
> > 
> > So I think this is special, and s390 is very different from x86, but I
> > don't think it's the problem.

Ah of course, I got confused by freeing pagetable pages vs. the pages
themselves. For the pagetable pages we actually use the generic
tlb_remove_table_(sync_)one, including the IPI-synchronizing
smp_call_function (CONFIG_MMU_GATHER_RCU_TABLE_FREE=y).

The "s390 magic" then only starts in our own __tlb_remove_table,
where we take care of the special 2K vs. 4K pagetable stuff.

Thanks a lot for this very valuable abstract of "who is who and why"
in pagetable memory management :-)

> > 
> > In fact, I think you pinpointed the real issue:
> > 
> > > Meanwhile, out of curiosity, while I still fail to comprehend commit
> > > 09854ba94c6a ("mm: do_wp_page() simplification") in its entirety, there
> > > is one detail that I find most confusing: the unlock_page() has moved
> > > behind the wp_page_reuse(), while it was the other way round before.
> > 
> > You know what? That was just a mistake, and I think you may actually
> > have hit the real cause of the problem.
> > 
> > It means that we keep the page locked until after we do the
> > pte_unmap_unlock(), so now we have no guarantees that we hold the page
> > referecne.
> > 
> > And then we unlock it - while somebody else might be freeing it.
> > 
> > So somebody is freeing a locked page just as we're unlocking it, and
> > that matches the problem you see exactly: the debug thing will hit
> > because the last free happened while locked, and then by the time the
> > printout happens it has become unlocked so it doesn't show any more.
> > 
> > Duh.
> > 
> > Would you mind testing just moving the unlock_page() back to before
> > the wp_page_reuse()?
> 
> Sure, I'll give it a try running over the night again.

It's all good now, no more occurrences with unlock_page() before
wp_page_reuse().
