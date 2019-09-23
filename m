Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10822 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394414AbfIWMfM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Sep 2019 08:35:12 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8NCV1Tm140149
        for <linux-s390@vger.kernel.org>; Mon, 23 Sep 2019 08:35:11 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v6x4g02wd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 23 Sep 2019 08:35:10 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Mon, 23 Sep 2019 13:35:08 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: [RFC PATCH 2/3] s390/virtio: fix virtio-ccw DMA without PV
Date: Mon, 23 Sep 2019 14:34:17 +0200
In-Reply-To: <20190923123418.22695-1-pasic@linux.ibm.com>
References: <20190923123418.22695-1-pasic@linux.ibm.com>
Message-Id: <20190923123418.22695-3-pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org

Commit 37db8985b211 ("s390/cio: add basic protected virtualization
support") breaks virtio-ccw devices with VIRTIO_F_IOMMU_PLATFORM for non
Protected Virtualization (PV) guests. The problem is that the dma_mask
of the ccw device, which is used by virtio core, gets changed from 64 to
31 bit, because some of the DMA allocations do require 31 bit
addressable memory. For PV the only drawback is that some of the virtio
structures must end up in ZONE_DMA because we have the bounce the
buffers mapped via DMA API anyway.

But for non PV guests we have a problem: because of the 31 bit mask
guests bigger than 2G are likely to try bouncing buffers. The swiotlb
however is only initialized for PV guests, because we don't want to
bounce anything for non PV guests. The first such map kills the guest.

Let us go back to differentiating between allocations that need to be
from ZONE_DMA and the ones that don't using the GFP_DMA flag. For that
we need to make sure dma_override_gfp_flags() won't clear away GFP_DMA
like it does by default. Then we can fix the dma_mask. CCW devices are
very well capable of  DMA-ing data to/from any address, it is just that
certain things need do be 31 addressable because of the 31 bit heritage.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Fixes: 37db8985b211 ("s390/cio: add basic protected virtualization support")
---

I was conservative about preserving old behavior for PCI. Could we just
not clear any flags in dma_override_gfp_flags()?
---
 arch/s390/Kconfig             |  1 +
 arch/s390/include/asm/cio.h   |  5 +++--
 arch/s390/mm/init.c           | 20 ++++++++++++++++++++
 drivers/s390/cio/css.c        | 16 +++++++++-------
 drivers/s390/cio/device.c     |  5 +++--
 drivers/s390/cio/device_ops.c |  3 ++-
 6 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index f933a473b128..e61351b61ce7 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -60,6 +60,7 @@ config S390
 	def_bool y
 	select ARCH_BINFMT_ELF_STATE
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
+	select ARCH_HAS_DMA_OVERRIDE_GFP_FLAGS
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
diff --git a/arch/s390/include/asm/cio.h b/arch/s390/include/asm/cio.h
index b5bfb3123cb1..32041ec48170 100644
--- a/arch/s390/include/asm/cio.h
+++ b/arch/s390/include/asm/cio.h
@@ -364,10 +364,11 @@ extern void cio_dma_free(void *cpu_addr, size_t size);
 extern struct device *cio_get_dma_css_dev(void);
 
 void *cio_gp_dma_zalloc(struct gen_pool *gp_dma, struct device *dma_dev,
-			size_t size);
+			size_t size, gfp_t flags);
 void cio_gp_dma_free(struct gen_pool *gp_dma, void *cpu_addr, size_t size);
 void cio_gp_dma_destroy(struct gen_pool *gp_dma, struct device *dma_dev);
-struct gen_pool *cio_gp_dma_create(struct device *dma_dev, int nr_pages);
+struct gen_pool *cio_gp_dma_create(struct device *dma_dev, int nr_pages,
+				   gfp_t flags);
 
 /* Function from drivers/s390/cio/chsc.c */
 int chsc_sstpc(void *page, unsigned int op, u16 ctrl, u64 *clock_delta);
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index a124f19f7b3c..757e2cc60a1a 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -161,6 +161,26 @@ bool force_dma_unencrypted(struct device *dev)
 	return is_prot_virt_guest();
 }
 
+
+gfp_t dma_override_gfp_flags(struct device *dev, gfp_t flags)
+{
+	gfp_t  taboo_mask;
+	const char *taboo_msg;
+
+	if (dma_is_direct(dev->dma_ops)) {
+		/* cio: we have to mix in some allocations from ZONE_DMA */
+		taboo_mask = __GFP_DMA32 | __GFP_HIGHMEM;
+		taboo_msg = "__GFP_DMA32, __GFP_HIGHMEM";
+	} else {
+		/* pci */
+		taboo_mask = __GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM;
+		taboo_msg = " __GFP_DMA, __GFP_DMA32, __GFP_HIGHMEM,";
+	}
+	dev_WARN_ONCE(dev, flags & taboo_mask,
+		      "fixme: don't dma_alloc with any of: %s\n", taboo_msg);
+	return flags & ~taboo_mask;
+}
+
 /* protected virtualization */
 static void pv_init(void)
 {
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index 22c55816100b..3115602384d7 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -231,7 +231,7 @@ struct subchannel *css_alloc_subchannel(struct subchannel_id schid,
 	 * The physical addresses of some the dma structures that can
 	 * belong to a subchannel need to fit 31 bit width (e.g. ccw).
 	 */
-	sch->dev.coherent_dma_mask = DMA_BIT_MASK(31);
+	sch->dev.coherent_dma_mask = DMA_BIT_MASK(64);
 	sch->dev.dma_mask = &sch->dev.coherent_dma_mask;
 	return sch;
 
@@ -1091,7 +1091,8 @@ struct device *cio_get_dma_css_dev(void)
 	return &channel_subsystems[0]->device;
 }
 
-struct gen_pool *cio_gp_dma_create(struct device *dma_dev, int nr_pages)
+struct gen_pool *cio_gp_dma_create(struct device *dma_dev,
+				   int nr_pages, gfp_t flags)
 {
 	struct gen_pool *gp_dma;
 	void *cpu_addr;
@@ -1103,7 +1104,7 @@ struct gen_pool *cio_gp_dma_create(struct device *dma_dev, int nr_pages)
 		return NULL;
 	for (i = 0; i < nr_pages; ++i) {
 		cpu_addr = dma_alloc_coherent(dma_dev, PAGE_SIZE, &dma_addr,
-					      CIO_DMA_GFP);
+					      flags);
 		if (!cpu_addr)
 			return gp_dma;
 		gen_pool_add_virt(gp_dma, (unsigned long) cpu_addr,
@@ -1134,14 +1135,14 @@ void cio_gp_dma_destroy(struct gen_pool *gp_dma, struct device *dma_dev)
 static int cio_dma_pool_init(void)
 {
 	/* No need to free up the resources: compiled in */
-	cio_dma_pool = cio_gp_dma_create(cio_get_dma_css_dev(), 1);
+	cio_dma_pool = cio_gp_dma_create(cio_get_dma_css_dev(), 1, CIO_DMA_GFP);
 	if (!cio_dma_pool)
 		return -ENOMEM;
 	return 0;
 }
 
 void *cio_gp_dma_zalloc(struct gen_pool *gp_dma, struct device *dma_dev,
-			size_t size)
+			size_t size, gfp_t flags)
 {
 	dma_addr_t dma_addr;
 	unsigned long addr;
@@ -1153,7 +1154,7 @@ void *cio_gp_dma_zalloc(struct gen_pool *gp_dma, struct device *dma_dev,
 	while (!addr) {
 		chunk_size = round_up(size, PAGE_SIZE);
 		addr = (unsigned long) dma_alloc_coherent(dma_dev,
-					 chunk_size, &dma_addr, CIO_DMA_GFP);
+					 chunk_size, &dma_addr, flags);
 		if (!addr)
 			return NULL;
 		gen_pool_add_virt(gp_dma, addr, dma_addr, chunk_size, -1);
@@ -1179,7 +1180,8 @@ void cio_gp_dma_free(struct gen_pool *gp_dma, void *cpu_addr, size_t size)
  */
 void *cio_dma_zalloc(size_t size)
 {
-	return cio_gp_dma_zalloc(cio_dma_pool, cio_get_dma_css_dev(), size);
+	return cio_gp_dma_zalloc(cio_dma_pool, cio_get_dma_css_dev(),
+				 size, CIO_DMA_GFP);
 }
 
 void cio_dma_free(void *cpu_addr, size_t size)
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 131430bd48d9..7726e9c4d719 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -711,12 +711,13 @@ static struct ccw_device * io_subchannel_allocate_dev(struct subchannel *sch)
 		goto err_priv;
 	cdev->dev.coherent_dma_mask = sch->dev.coherent_dma_mask;
 	cdev->dev.dma_mask = &cdev->dev.coherent_dma_mask;
-	dma_pool = cio_gp_dma_create(&cdev->dev, 1);
+	dma_pool = cio_gp_dma_create(&cdev->dev, 1, GFP_KERNEL | GFP_DMA);
 	if (!dma_pool)
 		goto err_dma_pool;
 	cdev->private->dma_pool = dma_pool;
 	cdev->private->dma_area = cio_gp_dma_zalloc(dma_pool, &cdev->dev,
-					sizeof(*cdev->private->dma_area));
+					sizeof(*cdev->private->dma_area),
+					GFP_KERNEL | GFP_DMA);
 	if (!cdev->private->dma_area)
 		goto err_dma_area;
 	return cdev;
diff --git a/drivers/s390/cio/device_ops.c b/drivers/s390/cio/device_ops.c
index d722458c5928..57dcb6175b71 100644
--- a/drivers/s390/cio/device_ops.c
+++ b/drivers/s390/cio/device_ops.c
@@ -706,7 +706,8 @@ EXPORT_SYMBOL_GPL(ccw_device_get_schid);
  */
 void *ccw_device_dma_zalloc(struct ccw_device *cdev, size_t size)
 {
-	return cio_gp_dma_zalloc(cdev->private->dma_pool, &cdev->dev, size);
+	return cio_gp_dma_zalloc(cdev->private->dma_pool, &cdev->dev, size,
+				 GFP_KERNEL | GFP_DMA);
 }
 EXPORT_SYMBOL(ccw_device_dma_zalloc);
 
-- 
2.17.1
