Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57177 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726887AbfKKNu3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 11 Nov 2019 08:50:29 -0500
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 0/4] vfio-ccw updates
Date: Mon, 11 Nov 2019 14:50:15 +0100
Message-Id: <20191111135019.2394-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>

The following changes since commit 89d0180a60fcc5368eb2d92faeb1e012f8a591b3=
:

  s390/Kconfig: add z13s and z14 ZR1 to TUNE descriptions (2019-10-10 10:50=
:14 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags=
/vfio-ccw-20191111

for you to fetch changes up to 8529888070f15e7c784b1c93bad358bf1d08045f:

  vfio-ccw: Rework the io_fctl trace (2019-10-17 11:37:24 +0200)

----------------------------------------------------------------
enhance tracing in vfio-ccw

----------------------------------------------------------------

Eric Farman (4):
  vfio-ccw: Refactor how the traces are built
  vfio-ccw: Trace the FSM jumptable
  vfio-ccw: Add a trace for asynchronous requests
  vfio-ccw: Rework the io_fctl trace

 drivers/s390/cio/Makefile           |  4 +-
 drivers/s390/cio/vfio_ccw_cp.h      |  1 +
 drivers/s390/cio/vfio_ccw_fsm.c     | 11 +++--
 drivers/s390/cio/vfio_ccw_private.h |  1 +
 drivers/s390/cio/vfio_ccw_trace.c   | 14 ++++++
 drivers/s390/cio/vfio_ccw_trace.h   | 76 ++++++++++++++++++++++++++---
 6 files changed, 93 insertions(+), 14 deletions(-)
 create mode 100644 drivers/s390/cio/vfio_ccw_trace.c

--=20
2.21.0
