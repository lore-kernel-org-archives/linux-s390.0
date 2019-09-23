Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56078 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2394325AbfIWMfK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Sep 2019 08:35:10 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8NCRRvi032476
        for <linux-s390@vger.kernel.org>; Mon, 23 Sep 2019 08:35:09 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v6v8smj5m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 23 Sep 2019 08:35:09 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Mon, 23 Sep 2019 13:35:07 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: [RFC PATCH 1/3] dma-mapping: make overriding GFP_* flags arch customizable
Date: Mon, 23 Sep 2019 14:34:16 +0200
In-Reply-To: <20190923123418.22695-1-pasic@linux.ibm.com>
References: <20190923123418.22695-1-pasic@linux.ibm.com>
Message-Id: <20190923123418.22695-2-pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org

Before commit 57bf5a8963f8 ("dma-mapping: clear harmful GFP_* flags in
common code") tweaking the client code supplied GFP_* flags used to be
an issue handled in the architecture specific code. The commit message
suggests, that fixing the client code would actually be a better way
of dealing with this.

On s390 common I/O devices are generally capable of using the full 64
bit address space for DMA I/O, but some chunks of the DMA memory need to
be 31 bit addressable (in physical address space) because the
instructions involved mandate it. Before switching to DMA API this used
to be a non-issue, we used to allocate those chunks from ZONE_DMA.
Currently our only option with the DMA API is to restrict the devices to
(via dma_mask and dma_mask_coherent) to 31 bit, which is sub-optimal.

Thus s390 we would benefit form having control over what flags are
dropped.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---
 include/linux/dma-mapping.h | 10 ++++++++++
 kernel/dma/Kconfig          |  6 ++++++
 kernel/dma/mapping.c        |  4 +---
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 4a1c4fca475a..5024bc863fa7 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -817,4 +817,14 @@ static inline int dma_mmap_wc(struct device *dev,
 #define dma_unmap_len_set(PTR, LEN_NAME, VAL)    do { } while (0)
 #endif
 
+#ifdef CONFIG_ARCH_HAS_DMA_OVERRIDE_GFP_FLAGS
+extern gfp_t dma_override_gfp_flags(struct device *dev, gfp_t flags);
+#else
+static inline gfp_t dma_override_gfp_flags(struct device *dev, gfp_t flags)
+{
+	/* let the implementation decide on the zone to allocate from: */
+	return flags & ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
+}
+#endif
+
 #endif
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 73c5c2b8e824..4756c75047e3 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -54,6 +54,12 @@ config ARCH_HAS_DMA_PREP_COHERENT
 config ARCH_HAS_DMA_COHERENT_TO_PFN
 	bool
 
+config ARCH_HAS_DMA_MMAP_PGPROT
+	bool
+
+config ARCH_HAS_DMA_OVERRIDE_GFP_FLAGS
+	bool
+
 config ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	bool
 
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index d9334f31a5af..535b809548e2 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -303,9 +303,7 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
 		return cpu_addr;
 
-	/* let the implementation decide on the zone to allocate from: */
-	flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
-
+	flag = dma_override_gfp_flags(dev, flag);
 	if (dma_is_direct(ops))
 		cpu_addr = dma_direct_alloc(dev, size, dma_handle, flag, attrs);
 	else if (ops->alloc)
-- 
2.17.1
