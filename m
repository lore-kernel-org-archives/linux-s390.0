Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583279;
	b=CQ9r6m6Em+zHcKU8bEVNyr/qloTS868KpWaHRzK/NWikc9+xcy31op9FUzti5n6Of3bI
	 AWsu6+LGqxsTAsm2Q3U752qUJ3IBM4UWD6op1UE4YrEjy9mv5IjcXB8MwWDYAO+NGu2kw
	 ozcjxU21+To4j+WDKI8Jh63OG6JoK0KCwwVLapbNM2pPAaHGaFSbyV53RYLOn3Id12G6j
	 jYK1WlXRVP5q8K6QlG8URQMzt4t7vceH/M6sI6UbkFMc+DQHIcw2gljLDE4hjLVu6ZEjJ
	 8Gh9JAg3K2H6HbeE/+R3AAQ7QaR91zOJrnKnFB7XeN9HMgtjoL/wdczitrnOZlGV+Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583279;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=UY0BY5YZcT9xFUcwEXXKGABgtDytV9atXMOzM0KH+wY=;
	b=z5EETyBVh3udOpGIr8PjmLbfn2v9W9ZyOuqB5Gr7kEiMZSET+V+4Pzsgzja2Tl3I37kH
	 H5EY6QQyvvfYWeo3lmpEI/g/DL7YBnol6tqBm0lcEKivnYouifj/42mPPvNevWbZmerDJ
	 IeS6M6HiN3nNZgXIufuB88VDbLZFCntDZfFu74HkCDJ31oHympdK7U6NUZgsGUqRWpcqv
	 YPSU2T4oLn29/NE+I9BqTZUaIS0pAEhWBifiFW739ViuM/NpKHp4/7XnkiDbcOYgyBjiW
	 RRwvtovFEYKJ4ZjJu/c6gchDrbmAbsuEZSeL0p4y/XC2etFF3UHU2e4ft82WmGcKmsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YdhnBWYe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52666606A319;
	Wed, 21 Oct 2026 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YdhnBWYe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992091F000C4;
	Wed, 21 Oct 2026 11:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792583279;
	bh=UY0BY5YZcT9xFUcwEXXKGABgtDytV9atXMOzM0KH+wY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YdhnBWYe3LLCjDlSmUmc7fbfmRbuuqfaySN5me/ny51WQDoQFdlIh2+8UL9tQ3WUI
	 QLOQEHpo/RasEj1yUxSmp5WVnLLlhN48g3Gdgpk8Da3uyBRRa/yvGrSoekpmLLSlo3
	 Ts4DDL/G29GuMseX9g/VaL9o4FJSAxHJ6wNXwITPioc8BGogc9r1dMo6sF1/O+WW1/
	 VrMkruz4tjRP7Siphpg2GtlCcBNpsGrYoZv7ztN3r8kNPqI9BXcYNIDVCR05R9IvcU
	 jSpGR3PcurvE7W+458ZtaW8m9gmkJWIuysihjESrJLVgPldaTk6EQv6K6Wkr+5B2IS
	 Xf8YIIoHyE0tw==
From: "Harry Yoo (Meta)" <harry@kernel.org>
Date: Wed, 21 Oct 2026 12:46:50 +0100
Subject: [PATCH slab/for-next 09/14] iommu: specify SLAB_MAY_ACCOUNT for
 slab-backed page table caches
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-9-096800aa3330@kernel.org>
References: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-0-096800aa3330@kernel.org>
In-Reply-To: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-0-096800aa3330@kernel.org>
To: Vlastimil Babka <vbabka@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
 David Rientjes <rientjes@google.com>, Muchun Song <muchun.song@linux.dev>, 
 Hao Ge <hao.ge@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 "Harry Yoo (Meta)" <harry@kernel.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Niklas Schnelle <schnelle@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-s390@vger.kernel.org, 
 linux-sunxi@lists.linux.dev
X-Mailer: b4 0.16.0

vfio, iommufd and vhost-vdpa call iommu_map() with GFP_KERNEL_ACCOUNT
and the gfp is passed down to the drivers' page table allocations.
Specify SLAB_MAY_ACCOUNT when the object may be charged to a memcg.
__GFP_ACCOUNT without SLAB_MAY_ACCOUNT will not be allowed.

Paths:
  VFIO_IOMMU_MAP_DMA -> iommu_map(GFP_KERNEL_ACCOUNT)
    -> s390_iommu_map_pages() -> dma_walk_cpu_trans()
    -> kmem_cache_alloc(dma_{region,page}_table_cache)
  iommu_map(GFP_KERNEL_ACCOUNT) -> arm_v7s_map_pages()
    -> __arm_v7s_alloc_table() -> kmem_cache_zalloc(data->l2_tables)
  iommu_map(GFP_KERNEL_ACCOUNT) -> sun50i_iommu_map()
    -> sun50i_dte_get_page_table() -> kmem_cache_zalloc(iommu->pt_pool)

Assisted-by: LLM
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Chen-Yu Tsai <wens@kernel.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: iommu@lists.linux.dev
Cc: linux-s390@vger.kernel.org
Cc: linux-sunxi@lists.linux.dev
Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 2 +-
 drivers/iommu/s390-iommu.c         | 4 ++--
 drivers/iommu/sun50i-iommu.c       | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 1dbef8c55007..b544e5da237a 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -706,7 +706,7 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 	data->l2_tables = kmem_cache_create("io-pgtable_armv7s_l2",
 					    ARM_V7S_TABLE_SIZE(2, cfg),
 					    ARM_V7S_TABLE_SIZE(2, cfg),
-					    slab_flag, NULL);
+					    slab_flag | SLAB_MAY_ACCOUNT, NULL);
 	if (!data->l2_tables)
 		goto out_free_data;
 
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index f148f559ac56..f308efadc87b 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -198,14 +198,14 @@ static int __init dma_alloc_cpu_table_caches(void)
 	dma_region_table_cache = kmem_cache_create("PCI_DMA_region_tables",
 						   ZPCI_TABLE_SIZE,
 						   ZPCI_TABLE_ALIGN,
-						   0, NULL);
+						   SLAB_MAY_ACCOUNT, NULL);
 	if (!dma_region_table_cache)
 		return -ENOMEM;
 
 	dma_page_table_cache = kmem_cache_create("PCI_DMA_page_tables",
 						 ZPCI_PT_SIZE,
 						 ZPCI_PT_ALIGN,
-						 0, NULL);
+						 SLAB_MAY_ACCOUNT, NULL);
 	if (!dma_page_table_cache) {
 		kmem_cache_destroy(dma_region_table_cache);
 		return -ENOMEM;
diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index be3f1ce696ba..51a30969dde4 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -1011,7 +1011,8 @@ static int sun50i_iommu_probe(struct platform_device *pdev)
 
 	iommu->pt_pool = kmem_cache_create(dev_name(&pdev->dev),
 					   PT_SIZE, PT_SIZE,
-					   SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA32,
+					   SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA32 |
+					   SLAB_MAY_ACCOUNT,
 					   NULL);
 	if (!iommu->pt_pool)
 		return -ENOMEM;

-- 
2.54.0

