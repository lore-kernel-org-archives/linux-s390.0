Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA113DE42B;
	Wed, 13 May 2026 08:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661003; cv=none; b=Bcs4/u0f00Qgk81sai9Oee2Kv5ZAhKoEhD/pZdit+8GtwHj0OcUIl4ibM2xZQocBNswq0KgB/CGQzJST9b/Vx6FuFT/YYFw6HMtJ4n6D+CNwBo9uMRICyAePrnvk2pSu0Fb+hKDGih1vkHAZ8M9NlwR+Q8u4/E3YlX6E99bh8mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661003; c=relaxed/simple;
	bh=ZLaj6u3xCKR0/GZAQ0y6ABck1ESL0dcx2vChaLzZJY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcvDig4cOEbeTD1u1D75WpUbx1HztSVkCBvP0oq0FZnUqdHYC7mtrCRuKcGXrMUPVq2x6k/YFC21DRAVLoB1eAMYxc7mpP1Ddx4C8mzKimzNpBXGNQqCpMZvwIf3mvYscWhStAHy+ZWqcpF/Xrcz0wQYmRs85+HcwfWbmsx4FW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HO+oY0Nd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HO+oY0Nd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0E4C2BCC6;
	Wed, 13 May 2026 08:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778661002;
	bh=ZLaj6u3xCKR0/GZAQ0y6ABck1ESL0dcx2vChaLzZJY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HO+oY0NdOFVz+h7eHE/9LEv12adXbeAnP2ZzwsbhPOMLpmsuysp76rXaSbwEoZL4L
	 MkLN96NUUYoMbW03eInLeBbIKNo8oo9DpBzMo2tlwCEetIMxUxdBk5Qdyp/L4jlfEj
	 H8jWkt6I02G3VbRXauvYbcIrItP+m3HHf72TCU/IG7SrM5Jl4ZtI49zg/GaFvd2wvP
	 fvEmMwncOKALBUmcqhKw6iJFOj0ywjuDbKyylhVuILHn+GXQF56XuiBl+0tIKn7Uqe
	 AfCFABtT36jxPCYHKIvqJQxNUCCM4fphduLkt5+EYb64hjkhu/XR2k6yBvigrqqwx6
	 JOKHlZVyyb4eg==
Date: Wed, 13 May 2026 11:29:51 +0300
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
Subject: Re: [PATCH 3/8] mm/bootmem_info: stop using PG_private
Message-ID: <agQ2fwPeMuEbnYeh@kernel.org>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
 <20260511-bootmem_info_prep-v1-3-3fb0be6fc688@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-bootmem_info_prep-v1-3-3fb0be6fc688@kernel.org>

On Mon, May 11, 2026 at 04:05:31PM +0200, David Hildenbrand (Arm) wrote:
> Nobody checks PG_private for these pages, and we can happily use
> set_page_private() without setting PG_private. So let's just stop
> setting/clearing PG_private.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/bootmem_info.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
> index a0a1ecdec8d0..6e2aaab3dca9 100644
> --- a/mm/bootmem_info.c
> +++ b/mm/bootmem_info.c
> @@ -19,7 +19,6 @@ void get_page_bootmem(unsigned long info, struct page *page,
>  {
>  	BUG_ON(type > 0xf);
>  	BUG_ON(info > (ULONG_MAX >> 4));
> -	SetPagePrivate(page);
>  	set_page_private(page, info << 4 | type);
>  	page_ref_inc(page);
>  }
> @@ -32,7 +31,6 @@ void put_page_bootmem(struct page *page)
>  	       type > MEMORY_HOTPLUG_MAX_BOOTMEM_TYPE);
>  
>  	if (page_ref_dec_return(page) == 1) {
> -		ClearPagePrivate(page);
>  		set_page_private(page, 0);
>  		kmemleak_free_part_phys(PFN_PHYS(page_to_pfn(page)), PAGE_SIZE);
>  		free_reserved_page(page);
> 
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.
