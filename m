Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1478739D3D2;
	Thu, 13 Aug 2026 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610865; cv=none; b=h80udX17oH1ssgheCenclA4uE5nVhaYqHYQBkruLuXYLrLrIWzUpSDk/0ubdc380M34JFfKTynjlFEo5B5vc7mcS6Rah5hF7dPdKYeoU57wTAqxtD0yPScoKlFSGWrqvSXsV30Zqo/+8ZFicOH2nV2PMAK3+hNe7BYLVy8j7HFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610865; c=relaxed/simple;
	bh=u5KMzGgVOcLWbuPlGu/sTLdzSGT3hVGWZa68nwwdEyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arFaaM712n517jb43Aq6F9yMnzS6Hxi7PO2QB+W0BWnd1pbfNJjXhfC38sJZnMjOXeEJSvKSOB1SlajBQfUB189jjJ+Ng5q33ZyLGRbCyebqij1qVpxSSpYvuX06d3U3Zw0ijPLOsbhFDAhWxifhL4r1wXnAaWE3DfwmPhQQoZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kT2LB7gW; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kT2LB7gW"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDACB153B;
	Thu, 13 Aug 2026 01:47:31 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B7F53F632;
	Thu, 13 Aug 2026 01:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786610855; bh=u5KMzGgVOcLWbuPlGu/sTLdzSGT3hVGWZa68nwwdEyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kT2LB7gWPYpgXVp71WWZoEXALMvIuyrYp2tyQrSRM7LMcXDOoynp3ByKSZ/tbnOds
	 7sOyvXvON5GdcI8v+AGnoMPFjNbyQnUOJYmgJ/wJu21XtiGgJJDFOhsnMhJdtg/Kps
	 Ku5KeVrNaQDn+9+ZGLenYYr12tmjJiDAlfff6Owc=
Date: Thu, 13 Aug 2026 09:47:28 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [RFC PATCH] dma: swiotlb: Size shared default pools for memory
 encryption
Message-ID: <an2EoONjyp570tvB@arm.com>
References: <20260811134056.756015-1-aneesh.kumar@kernel.org>
 <anxEc8EHmJQywVI5@arm.com>
 <yq5ajypvioks.fsf@kernel.org>
 <anysnQFVTO_RAYxp@arm.com>
 <yq5aecg2io0u.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5aecg2io0u.fsf@kernel.org>

On Thu, Aug 13, 2026 at 11:02:17AM +0530, Aneesh Kumar K.V wrote:
> Catalin Marinas <catalin.marinas@arm.com> writes:
> > On Wed, Aug 12, 2026 at 04:38:03PM +0530, Aneesh Kumar K.V wrote:
> >> Catalin Marinas <catalin.marinas@arm.com> writes:
> >> > On Tue, Aug 11, 2026 at 07:10:56PM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> >> Systems with memory encryption use swiotlb to provide shared or
> >> >> unencrypted buffers for device DMA. Confidential guests may route all
> >> >> DMA through these buffers, while SME hosts use them for devices that
> >> >> cannot address encrypted memory. The default swiotlb pool can therefore
> >> >> be exhausted under I/O-intensive workloads.
> >> >> 
> >> >> Let architectures mark the default swiotlb pool as shared before
> >> >> swiotlb_init().
> >> >
> >> > I thought we wanted even this decision to be moved out of the arch code.
> >> 
> >> Architectures may want to use an unencrypted swiotlb pool for different
> >> reasons, one of them being CC_ATTR_GUEST_MEM_ENCRYPT. x86 hosts also
> >> require unencrypted pool to support SME. We can cover both cases using
> >> CC_ATTR_MEM_ENCRYPT.
> >
> > Yes but in one case it did not do resizing. With your proposal, it now
> > does swiotlb resizing even for SME.
> 
> Isn't that a bug with x86 SME? I would expect both SME and SEV to
> require that swiotlb resize.

Maybe, but that's for a different discussion (and we may want different
sizing). Better to keep the semantics unchanged for now.

> >> > BTW, why does arm64 report CC_ATTR_MEM_ENCRYPT instead of the GUEST
> >> > option in realms?
> 
> This is getting fixed in  
> https://lore.kernel.org/all/20260701054926.825925-9-aneesh.kumar@kernel.org/

You might want to bring this early together with the swiotlb adjustment
here.

> >> For the same reason I mentioned above, architectures may have different
> >> reasons for setting cc_shared = true. IMHO, it is cleaner to let the
> >> architecture code make that decision before swiotlb_init().
> >
> > The arch code already reports cc_platform_has(), can we not rely on
> > this in the core code instead of specific is_realm_world() and a new
> > SWIOTLB_INIT_CC_SHARED flag or function call?
> >
> > We have three different decisions that shouldn't be driven by a single
> > flag from the arch code:
> >
> > 1. allocate default pool
> > 2. make default pool shared
> > 3. resize default pool
> >
> > (1) is traditionally driven by arch code and that's fine. For (2), the
> > core code has the information via CC_ATTR_*. For (3), we can enlarge it
> > based on CC_ATTR_GUEST_MEM_ENCRYPT in combination with rmem (but not
> > CC_ATTR_MEM_ENCRYPT to keep the current x86 behaviour).
> 
> Okay, if the presence of restricted-dma-pool is taken as a hint, we can
> definitely move that to generic code.
> 
> I still think not resizing the swiotlb pool on the host for SME is an
> x86 bug. However, I'll keep it compatible with the current behavior and
> use CC_ATTR_GUEST_MEM_ENCRYPT for now. We can handle host SME in a
> separate patch if needed.

Sound good.

> > I think we should also move the reduction based on
> > CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC into the core code. Riscv copied the
> > same heuristic as arm64, so there's precedent for sharing.
> 
> I already have a patch doing that.

Great. Now you have a 3-patch series for the generic swiotlb sizing ;)

-- 
Catalin
