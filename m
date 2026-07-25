Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBD92F8E8F;
	Sat, 25 Jul 2026 07:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784963366; cv=none; b=FkyQhoOjryiZeUOSMGHdDINE6PSDByhz/cmwzH2MNky+8it29vkU3VpBPyl3DPNyznTqjiV5fRl2ktURo/5zfIYIr3LoCqmZ7VYQzIEpumTfaGAKuOlYoYFpHCPfe2/6UyzPtA/1XiqXkY3L2T6uJ1DhvegEW2P3+EJAKbxkSRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784963366; c=relaxed/simple;
	bh=eWusWs1g22nWRtTHqO0ChFU1rsQZo1oLrBl2Wf7xDF8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B4I+eHV13oY5Agp2OtIlifcJjY23OnbMNRuyrbUkd88q2atr7BV/BjYwJBwD2uIJ7jRWn6OIV6HDobSDas9Vh9nWvZORnxZTxxbermAatfqcPUD8AdJEq9GcsPh1NuFPWx+6dN2KCc0CUKg9iDD0TWc0DWT5yVFpAr3ELpW8CVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UViRD/vP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UViRD/vP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FF01F000E9;
	Sat, 25 Jul 2026 07:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784963364;
	bh=hkeoESYmG7m48wiu7DFgnzkgoaFnDkiRgmmBzEi4GuA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=UViRD/vP1cLupXloQti86AXEHd5Oqhs081layDqXo6b+RZ4Y82x9x4afggJK229+a
	 Z+Yh1HMf6iUyBzHMniRMzOJOjGgX8/rmQVSfmwkUgXZ+kWSvMa1Sgpcojx9SrWMcgB
	 KcPws98KPcszn5zlm+ZGjTfjdG2IbmfOXkGuIIKxYOCQZnC1J+O/zd6xcvj+NvctrH
	 GOhr4BGexYASpkNSEDhYVdp4wzEoZLqqAAI00JxT4ZGJQliwuyn0a/tF1jAsMRBUQF
	 GXMAh2heA1Axq+PkzXqbXUf+5yjbzncmCve2s3LU0TkmEGx25k+AGhlZEcH1i8rD/X
	 k2xKELi60Uw9w==
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
Subject: Re: [PATCH v8 00/23] dma-mapping: Track shared DMA state through
 direct, pool and swiotlb paths
In-Reply-To: <20260717180442.110954-1-aneesh.kumar@kernel.org>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
Date: Sat, 25 Jul 2026 12:39:10 +0530
Message-ID: <yq5azezfeeax.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:

> This series tracks confidential-computing shared DMA state through the
> dma-direct, dma-pool, and swiotlb paths so that encrypted and decrypted
> DMA buffers are handled consistently.
>
> Today, the direct DMA path mostly relies on force_dma_unencrypted() for
> shared/decrypted buffer handling. This series consolidates the
> force_dma_unencrypted() checks in the top-level functions and ensures
> that the remaining DMA interfaces use DMA attributes to make the correct
> decisions.
>
> The series separates mapping and allocation state:
> - DMA_ATTR_CC_SHARED describes the DMA address attribute requested for a
>   mapping. It tells the DMA mapping path that the DMA address must target
>   shared/decrypted memory.
> - __DMA_ATTR_ALLOC_CC_SHARED is an internal DMA-mapping attribute used only
>   by allocation paths after the DMA core decides that the backing pages
>   must be allocated as shared/decrypted memory.
>
> The series:
> - moves swiotlb-backed allocations out of __dma_direct_alloc_pages(),
> - uses __DMA_ATTR_ALLOC_CC_SHARED through the dma-direct alloc/free paths
> - teaches the atomic DMA pools to track encrypted versus decrypted
>   state
> - tracks swiotlb pool encryption state and enforces strict pool
>   selection
> - centralizes encrypted/decrypted pgprot handling in dma_pgprot() using
>   DMA attributes
> - passes DMA attributes down to dma_capable() so capability checks can
>   validate whether the selected DMA address encoding matches
>   DMA_ATTR_CC_SHARED
> - makes dma_direct_map_phys() choose the DMA address encoding from
>   DMA_ATTR_CC_SHARED and fall back to swiotlb when a shared DMA request
>   cannot use the direct mapping, which lets arm64 and x86 CCA guests stop
>   relying on SWIOTLB_FORCE for DMA mappings
> - use the selected swiotlb pool state to derive the returned DMA
>   address
> - reports CC_ATTR_GUEST_MEM_ENCRYPT for arm64 Realms, powerpc secure
>   guests, and s390 protected virtualization guests.
>
> Dependency:
> This series depends on the pKVM changes posted at:
> https://lore.kernel.org/all/20260603110522.3331819-1-smostafa@google.com
>
> Please merge this series only after the pKVM changes above are merged.
> Otherwise pKVM will be broken.
>

pKVM topic branch is now available 

https://lore.kernel.org/all/178467286876.125042.12010461715645610054.b4-ty@kernel.org/

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/coco

-aneesh

