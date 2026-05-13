Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488C53D904D;
	Wed, 13 May 2026 08:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661130; cv=none; b=BvE1apbze3La066GqgWd6UiRdk5R/3gLU4zifTAnGErq60ZIouELUCH9YQ6ULLxAbO5/3M2KyjmIUmvd0QI27lbJImBAZR30CrrUW4a0oKQ1Srp8dTHpeTbHZJoPTwSPAbzOJxENb6a05Jakf1deXICYlpSsZImNS7hQITvLx5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661130; c=relaxed/simple;
	bh=qp/Kvrjw7Oq7hxqDPSczPb7gzSG1XTgAYGfhyvfkbpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwfIm36Q3oOSbY8Rf/J8ufw0dI/nhBGUypxscHc9EKoy9FvovQnmQIpqkLfT4vgNyHdqMnCN3fPmrkZiMpKAaNv4yiVi2qF6vwORl/W3ZgwqvK+bGITpcD5Qe3AcDxorUqnOSaVajEFFsZGPUGBVU6FWfzY9AEmwfvQB+UYgl4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4S1fRzs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4S1fRzs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5E9C2BCB7;
	Wed, 13 May 2026 08:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778661128;
	bh=qp/Kvrjw7Oq7hxqDPSczPb7gzSG1XTgAYGfhyvfkbpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b4S1fRzs+BpoYpyi2lzBeRnk/n/Eutkx1iJx4JcHlOEVAgOQyZ5NnR1NPl/q7qJoO
	 C7zMk2y/zgvAqKk3jybr21fH4PW9duyXBucYc30yZ8xZ8l0q2fcP9SX8t3CJJBOe6E
	 FcHQlKDGnZ7p7qa3Bj9oo7i1i5WpWCuHFbKuGDeLEjKZtbXEuuiWChQKbQii4tqnqI
	 TvzXQR7qJ6t4iWSL8b/6f5d9Hk4TS3fH2vtf0Eb104G9DcBwHMtUaFenltZVcdY9V6
	 nBbz+d3RbNr8GQQP7xyDaGlrjtUjRcckR90Z9NPnuwt8k6Ub+MvMf+YHLgdpqHvpoY
	 OLb9we90YCq8w==
Date: Wed, 13 May 2026 11:31:58 +0300
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
Subject: Re: [PATCH 4/8] mm/bootmem_info: remove call to
 kmemleak_free_part_phys()
Message-ID: <agQ2_upxbT_i7-6S@kernel.org>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
 <20260511-bootmem_info_prep-v1-4-3fb0be6fc688@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-bootmem_info_prep-v1-4-3fb0be6fc688@kernel.org>

On Mon, May 11, 2026 at 04:05:32PM +0200, David Hildenbrand (Arm) wrote:
> The call to kmemleak_free_part_phys() was added in 2022 in
> commit dd0ff4d12dd2 ("bootmem: remove the vmemmap pages from kmemleak in
> put_page_bootmem").
> 
> In 2025, commit b2aad24b5333 ("mm/memmap: prevent double scanning of memmap
> by kmemleak") started to use MEMBLOCK_ALLOC_NOLEAKTRACE when allocating
> the memmap to skip the kmemleak_alloc_phys() in the buddy.
> 
> So remove the call to kmemleak_free_part_phys(). If this would still
> be required for other purposes, either free_reserved_page() should take
> care of it, or selected users.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/bootmem_info.h | 1 -
>  mm/bootmem_info.c            | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
> index 492ceeb1cdf8..f724340755e5 100644
> --- a/include/linux/bootmem_info.h
> +++ b/include/linux/bootmem_info.h
> @@ -82,7 +82,6 @@ static inline void get_page_bootmem(unsigned long info, struct page *page,
>  
>  static inline void free_bootmem_page(struct page *page)
>  {
> -	kmemleak_free_part_phys(PFN_PHYS(page_to_pfn(page)), PAGE_SIZE);
>  	free_reserved_page(page);
>  }
>  #endif
> diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
> index 6e2aaab3dca9..74c1116626c8 100644
> --- a/mm/bootmem_info.c
> +++ b/mm/bootmem_info.c
> @@ -32,7 +32,6 @@ void put_page_bootmem(struct page *page)
>  
>  	if (page_ref_dec_return(page) == 1) {
>  		set_page_private(page, 0);
> -		kmemleak_free_part_phys(PFN_PHYS(page_to_pfn(page)), PAGE_SIZE);
>  		free_reserved_page(page);
>  	}
>  }
> 
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.
