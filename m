Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387412AbgE0VSm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 27 May 2020 17:18:42 -0400
MIME-Version: 1.0
References: <20200527173608.2885243-1-daniel.m.jordan@oracle.com> <20200527173608.2885243-6-daniel.m.jordan@oracle.com>
In-Reply-To: <20200527173608.2885243-6-daniel.m.jordan@oracle.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 27 May 2020 14:18:30 -0700
Message-ID: <CAKgT0UcVRMWpaxYu9SQnTuQZm6ePBJkTStWPwekzkfRMnLvf1Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] mm: don't track number of pages during deferred initialization
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert <steffen.klassert@secunet.com>, Alex Williamson <alex.williamson@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Triplett <josh@joshtriplett.org>, Kirill Tkhai <ktkhai@virtuozzo.com>, Michal Hocko <mhocko@kernel.org>, Pavel Machek <pavel@ucw.cz>, Pavel Tatashin <pasha.tatashin@soleen.com>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, Robert Elliott <elliott@hpe.com>, Shile Zhang <shile.zhang@linux.alibaba.com>, Steven Sistare <steven.sistare@oracle.com>, Tejun Heo <tj@kernel.org>, Zi Yan <ziy@nvidia.com>, linux-crypto@vger.kernel.org, linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>

On Wed, May 27, 2020 at 10:37 AM Daniel Jordan
<daniel.m.jordan@oracle.com> wrote:
>
> Deferred page init used to report the number of pages initialized:
>
>   node 0 initialised, 32439114 pages in 97ms
>
> Tracking this makes the code more complicated when using multiple
> threads.  Given that the statistic probably has limited value,
> especially since a zone grows on demand so that the page count can vary,
> just remove it.
>
> The boot message now looks like
>
>   node 0 deferred pages initialised in 97ms
>
> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Suggested-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

This looks good to me.

Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

> ---
>  mm/page_alloc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d0c0d9364aa6d..d64f3027fdfa6 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1819,7 +1819,7 @@ static int __init deferred_init_memmap(void *data)
>  {
>         pg_data_t *pgdat = data;
>         const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
> -       unsigned long spfn = 0, epfn = 0, nr_pages = 0;
> +       unsigned long spfn = 0, epfn = 0;
>         unsigned long first_init_pfn, flags;
>         unsigned long start = jiffies;
>         struct zone *zone;
> @@ -1868,15 +1868,15 @@ static int __init deferred_init_memmap(void *data)
>          * allocator.
>          */
>         while (spfn < epfn) {
> -               nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
> +               deferred_init_maxorder(&i, zone, &spfn, &epfn);
>                 cond_resched();
>         }
>  zone_empty:
>         /* Sanity check that the next zone really is unpopulated */
>         WARN_ON(++zid < MAX_NR_ZONES && populated_zone(++zone));
>
> -       pr_info("node %d initialised, %lu pages in %ums\n",
> -               pgdat->node_id, nr_pages, jiffies_to_msecs(jiffies - start));
> +       pr_info("node %d deferred pages initialised in %ums\n",
> +               pgdat->node_id, jiffies_to_msecs(jiffies - start));
>
>         pgdat_init_report_one_done();
>         return 0;
> --
> 2.26.2
>
>
