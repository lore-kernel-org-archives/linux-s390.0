Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89DF34C981
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 17:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965438; cv=none; b=G8glO8QePAfibV2Cjz1M3aMTfckzKt8H93Lib13FYZj7wYBlbw0fV9lMAjaBd9vQ8af0F6uwqvG9/0ShFw52GqCTOeE895teyxt4606hPutRxURSi56tqEaDQZvYazu6uC97z+w5YoP4NEoerdrhw4wX7iLnyGPfLHTh7EB+S6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965438; c=relaxed/simple;
	bh=/p42+HpNsjMWY1GT2uoeKq2/f492YfHBxuTyaBrOVBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZojeFhgybZGqvaE82YXo0sy74WRb/VrXbjaCIocPpvX0Bxe3OtciQIUN8Wdy2sxNH1Laz2VOCVEKeGwM2f6f47yezXFWGtbDDLwVVOYDgD7L9j5Kz9AUWifJ3y9ivWTTP7SBdhrBmZq9fR3EhObbf0cH6Si+eAIGkvdrxMtUQWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lgPjF6ZV; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lgPjF6ZV"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-902f92b8504so26291226d6.2
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 10:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783965435; x=1784570235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YGHI47Uk7ivYjDw6pJp4pRueuEDSB7hHUc7Dm7encu0=;
        b=lgPjF6ZVxbMDJg0tWwfH7PZN5SECceDZGHPsWNqHsaUt/EzMKhWGSZzZdGiKPM2kY+
         onblgJU5hApPT/O0xgM+RpuEmYrbw8a0TQi9NKsWhXb+itmJBsRDAXUK45AXQ8Qo5Xh6
         V1x6FF2+S3debIsb3hDaFnwMEdKHIyIe4tYvZ8Bvw7WYpw8zgUJVgB8fntgtI4e6Bgsg
         Cep4Z7d4HtgKVzlfCP+LpAoYYnnvazknuEofog2E7V7+CcVypzYIB5WHGhVvkM9jnKhH
         CWkYdtDiGYOK4tBh+xehYPSg1ORre4KeHWeDJ1VCajbxsOiPaFjbvK7y4Qjl5gtFphyN
         OqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783965435; x=1784570235;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YGHI47Uk7ivYjDw6pJp4pRueuEDSB7hHUc7Dm7encu0=;
        b=S/Qh4T8uSaYemI7974NngFl4EH4AMkYaS7+N7DVA5zjvICyvTsxov75EbyH2lBO8Wh
         JQTNWkTPtTVYVKn093gHShA9wkwnP/mjn62dqxTzl45fzRR8jRIqZ5FhlG2BrYUQg6ji
         3lmQ+RV4/8kWEx3JWGLcY3V6Nz44juIDOHVLXiXhKMqKY08zLuwz4ttSq4hVSHuCad71
         fuwQzX/clVd5CaQQZli2276hV89J76IIWHT2zCPVqkKgbBlD5Ek9ph+x/28pV+wr028i
         s2V9Dg7LAd6EWHTBkY3lqhXV5dBGk/ZnPyjFmXkXBNllKIfymkTVHXqqLtG7x0I084XL
         H8Lg==
X-Forwarded-Encrypted: i=1; AHgh+RrTBNKduOHIoVuv3yyTvlHWG34LheWZcrDXaBWo3LFaHuZW9aEwfWEoolta1Vkt6nQZonIrFIzkKFkP@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfom91t53Vm76aOLtYQsMdsgf+lWO6aINytb6ExDM53vNFIHSD
	ku0uIo7c3Vejk2agiKAJAW/jgTdwjXmQDcJeBum95+MPe33HCZXmUzDXgM/3bqZE4ys=
X-Gm-Gg: AfdE7cn+CubHqINHED7p2BF5g2gaql5msUC0iG3xaB3UrA9gLrX8AUlxxLic8ie2Axe
	weL9PN+o99Ofmhe9fTH8my6SWQN8tA8ozrdK0CIbik3qQImYfNpo6BSgDQaybJkZTCZAww1ZVTO
	6B9jlIdafwe4P4kam6o16mjePFLlVtGSLSTbBj2My5Tf3544I1Bw5F5ZWiEtv81STk1tL2Cx8rC
	qr2M90Da4RR4/5g05gnO4cyus0qnXPkHwgYXk+lMU7ToTZozGdTQDfbSPMyeFJVwewr1tHEnAuj
	CReII8gS2gxgP4oViEdxafYvvvgvGLp0auimMNH2BYB47hOMIIsfxawNX9aLMTDm6czxM7uOlX2
	ns6VwfU2lpfrnP3syTikKsq024bQirOWe9mxZKePxlb0XIglVzrxGpTxtftt3
X-Received: by 2002:a05:6214:5012:b0:8ff:60cd:8174 with SMTP id 6a1803df08f44-904053d8c92mr120238636d6.60.1783965434905;
        Mon, 13 Jul 2026 10:57:14 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e082csm149305496d6.5.2026.07.13.10.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 10:57:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjKu1-0000000DxAz-2t49;
	Mon, 13 Jul 2026 14:57:13 -0300
Date: Mon, 13 Jul 2026 14:57:13 -0300
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
Subject: Re: [PATCH v7 03/22] iommu/dma: Check atomic pool allocation result
 directly
Message-ID: <20260713175713.GK3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-4-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-4-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:07AM +0530, Aneesh Kumar K.V (Arm) wrote:
> The non-blocking, non-coherent allocation path uses dma_alloc_from_pool(),
> which returns the allocated page and fills cpu_addr only on success.
> 
> Do not rely on cpu_addr to detect allocation failure in this path. Check
> the returned page directly before using it for the IOMMU mapping.
> 
> Fixes: 9420139f516d ("dma-pool: fix coherent pool allocations for IOMMU mappings")
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Petr Tesarik <ptesarik@suse.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  drivers/iommu/dma-iommu.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
