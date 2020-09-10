Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-2-gerald.schaefer@linux.ibm.com> <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
 <20200909142904.00b72921@thinkpad> <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
 <20200909192534.442f8984@thinkpad> <20200909180324.GI87483@ziepe.ca>
 <20200910093925.GB29166@oc3871087118.ibm.com> <CAHk-=wh4SuNvThq1nBiqk0N-fW6NsY5w=VawC=rJs7ekmjAhjA@mail.gmail.com>
 <20200910181319.GO87483@ziepe.ca> <CAHk-=wh3SjOE2r4WCfagL5Zq4Oj4Jsu1=1jTTi2GxGDTxP-J0Q@mail.gmail.com>
 <20200910211010.46d064a7@thinkpad>
In-Reply-To: <20200910211010.46d064a7@thinkpad>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 10 Sep 2020 12:32:05 -0700
Message-ID: <CAHk-=wg3ggXU98Mnv-ss-hEcvUNc9vCtgSRc7GpcGfvyOw_h3g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table folding
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Alexander Gordeev <agordeev@linux.ibm.com>, Dave Hansen <dave.hansen@intel.com>, John Hubbard <jhubbard@nvidia.com>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>, Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-x86 <x86@kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, linux-sparc <sparclinux@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>

On Thu, Sep 10, 2020 at 12:11 PM Gerald Schaefer
<gerald.schaefer@linux.ibm.com> wrote:
>
> That sounds a lot like the pXd_offset_orig() from Martins first approach
> in this thread:
> https://lore.kernel.org/linuxppc-dev/20190418100218.0a4afd51@mschwideX1/

I have to admit to finding that name horrible, but aside from that, yes.

I don't think "pXd_offset_orig()" makes any sense as a name. Yes,
"orig" may make sense as the variable name (as in "this was the
original value we read"), but a function name should describe what it
*does*, not what the arguments are.

Plus "original" doesn't make sense to me anyway, since we're not
modifying it. To me, "original" means that there's a final version
too, which this interface in no way implies. It's just "this is the
value we already read".

("orig" does make some sense in that fault path - because by
definition we *are* going to modify the page table entry, that's the
whole point of the fault - we need to do something to not keep
faulting. But here, we're not at all necessarily modifying the page
table contents, we're just following them and readign the values once)

Of course, I don't know what a better name would be to describe what
is actually going on, I'm just explaining why I hate that naming.

*Maybe* something like just "pXd_offset_value()" together with a
comment explaining that it's given the upper pXd pointer _and_ the
value behind it, and it needs to return the next level offset? I
dunno. "value" doesn't really seem horribly descriptive either, but at
least it doesn't feel actively misleading to me.

Yeah, I get hung up on naming sometimes. I don't tend to care much
about private local variables ("i" is a perfectly fine variable name),
but these kinds of somewhat subtle cross-architecture definitions I
feel matter.

               Linus
