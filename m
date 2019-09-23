Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5896 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2394320AbfIWMfK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Sep 2019 08:35:10 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8NCRXow140049
        for <linux-s390@vger.kernel.org>; Mon, 23 Sep 2019 08:35:08 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v6wxagk0v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 23 Sep 2019 08:35:07 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Mon, 23 Sep 2019 13:35:05 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: [RFC PATCH 0/3] fix dma_mask for CCW devices 
Date: Mon, 23 Sep 2019 14:34:15 +0200
Message-Id: <20190923123418.22695-1-pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org

Commit 37db8985b211 ("s390/cio: add basic protected virtualization
support") breaks virtio-ccw devices with VIRTIO_F_IOMMU_PLATFORM for non
Protected Virtualization (PV) guests. The problem is that the dma_mask
of the CCW device, which is used by virtio core, gets changed from 64 to
31 bit. This is done because some of the DMA allocations do require 31
bit addressable memory, but it has unfavorable side effects. 

For PV the only drawback is that some of the virtio structures must end
up in ZONE_DMA (with PV we have the bounce the buffers mapped via DMA
API anyway).

But for non PV guests we have a problem: because of the 31 bit mask
guests bigger than 2G are likely to try bouncing buffers. The swiotlb
however is only initialized for PV guests (because we don't want to
bounce anything for non PV guests). The first map of a buffer with
an address beyond 0x7fffffff kills the guest.

This series sets out to fix this problem by first making the GPF_DMA
flag count for DMA API allocations -- on s390 at least.  Then we set
dma_mask to 64 bit and do the allocations for the memory that needs to
be 31 bit addressable with the GPF_DMA flag.

For CCW devices we could probably just not clear any GFP flags at
all but, I decided to be conservative and change only what really needs
to be changed.

I'm not perfectly satisfied with this solution, but I believe it is good
enough, and I can't think of anything better at the moment. Ideas
welcome.

Halil Pasic (3):
  dma-mapping: make overriding GFP_* flags arch customizable
  s390/virtio: fix virtio-ccw DMA without PV
  dma-mapping: warn on harmful GFP_* flags

 arch/s390/Kconfig             |  1 +
 arch/s390/include/asm/cio.h   |  5 +++--
 arch/s390/mm/init.c           | 20 ++++++++++++++++++++
 drivers/s390/cio/css.c        | 16 +++++++++-------
 drivers/s390/cio/device.c     |  5 +++--
 drivers/s390/cio/device_ops.c |  3 ++-
 include/linux/dma-mapping.h   | 13 +++++++++++++
 kernel/dma/Kconfig            |  6 ++++++
 kernel/dma/mapping.c          |  4 +---
 9 files changed, 58 insertions(+), 15 deletions(-)

-- 
2.17.1
