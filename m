Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60986 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389367AbgEYJl0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 25 May 2020 05:41:26 -0400
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 00/10] vfio-ccw patches for 5.8
Date: Mon, 25 May 2020 11:41:05 +0200
Message-Id: <20200525094115.222299-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>

The following changes since commit 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c:

  Linux 5.7-rc3 (2020-04-26 13:51:02 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw tags/vfio-ccw-20200525

for you to fetch changes up to 40b4240eed2f2de57775b996a0b38d412e570086:

  vfio-ccw: Add trace for CRW event (2020-05-18 11:46:33 +0200)

----------------------------------------------------------------
vfio-ccw updates:
- accept requests without the prefetch bit set
- enable path handling via two new regions

----------------------------------------------------------------
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

 Documentation/s390/vfio-ccw.rst     |  99 +++++++++++++++++++++-
 drivers/s390/cio/Makefile           |   2 +-
 drivers/s390/cio/vfio_ccw_chp.c     | 148 ++++++++++++++++++++++++++++++++
 drivers/s390/cio/vfio_ccw_cp.c      |  19 +++--
 drivers/s390/cio/vfio_ccw_drv.c     | 165 +++++++++++++++++++++++++++++++++---
 drivers/s390/cio/vfio_ccw_ops.c     |  65 ++++++++++----
 drivers/s390/cio/vfio_ccw_private.h |  16 ++++
 drivers/s390/cio/vfio_ccw_trace.c   |   1 +
 drivers/s390/cio/vfio_ccw_trace.h   |  30 +++++++
 include/uapi/linux/vfio.h           |   3 +
 include/uapi/linux/vfio_ccw.h       |  18 ++++
 11 files changed, 529 insertions(+), 37 deletions(-)
 create mode 100644 drivers/s390/cio/vfio_ccw_chp.c

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

 Documentation/s390/vfio-ccw.rst     |  99 ++++++++++++++++-
 drivers/s390/cio/Makefile           |   2 +-
 drivers/s390/cio/vfio_ccw_chp.c     | 148 +++++++++++++++++++++++++
 drivers/s390/cio/vfio_ccw_cp.c      |  19 ++--
 drivers/s390/cio/vfio_ccw_drv.c     | 165 ++++++++++++++++++++++++++--
 drivers/s390/cio/vfio_ccw_ops.c     |  65 ++++++++---
 drivers/s390/cio/vfio_ccw_private.h |  16 +++
 drivers/s390/cio/vfio_ccw_trace.c   |   1 +
 drivers/s390/cio/vfio_ccw_trace.h   |  30 +++++
 include/uapi/linux/vfio.h           |   3 +
 include/uapi/linux/vfio_ccw.h       |  18 +++
 11 files changed, 529 insertions(+), 37 deletions(-)
 create mode 100644 drivers/s390/cio/vfio_ccw_chp.c

-- 
2.25.4
