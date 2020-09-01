Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12500 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgIAXWX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 1 Sep 2020 19:22:23 -0400
Subject: Re: [RFC PATCH 0/2] mm/gup: fix gup_fast with dynamic page table
 folding
References: <20200828140314.8556-1-gerald.schaefer@linux.ibm.com>
 <9071c9fa-ba6a-90dc-2d7a-8b155141d890@de.ibm.com>
 <20200831121553.8be5dcdbdbc5256846ac513e@linux-foundation.org>
 <20200901194020.418da486@thinkpad>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <91988792-069c-31a6-7840-0122357538c7@nvidia.com>
Date: Tue, 1 Sep 2020 16:22:22 -0700
MIME-Version: 1.0
In-Reply-To: <20200901194020.418da486@thinkpad>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>

On 9/1/20 10:40 AM, Gerald Schaefer wrote:
> On Mon, 31 Aug 2020 12:15:53 -0700
> Andrew Morton <akpm@linux-foundation.org> wrote:
...
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index e8cbc2e795d5..43dacbce823f 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -681,6 +681,38 @@ static inline int arch_unmap_one(struct mm_struct *mm,
>   })
>   #endif
>   
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

Ah OK, I finally see what you have in mind. And as Jason noted, if we just
pass an additional parameter to pXd_addr_end() that's going to be
cleaner. And doing so puts this in line with other page table
abstractions that also carry more information than some architectures
need. For example, on x86, set_pte_at() ignores the first two
parameters:

#define set_pte_at(mm, addr, ptep, pte)	native_set_pte_at(mm, addr, ptep, pte)

static inline void native_set_pte_at(struct mm_struct *mm, unsigned long addr,
				     pte_t *ptep , pte_t pte)
{
	native_set_pte(ptep, pte);
}

This type of abstraction has worked out very well, IMHO.


thanks,
--
John Hubbard
NVIDIA
