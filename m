Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEB0381E8B;
	Thu, 24 Sep 2026 06:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230186; cv=none; b=MWV0/Tchvs+pP+c5HXOZgbh50+Jy/gIfChBjXpnx4C5tOdKWll1gITIsFUT/S9JS7ElTMvbP4pSdGrgSl751Rw1WnS7RQdN67gS7T9FcwgyEOmh4sCM3AQw2t93ru7o7WEl5Ycq8i/qiS0jAiU06iumXjaMSEYmjn27HTWRdCmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230186; c=relaxed/simple;
	bh=B7u2gHOxSgbV1IVBu7Ya9S2XZ0SGh6Tfesrhi9DhxA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GIDPCH2p+fL2fRxC9Y2mV8y50Mt+ZSNSHbMvcDqLaUZCHyozEp7y1yW178dfAdnvECvrG4R27Tqw9QDf/DwqcfRftWLdc6lpUJbHTbvdTZasNNyVBKA0Ro3P23Vnq9u96khQVe+qo+fS+bTZ0jGsSnJiP/hN/HClutG50xtVqm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCNOixZ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCNOixZ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16F91F000FF;
	Thu, 24 Sep 2026 06:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790230184;
	bh=tusr1yJ0MgOFWnYBFAQROVz75fdWB9waVMwRJ7a9kV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DCNOixZ1Uff5UkaFVScwFmBw6mXUZbMx0tgzEzPPRjLmGZVot10iFQ0ssXfLbeo52
	 z7fTCAC0mZk2tXAEkEnMTDNkATIn8sbA9AO8GsxYR4xGD7P90W2FNMjkQysI1pf47w
	 LbD9PgYtrDtUxxVLrfl77xSmS8nUjRfRqlYI/5y+hUIgeSzBpFR3i8x1opZKu45s35
	 ezO3ufVmH5GDESRxdwtIbqlfidV30AS+NYPv2zC/MUFlnZR/aDK0wCzTU1HjyYV/Xe
	 9a8MCBjC42Bry8aSYtbpOkz3ae1A4V7BdqAyJoaZmvcPMeQ6W9CBkSe5SFYb4bt3g2
	 ho4cz+DiCI9Kw==
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
Subject: [PATCH v6 5/8] dma: swiotlb: Centralize minimal pool sizing
Date: Thu, 24 Sep 2026 11:37:53 +0530
Message-ID: <20260924060756.1325156-6-aneesh.kumar@kernel.org>
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

A default SWIOTLB pool used only for unaligned kmalloc bouncing can be
smaller than one required for limited DMA addressing. Arm64 and RISC-V
currently implement this sizing independently, using 1 MiB of SWIOTLB
space per GiB of RAM.

The SWIOTLB core now identifies this case with SWIOTLB_POOL_MINIMAL.
Size that policy in swiotlb_adjust_pool_size() and remove the
architecture-specific adjustments.

Explicit swiotlb= sizing remains unchanged because swiotlb_adjust_size()
preserves a user-configured size.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Paul Walmsley <pjw@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/mm/init.c | 11 -----------
 arch/riscv/mm/init.c |  4 ----
 kernel/dma/swiotlb.c |  9 ++++++++-
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index f55ebe57b8e1..95075b5c8207 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -340,17 +340,6 @@ void __init arch_mm_preinit(void)
 {
 	unsigned int flags = SWIOTLB_VERBOSE;
 
-	if (max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
-		/*
-		 * If no bouncing needed for ZONE_DMA, reduce the swiotlb
-		 * buffer for kmalloc() bouncing to 1MB per 1GB of RAM.
-		 */
-		unsigned long size =
-			DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
-
-		swiotlb_adjust_size(min(swiotlb_default_pool_size(), size));
-	}
-
 	if (max_pfn > PFN_DOWN(arm64_dma_phys_limit))
 		flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
 
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 2562cf45a8f2..96856114b387 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -183,10 +183,6 @@ void __init arch_mm_preinit(void)
 		 * memory when DRAM starts above dma32_phys_limit.  Allocate
 		 * ~1 MB per 1 GB of RAM.
 		 */
-		unsigned long size =
-			DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
-		swiotlb_adjust_size(min(swiotlb_default_pool_size(), size));
-		swiotlb = true;
 		swiotlb_flags |= SWIOTLB_ANY;
 	}
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 8ae315b2d0e7..75ee63cd354e 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -469,9 +469,14 @@ static bool __init swiotlb_kmalloc_needs_bounce(void)
 static void __init
 swiotlb_adjust_pool_size(enum swiotlb_pool_policy policy)
 {
+	unsigned long size;
+
 	switch (policy) {
 	case SWIOTLB_POOL_MINIMAL:
-		return;
+		/* Use 1MB per 1GB of RAM for kmalloc() bouncing. */
+		size = DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
+		size = min(swiotlb_default_pool_size(), size);
+		break;
 	case SWIOTLB_POOL_CC_GUEST:
 		return;
 	case SWIOTLB_POOL_NONE:
@@ -481,6 +486,8 @@ swiotlb_adjust_pool_size(enum swiotlb_pool_policy policy)
 	default:
 		return;
 	}
+
+	swiotlb_adjust_size(size);
 }
 
 static enum swiotlb_pool_policy __init
-- 
2.43.0

