Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391043F8EB9;
	Thu, 24 Sep 2026 06:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230117; cv=none; b=aKbuX4ARN4iq/TuCqamUJAITBDtBoBRQ39ZkjtP+04tkf9677gHD0OMSJ0YrntOvK3KkXDLd4beiq4ng022GooLLp7UOlLnWSEsWc1e2NAxShktL8L+/VFQee8pHjAASABYOiP/ltMWSmNLQ08pf6heJAbNd2fCvv9IL52t+Pcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230117; c=relaxed/simple;
	bh=qK0G9eKtoWA18oa8e+GB5V8ZCeoeRcPLvKHunDBhFB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i4HILTQHVkP0Rl6Ga+BjAVRD9B5rqwUxeLfmV+DSgOjO7YwWBPMidp9WjMSBUKG5TL6gWrKOkTsp+ijzITl9E55q7IzuqZK2h84AJavZ/5yD4TYcoiOAHYD6zLY9gg8LPT7Nv9Omt8fkdkNAuWDI9Z/oDtN6l67ndkFZJO2A7xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dn1JBlRs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dn1JBlRs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2F01F00893;
	Thu, 24 Sep 2026 06:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790230115;
	bh=90/UBHgIVZHnWcX2iXkQQVtFO2UpIQ73195GKlJNVa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dn1JBlRsc1tzw1/Hp0ITWR1GzpUUhunYQCS0MQv1129xb7p54LHARo1KWvgJbKpYA
	 WxRRH3LRfneK8Jz+4Zv9Nb+SqgCe1KZxIRAUYJeRoXALzqqfIJjYWLZY+Blfsk7etY
	 7cbkpIUhQT3NqW9yf+YPzFUS7wMLzRbUEOyRPMgBwXSEKJWbGdGk2DigF3ABrcabAJ
	 IedCTNlJjkIg/pOURGkjX18mbmywzCKsTIosd2GinD2FpeTrKk+yD06Xa48WBpagr3
	 JXK0moBAIFefd37ROD/cGCVIBgOoINaxjXS2y3lSw4P+i6b2O/+LY7qU11vY+s3+Bz
	 DRDSkaKIG1Blw==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
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
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v6 1/8] dma: swiotlb: Rename swiotlb_size_or_default()
Date: Thu, 24 Sep 2026 11:37:49 +0530
Message-ID: <20260924060756.1325156-2-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
References: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename swiotlb_size_or_default() to swiotlb_default_pool_size() to make
clear that it returns the current size of the default SWIOTLB pool.
This includes changes made by command-line options or sizing heuristics,
not just the compiled-in default.

No functional change.

Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Paul Walmsley <pjw@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm/xen/mm.c                    | 2 +-
 arch/arm64/mm/init.c                 | 2 +-
 arch/riscv/mm/init.c                 | 2 +-
 arch/x86/include/asm/crash_reserve.h | 4 ++--
 include/linux/swiotlb.h              | 2 +-
 kernel/dma/swiotlb.c                 | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index 882cd70c7a2f..a6cf55c6fd55 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -125,7 +125,7 @@ static int __init xen_mm_init(void)
 		return 0;
 
 	/* we can work with the default swiotlb */
-	rc = swiotlb_init_late(swiotlb_size_or_default(),
+	rc = swiotlb_init_late(swiotlb_default_pool_size(),
 			       xen_swiotlb_gfp(), NULL);
 	if (rc < 0)
 		return rc;
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index fbf215ecc7d0..0842098a279b 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -348,7 +348,7 @@ void __init arch_mm_preinit(void)
 		unsigned long size =
 			DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
 
-		swiotlb_adjust_size(min(swiotlb_size_or_default(), size));
+		swiotlb_adjust_size(min(swiotlb_default_pool_size(), size));
 	}
 
 	swiotlb_init(true, flags);
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index fb37b0b67efe..5fa392021717 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -185,7 +185,7 @@ void __init arch_mm_preinit(void)
 		 */
 		unsigned long size =
 			DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
-		swiotlb_adjust_size(min(swiotlb_size_or_default(), size));
+		swiotlb_adjust_size(min(swiotlb_default_pool_size(), size));
 		swiotlb = true;
 		swiotlb_flags |= SWIOTLB_ANY;
 	}
diff --git a/arch/x86/include/asm/crash_reserve.h b/arch/x86/include/asm/crash_reserve.h
index 7835b2cdff04..047f638a766d 100644
--- a/arch/x86/include/asm/crash_reserve.h
+++ b/arch/x86/include/asm/crash_reserve.h
@@ -18,7 +18,7 @@
  * no good way to detect the paging mode of the target kernel which will be
  * loaded for dumping.
  */
-extern unsigned long swiotlb_size_or_default(void);
+extern unsigned long swiotlb_default_pool_size(void);
 
 #ifdef CONFIG_X86_32
 # define CRASH_ADDR_LOW_MAX     SZ_512M
@@ -33,7 +33,7 @@ extern unsigned long swiotlb_size_or_default(void);
 static inline unsigned long crash_low_size_default(void)
 {
 #ifdef CONFIG_X86_64
-	return max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
+	return max(swiotlb_default_pool_size() + (8UL << 20), 256UL << 20);
 #else
 	return 0;
 #endif
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 2a421241b980..5f24edf47b68 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -38,7 +38,7 @@ struct scatterlist;
 #define IO_TLB_DEFAULT_SIZE (64UL << 20)
 #endif
 
-unsigned long swiotlb_size_or_default(void);
+unsigned long swiotlb_default_pool_size(void);
 void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 	int (*remap)(void *tlb, unsigned long nslabs));
 int swiotlb_init_late(size_t size, gfp_t gfp_mask,
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index ded7016a46a7..42c51fb57e12 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -285,7 +285,7 @@ setup_io_tlb_npages(char *str)
 }
 early_param("swiotlb", setup_io_tlb_npages);
 
-unsigned long swiotlb_size_or_default(void)
+unsigned long swiotlb_default_pool_size(void)
 {
 	return default_nslabs << IO_TLB_SHIFT;
 }
-- 
2.43.0

