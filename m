Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F643547058;
	Fri, 18 Sep 2026 07:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789715149; cv=none; b=OaiN95XH13NRQ76DsJzV4WmV/baLPdUoL8vE2wwt5FaqXKnQyKxS8apxUY+Dt6YqHaA8wzoX7sQDbELH5DtF8Qp1iTh4i9y3tfBECwusTbuzyb8e3T5u5kfdEfzE05v2PMqXFJNqHPvk8SOqYbJ7RaGWUlrc11o4s9K8MvUG+Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789715149; c=relaxed/simple;
	bh=05z6qLqKU64IlgEUILy3XDrtidGtamK524q1GX8phvo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eCTsgI9o58FWN06P0Q6K8JQmsjqoWrYeETMPzPC/CozQIPRRdUmvjbJ98uWruiMbW5Cfxw00ANCjwWNXb0CfKu4RVrQAq3xjw6u68EqQxexjeqYd7/VRHMjcDw1f8rYFc+dPcozCyg98X3GaIzH0LjtKAHybXOTlR0I+J16uVM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhbOg+jM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhbOg+jM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1671F000FF;
	Fri, 18 Sep 2026 07:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789715148;
	bh=8A8/O+7kImUGwyK+g6ktN1c/AodTX2n+ZCwskgpCIms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=OhbOg+jMAJehO/c3Cb2LnBG1EHaNGxRwW7RCZKKxd0yM2OJJ2I84lIBozdzVSMMs3
	 +WM4nMhZGCgtmfbKF+3FYXPCXP1Fn4FFDij6NV9v6vIfhZZcrzdoad/ioZKk/OLmU7
	 U4BRT2idZTVWZWW7yJkZHO27YBS7pMiTfQDvZSfV9J/5lxNpLMBaC5tQN7SfTOadJv
	 2ad3QLFHUCi8MRnPkgfHrIBMEzM8OuOnv3XlsTimZnNOMHmO/2eVA2IOEf37ZK8x57
	 I3K6leIS7bYtSSIm8iuKjzuG67oG4h4B/uj+r42SlmJq9Rrpr4mu5D0Ji8r74G52jV
	 CtOj2OqWqqw7Q==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
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
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v4 2/5] dma: swiotlb: Centralize minimal pool sizing
In-Reply-To: <aqwLiHQb71hU8cEy@arm.com>
References: <20260914070135.313337-1-aneesh.kumar@kernel.org>
 <20260914070135.313337-3-aneesh.kumar@kernel.org>
 <aqwLiHQb71hU8cEy@arm.com>
Date: Fri, 18 Sep 2026 12:35:33 +0530
Message-ID: <yq5a4ifn11ky.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Mon, Sep 14, 2026 at 12:31:31PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> NOTE: We lose the RISC-V SWIOTLB_ANY setting in this patch. It will be
>> reinstated in a follow-up patch where we make SWIOTLB_ANY redundant.
>
> [...]
>
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index e0e4c103d603..734712230f35 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -165,31 +165,11 @@ static void print_vm_layout(void) { }
>>  
>>  void __init arch_mm_preinit(void)
>>  {
>> -	bool swiotlb = max_pfn > PFN_DOWN(dma32_phys_limit) &&
>> -		       memblock_start_of_DRAM() < dma32_phys_limit;
>>  	unsigned int swiotlb_flags = SWIOTLB_VERBOSE;
>>  #ifdef CONFIG_FLATMEM
>>  	BUG_ON(!mem_map);
>>  #endif /* CONFIG_FLATMEM */
>>  
>> -	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) && !swiotlb &&
>> -	    dma_cache_alignment != 1) {
>> -		/*
>> -		 * No 32-bit DMA bouncing needed (either all DRAM is within
>> -		 * the 32-bit limit, or it all starts above it), but
>> -		 * kmalloc() buffers whose sizes are not cache-line-aligned
>> -		 * still require bouncing for non-coherent DMA.  Use
>> -		 * SWIOTLB_ANY so that the buffer can be allocated from high
>> -		 * memory when DRAM starts above dma32_phys_limit.  Allocate
>> -		 * ~1 MB per 1 GB of RAM.
>> -		 */
>> -		unsigned long size =
>> -			DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
>> -		swiotlb_adjust_size(min(swiotlb_size_or_default(), size));
>> -		swiotlb = true;
>> -		swiotlb_flags |= SWIOTLB_ANY;
>> -	}
>
> Does it break the bisectability for risc-v? IIUC this undoes commit
> cfca5a48b03f until patch 5. Basically if there's no low memory and no
> SWIOTLB_ANY passed, memblock_alloc_low() will fail.
>

I mentioned this in the commit message. I can add the change below and
remove it in patch 5. 

modified   arch/riscv/mm/init.c
@@ -165,11 +165,27 @@ static void print_vm_layout(void) { }
 
 void __init arch_mm_preinit(void)
 {
+	bool swiotlb = max_pfn > PFN_DOWN(dma32_phys_limit) &&
+		       memblock_start_of_DRAM() < dma32_phys_limit;
 	unsigned int swiotlb_flags = SWIOTLB_VERBOSE;
 #ifdef CONFIG_FLATMEM
 	BUG_ON(!mem_map);
 #endif /* CONFIG_FLATMEM */
 
+	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) && !swiotlb &&
+	    dma_cache_alignment != 1) {
+		/*
+		 * No 32-bit DMA bouncing needed (either all DRAM is within
+		 * the 32-bit limit, or it all starts above it), but
+		 * kmalloc() buffers whose sizes are not cache-line-aligned
+		 * still require bouncing for non-coherent DMA.  Use
+		 * SWIOTLB_ANY so that the buffer can be allocated from high
+		 * memory when DRAM starts above dma32_phys_limit.  Allocate
+		 * ~1 MB per 1 GB of RAM.
+		 */
+		swiotlb_flags |= SWIOTLB_ANY;
+	}
+
 	if ((max_pfn > PFN_DOWN(dma32_phys_limit)) &&
 	     (memblock_start_of_DRAM() < dma32_phys_limit))
 		swiotlb_flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;


>
> I think we could preserve SWIOTLB_ANY until patch 5. Or it might be
> simpler to move patches 2 and 3 at the end (I haven't tried).
>
>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>> index aa19e81ae544..90e0bfd0715c 100644
>> --- a/kernel/dma/swiotlb.c
>> +++ b/kernel/dma/swiotlb.c
>> @@ -304,6 +304,11 @@ unsigned long swiotlb_size_or_default(void)
>>  	return default_nslabs << IO_TLB_SHIFT;
>>  }
>>  
>> +static bool __init swiotlb_default_size_changed(void)
>> +{
>> +	return default_nslabs != IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT;
>> +}
>
> I mentioned before in passing
> (https://lore.kernel.org/all/ann6noRzoPLL9kDY@arm.com/), if one sets
> swiotlb= to the default size, it will go unnoticed. I know it's an
> existing issue but we might as well fix it now with a bool that tells us
> the swiotlb size was forced/changed.
>

I will do this as an addtional patch

modified    kernel/dma/swiotlb.c
@@ -108,6 +108,7 @@
 
 static unsigned long default_nslabs = IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT;
 static unsigned long default_nareas;
+static bool swiotlb_size_set __initdata;
 
 /**
  * struct io_tlb_area - IO TLB memory area descriptor
@@ -270,6 +271,7 @@
 		/* avoid tail segment of size < IO_TLB_SEGSIZE */
 		default_nslabs =
 			ALIGN(simple_strtoul(str, &str, 0), IO_TLB_SEGSIZE);
+		swiotlb_size_set = true;
 	}
 	if (*str == ',')
 		++str;
@@ -307,7 +309,7 @@
 
 static bool __init swiotlb_default_size_changed(void)
 {
-	return default_nslabs != IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT;
+	return swiotlb_size_set;
 }
 
 void __init swiotlb_adjust_size(unsigned long size)


