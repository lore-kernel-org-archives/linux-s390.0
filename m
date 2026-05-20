Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAD8320A00;
	Wed, 20 May 2026 03:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779249461; cv=none; b=GhZFCYNf/ju9CnFyWl9tHabdYQn5XliP8p6EGFst6xboiHqYoVJ/9Kr+z7XV447Xlyf47YjDDTTIP56bH+0SiqKYz17ytxCHhOCRw/fd28cO5tDN00b1pHN3i7AIzoLTXYvw/nZV7OjVA8B7c7gth5yf4OLW4TCkoqUJdsKMdWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779249461; c=relaxed/simple;
	bh=u42KdqdBlbzemA/eXphy076aQATROAX8mgIesYzE0D8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jIpSGR4esW1tcsbVuS1gdtXCc6V5vycfu/15qe/Iqt18MxVAUJX9W0eT1tqBXcJeP0NXgqhNpJ+Qv2rysXfb//eQ7cRLA55g3RiqL0lMh6fBFHVWTxT7cX6cQtCBkdYIsI6URoitztXjTtSVXW8hVs8QHyq524jqbQ4jwYTgn1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InlsMQlE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InlsMQlE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679B51F000E9;
	Wed, 20 May 2026 03:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779249458;
	bh=2/10KWZth3f3oJZ9cVmYGyrspKBWGW0LeGuuNx46MWQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=InlsMQlEZWNdtUwAJ/WfdVY8k13HPRMssotBX7SBIuNa54Jg5vv0DFKV/w2mGAhTl
	 Tzussp1c8bM+KGnneYMWBdGbE4oZul6IPm60d103sHqARcIHtvuJIiVgW9S3QWUNxe
	 GjNuOmh9trmY3E8I6iNu0UCo/Ee4tbvNHH+iz36pcjOMPgbKC1DF7Zdic5DUxAP/5r
	 qFDNlC2UfvXa6u5GW5TK6+7EPafA/L3aUULUJfYDKazwkubhgxm0YcqdzN4vollRka
	 RL31G/X3pgTFzHPzIAgWwh2bzokWqpVVU6U6B2r+w0u77cJDi7s4qVbg0kWegirLl0
	 +27eesvv2tbCg==
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
In-Reply-To: <20260519161120.GO7702@ziepe.ca>
References: <yq5ah5oaa63h.fsf@kernel.org> <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org> <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org> <agxDxdxynp4KEovA@google.com>
 <yq5amrxvshxg.fsf@kernel.org> <yq5abjebsaid.fsf@kernel.org>
 <20260519152741.GM7702@ziepe.ca> <yq5a8q9fs7ud.fsf@kernel.org>
 <20260519161120.GO7702@ziepe.ca>
Date: Wed, 20 May 2026 09:27:27 +0530
Message-ID: <yq5a5x4ispg8.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Tue, May 19, 2026 at 09:35:30PM +0530, Aneesh Kumar K.V wrote:
>> Yes, that also resulted in simpler and cleaner code.
>> 
>> swiotlb_tbl_map_single
>> 	/*
>> 	 * If the physical address is encrypted but the device requires
>> 	 * decrypted DMA, use a decrypted io_tlb_mem and update the
>> 	 * attributes so the caller knows that a decrypted io_tlb_mem
>> 	 * was used.
>> 	 */
>> 	if (!(*attrs & DMA_ATTR_CC_SHARED) && force_dma_unencrypted(dev))
>> 		*attrs |= DMA_ATTR_CC_SHARED;
>> 
>> 	if (mem->unencrypted != !!(*attrs & DMA_ATTR_CC_SHARED))
>> 		return (phys_addr_t)DMA_MAPPING_ERROR;
>
> Yeah, exactly that is so much clearer now that the mem->unecrypted is
> tied directly.
>
> That logic is reversed though, the incoming ATTR_CC doesn't matter for
> swiotlb, that is just the source of the memcpy.
>
> /* swiotlb pool is incorrect for this device */
> if (mem->unencrypted != force_dma_unencrypted(dev))
>     return (phys_addr_t)DMA_MAPPING_ERROR;
>
> /* Force attrs to match the kind of memory in the pool */
> if (mem->unencrypted)
>      *attrs |= DMA_ATTR_CC_SHARED;
> else
>      *attrs &= ~DMA_ATTR_CC_SHARED;
>
>
> Attrs should be forced to whatever memory swiotlb selected.
>

But that will not handle a T=1 device that wants to use swiotlb to
bounce unencrypted memory. That is:

force_dma_unencrypted(dev) == 0  /* T=1 device */
attrs = DMA_ATTR_CC_SHARED;

In that case, it should use an unencrypted io_tlb_mem:
mem->unencrypted == 1

-aneesh
