Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58982 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726027AbfJ3IOI (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 30 Oct 2019 04:14:08 -0400
Date: Wed, 30 Oct 2019 09:14:04 +0100
From: Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH] mm/sparse.c: mark populate_section_memmap as __meminit
Message-ID: <20191030081359.GA11931@linux>
References: <20191028165549.14478-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028165549.14478-1-iii@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

On Mon, Oct 28, 2019 at 05:55:49PM +0100, Ilya Leoshkevich wrote:
> Building the kernel on s390 with -Og produces the following warning:
> 
> WARNING: vmlinux.o(.text+0x28dabe): Section mismatch in reference from the function populate_section_memmap() to the function .meminit.text:__populate_section_memmap()
> The function populate_section_memmap() references
> the function __meminit __populate_section_memmap().
> This is often because populate_section_memmap lacks a __meminit
> annotation or the annotation of __populate_section_memmap is wrong.
> 
> While -Og is not supported, in theory this might still happen with
> another compiler or on another architecture. So fix this by using the
> correct section annotations.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  mm/sparse.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index f6891c1992b1..0f1f36443a96 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -448,7 +448,7 @@ static unsigned long __init section_map_size(void)
>  	return PAGE_ALIGN(sizeof(struct page) * PAGES_PER_SECTION);
>  }
>  
> -struct page __init *__populate_section_memmap(unsigned long pfn,
> +struct page __meminit *__populate_section_memmap(unsigned long pfn,
>  		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
>  {
>  	unsigned long size = section_map_size();
> @@ -647,7 +647,7 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
>  #endif
>  
>  #ifdef CONFIG_SPARSEMEM_VMEMMAP
> -static struct page *populate_section_memmap(unsigned long pfn,
> +static struct page * __meminit populate_section_memmap(unsigned long pfn,
>  		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
>  {
>  	return __populate_section_memmap(pfn, nr_pages, nid, altmap);
> @@ -669,7 +669,7 @@ static void free_map_bootmem(struct page *memmap)
>  	vmemmap_free(start, end, NULL);
>  }
>  #else
> -struct page *populate_section_memmap(unsigned long pfn,
> +struct page * __meminit populate_section_memmap(unsigned long pfn,
>  		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
>  {
>  	struct page *page, *ret;

I did not really check deep, but I __think__ you only need to add __meminit in
populate_section_memmap functions.

__populate_section_memmap for SPARSE case is only used at init phase.


-- 
Oscar Salvador
SUSE L3
