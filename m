Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [RFC PATCH v2 2/3] mm: make pXd_addr_end() functions page-table
 entry aware
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-3-gerald.schaefer@linux.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <8e28858d-e6a4-1c4f-4087-5f4a9719db94@intel.com>
Date: Tue, 8 Sep 2020 07:33:24 -0700
MIME-Version: 1.0
In-Reply-To: <20200907180058.64880-3-gerald.schaefer@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>, Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-x86 <x86@kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, linux-sparc <sparclinux@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>

On 9/7/20 11:00 AM, Gerald Schaefer wrote:
> x86:
> add/remove: 0/0 grow/shrink: 2/0 up/down: 10/0 (10)
> Function                                     old     new   delta
> vmemmap_populate                             587     592      +5
> munlock_vma_pages_range                      556     561      +5
> Total: Before=15534694, After=15534704, chg +0.00%
...
>  arch/x86/mm/init_64.c                    | 15 ++++-----
>  arch/x86/mm/kasan_init_64.c              | 16 +++++-----

I didn't do a super thorough review on this, but it generally looks OK
and the benefits of sharing more code between arches certainly outweigh
a few bytes of binary growth.  For the x86 bits at least, feel free to
add my ack.
