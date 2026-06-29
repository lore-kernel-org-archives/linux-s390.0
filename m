Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5616B3A543F;
	Mon, 29 Jun 2026 06:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782715635; cv=none; b=dxAeLDLOKlQJASQvxfQ2Tos1mi605uwgF0Y8+exssB/b7a9b0+uviOZtYR5QXoXy3RhDqi5I8UIU7ZAg2/HY468VpXQY4Tg7OeYaAz6Q17b/ZjmHar4se6eLb1/di9IatLVNyxz8LghcDElYK3MHnL+OWrq8hPaf/l6wG989x+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782715635; c=relaxed/simple;
	bh=znmh01JaG+YV12lYbuPs8yO1BSajQWT1IMsv0kKGPJk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LkHEP63dYSJREyb796jJgGbavCe7adoRQuFjMgCD4KU9etYJSmhty9woWI1Fi+l58AGxVJK8UmZJy7NJvGPQg3EoHfvA0EXO7bAnqS6Z+uXEABHxOpCNFVJLXMnjuKfWy2WcncyOKyJd/p22RqOhoZvXXZpCRc2BsTMcwIsHWvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD6E1F000E9;
	Mon, 29 Jun 2026 06:47:03 +0000 (UTC)
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
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
Subject: Re: [PATCH v6 00/20] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
In-Reply-To: <20260619140616.GB1068655@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <aigYbK12D8uKQvJF@arm.com> <20260609144746.GL2764304@ziepe.ca>
 <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com>
 <yq5aqzm4dz25.fsf@kernel.org> <20260618153705.GH231643@ziepe.ca>
 <yq5ao6h6enhm.fsf@kernel.org> <20260619122148.GL231643@ziepe.ca>
 <yq5aldcaejos.fsf@kernel.org> <20260619140616.GB1068655@ziepe.ca>
Date: Mon, 29 Jun 2026 12:16:30 +0530
Message-ID: <yq5ao6gtoncp.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Fri, Jun 19, 2026 at 02:36:19PM +0100, Aneesh Kumar K.V wrote:
>> >> Agreed. If the device can do encrypted DMA and requires bouncing, it
>> >> should bounce through encrypted pools. We don't support encrypted pools
>> >> now and that means, we mark the option ("mem_encrypt=on iommu=pt
>> >> swiotlb=force") not supported for now? 
>> >
>> > ?? if you don't have a CC system then the swiotlb is "encrypted"
>> > meaning ordinary struct page system memory.
>> >
>> > The hypervisor should not be triggering any CC special stuff here, it
>> > is not a CC guest.
>> >
>> > Agree we don't need to worry about swiotlb=force with a trusted device
>> > in the GUEST for now, but it should be something to fix eventually.
>> >
>> 
>> If i understand this correctly, the setup Alexey is referring to here is
>> bare metal system with memory encryption enabled and dma address doesn't
>> need C bit cleared because it is handled in iommu.
>
> This is how I understand it too, if the iommu is turned on then it can
> take the high PA with the C bit set and map it to an IOVA that matches
> the device's dma limit.
>
>> ( I consider this as memory encryption that is handled
>> transparently, device can access any address because that encryption
>> details are now managed by iommu).
>
> Compared to the guest side there are some important host side differences:
>
>  - On the host the iommu can fix it because this is only a matter of
>    IOVA range not access control. On a guest even a IOMMU cannot
>    permit access to private memory
>  - On the host the state of the device is driven by the dma limit
>    which is not set until after the driver probes. On guest the state is
>    set by the tsm and device security level before the driver
>    probes
>  - Both flows end up using pgprot_decrypted and set_memory_decrypted()
>    to create their special pools, but for completely different
>    reasons.
>  - The memory coming from the special swiotlb pool must NOT be used by
>    a trusted device on a CC guest, while there is no problem for any
>    device to use it on the host.
>

Agreed.

>> Thinking about this more, I guess we should mark the swiotlb as
>> cc_shared only with  CC_ATTR_GUEST_MEM_ENCRYPT instead of
>> CC_ATTR_MEM_ENCRYPT as we have below.
>
> The name cc_shared should be used for GUEST scenarios only.
>
> I guess there is some merit in keeping swiotlb using "decrypted" to
> mean it usinig pgprot_decrypted and set_memory_decyped() which AMD
> gives meaning to on both host and guest.
>

Are you suggesting to change the struct io_tlb_mem::cc_shared back to
struct io_tlb_mem::unencrypted?. If we want to split cc_shared and
unencrypted as two flags, I think we will add quiet a lot of code
duplication.

> IDK what AMD should do on the host by default. I guess it should setup
> a swiotlb pool of low dma addrs "unencrypted", but not "cc_shared"?
>

If by low DMA address you mean using an address with the C-bit
cleared. Currently the SME code uses force_dma_unencrypted() as the hook to
determine whether the C-bit needs to be cleared. Therefore,
force_dma_unencrypted(dev) must be true to use such a pool.

The current code already does this and uses the swiotlb pool correctly
on SME. The challenge arises when we want to force SWIOTLB
bouncing even for devices that can handle encrypted DMA addresses (more
on that below). For such a config force_dma_uencrypted(dev) will return
false and swiotlb will be marked cc_shared/decrypted = true; This trip
the new check we added.

	/* swiotlb pool is incorrect for this device */
	if (unlikely(mem->cc_shared != force_dma_unencrypted(dev)))
		return (phys_addr_t)DMA_MAPPING_ERROR;

We can also do

	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
		/* swiotlb pool is incorrect for this device */
		if (unlikely(mem->cc_shared != force_dma_unencrypted(dev)))
			return (phys_addr_t)DMA_MAPPING_ERROR;

		/* Force attrs to match the kind of memory in the pool */
		if (mem->cc_shared)
			*attrs |= DMA_ATTR_CC_SHARED;
		else
			*attrs &= ~DMA_ATTR_CC_SHARED;
	} else {
		/*
		 * Host memory encryption where device requires an
		 * unencrypted dma_addr_t due to dma mask limit
    		 */
		if (force_dma_unencrypted(dev))
			*attrs |= DMA_ATTR_CC_SHARED;
		else
			*attrs &= ~DMA_ATTR_CC_SHARED;
	}


Here I see value in having DMA_ATTR_UNENCRYPTED. The question is do we
need to split this into two flags and introduce the resulting code
duplication.

>
> But if we are operating on the host then this pool is not limited to
> only T=0 devices, every device can "safely" use it. (ignoring this
> destroys the security memory encryption on bare metal was supposed to
> provide)
>
>> Now we have the case of host memory encryption where the C-bit needs to
>> be cleared in dma_addr_t. That requires special handling in the kernel, and
>> I believe we need to mark swiotlb as unencrypted in this configuration.
>
> I think we need to split the two things up, they have different
> behaviors and need different flags and labels to make it all work
> right.
>
>> I am still not clear whether there is a config option or runtime check
>> we can use to identify this case.
>
> The dma api has to detect, after the driver sets the dma limit, that
> none of system memory is usable when:
>  - The direct path is being used
>  - phys to dma for 0 is outside the dma limit
>
> Then it should assume the arch has setup a swiotlb pool for it to use
> to fix the high memory problem.
>
> Similar hackery would be needed in the dma alloc path to know that
> decrypted can be used to fix the high memory problem like for GUEST.
>
> I guess some 'dev_cannot_reach_memory(dev)' sort of test in a
> few key places? Setup with a static branch to be a nop on everything
> but AMD, compiled out on every other arch.
>

If we are not able to reach the memory because of the memory encryption
bit, then isn't dev_cannot_reach_memory(dev) the same as
force_dma_unencrypted(dev)? If so, that is how it is already done.

I am wondering whether we can keep this simpler by ignoring the
swiotlb=force kernel parameter and keeping cc_shared as it is, even
though that can be confusing when looking at SME.

The three configurations we need to consider here are:

1) SEV-SNP guest
2) SME host with iommu=translated
3) SME host with iommu=passthrough

IIUC, all of the above work with the current code because we mark the
swiotlb as cc_shared/decrypted when CC_ATTR_MEM_ENCRYPT is set (i.e.,
this applies to an SME host as well).

The challenge arises when the user forces swiotlb bouncing with the
swiotlb=force command-line option. At that point, all devices, including
those whose DMA mask can handle encrypted DMA addresses, are forced to
use SWIOTLB. That becomes a problem because SWIOTLB is marked as
decrypted by default.

How about something like the following?

x86/dma: Disable forced SWIOTLB bouncing for SME IOMMU passthrough

With host memory encryption and IOMMU passthrough, DMA address handling
depends on whether a device can address the C-bit. Devices that cannot
address it need DMA addresses with the C-bit cleared, while devices that
can address encrypted memory should keep using encrypted DMA addresses.

The default swiotlb pool is marked shared when memory encryption is active.
Forcing all devices through that pool would also force devices capable of
encrypted DMA to use shared mappings. Clear the global swiotlb-force-bounce
state in this mode, and warn when this overrides an explicit swiotlb=force
command-line request.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

modified   arch/x86/kernel/pci-dma.c
@@ -51,8 +51,24 @@ static void __init pci_swiotlb_detect(void)
 	 * Set swiotlb to 1 so that bounce buffers are allocated and used for
 	 * devices that can't support DMA to encrypted memory.
 	 */
-	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
+	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
 		x86_swiotlb_enable = true;
+		/*
+		 * With host memory encryption and IOMMU passthrough, devices
+		 * that cannot address the C-bit need DMA addresses with the
+		 * C-bit cleared, while devices that can address encrypted
+		 * memory should keep using encrypted DMA addresses.
+		 *
+		 * The default SWIOTLB pool is marked shared when memory
+		 * encryption is active, so forcing all devices through it would
+		 * also force devices that support encrypted DMA to use shared
+		 * mappings. Disable global forced bouncing in this mode.
+		 */
+		if (iommu_default_passthrough() &&
+		    clear_swiotlb_force_bounce())
+			pr_warn("Ignoring swiotlb=force with host memory encryption and "
+				"IOMMU passthrough\n");
+	}
 
 	/*
 	 * Guest with guest memory encryption currently perform all DMA through
modified   include/linux/swiotlb.h
@@ -40,6 +40,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 	int (*remap)(void *tlb, unsigned long nslabs));
 extern void __init swiotlb_update_mem_attributes(void);
+bool __init clear_swiotlb_force_bounce(void);
 
 #ifdef CONFIG_SWIOTLB
 
modified   kernel/dma/swiotlb.c
@@ -208,6 +208,15 @@ unsigned long swiotlb_size_or_default(void)
 	return default_nslabs << IO_TLB_SHIFT;
 }
 
+bool __init clear_swiotlb_force_bounce(void)
+{
+	if (!swiotlb_force_bounce)
+		return false;
+
+	swiotlb_force_bounce = false;
+	return true;
+}
+
 void __init swiotlb_adjust_size(unsigned long size)
 {
 	/*
