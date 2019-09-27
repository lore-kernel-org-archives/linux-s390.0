Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34308 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727463AbfI0AdY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 26 Sep 2019 20:33:24 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8R0WlWB001535
        for <linux-s390@vger.kernel.org>; Thu, 26 Sep 2019 20:33:23 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v93dc7mde-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 26 Sep 2019 20:33:22 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 27 Sep 2019 01:33:21 +0100
Date: Fri, 27 Sep 2019 02:33:14 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 1/3] dma-mapping: make overriding GFP_* flags arch
 customizable
In-Reply-To: <6c62da57-c94c-8078-957c-b6832ed7fd1b@arm.com>
References: <20190923123418.22695-1-pasic@linux.ibm.com>
 <20190923123418.22695-2-pasic@linux.ibm.com>
 <20190923152117.GA2767@lst.de>
 <20190926143745.68bdd082.pasic@linux.ibm.com>
 <6c62da57-c94c-8078-957c-b6832ed7fd1b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20190927023314.3e5c8324.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, iommu@lists.linux-foundation.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>

On Thu, 26 Sep 2019 14:04:13 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> On 26/09/2019 13:37, Halil Pasic wrote:
> > On Mon, 23 Sep 2019 17:21:17 +0200
> > Christoph Hellwig <hch@lst.de> wrote:
> > 
> >> On Mon, Sep 23, 2019 at 02:34:16PM +0200, Halil Pasic wrote:
> >>> Before commit 57bf5a8963f8 ("dma-mapping: clear harmful GFP_* flags in
> >>> common code") tweaking the client code supplied GFP_* flags used to be
> >>> an issue handled in the architecture specific code. The commit message
> >>> suggests, that fixing the client code would actually be a better way
> >>> of dealing with this.
> >>>
> >>> On s390 common I/O devices are generally capable of using the full 64
> >>> bit address space for DMA I/O, but some chunks of the DMA memory need to
> >>> be 31 bit addressable (in physical address space) because the
> >>> instructions involved mandate it. Before switching to DMA API this used
> >>> to be a non-issue, we used to allocate those chunks from ZONE_DMA.
> >>> Currently our only option with the DMA API is to restrict the devices to
> >>> (via dma_mask and coherent_dma_mask) to 31 bit, which is sub-optimal.
> >>>
> >>> Thus s390 we would benefit form having control over what flags are
> >>> dropped.
> >>
> >> No way, sorry.  You need to express that using a dma mask instead of
> >> overloading the GFP flags.
> > 
> > Thanks for your feedback and sorry for the delay. Can you help me figure
> > out how can I express that using a dma mask?
> > 
> > IMHO what you ask from me is frankly impossible.
> > 
> > What I need is the ability to ask for  (considering the physical
> > address) 31 bit addressable DMA memory if the chunk is supposed to host
> > control-type data that needs to be 31 bit addressable because that is
> > how the architecture is, without affecting the normal data-path. So
> > normally 64 bit mask is fine but occasionally (control) we would need
> > a 31 bit mask.
> 
> If it's possible to rework the "data" path to use streaming mappings 
> instead of coherent allocations, you could potentially mimic what virtio 
> does for a similar situation - see commit a0be1db4304f.
> 

Thank you for your feedback. Just to be sure we are on the same pager, I
read commit a0be1db4304f like this:
1) virtio_pci_legacy needs to allocate the virtqueues so that the base
address fits 44 bits
2) if 64 bit dma is possible they set coherent_dma_mask to
  DMA_BIT_MASK(44) and dma_mask to DMA_BIT_MASK(64)
3) since the queues get allocated with coherent allocations 1) is
satisfied
4) when the streaming mappings see a buffer that is beyond
  DMA_BIT_MASK(44) then it has to treat it as not coherent memory
  and do the syncing magic (which isn't actually required, just
  a side effect of the workaround.

I'm actually trying to get virtio_ccw working nice with Protected
Virtualization (best think of encrypted memory). So the "data" path
is mostly the same as for virtio_pci.

But unlike virtio_pci_legacy we are perfectly fine with virtqueues at
an arbitrary address.

We can make
coherent_dma_mask == DMA_BIT_MASK(31) != dma_mask == DMA_BIT_MASK(64)
but that affects all dma coherent allocations and needlessly force
the virtio control structures into the  [0..2G] range. Furthermore this
whole issue has nothing to do with memory coherence. For ccw devices
memory at addresses above 2G is no less coherent for ccw devices than
memory at addresses below 2G.

I've already implemented a patch (see after the scissors line) that
takes a similar route as commit a0be1db4304f, but I consider that a
workaround at best. But if that is what the community wants... I have to
get the job done one way or the other.

Many thanks for your help and your time.

-------------------------------8<------------------------------------

From: Halil Pasic <pasic@linux.ibm.com>
Date: Thu, 25 Jul 2019 18:44:21 +0200
Subject: [PATCH 1/1] s390/cio: fix virtio-ccw DMA without PV

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

Since the DMA API won't allow us to specify for each allocating whether
we need memory from ZONE_DMA (31 bit addressable) or any DMA capable
memory will do, let us abuse coherent_dma_mask (which is used for
allocations) to force allocating form ZONE_DMA while changing dma_mask
to DMA_BIT_MASK(64).

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Fixes: 37db8985b211 ("s390/cio: add basic protected virtualization support")
---
 drivers/s390/cio/cio.h    | 1 +
 drivers/s390/cio/css.c    | 8 +++++++-
 drivers/s390/cio/device.c | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/cio.h b/drivers/s390/cio/cio.h
index ba7d248..dcdaba6 100644
--- a/drivers/s390/cio/cio.h
+++ b/drivers/s390/cio/cio.h
@@ -113,6 +113,7 @@ struct subchannel {
 	enum sch_todo todo;
 	struct work_struct todo_work;
 	struct schib_config config;
+	u64 dma_mask;
 	char *driver_override; /* Driver name to force a match */
 } __attribute__ ((aligned(8)));
 
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index 22c5581..d63e80a 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -232,7 +232,13 @@ struct subchannel *css_alloc_subchannel(struct subchannel_id schid,
 	 * belong to a subchannel need to fit 31 bit width (e.g. ccw).
 	 */
 	sch->dev.coherent_dma_mask = DMA_BIT_MASK(31);
-	sch->dev.dma_mask = &sch->dev.coherent_dma_mask;
+	/*
+	 * But we don't have such restrictions imposed on the stuff that
+	 * is handled by the streaming API. Using coherent_dma_mask != dma_mask
+	 * is just a workaround.
+	 */
+	sch->dma_mask = DMA_BIT_MASK(64);
+	sch->dev.dma_mask = &sch->dma_mask;
 	return sch;
 
 err:
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 131430b..0c6245f 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -710,7 +710,7 @@ static struct ccw_device * io_subchannel_allocate_dev(struct subchannel *sch)
 	if (!cdev->private)
 		goto err_priv;
 	cdev->dev.coherent_dma_mask = sch->dev.coherent_dma_mask;
-	cdev->dev.dma_mask = &cdev->dev.coherent_dma_mask;
+	cdev->dev.dma_mask = sch->dev.dma_mask;
 	dma_pool = cio_gp_dma_create(&cdev->dev, 1);
 	if (!dma_pool)
 		goto err_dma_pool;
-- 
2.5.5
