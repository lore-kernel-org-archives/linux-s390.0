Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-io1-f68.google.com ([209.85.166.68]:46642 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfI0WRh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 27 Sep 2019 18:17:37 -0400
MIME-Version: 1.0
References: <1569613623-16820-1-git-send-email-cai@lca.pw> <20190927140222.6f7d0a41b9e734053ee911b9@linux-foundation.org>
 <1569619686.5576.242.camel@lca.pw> <20190927145945.846a3f3405d3af066827d3f5@linux-foundation.org>
In-Reply-To: <20190927145945.846a3f3405d3af066827d3f5@linux-foundation.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 27 Sep 2019 15:17:25 -0700
Message-ID: <CAKgT0UfZBNmn1aZdvRT6Yvki3LBi_Nr5hjkYeSnpA7S8kY58-Q@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: fix a crash in free_pages_prepare()
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Qian Cai <cai@lca.pw>, Heiko Carstens <heiko.carstens@de.ibm.com>, gor@linux.ibm.com, David Hildenbrand <david@redhat.com>, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>

On Fri, Sep 27, 2019 at 2:59 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 27 Sep 2019 17:28:06 -0400 Qian Cai <cai@lca.pw> wrote:
>
> > >
> > > So I think you've moved the arch_free_page() to be after the final
> > > thing which can access page contents, yes?  If so, we should have a
> > > comment in free_pages_prepare() to attmept to prevent this problem from
> > > reoccurring as the code evolves?
> >
> > Right, something like this above arch_free_page() there?
> >
> > /*
> >  * It needs to be just above kernel_map_pages(), as s390 could mark those
> >  * pages unused and then trigger a fault when accessing.
> >  */
>
> I did this.
>
> --- a/mm/page_alloc.c~mm-page_alloc-fix-a-crash-in-free_pages_prepare-fix
> +++ a/mm/page_alloc.c
> @@ -1179,7 +1179,13 @@ static __always_inline bool free_pages_p
>                 kernel_init_free_pages(page, 1 << order);
>
>         kernel_poison_pages(page, 1 << order, 0);
> +       /*
> +        * arch_free_page() can make the page's contents inaccessible.  s390
> +        * does this.  So nothing which can access the page's contents should
> +        * happen after this.
> +        */
>         arch_free_page(page, order);
> +
>         if (debug_pagealloc_enabled())
>                 kernel_map_pages(page, 1 << order, 0);
>

So the question I would have is what is the state of the page after it
has been marked unused and then pulled back in? I'm assuming it will
be all 0s.

I know with the work I am still doing on marking pages as unused this
ends up being an additional item that we will need to pay attention
to, however in our case we will just be initializing the page as zero
if we end up evicting it from the guest.
