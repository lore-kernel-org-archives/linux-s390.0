Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19200 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728285AbgFOMje (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 15 Jun 2020 08:39:34 -0400
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v2 0/1] s390: virtio: let's arch choose to accept devices without IOMMU feature
Date: Mon, 15 Jun 2020 14:39:23 +0200
Message-Id: <1592224764-1258-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org

An architecture protecting the guest memory against unauthorized host
access may want to enforce VIRTIO I/O device protection through the
use of VIRTIO_F_IOMMU_PLATFORM.

Let's give a chance to the architecture to accept or not devices
without VIRTIO_F_IOMMU_PLATFORM.

Pierre Morel (1):
  s390: virtio: let arch accept devices without IOMMU feature

 arch/s390/mm/init.c     | 6 ++++++
 drivers/virtio/virtio.c | 9 +++++++++
 include/linux/virtio.h  | 2 ++
 3 files changed, 17 insertions(+)

-- 
2.25.1

Changelog to v2:

- put the test in virtio_finalize_features()
  (Connie)

- put the test inside VIRTIO core
  (Jason)

- pass a virtio device as parameter
  (Halil)
