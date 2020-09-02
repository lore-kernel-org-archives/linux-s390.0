Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9100 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726285AbgIBMYr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Sep 2020 08:24:47 -0400
Date: Wed, 2 Sep 2020 14:24:37 +0200
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [RFC PATCH 0/2] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200902142437.5f39b4bb@thinkpad>
In-Reply-To: <91988792-069c-31a6-7840-0122357538c7@nvidia.com>
References: <20200828140314.8556-1-gerald.schaefer@linux.ibm.com>
        <9071c9fa-ba6a-90dc-2d7a-8b155141d890@de.ibm.com>
        <20200831121553.8be5dcdbdbc5256846ac513e@linux-foundation.org>
        <20200901194020.418da486@thinkpad>
        <91988792-069c-31a6-7840-0122357538c7@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>

On Tue, 1 Sep 2020 16:22:22 -0700
John Hubbard <jhubbard@nvidia.com> wrote:

> On 9/1/20 10:40 AM, Gerald Schaefer wrote:
> > On Mon, 31 Aug 2020 12:15:53 -0700
> > Andrew Morton <akpm@linux-foundation.org> wrote:
> ...
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index e8cbc2e795d5..43dacbce823f 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -681,6 +681,38 @@ static inline int arch_unmap_one(struct mm_struct *mm,
> >   })
> >   #endif
> >   
> > +/*
> > + * With dynamic page table levels on s390, the static pXd_addr_end() functions
> > + * will not return corresponding dynamic boundaries. This is no problem as long
> > + * as only pXd pointers are passed down during page table walk, because
> > + * pXd_offset() will simply return the given pointer for folded levels, and the
> > + * pointer iteration over a range simply happens at the correct page table
> > + * level.
> > + * It is however a problem with gup_fast, or other places walking the page
> > + * tables w/o locks using READ_ONCE(), and passing down the pXd values instead
> > + * of pointers. In this case, the pointer given to pXd_offset() is a pointer to
> > + * a stack variable, which cannot be used for pointer iteration at the correct
> > + * level. Instead, the iteration then has to happen by going up to pgd level
> > + * again. To allow this, provide pXd_addr_end_folded() functions with an
> > + * additional pXd value parameter, which can be used on s390 to determine the
> > + * folding level and return the corresponding boundary.
> 
> Ah OK, I finally see what you have in mind. And as Jason noted, if we just
> pass an additional parameter to pXd_addr_end() that's going to be
> cleaner. And doing so puts this in line with other page table
> abstractions that also carry more information than some architectures
> need. For example, on x86, set_pte_at() ignores the first two
> parameters:
> 
> #define set_pte_at(mm, addr, ptep, pte)	native_set_pte_at(mm, addr, ptep, pte)
> 
> static inline void native_set_pte_at(struct mm_struct *mm, unsigned long addr,
> 				     pte_t *ptep , pte_t pte)
> {
> 	native_set_pte(ptep, pte);
> }
> 
> This type of abstraction has worked out very well, IMHO.

Yes, it certainly feels like the right way to do it, and it would
not affect other archs in a functional way. It would however introduce
a subtle change for s390 behavior on _all_ page table walkers, not
just the READ_ONCE gup_fast path, i.e. it changes the level at which
the pointer iteration is done. Of course, that *should* not have any
functional issues, or else it would also be broken in gup_fast, but
in this area we often were wrong with should / could assumptions...

At least it could have some (minor) performance impact on s390,
due to going up to pgd level again instead of staying at the
folded level, but only for crossing pud/p4d boundaries, so that
*should* be neglectable.

So, while totally agreeing that adding the pXd parameter to
pXd_addr_end() in general looks like the cleanest way, we will at
least need to give this some proper testing on s390.

One other question that came up here while doing that generalized
approach was "how to submit it", i.e. should it be split up in
multiple patches which might be cleaner, or have it all-in-one,
which would simplify Fixes/stable tags. After all, we must not forget
that this fixes a severe data integrity issue on s390, so we don't
want to unnecessarily complicate or defer backports for that.

That being said, maybe a compromise could be to split it up
in a way that first introduces the pXd_addr_end_folded()
helpers for gup only, with proper Fixes/stable tags? Then
do the generalization with more thorough testing for s390
after that, possibly also with Fixes/stable tags so that we
do not have different code in stable and upstream?
