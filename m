Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1013590AE;
	Tue,  6 Oct 2026 21:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791323372; cv=none; b=SxCiulIhvc5juDpOUhg7rVBbuymwjWgqyE6AHVJVpBmFHaY74xYOA39ylLYJR5ePjiEnvR1q5tddRoRfKwHwhFN5exXSCUOQJGI6kP6ic4LaJTrOXLMY0Lb76r0YS8IRBEbcoD5syo9Hk5rMtPIiAOKqfOls2+61FTeljot4Juw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791323372; c=relaxed/simple;
	bh=zmNVpFiIdF8yRDkY6dmoQbBghNxbyY57cDfc2JuLrNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaMcm3GZ0WsGIoZ+lExP9KiVQRxRbCyNpVXiGH/DOBSI1UMcHdoL8RKH83lhYyVnoA98jLErWeeLUoPcDojxgHzyxdBeq5+NrDDF9cOBfbRfU7a7xUYgHF16ZlD293WiyNE6T2qKX9eYmV+GAaJN7lFGXNZ3ah5Fhawa5lMIg8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+T8EQwQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+T8EQwQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873651F0089B;
	Tue,  6 Oct 2026 21:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791323371;
	bh=MR/kKzdKUbRbxIo5AlBnzLpoRKt6DdnYtuH9HxT5rZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z+T8EQwQfcC4Dsl0rfHAy7DAr3ckjnc55xRY9k8ihf2V06by9utsJIUbvm4QE+qHR
	 QKdcDlyOBwe3F4rGUU5EdOvz65Jgt+VzWFiWaBtahe3bL5n/K61Ms7q595gvqrDB72
	 Ez27iKZ/SQ1f/FuWmqqDU3Guw4kpQZ2aiSIWeXp3/Fi2cDErexzgESkZmUkPWv20Vo
	 49yv64pLvV9ZDzsc7eMwgznEKqg8QdJ8I29J3N+TnSgVCEcytw3htWHfNzQjfFCe5P
	 LSItfvLQ9ixCWlP4yZR7plvTFG2lBxy8cZ/+eIE5upXhl7h44DyChdW/rFTzCXyyRz
	 k1f+1HOXPJh8g==
Date: Tue, 6 Oct 2026 22:49:17 +0100
From: Will Deacon <will@kernel.org>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
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
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v6 6/8] dma: swiotlb: Centralize memory-encryption pool
 sizing
Message-ID: <asVs3doaJ4WrT3M2@willie-the-truck>
References: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
 <20260924060756.1325156-7-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924060756.1325156-7-aneesh.kumar@kernel.org>

On Thu, Sep 24, 2026 at 11:37:54AM +0530, Aneesh Kumar K.V (Arm) wrote:
> Memory-encrypted guests use shared or unencrypted memory for DMA and may
> route all DMA through SWIOTLB. The default pool can therefore be too
> small for I/O-intensive workloads.
> 
> Move the existing x86 guest-sizing policy into the SWIOTLB core. For
> SWIOTLB_POOL_CC_GUEST, size the pool to 6% of guest memory, clamped
> between the normal default and 1 GiB. Preserve an explicit swiotlb=
> size.
> 
> Host memory encryption still selects a normal-sized shared pool and
> does not use the guest-sizing policy.
> 
> A restricted DMA pool already provides shared bounce buffers for its
> devices. Record its presence during reserved-memory initialization and
> do not select the confidential-guest default-pool policy solely because
> guest memory encryption is active.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  arch/x86/mm/mem_encrypt.c | 24 ------------------------
>  kernel/dma/swiotlb.c      | 27 +++++++++++++++++++++++++--
>  2 files changed, 25 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 95bae74fdab2..912f22ca838f 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -101,9 +101,6 @@ void __init mem_encrypt_init(void)
>  
>  void __init mem_encrypt_setup_arch(void)
>  {
> -	phys_addr_t total_mem = memblock_phys_mem_size();
> -	unsigned long size;
> -
>  	/*
>  	 * Do RMP table fixups after the e820 tables have been setup by
>  	 * e820__memory_setup().
> @@ -114,27 +111,6 @@ void __init mem_encrypt_setup_arch(void)
>  	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>  		return;
>  
> -	/*
> -	 * For SEV and TDX, all DMA has to occur via shared/unencrypted pages.
> -	 * Kernel uses SWIOTLB to make this happen without changing device
> -	 * drivers. However, depending on the workload being run, the
> -	 * default 64MB of SWIOTLB may not be enough and SWIOTLB may
> -	 * run out of buffers for DMA, resulting in I/O errors and/or
> -	 * performance degradation especially with high I/O workloads.
> -	 *
> -	 * Adjust the default size of SWIOTLB using a percentage of guest
> -	 * memory for SWIOTLB buffers. Also, as the SWIOTLB bounce buffer
> -	 * memory is allocated from low memory, ensure that the adjusted size
> -	 * is within the limits of low available memory.
> -	 *
> -	 * The percentage of guest memory used here for SWIOTLB buffers
> -	 * is more of an approximation of the static adjustment which
> -	 * 64MB for <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
> -	 */
> -	size = total_mem * 6 / 100;
> -	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
> -	swiotlb_adjust_size(size);
> -
>  	/* Set restricted memory access for virtio. */
>  	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
>  }
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 75ee63cd354e..e626cca63ad1 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -33,6 +33,7 @@
>  #include <linux/kmsan-checks.h>
>  #include <linux/iommu-helper.h>
>  #include <linux/init.h>
> +#include <linux/math64.h>
>  #include <linux/memblock.h>
>  #include <linux/mm.h>
>  #include <linux/pfn.h>
> @@ -80,6 +81,7 @@ struct io_tlb_slot {
>  
>  static bool swiotlb_force_bounce;
>  static bool swiotlb_force_disable;
> +static bool restricted_dma_pool_present __initdata;
>  
>  enum swiotlb_pool_policy {
>  	SWIOTLB_POOL_NONE,
> @@ -478,7 +480,25 @@ swiotlb_adjust_pool_size(enum swiotlb_pool_policy policy)
>  		size = min(swiotlb_default_pool_size(), size);
>  		break;
>  	case SWIOTLB_POOL_CC_GUEST:
> -		return;
> +		/*
> +		 * For SEV and TDX and CCA, all DMA has to occur via
> +		 * shared/unencrypted pages. Kernel uses SWIOTLB to make this
> +		 * happen without changing device drivers. However, depending on
> +		 * the workload being run, the default 64MB of SWIOTLB may not be
> +		 * enough and SWIOTLB may run out of buffers for DMA, resulting in
> +		 * I/O errors and/or performance degradation especially with high
> +		 * I/O workloads.
> +		 *
> +		 * Adjust the default size of SWIOTLB using a percentage of guest
> +		 * memory for SWIOTLB buffers.
> +		 *
> +		 * The percentage of guest memory used here for SWIOTLB buffers is
> +		 * more of an approximation of the static adjustment which 64MB for
> +		 * <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
> +		 */
> +		size = div_u64((u64)memblock_phys_mem_size() * 6, 100);
> +		size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
> +		break;
>  	case SWIOTLB_POOL_NONE:
>  		WARN(true, "Cannot adjust SWIOTLB size without a pool\n");
>  		return;
> @@ -496,7 +516,8 @@ swiotlb_select_pool_policy(unsigned int flags)
>  	if (swiotlb_force_disable)
>  		return SWIOTLB_POOL_NONE;
>  
> -	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> +	    !restricted_dma_pool_present)
>  		return SWIOTLB_POOL_CC_GUEST;

I think this check on the restricted DMA pool is too general -- the pool
could be tied to a specific DMA-capable peripheral and so treating its
presence as a global property isn't right.

Will
