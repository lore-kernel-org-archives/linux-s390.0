Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 10 Sep 2020 19:57:49 +0200
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200910195749.795232d1@thinkpad>
In-Reply-To: <20200910130233.GK87483@ziepe.ca>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
        <20200907180058.64880-2-gerald.schaefer@linux.ibm.com>
        <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
        <20200909142904.00b72921@thinkpad>
        <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
        <20200909192534.442f8984@thinkpad>
        <20200909180324.GI87483@ziepe.ca>
        <20200910093925.GB29166@oc3871087118.ibm.com>
        <20200910130233.GK87483@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Dave Hansen <dave.hansen@intel.com>, John Hubbard <jhubbard@nvidia.com>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>, Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-x86 <x86@kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, linux-sparc <sparclinux@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>

On Thu, 10 Sep 2020 10:02:33 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Thu, Sep 10, 2020 at 11:39:25AM +0200, Alexander Gordeev wrote:
> 
> > As Gerald mentioned, it is very difficult to explain in a clear way.
> > Hopefully, one could make sense ot of it.
> 
> I would say the page table API requires this invariant:
> 
>         pud = pud_offset(p4d, addr);
>         do {
> 		WARN_ON(pud != pud_offset(p4d, addr);
>                 next = pud_addr_end(addr, end);
>         } while (pud++, addr = next, addr != end);
> 
> ie pud++ is supposed to be a shortcut for 
>   pud_offset(p4d, next)
> 

Hmm, IIUC, all architectures with static folding will simply return
the passed-in p4d pointer for pud_offset(p4d, addr), for 3-level
pagetables. There is no difference for s390. For gup_fast, that p4d
pointer is not really a pointer to a value in a pagetable, but
to some local copy of such a value, and not just for s390.

So, pud = p4d = pointer to copy, and increasing that pud pointer
cannot be the same as pud_offset(p4d, next). I do see your point
however, at last I think :-) My problem is that I do not see where
we would have an s390-specific issue here. Maybe my understanding
of how it works for others with static folding is wrong. That
would explain my difficulties in getting your point...

> While S390 does not follow this. Fixing addr_end brings it into
> alignment by preventing pud++ from happening.

Exactly, only that nobody seems to follow it, IIUC. Fixing it up
with pXd_addr_end was my impression of what we need to do, in order to
have it work the same way as for others.

> The only currently known side effect is that gup_fast crashes, but it
> sure is an unexpected thing.

Well, from my understanding it feels more unexpected that something
that is supposed to be a pointer to an entry in a page table, really is
just a pointer to some copy somewhere.
