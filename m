Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642760;
	b=Z8/508s2Zwf8AQFbJS9hvacFe0DB3QxL2STLvApPqa+uqN51UhuJce4bmUe9vD6kuVaV
	 8M4IEhlCYtmfMKvAawmE6Jv+amILkG8k7Gg9D/JtH5gKrk5D0CwH8tqoCO4k59LzacQvC
	 d8t30tKasy9hbGUgsYmOw59YwKPhDJxxiWgy2YV73eTWvJn4B5ERtyJnsHkr1wmS705Ap
	 dU54V2TJFh2qM0AOxtlsNNIwftzVugfNPcnFDXkWjEcXJPb4Oje8GlyhpLIclGHB31goO
	 1WTCGM/Q7fCkaThJp5lY4wmxrQKBLO9hFVV4p3aauzKCr3o2/l4042TYNTJ8fXuJekA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642760;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=dJBjtHj/U35Sno9olpkCbmU3J1nhzHn1TeUoFt7nUEY=;
	b=yw8yR0Fuk510mtQ1ndMPIdMFcShLCThiFdhiO2BwUgJERVk6M2zBzu8yXBQRBUOyAOTu
	 4K7UBdbeu5LkwJZm26FVBjs+/hs8faW0zGiCatULW6my0tj91SH4OOXWfSXbbVYmpJ+Sp
	 Uef4N5749Vo6OYcpRcbxjqassXX6m8z9yYE1MXGSy0i9t3g4XhzOHSGIhkSJqPxsg4UUz
	 XL/2mI1MMdnsu/d8mdliRTt79KxHqNeYdxLKgRjLTVvqH9XHsn/DHFUNobeT0MK1B6SyJ
	 vRkgkJtGTqxQSsHy/s9nT0nGSoK9cXwED8vW5wGq6DQo+8mxZZw1eEXXCyDIT1mExKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZLxiR+T+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D52606A321;
	Wed, 25 Nov 2026 21:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZLxiR+T+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9A51F000C6;
	Wed, 25 Nov 2026 21:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642759;
	bh=dJBjtHj/U35Sno9olpkCbmU3J1nhzHn1TeUoFt7nUEY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZLxiR+T+BsSHG3qnraIpxEnw1AKOgXqd27CskrcQcAzCnBPEROUGkHQ8M0dOTuEF2
	 v+HG/9GIvXXDfUR31xFyycfQ9BqVveug3KmxNw+/KUHejD9Dw8OxWGOT7AkAbAYqaT
	 Bs21TaIArqigX5/IgmXaw3xKR13el4OxMviNGy8OOXCDyLAW+ABLAZZbBJ7r0stztO
	 4ZEv3kwQgp8dwDKSvLjxBmW1Ewm+SI2tnMzo2CVHfUk7ACK07Kg7xPgzSFzRuheuRW
	 ngbOq2z34xaqRnUG5TtsT/BktFuqrdfK3SdlzvKrnRgA7O2Oxvd1C32/9p3Wcuxnu5
	 EZnqfS6cvgYpA==
From: "Harry Yoo (Meta)" <harry@kernel.org>
Date: Wed, 25 Nov 2026 21:37:10 +0000
Subject: [PATCH slab/for-next v2 09/14] iommu: specify SLAB_MAY_ACCOUNT for
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
Message-Id: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-9-7c680f02a734@kernel.org>
References: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-0-7c680f02a734@kernel.org>
In-Reply-To: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-0-7c680f02a734@kernel.org>
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
 "Harry Yoo (Meta)" <harry@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Alice Ryhl <aliceryhl@google.com>, 
 Andrew Ballance <andrewjballance@gmail.com>, 
 Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
 Kees Cook <kees@kernel.org>, David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Amir Goldstein <amir73il@gmail.com>, 
 Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 linux-security-module@vger.kernel.org, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
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
index a280ad4f63b7..467b97ec18dc 100644
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
index acdccb7c9eef..604a357cc1fb 100644
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

