Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26566 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726675AbgIJRJM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Sep 2020 13:09:12 -0400
Date: Thu, 10 Sep 2020 19:07:57 +0200
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200910190757.153319d4@thinkpad>
In-Reply-To: <20200910151026.GL87483@ziepe.ca>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
        <20200907180058.64880-2-gerald.schaefer@linux.ibm.com>
        <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
        <20200909142904.00b72921@thinkpad>
        <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
        <20200909192534.442f8984@thinkpad>
        <20200909180324.GI87483@ziepe.ca>
        <20200910093925.GB29166@oc3871087118.ibm.com>
        <20200910130233.GK87483@ziepe.ca>
        <20200910152803.1a930afc@thinkpad>
        <20200910151026.GL87483@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Dave Hansen <dave.hansen@intel.com>, John Hubbard <jhubbard@nvidia.com>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>, Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-x86 <x86@kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, linux-sparc <sparclinux@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>

On Thu, 10 Sep 2020 12:10:26 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Thu, Sep 10, 2020 at 03:28:03PM +0200, Gerald Schaefer wrote:
> > On Thu, 10 Sep 2020 10:02:33 -0300
> > Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >   
> > > On Thu, Sep 10, 2020 at 11:39:25AM +0200, Alexander Gordeev wrote:
> > >   
> > > > As Gerald mentioned, it is very difficult to explain in a clear way.
> > > > Hopefully, one could make sense ot of it.    
> > > 
> > > I would say the page table API requires this invariant:
> > > 
> > >         pud = pud_offset(p4d, addr);
> > >         do {
> > > 		WARN_ON(pud != pud_offset(p4d, addr);
> > >                 next = pud_addr_end(addr, end);
> > >         } while (pud++, addr = next, addr != end);
> > > 
> > > ie pud++ is supposed to be a shortcut for 
> > >   pud_offset(p4d, next)
> > > 
> > > While S390 does not follow this. Fixing addr_end brings it into
> > > alignment by preventing pud++ from happening.
> > > 
> > > The only currently known side effect is that gup_fast crashes, but it
> > > sure is an unexpected thing.  
> > 
> > It only is unexpected in a "top-level folding" world, see my other reply.
> > Consider it an optimization, which was possible because of how our dynamic
> > folding works, and e.g. because we can determine the correct pagetable
> > level from a pXd value in pXd_offset.  
> 
> No, I disagree. The page walker API the arch presents has to have well
> defined semantics. For instance, there is an effort to define tests
> and invarients for the page table accesses to bring this understanding
> and uniformity:
> 
>  mm/debug_vm_pgtable.c
> 
> If we fix S390 using the pX_addr_end() change then the above should be
> updated with an invariant to check it. I've added Anshuman for some
> thoughts..

We are very aware of those tests, and actually a big supporter of the
idea. Also part of the supported architectures already, and it has
already helped us find / fix some s390 oddities.

However, we did not see any issues wrt to our pagetable walking,
neither with the current version, nor with the new generic approach.
We do currently see other issues, Anshuman will know what I mean :-)

> For better or worse, that invariant does exclude arches from using
> other folding techniques.
> 
> The other solution would be to address the other side of != and adjust
> the pud++
> 
> eg replcae pud++ with something like:
>   pud = pud_next_entry(p4d, pud, next)
> 
> Such that:
>   pud_next_entry(p4d, pud, next) === pud_offset(p4d, next)
> 
> In which case the invarient changes to 'callers can never do pointer
> arithmetic on the result of pXX_offset()' which is a bit harder to
> enforce.

I might have lost track a bit. Are we still talking about possible
functional impacts of either our current pagetable walking with s390
(apart from gup_fast), or the proposed generic change (for s390, or
others?)?

Or is this rather some (other) generic issue / idea that you have,
in order to put "some more structure / enforcement" to generic
pagetable walkers?
