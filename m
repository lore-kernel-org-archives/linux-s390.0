Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728523AbgBTQIC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 20 Feb 2020 11:08:02 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01KFxfPZ025924
        for <linux-s390@vger.kernel.org>; Thu, 20 Feb 2020 11:08:01 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y93kg66ac-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 20 Feb 2020 11:08:01 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Thu, 20 Feb 2020 16:07:59 -0000
From: Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH 1/2] mm: move force_dma_unencrypted() to mem_encrypt.h
Date: Thu, 20 Feb 2020 17:06:05 +0100
In-Reply-To: <20200220160606.53156-1-pasic@linux.ibm.com>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
Message-Id: <20200220160606.53156-2-pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Michael Mueller <mimu@linux.ibm.com>

Currently force_dma_unencrypted() is only used by the direct
implementation of the DMA API, and thus resides in dma-direct.h. But
there is nothing dma-direct specific about it: if one was -- for
whatever reason -- to implement custom DMA ops that have to in the
encrypted/protected scenarios dma-direct currently deals with, one would
need exactly this kind of information.

More importantly, virtio has to use DMA API (so that the memory
encryption (x86) or protection (power, s390) is handled) under the very
same circumstances force_dma_unencrypted() returns true. Furthermore,
the in these cases the reason to go via the DMA API is distinct,
compared to the reason indicated by VIRTIO_F_IOMMU_PLATFORM: we need to
use DMA API independently of the device's properties with regards to
access to memory. I.e. the addresses in the descriptors are still guest
physical addresses, the device may still be implemented by a SMP CPU,
and thus the device shall use those without any further translation. See
[1].

Let's move force_dma_unencrypted() the so virtio, or other
implementations of DMA ops can make the right decisions.

[1] https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x1-4100006
(In the spec VIRTIO_F_IOMMU_PLATFORM is called
VIRTIO_F_ACCESS_PLATFORM).

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Tested-by: Ram Pai <linuxram@us.ibm.com>
Tested-by: Michael Mueller <mimu@linux.ibm.com>
---
 include/linux/dma-direct.h  |  9 ---------
 include/linux/mem_encrypt.h | 10 ++++++++++
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 24b8684aa21d..590b15d881b0 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -26,15 +26,6 @@ static inline phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dev_addr)
 }
 #endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */
 
-#ifdef CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED
-bool force_dma_unencrypted(struct device *dev);
-#else
-static inline bool force_dma_unencrypted(struct device *dev)
-{
-	return false;
-}
-#endif /* CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED */
-
 /*
  * If memory encryption is supported, phys_to_dma will set the memory encryption
  * bit in the DMA address, and dma_to_phys will clear it.  The raw __phys_to_dma
diff --git a/include/linux/mem_encrypt.h b/include/linux/mem_encrypt.h
index 5c4a18a91f89..64a48c4b01a2 100644
--- a/include/linux/mem_encrypt.h
+++ b/include/linux/mem_encrypt.h
@@ -22,6 +22,16 @@ static inline bool mem_encrypt_active(void) { return false; }
 
 #endif	/* CONFIG_ARCH_HAS_MEM_ENCRYPT */
 
+struct device;
+#ifdef CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED
+bool force_dma_unencrypted(struct device *dev);
+#else
+static inline bool force_dma_unencrypted(struct device *dev)
+{
+	return false;
+}
+#endif /* CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED */
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 /*
  * The __sme_set() and __sme_clr() macros are useful for adding or removing
-- 
2.17.1
