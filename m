Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD4B4D8D8A;
	Tue, 19 May 2026 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779193670; cv=none; b=Zm7B+BbQIanyG1MMKLkW1aT/NsUnS+pUSo0KR+IDZM0jvAXiHwn/I/kCavny0NoSeiAeqO5A+hHQ6vDSw+h9hpn6RrTH6qpgNLIohIrXbbTkAODbajO7ySUO10/XKCgaZlG1+GHGHDemOzCZoSiWVuqoMf9ZjMwxcZ+dWdV1I6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779193670; c=relaxed/simple;
	bh=oh5xPm7aO87/jnT+7JZsE59suIMOg+uwG7kUANkSuuI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UgYP2ZN1bu8X7N82Kphg4pMBUtjxF8fOVBswNQ1aReGhU3oTsejdUw9jgar9XQgkYvgOz/HST8jZCRE0J9WISU1Q8AJHaeD73J2xqnsACN2Az4W5u0MgryQ6r8Mf+mqouxKQN0RX5ynhtUO6tVx1z2l/3gLoOEC4K2vLuM//u/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3oeSiK5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3oeSiK5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C3FC2BCB3;
	Tue, 19 May 2026 12:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779193670;
	bh=oh5xPm7aO87/jnT+7JZsE59suIMOg+uwG7kUANkSuuI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=s3oeSiK56KkasaDy21lXdRfQDszSI3yWcCMnoLlKn+41S+6zU+PAJqEy2hv5A8k+E
	 GtFnA/KesjHZTSVPVbtE0+H6iwxJYXPK16SxOeloY4HxuZnWheY5jMOXopVGzmD/tX
	 x0estu0/tyUMY5mo9AOcnX4J4MK/2WrIN/uHZSCL9536avpyokio0u8SsTUgEz0JZS
	 krheaIjJ+T0JM9+sgG7PVkxCYbXPfMPvZiIraW7/42ON+11dSoUaWtXRmITP+pQZ6v
	 MR6kg+qxSRKziQEl05pFMLwJ1RLRLf5uTVMWAk0hWiC8FQd6nHG9rmr97bALIPojqF
	 8G/bTvvjCUjWw==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
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
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
In-Reply-To: <agxDxdxynp4KEovA@google.com>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com> <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com> <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com> <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com>
Date: Tue, 19 May 2026 17:57:39 +0530
Message-ID: <yq5amrxvshxg.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mostafa Saleh <smostafa@google.com> writes:

> On Thu, May 14, 2026 at 08:13:25PM +0530, Aneesh Kumar K.V wrote:
>> >>=20
>> >> What I meant was that we need a generic way to identify a pKVM guest,=
 so
>> >> that we can use it in the conditional above.
>> >
>> > I have this patch, with that I can boot with your series unmodified,
>> > but I will need to do more testing.
>> >
>>=20
>> Thanks, I can add this to the series once you complete the required test=
ing.
>>=20
>
> I am still running more tests, but looking more into it. Setting
> force_dma_unencrypted() to true for pKVM guests is wrong, as the
> guest shouldn=E2=80=99t try to decrypt arbitrary memory as it can include
> sensitive information (for example in case of virtio sub-page
> allocation) and should strictly rely on the restricted-dma-pool
> for that.
>
> However, with my patch and setting force_dma_unencrypted() to false
> on top of this series, it fails on pKVM due to a missing shared
> attribute as Alexey mentioned, as now SWIOTLB rejects non shared
> attrs, so, the DMA-API has to pass it. With that, I can boot again:
>
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 5103a04df99f..b19aeec03f27 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -286,6 +286,8 @@ void *dma_direct_alloc(struct device *dev, size_t siz=
e,
>  	}
>=20=20
>  	if (is_swiotlb_for_alloc(dev)) {
> +		attrs |=3D DMA_ATTR_CC_SHARED;
> +
>  		page =3D dma_direct_alloc_swiotlb(dev, size, attrs);
>  		if (page) {
>  			/*
> @@ -449,6 +451,8 @@ struct page *dma_direct_alloc_pages(struct device *de=
v, size_t size,
>  						  &cpu_addr, gfp, attrs);
>=20=20
>  	if (is_swiotlb_for_alloc(dev)) {
> +		attrs |=3D DMA_ATTR_CC_SHARED;
> +
>  		page =3D dma_direct_alloc_swiotlb(dev, size, attrs);
>  		if (!page)
>  			return NULL;
> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
> index 4e35264ab6f8..8ee5bbf78cfb 100644
> --- a/kernel/dma/direct.h
> +++ b/kernel/dma/direct.h
> @@ -92,6 +92,7 @@ static inline dma_addr_t dma_direct_map_phys(struct dev=
ice *dev,
>  		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
>  			return DMA_MAPPING_ERROR;
>=20=20
> +		attrs |=3D DMA_ATTR_CC_SHARED;
>  		return swiotlb_map(dev, phys, size, dir, attrs);
>  	}
>=20=20
> --
>

How about the below?

modified   kernel/dma/direct.c
@@ -278,6 +278,10 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	}
=20
 	if (is_swiotlb_for_alloc(dev)) {
+
+		if (dev->dma_io_tlb_mem->unencrypted)
+			attrs |=3D DMA_ATTR_CC_SHARED;
+
 		page =3D dma_direct_alloc_swiotlb(dev, size, attrs);
 		if (page) {
 			/*
@@ -451,6 +455,10 @@ struct page *dma_direct_alloc_pages(struct device *dev=
, size_t size,
 						  &cpu_addr, gfp, attrs);
=20
 	if (is_swiotlb_for_alloc(dev)) {
+
+		if (dev->dma_io_tlb_mem->unencrypted)
+			attrs |=3D DMA_ATTR_CC_SHARED;
+
 		page =3D dma_direct_alloc_swiotlb(dev, size, attrs);
 		if (!page)
 			return NULL;
modified   kernel/dma/direct.h
@@ -92,6 +92,9 @@ static inline dma_addr_t dma_direct_map_phys(struct devic=
e *dev,
 		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
 			return DMA_MAPPING_ERROR;
=20
+		if (dev->dma_io_tlb_mem->unencrypted)
+			attrs |=3D DMA_ATTR_CC_SHARED;
+
 		return swiotlb_map(dev, phys, size, dir, attrs);
 	}
=20


>
>
> I will keep testing and let you know how it goes. If there is nothing
> else required to convert pKVM guests to CC, I can just post the patch
> separately as it has no dependency on this series.
>

That would be useful. I can then carry the patch as a dependent change,
which can also be merged separately

>
> Re force_dma_unencrypted(), I am looking into a safe way to use it
> for pKVM as I beleive it will be useful to eliminate some bouncing.
> However, that=E2=80=99s not critical for this series and can be added lat=
er
> as I am still investigating it, if I reach something I can post it
> along the pKVM patch above.
>
> Thanks,
> Mostafa
>
>>=20
>>=20
>> -aneesh
