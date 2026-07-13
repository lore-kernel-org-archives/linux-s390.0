Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B30C344D9D
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 18:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966263; cv=none; b=gv6QnTp8gdLPU+NTalGdemNtPrFQX6dzhqWLdGaPcjPO1ptaIp4+7VvWyohN8T+8K0lPTwrO0ATvXHmcxWahAubW0g44g+TXs3/0JzdPaRZYyJngiClvI2cBPK9E3gWFIdxguvIeerm10gqnjEOqF83XK8XkMw55e3m5g43cBsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966263; c=relaxed/simple;
	bh=YUh8//1CawO0lxzXPLb9x+Xef1uhNSh6FnuTiN+bISs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHlTPbijDGgj37kNqTntzJ4d/SIFxU3VLRDms5OHcltE+dpKm4seZY6BPXIKCTmDRioSYbtWCpyYuSfaFdsTw3lxb8Pff3daLRB51lTSa6jehClHNouwAOVA8olT1kOdsxpYh+WzfAiKdyzpTKy8WRQzEW+9GhXhFqCk+85OBvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KiTpIKkI; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KiTpIKkI"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8ee43b3e5abso28288396d6.3
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 11:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783966261; x=1784571061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r3LqUwIJYp9NQ4diqGbAZyVDrYnzRQFmiULYhYdIqPw=;
        b=KiTpIKkIyki9rkN22uLrIR75iMI+J4LNxKsOCvX8GGZgaI1rL69EeFpaM0oMLdEokx
         7+djrj0P+1ZixAHXWZIQRFAXGG/6GosFltYENUQ2Ya9FLZYtTka6UCnzZJkwoRhbBcvT
         04wjfLRc8L2TTwiUb0riww8PdXrSIUJghsELEgZ2P1AUidZxRW6I7aqnzHwib7zTJmXb
         JeE0l88pcp4j3TrDjGFe1c9oJPhjAZYZmyq+0emBpaiA+ZAA7/48FCATYDjG+UgKxrt2
         0GBH5ONjgl2ld39EI7Es+2dE1NElC3gMmsPGGlsw1lNxjBGqik8Wc6EL5ECBrdU9RUIi
         AkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783966261; x=1784571061;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r3LqUwIJYp9NQ4diqGbAZyVDrYnzRQFmiULYhYdIqPw=;
        b=QueqQ6exWjRl3ECkOdIsomMPN4gb2KGel/Wc0aYNykMVqEJouyqFrhybQiM49wwffa
         azzUcJi4yzSnbVa6W7WhKILwNkpROS4f11IFfUJHAB49kaEI2cENXCat5tx1fHc8aQwP
         E6O6oGtxg8V9XyPxHCUTuoZB3bTdp7fbG9VFUK8ZMC5/OwU0Mlru8PQxAPySevwXfo+9
         /xvfFgqg65Rngn0jClj2rfLSvJCwTTOU49JeMS+M1RZOofWJERKFjqKBdN3j2GsOYlRV
         XqHeNH34ajkKEzKLm9JIMp3JYG1nq8SfkLKkDcp1TW/kVdMSz8QVIQvjXVG5rLH6Wqsn
         q7tA==
X-Forwarded-Encrypted: i=1; AHgh+Ror066sfv0uT41W5vpYCR9vnVAHVaXA1wtk0/JjaRjHki1/uM1AErHPGPfwPPaNKqJsxKR6lJm/0hOx@vger.kernel.org
X-Gm-Message-State: AOJu0YwhsgYVjgjK6bQdT6hvmO0Hb7GfG+hJ3hBUC2JzPn2dGJuIVKM+
	1LbexkTOnqXdmENa0VrC6ZXT7pSxwWo8pFVfNN9hT9G4nl3LpyNb82Vu6TzhkZ00T+c=
X-Gm-Gg: AfdE7cmJrMJFkdlM/05iysiiFsfuAdrGDV+6RJ9TXWCSoYuQLApOaNrS31yL/l3HvNc
	/c42pGu0gJIDHszmYhz5FAHJ1D2zsrahIHaH6fxNLX2xMV7cVjdzkFW2olhfGU0kYGB1XFkwkQT
	9Ti/+Ybf6zLatUDNAmKaofI0jtHETOOf06k3/d+xXJ9FmHXFKLZybuLs4XXlmzts9RwW9cNCdl1
	TWeyyAjq6Ok1Nw8KEZfpeLmNem0q54jvJLBjAvJPC4sASTCCP9CiandHHV3bg9RcCH5rxy1sj6v
	QxWnlcjQvRDmFFWpkWDK9ulN1rTcL2q80MycefeSEYfL24iwWaSRjgAk22dKeWWdfvKBbHVvFcI
	OII0bw+ExJ029IuMYLG7pEeGinAxb1QgS4NmK3VCTrIidxoyHu9E1YKuJ3gK7
X-Received: by 2002:a05:6214:601a:b0:8f6:8677:7ea5 with SMTP id 6a1803df08f44-90402c68ee8mr99154096d6.37.1783966260999;
        Mon, 13 Jul 2026 11:11:00 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd5bbac2asm135284216d6.21.2026.07.13.11.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 11:11:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjL7L-0000000DyOu-42Rk;
	Mon, 13 Jul 2026 15:10:59 -0300
Date: Mon, 13 Jul 2026 15:10:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 04/22] dma: free atomic pool pages by physical address
Message-ID: <20260713181059.GL3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-5-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-5-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:08AM +0530, Aneesh Kumar K.V (Arm) wrote:
> dma_direct_alloc_pages() may satisfy atomic allocations from the coherent
> atomic pools. The pool allocation is keyed by the virtual address stored in
> the gen_pool, but the pages API returns only the backing struct page.
> 
> On architectures with CONFIG_DMA_DIRECT_REMAP, atomic pool chunks are added
> to the gen_pool using their remapped virtual address.
> dma_direct_free_pages() reconstructs a linear-map address with
> page_address(page) and passes that to dma_free_from_pool(). That address
> does not match the gen_pool virtual range, so the pool lookup can fail and
> the code can fall through to freeing a pool-owned page through the normal
> page allocator path.
> 
> Add a page-based pool free helper that looks up the owning pool chunk by
> physical address, translates it back to the gen_pool virtual address, and
> frees that address to the pool. Use it from dma_direct_free_pages() while
> keeping the existing virtual-address helper for coherent allocation frees.
> 
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  include/linux/dma-map-ops.h |  1 +
>  kernel/dma/direct.c         |  4 +--
>  kernel/dma/pool.c           | 54 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 57 insertions(+), 2 deletions(-)

This seems pretty suboptimal?

If !CONFIG_DMA_DIRECT_REMAP then page_to_virt() was used to compute
the genpool's addr so dma_free_from_pool_page() can use the same
logic, which is how things must be working at all today

The CONFIG_DMA_DIRECT_REMAP scenario does look broken, so I'm
surprised there isn't a Fixes line on this commit? I don't have an
opinion on the search, but since alloc_pages() is used there is 8
bytes in the struct page that could be used to store the remapped
vaddr to avoid the search if someday someone wants to improve
this. Maybe a small comment hinting that direction would be a nice
addition.

Jason
