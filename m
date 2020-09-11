Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
References: <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
 <20200909142904.00b72921@thinkpad> <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
 <20200909192534.442f8984@thinkpad> <20200909180324.GI87483@ziepe.ca>
 <20200910093925.GB29166@oc3871087118.ibm.com> <CAHk-=wh4SuNvThq1nBiqk0N-fW6NsY5w=VawC=rJs7ekmjAhjA@mail.gmail.com>
 <20200910181319.GO87483@ziepe.ca> <0c9bcb54-914b-e582-dd6d-3861267b6c94@nvidia.com>
 <20200910221116.GQ87483@ziepe.ca> <20200911121955.GA10250@oc3871087118.ibm.com>
In-Reply-To: <20200911121955.GA10250@oc3871087118.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Sep 2020 09:45:33 -0700
Message-ID: <CAHk-=wiiEUD_XvNnXysYsKiT4B3SajWbZ4VKY3jYk-17EEaaiA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table folding
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Dave Hansen <dave.hansen@intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>, Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-x86 <x86@kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, linux-sparc <sparclinux@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>

On Fri, Sep 11, 2020 at 5:20 AM Alexander Gordeev
<agordeev@linux.ibm.com> wrote:
>
> What if the entry is still pud_present, but got remapped after
> READ_ONCE(*pudp)? IOW, it is still valid, but points elsewhere?

That can't happen.

The GUP walk doesn't hold any locks, but it *is* done with interrupts
disabled, and anybody who is modifying the page tables needs to do the
TLB flush, and/or RCU-free them.

The interrupt disable means that on architectures where the TLB flush
involves an IPI, it will be delayed until afterwards, but it also acts
as a big RCU read lock hammer.

So the page tables can get modified under us, but the old pages won't
be released and re-used.

                Linus
