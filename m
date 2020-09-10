Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-2-gerald.schaefer@linux.ibm.com> <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
 <20200909142904.00b72921@thinkpad> <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
 <20200909192534.442f8984@thinkpad> <20200909180324.GI87483@ziepe.ca>
 <20200910093925.GB29166@oc3871087118.ibm.com> <CAHk-=wh4SuNvThq1nBiqk0N-fW6NsY5w=VawC=rJs7ekmjAhjA@mail.gmail.com>
 <20200910181319.GO87483@ziepe.ca>
In-Reply-To: <20200910181319.GO87483@ziepe.ca>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 10 Sep 2020 11:33:17 -0700
Message-ID: <CAHk-=wh3SjOE2r4WCfagL5Zq4Oj4Jsu1=1jTTi2GxGDTxP-J0Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table folding
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Dave Hansen <dave.hansen@intel.com>, John Hubbard <jhubbard@nvidia.com>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>, Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-x86 <x86@kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, linux-sparc <sparclinux@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>

On Thu, Sep 10, 2020 at 11:13 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> So.. To change away from the stack option I think we'd have to pass
> the READ_ONCE value to pXX_offset() as an extra argument instead of it
> derefing the pointer internally.

Yeah, but I think that would actually be the better model than passing
an address to a random stack location.

It's also effectively what we do in some other places, eg the whole
logic with "orig" in the regular pte fault handling is basically doing
unlocked loads of the pte, various decisions on that, and then doing a
final "is this still the same pte" after it has gotten the page table
lock.

(And yes, those other pte fault handling cases are different, since
they _do_ hold the mmap lock, so they know the page *tables* are
stable, and it's only the last level that then gets re-checked against
the pte once the pte itself has also been stabilized with the page
table lock).

So I think it would actually be a better conceptual match to make the
page table walking interface be "here, this is the value I read once
carefully, and this is the address, now give me the next address".

The folded case would then just return the address it was given, and
the non-folded case would return the inner page table based on the
value.

I dunno. I don't actually feel all that strongly about this, so
whatever works, I guess.

                Linus
