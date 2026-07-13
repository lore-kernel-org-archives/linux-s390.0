Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FBC357D13
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 19:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971586; cv=none; b=LgMGEHI2YPbjsaXtEAhYdD6MzG+bg04RcNrpKGpeRIBwGoM7W7RoJyM5vy4lNJHxVNnKE4ZRgrnae285iqm2Bu39E4NXCYxlMnqKlse8CWi0e2i+9RbPpfzAbfusqoUndyLiO5Ad1kXpUj2D6QA4x0irqQL5BjHLSDWxoumB6p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971586; c=relaxed/simple;
	bh=6ObL/bIb2BF9Fm+HEWevziQ1Coe0QkELhGyBpHyDwZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRjAO+LLxp02Ps1Py6fkRO8eqUBEN6w0bR39bAy0gxU2CN7o/PtcgxBlceM1l9SuwaUi7qUTKlu7x3ojYAoxM2bDQYMwNnjRxS/5S7FB6G+rCZOTjMIOKLbl3v7EaAuR5bpukhqUV4OfJxUSPuA6hR2YWnORJIyg/wHKcwETIKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=olusSk7d; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="olusSk7d"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8f29ec73064so29508646d6.1
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 12:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783971583; x=1784576383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1JWJRfd6QdZf7qlUjcbW5D2kIZlwkQZ3KWr7+m1ApiM=;
        b=olusSk7dW857D7vkVHeKtqcn8E/C5XJj+roNCR3KosdtGCtKKWDyZO5Mfck5lpEywS
         OlV59SgB4Nqt8g/exVmlWH/61W2+NJKOBoxwlFOT6wNpABjNaVff5DhKkbBgvWSWDrsg
         Zqqr5fo1TuJbw7Z0KG1MGmZLxNjm6tvLVgGLXsqWzeKTyIf1PNJLcpFmkfdp9RvJwp9n
         loKEHBB7BgtI4MYTjo0UOVIyqXYF5lnniYLsi5AAe4Qr1SnHZ3EufwCB0MY+mzcmOBvk
         ltqlEQH9B+OX9ahmjVyRMJj7eo6DVNP9c8PjWyJAsbf/GaTM3w9v+JpH2r89YgLAWFQq
         8GEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971583; x=1784576383;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1JWJRfd6QdZf7qlUjcbW5D2kIZlwkQZ3KWr7+m1ApiM=;
        b=d7P6draE3RrEBRBpaKGfx+I5iG/PH5UKZ9YFZRL2UAPAtF7ZZ0ogaBhaaI0P39olzG
         t+DvEFQqy2LIzOAW9FFm0ducling1zaz4CF3xQmu89Zd0RE71Ys1NF764Y1mOoJO7r/P
         66o4phpG9uaJrYLPrRGMIidhRVyDl94RN3sv6BcFiaB1pzekOfd2kf+Qzef4IU5nVz7U
         siY8eXz2AgCsREONaVaPI5OHSeEue1z+fqLnQqE0gE7df00LaIgfobpbyURH0lJ6BqZG
         fG3kDXsxVdIVkf4xLNeqKOQPvbdv1hJuNe3lR8D3fy9lNar4FRTLsLQ3HPL4C/86T7Q5
         blEQ==
X-Forwarded-Encrypted: i=1; AHgh+RpMg/cAJ0/dW8VoA7ciMf9ZYNfqcex6Eaoao+TFfbD31X9+Ov8pqzhWWnw/4YyeZ4NBhQD693LhCGXC@vger.kernel.org
X-Gm-Message-State: AOJu0YwJwnCrYrumhjdW6hmiwa0PLmEaA8Nkh2OdaqkUBlr6xVt1Iz0r
	ja+xLHDGN2esW3H/fFNB15sJEB+SOZNA+B9+zJeQJIYYgGLxyk6wfsmDSrTsr6mabZM=
X-Gm-Gg: AfdE7clhkJOBp80zAwb3h5b/QR5Ovz0IoKCFK3Fsu1U8leD+HK4kujj2eISUao8n9zD
	M9MWw9jh+LIRRXTGQKNfvq/ujV4/sVXlx8RmxMZzeWlYoJvWzwpdMbdg/zFw74PO/u+inb5lcW1
	tgvlzfnXsnTVjb5yk7H/mMICALIoOKuGgPCO66aPb4R8VAb4VUxb4OEhtsJ0/Tx0JwJ8UzXfUsL
	UuKgpryeTTqpLMzb6+RlTLnt7pwq0p5LWqW+OuEJy5J2KCrXwl+8rgx2Hf5c2JHOKsg2KdJZ83s
	pwopG2U6Evx5t05dosGkCn+hictQoJhHrsFGYsTl8C9Uw/VHhuFs9G6wcU74ZZaHWxG3tXFi3qP
	EesfKX2gQfssx9/0jbPEt0o8wqZb29t3hqFIjEqJB0W7n4DjqfkcH+2n3LWGk
X-Received: by 2002:a05:6214:4c8a:b0:8f1:3533:7a83 with SMTP id 6a1803df08f44-90402c68b4dmr105755746d6.33.1783971582552;
        Mon, 13 Jul 2026 12:39:42 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90725bc050esm20419156d6.28.2026.07.13.12.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:39:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMVB-0000000E6bn-2D9o;
	Mon, 13 Jul 2026 16:39:41 -0300
Date: Mon, 13 Jul 2026 16:39:41 -0300
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
Subject: Re: [PATCH v7 18/22] dma-direct: select DMA address encoding from
 __DMA_ATTR_ALLOC_CC_SHARED
Message-ID: <20260713193941.GX3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-19-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-19-aneesh.kumar@kernel.org>

> -	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
> +	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
> +					 !!(attrs & __DMA_ATTR_ALLOC_CC_SHARED));

The !! isn't needed when going through bool, the compiler does it
automatically.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
