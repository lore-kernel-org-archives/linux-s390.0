Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:49652 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgEUPoM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 21 May 2020 11:44:12 -0400
Date: Thu, 21 May 2020 11:39:03 -0400
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH v2 5/7] mm: parallelize deferred_init_memmap()
Message-ID: <20200521153903.ej4cudt3lmwlz436@ca-dmjordan1.us.oracle.com>
References: <20200520182645.1658949-1-daniel.m.jordan@oracle.com>
 <20200520182645.1658949-6-daniel.m.jordan@oracle.com>
 <CAKgT0UfWOe-_rA+o5Uh-mTKSodsv9pFvApun=oYeAsOpMpP83Q@mail.gmail.com>
 <CAKgT0UdRectcwcpMaHkot0Na7JZj8sAzr45Qh5pnR+joAQpKEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UdRectcwcpMaHkot0Na7JZj8sAzr45Qh5pnR+joAQpKEg@mail.gmail.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert <steffen.klassert@secunet.com>, Alex Williamson <alex.williamson@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Triplett <josh@joshtriplett.org>, Kirill Tkhai <ktkhai@virtuozzo.com>, Michal Hocko <mhocko@kernel.org>, Pavel Machek <pavel@ucw.cz>, Pavel Tatashin <pasha.tatashin@soleen.com>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, Robert Elliott <elliott@hpe.com>, Shile Zhang <shile.zhang@linux.alibaba.com>, Steven Sistare <steven.sistare@oracle.com>, Tejun Heo <tj@kernel.org>, Zi Yan <ziy@nvidia.com>, linux-crypto@vger.kernel.org, linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>

On Thu, May 21, 2020 at 08:00:31AM -0700, Alexander Duyck wrote:
> So I was thinking about my suggestion further and the loop at the end
> isn't quite correct as I believe it could lead to gaps. The loop on
> the end should probably be:
>                 for_each_free_mem_pfn_range_in_zone_from(i, zone, spfn, epfn) {
>                         if (epfn <= epfn_align)
>                                 continue;
>                         if (spfn < epfn_align)
>                                 spfn = epfn_align;
>                         break;
>                 }
> 
> That would generate a new range where epfn_align has actually ended
> and there is a range of new PFNs to process.

Whoops, my email crossed with yours.  Agreed, but see the other message.
