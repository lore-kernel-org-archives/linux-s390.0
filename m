Received: from mail.tkos.co.il (wiki.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42D6249EB;
	Fri,  2 Aug 2024 06:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722578645; cv=none; b=V+Pf9f2a6g1J4zwEsEHW37twUGGLMm+tS2WW55iAYt5KIsWJI63R6VuZNLjbMOFFEzxDIVADZ1vjMJgBcaniA/MgwaIPgrk5fD/cW+q813ma+FsZlamLZiWT+ODSsv0WKaiMcjkBnr6gJWwHL0lWDhazxfn2nfsD/Nb6idhnlXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722578645; c=relaxed/simple;
	bh=f7+YSeoZjV+nruyrLf+ETcyb6ScBPRAvwyyjAC4FQFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FLwKKcm45u3U24sDf4AokOfURWnuSIpxEQBZ9Df4ZEgOBdTK8DE138/PTtjw9fNErSrAUFuyTGBJW0lip78lqnuzIlyrbIzq4QhRgwO+NqGfUjwt/5/zxkvaoHyJpc1Aqc8ktgY2b05/7DNbAqoBS8CXLIehPEwZBRKJK33JFV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=laksWbYU; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="laksWbYU"
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 9BC03440478;
	Fri,  2 Aug 2024 09:02:39 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1722578559;
	bh=f7+YSeoZjV+nruyrLf+ETcyb6ScBPRAvwyyjAC4FQFo=;
	h=From:To:Cc:Subject:Date:From;
	b=laksWbYUuGR2eviQWANC1xAkZ5reUbsIdGDAQi60pNfJnr9Tq/TA0Nu8H11CbROwt
	 b4RU0Di3OEWiWem+oVrGHX4EfVbuliW88g7AvkZ5CAmuWE8NpmoK9nUe+GATiCEah5
	 3NolBe5dO8DPW8Np5CyQ31lkq7WtkAQn3mutHMQgAN4qGZvDJjmeFRl+WtMrVP2tau
	 uLsiRCoAKsagrgIXD6p64YY9icUL0ImBDYq0yVmy2S7/vfPmrsAr1+B0f3zoO1q8/J
	 tUv++lFihD0+OhzQ8OA5qqZ3x5Duqa+BfhsEMq/LSWhT6xEyp9k7fhzwIjYXEsHGxk
	 gmuxHtLZfz+kg==
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
Subject: [PATCH v5 0/3] dma: support DMA zone starting above 4GB
Date: Fri,  2 Aug 2024 09:03:45 +0300
Message-ID: <cover.1722578375.git.baruch@tkos.co.il>
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
suggestion to use start of RAM[3]. This series attempts to implement that 
suggestion.

With this series applied, the DMA zone covers the right RAM range for my 
platform.

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

Baruch Siach (1):
  dma: improve DMA zone selection

Catalin Marinas (2):
  dma: replace zone_dma_bits by zone_dma_limit
  arm64: support DMA zone above 4GB

 arch/arm64/mm/init.c       | 32 ++++++++++----------------------
 arch/powerpc/mm/mem.c      |  9 ++++-----
 arch/s390/mm/init.c        |  2 +-
 include/linux/dma-direct.h |  2 +-
 kernel/dma/direct.c        | 10 +++++-----
 kernel/dma/pool.c          |  4 ++--
 kernel/dma/swiotlb.c       |  8 ++++----
 7 files changed, 27 insertions(+), 40 deletions(-)


base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
-- 
2.43.0

