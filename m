Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2789322B8C
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783969931; cv=none; b=l9+ITwoUGsqIz2+mvvk1dfo7IO8WKzGJbDRiaBPZ2eBx3tfYh2U0lpHTEKWVYS3MLg74XKHJxG1pvstSTF3hU/6ZKq7O2urc6L9dXNlqiMrxRuuY2/31Sz9v/SfQyrEY0rgDBTPiQApgvJ/361JOuHqetg6U/QI4q8/vh5Syc1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783969931; c=relaxed/simple;
	bh=zQwwTTQgdWMUuBKytoq9EwDKG6Cm405oXwoG7/OyDFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYxlYIRIuWdPoqOqTznIpjP5V1U4fosd+P13BNPOWceyKDpKES/r+gCG0H+pkt3tCPRYJdUI8k7OPmJp1lsQN2eG1C7DZvWvqWzk30uukV2aFMz+W/5Qbs6k+TdeWrjljZRrOcuRscjmNAlCzTtTYNlMorsUakOxz2TuX2XHqVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GdjML5oU; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GdjML5oU"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c16ac21acso1497331cf.0
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 12:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783969929; x=1784574729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/NxveP/pyfIFv71kVfPTlg3b5XZeJTUOET5rnvr6kHo=;
        b=GdjML5oUAiB5fwMk1sx4IHaxbg0B8M0bAdE0szIBg03X78fA/WTaZH+bl5SdNjHQu7
         DPhE7NxEZFPbOOCMsvl/A9WLFnIDUBz8swIZCadbIsSoShm1Y5+0SOHIxHK7QIUi1EPv
         xej9K9S8C5JOEgAcDBLIaG8+eRy7un5u6qs0RGhcyZ2PRgDKDFdVHVIV3CcVDF52W7AK
         pLtFJDsP1akKhn8DMCozkVbvZOXlNqhqoE8V//J6tANUfq1OUIAbhQ3ANpooFNjFehcc
         5zU/6+oUsEdMc4JGJjRUPxTwmc98BQ3dOZKtBWtfm1G8/Lo/W2ha7hUUhTH7d2xpr2jQ
         isKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783969929; x=1784574729;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/NxveP/pyfIFv71kVfPTlg3b5XZeJTUOET5rnvr6kHo=;
        b=jbwPRJZ14Kd9ts1JkDZJeKZqO5C8yR6+3a5uVqQG0+Exqw1Uv21aqLJPngd5R7FWT/
         BwqbHpTY6CmiwkxP8w4ccDQhNTqKDbfa457094hNvPrmWw/uj/NZC+veJaS6FwF0Qgyl
         gXuvzLvtJVqNLAPq2ZvWGCiP11/IhYJ5Zk9hrPxTy+M5DZceSoHrzOghIgnOtkGFMn4z
         6Kw+qig1sHtFeq8sfB4kQGkwemAmu7z3jQS2wO5E7v0C4PNYfkigTQxFe/FfXw+NCCkP
         4yS0V/PY7T7LG9DGV+bsD+Cvrb8Vh/EBgZ6Bfu9xSB9rJDxd1e2tnJCvUiUi5et6ydkK
         DCxA==
X-Forwarded-Encrypted: i=1; AHgh+Rq9v768HYOSrySIWL02kwV+96gdhS/lGI1EJtFoJl4F/ohfBjIkqzawEmoohRb/4v+AZIT7ey8zaEPq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5jQrDUeDs+I7G8tmyhHWRqTs3JMrpqL6obB9zUQ0uTkAQY3et
	Fuyj7ZKcLq5Y96QXCPvkcC2u5dYwx/gwlz/HxAgCriAGzTKJa0C55qmTkPwxtG0upOY=
X-Gm-Gg: AfdE7ckNr4iLGgBTnxbTO1Snk0IoLyY3XGN6/VQleDDb2KOMOHHwv2ihOtJgMoKMmbF
	nUpzR68ODr+d6G4Wycs2mr93b958FvQsbunB9HnDOVrInoLBfAYAFvwqbccvtkeLRwiK9CxOm8I
	+mbP8AnYl2JFUdk3vSHb7spILq2WD7Of0XEvydY8/D3J+bJS1I9xNwgO/qIWIGCBF4Huk2fQTBO
	yhR4sbRAMSyv9RjeGaooL8xnuxbaCTg67x/NFnHopEvK9R+wGeFty8UcjpLpvgNigEiulgVK5wj
	G/ZG2cyu5yT9KxqUToA8dPDLG8xS8taeaRp4WLUryzcuXZW+lEIaBNypT7eDI+hpx789F1/chTx
	aWCkgeaYyFNELcWVPrJSg6caRKpoByRK+prAh+J0LKePR6XtF/YkUbXpXX1tq
X-Received: by 2002:a05:622a:551a:b0:51b:f217:539f with SMTP id d75a77b69052e-51cbf0569bbmr98856591cf.17.1783969928867;
        Mon, 13 Jul 2026 12:12:08 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caacad30asm88764001cf.9.2026.07.13.12.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:12:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjM4V-0000000E4Bs-31V7;
	Mon, 13 Jul 2026 16:12:07 -0300
Date: Mon, 13 Jul 2026 16:12:07 -0300
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
	Jiri Pirko <jiri@nvidia.com>, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 07/22] dma-direct: swiotlb: handle swiotlb alloc/free
 outside __dma_direct_alloc_pages
Message-ID: <20260713191207.GO3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-8-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-8-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:11AM +0530, Aneesh Kumar K.V (Arm) wrote:
> Move swiotlb allocation out of __dma_direct_alloc_pages() and handle it in
> dma_direct_alloc() / dma_direct_alloc_pages().
> 
> This is needed for follow-up changes that simplify the handling of
> memory encryption/decryption based on the DMA attribute flags.
> 
> swiotlb backing pages are already mapped decrypted by
> swiotlb_update_mem_attributes() and rmem_swiotlb_device_init(), so
> dma-direct should not call dma_set_decrypted() on allocation nor
> dma_set_encrypted() on free for swiotlb-backed memory.
> 
> Update alloc/free paths to detect swiotlb-backed pages and skip
> encrypt/decrypt transitions for those paths. Keep the existing highmem
> rejection in dma_direct_alloc_pages() for swiotlb allocations.
> 
> Only for "restricted-dma-pool", we currently set `for_alloc = true`, while
> rmem_swiotlb_device_init() decrypts the whole pool up front. This pool is
> typically used together with "shared-dma-pool", where the shared region is
> accessed after remap/ioremap and the returned address is suitable for
> decrypted memory access. So existing code paths remain valid.
> 
> Tested-by: Jiri Pirko <jiri@nvidia.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  include/linux/swiotlb.h |  6 ++++
>  kernel/dma/direct.c     | 71 ++++++++++++++++++++++++++++++-----------
>  kernel/dma/swiotlb.c    |  6 ++++
>  3 files changed, 65 insertions(+), 18 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
