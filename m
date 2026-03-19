Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD1C34D383;
	Thu, 19 Mar 2026 11:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773919927; cv=none; b=tT3P0G5jrBbULLe2CpQjR5o7VHizWdjW4hu2+YQ+H2vlXQ4R/43eHiNiMpPe+aQdMgaI0WHkKrSfo4lVieWzkwN8ZDZCVJNY1eMT/LdHuyt/frc17gc7iA2pNM2bH8q1ZO/Aj7yYLd/GeXXqE/E2dt7m1NY+mv+gWB2RuSiP5xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773919927; c=relaxed/simple;
	bh=ugQLkf+Im/G2ICHzfRRGmINpZCFsd5Ug2LKZKDtrCQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5gUOqtU8pTKvocLUG6kg+nJk2mnLkOt+KzG8RwjqifQtfQCKzvmWh2+0gfu5gECT4ZP7KVcTDDqDrCtZbGLoHCbapqFDlp8RPk5cHz+mednxb0Oc5tDE1aFhqKJwN9l47HtHZQA5kDHo7uWp0H2a+wYF3zHoQ86p/6vZPEbyoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2OyEQky; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2OyEQky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87ECBC19424;
	Thu, 19 Mar 2026 11:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773919926;
	bh=ugQLkf+Im/G2ICHzfRRGmINpZCFsd5Ug2LKZKDtrCQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X2OyEQkyM6gUfaXokm8qxkuv0WTQ10u+7Ts4unJj/PT1yGFvsITG7LB/Td5BC6kGR
	 kFrpofMPgQALPtj6R6PdXlViWz9aW87C/3LOV16eT02ve0oMBCkKvzVXVKrhF2MK+M
	 ljkDYbXZQ3ywYYxmHkIQigMocTVr+c+qn77LgA35CNdezZ0tk1MFeWl5oaPIyZEg+9
	 VphrsyzoEREy7BFbtc+/nj/sm3FQCeYEHDiNG3V2SIkxeqOf+iGj1ZEskGD9MDJkzt
	 CaE9smJJ38g5f7JqtzLcCFYJjDlVv5oq7rr2n6trUdfLlelwiW1/WeF+vw5SIetes6
	 YRHJNiULNqD4A==
Date: Thu, 19 Mar 2026 11:31:59 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, david@kernel.org, Liam.Howlett@oracle.com, 
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] mm: change to return bool for
 pmdp_test_and_clear_young()
Message-ID: <4cf8eac4-f601-4f39-8094-d904edbf454d@lucifer.local>
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
 <8025b898d0841a4bcbd766998959b4e2ae4d4abc.1773890510.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8025b898d0841a4bcbd766998959b4e2ae4d4abc.1773890510.git.baolin.wang@linux.alibaba.com>

On Thu, Mar 19, 2026 at 11:24:02AM +0800, Baolin Wang wrote:
> Callers use pmdp_test_and_clear_young() to clear the young flag and check
> whether it was set for this PMD entry. Change the return type to bool to
> make the intention clearer.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Some nits similar to before, otherwise LGTM so:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  arch/arm64/include/asm/pgtable.h             |  6 +++---
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 10 +++++-----
>  arch/powerpc/mm/book3s64/pgtable.c           |  4 ++--
>  arch/riscv/include/asm/pgtable.h             |  2 +-
>  arch/s390/include/asm/pgtable.h              |  4 ++--
>  arch/x86/include/asm/pgtable.h               |  4 ++--
>  arch/x86/mm/pgtable.c                        |  6 +++---
>  include/linux/pgtable.h                      | 19 +++++++++----------
>  8 files changed, 27 insertions(+), 28 deletions(-)
>
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 393a9d1873f6..7ea16f6ad564 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1321,9 +1321,9 @@ static inline bool __ptep_clear_flush_young(struct vm_area_struct *vma,
>
>  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG)
>  #define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
> -static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
> -					    unsigned long address,
> -					    pmd_t *pmdp)
> +static inline bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
> +					     unsigned long address,
> +					     pmd_t *pmdp)

Similar comment as before re: indetation, let's use 2 tabs please, so this would
become:

static inline bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
		unsigned long address, pmd_t *pmdp)

Thanks!

Same comment to all other cases here.

>  {
>  	/* Operation applies to PMD table entry only if FEAT_HAFT is enabled */
>  	VM_WARN_ON(pmd_table(READ_ONCE(*pmdp)) && !system_supports_haft());
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 25e3a86943e2..0f34011665a6 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -1161,13 +1161,13 @@ pud_hugepage_update(struct mm_struct *mm, unsigned long addr, pud_t *pudp,
>   * For radix we should always find H_PAGE_HASHPTE zero. Hence
>   * the below will work for radix too
>   */
> -static inline int __pmdp_test_and_clear_young(struct mm_struct *mm,
> -					      unsigned long addr, pmd_t *pmdp)
> +static inline bool __pmdp_test_and_clear_young(struct mm_struct *mm,
> +					       unsigned long addr, pmd_t *pmdp)
>  {
>  	unsigned long old;
>
>  	if ((pmd_raw(*pmdp) & cpu_to_be64(_PAGE_ACCESSED | H_PAGE_HASHPTE)) == 0)
> -		return 0;
> +		return false;
>  	old = pmd_hugepage_update(mm, addr, pmdp, _PAGE_ACCESSED, 0);
>  	return ((old & _PAGE_ACCESSED) != 0);
>  }
> @@ -1300,8 +1300,8 @@ extern int pudp_set_access_flags(struct vm_area_struct *vma,
>  				 pud_t entry, int dirty);
>
>  #define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
> -extern int pmdp_test_and_clear_young(struct vm_area_struct *vma,
> -				     unsigned long address, pmd_t *pmdp);
> +extern bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
> +				      unsigned long address, pmd_t *pmdp);

Remove the extern please!

>  #define __HAVE_ARCH_PUDP_TEST_AND_CLEAR_YOUNG
>  extern int pudp_test_and_clear_young(struct vm_area_struct *vma,
>  				     unsigned long address, pud_t *pudp);
> diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
> index 4b09c04654a8..aed39bba891e 100644
> --- a/arch/powerpc/mm/book3s64/pgtable.c
> +++ b/arch/powerpc/mm/book3s64/pgtable.c
> @@ -98,8 +98,8 @@ int pudp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
>  }
>
>
> -int pmdp_test_and_clear_young(struct vm_area_struct *vma,
> -			      unsigned long address, pmd_t *pmdp)
> +bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
> +			       unsigned long address, pmd_t *pmdp)
>  {
>  	return __pmdp_test_and_clear_young(vma->vm_mm, address, pmdp);
>  }
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 11f57ccf6dc9..bac559d29036 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -1015,7 +1015,7 @@ static inline int pmdp_set_access_flags(struct vm_area_struct *vma,
>  }
>
>  #define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
> -static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
> +static inline bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
>  					unsigned long address, pmd_t *pmdp)
>  {
>  	return ptep_test_and_clear_young(vma, address, (pte_t *)pmdp);
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index c9ab81caaf75..1f5efb7be71d 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -1683,8 +1683,8 @@ static inline int pmdp_set_access_flags(struct vm_area_struct *vma,
>  }
>
>  #define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
> -static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
> -					    unsigned long addr, pmd_t *pmdp)
> +static inline bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
> +					     unsigned long addr, pmd_t *pmdp)
>  {
>  	pmd_t pmd = *pmdp;
>
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 554dea93eb99..bd02ee730a23 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1295,8 +1295,8 @@ extern int pudp_set_access_flags(struct vm_area_struct *vma,
>  				 pud_t entry, int dirty);
>
>  #define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
> -extern int pmdp_test_and_clear_young(struct vm_area_struct *vma,
> -				     unsigned long addr, pmd_t *pmdp);
> +extern bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
> +				      unsigned long addr, pmd_t *pmdp);

Remove the extern please!

>  extern int pudp_test_and_clear_young(struct vm_area_struct *vma,
>  				     unsigned long addr, pud_t *pudp);
>
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index 0007dc3d739e..10a5e0b2be36 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -456,10 +456,10 @@ bool ptep_test_and_clear_young(struct vm_area_struct *vma,
>  }
>
>  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG)
> -int pmdp_test_and_clear_young(struct vm_area_struct *vma,
> -			      unsigned long addr, pmd_t *pmdp)
> +bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
> +			       unsigned long addr, pmd_t *pmdp)
>  {
> -	int ret = 0;
> +	bool ret = false;
>
>  	if (pmd_young(*pmdp))
>  		ret = test_and_clear_bit(_PAGE_BIT_ACCESSED,
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 1198e216fde3..e53220b0a9a3 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -507,25 +507,24 @@ static inline bool ptep_test_and_clear_young(struct vm_area_struct *vma,
>
>  #ifndef __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
>  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG)
> -static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
> -					    unsigned long address,
> -					    pmd_t *pmdp)
> +static inline bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
> +		unsigned long address, pmd_t *pmdp)
>  {
>  	pmd_t pmd = *pmdp;
> -	int r = 1;
> +	bool young = true;
> +
>  	if (!pmd_young(pmd))
> -		r = 0;
> +		young = false;
>  	else
>  		set_pmd_at(vma->vm_mm, address, pmdp, pmd_mkold(pmd));
> -	return r;
> +	return young;
>  }
>  #else
> -static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
> -					    unsigned long address,
> -					    pmd_t *pmdp)
> +static inline bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
> +		unsigned long address, pmd_t *pmdp)
>  {
>  	BUILD_BUG();
> -	return 0;
> +	return false;
>  }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG */
>  #endif
> --
> 2.47.3
>
