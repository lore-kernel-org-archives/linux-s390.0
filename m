From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Mon, 05 Jan 2015 08:57:28 +0000
Subject: Re: enabling kvm w/SPLIT_PTLOCK_CPUS > NR_CPUS fails to build in pgtable.c
Message-Id: <20150105095728.11b1981e@mschwide>
In-Reply-To: <20150102103136.GB4059@osiris>
References: <20150102103136.GB4059@osiris>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 2 Jan 2015 11:31:36 +0100
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> On Wed, Dec 31, 2014 at 12:56:59AM -0500, Mike Frysinger wrote:
> > i've configured my kernel to have:
> > 	CONFIG_KVM=y
> > 	CONFIG_NR_CPUS=2
> > 	CONFIG_SPLIT_PTLOCK_CPUS=4
> > 
> > and that makes the build very unhappy:
> > 	  CC      arch/s390/mm/pgtable.o
> > 	arch/s390/mm/pgtable.c: In function ���__gmap_segment_gaddr���:
> > 	arch/s390/mm/pgtable.c:327:2: error: implicit declaration of function 
> > 	���pmd_to_page��� [-Werror=implicit-function-declaration]
> > 	  page = pmd_to_page((pmd_t *) entry);
> > 	  ^
> > 
> > this is because include/linux/mm_types.h has:
> > 	#define USE_SPLIT_PMD_PTLOCKS	(USE_SPLIT_PTE_PTLOCKS && \
> > 			IS_ENABLED(CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK))
> > 
> > and include/linux/mm.h has:
> > 	#if USE_SPLIT_PMD_PTLOCKS
> > 	static struct page *pmd_to_page(pmd_t *pmd)
> > 	...
> > 
> > i did set NR_CPUS down on purpose (this system only has two cpus), but 
> > apparently tweaking SPLIT_PTLOCK_CPUS isn't an option :).  in mm/Kconfig:
> > 	config SPLIT_PTLOCK_CPUS
> > 		int
> > 		default "4"
> > -mike
> 
> Thanks for reporting. The patch below should fix it (adding Martin to To:)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f80d0194c9bc..4ee25aea7861 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1555,14 +1555,14 @@ static inline void pgtable_page_dtor(struct page *page)
>  	((unlikely(pmd_none(*(pmd))) && __pte_alloc_kernel(pmd, address))? \
>  		NULL: pte_offset_kernel(pmd, address))
> 
> -#if USE_SPLIT_PMD_PTLOCKS
> -
> -static struct page *pmd_to_page(pmd_t *pmd)
> +static inline struct page *pmd_to_page(pmd_t *pmd)
>  {
>  	unsigned long mask = ~(PTRS_PER_PMD * sizeof(pmd_t) - 1);
>  	return virt_to_page((void *)((unsigned long) pmd & mask));
>  }
> 
> +#if USE_SPLIT_PMD_PTLOCKS
> +
>  static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
>  {
>  	return ptlock_ptr(pmd_to_page(pmd));

That looks good, there is no reason why the pmd_to_page helper should be
conditional on the USE_SPLIT_PMD_PTLOCKS define.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
