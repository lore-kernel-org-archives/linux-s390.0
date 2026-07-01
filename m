Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060B033AD8B;
	Wed,  1 Jul 2026 03:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782875361; cv=none; b=uOe0vwgZ782msgNJ3OscovkrGhppLxJyPPbm3UD1h0a+ee42lgHBvKZ4HRyGephNIfhsyKma+I09LuPGdrPangLGlOS8/1tvOXqz9AtsFiunVkK1oMpxTf4+D3bxvpAnZzlYJmBogdclFOSagbW3VX7IeHj79B0dJkDDXRLZY8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782875361; c=relaxed/simple;
	bh=FPT9y30vnOlO/lNgfWP5ptP/TtCb7F5Scbs6AXcyfNM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KbRsp258eRuj5JIYvud3A6NghR/NCNHUiCC4kFmRFC5g/C5n8YQrM1NX8DntBnql9jzr/S0pfcf10JT+R3oA7VQfm+XxQZE+wfP4jz0/4qapBDJTlgLvKBZm5UZ5aFPX0Oggx3sfb4GaYsONtSeh8iy8JZEhPW7//fK+xIh7HRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Apa1e2TN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Apa1e2TN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598A71F000E9;
	Wed,  1 Jul 2026 03:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782875359;
	bh=FJhajr5kdTmXSpbRHiZGZT3ioUVr6sHAFFO+7D7H7Iw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Apa1e2TNAD1OXcazOEFCxJl7l5BrVVMLldpRf0byGAFIxmHZcJ9j3O57EBDpqqCGC
	 npNWTMDbd5MynUk+n9TOEgWrKZLUeu0x85rBnH3oE01O8UmQAVgtiT8Oxe0DwbXarq
	 Rhj55UyvnpmtD02vXdUXMyNS/Gwhk3JQUnTOPAcDA46ZE++fUcZtSTuxWdL5uTuivC
	 kvC2jhtCrGypZNaCdpd0nztN0oQqPcwT5h4mHQP6EvhXUQv1O6OZax7pV/JnK+5h4f
	 Xtfv09ZeJ7OVs0ct4YkBueDVTpnVdg+nTb12bqzwLvFUbpPUCF35eDdmAKCrVeiZyW
	 sl8y0F2F3AO0Q==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
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
Subject: Re: [PATCH v6 00/20] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
In-Reply-To: <20260630174216.GK7525@ziepe.ca>
References: <aigYbK12D8uKQvJF@arm.com> <20260609144746.GL2764304@ziepe.ca>
 <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com>
 <yq5aqzm4dz25.fsf@kernel.org> <20260618153705.GH231643@ziepe.ca>
 <yq5ao6h6enhm.fsf@kernel.org> <20260619122148.GL231643@ziepe.ca>
 <yq5aldcaejos.fsf@kernel.org> <20260619140616.GB1068655@ziepe.ca>
 <yq5ao6gtoncp.fsf@kernel.org> <20260630174216.GK7525@ziepe.ca>
Date: Wed, 01 Jul 2026 08:39:06 +0530
Message-ID: <yq5abjcro17x.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Mon, Jun 29, 2026 at 12:16:30PM +0530, Aneesh Kumar K.V wrote:
>> >> Thinking about this more, I guess we should mark the swiotlb as
>> >> cc_shared only with  CC_ATTR_GUEST_MEM_ENCRYPT instead of
>> >> CC_ATTR_MEM_ENCRYPT as we have below.
>> >
>> > The name cc_shared should be used for GUEST scenarios only.
>> >
>> > I guess there is some merit in keeping swiotlb using "decrypted" to
>> > mean it usinig pgprot_decrypted and set_memory_decyped() which AMD
>> > gives meaning to on both host and guest.
>> 
>> Are you suggesting to change the struct io_tlb_mem::cc_shared back to
>> struct io_tlb_mem::unencrypted?. 
>
> Yes
>
>> > IDK what AMD should do on the host by default. I guess it should setup
>> > a swiotlb pool of low dma addrs "unencrypted", but not "cc_shared"?
>> >
>> 
>> If by low DMA address you mean using an address with the C-bit
>> cleared. 
>
> Yes
>
>> The current code already does this and uses the swiotlb pool correctly
>> on SME.
>
> Well, through the force_dma_unencrypted() hack...
>
>> The challenge arises when we want to force SWIOTLB
>> bouncing even for devices that can handle encrypted DMA addresses (more
>> on that below). For such a config force_dma_uencrypted(dev) will return
>> false and swiotlb will be marked cc_shared/decrypted = true; This trip
>> the new check we added.
>
> Yes, because cc_shared (guest) and unencrypted (host) are very
> different things and we've mixed them:
>
>> 	if (unlikely(mem->cc_shared != force_dma_unencrypted(dev)))
>
> I'm aruging force_dma_unencrypted should mean cc_shared and be
> guest_only, but the SME hack breaks this.
>
>> We can also do
>> 
>> 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
>> 		/* swiotlb pool is incorrect for this device */
>> 		if (unlikely(mem->cc_shared != force_dma_unencrypted(dev)))
>> 			return (phys_addr_t)DMA_MAPPING_ERROR;
>> 
>> 		/* Force attrs to match the kind of memory in the pool */
>> 		if (mem->cc_shared)
>> 			*attrs |= DMA_ATTR_CC_SHARED;
>> 		else
>> 			*attrs &= ~DMA_ATTR_CC_SHARED;
>> 	} else {
>> 		/*
>> 		 * Host memory encryption where device requires an
>> 		 * unencrypted dma_addr_t due to dma mask limit
>>     		 */
>> 		if (force_dma_unencrypted(dev))
>> 			*attrs |= DMA_ATTR_CC_SHARED;
>> 		else
>> 			*attrs &= ~DMA_ATTR_CC_SHARED;
>> 	}
>
> If we do this I would like to split the force_dma_.. functions into
> guest and host, ie force_dma_cc_shared() and force_host_decrypted()
>
> To make it clear there are two very different things here.
>

I have now folded the below change into

modified   kernel/dma/swiotlb.c
@@ -1514,9 +1514,23 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
 
-	/* swiotlb pool is incorrect for this device */
-	if (unlikely(mem->cc_shared != force_dma_unencrypted(dev)))
-		return (phys_addr_t)DMA_MAPPING_ERROR;
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
+
+		/* swiotlb pool is incorrect for this device */
+		if (unlikely(mem->cc_shared != force_dma_unencrypted(dev)))
+			return (phys_addr_t)DMA_MAPPING_ERROR;
+
+	} else if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
+		/*
+		 * On hosts with memory encryption, SWIOTLB-backed memory is
+		 * unencrypted. DMA addresses returned for bounce buffers must
+		 * therefore be marked unencrypted, even for devices that can
+		 * address encrypted memory. This also preserves swiotlb=force
+		 * behavior for those devices.
+		 */
+		if (unlikely(!mem->cc_shared))
+			return (phys_addr_t)DMA_MAPPING_ERROR;
+	}
 
[PATCH] dma: swiotlb: track pool encryption state and honor DMA_ATTR_CC_SHARED

This is the only code path where we need to special-case host memory
encryption. For this reason, I have avoided renaming
io_tlb_mem::cc_shared to io_tlb_mem::unencrypted. I can send a v7 with
the above and we can review the changes based on that?

-aneesh
