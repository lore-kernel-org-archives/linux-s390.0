Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A643F4DC8;
	Wed,  8 Jul 2026 12:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783512727; cv=none; b=lAO81Plld+P48KNKaKPb8JxUS7jcUEaHdzpD0GF7FJpvNUYwnXpWEeALN1Eeu7b2CQkVpUpOFORV+bbjPlmtg3AUaRJ9WT5I757vRKB/2watb6utMrrZZSIjep+xHpFJTc+mX1GyQsEpRkqRBko52rRgIXNFUJ0fcemdabosTow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783512727; c=relaxed/simple;
	bh=8/7zvmWxegXEn2qwWzbLy+la1fhDjUolmn1c+tkuiCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8AC1wcmX3gnVzlp6aULjfOwy8bM+q4eJks3jmQvUdVOwfCKCyfN1uJIe9wkuZH8oqQ5vA3RNP7Y0uh5W5nunLul26CrezOvnDrTRWXS0URXboeYRLrGO26R8+A4QFuy8nv87GCjRnG5lp/W8pP5I2HpjjYp0mYUE0SxDJUOBQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VYLThK6n; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VYLThK6n"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8995215A1;
	Wed,  8 Jul 2026 05:12:00 -0700 (PDT)
Received: from [10.1.37.27] (Suzukis-MBP.cambridge.arm.com [10.1.37.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B81CF3F7B4;
	Wed,  8 Jul 2026 05:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783512724; bh=8/7zvmWxegXEn2qwWzbLy+la1fhDjUolmn1c+tkuiCo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VYLThK6nv7poE0WxqyAkkUzVattkhpNXgz0FB5kUhD63AtBVZyrisuMmv5M0CoESI
	 L6c2zVVqqGetqMAqNotIZPSb5x7ZJI/M+DkEmmj/SyrIe71mPHqJUlt3Lr8T1+qgXX
	 3+YkEUZClQkuG47VW0GuZxUiJRDmk0w4H31JziKU=
Message-ID: <79a41669-72f0-4068-9f38-62fb586d9180@arm.com>
Date: Wed, 8 Jul 2026 13:11:57 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 16/22] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
Content-Language: en-GB
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>,
 Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
 Petr Tesarik <ptesarik@suse.com>, Alexey Kardashevskiy <aik@amd.com>,
 Dan Williams <dan.j.williams@intel.com>, Xu Yilun
 <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
 Jiri Pirko <jiri@nvidia.com>, Michael Kelley <mhklinux@outlook.com>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-17-aneesh.kumar@kernel.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20260701054926.825925-17-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/07/2026 06:49, Aneesh Kumar K.V (Arm) wrote:
> Teach dma_direct_map_phys() to select the DMA address encoding based on
> DMA_ATTR_CC_SHARED.
> 
> Use phys_to_dma_unencrypted() for decrypted mappings and
> phys_to_dma_encrypted() otherwise. If a device requires unencrypted DMA
> but the source physical address is still encrypted, force the mapping
> through swiotlb so the DMA address and backing memory attributes remain
> consistent.
> 
> Update the arm64, x86, s390 and powerpc secure-guest setup to not use
> swiotlb force option
> 
> Tested-by: Jiri Pirko <jiri@nvidia.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
> Changes from v3:
> * Handle DMA_ATTR_MMIO
> ---
>   arch/arm64/mm/init.c                 |  4 +--
>   arch/powerpc/platforms/pseries/svm.c |  2 +-
>   arch/s390/mm/init.c                  |  2 +-
>   arch/x86/kernel/pci-dma.c            |  4 +--
>   kernel/dma/direct.c                  |  4 ++-
>   kernel/dma/direct.h                  | 45 +++++++++++++++-------------
>   6 files changed, 31 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 97987f850a33..acf67c7064db 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -338,10 +338,8 @@ void __init arch_mm_preinit(void)
>   	unsigned int flags = SWIOTLB_VERBOSE;
>   	bool swiotlb = max_pfn > PFN_DOWN(arm64_dma_phys_limit);
>   
> -	if (is_realm_world()) {
> +	if (is_realm_world())
>   		swiotlb = true;
> -		flags |= SWIOTLB_FORCE;
> -	}
>   
>   	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) && !swiotlb) {
>   		/*


For arm64 CCA bits:

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
