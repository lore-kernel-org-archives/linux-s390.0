Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8433A6F0F;
	Wed, 13 May 2026 08:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778660871; cv=none; b=rFIPKpeIgGagCH5XgRgSV/BUc4DiA1dm3ltbBpP9WgF7TgvkCKr1qsc18aWLzsE/v7Gd10seiscg+h0wHy7khUE0/eQIoJYfhKJvGupFUW7QxWm3Vb6kcIwzPu5Sfl6Wml5IJwG3XZH76VJnVxFqbMmSsoVH4oNhdNTMbtwfRIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778660871; c=relaxed/simple;
	bh=BFNiTiF/fmalzC6zsySYqjiBYoFoZn/VA1kMh/SGay4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BopidIhBayOC4I/tTvGaxFUMQtP60NP9zi15hMwK2UJWNYaaYn9i3f2srrzCNWv7twfm5pGm+4gfp1Jr9Bc7CKn14X0sdd5XF881ye7Ugu7kDXTnKKnyjQSNXcybkh7ewTtRMejfecR2lP5KsQH4wW4lmznVshjaSL5LqdhoRnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDVBvJWx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDVBvJWx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1415EC2BCC6;
	Wed, 13 May 2026 08:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778660871;
	bh=BFNiTiF/fmalzC6zsySYqjiBYoFoZn/VA1kMh/SGay4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RDVBvJWx9At9GYymZiTlO41qMOkSSKg3BboX/CVnFiIv0SuGpInRHEAvhGMxiyigy
	 XYxY2QFNHsiM/Kz6qb5NfpYB+1dXscvNM3WsLoOGc6QHMmkIQMh572x12weyGPWoYH
	 vHOryRtbOWtZJ68xh++I/5IQOucJ2dlC2eMdo3MQy9H691yqC0Lj11nXwLpOCAE3aS
	 KhDIBcOu0yW33BDLsOG8B9VSmd3sJ8VVXgKFCHYGt4NsVHGDVW/asy6XiNs4qyNwom
	 OXjzJ7LMX26VkGqcr9MOhhtZsLzcVib+okPrxWlYGMY16gAJAI/YzgvweX2k+RnwnR
	 FkFjWcg1j/ROg==
Date: Wed, 13 May 2026 11:27:40 +0300
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
Subject: Re: [PATCH 2/8] mm/bootmem_info: drop initialization of page->lru
Message-ID: <agQ1_Bl6obF1bpT0@kernel.org>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
 <20260511-bootmem_info_prep-v1-2-3fb0be6fc688@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-bootmem_info_prep-v1-2-3fb0be6fc688@kernel.org>

On Mon, May 11, 2026 at 04:05:30PM +0200, David Hildenbrand (Arm) wrote:
> In the past, we used to store the type in page->lru.next, introduced by
> commit 5f24ce5fd34c ("thp: remove PG_buddy"). The location changed over
> the years; ever since commit 0386aaa6e9c8 ("bootmem: stop using
> page->index"), we store it alongside the info in page->private.
> 
> Consequently, there is no need to reset page->lru anymore.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/bootmem_info.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
> index 3d7675a3ae04..a0a1ecdec8d0 100644
> --- a/mm/bootmem_info.c
> +++ b/mm/bootmem_info.c
> @@ -34,7 +34,6 @@ void put_page_bootmem(struct page *page)
>  	if (page_ref_dec_return(page) == 1) {
>  		ClearPagePrivate(page);
>  		set_page_private(page, 0);
> -		INIT_LIST_HEAD(&page->lru);
>  		kmemleak_free_part_phys(PFN_PHYS(page_to_pfn(page)), PAGE_SIZE);
>  		free_reserved_page(page);
>  	}
> 
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.
