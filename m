Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495FD32B134
	for <linux-s390@vger.kernel.org>; Thu, 18 Jun 2026 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797029; cv=none; b=CzJJk0AYaBxYp8Bppjt08QwBPKcivRPHJQ3uSSf8YifrXhgWiPcw1/llftI4qZIjYCxe8LDlcLTLqmptHGqivT5WShAMyZ1pYlCa78F0W9UdCABX01iRNwA9yPsXaI3mtHRRrAAp5mY/HDRG+y9eedtPgKUl9HoZ8fT0Nx8NrQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797029; c=relaxed/simple;
	bh=HppPOGKgKIoggGCewCbUbyU4i7DooaPcpXs3DkDXKHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaGC+ar9i3ZaivU6Su4s0FCSci93UoXbV4RuMrNcilfDF+LFBZVtPBA9KMvbRUK21/c67gxAczlVEuIqJY11Vm83fMmrp5RdBMcrTN9icLYjd9Ga2EGvNGv8+Zxp11oFN5MLIZ4PI7cPCbhVdRPC5KhtTIEEv7Lhao7Rlr0Uz/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=G+TcTu/Z; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="G+TcTu/Z"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-915aa0a9293so241746785a.1
        for <linux-s390@vger.kernel.org>; Thu, 18 Jun 2026 08:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781797027; x=1782401827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tm+jP+3WfoLtXaL6gn2l0sQY+Wj2XqJdxBBXikZyHQE=;
        b=G+TcTu/ZhrHoc9wpAmEr51Y3+GW/8PyEppBS2TYDtbHgaAUxUMJnxPUvc4NPC9cDad
         Gg5NBBVuuh1+oobmh1OsqMU62CMsp0k8IxJ8lYehE8stMxsATv1SYaJvcuWtkShKxP/j
         un9RR4j7G/7WXG6WQ1FFgEL56b/3NoSMiR1TE8uPy9U51VCcZhCzzZQgM1dUak/nT2SB
         jv3zjnbDUXnjloIwrrUPGXutVc6B2NrSGuCoOkiovagtkjVPHVdTxf/lHFFpKsuds0j0
         Nly2bdVSu8Zm6iXuIooKZDzGdSQSMw9k8W+X+HVyswQ0B1e8GNYdbItyT86LqV8q2E+n
         sc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781797027; x=1782401827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tm+jP+3WfoLtXaL6gn2l0sQY+Wj2XqJdxBBXikZyHQE=;
        b=ceOn3OQTJnKr0B2Km8uslKXaQhWQGCnM6QuLp9FYHTrZlwEphViq/JNcCcNmP9iZlz
         Cp9BtJYlF9Ov98Pq5hCfws84fLteA+E9AVS8XyF0ZOx4ntzL2fgGIv24vaFQf3ONtqvb
         sPThIBOaOIdMtEVV/9++2brEVlREtN7j13wWWYMQGognEON1WONDBcxMad2BJJlacUNR
         569YrxzbhM+q/D5Rluu4CkYr1RCegICxxLqiJ5qm0g0OGYmu7Oy+6Q89yNA2aeCxaY51
         LdDGFYHRKFEk+I3t8h9O+UAGAhWvzoxEvqDQMzeo8IrS/wEvQDhHsCEs3Iqp5VEA3MJd
         82kg==
X-Forwarded-Encrypted: i=1; AFNElJ+5HaOTpPIpqE0gm1NgYd8Etyz6LRFcNeCw3rRcqKLaSHsSSYVR8yMzh/V6mlV6HnanyuwzTthhh4K9@vger.kernel.org
X-Gm-Message-State: AOJu0YwL9lU9MBXsbrISkuO3MgBjpF/+OTXNcdqAx9pTiWAOQC9CjtJ1
	eY1XR4mwKjUAkEWQ2QQL/PALZM45lxs7ELKbt0JnFp1tjlhf8vuBmYVxPMbWrMDZsVk=
X-Gm-Gg: AfdE7cl+tgVTxcSK/cvQ9er6KSsRBSn95LuUS++V1iPCaxKc/VuCWvIfjUHJef2AtMO
	0JPcMmnoNqNk5iBUWqIIbwZFvAHR98i7YSou6ta6chJM+rfSx119fbo/ZvT5gQW5kFurdJqSt+6
	4DFIOFmw52QxdPu54OPOvhm3BWVfr1bzbGDWh0yiSCq5zIHH3Os5ShiWfyAMI4T6pGmxYJtNFX9
	tYE2FCak2M0vvrSuKDteR9JJrc0DP2ScMHb4hqCrm5FpuZJ9uapADH4GozqRdCuMkIxjLoFT0wu
	qzYvDo8nhGI4CqC/v8MFUrkziESvtjYqk/n5m2WhY67qfN6KrcOuVExZaIN2Bvk5AecDDH4sQj8
	OuNJRYEtc9k6KF+gEJS+QEt+h0/p1xuG6HwAvQ4x8IPynqArAiZyGjUeVqpyLmbezOppVqgxnK6
	En1UG6nyHxTOEVLO/GVCbTUQ6+M8uqLqCixrGoxVv5QW+ge43Dieg7oAzC7aHkY3nA5OI=
X-Received: by 2002:a05:620a:469e:b0:915:8f64:604c with SMTP id af79cd13be357-91f082ff425mr678605385a.15.1781797026718;
        Thu, 18 Jun 2026 08:37:06 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f3c324sm2104263685a.21.2026.06.18.08.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 08:37:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1waEnh-00000002tSw-24HO;
	Thu, 18 Jun 2026 12:37:05 -0300
Date: Thu, 18 Jun 2026 12:37:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v6 00/20] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
Message-ID: <20260618153705.GH231643@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <aigYbK12D8uKQvJF@arm.com>
 <20260609144746.GL2764304@ziepe.ca>
 <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com>
 <yq5aqzm4dz25.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5aqzm4dz25.fsf@kernel.org>

On Thu, Jun 18, 2026 at 09:37:22AM +0100, Aneesh Kumar K.V wrote:
> Alexey Kardashevskiy <aik@amd.com> writes:
> 
> > On 10/6/26 00:47, Jason Gunthorpe wrote:
> >> On Tue, Jun 09, 2026 at 02:43:08PM +0100, Catalin Marinas wrote:
> >>> On Thu, Jun 04, 2026 at 02:09:39PM +0530, Aneesh Kumar K.V (Arm) wrote:
> >>>> This series propagates DMA_ATTR_CC_SHARED through the dma-direct,
> >>>> dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
> >>>> are handled consistently.
> >>>>
> >>>> Today, the direct DMA path mostly relies on force_dma_unencrypted() for
> >>>> shared/decrypted buffer handling. This series consolidates the
> >>>> force_dma_unencrypted() checks in the top-level functions and ensures
> >>>> that the remaining DMA interfaces use DMA attributes to make the correct
> >>>> decisions.
> >>>
> >>> Please check Sashiko's reports, it has some good points:
> >>>
> >>> https://sashiko.dev/#/patchset/20260604083959.1265923-1-aneesh.kumar@kernel.org
> >>>
> >>> I think the main one is the swiotlb_tbl_map_single() changes which break
> >>> AMD SME host support. There cc_platform_has(CC_ATTR_MEM_ENCRYPT) is true
> >>> but force_dma_unencrypted() is false. Normally you'd not end up on this
> >>> path but you can have swiotlb=force.
> >> 
> >> IMHO that's an AMD issue, not with the design of this series..
> >> 
> >> The series is right, a device that is !force_dma_decrypted() must be
> >> considerd to be a trusted device and we must never place any DMA
> >> mappings for a trusted device into shared memory.
> >
> > swiotlb=force forces swiotlb, not decryption.

If force_dma_decrypted() == true then swiotlb must allocate from a
decrypted memory pool. It is right there in the name!

The hypervisor environment should *never* set force_dma_decrypted()
because all devices can access all hypervisor memory, up to their IOVA
limits.

> > So when I try "mem_encrypt=on iommu=pt swiotlb=force" with this
> > patchset, it fails to boot. But it boots with a hack like this:

On the host side I expect this to cause swiotlb to allocate encrypted
memory and bounce to it.

>  		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
>  		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
>  						dev->bus_dma_limit);
> +		/*
> +		 * With memory encryption enabled, SWIOTLB is marked decrypted.
> +		 * If SWIOTLB bouncing is forced, treat the device as requiring
> +		 * decrypted DMA.
> +		 */

And this is more insane logic. The right fix is to allocate the
swiotlb bounce from the *encrypted* pools when running on the
hypervisor which requires undoing this abuse of force_dma_decrypted().

Jason
