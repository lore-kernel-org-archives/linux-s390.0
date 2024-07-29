Received: from mail.tkos.co.il (mail.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C9613D281;
	Mon, 29 Jul 2024 10:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722250321; cv=none; b=dbCt2gjptL3dRRULmm2hFH/xpZEdD7thB+FGw+JqlEwyvbpnsWJAaE8LPmrXSMdQVTHUdnF0i93q1WPUBl78hoiB0/7H86aktm0X0H1mir8pLFKS9DI2pSP2bucdmfDobsFh0ZUcqSqZW69SpfQIz/dfyvzoFHQZi1XoVHS6ucc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722250321; c=relaxed/simple;
	bh=fW3seKu3qSWQ63GvanpzjS9o30g/c8HO+hDOTWVeunY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QjVKtJ8+voTQlXPCbJOIzZha4iovSoEKCQPVaYD2YreyedIgE6IMj5oGlSUTcoPlK+4CcnM+69lEhthnOj6dlTDWTvTRFKNXjlgFdUnk81wspMNjx7RRWg42F86a8GP3N7XBuVarVD0XcGfyDzPtoFeGdw8VfDqdlw5ZZDDXOy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=oxb6c/Eu; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="oxb6c/Eu"
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 5C85044077F;
	Mon, 29 Jul 2024 13:50:32 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1722250232;
	bh=fW3seKu3qSWQ63GvanpzjS9o30g/c8HO+hDOTWVeunY=;
	h=From:To:Cc:Subject:Date:From;
	b=oxb6c/Eu6R3lnFbBk1ATcjrT04NEVWB9QlcbuP6HUW8mgWd+gF1a/nKIokODTXVEa
	 OPq8XiyDhAxh7nRm91I3O5m+7MK740rLnMhBRvbhasdMcwGkbi26eNM/wG5j4zx6kg
	 RUo7n483hb7jswtzULahoaXd3+3arO6GytgHs/6b3Sr7Pv5lBZptycGtoF2RzPY+oR
	 hnpqgsVLqN8b3fvK4wTH0IzCg5Srw5G0QnQdFHmIbO7LBBDAHHpSTMe/xSTfjVKt/A
	 ouC0R5aURB3/Sn2fLU2NJut7AYOriSMaeAYYf4ywM42DhNjkBh6oEknuwRbvGmBvjo
	 30+SvOeUXew4A==
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
Subject: [PATCH v3 0/3] dma: support DMA zone starting above 4GB
Date: Mon, 29 Jul 2024 13:51:23 +0300
Message-ID: <cover.1722249878.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DMA zones code assumes that DMA lower limit is zero. When there is no RAM 
below 4GB, arm64 platform code sets DMA/DMA32 zone limits to cover the entire 
RAM[0].

My target platform has RAM starting at 32GB. Devices with 30-bit DMA mask are 
mapped to 1GB at the bottom of RAM, between 32GB - 33GB. DMA zone over the 
entire RAM breaks DMA allocation for these devices.

In response to a previous RFC hack[1] Catalin Marinas suggested to add a
separate offset value as base address for the DMA zone, and then refined the 
suggestion to use start of RAM[3]. This RFC series attempts to implement that 
suggestion.

With this series applied, the DMA zone covers the right RAM range for my 
platform.

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

Baruch Siach (2):
  dma-mapping: improve DMA zone selection
  dma-direct: use RAM start to offset zone_dma_limit

Catalin Marinas (1):
  dma-mapping: replace zone_dma_bits by zone_dma_limit

 arch/arm64/mm/init.c       | 34 +++++++++++++---------------------
 arch/powerpc/mm/mem.c      |  9 ++++-----
 arch/s390/mm/init.c        |  2 +-
 include/linux/dma-direct.h |  2 +-
 kernel/dma/direct.c        | 15 ++++++++-------
 kernel/dma/pool.c          |  3 ++-
 kernel/dma/swiotlb.c       |  4 ++--
 7 files changed, 31 insertions(+), 38 deletions(-)

-- 
2.43.0

