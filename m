Received: from mail.tkos.co.il (guitar.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CEA35280;
	Fri,  2 Aug 2024 06:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722578645; cv=none; b=Ruz2+5HFxRMeCvRQbIpfrZdONKsLOWyBZJAW7lTNMilS8rEx57f1eEVAn2JlTeMB1hDxsNObkC8r6wihcXi8ZBOv5bn/ZAksUiJGWLn9M6/UsKBv6i41osYNl2em1SaapuLpnmN1Q80XQ7fQWVLS0QnmoTBCvwmfJtq3LJ5+ZGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722578645; c=relaxed/simple;
	bh=pqfXeuMc5R7Cx8Hid5iZqoJG0UKfN0CUSBnJMj912kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ld6L8NwdbvWK9fjlXS/DjN5Uwr7hkFWvLObJ4ZcExk0Wwgw1cNtYQI7WHWpz73X8r31VNjtK0+DW2c1rIauJDF2+kE+2/LqOA3BLUK2jnG32kALi/fr51SP32dKh6LBy8mdQWG1wB9x3E5/lPZedKKs9oeInRYG67Ra24tazcjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=jxw4ewpc; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="jxw4ewpc"
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 67FEC440781;
	Fri,  2 Aug 2024 09:02:40 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1722578560;
	bh=pqfXeuMc5R7Cx8Hid5iZqoJG0UKfN0CUSBnJMj912kU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jxw4ewpcZKyrwwVVby3ENvaRKD5+q43frok6KvtiVJjixZ70wQjpzYYQffkA9WxRP
	 0KWBItUAW6BoNL+vOZvvP+zUvkqDQlkajNoc3Xvq+u2gqzkKn2DOCZdHZ2+0Qlpiox
	 BmVJb1aL26HgwatlIySl0FDvsZY5YXheAqrbpgWf88dnLv5MNUvgy0EsrbMxlpnjrr
	 sIS2yh6n1Q0E4Ogw/3emRiGR3GTpm4dd5i7z0i3yQ938EWaF5stOqKZAJqqesJRgmj
	 eSSGZoylk2Hcn6v7gdRxTCFzoEzwtI6/SYs1no4jBvTetS1fuKkks6oEyL8I/WtSe3
	 CS0OKA8M4LbXQ==
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
Subject: [PATCH v5 3/3] arm64: support DMA zone above 4GB
Date: Fri,  2 Aug 2024 09:03:48 +0300
Message-ID: <517ef5af643bbc258b53c95b443ffe9678a95af3.1722578375.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722578375.git.baruch@tkos.co.il>
References: <cover.1722578375.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Catalin Marinas <catalin.marinas@arm.com>

Commit 791ab8b2e3db ("arm64: Ignore any DMA offsets in the
max_zone_phys() calculation") made arm64 DMA/DMA32 zones span the entire
RAM when RAM starts above 32-bits. This breaks hardware with DMA area
that start above 32-bits. But the commit log says that "we haven't
noticed any such hardware". It turns out that such hardware does exist.

One such platform has RAM starting at 32GB with an internal bus that has
the following DMA limits:

  #address-cells = <2>;
  #size-cells = <2>;
  dma-ranges = <0x00 0xc0000000 0x08 0x00000000 0x00 0x40000000>;

That is, devices under this bus see 1GB of DMA range between 3GB-4GB in
their address space. This range is mapped to CPU memory at 32GB-33GB.
With current code DMA allocations for devices under this bus are not
limited to DMA area, leading to run-time allocation failure.

This commit reinstates DMA zone at the bottom of RAM. The result is DMA
zone that properly reflects the hardware constraints as follows:

[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000800000000-0x000000083fffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000840000000-0x0000000bffffffff]

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[baruch: split off the original patch]
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm64/mm/init.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index c45e2152ca9e..bfb10969cbf0 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -114,20 +114,8 @@ static void __init arch_reserve_crashkernel(void)
 				    low_size, high);
 }
 
-/*
- * Return the maximum physical address for a zone given its limit.
- * If DRAM starts above 32-bit, expand the zone to the maximum
- * available memory, otherwise cap it at 32-bit.
- */
 static phys_addr_t __init max_zone_phys(phys_addr_t zone_limit)
 {
-	phys_addr_t phys_start = memblock_start_of_DRAM();
-
-	if (phys_start > U32_MAX)
-		zone_limit = PHYS_ADDR_MAX;
-	else if (phys_start > zone_limit)
-		zone_limit = U32_MAX;
-
 	return min(zone_limit, memblock_end_of_DRAM() - 1) + 1;
 }
 
-- 
2.43.0

