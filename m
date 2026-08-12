Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A511E3F0AA9;
	Wed, 12 Aug 2026 11:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786534308; cv=none; b=XqhINwKFE60eDo+BLp4nHnyI69re32pkfzA1o+1r8tIWIKt9TQ8ssXWsTg6P5W1vWcxnlLq07ZnM2Yorz2VHAK2f9cBJuDeiUQRng0Qwcx7ViWrPswVQeiwyDycVzk9rs6d9pGyaVrX8DdTvePrapCt+MbVrvKBXDSPMNUfpfx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786534308; c=relaxed/simple;
	bh=prvfrk9gL+HqgXLDaAtA86obGKz2hkWS/KhX5m4Y2uI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MuMDbYPoF3pXtSIX2QLv21jAvYjGj4R/1eJMkLnZ3JhkQlmdWuBGMJlvn72cxcCA0bY7mPEKDOIAgfSreNaUoMs6w+yMxwWx9eV9bDVQXpWFDeorvjuBvMQMeDQBvSeM4knMSuBRPLMGm8zcZyKTW1QFNlOrlihIO3yMkuKG9k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvoNZLlJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvoNZLlJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EF91F000E9;
	Wed, 12 Aug 2026 11:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786534307;
	bh=8R0bYt528y2mbivyUE1djUnRJwaalT2no2Rhah2uRgU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=cvoNZLlJHW+4WOwYmevlbzkHPd7+Hbm9aTKER6k84q/k54rUk8JPdaAZtnxpqPlGh
	 WBUIWjAoHCAfBrKR2k6VIIpyHPdYitk67obZ1E3ZqU0mj2wcu8OQaFMwuWv1Gc8pRn
	 lGVsxICtRj7Pjsym6tNbO6xBq5x5xHZvdLvgC1NfkP22+Sr8s4yoJGpQaMusWOl6Wo
	 TTlkiBlem5dh19IDXWOSxSjsWWSi3+UQ7dGyxBjXjtEnOwL8mPkqaYjAH37SBlFd3b
	 ieLS7PaRTKrwBLLAqi7+ZIAmPBmvS1d+u3/VKi9x/bOU1+ohhYTujIU+5khH/iE0fR
	 GUsUxWVBsS1lQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
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
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [RFC PATCH] dma: swiotlb: Size shared default pools for memory
 encryption
In-Reply-To: <anxEc8EHmJQywVI5@arm.com>
References: <20260811134056.756015-1-aneesh.kumar@kernel.org>
 <anxEc8EHmJQywVI5@arm.com>
Date: Wed, 12 Aug 2026 17:01:33 +0530
Message-ID: <yq5ah5kzinhm.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Catalin Marinas <catalin.marinas@arm.com> writes:

>
> I also wonder whether we could address Will's pKVM request not to
> allocate a bounce buffer once pKVM guests will start reporting
> CC_ATTR_GUEST_MEM_ENCRYPT. Some simple heuristic: if a
> restricted-dma-pool is advertised in DT (it will end up in
> rmem_swiotlb_setup()), skip resizing the default swiotlb. It's not
> perfect but the bounce buffer can be overridden on the command line.

I have a follow-up cleanup patch where I switch the swiotlb
initialization reason to a flag value. With that, we now have
SWIOTLB_INIT_CC_SHARED.

The challenge is that it is still not clear when pKVM would want to use
an unencrypted swiotlb pool for DMA bouncing. I would expect pKVM to
have some additional condition based on which it chooses either the
restricted-dma-pool or the default swiotlb pool.

Using the presence of a restricted-dma-pool to decide whether the
default swiotlb pool should be unencrypted is one option, but I am not
sure that is the right abstraction.

modified   arch/arm64/mm/init.c
@@ -342,7 +342,7 @@ void __init arch_mm_preinit(void)
 	bool cc_guest = is_realm_world();
 
 	if (cc_guest)
-		swiotlb_mark_default_cc_shared();
+		flags |= SWIOTLB_INIT_CC_SHARED;
 	else if (max_pfn > PFN_DOWN(arm64_dma_phys_limit))
 		flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
 
modified   arch/powerpc/mm/mem.c
@@ -289,9 +289,8 @@ void __init arch_mm_preinit(void)
 #ifdef CONFIG_SWIOTLB
 	if (is_secure_guest()) {
 		/* The host can access DMA buffers only through the SWIOTLB. */
-		swiotlb_mark_default_cc_shared();
 		ppc_swiotlb_enable = 1;
-		ppc_swiotlb_flags |= SWIOTLB_ANY;
+		ppc_swiotlb_flags |= SWIOTLB_INIT_CC_SHARED | SWIOTLB_ANY;
 	}
 
 	/*
modified   arch/s390/mm/init.c
@@ -163,12 +163,10 @@ static void __init pv_init(void)
 	if (!is_prot_virt_guest())
 		return;
 
-	swiotlb_mark_default_cc_shared();
-
 	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
 
 	/* make sure bounce buffers are shared */
-	swiotlb_init(SWIOTLB_VERBOSE);
+	swiotlb_init(SWIOTLB_VERBOSE | SWIOTLB_INIT_CC_SHARED);
 	swiotlb_update_mem_attributes();
 }
 
modified   arch/x86/mm/mem_encrypt.c
@@ -14,6 +14,7 @@
 #include <linux/mem_encrypt.h>
 #include <linux/virtio_anchor.h>
 
+#include <asm/iommu.h>
 #include <asm/sev.h>
 
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
@@ -109,7 +110,7 @@ void __init mem_encrypt_setup_arch(void)
 		snp_fixup_e820_tables();
 
 	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
-		swiotlb_mark_default_cc_shared();
+		x86_swiotlb_flags |= SWIOTLB_INIT_CC_SHARED;
 
 	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 		return;
modified   include/linux/swiotlb.h
@@ -18,6 +18,8 @@ struct scatterlist;
 #define SWIOTLB_ANY	(1 << 1) /* allow any memory for the buffer */
 /* Initialize a default-sized pool for devices with limited DMA addressing. */
 #define SWIOTLB_INIT_ADDRESSING_LIMIT	(1 << 2)
+/* Initialize a shared default pool for confidential-computing systems. */
+#define SWIOTLB_INIT_CC_SHARED		(1 << 3)
 
 /*
  * Maximum allowable number of contiguous slabs to map,
@@ -191,7 +193,6 @@ void swiotlb_dev_init(struct device *dev);
 size_t swiotlb_max_mapping_size(struct device *dev);
 bool is_swiotlb_allocated(void);
 bool is_swiotlb_active(struct device *dev);
-void __init swiotlb_mark_default_cc_shared(void);
 void __init swiotlb_adjust_size(unsigned long size);
 phys_addr_t default_swiotlb_base(void);
 phys_addr_t default_swiotlb_limit(void);
@@ -231,10 +232,6 @@ static inline bool is_swiotlb_active(struct device *dev)
 	return false;
 }
 
-static inline void swiotlb_mark_default_cc_shared(void)
-{
-}
-
 static inline void swiotlb_adjust_size(unsigned long size)
 {
 }
modified   kernel/dma/swiotlb.c
@@ -373,11 +373,6 @@ static void __init *swiotlb_memblock_alloc(unsigned long nslabs,
 	return tlb;
 }
 
-void __init swiotlb_mark_default_cc_shared(void)
-{
-	io_tlb_default_mem.cc_shared = true;
-}
-
 static void __init swiotlb_adjust_cc_attributes(void)
 {
 	unsigned long size;
@@ -429,7 +424,7 @@ static bool __init swiotlb_should_init(unsigned int flags)
 	if (swiotlb_force_bounce)
 		return true;
 
-	if (io_tlb_default_mem.cc_shared)
+	if (flags & SWIOTLB_INIT_CC_SHARED)
 		return true;
 
 	return false;
@@ -451,6 +446,9 @@ void __init swiotlb_init_remap(unsigned int flags,
 	if (!swiotlb_should_init(flags))
 		return;
 
+	if (flags & SWIOTLB_INIT_CC_SHARED)
+		io_tlb_default_mem.cc_shared = true;
+
 	io_tlb_default_mem.force_bounce = swiotlb_force_bounce;
 
 #ifdef CONFIG_SWIOTLB_DYNAMIC
