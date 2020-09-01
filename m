Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgIASOP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 1 Sep 2020 14:14:15 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD735C061244
        for <linux-s390@vger.kernel.org>; Tue,  1 Sep 2020 11:14:14 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id cy2so974793qvb.0
        for <linux-s390@vger.kernel.org>; Tue, 01 Sep 2020 11:14:14 -0700 (PDT)
Date: Tue, 1 Sep 2020 15:14:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [RFC PATCH 0/2] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200901181412.GE24045@ziepe.ca>
References: <20200828140314.8556-1-gerald.schaefer@linux.ibm.com>
 <9071c9fa-ba6a-90dc-2d7a-8b155141d890@de.ibm.com>
 <20200831121553.8be5dcdbdbc5256846ac513e@linux-foundation.org>
 <20200901194020.418da486@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901194020.418da486@thinkpad>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, John Hubbard <jhubbard@nvidia.com>

On Tue, Sep 01, 2020 at 07:40:20PM +0200, Gerald Schaefer wrote:
> +/*
> + * With dynamic page table levels on s390, the static pXd_addr_end() functions
> + * will not return corresponding dynamic boundaries. This is no problem as long
> + * as only pXd pointers are passed down during page table walk, because
> + * pXd_offset() will simply return the given pointer for folded levels, and the
> + * pointer iteration over a range simply happens at the correct page table
> + * level.
> + * It is however a problem with gup_fast, or other places walking the page
> + * tables w/o locks using READ_ONCE(), and passing down the pXd values instead
> + * of pointers. In this case, the pointer given to pXd_offset() is a pointer to
> + * a stack variable, which cannot be used for pointer iteration at the correct
> + * level. Instead, the iteration then has to happen by going up to pgd level
> + * again. To allow this, provide pXd_addr_end_folded() functions with an
> + * additional pXd value parameter, which can be used on s390 to determine the
> + * folding level and return the corresponding boundary.
> + */
> +#ifndef pgd_addr_end_folded
> +#define pgd_addr_end_folded(pgd, addr, end)	pgd_addr_end(addr, end)
> +#endif
> +
> +#ifndef p4d_addr_end_folded
> +#define p4d_addr_end_folded(p4d, addr, end)	p4d_addr_end(addr, end)
> +#endif
> +
> +#ifndef pud_addr_end_folded
> +#define pud_addr_end_folded(pud, addr, end)	pud_addr_end(addr, end)
> +#endif
> +
> +#ifndef pmd_addr_end_folded
> +#define pmd_addr_end_folded(pmd, addr, end)	pmd_addr_end(addr, end)
> +#endif

Feels like it would be cleaner to globally change pmd_addr_end() /etc
to require the extra pmd input rather that introduce this special rule
when *_folded needs to be used? NOP on all arches execpt s390..

There are not so many call sites that it seems too scary, and I
wouldn't be surprised if there are going to be more cases beyond GUP
that *should* be using the READ_ONCE trick.

Jason
