Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 9 Sep 2020 14:29:04 +0200
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200909142904.00b72921@thinkpad>
In-Reply-To: <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
        <20200907180058.64880-2-gerald.schaefer@linux.ibm.com>
        <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>, Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-x86 <x86@kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, linux-sparc <sparclinux@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>

On Tue, 8 Sep 2020 07:30:50 -0700
Dave Hansen <dave.hansen@intel.com> wrote:

> On 9/7/20 11:00 AM, Gerald Schaefer wrote:
> > Commit 1a42010cdc26 ("s390/mm: convert to the generic get_user_pages_fast
> > code") introduced a subtle but severe bug on s390 with gup_fast, due to
> > dynamic page table folding.
> 
> Would it be fair to say that the "fake" page table entries s390
> allocates on the stack are what's causing the trouble here?  That might
> be a nice thing to open up with here.  "Dynamic page table folding"
> really means nothing to me.

Sorry, I guess my previous reply does not really explain "what the heck
is dynamic page table folding?".

On s390, we can have different number of page table levels for different
processes / mms. We always start with 3 levels, and update dynamically
on process demand to 4 or 5 levels, hence the dynamic folding. Still,
the PxD_SIZE/SHIFT is defined statically, so that e.g. pXd_addr_end() will
not reflect this dynamic behavior.

For the various pagetable walkers using pXd_addr_end() (w/o READ_ONCE
logic) this is no problem. With static folding, iteration over the folded
levels will always happen at pgd level (top-level folding). For s390,
we stay at the respective level and iterate there (dynamic middle-level
folding), only return to pgd level if there really were 5 levels.

This only works well as long there are real pagetable pointers involved,
that can also be used for iteration. For gup_fast, or any other future
pagetable walkers using the READ_ONCE logic w/o lock, that is not true.
There are pointers involved to local pXd values on the stack, because of
the READ_ONCE logic, and our middle-level iteration will suddenly iterate
over such stack pointers instead of pagetable pointers.

This will be addressed by making the pXd_addr_end() dynamic, for which
we need to see the pXd value in order to determine its level / type.
