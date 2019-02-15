Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Subject: Re: [PATCH v3] hugetlb: allow to free gigantic pages regardless of
 the configuration
References: <20190214193100.3529-1-alex@ghiti.fr>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <c6d9be5f-3b3a-c95b-0045-9f98ea52a5c4@intel.com>
Date: Fri, 15 Feb 2019 09:34:24 -0800
MIME-Version: 1.0
In-Reply-To: <20190214193100.3529-1-alex@ghiti.fr>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: Alexandre Ghiti <alex@ghiti.fr>, Vlastimil Babka <vbabka@suse.cz>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Mike Kravetz <mike.kravetz@oracle.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
List-ID: <linux-s390.vger.kernel.org>

> -#if (defined(CONFIG_MEMORY_ISOLATION) && defined(CONFIG_COMPACTION)) || defined(CONFIG_CMA)
> +#ifdef CONFIG_CONTIG_ALLOC
>  /* The below functions must be run on a range from a single zone. */
>  extern int alloc_contig_range(unsigned long start, unsigned long end,
>  			      unsigned migratetype, gfp_t gfp_mask);
> -extern void free_contig_range(unsigned long pfn, unsigned nr_pages);
>  #endif
> +extern void free_contig_range(unsigned long pfn, unsigned int nr_pages);

There's a lot of stuff going on in this patch.  Adding/removing config
options.  Please get rid of these superfluous changes or at least break
them out.

>  #ifdef CONFIG_CMA
>  /* CMA stuff */
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 25c71eb8a7db..138a8df9b813 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -252,12 +252,17 @@ config MIGRATION
>  	  pages as migration can relocate pages to satisfy a huge page
>  	  allocation instead of reclaiming.
>  
> +
>  config ARCH_ENABLE_HUGEPAGE_MIGRATION
>  	bool

Like this. :)

>  config ARCH_ENABLE_THP_MIGRATION
>  	bool
>  
> +config CONTIG_ALLOC
> +	def_bool y
> +	depends on (MEMORY_ISOLATION && COMPACTION) || CMA
> +
>  config PHYS_ADDR_T_64BIT
>  	def_bool 64BIT

Please think carefully though the Kconfig dependencies.  'select' is
*not* the same as 'depends on'.

This replaces a bunch of arch-specific "select ARCH_HAS_GIGANTIC_PAGE"
with a 'depends on'.  I *think* that ends up being OK, but it absolutely
needs to be addressed in the changelog about why *you* think it is OK
and why it doesn't change the functionality of any of the patched
architetures.

> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index afef61656c1e..e686c92212e9 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1035,7 +1035,6 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
>  		((node = hstate_next_node_to_free(hs, mask)) || 1);	\
>  		nr_nodes--)
>  
> -#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
>  static void destroy_compound_gigantic_page(struct page *page,
>  					unsigned int order)
>  {

Whats the result of this #ifdef removal?  A universally larger kernel
even for architectures that do not support runtime gigantic page
alloc/free?  That doesn't seem like a good thing.

> @@ -1058,6 +1057,12 @@ static void free_gigantic_page(struct page *page, unsigned int order)
>  	free_contig_range(page_to_pfn(page), 1 << order);
>  }
>  
> +static inline bool gigantic_page_runtime_allocation_supported(void)
> +{
> +	return IS_ENABLED(CONFIG_CONTIG_ALLOC);
> +}

Why bother having this function?  Why don't the callers just check the
config option directly?

> +#ifdef CONFIG_CONTIG_ALLOC
>  static int __alloc_gigantic_page(unsigned long start_pfn,
>  				unsigned long nr_pages, gfp_t gfp_mask)
>  {
> @@ -1143,22 +1148,15 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
>  static void prep_new_huge_page(struct hstate *h, struct page *page, int nid);
>  static void prep_compound_gigantic_page(struct page *page, unsigned int order);
>  
> -#else /* !CONFIG_ARCH_HAS_GIGANTIC_PAGE */
> -static inline bool gigantic_page_supported(void) { return false; }
> +#else /* !CONFIG_CONTIG_ALLOC */
>  static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
>  		int nid, nodemask_t *nodemask) { return NULL; }
> -static inline void free_gigantic_page(struct page *page, unsigned int order) { }
> -static inline void destroy_compound_gigantic_page(struct page *page,
> -						unsigned int order) { }
>  #endif
>  
>  static void update_and_free_page(struct hstate *h, struct page *page)
>  {
>  	int i;
>  
> -	if (hstate_is_gigantic(h) && !gigantic_page_supported())
> -		return;

I don't get the point of removing this check.  Logically, this reads as
checking if the architecture supports gigantic hstates and has nothing
to do with allocation.

>  	h->nr_huge_pages--;
>  	h->nr_huge_pages_node[page_to_nid(page)]--;
>  	for (i = 0; i < pages_per_huge_page(h); i++) {
> @@ -2276,13 +2274,20 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
>  }
>  
>  #define persistent_huge_pages(h) (h->nr_huge_pages - h->surplus_huge_pages)
> -static unsigned long set_max_huge_pages(struct hstate *h, unsigned long count,
> +static int set_max_huge_pages(struct hstate *h, unsigned long count,
>  						nodemask_t *nodes_allowed)
>  {
>  	unsigned long min_count, ret;
>  
> -	if (hstate_is_gigantic(h) && !gigantic_page_supported())
> -		return h->max_huge_pages;
> +	if (hstate_is_gigantic(h) &&
> +		!gigantic_page_runtime_allocation_supported()) {

The indentation here is wrong and reduces readability.  Needs to be like
this:

	if (hstate_is_gigantic(h) &&
	    !gigantic_page_runtime_allocation_supported()) {

> +		spin_lock(&hugetlb_lock);
> +		if (count > persistent_huge_pages(h)) {
> +			spin_unlock(&hugetlb_lock);
> +			return -EINVAL;
> +		}
> +		goto decrease_pool;
> +	}

Needs comments.

	/* Gigantic pages can be freed but not allocated */

or something.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
