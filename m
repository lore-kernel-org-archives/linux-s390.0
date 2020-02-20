Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is protected
Date: Thu, 20 Feb 2020 17:06:06 +0100
In-Reply-To: <20200220160606.53156-1-pasic@linux.ibm.com>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
Message-Id: <20200220160606.53156-3-pasic@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Michael Mueller <mimu@linux.ibm.com>

Currently the advanced guest memory protection technologies (AMD SEV,
powerpc secure guest technology and s390 Protected VMs) abuse the
VIRTIO_F_IOMMU_PLATFORM flag to make virtio core use the DMA API, which
is in turn necessary, to make IO work with guest memory protection.

But VIRTIO_F_IOMMU_PLATFORM a.k.a. VIRTIO_F_ACCESS_PLATFORM is really a
different beast: with virtio devices whose implementation runs on an SMP
CPU we are still fine with doing all the usual optimizations, it is just
that we need to make sure that the memory protection mechanism does not
get in the way. The VIRTIO_F_ACCESS_PLATFORM mandates more work on the
side of the guest (and possibly he host side as well) than we actually
need.

An additional benefit of teaching the guest to make the right decision
(and use DMA API) on it's own is: removing the need, to mandate special
VM configuration for guests that may run with protection. This is
especially interesting for s390 as VIRTIO_F_IOMMU_PLATFORM pushes all
the virtio control structures into the first 2G of guest memory:
something we don't necessarily want to do per-default.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Tested-by: Ram Pai <linuxram@us.ibm.com>
Tested-by: Michael Mueller <mimu@linux.ibm.com>
---
 drivers/virtio/virtio_ring.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 867c7ebd3f10..fafc8f924955 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -243,6 +243,9 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
 	if (!virtio_has_iommu_quirk(vdev))
 		return true;
 
+	if (force_dma_unencrypted(&vdev->dev))
+		return true;
+
 	/* Otherwise, we are left to guess. */
 	/*
 	 * In theory, it's possible to have a buggy QEMU-supposed
-- 
2.17.1
