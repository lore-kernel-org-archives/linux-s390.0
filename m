Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EC135F18A;
	Thu, 21 May 2026 11:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779364463; cv=none; b=tEZkH3hkfKHicfwF/7mkse+BI2o6fcg/Ut26iWTLTSWNxZibHfkc8JPoPb7uDARAPtHvD21sbcbOrAWjeFKWFbA/KmYI0eBRajghGxYq+YC0rkRv4CS7A1RBq+yiYg3uHg9ByWcSVUPCujtMDGCMs1ZgbH+1WO+tgMj1I5t/bwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779364463; c=relaxed/simple;
	bh=ZgZIWjW+VmcEbqu15znYRaEOpX+b7l5mNLvU3xhgsCk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=COVXIYdINCQmqICBtu9N4DqseiiXrI8TnMCGVyOS+8s1y88Ycrbk2OSWzn4cylKyLyIk/cZjhWipULDITU63/tE/sdD8dXXASFn/d9FlswPsIiTVyLNXclw9guy6R+/6KMeugUJm0IoLtw6VTwlvEefzYBKkkRWu9DMq7kJ7+0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRoV8Obk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRoV8Obk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60901F000E9;
	Thu, 21 May 2026 11:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779364462;
	bh=AfaRmOFwq9PG0Q9lB7Y5h4Js0tCrSyooaZYJ9TAjF4I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=VRoV8Obk6Db2yTrA5yAdD7bmtQFvSWYfd/ZMw0E5GBL5jIdP8p2frzgVjebJ/AI8N
	 hR/ltXnLmqYytDDOSL4NfrAm8WWL6Eapslk7nKLHkiEPTsINTDc/s/wXE5nhOEOkw0
	 ocFPhIherbIJmWmA0TT9aOS8dxo5zor2QipnNUscdwsm508C2EjBqUXMBblgS8bTHy
	 VTwtO3pIzg195ryyporAX+AUffxjuJV03eR50aV96prxY5h11jwtvbWjHvTe3DepXz
	 Q2BR9ERr09ummMuYbcfqyARU4HAkb3n2S7jWp660Rin4hD/1ttPs8n0zhk15N2/FrI
	 IAG1as/hVnwgg==
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
Subject: Re: [PATCH v4 13/13] x86/amd-gart: preserve the direct DMA address
 until GART mapping succeeds
In-Reply-To: <20260512090408.794195-14-aneesh.kumar@kernel.org>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-14-aneesh.kumar@kernel.org>
Date: Thu, 21 May 2026 17:24:07 +0530
Message-ID: <yq5a4ik16krk.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:

> gart_alloc_coherent() first allocates memory through dma_direct_alloc(),
> which returns a direct-mapped DMA address in dma_addr. When force_iommu is
> enabled, the buffer is then remapped.
>
> Do not overwrite dma_addr before dma_map_area() has succeeded. Keep the
> dma_map_area result in a temporary variable so the direct DMA address
> remains available for dma_direct_free() on the error path.
>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  arch/x86/kernel/amd_gart_64.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
> index b5f1f031d45b..a109649c5649 100644
> --- a/arch/x86/kernel/amd_gart_64.c
> +++ b/arch/x86/kernel/amd_gart_64.c
> @@ -467,18 +467,20 @@ gart_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_addr,
>  		    gfp_t flag, unsigned long attrs)
>  {
>  	void *vaddr;
> +	dma_addr_t dma_map_addr;
>  
>  	vaddr = dma_direct_alloc(dev, size, dma_addr, flag, attrs);
>  	if (!vaddr ||
>  	    !force_iommu || dev->coherent_dma_mask <= DMA_BIT_MASK(24))
>  		return vaddr;
>  
> -	*dma_addr = dma_map_area(dev, virt_to_phys(vaddr), size,
> -				 DMA_BIDIRECTIONAL,
> -				 (1UL << get_order(size)) - 1, attrs);
> +	dma_map_addr = dma_map_area(dev, virt_to_phys(vaddr), size,
> +				     DMA_BIDIRECTIONAL,
> +				     (1UL << get_order(size)) - 1, attrs);
>  	flush_gart();
> -	if (unlikely(*dma_addr == DMA_MAPPING_ERROR))
> +	if (unlikely(dma_map_addr == DMA_MAPPING_ERROR))
>  		goto out_free;
> +	*dma_addr = dma_map_addr;
>  	return vaddr;
>  out_free:
>  	dma_direct_free(dev, size, vaddr, *dma_addr, attrs);
> -- 
> 2.43.0
>

This needs corresponding changes on the gart_free_coherent() side as well.

https://sashiko.dev/#/patchset/20260512090408.794195-1-aneesh.kumar%40kernel.org?part=13

I will avoid making that change as part of this series, since I assume
it would require specific testing.

-aneesh
