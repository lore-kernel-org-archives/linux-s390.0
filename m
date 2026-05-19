Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5941F2EA172;
	Tue, 19 May 2026 16:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206742; cv=none; b=rcAZ9CmAiWAWmi37biEao+ea+Hdv9kgNOo5pmXIPvy2XWZ/KTroHzCA6EjeuLixh6g+6d5Rg4TEDe95jLbRclIomwoLxbmuPJuRC6mO8Xw+opCh99i/nnJ5ImJUZYBVeTCqZ1gQgZrPRc1w5CSqHmvzB+GXz0HV8dsLY7N9s5Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206742; c=relaxed/simple;
	bh=pt5iQUdtnfhNpvK7AQkTvn0wItb9id28JUqhd00xZrQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XERSgcPaVhs6nDVdYhR0sugk6cXKh80AG47MajTgucWV3SgcPVAAtY98oTN0W9AEHvuhF09OalRLuJ6XcyPujB9lpOPDNfxnSpKp/as32sKGALmy9guHkDvUk22Av2Ns/ORNaM6FT5LfJ27e2FBhLReG39lhjxPDo3UkfaUb/Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGi6uP7y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGi6uP7y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1256CC2BCB3;
	Tue, 19 May 2026 16:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779206741;
	bh=pt5iQUdtnfhNpvK7AQkTvn0wItb9id28JUqhd00xZrQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HGi6uP7yy8FWoL7oh9OmyDBp0yhprk2imSwMZjGloMbu3LE8f+/TN15iYqZsQGE12
	 H3DYnre52YIJ/uT1BeRvsgD6IgRrNVXmwqptQEEZe8j41PJCv2wWVTsbyddLHAWYCA
	 SFn4CGqXmHZN6l7aS/RQQoZdPhZXYQocv7tQfDwf4Qg+R9TubMaXE1xHo400GfSt6h
	 RUQgyx5wjkS+seTEJTNDVSya5d5ejYQZTwRfAdieddYzFg03oz9xCacpGlUeo9JEl6
	 /U+r51r9x2H36M0pV+l1vPBBsM2KxsILg41qc8fEafY4w7J/ETxXDu88urSFQbI3Sl
	 ULPyemdC4Tfhg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
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
In-Reply-To: <20260519152741.GM7702@ziepe.ca>
References: <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com> <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com> <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com> <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com> <yq5amrxvshxg.fsf@kernel.org>
 <yq5abjebsaid.fsf@kernel.org> <20260519152741.GM7702@ziepe.ca>
Date: Tue, 19 May 2026 21:35:30 +0530
Message-ID: <yq5a8q9fs7ud.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Tue, May 19, 2026 at 08:37:54PM +0530, Aneesh Kumar K.V wrote:
>
>> if we get force_dma_unencrypted(dev) correct, we won't need the above.
>> 
>> for dma_direct_alloc and dma_direct_alloc_pages() we have
>> 
>> 	if (force_dma_unencrypted(dev))
>> 		attrs |= DMA_ATTR_CC_SHARED;
>> 
>> 
>> for dma_direct_map_phys(), if we have swiotlb bouncing forced,
>> 
>> swiotlb_tbl_map_single():
>> 
>> 	if ((attrs & DMA_ATTR_CC_SHARED) || force_dma_unencrypted(dev))
>> 		require_decrypted = true;
>
> IMHO I really do prefer the DMA_ATTR_CC_SHARED flows closer to the
> thing that did the decryption. While the above is possibly sound it is
> very obtuse to be guessing what kind of memory swiotlb decided to
> return..
>
> Can we pass a pointer to the attrs into the swiotlb stuff and it can
> update it based on the kind of memory it has allocated?
>

Yes, that also resulted in simpler and cleaner code.

swiotlb_tbl_map_single
	/*
	 * If the physical address is encrypted but the device requires
	 * decrypted DMA, use a decrypted io_tlb_mem and update the
	 * attributes so the caller knows that a decrypted io_tlb_mem
	 * was used.
	 */
	if (!(*attrs & DMA_ATTR_CC_SHARED) && force_dma_unencrypted(dev))
		*attrs |= DMA_ATTR_CC_SHARED;

	if (mem->unencrypted != !!(*attrs & DMA_ATTR_CC_SHARED))
		return (phys_addr_t)DMA_MAPPING_ERROR;

and

@@ -1640,19 +1654,14 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
 
 	trace_swiotlb_bounced(dev, phys_to_dma(dev, paddr), size);
 
-	swiotlb_addr = swiotlb_tbl_map_single(dev, paddr, size, 0, dir, attrs);
+	swiotlb_addr = swiotlb_tbl_map_single(dev, paddr, size, 0, dir, &attrs);
 	if (swiotlb_addr == (phys_addr_t)DMA_MAPPING_ERROR)
 		return DMA_MAPPING_ERROR;
 
-	/*
-	 * Use the allocated io_tlb_mem encryption type to determine dma addr.
-	 */
-	if (dev->dma_io_tlb_mem->unencrypted) {
+	if (attrs & DMA_ATTR_CC_SHARED)
 		dma_addr = phys_to_dma_unencrypted(dev, swiotlb_addr);
-		attrs |= DMA_ATTR_CC_SHARED;
-	} else {
+	else
 		dma_addr = phys_to_dma_encrypted(dev, swiotlb_addr);
-	}
 
 	if (unlikely(!dma_capable(dev, dma_addr, size, true, attrs))) {
 		__swiotlb_tbl_unmap_single(dev, swiotlb_addr, size, dir,
