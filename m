Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64472 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729673AbgBMMhz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 13 Feb 2020 07:37:55 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01DCZi0J035446
        for <linux-s390@vger.kernel.org>; Thu, 13 Feb 2020 07:37:54 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y3yw977su-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 13 Feb 2020 07:37:54 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Thu, 13 Feb 2020 12:37:51 -0000
From: Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH 0/2] virtio-blk: improve handling of DMA mapping failures
Date: Thu, 13 Feb 2020 13:37:26 +0100
Message-Id: <20200213123728.61216-1-pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>

Two patches are handling new edge cases introduced by doing DMA mappings
(which can fail) in virtio core.

I stumbled upon this while stress testing I/O for Protected Virtual
Machines. I deliberately chose a tiny swiotlb size and have generated
load with fio. With more than one virtio-blk disk in use I experienced
hangs.

The goal of this series is to fix those hangs.

Halil Pasic (2):
  virtio-blk: fix hw_queue stopped on arbitrary error
  virtio-blk: improve virtqueue error to BLK_STS

 drivers/block/virtio_blk.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)


base-commit: 39bed42de2e7d74686a2d5a45638d6a5d7e7d473
-- 
2.17.1
