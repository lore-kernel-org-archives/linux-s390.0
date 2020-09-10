Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14255 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbgIJVWw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Sep 2020 17:22:52 -0400
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table
 folding
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-2-gerald.schaefer@linux.ibm.com>
 <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
 <20200909142904.00b72921@thinkpad>
 <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
 <20200909192534.442f8984@thinkpad> <20200909180324.GI87483@ziepe.ca>
 <20200910093925.GB29166@oc3871087118.ibm.com>
 <CAHk-=wh4SuNvThq1nBiqk0N-fW6NsY5w=VawC=rJs7ekmjAhjA@mail.gmail.com>
 <20200910181319.GO87483@ziepe.ca>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <0c9bcb54-914b-e582-dd6d-3861267b6c94@nvidia.com>
Date: Thu, 10 Sep 2020 14:22:37 -0700
MIME-Version: 1.0
In-Reply-To: <20200910181319.GO87483@ziepe.ca>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Dave Hansen <dave.hansen@intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>, Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-x86 <x86@kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, linux-sparc <sparclinux@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>

On 9/10/20 11:13 AM, Jason Gunthorpe wrote:
> On Thu, Sep 10, 2020 at 10:35:38AM -0700, Linus Torvalds wrote:
>> On Thu, Sep 10, 2020 at 2:40 AM Alexander Gordeev
>> <agordeev@linux.ibm.com> wrote:
>>>
>>> It is only gup_fast case that exposes the issue. It hits because
>>> pointers to stack copies are passed to gup_pXd_range iterators, not
>>> pointers to real page tables itself.
>>
>> Can we possibly change fast-gup to not do the stack copies?
>>
>> I'd actually rather do something like that, than the "addr_end" thing.
> 
>> As you say, none of the other page table walking code does what the
>> GUP code does, and I don't think it's required.
> 
> As I understand it, the requirement is because fast-gup walks without
> the page table spinlock, or mmap_sem held so it must READ_ONCE the
> *pXX.
> 
> It then checks that it is a valid page table pointer, then calls
> pXX_offset().
> 
> The arch implementation of pXX_offset() derefs again the passed pXX
> pointer. So it defeats the READ_ONCE and the 2nd load could observe
> something that is no longer a page table pointer and crash.

Just to be clear, though, that makes it sound a little wilder and
reckless than it really is, right?

Because actually, the page tables cannot be freed while gup_fast is
walking them, due to either IPI blocking during the walk, or the moral
equivalent (MMU_GATHER_RCU_TABLE_FREE) for non-IPI architectures. So the
pages tables can *change* underneath gup_fast, and for example pages can
be unmapped. But they remain valid page tables, it's just that their
contents are unstable. Even if pXd_none()==true.

Or am I way off here, and it really is possible (aside from the current
s390 situation) to observe something that "is no longer a page table"?


thanks,
-- 
John Hubbard
NVIDIA
