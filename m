Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16210 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725898AbgIKMVF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 11 Sep 2020 08:21:05 -0400
Date: Fri, 11 Sep 2020 14:19:56 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200911121955.GA10250@oc3871087118.ibm.com>
References: <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
 <20200909142904.00b72921@thinkpad>
 <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
 <20200909192534.442f8984@thinkpad>
 <20200909180324.GI87483@ziepe.ca>
 <20200910093925.GB29166@oc3871087118.ibm.com>
 <CAHk-=wh4SuNvThq1nBiqk0N-fW6NsY5w=VawC=rJs7ekmjAhjA@mail.gmail.com>
 <20200910181319.GO87483@ziepe.ca>
 <0c9bcb54-914b-e582-dd6d-3861267b6c94@nvidia.com>
 <20200910221116.GQ87483@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910221116.GQ87483@ziepe.ca>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: John Hubbard <jhubbard@nvidia.com>, Linus Torvalds <torvalds@linux-foundation.org>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Dave Hansen <dave.hansen@intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>, Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-x86 <x86@kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, linux-sparc <sparclinux@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>

On Thu, Sep 10, 2020 at 07:11:16PM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 10, 2020 at 02:22:37PM -0700, John Hubbard wrote:
> 
> > Or am I way off here, and it really is possible (aside from the current
> > s390 situation) to observe something that "is no longer a page table"?
> 
> Yes, that is the issue. Remember there is no locking for GUP
> fast. While a page table cannot be freed there is nothing preventing
> the page table entry from being concurrently modified.
> 
> Without the stack variable it looks like this:
> 
>        pud_t pud = READ_ONCE(*pudp);
>        if (!pud_present(pud))
>             return
>        pmd_offset(pudp, address);
> 
> And pmd_offset() expands to
> 
>     return (pmd_t *)pud_page_vaddr(*pud) + pmd_index(address);
> 
> Between the READ_ONCE(*pudp) and (*pud) inside pmd_offset() the value
> of *pud can change, eg to !pud_present.
> 
> Then pud_page_vaddr(*pud) will crash. It is not use after free, it
> is using data that has not been validated.

One thing I ask myself and it is probably a good moment to wonder.

What if the entry is still pud_present, but got remapped after
READ_ONCE(*pudp)? IOW, it is still valid, but points elsewhere?

> Jason
