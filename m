Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhBAMKo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 1 Feb 2021 07:10:44 -0500
Date: Mon, 1 Feb 2021 13:09:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC 11/20] mm/tlb: remove arch-specific tlb_start/end_vma()
Message-ID: <YBfvh1Imz6RRTUDV@hirez.programming.kicks-ass.net>
References: <20210131001132.3368247-1-namit@vmware.com>
 <20210131001132.3368247-12-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210131001132.3368247-12-namit@vmware.com>
List-ID: <linux-s390.vger.kernel.org>
To: Nadav Amit <nadav.amit@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>, Nick Piggin <npiggin@gmail.com>, linux-csky@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, x86@kernel.org

On Sat, Jan 30, 2021 at 04:11:23PM -0800, Nadav Amit wrote:

> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 427bfcc6cdec..b97136b7010b 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -334,8 +334,8 @@ static inline void __tlb_reset_range(struct mmu_gather *tlb)
>  
>  #ifdef CONFIG_MMU_GATHER_NO_RANGE
>  
> -#if defined(tlb_flush) || defined(tlb_start_vma) || defined(tlb_end_vma)
> -#error MMU_GATHER_NO_RANGE relies on default tlb_flush(), tlb_start_vma() and tlb_end_vma()
> +#if defined(tlb_flush)
> +#error MMU_GATHER_NO_RANGE relies on default tlb_flush()
>  #endif
>  
>  /*
> @@ -362,10 +362,6 @@ static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vm
>  
>  #ifndef tlb_flush
>  
> -#if defined(tlb_start_vma) || defined(tlb_end_vma)
> -#error Default tlb_flush() relies on default tlb_start_vma() and tlb_end_vma()
> -#endif

#ifdef CONFIG_ARCH_WANT_AGGRESSIVE_TLB_FLUSH_BATCHING
#error ....
#endif

goes here...


>  static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
>  {
>  	if (tlb->fullmm)
>  		return;
>  
> +	if (IS_ENABLED(CONFIG_ARCH_WANT_AGGRESSIVE_TLB_FLUSH_BATCHING))
> +		return;

Also, can you please stick to the CONFIG_MMU_GATHER_* namespace?

I also don't think AGRESSIVE_FLUSH_BATCHING quite captures what it does.
How about:

	CONFIG_MMU_GATHER_NO_PER_VMA_FLUSH

?
