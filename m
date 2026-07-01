Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418B4386C24
	for <linux-s390@vger.kernel.org>; Wed,  1 Jul 2026 06:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782886452; cv=none; b=cZtEepGSk+4NqxIthjUgX4z1VEeW5HlNGI0zrhbp39+es7KQTAjl+XSXqO0H9w7/tB3YDG6kGkDaCrtYpdkWjoPq+XBKt2XOSXK9CtVzl17x47I6Tdiqj+OE6T0sXYaUjNPcR+aIumtErm0MiEdPAFVVTkF4DdJp6pgxZnGJUkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782886452; c=relaxed/simple;
	bh=TJtk39p9GeF3lodWbyOKS3asKYOKwCFMa1cAsTccJP4=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=abRWVBM0frASP7gSKTuFwSvAVcx0X5vZkyLMsJyMfjEW5peOoBPyYFsHXc0ganvS66MEEnYcKK2szqSTEePf7kECK/SA5hkJmSlSetFvxvUoDmYqwQDjCs4yOKXkE7j/eJhJ/P22u4kATExd7ub49rTMEzxYP0auoZGwk9DM2jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Otpl3XCv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Otpl3XCv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B4A1F000E9;
	Wed,  1 Jul 2026 06:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782886449;
	bh=Ebanz5j1FnGHj+79A2OIMWDR9YSWGglOoGwyt+5OjeA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Otpl3XCvF8RRsmVyX3iZ3EZziP2C2N7Is1XsnKTAjdAc+ZDQghrdKHewDahgeLYKN
	 +g25oQIWzHV6ycEMzrI2ViO8XTy9JJkvhzXkavvoi5XHebxsAN89uSZK/L4uVMknLJ
	 oTX+l/6rK7qsw/75HAhlja6U6Cvo34s3c361W4oJGYj0vO6k6Qa8QBtbDvFnnWipco
	 qhdblb/R1M2KXBL6BDVy5oyiZE479iF4v+Fn5eRjqhb8N09VNOQTOY2V0prhQoEw5k
	 amnehE7vyVgpYMo2o6PC14PwWLQkh2ifUpyoufP0vvlR3rggtWZRg9bMVPKcI6RpzJ
	 Y2V0p0DxSZ+qQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 16/22] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
Reply-To: sashiko-reviews@lists.linux.dev
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260701054926.825925-17-aneesh.kumar@kernel.org>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-17-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 06:14:08 +0000
Message-Id: <20260701061409.56B4A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] dma_map_resource() fails for devices using a dma_range_map that do=
es not cover MMIO regions, as DMA_ATTR_MMIO mappings are now unconditionall=
y subjected to phys_to_dma() translation.
- [High] Peer-to-Peer DMA (MMIO) breaks on AMD SME systems because the memo=
ry encryption mask (C-bit) is erroneously applied to MMIO addresses, potent=
ially causing memory corruption.
--

commit 5904e27516915147560df0a4dd16561a829eaf9e
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_SHARED

This commit modifies dma_direct_map_phys() to select the DMA address
encoding based on DMA_ATTR_CC_SHARED. It uses phys_to_dma_unencrypted() for
decrypted mappings and phys_to_dma_encrypted() otherwise, while preventing
the swiotlb force option for several architectures' secure-guest setups.

> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
> index e05dc7649366a..f3fc28f352ba1 100644
> --- a/kernel/dma/direct.h
> +++ b/kernel/dma/direct.h
> @@ -88,37 +88,40 @@ static inline dma_addr_t dma_direct_map_phys(struct d=
evice *dev,
>  {
>  	dma_addr_t dma_addr;
> =20
> +	/*
> +	 * For a device requiring unencrypted DMA, MMIO memory is treated
> +	 * as shared by default.
> +	 */
> +	if (force_dma_unencrypted(dev) && (attrs & DMA_ATTR_MMIO))
> +		attrs |=3D DMA_ATTR_CC_SHARED;
> +
>  	if (is_swiotlb_force_bounce(dev)) {
> -		if (!(attrs & DMA_ATTR_CC_SHARED)) {
> -			if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
> -				return DMA_MAPPING_ERROR;
> +		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
> +			return DMA_MAPPING_ERROR;
> =20
> -			return swiotlb_map(dev, phys, size, dir, attrs);
> -		}
> -	} else if (attrs & DMA_ATTR_CC_SHARED) {
> -		return DMA_MAPPING_ERROR;
>  	}
> =20
> -	if (attrs & DMA_ATTR_MMIO) {
> -		dma_addr =3D phys;
> -		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
> -			goto err_overflow;
> -	} else if (attrs & DMA_ATTR_CC_SHARED) {
> +	if (attrs & DMA_ATTR_CC_SHARED)
>  		dma_addr =3D phys_to_dma_unencrypted(dev, phys);
> +	else
> +		dma_addr =3D phys_to_dma_encrypted(dev, phys);
> +
> +	if (attrs & DMA_ATTR_MMIO) {

[Severity: High]
Will this break dma_map_resource() for devices that use a dma_range_map?

Previously, DMA_ATTR_MMIO addresses bypassed translation and directly used
dma_addr =3D phys. By routing MMIO addresses through phys_to_dma_encrypted()
or phys_to_dma_unencrypted(), they now pass through __phys_to_dma().

Since MMIO addresses do not reside in system RAM, they will be absent from
the device's dma_range_map. Doesn't this cause translate_phys_to_dma() to
return DMA_MAPPING_ERROR and fail the mapping?

[Severity: High]
On AMD SME systems, does this inadvertently apply the memory encryption
mask (C-bit) to MMIO addresses?

If a capable device performs Peer-to-Peer DMA, force_dma_unencrypted(dev)
returns false, so DMA_ATTR_CC_SHARED is not set. The MMIO address then
passes through phys_to_dma_encrypted(), which injects the C-bit via
__sme_set().

If the PCIe Root Complex receives an MMIO address with the C-bit set,
will it misroute the transaction to system RAM instead of the target PCI
BAR, potentially causing memory corruption?

>  		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
>  			goto err_overflow;
> -	} else {
> -		dma_addr =3D phys_to_dma(dev, phys);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701054926.8259=
25-1-aneesh.kumar@kernel.org?part=3D16
