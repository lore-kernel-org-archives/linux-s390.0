Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774A927280D;
	Fri, 13 Jun 2025 08:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749804065; cv=none; b=SgcQ+kvPPGw7QtG63Rq2LVcFzLDy1x0hkDO0lFbVyFBN/iGSnRU1Wli4j1HUmzpdsOUpNORHnN5+3ediQ+DX97kyQ+ZRQ4lcT2FG+IsPCEmp74DConXkO8MUuj09GDZ8jlGX6P/YYA8CyabQWutVCAbw3niagWneDl9x7n0F99E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749804065; c=relaxed/simple;
	bh=1vbWYN+GhwXsjrdnlis6Sci0aA4eEwyl2lxh0M7iuy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YQUQXdz9xs1SOycNC2Y7xZ9LwQ0u/SEdHAn1bhkotGkxnhD1B/SkhmVjKhQVJjSvB09XfYacdjfNx4kYj1Ue2v8HmZgbSSvPlOUEeZ2dF6Pvy4qHmxlzTjsV0Gu4/PrwhYAvbSjVru6qMkf01LPrvpzCUlaCfa+CTjrWGFTih+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C1C41CDD;
	Fri, 13 Jun 2025 01:40:42 -0700 (PDT)
Received: from [10.57.84.117] (unknown [10.57.84.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DA213F66E;
	Fri, 13 Jun 2025 01:41:00 -0700 (PDT)
Message-ID: <0ba9820d-f498-42b0-a663-6f4dca5374b4@arm.com>
Date: Fri, 13 Jun 2025 09:40:58 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] sparc/mm: Do not disable preemption in lazy MMU mode
Content-Language: en-GB
To: Alexander Gordeev <agordeev@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 Hugh Dickins <hughd@google.com>, Nicholas Piggin <npiggin@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>, Juergen Gross <jgross@suse.com>,
 Jeremy Fitzhardinge <jeremy@goop.org>
References: <cover.1749747752.git.agordeev@linux.ibm.com>
 <db1559396c38c1dfe97a6d929412d7d6244f64b8.1749747752.git.agordeev@linux.ibm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <db1559396c38c1dfe97a6d929412d7d6244f64b8.1749747752.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/06/2025 18:36, Alexander Gordeev wrote:
> Commit a1d416bf9faf ("sparc/mm: disable preemption in lazy mmu mode")
> is not necessary anymore, since the lazy MMU mode is entered with a
> spinlock held and sparc does not support Real-Time. Thus, upon entering
> the lazy mode the preemption is already disabled.

Surely given Sparc knows that it doesn't support PREEMPT_RT, it is better for
it's implementation to explicitly disable preemption rather than rely on the
spinlock to do it, since the spinlock penalizes other arches unnecessarily? It
also prevents multiple CPUs from updating (different areas of) kernel pgtables
in parallel. The property Sparc needs is for the task to stay on the same CPU
without interruption, right? Same goes for powerpc.

> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  arch/sparc/include/asm/tlbflush_64.h |  2 +-
>  arch/sparc/mm/tlb.c                  | 12 ++++++++----
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/tlbflush_64.h b/arch/sparc/include/asm/tlbflush_64.h
> index 8b8cdaa69272..a6d8068fb211 100644
> --- a/arch/sparc/include/asm/tlbflush_64.h
> +++ b/arch/sparc/include/asm/tlbflush_64.h
> @@ -44,7 +44,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end);
>  void flush_tlb_pending(void);
>  void arch_enter_lazy_mmu_mode(void);
>  void arch_leave_lazy_mmu_mode(void);
> -#define arch_flush_lazy_mmu_mode()      do {} while (0)
> +void arch_flush_lazy_mmu_mode(void);
>  
>  /* Local cpu only.  */
>  void __flush_tlb_all(void);
> diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
> index a35ddcca5e76..e46dfd5f2583 100644
> --- a/arch/sparc/mm/tlb.c
> +++ b/arch/sparc/mm/tlb.c
> @@ -52,10 +52,9 @@ void flush_tlb_pending(void)
>  
>  void arch_enter_lazy_mmu_mode(void)
>  {
> -	struct tlb_batch *tb;
> +	struct tlb_batch *tb = this_cpu_ptr(&tlb_batch);
>  
> -	preempt_disable();
> -	tb = this_cpu_ptr(&tlb_batch);
> +	VM_WARN_ON_ONCE(preemptible());
>  	tb->active = 1;
>  }
>  
> @@ -63,10 +62,15 @@ void arch_leave_lazy_mmu_mode(void)
>  {
>  	struct tlb_batch *tb = this_cpu_ptr(&tlb_batch);
>  
> +	VM_WARN_ON_ONCE(preemptible());
>  	if (tb->tlb_nr)
>  		flush_tlb_pending();
>  	tb->active = 0;
> -	preempt_enable();
> +}
> +
> +void arch_flush_lazy_mmu_mode(void)
> +{
> +	VM_WARN_ON_ONCE(preemptible());
>  }
>  
>  static void tlb_batch_add_one(struct mm_struct *mm, unsigned long vaddr,

