Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D12C2BDC32;
	Thu, 21 May 2026 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377884; cv=none; b=PCYBstV24qzUGTv+YXTAJ62prRwCVKeznjof0dIH2XM7vS9dSVGuIFF0EbWJPuByTpah5gD+FwKnFoi0g192LgHLqZoFKH1va7qncFlzDnQO1QPP4RWjfqtocmwIi5bmUyXhhyj65xUeqledF86fFGmWnP19g22iMp9tQTfxj0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377884; c=relaxed/simple;
	bh=4v79JhfkK7irUQUXGMhr5/E/7yX1WhwQVD6Rpohut0c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rddx3ij1DbtCSUDcmargZdiu41FW0zF2+86kb04g2IFcvpmTVIKX9VwwtnZcs7eKz0wpYoMyWMYZTty1e3rzVTH+dWl71cYcyQ2ysnlFdUTiuc87+e3/aaEDMKjDfZtKEBCJH6w91mOvlOQnnBGeuW8wMgm3VrO4oaUISOlsdCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKjGQCP1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKjGQCP1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055241F000E9;
	Thu, 21 May 2026 15:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779377883;
	bh=Qomyt6SRN6loAiKuzG+mnZMN+9NDAav5uB2vD7COXYY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=SKjGQCP1jUHZn8lGcvNb16fhytEsPovJvUrNUllKBoXBnYhKzZyiWFp5SXoR00qSh
	 4Yi1RUq4BpLuoEGXd/ZfpfHeWAgR0+SKGaVyCv/OICsvCL8QuRGyjiXEjI5giDln+y
	 nPHP27gGY79//Ncb34+zHprzV63ewWoOHLFrps3BSWb2kqL1XebtXJJN3TVZe3EV/k
	 urWUK7qq4xQ19I8ijQAMN6p1ereVXTWRx1/nsAg3dl09jZhyb9oK04vIX/Z5RdNTgn
	 97oMJkfi8HsdKYrcl3kj4rpuwHeCO8ecnTXfnja7vDYtRCrTlYPo8c5gdohMtv0jZ2
	 UZTZ7iyYKVbCg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 07/13] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
In-Reply-To: <20260512090408.794195-8-aneesh.kumar@kernel.org>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-8-aneesh.kumar@kernel.org>
Date: Thu, 21 May 2026 21:07:49 +0530
Message-ID: <yq5awlww6aeq.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:

> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
> index e05dc7649366..4e35264ab6f8 100644
> --- a/kernel/dma/direct.h
> +++ b/kernel/dma/direct.h
> @@ -89,36 +89,32 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
>  	dma_addr_t dma_addr;
>  
>  	if (is_swiotlb_force_bounce(dev)) {
> -		if (!(attrs & DMA_ATTR_CC_SHARED)) {
> -			if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
> -				return DMA_MAPPING_ERROR;
> +		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
> +			return DMA_MAPPING_ERROR;
>  
> -			return swiotlb_map(dev, phys, size, dir, attrs);
> -		}
> -	} else if (attrs & DMA_ATTR_CC_SHARED) {
> -		return DMA_MAPPING_ERROR;
> +		return swiotlb_map(dev, phys, size, dir, attrs);
>  	}
>  
> -	if (attrs & DMA_ATTR_MMIO) {
> -		dma_addr = phys;
> -		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
> -			goto err_overflow;
> -	} else if (attrs & DMA_ATTR_CC_SHARED) {
> +	if (attrs & DMA_ATTR_CC_SHARED)
>  		dma_addr = phys_to_dma_unencrypted(dev, phys);
> +	else
> +		dma_addr = phys_to_dma_encrypted(dev, phys);
> +
> +	if (attrs & DMA_ATTR_MMIO) {
>  		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
>  			goto err_overflow;
> -	} else {
> -		dma_addr = phys_to_dma(dev, phys);
> -		if (unlikely(!dma_capable(dev, dma_addr, size, true, attrs)) ||
> -		    dma_kmalloc_needs_bounce(dev, size, dir)) {
> -			if (is_swiotlb_active(dev) &&
> -			    !(attrs & DMA_ATTR_REQUIRE_COHERENT))
> -				return swiotlb_map(dev, phys, size, dir, attrs);
> +		goto dma_mapped;
> +	}
>  
> -			goto err_overflow;
> -		}
> +	if (unlikely(!dma_capable(dev, dma_addr, size, true, attrs)) ||
> +	    dma_kmalloc_needs_bounce(dev, size, dir)) {
> +		if (is_swiotlb_active(dev) &&
> +		    !(attrs & DMA_ATTR_REQUIRE_COHERENT))
> +			return swiotlb_map(dev, phys, size, dir, attrs);
> +		goto err_overflow;
>  	}
>  
> +dma_mapped:
>  	if (!dev_is_dma_coherent(dev) &&
>  	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO))) {
>  		arch_sync_dma_for_device(phys, size, dir);
> -- 
> 2.43.0

I guess we need this change on top of the above

modified   kernel/dma/direct.h
@@ -88,6 +88,13 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 {
 	dma_addr_t dma_addr;
 
+	/*
+	 * For a device requiring unencrypted DMA, MMIO memory is treated
+	 * as shared by default.
+	 */
+	if (force_dma_unencrypted(dev) && (attrs & DMA_ATTR_MMIO))
+		attrs |= DMA_ATTR_CC_SHARED;
+
 	if (is_swiotlb_force_bounce(dev)) {
 		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
 			return DMA_MAPPING_ERROR;
