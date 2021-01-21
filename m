Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 21 Jan 2021 10:23:33 +0100
From: Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH V3 1/3] mm/memory_hotplug: Prevalidate the address range
 being added with platform
Message-ID: <20210121092328.GA11001@linux>
References: <1610975582-12646-1-git-send-email-anshuman.khandual@arm.com>
 <1610975582-12646-2-git-send-email-anshuman.khandual@arm.com>
 <691872bb-b251-83e0-126e-afd54683c83e@redhat.com>
 <3d4f3b14-0715-b2b3-b015-04b8a77abfb8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d4f3b14-0715-b2b3-b015-04b8a77abfb8@arm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, akpm@linux-foundation.org, hca@linux.ibm.com, catalin.marinas@arm.com, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 02:03:45PM +0530, Anshuman Khandual wrote:
> Just to be sure, will the following change achieve what you are
> suggesting here. pagemap_range() after this change, will again
> be the same like the V1 series.

With below diff on top it looks good to me:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

The only nit I would have is whether the declaration of arch_get_mappable_range
should be in include/linux/memory_hotplug.h.
As you pointed out, arch_get_mappable_range() might be used by the platform
for other purposes, and since you are defining it out of CONFIG_MEMORY_HOTPLUG
anyway.
Would include/linu/memory.h be a better fit?

As I said, nothing to bikeshed about, just my thoughts.

> ---
>  mm/memory_hotplug.c |  3 +--
>  mm/memremap.c       | 12 +++++-------
>  2 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 46faa914aa25..10d4ec8f349c 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -304,8 +304,7 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>  	if (WARN_ON_ONCE(!params->pgprot.pgprot))
>  		return -EINVAL;
>  
> -	if(!memhp_range_allowed(PFN_PHYS(pfn), nr_pages * PAGE_SIZE, false))
> -		return -E2BIG;
> +	VM_BUG_ON(!memhp_range_allowed(PFN_PHYS(pfn), nr_pages * PAGE_SIZE, false));
>  
>  	if (altmap) {
>  		/*
> diff --git a/mm/memremap.c b/mm/memremap.c
> index e15b13736f6a..26c1825756cc 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -185,6 +185,7 @@ static void dev_pagemap_percpu_release(struct percpu_ref *ref)
>  static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
>  		int range_id, int nid)
>  {
> +	const bool is_private = pgmap->type == MEMORY_DEVICE_PRIVATE;
>  	struct range *range = &pgmap->ranges[range_id];
>  	struct dev_pagemap *conflict_pgmap;
>  	int error, is_ram;
> @@ -230,6 +231,9 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
>  	if (error)
>  		goto err_pfn_remap;
>  
> +	if (!memhp_range_allowed(range->start, range_len(range), !is_private))
> +		goto err_pfn_remap;
> +
>  	mem_hotplug_begin();
>  
>  	/*
> @@ -243,7 +247,7 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
>  	 * the CPU, we do want the linear mapping and thus use
>  	 * arch_add_memory().
>  	 */
> -	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
> +	if (is_private) {
>  		error = add_pages(nid, PHYS_PFN(range->start),
>  				PHYS_PFN(range_len(range)), params);
>  	} else {
> @@ -253,12 +257,6 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
>  			goto err_kasan;
>  		}
>  
> -		if (!memhp_range_allowed(range->start, range_len(range), true)) {
> -			error = -ERANGE;
> -			mem_hotplug_done();
> -			goto err_add_memory;
> -		}
> -
>  		error = arch_add_memory(nid, range->start, range_len(range),
>  					params);
>  	}
> -- 
> 2.20.1
> 

-- 
Oscar Salvador
SUSE L3
