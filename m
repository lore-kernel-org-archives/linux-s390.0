Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58530 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726083AbgFCL10 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 3 Jun 2020 07:27:26 -0400
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL v2 00/10] vfio-ccw patches for 5.8
Date: Wed,  3 Jun 2020 13:27:06 +0200
Message-Id: <20200603112716.332801-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>

The following changes since commit e1750a3d9abbea2ece29cac8dc5a6f5bc19c1492:

  s390/pci: Log new handle in clp_disable_fh() (2020-05-28 12:26:03 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw tags/vfio-ccw-20200603-v2

for you to fetch changes up to b2dd9a44a1098c96935c495570b663bd223a087e:

  vfio-ccw: Add trace for CRW event (2020-06-03 11:28:19 +0200)

----------------------------------------------------------------
vfio-ccw updates:
- accept requests without the prefetch bit set
- enable path handling via two new regions

----------------------------------------------------------------

Changes v1->v2:
- add padding to struct ccw_crw_region
- rebase to s390 features branch

Cornelia Huck (1):
  vfio-ccw: document possible errors

Eric Farman (3):
  vfio-ccw: Refactor the unregister of the async regions
  vfio-ccw: Refactor IRQ handlers
  vfio-ccw: Add trace for CRW event

Farhan Ali (5):
  vfio-ccw: Introduce new helper functions to free/destroy regions
  vfio-ccw: Register a chp_event callback for vfio-ccw
  vfio-ccw: Introduce a new schib region
  vfio-ccw: Introduce a new CRW region
  vfio-ccw: Wire up the CRW irq and CRW region

Jared Rossi (1):
  vfio-ccw: Enable transparent CCW IPL from DASD

 Documentation/s390/vfio-ccw.rst     | 100 ++++++++++++++++-
 drivers/s390/cio/Makefile           |   2 +-
 drivers/s390/cio/vfio_ccw_chp.c     | 148 +++++++++++++++++++++++++
 drivers/s390/cio/vfio_ccw_cp.c      |  19 ++--
 drivers/s390/cio/vfio_ccw_drv.c     | 165 ++++++++++++++++++++++++++--
 drivers/s390/cio/vfio_ccw_ops.c     |  65 ++++++++---
 drivers/s390/cio/vfio_ccw_private.h |  16 +++
 drivers/s390/cio/vfio_ccw_trace.c   |   1 +
 drivers/s390/cio/vfio_ccw_trace.h   |  30 +++++
 include/uapi/linux/vfio.h           |   3 +
 include/uapi/linux/vfio_ccw.h       |  19 ++++
 11 files changed, 531 insertions(+), 37 deletions(-)
 create mode 100644 drivers/s390/cio/vfio_ccw_chp.c

-- 
2.25.4
