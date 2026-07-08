Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B33A439349;
	Wed,  8 Jul 2026 15:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524435; cv=none; b=srd3jHAr1irnoYtASfz8utn8rpcXQHLQ62NGF83tRbRu2RXzH2l0lMGXYg+t/Bqyj0ekFdBFWb8f7xv4BLFFbQi+/++zIP3n+ZkizFWWcEIr9Y3owFYiC+l5bTsvrMIrfLGW5/AhRABh+tJXAE+A8xxQXDM/WzJO/Q7X/AhehOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524435; c=relaxed/simple;
	bh=KBOlDHzFj0lM+kCw63z4O4lR+Gdn5SZMfq0HvqPr740=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WMudVXzuhy50i1Pj3xkQlTVuiGFRIrtd8mtNVc71WhsjUWm1PFInYPhXhANQoCNeyxH+oR1UhHQBivHvCoJBP6RTMfOJEdvKvswomu10zJCOB2Tta1XEQacHEKNSC+9UaIFyfjgzIi17d8uvTKa5iiybgYP+0ge0y28uWmQDBi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtIuHDz4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtIuHDz4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B15E1F000E9;
	Wed,  8 Jul 2026 15:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783524433;
	bh=d6H66oQKu4+AFEkauauvVyBVXr6c/W/wZzKm2MLUgm4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DtIuHDz4q0OKUO3gPfm+8lKay5WivKisN0Dk+GKdB+UTpg5Pz33kxFgwvsHFF/nGL
	 UL2svqSefT97edjrbE5kQ/YY+6/rMImYYNuijAP+WzCZRgvYz9kCq+AtPEmFScgG7Y
	 OyForKqp9VdK7e5vGLiqgp6C4XqNeXwuh9LhUCO4iyYNg4lEzWkbmRXSq18+4jchgP
	 0/QEIH+VgPg4ZB4qqmh8st4tNNOlw1wwG6zFDuk2AfcEbsIdtnzC7z3JzQQL8FXW63
	 ec/Ojr+zZqSP4tUgyuqthZahTLLNfSGiGWtJSg1J6Pm09iivlMbrPsVPg/SvUcQCf4
	 4iXpqwdmoaeJQ==
Message-ID: <521fbaf3-ea07-4794-8bec-ac12020e04d7@kernel.org>
Date: Wed, 8 Jul 2026 17:27:05 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] x86/mm: stop marking page tables as
 MIX_SECTION_INFO
To: Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org
References: <20260708-bootmem_info_part2-v1-0-156ce4986598@kernel.org>
 <20260708-bootmem_info_part2-v1-6-156ce4986598@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260708-bootmem_info_part2-v1-6-156ce4986598@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/26 16:11, David Hildenbrand (Arm) wrote:
> There is no good reason to mark boot page tables as MIX_SECTION_INFO: we
> only free boot page tables when they are completely empty, and memory
> offlining/hotunplug doesn't benefit from it in any way.
> 
> So just stop marking page tables as MIX_SECTION_INFO. In
> free_pagetable(), we can now simply free reserved pages directly.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  arch/x86/mm/init_64.c | 59 ++-------------------------------------------------
>  1 file changed, 2 insertions(+), 57 deletions(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 82bb0384b8ab0..1b17dcf781e66 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1002,21 +1002,10 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  
>  static void __meminit free_pagetable(struct page *page)
>  {
> -	/* bootmem page has reserved flag */
> -	if (PageReserved(page)) {
> -#ifdef CONFIG_HAVE_BOOTMEM_INFO_NODE
> -		enum bootmem_type type = bootmem_type(page);
> -
> -		if (type == MIX_SECTION_INFO)
> -			put_page_bootmem(page);
> -		else
> -			free_reserved_page(page);
> -#else
> +	if (PageReserved(page))
>  		free_reserved_page(page);
> -#endif
> -	} else {
> +	else
>  		pagetable_free(page_ptdesc(page));
> -	}
>  }
>  
>  static void __meminit free_vmemmap_pages(struct page *page, unsigned int order,
> @@ -1579,50 +1568,6 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>  void register_page_bootmem_memmap(unsigned long section_nr,
>  				  struct page *start_page, unsigned long nr_pages)
>  {
> -	unsigned long addr = (unsigned long)start_page;
> -	unsigned long end = (unsigned long)(start_page + nr_pages);
> -	unsigned long next;
> -	pgd_t *pgd;
> -	p4d_t *p4d;
> -	pud_t *pud;
> -	pmd_t *pmd;
> -
> -	for (; addr < end; addr = next) {
> -		pgd = pgd_offset_k(addr);
> -		if (pgd_none(*pgd)) {
> -			next = (addr + PAGE_SIZE) & PAGE_MASK;
> -			continue;
> -		}
> -		get_page_bootmem(section_nr, pgd_page(*pgd), MIX_SECTION_INFO);
> -
> -		p4d = p4d_offset(pgd, addr);
> -		if (p4d_none(*p4d)) {
> -			next = (addr + PAGE_SIZE) & PAGE_MASK;
> -			continue;
> -		}
> -		get_page_bootmem(section_nr, p4d_page(*p4d), MIX_SECTION_INFO);
> -
> -		pud = pud_offset(p4d, addr);
> -		if (pud_none(*pud)) {
> -			next = (addr + PAGE_SIZE) & PAGE_MASK;
> -			continue;
> -		}
> -		get_page_bootmem(section_nr, pud_page(*pud), MIX_SECTION_INFO);
> -
> -		pmd = pmd_offset(pud, addr);
> -		if (pmd_none(*pmd)) {
> -			next = (addr + PAGE_SIZE) & PAGE_MASK;
> -			continue;
> -		}
> -
> -		if (!boot_cpu_has(X86_FEATURE_PSE) || !pmd_leaf(*pmd)) {
> -			next = (addr + PAGE_SIZE) & PAGE_MASK;
> -			get_page_bootmem(section_nr, pmd_page(*pmd),
> -					 MIX_SECTION_INFO);
> -		} else {
> -			next = pmd_addr_end(addr, end);
> -		}
> -	}
>  }
>  #endif
>  
> 

Sashiko being rather useless:

New issues:
- [Low] The patch leaves the entire bootmem_info infrastructure as dead code
without removing it.

-> It's not aware of other patches in the series? Surprising.


Pre-existing issues:
- [High] Kernel page table pages and vmemmap pages are freed to the buddy
allocator before their parent entries are cleared and before the TLB is flushed,
creating a dangling pointer window.

-> Reported two times in previous patches and I will not fix that.


-- 
Cheers,

David
