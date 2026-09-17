Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3AB390CA6;
	Thu, 17 Sep 2026 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789656477; cv=none; b=WmHJRaDIiThSV7FKlGQvnrE68VTCxRNxa1qMPSM8QHgTWeyDMuVxEOwN6o86U0TzUIwSKrYNjsRBrt51xxzcbn9GTspM1ouQur5nsc0PRvhA4SU9CP6cNt9hfibBbgHao2uiguHWU7CnoWXBvEMlwzqn5nTM4/1tb8kqW37vApM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789656477; c=relaxed/simple;
	bh=M6L3gDgo7kZ+fxTWrN1ZIsrMlAv/aP6jh31bZohJ0Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCzAOPFGa4ebpahvaOppnQjatrE5PhBh2u6MjtOZT4E2PnBPspqelbIUyY35vLTCqsl1Qs9CZDi0DuC1iCe10MbE7tGERufGm6B9PEkggFXd+YazmJGTLJXuFUzkb3/DO+K5Ml17Go60LSKGEV4NOXy3Xcrw2FE1jnV6On3cs/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FfOzLZ+3; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FfOzLZ+3"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52F5B1476;
	Thu, 17 Sep 2026 07:47:42 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 011E03F86F;
	Thu, 17 Sep 2026 07:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789656465; bh=M6L3gDgo7kZ+fxTWrN1ZIsrMlAv/aP6jh31bZohJ0Rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FfOzLZ+3Qia0W7RivVKaHNN7ieAHkjlQ0vn4TRTzuF7z8OiKjJ/k086OfMvanwLe4
	 ELpOh1p5+42rsPtfbx27NAQlMXC2xMiCbIVs5xTJrXk64zRBISqHGguvSJA4aBz7vA
	 RLAIQplJPf8iM7ccnFiG8UpvaheI8Ih5+YH3OgPE=
Date: Thu, 17 Sep 2026 15:47:37 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
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
	Xu Yilun <yilun.xu@linux.intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v4 1/5] dma: swiotlb: Centralize default pool policy
 selection
Message-ID: <aqv9icxsfN3PLErN@arm.com>
References: <20260914070135.313337-1-aneesh.kumar@kernel.org>
 <20260914070135.313337-2-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914070135.313337-2-aneesh.kumar@kernel.org>

On Mon, Sep 14, 2026 at 12:31:30PM +0530, Aneesh Kumar K.V (Arm) wrote:
> diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
> index 3be2451e7bc8..22c8190fe34d 100644
> --- a/arch/x86/include/asm/iommu.h
> +++ b/arch/x86/include/asm/iommu.h
> @@ -14,8 +14,10 @@ extern bool amd_iommu_snp_en;
>  
>  #ifdef CONFIG_SWIOTLB
>  extern bool x86_swiotlb_enable;
> +extern unsigned int x86_swiotlb_flags;
>  #else
>  #define x86_swiotlb_enable false
> +#define x86_swiotlb_flags 0
>  #endif
>  
>  /* 10 seconds */
> diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
> index b5f1f031d45b..d0fbc0271e43 100644
> --- a/arch/x86/kernel/amd_gart_64.c
> +++ b/arch/x86/kernel/amd_gart_64.c
> @@ -814,6 +814,7 @@ int __init gart_iommu_init(void)
>  	dma_ops = &gart_dma_ops;
>  	x86_platform.iommu_shutdown = gart_iommu_shutdown;
>  	x86_swiotlb_enable = false;
> +	x86_swiotlb_flags = 0;

I don't think the flags are still read anywhere after this function.
gart_iommu_init() is called long after swiotlb_init(). So you can drop
this and make x86_swiotlb_flags static in pci-dma.c.

With this:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
