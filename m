Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 9 Sep 2020 19:25:34 +0200
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200909192534.442f8984@thinkpad>
In-Reply-To: <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
        <20200907180058.64880-2-gerald.schaefer@linux.ibm.com>
        <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
        <20200909142904.00b72921@thinkpad>
        <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>, Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-x86 <x86@kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, linux-sparc <sparclinux@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>

On Wed, 9 Sep 2020 09:18:46 -0700
Dave Hansen <dave.hansen@intel.com> wrote:

> On 9/9/20 5:29 AM, Gerald Schaefer wrote:
> > This only works well as long there are real pagetable pointers involved,
> > that can also be used for iteration. For gup_fast, or any other future
> > pagetable walkers using the READ_ONCE logic w/o lock, that is not true.
> > There are pointers involved to local pXd values on the stack, because of
> > the READ_ONCE logic, and our middle-level iteration will suddenly iterate
> > over such stack pointers instead of pagetable pointers.
> 
> By "There are pointers involved to local pXd values on the stack", did
> you mean "locate" instead of "local"?  That sentence confused me.
> 
> Which code is it, exactly that allocates these troublesome on-stack pXd
> values, btw?

It is the gup_pXd_range() call sequence in mm/gup.c. It starts in
gup_pgd_range() with "pgdp = pgd_offset(current->mm, addr)" and then
the "pgd_t pgd = READ_ONCE(*pgdp)" which creates the first local
stack variable "pgd".

The next-level call to gup_p4d_range() gets this "pgd" value as
input, but not the original pgdp pointer where it was read from.
This is already the essential difference to other pagetable walkers
like e.g. walk_pXd_range() in mm/pagewalk.c, where the original
pointer is passed through. With READ_ONCE, that pointer must not
be further de-referenced, so instead the value is passed over.

In gup_p4d_range() we then have "p4dp = p4d_offset(&pgd, addr)",
with &pgd being a pointer to the passed over pgd value, so that's
the first pXd pointer that does not point directly to the pXd in
the page table, but a local stack variable.

With folded p4d, p4d_offset(&pgd, addr) will simply return
the passed-in &pgd pointer, so we now also have p4dp point to that.
That continues with "p4d_t p4d = READ_ONCE(*p4dp)", and that second
stack variable passed to gup_huge_pud() and so on. Due to inlining,
all those variables will not really be passed anywhere, but simply
sit on the stack.

So far, IIUC, that would also happen on x86 (or everywhere else
actually) for folded levels, i.e. some pXd_offset() calls would
simply return the passed in (stack) value pointer. This works
as designed, and it will not lead to the "iteration over stack
pointer" for anybody but s390, because the pXd_addr_end()
boundaries usually take care that you always return to pgd
level for iteration, and that is the only level with a real
pagetable pointer. For s390, we stay at the first non-folded
level and do the iteration there, which is fine for other
pagetable walkers using the original pointers, but not for
the READ_ONCE-style gup_fast.

I actually had to draw myself a picture to get some hold of
this, or rather a walk-through with a certain pud-crossing
range in a folded 3-level scenario. Not sure if I would have
understood my explanation above w/o that, but I hope you can
make some sense out of it. Or draw yourself a picture :-)
