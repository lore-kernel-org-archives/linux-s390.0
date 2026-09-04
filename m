Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB6446A60B
	for <linux-s390@vger.kernel.org>; Fri,  4 Sep 2026 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518136; cv=none; b=BVV+X38pkvG2IsiIvZ0PlY4EvoRelSpaS1BA8AsAyDqnfvgbeEbngSmU0LSo5NY7JGjgMcIAyWpwEken1VUtk0ghvPmd1wcTKoUSC+IpPHVUzysOOLe054W0AYsJEleSqYLASODBMr3/YuPXs5V/5WXUyrlh2NWJX8SWLWlm+RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518136; c=relaxed/simple;
	bh=NCLHjs+7vIB6IO1LloDMgXSZ6hifXqqo7ZdgEyFV9Dc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fn/HogyxzB6u/Gh3VKtY/3WxlbuM2hizXUXOTfG69yJfAK9fgTPPKnh8gqTjF3pBEJEBlt5IZ88yeJNrSn+tCeMtqDynikhovTZZxEUlu5FdFFEdsFN0GK+nwcjwvbQSCDNfsqJt8vViRsr47+Gli3hqUr4xKpJXEioMUouG+9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cn4CjLOc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cn4CjLOc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC191F00AC4;
	Fri,  4 Sep 2026 10:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788518134;
	bh=CpmKzGRYhjzO5CiL9L7cxcO5FTIJXnu0N4BAs90vGto=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cn4CjLOclce10L33BFbSNPfwYrJTDYc03K3ysBNvSjJukCBlj2jdZNNHxYJyvZhrc
	 7ErT8HF1IJ+iSzqLwObhWPqhLoddNs5hzjL2vy4Ex0CScHmwoRHBDmMwL3RArSFIul
	 0bQR1qg+hBoeEXh6KQYaAjNWJagJuJg5eAeOcMXNAjJfXlfKTtCYLhZ4dQBiK55GDS
	 cVSrE1+uoCdbfH4E2aaJsxpw1TsaJ9sFyrCNzgr4sXwuc7a53BVJ4haAJZWx7Wlv+W
	 65TYH7cJ5zpauhlfdbE/fY9a0x2QDl3tF9/9gZpUfg4UQYAurrzsVnXlJZVCfFNvRm
	 UH0E75Ps4NY7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] dma: swiotlb: Remove SWIOTLB_ANY
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260904101810.1193505-5-aneesh.kumar@kernel.org>
References: <20260904101810.1193505-1-aneesh.kumar@kernel.org>
 <20260904101810.1193505-5-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 10:35:33 +0000
Message-Id: <20260904103533.DCC191F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Inverting the default SWIOTLB allocation behavior from `memblock_a=
lloc_low()` to `memblock_alloc()` breaks DMA for legacy 32-bit devices on x=
86 systems with `iommu=3Doff` when memory encryption or `swiotlb=3Dforce` i=
s used.
--

commit 35955ff88ad01e61df3c901065f4e509abaab7d0
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

dma: swiotlb: Remove SWIOTLB_ANY

SWIOTLB_ANY permits the swiotlb pool to be allocated outside the
architecture's low address limit. This is already implied when
SWIOTLB_INIT_ADDRESSING_LIMIT is not set, making SWIOTLB_ANY redundant.

Use SWIOTLB_INIT_ADDRESSING_LIMIT as the sole indication that the
default pool and any dynamically allocated pools must reside below
ARCH_LOW_ADDRESS_LIMIT. Otherwise, allow the pools to use any directly
mapped memory.

> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index c4611b2c45403..2715833a21f8a 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -448,15 +448,10 @@ static void __init *swiotlb_memblock_alloc(unsigned=
 long nslabs,
>  	size_t bytes =3D PAGE_ALIGN(nslabs << IO_TLB_SHIFT);
>  	void *tlb;
> =20
> -	/*
> -	 * By default allocate the bounce buffer memory from low memory, but
> -	 * allow to pick a location everywhere for hypervisors with guest
> -	 * memory encryption.
> -	 */
> -	if (flags & SWIOTLB_ANY)
> -		tlb =3D memblock_alloc(bytes, PAGE_SIZE);
> -	else
> +	if (flags & SWIOTLB_INIT_ADDRESSING_LIMIT)
>  		tlb =3D memblock_alloc_low(bytes, PAGE_SIZE);
> +	else
> +		tlb =3D memblock_alloc(bytes, PAGE_SIZE);

[Severity: High]
Does inverting the default SWIOTLB allocation behavior from memblock_alloc_=
low()
to memblock_alloc() break DMA for legacy 32-bit devices on x86 systems?

If a system boots with iommu=3Doff and swiotlb=3Dforce (or memory encryptio=
n),
pci_swiotlb_detect() leaves x86_swiotlb_flags as 0 because no_iommu is true:

arch/x86/kernel/pci-dma.c:pci_swiotlb_detect() {
	/* don't initialize swiotlb if iommu=3Doff (no_iommu=3D1) */
	if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN) {
		x86_swiotlb_enable =3D true;
		x86_swiotlb_flags |=3D SWIOTLB_INIT_ADDRESSING_LIMIT;
	}
    ...
}

Because SWIOTLB_INIT_ADDRESSING_LIMIT is not set, this new logic uses
memblock_alloc() instead of the previous memblock_alloc_low(), placing the
bounce buffer pool anywhere, including above 4GB.

Legacy 32-bit devices will then fail DMA mappings because they receive boun=
ce
buffers allocated above 4GB, failing dma_capable() checks and causing
swiotlb_map() to return DMA_MAPPING_ERROR.

[ ... ]

> @@ -598,10 +593,10 @@ void __init swiotlb_init_remap(unsigned int flags,
>  #ifdef CONFIG_SWIOTLB_DYNAMIC
>  	if (!remap)
>  		io_tlb_default_mem.can_grow =3D true;
> -	if (flags & SWIOTLB_ANY)
> -		io_tlb_default_mem.phys_limit =3D virt_to_phys(high_memory - 1);
> -	else
> +	if (flags & SWIOTLB_INIT_ADDRESSING_LIMIT)
>  		io_tlb_default_mem.phys_limit =3D ARCH_LOW_ADDRESS_LIMIT;
> +	else
> +		io_tlb_default_mem.phys_limit =3D virt_to_phys(high_memory - 1);
>  #endif

[Severity: High]
Similarly, does this incorrectly record an unrestricted phys_limit for the =
pool
when SWIOTLB_INIT_ADDRESSING_LIMIT is missing under the same iommu=3Doff
conditions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904101810.1193=
505-1-aneesh.kumar@kernel.org?part=3D4
