Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6047122F767;
	Fri, 13 Jun 2025 10:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749810746; cv=none; b=tOx+F3dUgencnCQcl/6q3aS/Oh8Spn3sKLBU4C96DbXLAPmzESF2jk05SbmDGDJEqqR3V9Ze/LJl2DfU2dYdvUtlzUexExie/D0sob0Wt6Ejz+zf0K21KErWhTyPGznZ2eCnib7JOn/TyRmWVfcCU0EuRqzKe9VPvlTyyyjFSGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749810746; c=relaxed/simple;
	bh=IktqxgkhvmBKeCJtPqtfyuSdk/dvJscRN+UmlbcMLWM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmr/Js27erIlxGgbYQGu6TKTWn+eRajlht+nvm950N5I/yaGVJj2bggNHItUKCsi7oQp5w1BHTYjl2efr6RjysDg4NACesD/KnhpBTtfoeVe/YeI6a4vIx8eb+P19yxOeVzMbCXr2BM8Ptzvx51J2ecrdS2Rzw7FHKxHzINOzaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ar9tLsdL; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ar9tLsdL"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-310447fe59aso19511081fa.0;
        Fri, 13 Jun 2025 03:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749810741; x=1750415541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wu4qJvn4Llwk0tWZQ65fBk0n6CvVyWDwwMQQPjhEpAs=;
        b=ar9tLsdL8e2q1OqzyqhO6Bggu2U6CtSq2QoD85Mxgn7/6jc47diTpzI1Uk+93YqX3q
         OYCwcagkFYWGYsEReGmSV3bWmB0oHktxPlbtktl7wLb9+1RNegvIi87PzTaiK17jzawU
         a5aGkBjjUGP3pgARXCl5sXp8E096zCm7EksBP+7/o1ZO8Ber/gSc2y/dsYKVM84T9d4i
         RrTWYhat0I1N4So1LW+l2rJ6n041P5pFF9CrQp0J2et4r511kO3AOCDZK2G3vviY+g/E
         NCSnngMMDBiHmt7OozCqAzqFHBrsU80tf/dGRQ1r5pCsDbMw6mar/PXp7Y2PwlkC1q+5
         3M7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749810741; x=1750415541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wu4qJvn4Llwk0tWZQ65fBk0n6CvVyWDwwMQQPjhEpAs=;
        b=abkMRPLeoq69IHtwgr8vk9eNI8PZUl0y/GBV/V/bc6H2onR94JLrKmsjmbSlr0Gd93
         65fuZnFzYaq2BITyWBtw1rxtOwcTqwJAXLawANu8AI/MmXjECWUzoTT+lpKNWi/i+e7r
         EPDZLlOZehFF+br+2Ef9kAOkAzsr7W98GG9tTkzKH6gAgQ5YLsCZlmvjpxuG8W8+SpUk
         RmBi938kUSjXbPWdzRdgP7s+M1J5LnCtx2QbQNaADu8S5JHXgefGK/Jxmygqrl5sdjmB
         N+AvuH/PUjPx7Eq27OUM9n0aM1K4AtpPIoi0OzC2RqiqJIx7fqRPa0v2DGusdJWm7+YO
         mE2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0PxhHVj+1aXogoS+OpzkZjGr/6nDy5MBv7H74EUYOgaIMRyMWGVsFdmuQMSuyl11WP7hRyLCq6mT2hA==@vger.kernel.org, AJvYcCVn7jplKibjdQ31XcaABIx/1uTl1ywtdF9qdh/S2IFk5wxOQs4q6HwVaztzFGtWNLf/mv+sKUWmnfDzr94=@vger.kernel.org, AJvYcCWQ2YR6ZPSN2m15H9fx70UxC44OqLqVvUa+g4aDAeMWzODpYorrpov6wOqaFirsjOo0JnFeJ6lhvXONIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWAFURmNrLu77PoWugD43qf5PwailhRtfBLHC0OXhbStUdxJiy
	DGvZ1g0sBeSFI+KHtUcwmKuaN9IVnC7EQIPTbM/E09PZo4yhcr5rqi1sUvvAcYPt
X-Gm-Gg: ASbGncsWFJb+JR+HBzHf5YJccNCQOMFt78mjkP+pzKpZ0IGNU20slc3Hqm87LUk1e+h
	Tf+6uQktF0HWRbBzBOF8COyyRkCQGb9ORxDRqZckl9QkJTj31wsPmQ2u//1/kI1Dy62m+/i/mEd
	HpZm4gxJ49uBwq55YdZzVzfQDTvOpUbvQVn+GyQWzKLLIUJQq4RcL1Mrn3bRa1KpJrqchSxqstF
	FHE29DwITt5RlvKrC68LmVk97qhZNmdPDi2pNs6PTQZV0ZTybVXb3jhQVHcDvNQjfRxbNz4o9ag
	AIluOWU3ZeliPRH3GehHJSpKoFUC3XMrDD0QNRLVjqqTCSlWwS+eXwSh8q6XoJe1j9dbH8H5gkF
	IIWuQEEDREBs=
X-Google-Smtp-Source: AGHT+IH9UJ7uFj1fdsdkfO2A9iWrTLeLn4U5mol1YXw4WzFM5kRsgurhm6wsyckaQjO11Dn5eJdcbA==
X-Received: by 2002:a05:6512:3b06:b0:553:a3e7:812e with SMTP id 2adb3069b0e04-553af90817dmr681078e87.20.1749810730193;
        Fri, 13 Jun 2025 03:32:10 -0700 (PDT)
Received: from pc636 (host-95-203-1-180.mobileonline.telia.com. [95.203.1.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac1dc3absm402194e87.197.2025.06.13.03.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:32:09 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 13 Jun 2025 12:32:06 +0200
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, sparclinux@vger.kernel.org,
	xen-devel@lists.xenproject.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, Hugh Dickins <hughd@google.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>, Juergen Gross <jgross@suse.com>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH 2/6] mm: Lock kernel page tables before entering lazy MMU
 mode
Message-ID: <aEv-JjY4lUPNqyjZ@pc636>
References: <cover.1749747752.git.agordeev@linux.ibm.com>
 <7bd3a45dbc375dc2c15cebae09cb2bb972d6039f.1749747752.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bd3a45dbc375dc2c15cebae09cb2bb972d6039f.1749747752.git.agordeev@linux.ibm.com>

On Thu, Jun 12, 2025 at 07:36:09PM +0200, Alexander Gordeev wrote:
> As a follow-up to commit 691ee97e1a9d ("mm: fix lazy mmu docs and
> usage") take a step forward and protect with a lock not only user,
> but also kernel mappings before entering the lazy MMU mode. With
> that the semantics of arch_enter|leave_lazy_mmu_mode() callbacks
> is consolidated, which allows further simplifications.
> 
> The effect of this consolidation is not fully preemptible (Real-Time)
> kernels can not enter the context switch while the lazy MMU mode is
> active - which is easier to comprehend.
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  include/linux/pgtable.h | 12 ++++++------
>  mm/kasan/shadow.c       |  5 -----
>  mm/memory.c             |  5 ++++-
>  mm/vmalloc.c            |  6 ++++++
>  4 files changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 0b6e1f781d86..33bf2b13c219 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -224,12 +224,12 @@ static inline int pmd_dirty(pmd_t pmd)
>   * a raw PTE pointer after it has been modified are not guaranteed to be
>   * up to date.
>   *
> - * In the general case, no lock is guaranteed to be held between entry and exit
> - * of the lazy mode. So the implementation must assume preemption may be enabled
> - * and cpu migration is possible; it must take steps to be robust against this.
> - * (In practice, for user PTE updates, the appropriate page table lock(s) are
> - * held, but for kernel PTE updates, no lock is held). Nesting is not permitted
> - * and the mode cannot be used in interrupt context.
> + * For PREEMPT_RT kernels implementation must assume that preemption may
> + * be enabled and cpu migration is possible between entry and exit of the
> + * lazy MMU mode; it must take steps to be robust against this. There is
> + * no such assumption for non-PREEMPT_RT kernels, since both kernel and
> + * user page tables are protected with a spinlock while in lazy MMU mode.
> + * Nesting is not permitted and the mode cannot be used in interrupt context.
>   */
>  #ifndef __HAVE_ARCH_ENTER_LAZY_MMU_MODE
>  #define arch_enter_lazy_mmu_mode()	do {} while (0)
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index d2c70cd2afb1..45115bd770a9 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -313,12 +313,10 @@ static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
>  	__memset(page_to_virt(page), KASAN_VMALLOC_INVALID, PAGE_SIZE);
>  	pte = pfn_pte(page_to_pfn(page), PAGE_KERNEL);
>  
> -	spin_lock(&init_mm.page_table_lock);
>  	if (likely(pte_none(ptep_get(ptep)))) {
>  		set_pte_at(&init_mm, addr, ptep, pte);
>  		data->pages[index] = NULL;
>  	}
> -	spin_unlock(&init_mm.page_table_lock);
>  
>  	return 0;
>  }
> @@ -465,13 +463,10 @@ static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
>  
>  	page = (unsigned long)__va(pte_pfn(ptep_get(ptep)) << PAGE_SHIFT);
>  
> -	spin_lock(&init_mm.page_table_lock);
> -
>  	if (likely(!pte_none(ptep_get(ptep)))) {
>  		pte_clear(&init_mm, addr, ptep);
>  		free_page(page);
>  	}
> -	spin_unlock(&init_mm.page_table_lock);
>  
>  	return 0;
>  }
> diff --git a/mm/memory.c b/mm/memory.c
> index 71b3d3f98999..1ddc532b1f13 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3017,6 +3017,7 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
>  			pte = pte_offset_kernel(pmd, addr);
>  		if (!pte)
>  			return err;
> +		spin_lock(&init_mm.page_table_lock);
>  	} else {
>  		if (create)
>  			pte = pte_alloc_map_lock(mm, pmd, addr, &ptl);
> @@ -3042,7 +3043,9 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
>  
>  	arch_leave_lazy_mmu_mode();
>  
> -	if (mm != &init_mm)
> +	if (mm == &init_mm)
> +		spin_unlock(&init_mm.page_table_lock);
> +	else
>  		pte_unmap_unlock(mapped_pte, ptl);
>  
>  	*mask |= PGTBL_PTE_MODIFIED;
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ab986dd09b6a..57b11000ae36 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -105,6 +105,7 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>  	if (!pte)
>  		return -ENOMEM;
>  
> +	spin_lock(&init_mm.page_table_lock);
>
This is not good. We introduce another bottle-neck.

--
Uladzislau Rezki
