Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E933DDDB0;
	Thu, 24 Sep 2026 06:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230220; cv=none; b=Hcc6roS3F4IUPCu5VdflbTcG6n4RAdAe8PbidjkaHZKFNmq8JIsBEbFxrcEfrQKATurLjrx6yznbEb8Vj5prF+jYYYt8I70qy01fOQjyyzIBQNh+ljJbb2GX65Cv/H5b62kxIlXq36UR00jhN7epgQi4gfyUoMqqxPilAiYCsrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230220; c=relaxed/simple;
	bh=p1uZ6m2QAos8fgm5OVJVppqz17Rk2IQHv1YVhSpdB4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XbF0n0y0VCCKPmdBobsJck57jz/cjbVQARTfGND8TSiZ7c++Nq09LKmRic4iCLKfzXJo1fREJGLuhjf2mmwnPFE7TRB3ZGxd+iMAAdZ80/sw0kh3PSYjECjQ4CJSiCkQfBSckNZ+/AuqITuJlWeySkpHHqdYC9xvwCCELXjacyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfjpmzYr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfjpmzYr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4561F000FF;
	Thu, 24 Sep 2026 06:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790230218;
	bh=rNm+mOo8Qc346ouhd+MVcZZHr4pMSublo9/m/bzvlkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lfjpmzYr2RJ/hwCqh4+Xa84oi7xdypaLrJm6fg+U3mWTgBN0yRfH3aGn1EEj3dGNt
	 Kp8IckeRp2L30fKxhmpkmXWq7OXQzrIMlRFV5cq4/gsT1SVlUaePfDRHSSG0nQhPtr
	 qZ9Swk606Qo4mAVLWNXtqH5LINBI8/SaVe5/E9BC7xGXnX64SBaDOWGIogT7WKp00G
	 CTji3JPJk7iQKZo6TX6213hpDPapehVq3bDQPvXlV7MKjRai9u30EpJnhDlmr1I004
	 MY2ZKadu9+0hUOxFLnaMmc/JR0oU9ocYeXs6lWmKcVWqBN16sO/IkzkeR9Q51iM251
	 gkQnHaMRcshWw==
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
Subject: [PATCH v6 7/8] dma: swiotlb: Add an overridable architecture pool opt-out
Date: Thu, 24 Sep 2026 11:37:55 +0530
Message-ID: <20260924060756.1325156-8-aneesh.kumar@kernel.org>
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

On x86, iommu=off historically prevented SWIOTLB initialization by not
setting SWIOTLB_INIT_ADDRESSING_LIMIT. This overloads that flag: it
controls both whether a pool is selected and where the pool is
allocated. If another requirement, swiotlb=force selects a pool
independently, omitting SWIOTLB_INIT_ADDRESSING_LIMIT may place it above
the addressable range of devices which need bounce buffering.

Add SWIOTLB_INIT_DEFAULT_OFF to let an architecture opt out of normal
pool initialization without discarding the pool placement constraints.

Unlike swiotlb_force_disable, which is set by swiotlb=noforce and
unconditionally prevents pool initialization, the new flag is an
architecture default. Explicit requirements such as memory encryption,
architecture remapping, or swiotlb=force take precedence over it.

iommu=soft retains SWIOTLB_INIT_ADDRESSING_LIMIT because it requests
software bounce buffering for devices whose DMA masks cannot address all
system memory. Such devices must be able to reach the bounce pool.

Clear both flags for Xen because Xen explicitly requires a remapped
swiotlb pool and may allocate it anywhere in directly mapped memory.

With no override, iommu=off disables both hardware IOMMU translation and
swiotlb bouncing. Direct DMA remains available; mappings outside a
device's addressable range fail instead of being bounced.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
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
 arch/x86/kernel/pci-dma.c | 11 ++++++++---
 include/linux/swiotlb.h   |  2 ++
 kernel/dma/swiotlb.c      | 10 ++++++++--
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index 0cff255827ba..ce257b20ea9c 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -44,9 +44,13 @@ static unsigned int x86_swiotlb_flags;
 static void __init pci_swiotlb_detect(void)
 {
 	/* don't initialize swiotlb if iommu=off (no_iommu=1) */
-	if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN) {
-		x86_swiotlb_enable = true;
+	if (no_iommu)
+		x86_swiotlb_flags |= SWIOTLB_INIT_DEFAULT_OFF;
+
+	if (max_possible_pfn > MAX_DMA32_PFN) {
 		x86_swiotlb_flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
+		if (!no_iommu)
+			x86_swiotlb_enable = true;
 	}
 
 	/*
@@ -84,7 +88,8 @@ static void __init pci_xen_swiotlb_init(void)
 		return;
 	x86_swiotlb_enable = true;
 	/* Xen can use a SWIOTLB pool anywhere in directly mapped memory. */
-	x86_swiotlb_flags &= ~SWIOTLB_INIT_ADDRESSING_LIMIT;
+	x86_swiotlb_flags &= ~(SWIOTLB_INIT_ADDRESSING_LIMIT |
+			       SWIOTLB_INIT_DEFAULT_OFF);
 	x86_swiotlb_flags |= SWIOTLB_INIT_REMAP | SWIOTLB_ANY;
 	swiotlb_init_remap(x86_swiotlb_flags, xen_swiotlb_fixup);
 	dma_ops = &xen_swiotlb_dma_ops;
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 6386536a5ec6..f5ce45f2994b 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -20,6 +20,8 @@ struct scatterlist;
 #define SWIOTLB_INIT_ADDRESSING_LIMIT	(1 << 2)
 /* Initialize a default-sized pool that requires architecture remapping. */
 #define SWIOTLB_INIT_REMAP		(1 << 3)
+/* Do not initialize a pool unless SWIOTLB is explicitly required. */
+#define SWIOTLB_INIT_DEFAULT_OFF		(1 << 4)
 
 /*
  * Maximum allowable number of contiguous slabs to map,
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index e626cca63ad1..130a13eb85b0 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -526,10 +526,16 @@ swiotlb_select_pool_policy(unsigned int flags)
 	if (flags & SWIOTLB_INIT_REMAP)
 		return SWIOTLB_POOL_DEFAULT;
 
-	if (flags & SWIOTLB_INIT_ADDRESSING_LIMIT)
+	if (swiotlb_force_bounce)
 		return SWIOTLB_POOL_DEFAULT;
 
-	if (swiotlb_force_bounce)
+	/*
+	 * Explicit requirements above override an architecture's default opt-out.
+	 */
+	if (flags & SWIOTLB_INIT_DEFAULT_OFF)
+		return SWIOTLB_POOL_NONE;
+
+	if (flags & SWIOTLB_INIT_ADDRESSING_LIMIT)
 		return SWIOTLB_POOL_DEFAULT;
 
 	if (swiotlb_kmalloc_needs_bounce())
-- 
2.43.0

