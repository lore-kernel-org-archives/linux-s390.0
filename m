Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FA419C546;
	Thu, 19 Mar 2026 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773920061; cv=none; b=ZQHbQmirC06RMsr6QzMpxWhZIi39IN8J5uoHeaowCvsfQU9RViTpFbGlN66xOUOnYxfAWyr3Vx5RnpanhWUTIvqz5sQKaV90QXxhIKzxdsVoHkeFCBh557kl87JxpGCPGTqlOdcqnNEbE9N2FGxODcLhFG9SL66VcdUEKM5dUmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773920061; c=relaxed/simple;
	bh=vGPmcqAhZCk0gdlr+wYCcpNO1tqWQw2RngJu1gW9hIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2/43gs8JRTlHaoI51xwWQbQmebdI0v6j2pLa05IwBNyS04Bz6dRxOQSpz5b+WTLSQN7G9I2sNbh3r0lONbzhL5UY9l8eS8zb5HUN90U2qli37IyAr4+q0lO3wSgkINYjsRQgB2QheYKfVU31RZx4s4fQHeouOZ4CnscGgMcVr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXR9V298; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXR9V298"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5F2C2BCB0;
	Thu, 19 Mar 2026 11:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773920061;
	bh=vGPmcqAhZCk0gdlr+wYCcpNO1tqWQw2RngJu1gW9hIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HXR9V298CpUtMI8uiUfzgXIhpTXpgltg84qzhP5tYL999s9u38RdIf5/+znO/AKE1
	 nqdW9Kq54pTvI4cGRFD2fUy4wjnBRVN+hAoSlkhQipxY5QwpDm0qw/h962PSLEsbLR
	 v6RwuOsIJQst5wZaS5ybKMq5k9XUSGo1qyD2DHzUbCEZzYDzvgPHeP/Dx+E4/aQnpy
	 yVeQFdy4I9jGYcI7u2KCScFjvcb5MeSUYYiTwA5vTmdH/rrgzTC2wcNRsJt4VgQH5M
	 eNJt8KcZbP8/OhTnGatWrUV8VPU4EftxdWW/1OF1NI646J0TpK4aNS9v3S1zz09OW3
	 LuZU7ah4P9Amg==
Date: Thu, 19 Mar 2026 11:34:14 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, david@kernel.org, Liam.Howlett@oracle.com, 
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] mm: change to return bool for
 pudp_test_and_clear_young()
Message-ID: <522588b0-1172-4cc6-9011-f077e94011df@lucifer.local>
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
 <2711ec4bf6c30182004e34027fb31a2e8e24749e.1773890510.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2711ec4bf6c30182004e34027fb31a2e8e24749e.1773890510.git.baolin.wang@linux.alibaba.com>

On Thu, Mar 19, 2026 at 11:24:04AM +0800, Baolin Wang wrote:
> The pudp_test_and_clear_young() is used to clear the young flag,
> returning whether the young flag was set for this PUD entry. Change
> the return type to bool to make the intention clearer.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Some nits but otherwise loogs good so:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 10 +++++-----
>  arch/powerpc/mm/book3s64/pgtable.c           |  4 ++--
>  arch/riscv/include/asm/pgtable.h             |  4 ++--
>  arch/x86/include/asm/pgtable.h               |  4 ++--
>  arch/x86/mm/pgtable.c                        |  6 +++---
>  5 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 0f34011665a6..083c4b9ed5b3 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -1172,13 +1172,13 @@ static inline bool __pmdp_test_and_clear_young(struct mm_struct *mm,
>  	return ((old & _PAGE_ACCESSED) != 0);
>  }
>
> -static inline int __pudp_test_and_clear_young(struct mm_struct *mm,
> -					      unsigned long addr, pud_t *pudp)
> +static inline bool __pudp_test_and_clear_young(struct mm_struct *mm,
> +					       unsigned long addr, pud_t *pudp)

Formatting yada yada you know the drill, 2 tabs etc. :))

>  {
>  	unsigned long old;
>
>  	if ((pud_raw(*pudp) & cpu_to_be64(_PAGE_ACCESSED | H_PAGE_HASHPTE)) == 0)
> -		return 0;
> +		return false;
>  	old = pud_hugepage_update(mm, addr, pudp, _PAGE_ACCESSED, 0);
>  	return ((old & _PAGE_ACCESSED) != 0);
>  }
> @@ -1303,8 +1303,8 @@ extern int pudp_set_access_flags(struct vm_area_struct *vma,
>  extern bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
>  				      unsigned long address, pmd_t *pmdp);
>  #define __HAVE_ARCH_PUDP_TEST_AND_CLEAR_YOUNG
> -extern int pudp_test_and_clear_young(struct vm_area_struct *vma,
> -				     unsigned long address, pud_t *pudp);
> +extern bool pudp_test_and_clear_young(struct vm_area_struct *vma,
> +				      unsigned long address, pud_t *pudp);

Drop the extern please!

>
>
>  #define __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
> diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
> index aed39bba891e..838cb4a8e2cf 100644
> --- a/arch/powerpc/mm/book3s64/pgtable.c
> +++ b/arch/powerpc/mm/book3s64/pgtable.c
> @@ -104,8 +104,8 @@ bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
>  	return __pmdp_test_and_clear_young(vma->vm_mm, address, pmdp);
>  }
>
> -int pudp_test_and_clear_young(struct vm_area_struct *vma,
> -			      unsigned long address, pud_t *pudp)
> +bool pudp_test_and_clear_young(struct vm_area_struct *vma,
> +			       unsigned long address, pud_t *pudp)
>  {
>  	return __pudp_test_and_clear_young(vma->vm_mm, address, pudp);
>  }
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index bac559d29036..88fa63186ca5 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -1109,8 +1109,8 @@ static inline int pudp_set_access_flags(struct vm_area_struct *vma,
>  	return ptep_set_access_flags(vma, address, (pte_t *)pudp, pud_pte(entry), dirty);
>  }
>
> -static inline int pudp_test_and_clear_young(struct vm_area_struct *vma,
> -					    unsigned long address, pud_t *pudp)
> +static inline bool pudp_test_and_clear_young(struct vm_area_struct *vma,
> +					     unsigned long address, pud_t *pudp)
>  {
>  	return ptep_test_and_clear_young(vma, address, (pte_t *)pudp);
>  }
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index f9439449c9bd..6ca1fdd25191 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1297,8 +1297,8 @@ extern int pudp_set_access_flags(struct vm_area_struct *vma,
>  #define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
>  extern bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
>  				      unsigned long addr, pmd_t *pmdp);
> -extern int pudp_test_and_clear_young(struct vm_area_struct *vma,
> -				     unsigned long addr, pud_t *pudp);
> +extern bool pudp_test_and_clear_young(struct vm_area_struct *vma,
> +				      unsigned long addr, pud_t *pudp);

Drop the extern please!

>
>  #define __HAVE_ARCH_PMDP_CLEAR_YOUNG_FLUSH
>  extern bool pmdp_clear_flush_young(struct vm_area_struct *vma,
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index 8c336edf0e65..2677dcf0bbce 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -470,10 +470,10 @@ bool pmdp_test_and_clear_young(struct vm_area_struct *vma,
>  #endif
>
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -int pudp_test_and_clear_young(struct vm_area_struct *vma,
> -			      unsigned long addr, pud_t *pudp)
> +bool pudp_test_and_clear_young(struct vm_area_struct *vma,
> +			       unsigned long addr, pud_t *pudp)
>  {
> -	int ret = 0;
> +	bool ret = false;
>
>  	if (pud_young(*pudp))
>  		ret = test_and_clear_bit(_PAGE_BIT_ACCESSED,
> --
> 2.47.3
>
