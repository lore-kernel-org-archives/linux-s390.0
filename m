Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03037191
	for <linux-s390@vger.kernel.org>; Wed,  1 Jul 2026 06:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782886477; cv=none; b=EuCRIZYSISb9RQWMCrL0GX9cznAqyj1kngn1JxhMz7cc0C+K0mjDhngbv40Ei9zF6Q2PqKI1F/Xe8nem0RfKUNw0MohVx9S93YJuJKf99oHSkq7hl6fZt18TrsitEQGVtOH6kxCUvgXM/SCicUZj20I/5LuUd6XxF0ctL/Y+6rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782886477; c=relaxed/simple;
	bh=2MzbYZdIr8VROPTxeS7g/TGapFOf5+d4ECn6256ja5o=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lK9RUzxo8qfX+uYimv2T4ysSVD9Yf16XEPD80tpSZFY2nh4NNM2Zlx38PEPp7xyfPwOyapakInaXx6Pta4ITKfNbEojykNj8K1rlwQ0HjbDiCfhTzI1nM6xSQvNzIGDcj9MrYjp7tYoXXXDDrtSl3Wg6PG1v/MeP2tS5bW2l60w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHvnjmEp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHvnjmEp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E3C1F000E9;
	Wed,  1 Jul 2026 06:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782886472;
	bh=il8gdoZhwZNuejqkHHrWP1x1LZeovQ1aHxnK5+zggZU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=UHvnjmEpL4JAeaQFhQOjiNPaDpXBmbhN5sxfefk11G0g0onYIlDuvLYh41mlBWus9
	 nYsIThzxYj6rbGCwgSGxVRKkU/9TFTZZrRb8auDJFhjv27GX0tEqrsT3tYojWiz/Yy
	 OoCqk588ykr1nPJS3s8ddAErWyiUBAiBxOWq3A1omZ6zsKCfHwoo+a4sL8SzkG4ci/
	 ztGCgcPa3igjLuXYAeDCa12I8/54JYAG9DKTISPinZJXL1ROdLbehmyMgfV/adVnuU
	 K9509i0fLwcPKo6od0sxJ7KW4t4gO5/ucnunYH1CJgF69WcvTrT10b4PE/08eoEpKf
	 pPs64o5+LVz7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 15/22] dma-direct: pass attrs to dma_capable() for
 DMA_ATTR_CC_SHARED checks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260701054926.825925-16-aneesh.kumar@kernel.org>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-16-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 06:14:31 +0000
Message-Id: <20260701061432.16E3C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] xen_swiotlb_map_phys() unconditionally rejects valid MMIO DMA mapp=
ings for devices requiring unencrypted DMA, breaking peer-to-peer DMA.
- [High] xen_swiotlb_map_phys() fails to strip the encryption bit from boun=
ce buffer DMA addresses.

Pre-existing issues:
- [Critical] gart_alloc_coherent() and gart_free_coherent() pass an invalid=
 dma_addr to dma_direct_free(), causing severe page allocator corruption an=
d physical memory leaks.
--

commit d278e823d2c8033c6a6105a3f51b2763931c565f
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

dma-direct: pass attrs to dma_capable() for DMA_ATTR_CC_SHARED checks
   =20
Teach dma_capable() about DMA_ATTR_CC_SHARED so the capability
check can reject encrypted DMA addresses for devices that require
unencrypted/shared DMA.

Also propagate DMA_ATTR_CC_SHARED in swiotlb_map() when the selected
SWIOTLB pool is decrypted so the capability check sees the correct DMA
address attribute.

Tested-by: Jiri Pirko <jiri@nvidia.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Petr Tesarik <ptesarik@suse.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

> diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
> index e8000a56732e4..b5f1f031d45b8 100644
> --- a/arch/x86/kernel/amd_gart_64.c
> +++ b/arch/x86/kernel/amd_gart_64.c
[ ... ]
> @@ -473,7 +474,8 @@ gart_alloc_coherent(struct device *dev, size_t size, =
dma_addr_t *dma_addr,
>  		return vaddr;
> =20
>  	*dma_addr =3D dma_map_area(dev, virt_to_phys(vaddr), size,
> -			DMA_BIDIRECTIONAL, (1UL << get_order(size)) - 1);
> +				 DMA_BIDIRECTIONAL,
> +				 (1UL << get_order(size)) - 1, attrs);
>  	flush_gart();
>  	if (unlikely(*dma_addr =3D=3D DMA_MAPPING_ERROR))
>  		goto out_free;

[Severity: Critical]
This is a pre-existing issue, but does the error path in gart_alloc_coheren=
t()
and gart_free_coherent() pass an invalid dma_addr to dma_direct_free()?

If dma_map_area() fails, *dma_addr becomes DMA_MAPPING_ERROR, and the error
path at out_free passes it to dma_direct_free(). On success,
gart_free_coherent() later passes the GART-mapped dma_addr to
dma_direct_free().

Because dma_direct_free() uses the provided dma_addr to locate the backing
struct page (when dma_free_from_pool() is false), passing a GART aperture
address or DMA_MAPPING_ERROR instead of the physical DMA address causes it
to operate on bogus page structures, leading to severe memory corruption and
physical page leaks.

> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 8c4abe65cd49f..e2538824ef52e 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -212,7 +212,7 @@ static dma_addr_t xen_swiotlb_map_phys(struct device =
*dev, phys_addr_t phys,
>  	BUG_ON(dir =3D=3D DMA_NONE);
> =20
>  	if (attrs & DMA_ATTR_MMIO) {
> -		if (unlikely(!dma_capable(dev, phys, size, false))) {
> +		if (unlikely(!dma_capable(dev, phys, size, false, attrs))) {

[Severity: High]
Does this unconditionally reject valid MMIO DMA mappings for devices requir=
ing
unencrypted DMA, breaking peer-to-peer DMA?

When mapping MMIO memory, attrs typically lacks DMA_ATTR_CC_SHARED. For CoCo
guests under Xen, force_dma_unencrypted(dev) is true, so dma_capable() will
evaluate !(attrs & DMA_ATTR_CC_SHARED) && force_dma_unencrypted(dev) as tru=
e,
thus rejecting the mapping.

While dma_direct_map_phys() was fixed elsewhere in this series to append
DMA_ATTR_CC_SHARED for MMIO, it appears xen_swiotlb_map_phys() was missed.

>  			dev_err_once(
>  				dev,
>  				"DMA addr %pa+%zu overflow (mask %llx, bus limit %llx).\n",
[ ... ]
> @@ -253,7 +253,7 @@ static dma_addr_t xen_swiotlb_map_phys(struct device =
*dev, phys_addr_t phys,
>  	/*
>  	 * Ensure that the address returned is DMA'ble
>  	 */
> -	if (unlikely(!dma_capable(dev, dev_addr, size, true))) {
> +	if (unlikely(!dma_capable(dev, dev_addr, size, true, attrs))) {

[Severity: High]
Does this fail to strip the encryption bit from bounce buffer DMA addresses?

When a DMA mapping requires a bounce buffer, swiotlb_tbl_map_single() alloc=
ates
an unencrypted buffer and injects DMA_ATTR_CC_SHARED into attrs. However,
dev_addr was set via xen_phys_to_dma(dev, map) right above this check, which
relies on phys_to_dma() and unconditionally applies the physical encryption=
 bit
to the DMA address.

Because attrs now contains DMA_ATTR_CC_SHARED, dma_capable() will approve t=
he
address. As a result, the device erroneously receives an encrypted DMA addr=
ess
for decrypted memory.

>  		__swiotlb_tbl_unmap_single(dev, map, size, dir,
>  				attrs | DMA_ATTR_SKIP_CPU_SYNC,
>  				swiotlb_find_pool(dev, map));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701054926.8259=
25-1-aneesh.kumar@kernel.org?part=3D15
