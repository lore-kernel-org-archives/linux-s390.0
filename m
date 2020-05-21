Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:44862 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbgEUPiW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 21 May 2020 11:38:22 -0400
Date: Thu, 21 May 2020 11:37:43 -0400
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH v2 5/7] mm: parallelize deferred_init_memmap()
Message-ID: <20200521153743.ymrwhgceazzc6ccb@ca-dmjordan1.us.oracle.com>
References: <20200520182645.1658949-1-daniel.m.jordan@oracle.com>
 <20200520182645.1658949-6-daniel.m.jordan@oracle.com>
 <CAKgT0UfWOe-_rA+o5Uh-mTKSodsv9pFvApun=oYeAsOpMpP83Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UfWOe-_rA+o5Uh-mTKSodsv9pFvApun=oYeAsOpMpP83Q@mail.gmail.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert <steffen.klassert@secunet.com>, Alex Williamson <alex.williamson@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Triplett <josh@joshtriplett.org>, Kirill Tkhai <ktkhai@virtuozzo.com>, Michal Hocko <mhocko@kernel.org>, Pavel Machek <pavel@ucw.cz>, Pavel Tatashin <pasha.tatashin@soleen.com>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, Robert Elliott <elliott@hpe.com>, Shile Zhang <shile.zhang@linux.alibaba.com>, Steven Sistare <steven.sistare@oracle.com>, Tejun Heo <tj@kernel.org>, Zi Yan <ziy@nvidia.com>, linux-crypto@vger.kernel.org, linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>

On Wed, May 20, 2020 at 06:29:32PM -0700, Alexander Duyck wrote:
> On Wed, May 20, 2020 at 11:27 AM Daniel Jordan
> > @@ -1814,16 +1815,44 @@ deferred_init_maxorder(u64 *i, struct zone *zone, unsigned long *start_pfn,
> >         return nr_pages;
> >  }
> >
> > +struct definit_args {
> > +       struct zone *zone;
> > +       atomic_long_t nr_pages;
> > +};
> > +
> > +static void __init
> > +deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
> > +                          void *arg)
> > +{
> > +       unsigned long spfn, epfn, nr_pages = 0;
> > +       struct definit_args *args = arg;
> > +       struct zone *zone = args->zone;
> > +       u64 i;
> > +
> > +       deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn, start_pfn);
> > +
> > +       /*
> > +        * Initialize and free pages in MAX_ORDER sized increments so that we
> > +        * can avoid introducing any issues with the buddy allocator.
> > +        */
> > +       while (spfn < end_pfn) {
> > +               nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
> > +               cond_resched();
> > +       }
> > +
> > +       atomic_long_add(nr_pages, &args->nr_pages);
> > +}
> > +
> 
> Personally I would get rid of nr_pages entirely. It isn't worth the
> cache thrash to have this atomic variable bouncing around.

One of the things I tried to optimize was the managed_pages atomic adds in
__free_pages_core, but performance stayed the same on the biggest machine I
tested when it was done once at the end of page init instead of in every thread
for every pageblock.

I'm not sure this atomic would matter either, given it's less frequent.

> You could
> probably just have this function return void since all nr_pages is
> used for is a pr_info  statement at the end of the initialization
> which will be completely useless now anyway since we really have the
> threads running in parallel anyway.

The timestamp is still useful for observability, page init is a significant
part of kernel boot on big machines, over 10% sometimes with these patches.

It's mostly the time that matters though, I agree the number of pages is less
important and is probably worth removing just to simplify the code.  I'll do it
if no one sees a reason to keep it.

> We only really need the nr_pages logic in deferred_grow_zone in order
> to track if we have freed enough pages to allow us to go back to what
> we were doing.
>
> > @@ -1863,11 +1892,32 @@ static int __init deferred_init_memmap(void *data)
> >                 goto zone_empty;
> >
> >         /*
> > -        * Initialize and free pages in MAX_ORDER sized increments so
> > -        * that we can avoid introducing any issues with the buddy
> > -        * allocator.
> > +        * More CPUs always led to greater speedups on tested systems, up to
> > +        * all the nodes' CPUs.  Use all since the system is otherwise idle now.
> >          */
> > +       max_threads = max(cpumask_weight(cpumask), 1u);
> > +
> >         while (spfn < epfn) {
> > +               epfn_align = ALIGN_DOWN(epfn, PAGES_PER_SECTION);
> > +
> > +               if (IS_ALIGNED(spfn, PAGES_PER_SECTION) &&
> > +                   epfn_align - spfn >= PAGES_PER_SECTION) {
> > +                       struct definit_args arg = { zone, ATOMIC_LONG_INIT(0) };
> > +                       struct padata_mt_job job = {
> > +                               .thread_fn   = deferred_init_memmap_chunk,
> > +                               .fn_arg      = &arg,
> > +                               .start       = spfn,
> > +                               .size        = epfn_align - spfn,
> > +                               .align       = PAGES_PER_SECTION,
> > +                               .min_chunk   = PAGES_PER_SECTION,
> > +                               .max_threads = max_threads,
> > +                       };
> > +
> > +                       padata_do_multithreaded(&job);
> > +                       nr_pages += atomic_long_read(&arg.nr_pages);
> > +                       spfn = epfn_align;
> > +               }
> > +
> >                 nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
> >                 cond_resched();
> >         }
> 
> This doesn't look right. You are basically adding threads in addition
> to calls to deferred_init_maxorder.

The deferred_init_maxorder call is there to do the remaining, non-section
aligned part of a range.  It doesn't have to be done this way.

> In addition you are spawning one
> job per section instead of per range.

That's not what's happening, all the above is doing is aligning the end of the
range down to a section.  Each thread is working on way more than a section at
a time.

> Really you should be going for
> something more along the lines of:
> 
>         while (spfn < epfn) {
>                 unsigned long epfn_align = ALIGN(epfn,
> PAGE_PER_SECTION);
>                 struct definit_args arg = { zone, ATOMIC_LONG_INIT(0)
> };
>                 struct padata_mt_job job = {
>                         .thread_fn   = deferred_init_memmap_chunk,
>                         .fn_arg      = &arg,
>                         .start       = spfn,
>                         .size        = epfn_align - spfn,
>                         .align       = PAGES_PER_SECTION,
>                         .min_chunk   = PAGES_PER_SECTION,
>                         .max_threads = max_threads,
>                 };
> 
>                 padata_do_multithreaded(&job);
> 
>                 for_each_free_mem_pfn_range_in_zone_from(i, zone,
> spfn, epfn) {
>                         if (epfn_align <= spfn)
>                                 break;
>                 }
>         }

I can see what you're getting at even though I think this can leave ranges
uninitialized.  Starting with range [a,b), b is aligned up to d and the inner
loop skips [c,e).

a    b  c d        e
|         |         |   section boundaries
[    )  [          )

We could use deferred_init_mem_pfn_range_in_zone() instead of the for_each
loop.

What I was trying to avoid by aligning down is creating a discontiguous pfn
range that get passed to padata.  We already discussed how those are handled
by the zone iterator in the thread function, but job->size can be exaggerated
to include parts of the range that are never touched.  Thinking more about it
though, it's a small fraction of the total work and shouldn't matter.

> This should accomplish the same thing, but much more efficiently.

Well, more cleanly.  I'll give it a try.

> The
> only thing you really lose is the tracking of nr_pages which really
> doesn't add anything anyway since the value could shift around
> depending on how many times deferred_grow_zone got called anyway.
> 
> Also the spfn should already be sectioned aligned, or at least be in a
> new section unrelated to the one we just scheduled, so there is no
> need for the extra checks you had.

I was doing it to be robust to future changes.  Otherwise epfn_align - spfn
could be huge when aligning down, but with aligning up it won't matter and can
be removed.
