Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgIJSNe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Sep 2020 14:13:34 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845C5C061757
        for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2020 11:13:21 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id h6so5600427qtd.6
        for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2020 11:13:21 -0700 (PDT)
Date: Thu, 10 Sep 2020 15:13:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200910181319.GO87483@ziepe.ca>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-2-gerald.schaefer@linux.ibm.com>
 <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
 <20200909142904.00b72921@thinkpad>
 <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
 <20200909192534.442f8984@thinkpad>
 <20200909180324.GI87483@ziepe.ca>
 <20200910093925.GB29166@oc3871087118.ibm.com>
 <CAHk-=wh4SuNvThq1nBiqk0N-fW6NsY5w=VawC=rJs7ekmjAhjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh4SuNvThq1nBiqk0N-fW6NsY5w=VawC=rJs7ekmjAhjA@mail.gmail.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Dave Hansen <dave.hansen@intel.com>, John Hubbard <jhubbard@nvidia.com>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>, Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-x86 <x86@kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, linux-sparc <sparclinux@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>

On Thu, Sep 10, 2020 at 10:35:38AM -0700, Linus Torvalds wrote:
> On Thu, Sep 10, 2020 at 2:40 AM Alexander Gordeev
> <agordeev@linux.ibm.com> wrote:
> >
> > It is only gup_fast case that exposes the issue. It hits because
> > pointers to stack copies are passed to gup_pXd_range iterators, not
> > pointers to real page tables itself.
> 
> Can we possibly change fast-gup to not do the stack copies?
>
> I'd actually rather do something like that, than the "addr_end" thing.

> As you say, none of the other page table walking code does what the
> GUP code does, and I don't think it's required.

As I understand it, the requirement is because fast-gup walks without
the page table spinlock, or mmap_sem held so it must READ_ONCE the
*pXX.

It then checks that it is a valid page table pointer, then calls
pXX_offset().

The arch implementation of pXX_offset() derefs again the passed pXX
pointer. So it defeats the READ_ONCE and the 2nd load could observe
something that is no longer a page table pointer and crash.

Passing it the address of the stack value is a way to force
pXX_offset() to use the READ_ONCE result which has already been tested
to be a page table pointer.

Other page walking code that holds the mmap_sem tends to use
pmd_trans_unstable() which solves this problem by injecting a
barrier. The load hidden in pte_offset() after a pmd_trans_unstable()
can't be re-ordered and will only see a page table entry under the
mmap_sem.

However, I think that logic would have been much clearer following the
GUP model of READ_ONCE vs extra reads and a hidden barrier. At least
it took me a long time to work it out :(

I also think there are real bugs here where places are reading *pXX
multiple times without locking the page table. One was found recently
in the wild in the huge tlb code IIRC.

The mm/pagewalk.c has these missing READ_ONCE bugs too.

So.. To change away from the stack option I think we'd have to pass
the READ_ONCE value to pXX_offset() as an extra argument instead of it
derefing the pointer internally.

Jason
