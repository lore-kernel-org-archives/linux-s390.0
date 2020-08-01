Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45114 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725931AbgHAKy4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 1 Aug 2020 06:54:56 -0400
Subject: Re: [PATCH 06/15] powerpc: fadamp: simplify
 fadump_reserve_crash_area()
References: <20200728051153.1590-1-rppt@kernel.org>
 <20200728051153.1590-7-rppt@kernel.org> <87d04d5hda.fsf@mpe.ellerman.id.au>
 <20200801101854.GD534153@kernel.org>
From: Hari Bathini <hbathini@linux.ibm.com>
Message-ID: <bb86fb93-4d52-6b58-0914-eab45b74c028@linux.ibm.com>
Date: Sat, 1 Aug 2020 16:23:15 +0530
MIME-Version: 1.0
In-Reply-To: <20200801101854.GD534153@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mike Rapoport <rppt@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, Hari Bathini <hbathini@in.ibm.com>, linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>, Stafford Horne <shorne@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>, clang-built-linux@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>



On 01/08/20 3:48 pm, Mike Rapoport wrote:
> On Thu, Jul 30, 2020 at 10:15:13PM +1000, Michael Ellerman wrote:
>> Mike Rapoport <rppt@kernel.org> writes:
>>> From: Mike Rapoport <rppt@linux.ibm.com>
>>>
>>> fadump_reserve_crash_area() reserves memory from a specified base address
>>> till the end of the RAM.
>>>
>>> Replace iteration through the memblock.memory with a single call to
>>> memblock_reserve() with appropriate  that will take care of proper memory
>>                                       ^
>>                                       parameters?
>>> reservation.
>>>
>>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>>> ---
>>>   arch/powerpc/kernel/fadump.c | 20 +-------------------
>>>   1 file changed, 1 insertion(+), 19 deletions(-)
>>
>> I think this looks OK to me, but I don't have a setup to test it easily.
>> I've added Hari to Cc who might be able to.
>>
>> But I'll give you an ack in the hope that it works :)
> 
> Actually, I did some digging in the git log and the traversal was added
> there on purpose by the commit b71a693d3db3 ("powerpc/fadump: exclude
> memory holes while reserving memory in second kernel")

I was about to comment on the same :)
memblock_reserve() was being used until we ran into the issue talked 
about in the above commit...

> Presuming this is still reqruired I'm going to drop this patch and will

Yeah, it is still required..

> simply replace for_each_memblock() with for_each_mem_range() in v2.

Sounds right.

>   
>> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
>>
>>
>>> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
>>> index 78ab9a6ee6ac..2446a61e3c25 100644
>>> --- a/arch/powerpc/kernel/fadump.c
>>> +++ b/arch/powerpc/kernel/fadump.c
>>> @@ -1658,25 +1658,7 @@ int __init fadump_reserve_mem(void)
>>>   /* Preserve everything above the base address */
>>>   static void __init fadump_reserve_crash_area(u64 base)
>>>   {
>>> -	struct memblock_region *reg;
>>> -	u64 mstart, msize;
>>> -
>>> -	for_each_memblock(memory, reg) {
>>> -		mstart = reg->base;
>>> -		msize  = reg->size;
>>> -
>>> -		if ((mstart + msize) < base)
>>> -			continue;
>>> -
>>> -		if (mstart < base) {
>>> -			msize -= (base - mstart);
>>> -			mstart = base;
>>> -		}
>>> -
>>> -		pr_info("Reserving %lluMB of memory at %#016llx for preserving crash data",
>>> -			(msize >> 20), mstart);
>>> -		memblock_reserve(mstart, msize);
>>> -	}
>>> +	memblock_reserve(base, memblock_end_of_DRAM() - base);
>>>   }
>>>   
>>>   unsigned long __init arch_reserved_kernel_pages(void)
>>> -- 
>>> 2.26.2
> 

Thanks
Hari
