Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table
 folding
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-2-gerald.schaefer@linux.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
Date: Tue, 8 Sep 2020 07:30:50 -0700
MIME-Version: 1.0
In-Reply-To: <20200907180058.64880-2-gerald.schaefer@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>, Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-x86 <x86@kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, linux-sparc <sparclinux@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>

On 9/7/20 11:00 AM, Gerald Schaefer wrote:
> Commit 1a42010cdc26 ("s390/mm: convert to the generic get_user_pages_fast
> code") introduced a subtle but severe bug on s390 with gup_fast, due to
> dynamic page table folding.

Would it be fair to say that the "fake" page table entries s390
allocates on the stack are what's causing the trouble here?  That might
be a nice thing to open up with here.  "Dynamic page table folding"
really means nothing to me.

> @@ -2521,7 +2521,7 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
>  	do {
>  		pmd_t pmd = READ_ONCE(*pmdp);
>  
> -		next = pmd_addr_end(addr, end);
> +		next = pmd_addr_end_folded(pmd, addr, end);
>  		if (!pmd_present(pmd))
>  			return 0;

It looks like you fix this up later, but this would be a problem if left
this way.  There's no documentation for whether I use
pmd_addr_end_folded() or pmd_addr_end() when writing a page table walker.
