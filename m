Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7BC2417D9;
	Tue, 21 Jul 2026 12:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784637663; cv=none; b=E0o0wFieZmBEB/kk8v7et5AbGlcxVp0wz0gPZHQHC6JyD+TQn43tLgtxFnfkpc2eeINJQZwcHqFEIkpBdEFWjydUq0UBUE391+lEwUX8YSAst7o7HAcTifjlY3Qyhi+zaifayX1awU/ZPSLyAGLyqM5cUVAcYZnA4baskCr4J2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784637663; c=relaxed/simple;
	bh=sTp/VjX06Dq0Gnho5C/rlC7ly6rOmA/O/qouPm2TWo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yz2pd/exzw5zSbrJZAXBRppyPydyGZcV6clxVhqNGvERIkKrF2Eu9sWWIzEO4LoJVbRIjVlHjAfBh5eqYZngxlxbfykWIP5KWbRnAL40labOtRIUXWp0agLH5DrVPUxrKffumRjF9qvGjOobE8rtQSq04pteBmtaJd+CV2RJmlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAJKKs0m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAJKKs0m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192681F000E9;
	Tue, 21 Jul 2026 12:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784637662;
	bh=hHR20QdKLO7v/A9MVkG/crlJxAvTVIREme8pDXPWdpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NAJKKs0mp2HmwOSTJulMZY5zyU9KSHD4BEHyX/3KSxaa6O0e2VNfyFDvHcEQrBIUW
	 bd82xmmgnk756BP7oXclO74C3UoYQ1RpyBCIMyFCTPKScXjr6JuhakROp532PhlGii
	 7+tvviJq58faR47mZtEi7AqNFpFYy9IdeQC20flk26Vt7yInq2BpBVQ+uTWDrRFQIw
	 +FUaxo2v+2zrzcANJTXCpP90ZjjCTSjtH3May7B81OOEfG5gnjI+7xflXFP/VICNWm
	 ngwbXG7eIyqM2nFDwd/Nrju8ruvTr6mFAlwtP7QUprRc0YvAWx8z4toMr8/O9/l88w
	 etg8T2ReDZfXA==
Date: Tue, 21 Jul 2026 15:40:56 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
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
Subject: Re: [PATCH v8 00/23] dma-mapping: Track shared DMA state through
 direct, pool and swiotlb paths
Message-ID: <20260721124056.GK110966@unreal>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717180442.110954-1-aneesh.kumar@kernel.org>

On Fri, Jul 17, 2026 at 11:34:18PM +0530, Aneesh Kumar K.V (Arm) wrote:
> This series tracks confidential-computing shared DMA state through the
> dma-direct, dma-pool, and swiotlb paths so that encrypted and decrypted
> DMA buffers are handled consistently.

<...>

> - makes dma_direct_map_phys() choose the DMA address encoding from
>   DMA_ATTR_CC_SHARED and fall back to swiotlb when a shared DMA request
>   cannot use the direct mapping, which lets arm64 and x86 CCA guests stop
>   relying on SWIOTLB_FORCE for DMA mappings

Why don't we continue the effort to remove "struct page" entirely
from the DMA API internals?

IMHO, everything not exposed to DMA API users should use
phys_addr_t, including the DMA address pool.

Thanks
