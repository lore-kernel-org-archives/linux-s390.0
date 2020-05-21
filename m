Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:46464 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgEUVQW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 21 May 2020 17:16:22 -0400
Date: Thu, 21 May 2020 17:15:20 -0400
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH v2 5/7] mm: parallelize deferred_init_memmap()
Message-ID: <20200521211520.sqkwg4qbvx4oviob@ca-dmjordan1.us.oracle.com>
References: <20200520182645.1658949-1-daniel.m.jordan@oracle.com>
 <20200520182645.1658949-6-daniel.m.jordan@oracle.com>
 <CAKgT0UfWOe-_rA+o5Uh-mTKSodsv9pFvApun=oYeAsOpMpP83Q@mail.gmail.com>
 <20200521153743.ymrwhgceazzc6ccb@ca-dmjordan1.us.oracle.com>
 <CAKgT0Uc_LNe+KuyYxFnQ44GAfygEOQNubxwzxmTDVBvFA=WZkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0Uc_LNe+KuyYxFnQ44GAfygEOQNubxwzxmTDVBvFA=WZkA@mail.gmail.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert <steffen.klassert@secunet.com>, Alex Williamson <alex.williamson@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Triplett <josh@joshtriplett.org>, Kirill Tkhai <ktkhai@virtuozzo.com>, Michal Hocko <mhocko@kernel.org>, Pavel Machek <pavel@ucw.cz>, Pavel Tatashin <pasha.tatashin@soleen.com>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, Robert Elliott <elliott@hpe.com>, Shile Zhang <shile.zhang@linux.alibaba.com>, Steven Sistare <steven.sistare@oracle.com>, Tejun Heo <tj@kernel.org>, Zi Yan <ziy@nvidia.com>, linux-crypto@vger.kernel.org, linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>

On Thu, May 21, 2020 at 09:46:35AM -0700, Alexander Duyck wrote:
> It is more about not bothering with the extra tracking. We don't
> really need it and having it doesn't really add much in the way of
> value.

Yeah, it can probably go.

> > > > @@ -1863,11 +1892,32 @@ static int __init deferred_init_memmap(void *data)
> > > >                 goto zone_empty;
> > > >
> > > >         /*
> > > > -        * Initialize and free pages in MAX_ORDER sized increments so
> > > > -        * that we can avoid introducing any issues with the buddy
> > > > -        * allocator.
> > > > +        * More CPUs always led to greater speedups on tested systems, up to
> > > > +        * all the nodes' CPUs.  Use all since the system is otherwise idle now.
> > > >          */
> > > > +       max_threads = max(cpumask_weight(cpumask), 1u);
> > > > +
> > > >         while (spfn < epfn) {
> > > > +               epfn_align = ALIGN_DOWN(epfn, PAGES_PER_SECTION);
> > > > +
> > > > +               if (IS_ALIGNED(spfn, PAGES_PER_SECTION) &&
> > > > +                   epfn_align - spfn >= PAGES_PER_SECTION) {
> > > > +                       struct definit_args arg = { zone, ATOMIC_LONG_INIT(0) };
> > > > +                       struct padata_mt_job job = {
> > > > +                               .thread_fn   = deferred_init_memmap_chunk,
> > > > +                               .fn_arg      = &arg,
> > > > +                               .start       = spfn,
> > > > +                               .size        = epfn_align - spfn,
> > > > +                               .align       = PAGES_PER_SECTION,
> > > > +                               .min_chunk   = PAGES_PER_SECTION,
> > > > +                               .max_threads = max_threads,
> > > > +                       };
> > > > +
> > > > +                       padata_do_multithreaded(&job);
> > > > +                       nr_pages += atomic_long_read(&arg.nr_pages);
> > > > +                       spfn = epfn_align;
> > > > +               }
> > > > +
> > > >                 nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
> > > >                 cond_resched();
> > > >         }
> > >
> > > This doesn't look right. You are basically adding threads in addition
> > > to calls to deferred_init_maxorder.
> >
> > The deferred_init_maxorder call is there to do the remaining, non-section
> > aligned part of a range.  It doesn't have to be done this way.
> 
> It is also doing the advancing though isn't it?

Yes.  Not sure what you're getting at.  There's the 'spfn = epfn_align' before
so nothing is skipped.  It's true that the nonaligned part is done outside of
padata when it could be done by a thread that'd otherwise be waiting or idle,
which should be addressed in the next version.

> I think I resolved this with the fix for it I described in the other
> email. We just need to swap out spfn for epfn and make sure we align
> spfn with epfn_align. Then I think that takes care of possible skips.

Right, though your fix looks a lot like deferred_init_mem_pfn_range_in_zone().
Seems better to just use that and not repeat ourselves.  Lame that it's
starting at the beginning of the ranges every time, maybe it could be
generalized somehow, but I think it should be fast enough.

> > We could use deferred_init_mem_pfn_range_in_zone() instead of the for_each
> > loop.
> >
> > What I was trying to avoid by aligning down is creating a discontiguous pfn
> > range that get passed to padata.  We already discussed how those are handled
> > by the zone iterator in the thread function, but job->size can be exaggerated
> > to include parts of the range that are never touched.  Thinking more about it
> > though, it's a small fraction of the total work and shouldn't matter.
> 
> So the problem with aligning down is that you are going to be slowed
> up as you have to go single threaded to initialize whatever remains.
> So worst case scenario is that you have a section aligned block and
> you will process all but 1 section in parallel, and then have to
> process the remaining section one max order block at a time.

Yes, aligning up is better.

> > > This should accomplish the same thing, but much more efficiently.
> >
> > Well, more cleanly.  I'll give it a try.
> 
> I agree I am not sure if it will make a big difference on x86, however
> the more ranges you have to process the faster this approach should be
> as it stays parallel the entire time rather than having to drop out
> and process the last section one max order block at a time.

Right.
