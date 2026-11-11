Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.139.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398010;
	b=TjUOnGAOlF9pQHn0UlCg6Wmj7XOQWF1S6E77c62VYvABiDSCYrbSUR7NkcTpKx0kQvcI
	 RxeMKkKvLH+je0WuN5Wg/Dn3Le4l1JrTjCu3fEIy9xnOq0EuQ90W/SlrQPFQNe76u3n94
	 F2E63kA8gwDCKuGjCZRcx+58DnJ76sr8zGP/etwkA8yUrjdoVdbFwe3Eqn5W6fwPtg956
	 4/svpSBpTyb0tAIGy6A6vfRjWnrv6WM8uYPGLrTdwjTC3SgVWNSsds8BRGWA4Z+WephWZ
	 raIKoSedaRUloJKqjAzbl7nm7v1wF3GR/U6fdfZqiNGIipZLiRU4xaz9G+hAGJjCFhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398010;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=LHx3sOu0nRc26uMaGdX5eIGUhuQ24/CQDwrvILlx8g0=;
	b=kMDnpPY3KigeczIlhhdoohfc5yE7jwwQqviQHFUcTnkV3YY51R5UQjT6Ey3d8D9lAw0W
	 aZw6mEIbk25IQFPDMcOXdD6/9wNGKLVaaL/3TLlph5xZESejONGDoyFp1BxZzGemw3sdr
	 l/4I36KtgeWH5idiX0lKe1cRdQQY/nWqxA6WQjcg1sPLJJVV32LfgWEHBlQhTTJJPVzcw
	 RP8SniexXICD9WIkhmPgImfdcCbxjffXSyuJSV1PzHZBlXfGusbEO96LO2AunQy7fprxB
	 zNTzGOSCfomT7DwHTe5hufB+rMdghAHiGFfgmGlujigcLBARw1YfezBNLVFVrz6xg+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fujitsu.com;
	spf=pass smtp.mailfrom=fujitsu.com;
	dkim=pass header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=b0qyD0WF;
	arc=none smtp.remote-ip=68.232.139.139
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F12F606A326;
	Wed, 11 Nov 2026 11:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F12F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=b0qyD0WF
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1794398009; x=1825934009;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HCCipxtjnPjwYW8DIXAeMVHDqScHm74Hg2zPPlBSipM=;
  b=b0qyD0WFzEd0Y2jCJD12hgyksqq3GI4TR5QrPUvWQyuVC+HurNy6Oe/m
   FrlN2QY3Hf65OxrdN++NKRm6c790tIgAzx1aQwh5cwIZW4X+fmN6/dHhq
   54VtyxVlAmYqllHQOLvbKql6SBfwqVXemG/oavN3rFxMI1h+kqLGHM3dX
   XKrnVuX2EVHPcA0j7Kw6N6Yob25NPoV+K7eCtBCBXY5OfQyc4EYAI7ved
   PFoMvsb6Pm4Y9Xm55UL87DzaS1esJ0QzCqydJklXb1gbvvSeiBQLvYb/6
   vBzlorF5Y5ixzIkc+2jmKfQ1hWp6xHkpxbhTRTQZogdCwwX2WvqLEhGEV
   w==;
X-CSE-ConnectionGUID: 78fX9jHjRtK3OLNk3zWvFA==
X-CSE-MsgGUID: I1LO9uX3S+WO7k96rPianQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="265450049"
X-IronPort-AV: E=Sophos;i="6.27,207,1786978800"; 
   d="scan'208";a="265450049"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 20:53:22 +0900
Received: from az2nlsmgm1.o.css.fujitsu.com (unknown [10.150.26.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 8A9921C04FB7;
	Wed, 11 Nov 2026 11:53:22 +0000 (UTC)
Received: from az2nlsmom3.fujitsu.com (unknown [10.150.26.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm1.o.css.fujitsu.com (Postfix) with ESMTPS id 3B5C2C01287;
	Wed, 11 Nov 2026 11:53:22 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.9.86.149])
	by az2nlsmom3.fujitsu.com (Postfix) with SMTP id 52B3F101BB7F;
	Wed, 11 Nov 2026 11:53:02 +0000 (UTC)
Date: Wed, 11 Nov 2026 20:53:00 +0900
From: Kohei Enju <enju.kohei@fujitsu.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>, 
	Suzuki K Poulose <Suzuki.Poulose@arm.com>, Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Mostafa Saleh <smostafa@google.com>, Petr Tesarik <ptesarik@suse.com>, 
	Alexey Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, 
	Xu Yilun <yilun.xu@linux.intel.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	x86@kernel.org
Subject: Re: [PATCH v6 6/8] dma: swiotlb: Centralize memory-encryption pool
 sizing
Message-ID: <avRKiCBs81XSYMqW@FCCLS0092175.localdomain>
References: <20260924060756.1325156-7-aneesh.kumar@kernel.org>
 <asVs3doaJ4WrT3M2@willie-the-truck>
 <asYZFXGyafRjjBS0@arm.com>
 <asYiOgskwi8JYLe_@willie-the-truck>
 <yq5awlrt3dwo.fsf@kernel.org>
 <yq5av77c92oo.fsf@kernel.org>
 <aseRzPshcoys7AJS@arm.com>
 <yq5ao6d48dqr.fsf@kernel.org>
 <auR0fT1yrKQ9wbm8@FCCLS0092175.localdomain>
 <yq5a8q3d9oe6.fsf@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <yq5a8q3d9oe6.fsf@kernel.org>

Hi Aneesh,

On 11/01 09:47, Aneesh Kumar K.V wrote:
[...]
> >
> > Hi Aneesh,
> >
> > I can reproduce the CCA regression discussed in this thread:
> >   https://lore.kernel.org/all/yq5azeyxyfol.fsf@kernel.org/#t
> >
> > The guest runs out of SWIOTLB slots, causing disk I/O to fail and
> > preventing the guest from booting.
> >
> > I would like to test the fix on real CCA hardware. Could you please Cc
> > me when you respin the series? I follow LKML, but I may still miss the
> > posting by chance.
> >
> 
> The conclusion was to either use CONFIG_SWIOTLB_DYNAMIC or swiotlb kernel command line
> option

Thanks for the clarification.

After reading this whole thread, I agree that dynamic sizing would be
appropriate.

However, currently some distributions do not enable
CONFIG_SWIOTLB_DYNAMIC. Users of such distributions would therefore need
to rebuild their kernels with the option enabled. This is not a
practical solution for many users, particularly cloud users who use
kernels provided by their distributions or cloud providers.

Specifying swiotlb= on the kernel command line is also not particularly
user-friendly. It requires users or cloud providers to choose a fixed
value in advance, without automatically taking into account properties
of the VM, such as its memory size or whether it is a confidential
guest.

I do not think the existing heuristic used for x86 CoCo guests is
necessarily optimal, but a fixed swiotlb= value chosen by each user may
be even less appropriate.

Overall, I would prefer the dynamic sizing approach. However, I believe
the initial pool size still matters.

Also, as Catalin pointed out earlier in the following message:

    https://lore.kernel.org/all/ann6noRzoPLL9kDY@arm.com/

the arm64 adjustment also reduces the target size used for dynamic
pool allocation, since both the initial pool and dynamic allocation
currently use default_nslabs.

I am testing the patch below to decouple the initial pool size from the
dynamic allocation target. It adds swiotlb_adjust_initial_size() for
callers that only want to reduce the initial allocation, while keeping
the existing swiotlb_adjust_size() semantics for callers that want to
adjust both sizes.

Thanks,
Kohei

--->8---
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 4e7682dfe366..80a2c171895f 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -349,7 +349,7 @@ void __init arch_mm_preinit(void)
                unsigned long size =
                        DIV_ROUND_UP(memblock_phys_mem_size(), 1024);

-               swiotlb_adjust_size(min(swiotlb_default_pool_size(), size));
+               swiotlb_adjust_initial_size(min(swiotlb_default_pool_size(), size));
        }

        swiotlb_init(true, flags);
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 070ee69eabb3..7dd9fcec90a5 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -189,7 +189,7 @@ void __init arch_mm_preinit(void)
                 */
                unsigned long size =
                        DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
-               swiotlb_adjust_size(min(swiotlb_default_pool_size(), size));
+               swiotlb_adjust_initial_size(min(swiotlb_default_pool_size(), size));
                swiotlb = true;
                swiotlb_flags |= SWIOTLB_ANY;
        }
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 5f24edf47b68..c1984ee12355 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -190,6 +190,7 @@ size_t swiotlb_max_mapping_size(struct device *dev);
 bool is_swiotlb_allocated(void);
 bool is_swiotlb_active(struct device *dev);
 void __init swiotlb_adjust_size(unsigned long size);
+void __init swiotlb_adjust_initial_size(unsigned long size);
 phys_addr_t default_swiotlb_base(void);
 phys_addr_t default_swiotlb_limit(void);
 #else
@@ -232,6 +233,10 @@ static inline void swiotlb_adjust_size(unsigned long size)
 {
 }

+static inline void swiotlb_adjust_initial_size(unsigned long size)
+{
+}
+
 static inline phys_addr_t default_swiotlb_base(void)
 {
        return 0;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 2c57b49ac7c0..211fefb32fb5 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -99,6 +99,7 @@ static struct io_tlb_mem io_tlb_default_mem;
 #endif /* CONFIG_SWIOTLB_DYNAMIC */

 static unsigned long default_nslabs = IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT;
+static unsigned long dynamic_nslabs = IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT;
 static unsigned long default_nareas;
 static bool swiotlb_cmdline_size_set __initdata;

@@ -152,6 +153,8 @@ static void swiotlb_adjust_nareas(unsigned int nareas)
                nareas = roundup_pow_of_two(nareas);

        default_nareas = nareas;
+       dynamic_nslabs =
+               swiotlb_calc_nslabs(dynamic_nslabs << IO_TLB_SHIFT, nareas);

        pr_info("area num %d.\n", nareas);
        nslabs = swiotlb_calc_nslabs(default_nslabs << IO_TLB_SHIFT, nareas);
@@ -254,6 +257,7 @@ setup_io_tlb_npages(char *str)
                /* avoid tail segment of size < IO_TLB_SEGSIZE */
                default_nslabs =
                        ALIGN(simple_strtoul(str, &str, 0), IO_TLB_SEGSIZE);
+               dynamic_nslabs = default_nslabs;
                swiotlb_cmdline_size_set = true;
        }
        if (*str == ',')
@@ -290,7 +294,7 @@ unsigned long swiotlb_default_pool_size(void)
        return default_nslabs << IO_TLB_SHIFT;
 }

-void __init swiotlb_adjust_size(unsigned long size)
+void __init swiotlb_adjust_initial_size(unsigned long size)
 {
        /*
         * If swiotlb parameter has not been specified, give a chance to
@@ -305,6 +309,12 @@ void __init swiotlb_adjust_size(unsigned long size)
        pr_info("SWIOTLB bounce buffer size adjusted to %luMB", size >> 20);
 }

+void __init swiotlb_adjust_size(unsigned long size)
+{
+       swiotlb_adjust_initial_size(size);
+       dynamic_nslabs = default_nslabs;
+}
+
 void swiotlb_print_info(void)
 {
        struct io_tlb_pool *mem = &io_tlb_default_mem.defpool;
@@ -507,6 +517,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
                pr_info("SWIOTLB bounce buffer size adjusted %lu -> %lu slabs",
                        default_nslabs, nslabs);
                default_nslabs = nslabs;
+               dynamic_nslabs = default_nslabs;
        }

        alloc_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), nslabs));
@@ -889,7 +900,7 @@ static void swiotlb_dyn_alloc(struct work_struct *work)
                container_of(work, struct io_tlb_mem, dyn_alloc);
        struct io_tlb_pool *pool;

-       pool = swiotlb_alloc_pool(NULL, mem, IO_TLB_MIN_SLABS, default_nslabs,
+       pool = swiotlb_alloc_pool(NULL, mem, IO_TLB_MIN_SLABS, dynamic_nslabs,
                                  default_nareas, mem->phys_limit, GFP_KERNEL);
        if (!pool) {
                pr_warn_ratelimited("Failed to allocate new pool");

