Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6743E423A7B;
	Tue,  9 Jun 2026 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781012746; cv=none; b=ZWHr328Tmd7fA6qQ5rtwyGpNfSOoUX2NAY9JQM71ybusk++Kq6QARqRDiRWiZGsYh733g8BCBv7rb2NlbliRsNnU5DNj06xlosTxRjZjYoyRmnHxcEglK6NcS22gQd0SraVeS38Dr4bWmEDW0kaALWqccWCW37XjDN+oTI+qWhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781012746; c=relaxed/simple;
	bh=hPU8IDMY/1bigood4PJh0IZ3C11zD9lylepa8mUtOe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6/7R2GF0EmJZEMdzG8lVRwGOx+HG9JGPeUWqApCV1qJpuXq6H13cfaALC7Qy2RqKHQI4xwnRNyMJmIc1G87MlXtMiulmMUtnvBbT1psmNZEWl/Pig++3ikJLp9AfDgPG3oCi69o8k5W56UaORRC6axZtx77SusujrYYNMLIuts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=oYrRuOCH; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="oYrRuOCH"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D20B2680;
	Tue,  9 Jun 2026 06:45:40 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 474453F905;
	Tue,  9 Jun 2026 06:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781012744; bh=hPU8IDMY/1bigood4PJh0IZ3C11zD9lylepa8mUtOe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oYrRuOCHy40/LOMBgqLu/oSgePxQ/mEJvhjlcrmFG7n5JH5hYFOLq53vSRXwMoF4K
	 WsW1KucEpt3XAT202ZIToMDDzs85/wgGVIarAdGuD75zD75OG/1q8Da0LYudlb70WF
	 JMHFfuqPz/yyRGv++Hfm4quhY9yzz7uhfEXlBEaY=
Date: Tue, 9 Jun 2026 14:45:37 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	stable@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 14/20] dma-direct: return struct page from
 dma_direct_alloc_from_pool()
Message-ID: <aigZAUwss-_axBJ3@arm.com>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-15-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604083959.1265923-15-aneesh.kumar@kernel.org>

On Thu, Jun 04, 2026 at 02:09:53PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Commit 5b138c534fda ("dma-direct: factor out a dma_direct_alloc_from_pool
> helper") changed dma_direct_alloc_from_pool() to return the CPU address
> from dma_alloc_from_pool(). That fits dma_direct_alloc(), but
> dma_direct_alloc_pages() also uses the helper and expects a struct page *.
> 
> Fix this by making dma_direct_alloc_from_pool() return the struct page *
> again, and pass the CPU address back through an out-parameter for the
> dma_direct_alloc() caller.
> 
> Fixes: 5b138c534fda ("dma-direct: factor out a dma_direct_alloc_from_pool helper")
> Cc: stable@vger.kernel.org
> 
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Nit: remove the empty line after Cc: stable. It may confuse tooling.

-- 
Catalin
