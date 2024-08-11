Received: from mail.tkos.co.il (guitar.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06EE1C2BD;
	Sun, 11 Aug 2024 07:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723360189; cv=none; b=l4/hWvugydpQR7667+cHkm/H5Rm1YG2q32qWL25D62sPrH8vJ8jgSmZwPw6C3SSoCdGetvP30PObWWMAKhWnwqDsIrelZlX6jsxJfUQog8yL9YuA+8KT+RdRCPxn7ZS7P54+I3JMuXCZRBSHefmk3op3v9WG/d8EnkN7CVel1R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723360189; c=relaxed/simple;
	bh=nf/MkqeBwiD3TKhf52jrg5yDi7MiKiiAJynae1NoHxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rkRDuh1wr/VAH+KbZPmxW6CEVcHEwgOD15shynazGoL0K5cS5HvuttgXva7HbTsk9CSw2kQQelFfqXd76k5EsINCDWwRCTFbYnEXSdYuEV6HYcgCNh/AJpRgp7a+/1QEnmEgQUY0WCicr0TDzS587hLOZXKGt5gHXyOa1ZOPJfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=u9t9D4D4; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="u9t9D4D4"
Received: from tarshish.tkos.co.il (unknown [10.0.8.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id AC632440F36;
	Sun, 11 Aug 2024 10:08:13 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1723360094;
	bh=nf/MkqeBwiD3TKhf52jrg5yDi7MiKiiAJynae1NoHxY=;
	h=From:To:Cc:Subject:Date:From;
	b=u9t9D4D4GOVGPdIf3j4rCxiYr4On/te/G7ibLcCPJd1L3xwINzoEOnQObJFuTX579
	 Jps5mdQfaS1pDDDpDr4we09WWJ3Z1c3mXIL2KgjqyBT/MRAVg8BaESBpfO3hauuxSb
	 tBftApeC1T5mj/hC7zPK/ux9AG/Nbrbw3aFtxfvhXiNVb3XbkluI8U2J2fvdPPDxP3
	 vEc757+0bvOeip9isMvhTi3zHGt5vqSN2WT/AzeRR4S+xyu0bWhWcM1cR9WGVsoZJm
	 6yjlgw27UOu2t7BolltOtgvs1Ws4PsybaMjcirEk+nQCCR+dHv1Cc3jSHx9pcdaph6
	 fQDCCPoFH0q/g==
From: Baruch Siach <baruch@tkos.co.il>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Baruch Siach <baruch@tkos.co.il>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>,
	Ramon Fried <ramon@neureality.ai>,
	Elad Nachman <enachman@marvell.com>
Subject: [PATCH v6 RESED 0/2] dma: support DMA zone starting above 4GB
Date: Sun, 11 Aug 2024 10:09:34 +0300
Message-ID: <cover.1723359916.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Resend series with correct Cc list. Sorry for the spam. ]

DMA zones code assumes that DMA lower limit is zero. When there is no RAM 
below 4GB, arm64 platform code sets DMA/DMA32 zone limits to cover the entire 
RAM[0].

My target platform has RAM starting at 32GB. Devices with 30-bit DMA mask are 
mapped to 1GB at the bottom of RAM, between 32GB - 33GB. DMA zone over the 
entire RAM breaks DMA allocation for these devices.

In response to a previous RFC hack[1] Catalin Marinas suggested to add a
separate offset value as base address for the DMA zone, and then refined the 
suggestion to use start of RAM[3]. This series attempts to implement that 
suggestion.

With this series applied, the DMA zone covers the right RAM range for my 
platform.

v6:

  * Drop the first patch; existing logic is just fine

  * Modify powerpc code to avoid off by one issue

v5:

  * Test the correct kernel

  * Add missing patch that actually makes DMA zone work

  * Extend the treatment of zone_dma_limit > DMA_BIT_MASK(32)

  * Use max() to make the code somewhat more readable

  * Change zone_dma_limit type to u64 to match DMA_BIT_MASK()

v4:

  * Drop last patch. zone_dma_limit includes RAM base address.

  * Adjust DMA zone selection in swiotlb as well.

  * Don't change max_zone_phys() behaviour

  * Update code to fallback to DMA zone when zone_dma_limit > DMA_BIT_MASK(32)

v3:

  * Rebase on v6.11-rc1.

  * Drop zone_dma_base. Use memblock_start_of_DRAM() instead.

  * Drop DT patches. Low DMA range limit no longer needed.

  * Add patch to improve dma_direct_optimal_gfp_mask() heuristics as Catalin 
    suggested.

RFC v2:

  * Add patch from Catalin[2] changing zone_dma_bits to zone_dma_limit to 
    simplify subsequent patches

  * Test on real hardware

RFC v1: https://lore.kernel.org/all/cover.1703683642.git.baruch@tkos.co.il/

[0] See commit 791ab8b2e3db ("arm64: Ignore any DMA offsets in the 
    max_zone_phys() calculation")

[1] https://lore.kernel.org/all/9af8a19c3398e7dc09cfc1fbafed98d795d9f83e.1699464622.git.baruch@tkos.co.il/

[2] https://lore.kernel.org/all/ZZ2HnHJV3gdzu1Aj@arm.com/

[3] https://lore.kernel.org/all/ZnH-VU2iz9Q2KLbr@arm.com/

Catalin Marinas (2):
  dma: replace zone_dma_bits by zone_dma_limit
  arm64: support DMA zone above 4GB

 arch/arm64/mm/init.c       | 32 ++++++++++----------------------
 arch/powerpc/mm/mem.c      |  5 ++++-
 arch/s390/mm/init.c        |  2 +-
 include/linux/dma-direct.h |  2 +-
 kernel/dma/direct.c        |  6 +++---
 kernel/dma/pool.c          |  4 ++--
 kernel/dma/swiotlb.c       |  6 +++---
 7 files changed, 24 insertions(+), 33 deletions(-)


base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
-- 
2.43.0

