Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83DB31D375;
	Mon, 18 May 2026 10:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779098702; cv=none; b=O3rrfZ/QO/rGVJDLtOCWoxAExz6nq5Lcnx3p8+EB+vtAtq2Y7I5F4qemJ+3ygjo8Y3V+KAAyTG/+1DGQ71yjBW1moteq28pRhevB+Kct2jIM7ax8sVURxj7VCIUXN/IpsX7DPGaJ5QyALsg1KyXYP4egesFM8em3KhRlxNFkN2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779098702; c=relaxed/simple;
	bh=lTcdSkMQATCIoVQpgudd8cXMuDaItU9tjvZCwTP5suo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+RJOSOqkSqin0FXsWlgvvFprKRr8/L1zPFVpNoVetuDMr93z3Du5CYaYBEHJqvSRqm6jDZRaa0jWVFbwWTm0Z6zEZcjbcViG34GUmVuWG7zgVLcsFSQgExouR4OwXUJl0WvNx4ZhXbVG9OkWKCOQftrBr7/WjWVRBD4HCr/FD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SCGHXnOZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SCGHXnOZ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I5xINO3644003;
	Mon, 18 May 2026 10:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xqG9pc
	JuVwBv9+ztVwo8tr2fW0UH1ib8ZvGVBXkIgQw=; b=SCGHXnOZiuLhs26tPceFUq
	EeQYRCC3wgSS4WI7KC14mP3KNB6D2AAKK8pfccYiMIWsB9BRMuyHWLC5udDnspwW
	A+MSsUkU0nCp6L3/eGNkBVCu1hB+8eXHDeGgYqDnt87PjvWQ3XZGVNgnhPpsTM3O
	4RLGtDNkB+Ed7HoUoZ9sKYVMrqtlNeUiKGNBWa6EpoCI7yLC1zEhqy9swpKNrXsg
	Eh0m4Z9RQMkoCEmqWYAQU39ITzthgM6HyxZdbNuggeWWv6mXqxdk9VBtNgBouq5X
	nF6ebA6+ys04MhwYCg5v/IW8Z65tcTt2nhcbcLaZv2V8o1emCOB0UpspTkHn4MbQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb86ysr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 10:04:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64I9s5oD009355;
	Mon, 18 May 2026 10:04:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhd8rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 10:04:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64IA4QZN16318818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 10:04:26 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DAF72004E;
	Mon, 18 May 2026 10:04:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D838B2004B;
	Mon, 18 May 2026 10:04:25 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 10:04:25 +0000 (GMT)
Message-ID: <3488974b-ad99-4adb-96c2-e8623f81c3f0@linux.ibm.com>
Date: Mon, 18 May 2026 12:04:25 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/13] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-coco@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
        Mostafa Saleh <smostafa@google.com>, Petr Tesarik <ptesarik@suse.com>,
        Alexey Kardashevskiy <aik@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Xu Yilun
 <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
        Halil Pasic <pasic@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Jaehoon Kim <jhkim@linux.ibm.com>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-8-aneesh.kumar@kernel.org>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260512090408.794195-8-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA5MiBTYWx0ZWRfXweiiSDL+TsiI
 8jYni17GlfiiUQkjE+LprA3ViqMfAzAhdcoH54htbeNnRhM0stXFxfm1EHaGmrBFQP9PjyEmE7N
 9n23EAatbVmq7kRfVC07ErevUPVkCpcIptKoX7JUlnUHsT+FBYtUeHFDHozSyE0NizAgMRRPE5g
 kFTi2itktI9BOqK92lemOsxyHHU4YVKMSQwXHKzI+71UPPGIZT9GZFeBKoVECnhQyA75672VqWv
 d2X8lZa4d3KiJvviOZkR8ohQGU/HfIUrSQlqVhg5OIUzYrurkPpG+II4u1stFhYU05DUs5hwz3L
 ACcOX+TyejgiHcKRx4UWAsf6hpx9+WAUMZGn1Wl8yZ9/YCgJvO+HcXIM4doqmQX+iSty4CniAeO
 muLLQBQ2AAGLzvzCLdsZbD2W5QjkHa++34l5lrzH6QygREm6GxMe3sTaM39LNf1Lzpgkh2dRn3K
 zXbCC85lM8fWpui8x6w==
X-Proofpoint-GUID: _1ROsYvBpxxXKrSVhYjNsdTf1ncTdJwI
X-Proofpoint-ORIG-GUID: GMA_N4PbhBFPm2tIl6aZuINIeP481idN
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0ae42f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=cNP6tjfTc9-AQSTecuMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180092

cc Halil, Matt, Jaehoon.
Can you have a look what this means for virtio on secure execution?

Am 12.05.26 um 11:04 schrieb Aneesh Kumar K.V (Arm):
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
>   kernel/dma/direct.h                  | 38 +++++++++++++---------------
>   6 files changed, 24 insertions(+), 30 deletions(-)
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
> diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
> index 384c9dc1899a..7a403dbd35ee 100644
> --- a/arch/powerpc/platforms/pseries/svm.c
> +++ b/arch/powerpc/platforms/pseries/svm.c
> @@ -29,7 +29,7 @@ static int __init init_svm(void)
>   	 * need to use the SWIOTLB buffer for DMA even if dma_capable() says
>   	 * otherwise.
>   	 */
> -	ppc_swiotlb_flags |= SWIOTLB_ANY | SWIOTLB_FORCE;
> +	ppc_swiotlb_flags |= SWIOTLB_ANY;
>   
>   	/* Share the SWIOTLB buffer with the host. */
>   	swiotlb_update_mem_attributes();
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index 1f72efc2a579..843dbd445124 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -149,7 +149,7 @@ static void __init pv_init(void)
>   	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
>   
>   	/* make sure bounce buffers are shared */
> -	swiotlb_init(true, SWIOTLB_FORCE | SWIOTLB_VERBOSE);
> +	swiotlb_init(true, SWIOTLB_VERBOSE);
>   	swiotlb_update_mem_attributes();
>   }
>   
> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
> index 6267363e0189..75cf8f6ae8cd 100644
> --- a/arch/x86/kernel/pci-dma.c
> +++ b/arch/x86/kernel/pci-dma.c
> @@ -59,10 +59,8 @@ static void __init pci_swiotlb_detect(void)
>   	 * bounce buffers as the hypervisor can't access arbitrary VM memory
>   	 * that is not explicitly shared with it.
>   	 */
> -	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
> +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>   		x86_swiotlb_enable = true;
> -		x86_swiotlb_flags |= SWIOTLB_FORCE;
> -	}
>   }
>   #else
>   static inline void __init pci_swiotlb_detect(void)
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index ac315dd046c4..5aaa813c5509 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -691,8 +691,10 @@ size_t dma_direct_max_mapping_size(struct device *dev)
>   {
>   	/* If SWIOTLB is active, use its maximum mapping size */
>   	if (is_swiotlb_active(dev) &&
> -	    (dma_addressing_limited(dev) || is_swiotlb_force_bounce(dev)))
> +	    (dma_addressing_limited(dev) || is_swiotlb_force_bounce(dev) ||
> +	     force_dma_unencrypted(dev)))
>   		return swiotlb_max_mapping_size(dev);
> +
>   	return SIZE_MAX;
>   }
>   
> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
> index e05dc7649366..4e35264ab6f8 100644
> --- a/kernel/dma/direct.h
> +++ b/kernel/dma/direct.h
> @@ -89,36 +89,32 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
>   	dma_addr_t dma_addr;
>   
>   	if (is_swiotlb_force_bounce(dev)) {
> -		if (!(attrs & DMA_ATTR_CC_SHARED)) {
> -			if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
> -				return DMA_MAPPING_ERROR;
> +		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
> +			return DMA_MAPPING_ERROR;
>   
> -			return swiotlb_map(dev, phys, size, dir, attrs);
> -		}
> -	} else if (attrs & DMA_ATTR_CC_SHARED) {
> -		return DMA_MAPPING_ERROR;
> +		return swiotlb_map(dev, phys, size, dir, attrs);
>   	}
>   
> -	if (attrs & DMA_ATTR_MMIO) {
> -		dma_addr = phys;
> -		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
> -			goto err_overflow;
> -	} else if (attrs & DMA_ATTR_CC_SHARED) {
> +	if (attrs & DMA_ATTR_CC_SHARED)
>   		dma_addr = phys_to_dma_unencrypted(dev, phys);
> +	else
> +		dma_addr = phys_to_dma_encrypted(dev, phys);
> +
> +	if (attrs & DMA_ATTR_MMIO) {
>   		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
>   			goto err_overflow;
> -	} else {
> -		dma_addr = phys_to_dma(dev, phys);
> -		if (unlikely(!dma_capable(dev, dma_addr, size, true, attrs)) ||
> -		    dma_kmalloc_needs_bounce(dev, size, dir)) {
> -			if (is_swiotlb_active(dev) &&
> -			    !(attrs & DMA_ATTR_REQUIRE_COHERENT))
> -				return swiotlb_map(dev, phys, size, dir, attrs);
> +		goto dma_mapped;
> +	}
>   
> -			goto err_overflow;
> -		}
> +	if (unlikely(!dma_capable(dev, dma_addr, size, true, attrs)) ||
> +	    dma_kmalloc_needs_bounce(dev, size, dir)) {
> +		if (is_swiotlb_active(dev) &&
> +		    !(attrs & DMA_ATTR_REQUIRE_COHERENT))
> +			return swiotlb_map(dev, phys, size, dir, attrs);
> +		goto err_overflow;
>   	}
>   
> +dma_mapped:
>   	if (!dev_is_dma_coherent(dev) &&
>   	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO))) {
>   		arch_sync_dma_for_device(phys, size, dir);

