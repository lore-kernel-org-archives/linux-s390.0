Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C07D37E5D7;
	Mon, 14 Sep 2026 07:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789369399; cv=none; b=GLFmMTApAzE12sj9TqJyNqGqORtBb53zuZbINP8hNqeaNhXZXWIQbasXRkuzhgQLzGjEkcayijei1vN/BlgvFLQfgMbBFgSWCUc1Swn7rItRVhg+UQtbEb8dVZ+9E3IZSeOh02USPQvn5Ov+NImyBQwdlu0XsDaMVMDNEiG9uWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789369399; c=relaxed/simple;
	bh=vw7zAd5VThGImoz9QVlL6bM9V0UF1g3zAo7j+ll+YQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UdQBUCzeFTeDBz0MJxOcRXlfYZqqaGPUYFBO6PMeRT0GyciTMxNJuOcIc0LQrY+Yi4YBaWy/7uDjB1eDsszFHoNylk/rGKQBbZ4+6czW9KWHiaaOTXQB8cJ3fNCsFjZkWcIGl2Ikz9Xj4R4ac2hZZYUR1hbnkM2KDGyz0EAhONw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxHF4NFf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxHF4NFf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6B61F00893;
	Mon, 14 Sep 2026 07:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789369398;
	bh=7KNP43XtreccAemuIAJIH10BurR1mq1cqFVOYH1WwzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AxHF4NFfd4AGPA5yz8mau8+tK8AD9+KRrcVP4sPs6Ek5IpM9Rsyqh6nsse9weKZvB
	 l5y13It4KBVQztJqctnLK2osOkFM1t5PO+Hbb5WPlH/r3daqeQ2IwKkkgqEj+9r1rs
	 8nvaQng0eiiKaLr0YTpK86ts/4rey7oaeSvdhjkXhfL9RyPDSna5aY0FpgDyeYQ3It
	 D8HdD36+++X8fa+axfp71jZdnOtOLSbBc9kZmyQs6hFbnaPWP6KzRlDba1WF8CNKs4
	 RoPEybdTKK9YVknPt/p3XtOLneRSVAkGZfMmQlSp8GucKqkyP/KDMMfN4Vj+bT8v4W
	 Z9TCrN8riw1IA==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>,
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
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v4 4/5] dma: swiotlb: Add an overridable architecture pool opt-out
Date: Mon, 14 Sep 2026 12:31:33 +0530
Message-ID: <20260914070135.313337-5-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914070135.313337-1-aneesh.kumar@kernel.org>
References: <20260914070135.313337-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On x86, iommu=off historically prevented SWIOTLB initialization by not
setting SWIOTLB_INIT_ADDRESSING_LIMIT. This overloads that flag: it
controls both whether a pool is selected and where the pool is
allocated. If another requirement, swiotlb=force selects a pool
independently, omitting SWIOTLB_INIT_ADDRESSING_LIMIT may place it above
the addressable range of devices which need bounce buffering.

Add SWIOTLB_INIT_FORCE_DISABLE to let an architecture opt out of normal
pool initialization without discarding the pool placement constraints.

Unlike swiotlb_force_disable, which is set by swiotlb=noforce and
unconditionally prevents pool initialization, the new flag is an
architecture default. Explicit requirements such as memory encryption,
architecture remapping, or swiotlb=force take precedence over it.

iommu=soft retains SWIOTLB_INIT_ADDRESSING_LIMIT because it requests
software bounce buffering for devices whose DMA masks cannot address all
system memory. Such devices must be able to reach the bounce pool.

Clear both flags for Xen because Xen explicitly requires a remapped
SWIOTLB pool and may allocate it anywhere in directly mapped memory.

With no override, iommu=off disables both hardware IOMMU translation and
SWIOTLB bouncing. Direct DMA remains available; mappings outside a
device's addressable range fail instead of being bounced.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/x86/kernel/pci-dma.c | 11 ++++++++---
 include/linux/swiotlb.h   |  2 ++
 kernel/dma/swiotlb.c      | 10 ++++++++--
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index 3c82ebb5b6e0..cd6dd151d634 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -44,9 +44,13 @@ unsigned int x86_swiotlb_flags;
 static void __init pci_swiotlb_detect(void)
 {
 	/* don't initialize swiotlb if iommu=off (no_iommu=1) */
-	if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN) {
-		x86_swiotlb_enable = true;
+	if (no_iommu)
+		x86_swiotlb_flags |= SWIOTLB_INIT_FORCE_DISABLE;
+
+	if (max_possible_pfn > MAX_DMA32_PFN) {
 		x86_swiotlb_flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
+		if (!no_iommu)
+			x86_swiotlb_enable = true;
 	}
 
 	/*
@@ -83,7 +87,8 @@ static void __init pci_xen_swiotlb_init(void)
 		return;
 	x86_swiotlb_enable = true;
 	/* Xen can use a SWIOTLB pool anywhere in directly mapped memory. */
-	x86_swiotlb_flags &= ~SWIOTLB_INIT_ADDRESSING_LIMIT;
+	x86_swiotlb_flags &= ~(SWIOTLB_INIT_ADDRESSING_LIMIT |
+			       SWIOTLB_INIT_FORCE_DISABLE);
 	x86_swiotlb_flags |= SWIOTLB_INIT_REMAP | SWIOTLB_ANY;
 	swiotlb_init_remap(x86_swiotlb_flags, xen_swiotlb_fixup);
 	dma_ops = &xen_swiotlb_dma_ops;
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index be3962a33fc6..ef7a776ee508 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -20,6 +20,8 @@ struct scatterlist;
 #define SWIOTLB_INIT_ADDRESSING_LIMIT	(1 << 2)
 /* Initialize a default-sized pool that requires architecture remapping. */
 #define SWIOTLB_INIT_REMAP		(1 << 3)
+/* Do not initialize a pool unless SWIOTLB is explicitly required. */
+#define SWIOTLB_INIT_FORCE_DISABLE	(1 << 4)
 
 /*
  * Maximum allowable number of contiguous slabs to map,
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c4611b2c4540..6695da682f96 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -563,10 +563,16 @@ swiotlb_select_pool_policy(unsigned int flags)
 	if (flags & SWIOTLB_INIT_REMAP)
 		return SWIOTLB_POOL_DEFAULT;
 
-	if (flags & SWIOTLB_INIT_ADDRESSING_LIMIT)
+	if (swiotlb_force_bounce)
 		return SWIOTLB_POOL_DEFAULT;
 
-	if (swiotlb_force_bounce)
+	/*
+	 * Explicit requirements above override an architecture's default opt-out.
+	 */
+	if (flags & SWIOTLB_INIT_FORCE_DISABLE)
+		return SWIOTLB_POOL_NONE;
+
+	if (flags & SWIOTLB_INIT_ADDRESSING_LIMIT)
 		return SWIOTLB_POOL_DEFAULT;
 
 	if (swiotlb_kmalloc_needs_bounce())
-- 
2.43.0

