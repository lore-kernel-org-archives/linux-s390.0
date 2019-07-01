Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59830 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727138AbfGAIPL (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 1 Jul 2019 04:15:11 -0400
Date: Mon, 1 Jul 2019 10:15:08 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v3 08/11] mm/memory_hotplug: Drop MHP_MEMBLOCK_API
Message-ID: <20190701081508.GH6376@dhcp22.suse.cz>
References: <20190527111152.16324-1-david@redhat.com>
 <20190527111152.16324-9-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527111152.16324-9-david@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Dan Williams <dan.j.williams@intel.com>, Wei Yang <richard.weiyang@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Oscar Salvador <osalvador@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Qian Cai <cai@lca.pw>, Arun KS <arunks@codeaurora.org>, Mathieu Malaterre <malat@debian.org>

On Mon 27-05-19 13:11:49, David Hildenbrand wrote:
> No longer needed, the callers of arch_add_memory() can handle this
> manually.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Arun KS <arunks@codeaurora.org>
> Cc: Mathieu Malaterre <malat@debian.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memory_hotplug.h | 8 --------
>  mm/memory_hotplug.c            | 9 +++------
>  2 files changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 2d4de313926d..2f1f87e13baa 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -128,14 +128,6 @@ extern void arch_remove_memory(int nid, u64 start, u64 size,
>  extern void __remove_pages(struct zone *zone, unsigned long start_pfn,
>  			   unsigned long nr_pages, struct vmem_altmap *altmap);
>  
> -/*
> - * Do we want sysfs memblock files created. This will allow userspace to online
> - * and offline memory explicitly. Lack of this bit means that the caller has to
> - * call move_pfn_range_to_zone to finish the initialization.
> - */
> -
> -#define MHP_MEMBLOCK_API               (1<<0)
> -
>  /* reasonably generic interface to expand the physical pages */
>  extern int __add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
>  		       struct mhp_restrictions *restrictions);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index b1fde90bbf19..9a92549ef23b 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -251,7 +251,7 @@ void __init register_page_bootmem_info_node(struct pglist_data *pgdat)
>  #endif /* CONFIG_HAVE_BOOTMEM_INFO_NODE */
>  
>  static int __meminit __add_section(int nid, unsigned long phys_start_pfn,
> -		struct vmem_altmap *altmap, bool want_memblock)
> +				   struct vmem_altmap *altmap)
>  {
>  	int ret;
>  
> @@ -294,8 +294,7 @@ int __ref __add_pages(int nid, unsigned long phys_start_pfn,
>  	}
>  
>  	for (i = start_sec; i <= end_sec; i++) {
> -		err = __add_section(nid, section_nr_to_pfn(i), altmap,
> -				restrictions->flags & MHP_MEMBLOCK_API);
> +		err = __add_section(nid, section_nr_to_pfn(i), altmap);
>  
>  		/*
>  		 * EEXIST is finally dealt with by ioresource collision
> @@ -1067,9 +1066,7 @@ static int online_memory_block(struct memory_block *mem, void *arg)
>   */
>  int __ref add_memory_resource(int nid, struct resource *res)
>  {
> -	struct mhp_restrictions restrictions = {
> -		.flags = MHP_MEMBLOCK_API,
> -	};
> +	struct mhp_restrictions restrictions = {};
>  	u64 start, size;
>  	bool new_node = false;
>  	int ret;
> -- 
> 2.20.1
> 

-- 
Michal Hocko
SUSE Labs
