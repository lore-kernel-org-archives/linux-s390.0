Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C74346A07
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 19:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783970707; cv=none; b=qdXNwPcXonX8nNIPy29EYeJtJQq86QPA2I6ePNWmen2BnjgoRuSPajZ4bMBXEPRziSHbm+nAnlawd3coa83ThhswBaw6ij6kvtVk0GA/W3Wh/mr8kPXKYro9YabDdhNr8yFeepT38he2cm6KujzHJPGWs5YM6Z/oNV7Re0cKEEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783970707; c=relaxed/simple;
	bh=kHNC6GKxK3Oa0yY2t9YDWJJoMMfSAWNNMKsiuCwI/8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mD+uZ9H5UaNjIXlRdpASZA/QK9roERIiTAWpLNk5h8h9Sj+45ulSx5TfOHCAArNe/Or7IkcuvpMFGd0I+BZkpgeIM/ZpjDNevLpKgS5J1OVyAKe4S0/OKUM5iOQ1zfgb9d9wiwP6JlDVL+1i4f+PcEcuzzzrRyKwka9e/6rukvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=G38VB55r; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="G38VB55r"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c08df8513so1660431cf.3
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 12:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783970704; x=1784575504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2kWy2240zOoLDDzwtKisgk31mZ51kjxw8fZyoUW4j0E=;
        b=G38VB55rczL+HtL37bAUlUAettcihLt8qw6IsSvTED/EB4k6c1rfaN6bxrCXj+zG7t
         DlpxUo2efzT7g9i6Sdr7GGswN524GurYxz0IJ4yKzh8ugLcJsMaP1paKJYg+0+qUM02y
         kNh9ehHuxBOpuxmnYJTG6V6gnHseXk9P+D0D/SaqZp+kMDY582RSGsG09PRUEbqhlHls
         MyH0BbkF7gujhewYW7gPfSjJ6h7L4P3z31F9S+QewRVTP32Dtscjc3DW4oBMWXHhd+Il
         f0RIfBvaWgXY4GDt+QPb9HzdnhXUr1p/b2HVetn6BCKL7RdR6yYvj3TNYdbvPw/4rPZ0
         KCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783970704; x=1784575504;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2kWy2240zOoLDDzwtKisgk31mZ51kjxw8fZyoUW4j0E=;
        b=tUdOJ1Ha60IiAtV6YQy4gMf84sxJ4QMzAKO3Q99Ov9nmmCzrlrT7jgJRTZ7bEmURxW
         EfNXR81i4G1fwFkLaYhF8ZLDH8xLUsVfA+mRg3+GtVSlhnTETzLo36ANSUu6D3UzhHkq
         xM5PHU2p31981BS7dyahzF3zNxd3cqesMGJ/ruf928YgxiV9ZffN0XsfA+2vr/2C4Da/
         K76pgrWKTmhQC+7kYqEFdg1m3uXqS0vpTu7JXkFJWj8/w9cg2LvSvf8DijUNywujb7De
         RnfHXgMvVBveiyWDz4dtWBS+61nhyLE6wRIzPxcGepR/AnsPaUZQT1KFq/hj0mqVWzYD
         dllg==
X-Forwarded-Encrypted: i=1; AHgh+RpWZTqDjaCzmrqjQVsQphGWEfu6jmZLr+/93sUurx2HKUOTZowrRijb6avxOmBuaTsqKUuD96RcvFyY@vger.kernel.org
X-Gm-Message-State: AOJu0YxE5yvNIcHqq478HK49xeDLkUA1CjpfAFNIDymp9i3b4Z16Js4m
	oeQF0hoedZuGBXCdxHsUs2FtOadNmWmg3ecuODLW9hrHaAuIlWNclEiPAFPuLOxhyJbGwnhbLjO
	PGxG9
X-Gm-Gg: AfdE7cltpBJJEil7skFJhgHUt6Y8mn/O0Zdb06QC0EMsjlWRj41ffffDKUBcJ41rtxx
	TUP07m3PHWKgp7rhvFH1e/F9u91u6kRDPQiM/A0jMDqCUCqDlikX7024d46WqeE5jjJ+L67hnop
	Z78bffhC07Q4UA+A6B1dH81AWJ5elWJD5pKMIeGn6/XIFJuN7yNBxmcGu48SiwM0tiZpcUwJiVJ
	LCdXZhIPKrPkGZA0mfnbsSh2TuGilABR6xLOIA7GZx+vsGtx7jxalxfY7Mqxva3jRfVh1Tkonv8
	BGKZKJT871yFKF0Uj2lqEjiYHg20Ps9lEJdGkesgs3r3SNFnGcXghrsuOW5SaPSzwgKyPZewIgY
	SZSAJFCGPG6gti/TPLwTaLTxARC4I1QiwIAGQkmYt6BUjJrfqSV0r4RLKUQ5v
X-Received: by 2002:a05:6214:2f8d:b0:8ef:76c:cb18 with SMTP id 6a1803df08f44-903fe450e81mr122377626d6.11.1783970703547;
        Mon, 13 Jul 2026 12:25:03 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1da1bsm137170026d6.30.2026.07.13.12.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:25:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMH0-0000000E5NW-1O3S;
	Mon, 13 Jul 2026 16:25:02 -0300
Date: Mon, 13 Jul 2026 16:25:02 -0300
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
Subject: Re: [PATCH v7 13/22] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
Message-ID: <20260713192502.GS3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-14-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-14-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:17AM +0530, Aneesh Kumar K.V (Arm) wrote:
> Teach swiotlb to distinguish between encrypted and decrypted bounce
> buffer pools, and make allocation and mapping paths select a pool whose
> state matches the requested DMA attributes.
> 
> Add a cc_shared flag to io_tlb_mem, initialize it for the default and
> restricted pools, and propagate __DMA_ATTR_ALLOC_CC_SHARED into swiotlb
> pool allocation. Reject swiotlb alloc/map requests when the selected pool
> does not match the required encrypted/decrypted state.
> 
> Also return DMA addresses with the matching phys_to_dma_{encrypted,
> unencrypted} helper so the DMA address encoding stays consistent with the
> chosen pool.
> 
> Tested-by: Jiri Pirko <jiri@nvidia.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  include/linux/dma-direct.h |  10 +++
>  include/linux/swiotlb.h    |  10 ++-
>  kernel/dma/direct.c        |  13 ++-
>  kernel/dma/swiotlb.c       | 177 ++++++++++++++++++++++++++++---------
>  4 files changed, 162 insertions(+), 48 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
