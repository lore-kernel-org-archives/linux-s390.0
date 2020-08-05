Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28655 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725920AbgHEGAf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Aug 2020 02:00:35 -0400
Date: Wed, 5 Aug 2020 14:00:06 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2 14/17] x86/setup: simplify reserve_crashkernel()
Message-ID: <20200805060006.GU10792@MiWiFi-R3L-srv>
References: <20200802163601.8189-1-rppt@kernel.org>
 <20200802163601.8189-15-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200802163601.8189-15-rppt@kernel.org>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christoph Hellwig <hch@lst.de>, Dave Hansen <dave.hansen@linux.intel.com>, Emil Renner Berthing <kernel@esmil.dk>, Ingo Molnar <mingo@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Mike Rapoport <rppt@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, clang-built-linux@googlegroups.com, iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org, openrisc@lists.librecores.org, sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, x86@kernel.org

On 08/02/20 at 07:35pm, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> * Replace magic numbers with defines
> * Replace memblock_find_in_range() + memblock_reserve() with
>   memblock_phys_alloc_range()
> * Stop checking for low memory size in reserve_crashkernel_low(). The
>   allocation from limited range will anyway fail if there is no enough
>   memory, so there is no need for extra traversal of memblock.memory
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/x86/kernel/setup.c | 40 ++++++++++++++--------------------------
>  1 file changed, 14 insertions(+), 26 deletions(-)

Applied this patch on top of 5.8, crashkernel reservation works well.
And the code change looks good.

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index d8de4053c5e8..d7ced6982524 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -419,13 +419,13 @@ static int __init reserve_crashkernel_low(void)
>  {
>  #ifdef CONFIG_X86_64
>  	unsigned long long base, low_base = 0, low_size = 0;
> -	unsigned long total_low_mem;
> +	unsigned long low_mem_limit;
>  	int ret;
>  
> -	total_low_mem = memblock_mem_size(1UL << (32 - PAGE_SHIFT));
> +	low_mem_limit = min(memblock_phys_mem_size(), CRASH_ADDR_LOW_MAX);
>  
>  	/* crashkernel=Y,low */
> -	ret = parse_crashkernel_low(boot_command_line, total_low_mem, &low_size, &base);
> +	ret = parse_crashkernel_low(boot_command_line, low_mem_limit, &low_size, &base);
>  	if (ret) {
>  		/*
>  		 * two parts from kernel/dma/swiotlb.c:
> @@ -443,23 +443,17 @@ static int __init reserve_crashkernel_low(void)
>  			return 0;
>  	}
>  
> -	low_base = memblock_find_in_range(0, 1ULL << 32, low_size, CRASH_ALIGN);
> +	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
>  	if (!low_base) {
>  		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
>  		       (unsigned long)(low_size >> 20));
>  		return -ENOMEM;
>  	}
>  
> -	ret = memblock_reserve(low_base, low_size);
> -	if (ret) {
> -		pr_err("%s: Error reserving crashkernel low memblock.\n", __func__);
> -		return ret;
> -	}
> -
> -	pr_info("Reserving %ldMB of low memory at %ldMB for crashkernel (System low RAM: %ldMB)\n",
> +	pr_info("Reserving %ldMB of low memory at %ldMB for crashkernel (low RAM limit: %ldMB)\n",
>  		(unsigned long)(low_size >> 20),
>  		(unsigned long)(low_base >> 20),
> -		(unsigned long)(total_low_mem >> 20));
> +		(unsigned long)(low_mem_limit >> 20));
>  
>  	crashk_low_res.start = low_base;
>  	crashk_low_res.end   = low_base + low_size - 1;
> @@ -503,13 +497,13 @@ static void __init reserve_crashkernel(void)
>  		 * unless "crashkernel=size[KMG],high" is specified.
>  		 */
>  		if (!high)
> -			crash_base = memblock_find_in_range(CRASH_ALIGN,
> -						CRASH_ADDR_LOW_MAX,
> -						crash_size, CRASH_ALIGN);
> +			crash_base = memblock_phys_alloc_range(crash_size,
> +						CRASH_ALIGN, CRASH_ALIGN,
> +						CRASH_ADDR_LOW_MAX);
>  		if (!crash_base)
> -			crash_base = memblock_find_in_range(CRASH_ALIGN,
> -						CRASH_ADDR_HIGH_MAX,
> -						crash_size, CRASH_ALIGN);
> +			crash_base = memblock_phys_alloc_range(crash_size,
> +						CRASH_ALIGN, CRASH_ALIGN,
> +						CRASH_ADDR_HIGH_MAX);
>  		if (!crash_base) {
>  			pr_info("crashkernel reservation failed - No suitable area found.\n");
>  			return;
> @@ -517,19 +511,13 @@ static void __init reserve_crashkernel(void)
>  	} else {
>  		unsigned long long start;
>  
> -		start = memblock_find_in_range(crash_base,
> -					       crash_base + crash_size,
> -					       crash_size, 1 << 20);
> +		start = memblock_phys_alloc_range(crash_size, SZ_1M, crash_base,
> +						  crash_base + crash_size);
>  		if (start != crash_base) {
>  			pr_info("crashkernel reservation failed - memory is in use.\n");
>  			return;
>  		}
>  	}
> -	ret = memblock_reserve(crash_base, crash_size);
> -	if (ret) {
> -		pr_err("%s: Error reserving crashkernel memblock.\n", __func__);
> -		return;
> -	}
>  
>  	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low()) {
>  		memblock_free(crash_base, crash_size);
> -- 
> 2.26.2
> 
