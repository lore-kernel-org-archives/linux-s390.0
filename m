Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90744399001;
	Thu,  8 Oct 2026 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469955; cv=none; b=bDGiw0bwi3QYZSVNmLQcRU/bTpOxuGVSOkvXXFa2gsbKpy8WrmAgrYjNViEKK/VuA1DDYlM+Z7E+6TrVPNgDqJWewdNN7gp3qvf91L1bCanxJW5ClEr9XW1MzJZI5zGdH/UHpQ3iPdlM7qTcjpxkfSbbrvAYjXOpc1BIbWQPGzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469955; c=relaxed/simple;
	bh=MXnM0EDU3w1u+gF56UBriK+0MWzar5YRfHlAZ3iaFZE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D6LNnylL8zfZ1bQ9fDP1SIPnlcwUREWhK+C55NbzDAr1pcQj2mRmTnmOPXKN2ZJ8Up+33irXHqnFffT4nJiqu7gk5TgGCLPhHkxZfZceBs9NxLrBthiyExi40mYo23d8XEvrM2i0/wocf/pqqAB+sqjKF874W7rW1E6j3veylRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPRx0Bwz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPRx0Bwz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C492C1F000FF;
	Thu,  8 Oct 2026 14:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791469953;
	bh=irNiHkoq2gb2cravAxu7t6nAA3go3bV1Ft6XxreLNRM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=MPRx0BwzNKcHHHk96BI8i57G16CryPAOtNQtfbFm1nrRuv/URSrexk5GgD3rlz/Wi
	 Z3fsq9oJE0K4na3O67iq2xcyi4Zcx64DZofgwFUFvX0KBfJr6wMqbUEYZ7Y3Gd/+B6
	 xWIRizY3avz8S4KK5sVb3Pb8k5/+TvwZOEtkDPVqvu/uhpH3xbppO9Dlm/IwVDM3/S
	 Rh8Mw+CAxyM6BrLBtBUhixQTlgqAGx/uxhJy2lL1Nw9jR/KcnW6D/QbFz8PfEjy+C+
	 FAbDhtA5KyW/wba+MhUJYoEQuIpayxRQoCsf1Q5pM5PkbsTd59y7kdbwe79PyCRb+N
	 62XiVS5DBG/aQ==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
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
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v6 6/8] dma: swiotlb: Centralize memory-encryption pool
 sizing
In-Reply-To: <aseRzPshcoys7AJS@arm.com>
References: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
 <20260924060756.1325156-7-aneesh.kumar@kernel.org>
 <asVs3doaJ4WrT3M2@willie-the-truck> <asYZFXGyafRjjBS0@arm.com>
 <asYiOgskwi8JYLe_@willie-the-truck> <yq5awlrt3dwo.fsf@kernel.org>
 <yq5av77c92oo.fsf@kernel.org> <aseRzPshcoys7AJS@arm.com>
Date: Thu, 08 Oct 2026 20:02:12 +0530
Message-ID: <yq5ao6d48dqr.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Thu, Oct 08, 2026 at 11:03:27AM +0530, Aneesh Kumar K.V wrote:
>> Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:
>> > Will Deacon <will@kernel.org> writes:
>> >> On Wed, Oct 07, 2026 at 11:04:05AM +0100, Catalin Marinas wrote:
>> >>> On Tue, Oct 06, 2026 at 10:49:17PM +0100, Will Deacon wrote:
>> >>> > On Thu, Sep 24, 2026 at 11:37:54AM +0530, Aneesh Kumar K.V (Arm) wrote:
>> >>> > > @@ -496,7 +516,8 @@ swiotlb_select_pool_policy(unsigned int flags)
>> >>> > >  	if (swiotlb_force_disable)
>> >>> > >  		return SWIOTLB_POOL_NONE;
>> >>> > >  
>> >>> > > -	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>> >>> > > +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
>> >>> > > +	    !restricted_dma_pool_present)
>> >>> > >  		return SWIOTLB_POOL_CC_GUEST;
>> >>> > 
>> >>> > I think this check on the restricted DMA pool is too general -- the pool
>> >>> > could be tied to a specific DMA-capable peripheral and so treating its
>> >>> > presence as a global property isn't right.
>> >>> 
>> >>> I agree it's a hack but that was the simplest way to avoid the pVMs
>> >>> getting a bounce buffer after this patch. More than happy to leave it
>> >>> out and reduce the buffer on cmdline or we come up with some better
>> >>> heuristics.
>> >>
>> >> Hrm, that does mean that reverting just this part will regress pVMs
>> >> because they'll suddenly be allocating a tonne more memory for an
>> >> entirely unused swiotlb buffer. So I think I'd prefer to drop the entire
>> >> series until this has been worked out properly.
>> >>
>> >>> Another option could be the arch code passing another flag that it
>> >>> doesn't want an encrypted pool (e.g. when running in a pKVM guest) but I
>> >>> don't particularly this either. The arch code doesn't know whether
>> >>> there's an alternative pool.
>> >>
>> >> At that point, the default size may as well be driven by the
>> >> drivers/virt/coco driver.
>> >>
>> >>> That said, such heuristics should have been a separate patch to make it
>> >>> easier to review/drop.
>> >>
>> >> I think the only right way to get a semi-accurate heuristic is to take
>> >> into account the set of dma-capable devices that will use the swiotlb
>> >> pool, but that's fiddly and should probably be tackled as a separate
>> >> series. Maybe a simpler hack in that direction would be to take the
>> >> SWIOTLB_POOL_CC_GUEST if _any_ device is going to use swiotlb? You'll
>> >> run into the usual problem of not being able to tell if a device is
>> >> DMA-capable or not, but you could probably look for a global restricted
>> >> DMA pool and, if that doesn't exist, check for per-device restricted pools
>> >> on dma-coherent devices (since restricted DMA isn't supported by ACPI) as
>> >> a reasonable approximation.
>> >
>> > So, something like this?
>> >
>> > 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
>> > 	    swiotlb_cc_guest_needs_default_pool())
>> > 		return SWIOTLB_POOL_CC_GUEST;
>> >
>> 
>> Detecting a DMA-capable device is not straightforward, and if we get it
>> wrong, we will enable SWIOTLB_POOL_CC_GUEST unnecessarily. Would the
>> code below be a reasonable approximation of what you suggested?
>> 
>> Another option would be to make swiotlb_cc_guest_needs_default_pool() a
>> weak function that architectures can override. arm64 pKVM could then use
>> a different scheme (for this patch series default to false). Would that
>> be preferable?
>
> Even the rmem check for each device is still a hack that may bite us in
> the future (private devices for example would not need swiotlb). I'm
> thinking more and more of leaving the sizing an arch-specific decision,
> don't bother generalising it at all.
>
> On pKVM vs CCA guests, there's really nothing specific here to pKVM
> guests. The only difference is that confidential guests that so far have
> run without a swiotlb buffer will regress if their memory is tight. For
> confidential guests without dedicated rmem (either CCA or pKVM), I think
> our options are either command line swiotlb sizing or dynamic swiotlb.
>
> Could you respin your series while leaving out the generic sizing? IOW,
> no x86 code generalisation. We can discuss the best strategy on sizing
> later (I haven't checked how much of this series still makes sense
> without the generic sizing).
>

It would mostly consist of the first three cleanup patches, followed by
three patches that replace the addressing_limit argument with flags.

#define SWIOTLB_VERBOSE	(1 << 0) /* verbose initialization */
/* Initialize a pool for devices with limited DMA addressing. */
#define SWIOTLB_INIT_ADDRESSING_LIMIT	(1 << 1)
/* Initialize a pool that requires architecture remapping. */
#define SWIOTLB_INIT_REMAP		(1 << 2)
/* Initialize a pool for DMA to memory-encrypted host or guest memory. */
#define SWIOTLB_INIT_MEM_ENCRYPT		(1 << 3)
/* Initialize a pool for unaligned kmalloc bouncing. */
#define SWIOTLB_INIT_KMALLOC		(1 << 4)
/* Do not initialize a pool unless SWIOTLB is explicitly required. */
#define SWIOTLB_INIT_DEFAULT_OFF		(1 << 5)

This results in the large change below. I'm not sure we want to do this
for no real benefit other than making swiotlb_should_init() slightly
easier to follow.

static bool __init swiotlb_should_init(unsigned int flags)
{
	if (swiotlb_force_disable)
		return false;

	if (swiotlb_force_bounce)
		return true;

	if (flags & (SWIOTLB_INIT_REMAP | SWIOTLB_INIT_MEM_ENCRYPT)))
		return true;

	/* Explicit requirements override an architecture's default opt-out. */
	if (flags & SWIOTLB_INIT_DEFAULT_OFF)
		return false;

	return flags & (SWIOTLB_INIT_ADDRESSING_LIMIT | SWIOTLB_INIT_KMALLOC);
}

Marek,

Patch 3 is a fix, so you may want to take it even if we drop the rest of
the series. Perhaps the first three patches could be taken together?

modified   arch/arm/mm/init.c
@@ -223,7 +223,11 @@ static inline void poison_init_mem(void *s, size_t count)
 void __init arch_mm_preinit(void)
 {
 #ifdef CONFIG_ARM_LPAE
-	swiotlb_init(max_pfn > arm_dma_pfn_limit, SWIOTLB_VERBOSE);
+	unsigned int flags = SWIOTLB_VERBOSE;
+
+	if (max_pfn > arm_dma_pfn_limit)
+		flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
+	swiotlb_init(flags);
 #endif
 
 #ifdef CONFIG_SA1111
modified   arch/arm64/mm/init.c
@@ -351,7 +351,10 @@ void __init arch_mm_preinit(void)
 		swiotlb_adjust_size(min(swiotlb_default_pool_size(), size));
 	}
 
-	swiotlb_init(true, flags);
+	if (max_pfn > PFN_DOWN(arm64_dma_phys_limit))
+		flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
+
+	swiotlb_init(flags);
 
 	/*
 	 * Check boundaries twice: Some fundamental inconsistencies can be
modified   arch/loongarch/kernel/setup.c
@@ -404,7 +404,7 @@ static void __init arch_mem_init(char **cmdline_p)
 
 	memblock_set_bottom_up(true);
 
-	swiotlb_init(true, SWIOTLB_VERBOSE);
+	swiotlb_init(SWIOTLB_VERBOSE | SWIOTLB_INIT_ADDRESSING_LIMIT);
 
 	dma_contiguous_reserve(PFN_PHYS(max_low_pfn));
 
modified   arch/mips/cavium-octeon/dma-octeon.c
@@ -235,5 +235,5 @@ void __init plat_swiotlb_setup(void)
 #endif
 
 	swiotlb_adjust_size(swiotlbsize);
-	swiotlb_init(true, SWIOTLB_VERBOSE);
+	swiotlb_init(SWIOTLB_VERBOSE | SWIOTLB_INIT_ADDRESSING_LIMIT);
 }
modified   arch/mips/loongson64/dma.c
@@ -25,5 +25,5 @@ phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
 
 void __init plat_swiotlb_setup(void)
 {
-	swiotlb_init(true, SWIOTLB_VERBOSE);
+	swiotlb_init(SWIOTLB_VERBOSE | SWIOTLB_INIT_ADDRESSING_LIMIT);
 }
modified   arch/mips/sibyte/common/dma.c
@@ -10,5 +10,5 @@
 
 void __init plat_swiotlb_setup(void)
 {
-	swiotlb_init(true, SWIOTLB_VERBOSE);
+	swiotlb_init(SWIOTLB_VERBOSE | SWIOTLB_INIT_ADDRESSING_LIMIT);
 }
modified   arch/powerpc/kernel/dma-swiotlb.c
@@ -14,8 +14,10 @@ unsigned int ppc_swiotlb_flags;
 
 void __init swiotlb_detect_4g(void)
 {
-	if ((memblock_end_of_DRAM() - 1) > 0xffffffff)
+	if ((memblock_end_of_DRAM() - 1) > 0xffffffff) {
 		ppc_swiotlb_enable = 1;
+		ppc_swiotlb_flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
+	}
 }
 
 static int __init check_swiotlb_enabled(void)
modified   arch/powerpc/mm/mem.c
@@ -287,6 +287,19 @@ void __init arch_mm_preinit(void)
 	BUILD_BUG_ON(MMU_PAGE_COUNT > 16);
 
 #ifdef CONFIG_SWIOTLB
+	if (is_secure_guest()) {
+
+		/* Don't release the SWIOTLB buffer. */
+		ppc_swiotlb_enable = 1;
+
+		/*
+		 * Since the guest memory is inaccessible to the host,
+		 * devices always need to use the SWIOTLB buffer for DMA
+		 * even if dma_capable() says otherwise.
+		 */
+		ppc_swiotlb_flags |= SWIOTLB_ANY;
+	}
+
 	/*
 	 * Some platforms (e.g. 85xx) limit DMA-able memory way below
 	 * 4G. We force memblock to bottom-up mode to ensure that the
@@ -295,7 +308,7 @@ void __init arch_mm_preinit(void)
 	 * back to to-down.
 	 */
 	memblock_set_bottom_up(true);
-	swiotlb_init(ppc_swiotlb_enable, ppc_swiotlb_flags);
+	swiotlb_init(ppc_swiotlb_flags);
 #endif
 
 	kasan_late_init();
modified   arch/powerpc/platforms/pseries/svm.c
@@ -21,16 +21,6 @@ static int __init init_svm(void)
 	if (!is_secure_guest())
 		return 0;
 
-	/* Don't release the SWIOTLB buffer. */
-	ppc_swiotlb_enable = 1;
-
-	/*
-	 * Since the guest memory is inaccessible to the host, devices always
-	 * need to use the SWIOTLB buffer for DMA even if dma_capable() says
-	 * otherwise.
-	 */
-	ppc_swiotlb_flags |= SWIOTLB_ANY;
-
 	/* Share the SWIOTLB buffer with the host. */
 	swiotlb_update_mem_attributes();
 
modified   arch/powerpc/sysdev/fsl_pci.c
@@ -444,6 +444,7 @@ static void setup_pci_atmu(struct pci_controller *hose)
 	if (hose->dma_window_size < mem) {
 #ifdef CONFIG_SWIOTLB
 		ppc_swiotlb_enable = 1;
+		ppc_swiotlb_flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
 #else
 		pr_err("%pOF: ERROR: Memory size exceeds PCI ATMU ability to "
 			"map - enable CONFIG_SWIOTLB to avoid dma errors.\n",
modified   arch/riscv/mm/init.c
@@ -165,14 +165,17 @@ static void print_vm_layout(void) { }
 
 void __init arch_mm_preinit(void)
 {
-	bool swiotlb = max_pfn > PFN_DOWN(dma32_phys_limit) &&
-		       memblock_start_of_DRAM() < dma32_phys_limit;
 	unsigned int swiotlb_flags = SWIOTLB_VERBOSE;
 #ifdef CONFIG_FLATMEM
 	BUG_ON(!mem_map);
 #endif /* CONFIG_FLATMEM */
 
-	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) && !swiotlb &&
+	if (max_pfn > PFN_DOWN(dma32_phys_limit) &&
+	    memblock_start_of_DRAM() < dma32_phys_limit)
+		swiotlb_flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
+
+	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
+	    !(swiotlb_flags & SWIOTLB_INIT_ADDRESSING_LIMIT) &&
 	    dma_cache_alignment != 1) {
 		/*
 		 * No 32-bit DMA bouncing needed (either all DRAM is within
@@ -186,11 +189,10 @@ void __init arch_mm_preinit(void)
 		unsigned long size =
 			DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
 		swiotlb_adjust_size(min(swiotlb_default_pool_size(), size));
-		swiotlb = true;
-		swiotlb_flags |= SWIOTLB_ANY;
+		swiotlb_flags |= SWIOTLB_INIT_KMALLOC | SWIOTLB_ANY;
 	}
 
-	swiotlb_init(swiotlb, swiotlb_flags);
+	swiotlb_init(swiotlb_flags);
 
 	print_vm_layout();
 }
modified   arch/s390/mm/init.c
@@ -166,7 +166,7 @@ static void __init pv_init(void)
 	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
 
 	/* make sure bounce buffers are shared */
-	swiotlb_init(true, SWIOTLB_VERBOSE | SWIOTLB_ANY);
+	swiotlb_init(SWIOTLB_VERBOSE | SWIOTLB_ANY);
 	swiotlb_update_mem_attributes();
 }
 
modified   arch/x86/kernel/pci-dma.c
@@ -44,8 +44,10 @@ static unsigned int x86_swiotlb_flags;
 static void __init pci_swiotlb_detect(void)
 {
 	/* don't initialize swiotlb if iommu=off (no_iommu=1) */
-	if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN)
+	if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN) {
 		x86_swiotlb_enable = true;
+		x86_swiotlb_flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
+	}
 
 	/*
 	 * Set swiotlb to 1 so that bounce buffers are allocated and used for
@@ -81,8 +83,10 @@ static void __init pci_xen_swiotlb_init(void)
 	if (!xen_swiotlb_enabled())
 		return;
 	x86_swiotlb_enable = true;
-	x86_swiotlb_flags |= SWIOTLB_ANY;
-	swiotlb_init_remap(true, x86_swiotlb_flags, xen_swiotlb_fixup);
+	/* Xen can use a SWIOTLB pool anywhere in directly mapped memory. */
+	x86_swiotlb_flags &= ~SWIOTLB_INIT_ADDRESSING_LIMIT;
+	x86_swiotlb_flags |= SWIOTLB_INIT_REMAP | SWIOTLB_ANY;
+	swiotlb_init_remap(x86_swiotlb_flags, xen_swiotlb_fixup);
 	dma_ops = &xen_swiotlb_dma_ops;
 	if (IS_ENABLED(CONFIG_PCI))
 		pci_request_acs();
@@ -103,7 +107,7 @@ void __init pci_iommu_alloc(void)
 	gart_iommu_hole_init();
 	amd_iommu_detect();
 	detect_intel_iommu();
-	swiotlb_init(x86_swiotlb_enable, x86_swiotlb_flags);
+	swiotlb_init(x86_swiotlb_flags);
 }
 
 static __init int iommu_setup(char *p)
@@ -149,8 +153,10 @@ static __init int iommu_setup(char *p)
 			return 1;
 		}
 #ifdef CONFIG_SWIOTLB
-		if (!strncmp(p, "soft", 4))
+		if (!strncmp(p, "soft", 4)) {
 			x86_swiotlb_enable = true;
+			x86_swiotlb_flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
+		}
 #endif
 		if (!strncmp(p, "pt", 2))
 			iommu_set_default_passthrough(true);
modified   include/linux/swiotlb.h
@@ -16,6 +16,14 @@ struct scatterlist;
 
 #define SWIOTLB_VERBOSE	(1 << 0) /* verbose initialization */
 #define SWIOTLB_ANY	(1 << 1) /* allow any memory for the buffer */
+/* Initialize a pool for devices with limited DMA addressing. */
+#define SWIOTLB_INIT_ADDRESSING_LIMIT	(1 << 2)
+/* Initialize a pool that requires architecture remapping. */
+#define SWIOTLB_INIT_REMAP		(1 << 3)
+/* Initialize a pool for DMA to memory-encrypted host or guest memory. */
+#define SWIOTLB_INIT_MEM_ENCRYPT		(1 << 4)
+/* Initialize a pool for unaligned kmalloc bouncing. */
+#define SWIOTLB_INIT_KMALLOC		(1 << 5)
 
 /*
  * Maximum allowable number of contiguous slabs to map,
@@ -39,8 +47,8 @@ struct scatterlist;
 #endif
 
 unsigned long swiotlb_default_pool_size(void);
-void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
-	int (*remap)(void *tlb, unsigned long nslabs));
+void __init swiotlb_init_remap(unsigned int flags,
+			       int (*remap)(void *tlb, unsigned long nslabs));
 int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 	int (*remap)(void *tlb, unsigned long nslabs));
 extern void __init swiotlb_update_mem_attributes(void);
@@ -183,7 +191,7 @@ static inline bool is_swiotlb_force_bounce(struct device *dev)
 	return mem && mem->force_bounce;
 }
 
-void swiotlb_init(bool addressing_limited, unsigned int flags);
+void swiotlb_init(unsigned int flags);
 void __init swiotlb_exit(void);
 void swiotlb_dev_init(struct device *dev);
 size_t swiotlb_max_mapping_size(struct device *dev);
@@ -193,7 +201,7 @@ void __init swiotlb_adjust_size(unsigned long size);
 phys_addr_t default_swiotlb_base(void);
 phys_addr_t default_swiotlb_limit(void);
 #else
-static inline void swiotlb_init(bool addressing_limited, unsigned int flags)
+static inline void swiotlb_init(unsigned int flags)
 {
 }
 
modified   kernel/dma/swiotlb.c
@@ -354,24 +354,15 @@ static void swiotlb_mark_pool_used(struct io_tlb_pool *pool)
 void __init swiotlb_update_mem_attributes(void)
 {
 	struct io_tlb_pool *mem = &io_tlb_default_mem.defpool;
-	unsigned long bytes;
-
-	/*
-	 * if platform support memory encryption, swiotlb buffers are
-	 * shared by default.
-	 */
-	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
-		io_tlb_default_mem.cc_shared = true;
-	else
-		io_tlb_default_mem.cc_shared = false;
 
 	if (!mem->nslabs || mem->late_alloc)
 		return;
-	bytes = PAGE_ALIGN(mem->nslabs << IO_TLB_SHIFT);
 
 	if (io_tlb_default_mem.cc_shared) {
 		int ret;
+		unsigned long bytes;
 
+		bytes = PAGE_ALIGN(mem->nslabs << IO_TLB_SHIFT);
 		ret = set_memory_decrypted((unsigned long)mem->vaddr,
 					   bytes >> PAGE_SHIFT);
 		if (ret) {
@@ -462,12 +453,32 @@ static void __init *swiotlb_memblock_alloc(unsigned long nslabs,
 	return tlb;
 }
 
+static bool __init swiotlb_kmalloc_needs_bounce(void)
+{
+	return IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
+	       (dma_get_cache_alignment() > 1);
+}
+
+static bool __init swiotlb_should_init(unsigned int flags)
+{
+	if (swiotlb_force_disable)
+		return false;
+
+	if (swiotlb_force_bounce)
+		return true;
+
+	return (flags & (SWIOTLB_INIT_ADDRESSING_LIMIT |
+			 SWIOTLB_INIT_REMAP |
+			 SWIOTLB_INIT_MEM_ENCRYPT |
+			 SWIOTLB_INIT_KMALLOC));
+}
+
 /*
  * Statically reserve bounce buffer space and initialize bounce buffer data
  * structures for the software IO TLB used to implement the DMA API.
  */
-void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
-		int (*remap)(void *tlb, unsigned long nslabs))
+void __init swiotlb_init_remap(unsigned int flags,
+			       int (*remap)(void *tlb, unsigned long nslabs))
 {
 	struct io_tlb_pool *mem = &io_tlb_default_mem.defpool;
 	unsigned long nslabs;
@@ -475,9 +486,12 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 	size_t alloc_size;
 	void *tlb;
 
-	if (!addressing_limit && !swiotlb_force_bounce)
-		return;
-	if (swiotlb_force_disable)
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
+		flags |= SWIOTLB_INIT_MEM_ENCRYPT;
+	if (swiotlb_kmalloc_needs_bounce())
+		flags |= SWIOTLB_INIT_KMALLOC;
+
+	if (!swiotlb_should_init(flags))
 		return;
 
 	io_tlb_default_mem.force_bounce = swiotlb_force_bounce;
@@ -491,6 +505,10 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 		io_tlb_default_mem.phys_limit = ARCH_LOW_ADDRESS_LIMIT;
 #endif
 
+	/* if we have host or guest memory encryption */
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
+		io_tlb_default_mem.cc_shared = true;
+
 	if (!default_nareas)
 		swiotlb_adjust_nareas(num_possible_cpus());
 
@@ -531,9 +549,9 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 		swiotlb_print_info();
 }
 
-void __init swiotlb_init(bool addressing_limit, unsigned int flags)
+void __init swiotlb_init(unsigned int flags)
 {
-	swiotlb_init_remap(addressing_limit, flags, NULL);
+	swiotlb_init_remap(flags, NULL);
 }
 
 /*


-aneesh
