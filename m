Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 17 Jun 2020 12:10:49 -0400
From: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 00/25] mm: Page fault accounting cleanups
Message-ID: <20200617161049.GE76766@xz-x1>
References: <20200615221607.7764-1-peterx@redhat.com>
 <CAHk-=wiTjaXHu+uxMi0xCZQOm4KVr0MucECAK=Zm4p4YZZ1XEg@mail.gmail.com>
 <87imfqecjx.fsf@mpe.ellerman.id.au>
 <20200617080405.GA3208@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200617080405.GA3208@willie-the-truck>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>, openrisc@lists.librecores.org, linux-arch <linux-arch@vger.kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Wed, Jun 17, 2020 at 09:04:06AM +0100, Will Deacon wrote:
> On Wed, Jun 17, 2020 at 10:55:14AM +1000, Michael Ellerman wrote:
> > Linus Torvalds <torvalds@linux-foundation.org> writes:
> > > On Mon, Jun 15, 2020 at 3:16 PM Peter Xu <peterx@redhat.com> wrote:
> > >> This series tries to address all of them by introducing mm_fault_accounting()
> > >> first, so that we move all the page fault accounting into the common code base,
> > >> then call it properly from arch pf handlers just like handle_mm_fault().
> > >
> > > Hmm.
> > >
> > > So having looked at this a bit more, I'd actually like to go even
> > > further, and just get rid of the per-architecture code _entirely_.
> > 
> > <snip>
> > 
> > > One detail worth noting: I do wonder if we should put the
> > >
> > >     perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
> > >
> > > just in the arch code at the top of the fault handling, and consider
> > > it entirely unrelated to the major/minor fault handling. The
> > > major/minor faults fundamnetally are about successes. But the plain
> > > PERF_COUNT_SW_PAGE_FAULTS could be about things that fail, including
> > > things that never even get to this point at all.
> > 
> > Yeah I think we should keep it in the arch code at roughly the top.
> 
> I agree. It's a nice idea to consolidate the code, but I don't see that
> it's really possible for PERF_COUNT_SW_PAGE_FAULTS without significantly
> changing the semantics (and a potentially less useful way. Of course,
> moving more of do_page_fault() out of the arch code would be great, but
> that's a much bigger effort.
> 
> > If it's moved to the end you could have a process spinning taking bad
> > page faults (and fixing them up), and see no sign of it from the perf
> > page fault counters.
> 
> The current arm64 behaviour is that we record PERF_COUNT_SW_PAGE_FAULTS
> if _all_ of the following are true:
> 
>   1. The fault isn't handled by kprobes
>   2. The pagefault handler is enabled
>   3. We have an mm (current->mm)
>   4. The fault isn't an unexpected kernel fault on a user address (we oops
>      and kill the task in this case)
> 
> Which loosely corresponds to "we took a fault on a user address that it
> looks like we can handle".
> 
> That said, I'm happy to tweak this if it brings us into line with other
> architectures.

I see.  I'll keep the semantics for PERF_COUNT_SW_PAGE_FAULTS in the next
version.  Thanks for all the comments!

-- 
Peter Xu
