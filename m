Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729955AbgHFRE5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 6 Aug 2020 13:04:57 -0400
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v1 0/1] s390: virtio-ccw: PV needs VIRTIO I/O device protection
Date: Thu,  6 Aug 2020 16:23:01 +0200
Message-Id: <1596723782-12798-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org

Hi all,

In another series I proposed to add an architecture specific
callback to fail feature negociation on architecture need.

In VIRTIO, we already have an entry to reject the features on the
transport basis.

Transport is not architecture so I send a separate series in which
we fail the feature negociation inside virtio_ccw_finalize_features,
the virtio_config_ops.finalize_features for S390 CCW transport,
when the device do not propose the VIRTIO_F_IOMMU_PLATFORM.

This solves the problem of crashing QEMU when this one is not using
a CCW device with iommu_platform=on in S390.

Regards,
Pierre

Regards,
Pierre

Pierre Morel (1):
  s390: virtio-ccw: PV needs VIRTIO I/O device protection

 drivers/s390/virtio/virtio_ccw.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

-- 
2.25.1
