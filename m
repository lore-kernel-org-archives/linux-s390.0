Received: from mail.tkos.co.il (mail.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E99144D1C;
	Mon, 29 Jul 2024 10:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722250319; cv=none; b=eeE4/cN4E985qUnUUqSuxCaTmG4fJoF7o+dut02V4UmyYQMDI3nwBDjXUHdc/wYvk6Ufj3ibHfzKa40mDUYlz/qhEkdB6cUr7mo9+3ezMaasrdWjPXsfYbgPmjqiUVyQlsBo0Rw2PGGSMB8z8c7aUcorwBEJCLb2SL0GQov6Q2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722250319; c=relaxed/simple;
	bh=Za3ndOc802AihmgHa1yG/1ah7Y+qALAilhokvJR5l6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=getJERRzb4l41ITIhPVWw6AOeiWx+sjDvquCg792hDVIiM/PV+qlOhfJaFD4cwks+Jq/QMhrJE60Qmb+14bj0OMusDvVEdZJwn8Uhlml8E3ZKjsPeQpzns28R7diMNnnsxwN2mgllv5YJz9l2vem6ouMpL2TuZjdq24n+WDuhqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=sqYrURUN; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="sqYrURUN"
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 9C11D440822;
	Mon, 29 Jul 2024 13:50:32 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1722250232;
	bh=Za3ndOc802AihmgHa1yG/1ah7Y+qALAilhokvJR5l6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sqYrURUNeVzskJP5y542ZUwGS+Yuc8/B6oLImG2wmK1bofHj9wdMUUCE+ZNo3QwtV
	 C9couwt2AgMZhgvSGDZhKyrVYGTfNYoxhTIjl+YEdDsYUq7vT/52VuqzjF2Frp1Uvr
	 wLubP/hRfj5O5ezNtoG6/ej+TSbNf5hpEAl4UsAbSCd2ZvvqgyOzobLzNjS35zVPMH
	 vs1JX+wzlRu7zbGJqLEaaF0nfp1tefez3QpSt1mBhVPrbyUZk19dmMWSpLg7wtuD9W
	 JSYE9nfzIc6YtLFlQCsttUXpM3a7cjfkVN80+tYDYZVVzYdqWMzKnVHrr79LwyZeDz
	 6UTsuJtIJu/QA==
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
Subject: [PATCH v3 1/3] dma-mapping: improve DMA zone selection
Date: Mon, 29 Jul 2024 13:51:24 +0300
Message-ID: <fe2e245ba534fc3cee9890ba12d1da13084e67a5.1722249878.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722249878.git.baruch@tkos.co.il>
References: <cover.1722249878.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When device DMA limit does not fit in DMA32 zone it should use DMA zone,
even when DMA zone is stricter than needed.

Same goes for devices that can't allocate from the entire normal zone.
Limit to DMA32 in that case.

Reported-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 kernel/dma/direct.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 4480a3cd92e0..3b4be4ca3b08 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -4,7 +4,7 @@
  *
  * DMA operations that map physical memory directly without using an IOMMU.
  */
-#include <linux/memblock.h> /* for max_pfn */
+#include <linux/memblock.h>
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/dma-map-ops.h>
@@ -59,9 +59,9 @@ static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 *phys_limit)
 	 * zones.
 	 */
 	*phys_limit = dma_to_phys(dev, dma_limit);
-	if (*phys_limit <= DMA_BIT_MASK(zone_dma_bits))
+	if (*phys_limit < DMA_BIT_MASK(32))
 		return GFP_DMA;
-	if (*phys_limit <= DMA_BIT_MASK(32))
+	if (*phys_limit < memblock_end_of_DRAM())
 		return GFP_DMA32;
 	return 0;
 }
-- 
2.43.0

