Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1304324336D;
	Fri, 10 Jul 2026 05:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783660985; cv=none; b=M3JDkMByZ7G+8gSWSYLoBLbKhM0QKILhJoodFrRAidAH1fmt2kLS7EYhoGYYi0owrxZ3YAYqyrKvsZ95u50HjURpV3EXM/6Td9idSb56pLTolWdaAy2AAd2veVJq8gCGenX0KbXzhOtDxYK2X5iv6NqKZU5Jg2W1dzmLZfDKYoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783660985; c=relaxed/simple;
	bh=lqBwW/if3qUGBNykxpmLTfRLLwSORAlTtLD14GzmOVY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MzQq6/6IEeD6wztyXI0aXaBr3dYAe/RZRKu5wnhe19gAnRY6rd0LOHscECI01IfGCH2J1tTmCHEONKoLkJISG2zWPhvaSO4CFNv0oDHHKmL4BKIlJz1MZmDnaz2y1sYjP0KvVGCn4nQ/zvzafIaygvDMd2h2oVFPy6YxmAqHzd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNlSVXT3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNlSVXT3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EBD1F000E9;
	Fri, 10 Jul 2026 05:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783660984;
	bh=550ooWT8542+63+b73F3KAgnV89CFJo9aC92rxEIRio=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=bNlSVXT3ETCHbdeWOabjzODZivq8U9g4F7kEA6Aw4NSN7/iClos+6FnnRkEloBTQx
	 kYDdZ5It6cK3pDU1sVLNfVvyp92GT9KnRBSjY45JIhg78l32NwyF7rJpiRPqj0BVUP
	 8ZguLouhrS8wYHspEicQcK61eLs15Bcqz/9u2KhrJQJk4XgUD2q/0h/z4hDga0v9QI
	 eMeQxwFokadPjLOrsMZkF6JDmQ/8georqPF7vU27VTFLhMKBvJISPjIM8Mrs4P/TXt
	 yOJTeULh173Hgo7dKmAW3nhIaq8VFpWH+iVqc4tNoqbH1ucJJsZH4f7Af8vl/d9ed7
	 nijIDYfIjO2vw==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Jiri Pirko <jiri@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 16/22] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
In-Reply-To: <20260709181336.GM118978@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-17-aneesh.kumar@kernel.org>
 <ak42F240d-53QeFN@arm.com> <yq5apl0xgy89.fsf@kernel.org>
 <ak-CT3oanlDfgTy4@arm.com> <20260709181336.GM118978@ziepe.ca>
Date: Fri, 10 Jul 2026 10:52:49 +0530
Message-ID: <yq5ajyr3h106.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Thu, Jul 09, 2026 at 12:13:19PM +0100, Catalin Marinas wrote:
>> > > For AMD/SME, on host with memory encryption we now end up setting the C
>> > > bit for DMA_ATTR_MMIO. This is fine for RAM but not sure whether
>> > > some other MMIO bus understands this attribute. Maybe we should stick to
>> > > something like __phys_to_dma() for the !CC_SHARED && MMIO path. Or,
>> > > since this is not universally defined, just use the old dma_addr = phys
>> > > if MMIO and ignore any unlikely DMA offsets.
>> > >
>> > 
>> > Considering for AMD/SME system an unencrypted dma addr is one without C
>> > bit, will this be good?
>> > 
>> > 	/*
>> > 	 * For host memory encryption and device requiring unencrypted DMA,
>> > 	 * MMIO memory is treated as shared by default.
>> > 	 */
>> > 	if (attrs & DMA_ATTR_MMIO) {
>> > 		if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) || force_dma_unencrypted(dev))
>> > 			attrs |= DMA_ATTR_CC_SHARED;
>> > 	}
>> 
>> Yes, I think it does the trick, preserves the current semantics for AMD.
>> I guess you could use a single 'if' for all checks (up to you).
>
> Please don't change it, MMIO P2P is broken on CC systems today and it
> should stay broken. Passing DMA_ATTR_MMIO with DMA_ATTR_CC_SHARED is
> an error that we need to correct in the drivers not make work in the
> core code.
>

But the above changes are intended to handle HOST_MEM_ENCRYPT. In v7, we
had the following diff:

@@ -88,37 +88,40 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 {
 	dma_addr_t dma_addr;
 
+	/*
+	 * For a device requiring unencrypted DMA, MMIO memory is treated
+	 * as shared by default.
+	 */
+	if (force_dma_unencrypted(dev) && (attrs & DMA_ATTR_MMIO))
+		attrs |= DMA_ATTR_CC_SHARED;
+

This is now getting updated to

@@ -624,37 +626,44 @@ dma_addr_t dma_direct_map_phys(struct device *dev, phys_addr_t phys,
 {
 	dma_addr_t dma_addr;
 
+	if (attrs & DMA_ATTR_MMIO) {
+		/*
+		 * For host memory encryption and device requiring
+		 * unencrypted DMA, MMIO memory is treated as shared by
+		 * default.
+		 */
+		if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) ||
+		    force_dma_unencrypted(dev))
+			attrs |= DMA_ATTR_CC_SHARED;
+	}
+

I agree that we need to move that DMA_ATTR_CC_SHARED setting to 

modified   drivers/pci/p2pdma.c
@@ -285,6 +285,11 @@ int pcim_p2pdma_init(struct pci_dev *pdev)
 			continue;
 
 		p2p->mem[i].owner = &pdev->dev;
+
+		p2p->mem[i].dma_mapping_flags = DMA_ATTR_MMIO;
+		if (force_dma_unencrypted(dev))
+			p2p->mem[i].dma_mapping_flags |= DMA_ATTR_CC_SHARED;
+

As we discussed [1], that can come in a later patch. In the meantime, adding
the HOST_MEM_ENCRYPT check preserves the previous behavior for SME.

[1] https://lore.kernel.org/all/20260522132240.GD7702@ziepe.ca/

-aneesh
