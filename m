Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:65215 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfH1P5U (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Aug 2019 11:57:20 -0400
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 0/1] vfio-ccw patch for next release
Date: Wed, 28 Aug 2019 17:57:15 +0200
Message-Id: <20190828155716.22809-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>

The following changes since commit 416f79c23dbe47e0e223efc06d3487e1d90a92ee:

  s390/paes: Prepare paes functions for large key blobs (2019-08-21 12:58:54 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20190828

for you to fetch changes up to 60e05d1cf0875f0cf73472f7dff71d9933c5b697:

  vfio-ccw: add some logging (2019-08-23 12:53:32 +0200)

----------------------------------------------------------------
Add some logging into the s390dbf.

----------------------------------------------------------------

Cornelia Huck (1):
  vfio-ccw: add some logging

 drivers/s390/cio/vfio_ccw_drv.c     | 50 ++++++++++++++++++++++++++--
 drivers/s390/cio/vfio_ccw_fsm.c     | 51 ++++++++++++++++++++++++++++-
 drivers/s390/cio/vfio_ccw_ops.c     | 10 ++++++
 drivers/s390/cio/vfio_ccw_private.h | 17 ++++++++++
 4 files changed, 124 insertions(+), 4 deletions(-)

-- 
2.20.1
