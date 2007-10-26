Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [patch 2/6] CONFIG_HIGHPTE vs. sub-page page tables.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <1193345221.7018.18.camel@pasglop>
References: <20071025181520.880272069@de.ibm.com>
	 <20071025181901.212545095@de.ibm.com>  <1193345221.7018.18.camel@pasglop>
Content-Type: text/plain
Date: Fri, 26 Oct 2007 10:06:31 +0200
Message-Id: <1193385991.31831.11.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: benh@kernel.crashing.org
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

> @@ -107,20 +107,21 @@ __init_refok pte_t *pte_alloc_one_kernel
>  	return pte;
>  }
>  
> -struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
> +pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
>  {
>  	struct page *ptepage;
>  
>  #ifdef CONFIG_HIGHPTE
> -	gfp_t flags = GFP_KERNEL | __GFP_HIGHMEM | __GFP_REPEAT;
> +	gfp_t flags = GFP_KERNEL | __GFP_HIGHMEM | __GFP_REPEAT | __GFP_ZERO;
>  #else
> -	gfp_t flags = GFP_KERNEL | __GFP_REPEAT;
> +	gfp_t flags = GFP_KERNEL | __GFP_REPEAT | __GFP_ZERO;
>  #endif
>  
>  	ptepage = alloc_pages(flags, 0);
> -	if (ptepage)
> -		clear_highpage(ptepage);
> -	return ptepage;
> +	if (!ptepage)
> +		return NULL;
> +	pgtable_page_ctor(ptepage);
> +	return page_address(ptepage);
>  }
>  
> void pte_free_kernel(struct mm_struct *mm, pte_t *pte)

Hmpf, where is my brown paper bag? The pte_alloc_one function for 32 bit
powerpc should better return a struct page pointer .. fix below.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.

---

diff -urpN linux-2.6/arch/powerpc/mm/pgtable_32.c linux-2.6-patched/arch/powerpc/mm/pgtable_32.c
--- linux-2.6/arch/powerpc/mm/pgtable_32.c	2007-10-26 09:38:30.000000000 +0200
+++ linux-2.6-patched/arch/powerpc/mm/pgtable_32.c	2007-10-26 10:01:10.000000000 +0200
@@ -121,7 +121,7 @@ pgtable_t pte_alloc_one(struct mm_struct
 	if (!ptepage)
 		return NULL;
 	pgtable_page_ctor(ptepage);
-	return page_address(ptepage);
+	return ptepage;
 }
 
 void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
