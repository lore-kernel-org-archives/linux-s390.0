Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392D83D88EB;
	Wed, 13 May 2026 08:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661547; cv=none; b=g27vriHTAoPiZBcHWS9g2r0+8jlclWPkjfLz9UgZ9JURo655kiU2GT4C00cK8GAHg+B9XZrJ4h5qzUYTUBTnflvNU/qv/Gv7i6FOiTi7oZRRdMPX51ApBFtMjuV+GB1cUtHDCjdhCz/b0LsbOqDXbbXMOZ2p45b/ZNLPh4ZrfOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661547; c=relaxed/simple;
	bh=A+alEkVbDEYYLkoEGrsz9cm8DsNiefv/WIMetnJZ4aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/QTp0o2sk4eA/K7+ORLUQy3Mzn+jzsLuxeqZBvriQtZlGsH1YEk7TdCDok3jfH+PROl2ysFvUGLtl49o4tSXlbmeaLhr0hhfxDCjkgxjmvfB8As7/2n024i0EVpwM5M02ih/msCi9cjvBHSQzmMciMgHqG/rXG+DuscQFnqu6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5o2b94C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5o2b94C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C496EC2BCB7;
	Wed, 13 May 2026 08:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778661546;
	bh=A+alEkVbDEYYLkoEGrsz9cm8DsNiefv/WIMetnJZ4aA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i5o2b94CuXzH2xo1vE/DUzE4IguK5/np+Jsb57LZ3NB3zL8hSI80f7ACMbgEeHtAP
	 qV9dcRBrrPGWTvrCfK3ozf6Q/Nh4quN4g1L//ckWLJ5IZBF9wcexyyeHeoSRxNtPFH
	 5N9yNX4d6ez9CMAHkKOf9Q8JiXvXQhoxZZdpf8TvK+Byg36ZnOCAuDu9QuNuCfrEwH
	 Qm78NZa6NaXCcHKglUgtQMONd4VPk8qQQ87YzAm64xITK4kwsanSFW8xhr76ovDxnp
	 r4CIUxQc9Mt49yJ2jK7gSCRV3umP23VsjLZA5UF5Ta5xnIWTZ1tKagj3rn4mhxaYzQ
	 HWhG0Vzd8dUdQ==
Date: Wed, 13 May 2026 11:38:56 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 6/8] mm/bootmem_info: stop marking mem_section_usage as
 MIX_SECTION_INFO
Message-ID: <agQ4oL4pKP0D51gn@kernel.org>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
 <20260511-bootmem_info_prep-v1-6-3fb0be6fc688@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-bootmem_info_prep-v1-6-3fb0be6fc688@kernel.org>

On Mon, May 11, 2026 at 04:05:34PM +0200, David Hildenbrand (Arm) wrote:
> We never free the ms->usage data for boot memory sections (see
> section_deactivate()). And to identify whether ms->usage was allocated
> from memblock, we simply identify it by looking at PG_reserved.
> 
> Consequently, there is no need to mark ms->usage as MIX_SECTION_INFO.
> Let's just stop doing that.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/bootmem_info.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
> index cce1d560f094..0fa78db7fbc0 100644
> --- a/mm/bootmem_info.c
> +++ b/mm/bootmem_info.c
> @@ -38,10 +38,8 @@ void put_page_bootmem(struct page *page)
>  
>  static void __init register_page_bootmem_info_section(unsigned long start_pfn)
>  {
> -	unsigned long mapsize, section_nr, i;
> +	unsigned long section_nr;
>  	struct mem_section *ms;
> -	struct mem_section_usage *usage;
> -	struct page *page;
>  
>  	start_pfn = SECTION_ALIGN_DOWN(start_pfn);
>  	section_nr = pfn_to_section_nr(start_pfn);
> @@ -50,14 +48,6 @@ static void __init register_page_bootmem_info_section(unsigned long start_pfn)
>  	if (!preinited_vmemmap_section(ms))
>  		register_page_bootmem_memmap(section_nr, pfn_to_page(start_pfn),
>  					     PAGES_PER_SECTION);
> -
> -	usage = ms->usage;
> -	page = virt_to_page(usage);
> -
> -	mapsize = PAGE_ALIGN(mem_section_usage_size()) >> PAGE_SHIFT;
> -
> -	for (i = 0; i < mapsize; i++, page++)
> -		get_page_bootmem(section_nr, page, MIX_SECTION_INFO);
>  }
>  
>  void __init register_page_bootmem_info_node(struct pglist_data *pgdat)
> 
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.
