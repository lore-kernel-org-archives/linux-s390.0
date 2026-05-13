Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B253E51E3;
	Wed, 13 May 2026 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661615; cv=none; b=mig+DY2twulLFsMInsxfQ2WiyCyxp2vSENesTT8rIv4d969R1eobNsdgiHQB/AO1J4ic4zdSycS/66lbKFUfz+nXoEpnaXln0EymbUith2d0VG4+Niku0rInx0HIMAywiG+UjQ7uQ34PuHgyj8NAmD/APAloSltj3iE4qfa9QDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661615; c=relaxed/simple;
	bh=13LRFe622XguU1NLsfV3Ba6p09OZjDFhjXPDUplgOU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LG0HV+Nh/RXZU+zyu0cQBCc+hvSWQLlY7fDS3z6sAj7jq7SCM2SgwFg8VGUwan3nC4ne1PUvoasd6Y6UY5yyM+Aiy/4RE6l+0EBZvTW8w0G5El0EkF5e53Im6+2OV4ktQy+M6ZEmFFeWuUXJ+Q70Zw2Rr8ZSuC1LanPdYkInDkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=On2kQD50; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="On2kQD50"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7544FC2BCB7;
	Wed, 13 May 2026 08:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778661613;
	bh=13LRFe622XguU1NLsfV3Ba6p09OZjDFhjXPDUplgOU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=On2kQD50c1CeSLA0BlAVe3bh+GUVj4uncC/7cgHnMtbaOrrRDniULBC94dy6eSjz2
	 djLv6fWwvUdR+m85+VyTYLWyGPW1cp8lOngxujuunUkkTHFyvqi6iNQBMTMFHe3e6e
	 aTW03Op5p/T7d3KxJPF7AWzIDANS5U/x/W0pGNgFoLoBKlXL0DCvdQV1zf+aJFPPPx
	 FKUdczC4Y9UTrOVd25yGVEHsu+VFR/azqim6i572JU8Zum2z/G6jyDn/S29zSadSe0
	 kpwGcrcVJtwxyGRByZ9+vq6E2Wjjp/cxfoii/8CSxdmfaY3/tsBi/UVVNcU+Dymb+H
	 JRQtv3sKRxUKA==
Date: Wed, 13 May 2026 11:40:03 +0300
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
Subject: Re: [PATCH 7/8] s390/mm: use free_reserved_page() in
 vmem_free_pages()
Message-ID: <agQ44zJDVpJXCfYJ@kernel.org>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
 <20260511-bootmem_info_prep-v1-7-3fb0be6fc688@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-bootmem_info_prep-v1-7-3fb0be6fc688@kernel.org>

On Mon, May 11, 2026 at 04:05:35PM +0200, David Hildenbrand (Arm) wrote:
> We never select CONFIG_HAVE_BOOTMEM_INFO_NODE on s390. Therefore,
> free_bootmem_page() nowadays always translates to free_reserved_page().
> 
> Let's use free_reserved_page() to replace the free_bootmem_page() loop.
> We can stop including bootmem_info.h.
> 
> Likely, vmemmap freeing code could be factored out into the core in the
> future.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  arch/s390/mm/vmem.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
> index eeadff45e0e1..d8b2a60e0c33 100644
> --- a/arch/s390/mm/vmem.c
> +++ b/arch/s390/mm/vmem.c
> @@ -4,7 +4,6 @@
>   */
>  
>  #include <linux/memory_hotplug.h>
> -#include <linux/bootmem_info.h>
>  #include <linux/cpufeature.h>
>  #include <linux/memblock.h>
>  #include <linux/pfn.h>
> @@ -51,7 +50,7 @@ static void vmem_free_pages(unsigned long addr, int order, struct vmem_altmap *a
>  	if (PageReserved(page)) {
>  		/* allocated from memblock */
>  		while (nr_pages--)
> -			free_bootmem_page(page++);
> +			free_reserved_page(page++);
>  	} else {
>  		free_pages(addr, order);
>  	}
> 
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.
