Received: from mail.tkos.co.il (golan.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56AD13CA8E;
	Thu,  1 Aug 2024 08:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722500735; cv=none; b=RKw8n0iwiKJG1X9F9uSJxa6oOgrjoXNL90aLzPjCV/p63JESCDRfBTHIBTMG8zuKLGJcQWwoxY9iVyBpSU2QjW3SlgrFZd/XR0U+oRVbExm3Fq+u4j6a9haS5ycBS+lcsbgxrxtFmZC/5VBdHWh/iEhDZFmgmgOVIF5kMxIyZ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722500735; c=relaxed/simple;
	bh=e4Yj33YrCMXIAhWSQdxNKN5zPpV1PvwBwZyzghUIBMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LIfFXlfwxKxxlQJeeXlFWdYGnNLQiYzBtcV31a2Dd0J5pQgLRqNUsJU3mv8Lx4pw3MGM8uVAib6ql+4jkrrlNxdDa5fzNv4FgacJfcRJNKGhUvz5Zkn1lTg9RAUvKbj3oobo51iAlGv6rQBmRLshElSfe5Lv0ufDeOxKYwhVomo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=MO+oof9h; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="MO+oof9h"
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 2C0424403E6;
	Thu,  1 Aug 2024 11:24:05 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1722500645;
	bh=e4Yj33YrCMXIAhWSQdxNKN5zPpV1PvwBwZyzghUIBMk=;
	h=From:To:Cc:Subject:Date:From;
	b=MO+oof9hDinlwTZLphphkO6pelfCsHxYxJT4C+Os5kSj1t+43czch0I6u23S4KUfu
	 PfGWEk7NoZj3A9BJoFch2FAl4appafP9F83imsHL1OdV1bSejsH4eVEanTVffDe6JX
	 QlIAMEMHeKOJRgrcMIDYtDxc1iCrHYRJMGRJxsGGGoupMtfZ32BCKXetYX8E13E9fW
	 ODXffujw3tqQNWsuIT0SR4/yG8AAIcYni+NuPF0i0ugO+JcpU3BxcQwJKqv0B/ylce
	 rD3xBWePHo3b0Nwf/hetxL7yfuEL91j/d4ktrcDmk6HlKjpyNskSqTdJwkYgJtpnyJ
	 j1T+l6rnBLP8w==
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
Subject: [PATCH v4 0/2] dma: support DMA zone starting above 4GB
Date: Thu,  1 Aug 2024 11:25:05 +0300
Message-ID: <cover.1722499975.git.baruch@tkos.co.il>
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

Catalin Marinas (1):
  dma: replace zone_dma_bits by zone_dma_limit

 arch/arm64/mm/init.c       | 30 +++++++++++++++---------------
 arch/powerpc/mm/mem.c      |  9 ++++-----
 arch/s390/mm/init.c        |  2 +-
 include/linux/dma-direct.h |  2 +-
 kernel/dma/direct.c        | 10 +++++-----
 kernel/dma/pool.c          |  5 +++--
 kernel/dma/swiotlb.c       |  6 +++---
 7 files changed, 32 insertions(+), 32 deletions(-)


base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
-- 
2.43.0

