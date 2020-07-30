Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgG3MPX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Jul 2020 08:15:23 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 06/15] powerpc: fadamp: simplify fadump_reserve_crash_area()
In-Reply-To: <20200728051153.1590-7-rppt@kernel.org>
References: <20200728051153.1590-1-rppt@kernel.org> <20200728051153.1590-7-rppt@kernel.org>
Date: Thu, 30 Jul 2020 22:15:13 +1000
Message-ID: <87d04d5hda.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christoph Hellwig <hch@lst.de>, Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <monstr@monstr.eu>, Mike Rapoport <rppt@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, clang-built-linux@googlegroups.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org, openrisc@lists.librecores.org, sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, x86@kernel.org, Hari Bathini <hbathini@in.ibm.com>

Mike Rapoport <rppt@kernel.org> writes:
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> fadump_reserve_crash_area() reserves memory from a specified base address
> till the end of the RAM.
>
> Replace iteration through the memblock.memory with a single call to
> memblock_reserve() with appropriate  that will take care of proper memory
                                     ^
                                     parameters?
> reservation.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/powerpc/kernel/fadump.c | 20 +-------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)

I think this looks OK to me, but I don't have a setup to test it easily.
I've added Hari to Cc who might be able to.

But I'll give you an ack in the hope that it works :)

Acked-by: Michael Ellerman <mpe@ellerman.id.au>


> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 78ab9a6ee6ac..2446a61e3c25 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -1658,25 +1658,7 @@ int __init fadump_reserve_mem(void)
>  /* Preserve everything above the base address */
>  static void __init fadump_reserve_crash_area(u64 base)
>  {
> -	struct memblock_region *reg;
> -	u64 mstart, msize;
> -
> -	for_each_memblock(memory, reg) {
> -		mstart = reg->base;
> -		msize  = reg->size;
> -
> -		if ((mstart + msize) < base)
> -			continue;
> -
> -		if (mstart < base) {
> -			msize -= (base - mstart);
> -			mstart = base;
> -		}
> -
> -		pr_info("Reserving %lluMB of memory at %#016llx for preserving crash data",
> -			(msize >> 20), mstart);
> -		memblock_reserve(mstart, msize);
> -	}
> +	memblock_reserve(base, memblock_end_of_DRAM() - base);
>  }
>  
>  unsigned long __init arch_reserved_kernel_pages(void)
> -- 
> 2.26.2
