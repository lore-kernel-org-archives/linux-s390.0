Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD772135AD
	for <linux-s390@vger.kernel.org>; Tue,  9 Jun 2026 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781010756; cv=none; b=JFcjb7DxbShseb73UNGTk+mdhGtSkaNLjuWb2Wq4ecH0dfdk/nQImPdtVQ4kgzxKxpgkIylqWqiN4ICLDx1mZJuK3ooC72rxWIb0V/zvMeR1zA/Oz42404OH5ZGaIcjdm3W38sBr4h3kHuE95gSDqYKZGNO2PP0kpQtBoV5t9Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781010756; c=relaxed/simple;
	bh=cRmrex5oPCwg42dkdhJaD73cEwhY7jfqwVZ+TJf7vSo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/O9RYGBP5NFxqakZ87aAuzNcnFrel25gcO81K+TE2i6ZfS5g9UzEztHHoxjg+BNzdjAqff5H91l+8BNCIju5OZT4zkfujJGag+KFh29MEudmmqW36FvCBDiB38/bNvv/tZNLBhzf7OoCINZhrMO8MRV6ShkWIcg32IYRJds9aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AKNuI2v0; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AKNuI2v0"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490c28f84fdso9551975e9.0
        for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 06:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781010754; x=1781615554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOb0YWdrCyqRf70PqWxcCcSyY2RJrYltX6EkSx4+w3M=;
        b=AKNuI2v055wKL5+W3JqPxgf1MwVtlePBhAtv9nDHGhbadv1s8XuAFW3BJKSygjmAb2
         pf4ydMyAZUPxhbZeGg8GYp3UEsxOcH7X2gs91g8w2svLEAsdKACYZ9s0hMHKws1DrOz4
         fZx0SSuS0M+2eoF2QZGzPoLB9WlWm0SQ/UTMT8A8Mcd59lHCG9YNDlH7Z5rLu9oBspxc
         lb7HdfNM5G6ndsNJxwjYpslx+phD2ZITINX3Eb+XncIwjFY7Uufef6jc8Ujr1UVr9OrR
         Z+0uYyP+fCIPoPBpHL4UN3BYGce7IPtlhCKXEwLc3L3cV0pnj1wEPGR12mBHJpbZmKO7
         1ZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781010754; x=1781615554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jOb0YWdrCyqRf70PqWxcCcSyY2RJrYltX6EkSx4+w3M=;
        b=Unw5xBvkq/c6sPQ3KV4BkuJDpKZH3Qc6CgGcku5Ooq2OZN5A1Y0FCF6mNC9FwrWQLi
         vpOpekuL5DgBVtR3Pb8XlkAfvesXWC1n4QlLI9nTFUbt73Hfdu2jAJfY3EjxwGTORKXQ
         w6DKvojQj08TfQ0SY5VT9GC5aQFc4pOpEm20J8h2/K4/F3kHEcQCTqdV7KuJbvZ+qO8/
         XhLCp4EkR0gb/AWX6X3y5ENIeHr2OqnInfMSD0VMvRdz/q3iVAhJQvK46TFHyk9Y6KJt
         TQzN+MSE+mwGl+QzsovIJFzLA0DCRKrDdWRQSIXizk6ntoxdlcfpniW1YMgDo3j/B1yQ
         XnGA==
X-Forwarded-Encrypted: i=1; AFNElJ8Exm3tjqILjWSvrgAwsbNEN2B8WdxmxT8+iksZbvHQYcm70cd7NJgOl0BGAcl+Aj3vRPGuh8nCEet0@vger.kernel.org
X-Gm-Message-State: AOJu0YxwuPkSH5DVSVTT4eBqTPRQazMhxNqtpidrsC7ybr2t5sI+zxOH
	rPkc+KQnb7WanNhJA8COJtzOMzqLnqWl6lqpO3JM3n/fbUCZtFhGTU2e6qtQ6gKxZBo=
X-Gm-Gg: Acq92OHE9pMk3cv5rdUAzf6aeih/I1WoSnPSGWaNJ+rgVCvCWphUZc72mGnwUQyLpi8
	1YC/W++mV+g5MESI8N/QmdPtmjiE0O+upo1wdsEivRoLyC1wP/NjpMO72uIKfuTr+tv+54uF2Hj
	EsRe8LlUf7dUvhIyf25EDYgJkzVgkhqlqMA4s62kSXtYdo3v1pesGs8trD0YM5iEwfBnbjVCH3m
	4Oyimn3kiPdnx1lxQIO8dgirGnmPUpyhFWbQr7rf/IAXB7TCBpFMMjaqpQMTrzf4sZS2cXPq5DZ
	3DJZSHRqLS1KKspjMwOEYQYVlzKzfFJ2JZA9Gam9bCxQBZYZz7pyOD5RWHFRXTGuJGwlxHMyk/G
	24ymIkwxX47oYVKAfa2iI7nwj7RB2RUupDT2NOD4PWSyd8qAUeiXyVnVIPd8a+RE+nahqMnayo/
	iWr2fnF783kWR7FMD+JJZIvDE=
X-Received: by 2002:a05:600c:8b65:b0:490:b4d4:5c16 with SMTP id 5b1f17b1804b1-490d72759f0mr16962775e9.8.1781010753634;
        Tue, 09 Jun 2026 06:12:33 -0700 (PDT)
Received: from mordecai ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d69sm111677469f8f.29.2026.06.09.06.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 06:12:26 -0700 (PDT)
Date: Tue, 9 Jun 2026 15:12:22 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, Robin Murphy
 <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Will
 Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Steven Price
 <steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>, Jason
 Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Alexey
 Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, Xu
 Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, x86@kernel.org, stable@vger.kernel.org, Michael
 Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 14/20] dma-direct: return struct page from
 dma_direct_alloc_from_pool()
Message-ID: <20260609151222.476a5521@mordecai>
In-Reply-To: <20260604083959.1265923-15-aneesh.kumar@kernel.org>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
	<20260604083959.1265923-15-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jun 2026 14:09:53 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Commit 5b138c534fda ("dma-direct: factor out a dma_direct_alloc_from_pool
> helper") changed dma_direct_alloc_from_pool() to return the CPU address
> from dma_alloc_from_pool(). That fits dma_direct_alloc(), but
> dma_direct_alloc_pages() also uses the helper and expects a struct page *.
> 
> Fix this by making dma_direct_alloc_from_pool() return the struct page *
> again, and pass the CPU address back through an out-parameter for the
> dma_direct_alloc() caller.
> 
> Fixes: 5b138c534fda ("dma-direct: factor out a dma_direct_alloc_from_pool helper")
> Cc: stable@vger.kernel.org

While I totally agree with the reasoning and the fix, it's interesting
that this bug has been apparently present in the kernel for 5+ years
without anybody hitting nasty memory corruption bugs.

How can it be? Is the buggy code path never actually used in practice?
Does it hint at a missed opportunity to simplify the code?

Anyway, these these thoughts are intended for a possible future
cleanup. For now, let's apply the fix as is, of course.

Petr T

> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  kernel/dma/direct.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 4e446aa4130e..e0ab9ff3f1d6 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -157,24 +157,24 @@ static bool dma_direct_use_pool(struct device *dev, gfp_t gfp)
>  	return !gfpflags_allow_blocking(gfp) && !is_swiotlb_for_alloc(dev);
>  }
>  
> -static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
> -		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
> +static struct page *dma_direct_alloc_from_pool(struct device *dev, size_t size,
> +		dma_addr_t *dma_handle, void **cpu_addr, gfp_t gfp,
> +		unsigned long attrs)
>  {
>  	struct page *page;
>  	u64 phys_limit;
> -	void *ret;
>  
>  	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_DMA_COHERENT_POOL)))
>  		return NULL;
>  
>  	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
> -	page = dma_alloc_from_pool(dev, size, &ret, gfp, attrs,
> +	page = dma_alloc_from_pool(dev, size, cpu_addr, gfp, attrs,
>  				   dma_coherent_ok);
>  	if (!page)
>  		return NULL;
>  	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
>  					 !!(attrs & DMA_ATTR_CC_SHARED));
> -	return ret;
> +	return page;
>  }
>  
>  static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
> @@ -270,9 +270,12 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	 * the atomic pools instead if we aren't allowed block.
>  	 */
>  	if ((remap || (attrs & DMA_ATTR_CC_SHARED)) &&
> -	    dma_direct_use_pool(dev, gfp))
> -		return dma_direct_alloc_from_pool(dev, size, dma_handle,
> -						  gfp, attrs);
> +	    dma_direct_use_pool(dev, gfp)) {
> +		page = dma_direct_alloc_from_pool(dev, size,
> +					dma_handle, &cpu_addr,
> +					gfp, attrs);
> +		return page ? cpu_addr : NULL;
> +	}
>  
>  	if (is_swiotlb_for_alloc(dev)) {
>  		page = dma_direct_alloc_swiotlb(dev, size, attrs);
> @@ -445,7 +448,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  
>  	if ((attrs & DMA_ATTR_CC_SHARED) && dma_direct_use_pool(dev, gfp))
>  		return dma_direct_alloc_from_pool(dev, size, dma_handle,
> -						  gfp, attrs);
> +						  &cpu_addr, gfp, attrs);
>  
>  	if (is_swiotlb_for_alloc(dev)) {
>  		page = dma_direct_alloc_swiotlb(dev, size, attrs);

