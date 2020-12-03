Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62368 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728252AbgLCVgF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Dec 2020 16:36:05 -0500
From: Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v3 0/2] Connect request callback to mdev and vfio-ccw
Date: Thu,  3 Dec 2020 22:35:10 +0100
Message-Id: <20201203213512.49357-1-farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Kirti Wankhede <kwankhede@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>

Alex,

As promised, here is a v3 with a message indicating a request is blocked
until a user releases the device in question and a corresponding tweak to
the commit message describing this change (and Conny's r-b). The remainder
of the patches are otherwise identical.

v2      : https://lore.kernel.org/kvm/20201120180740.87837-1-farman@linux.ibm.com/
v1(RFC) : https://lore.kernel.org/kvm/20201117032139.50988-1-farman@linux.ibm.com/

Eric Farman (2):
  vfio-mdev: Wire in a request handler for mdev parent
  vfio-ccw: Wire in the request callback

 drivers/s390/cio/vfio_ccw_ops.c     | 26 ++++++++++++++++++++++++++
 drivers/s390/cio/vfio_ccw_private.h |  4 ++++
 drivers/vfio/mdev/mdev_core.c       |  4 ++++
 drivers/vfio/mdev/vfio_mdev.c       | 13 +++++++++++++
 include/linux/mdev.h                |  4 ++++
 include/uapi/linux/vfio.h           |  1 +
 6 files changed, 52 insertions(+)

-- 
2.17.1
