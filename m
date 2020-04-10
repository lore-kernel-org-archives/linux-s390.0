Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10916 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725912AbgDJKkp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 10 Apr 2020 06:40:45 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03AAcIei095030
        for <linux-s390@vger.kernel.org>; Fri, 10 Apr 2020 06:40:44 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30920awn8a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 Apr 2020 06:40:44 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Fri, 10 Apr 2020 11:40:21 +0100
Date: Fri, 10 Apr 2020 12:40:36 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [GIT PULL] s390 patches for the 5.7 merge window #2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Message-Id: <your-ad-here.call-01586515236-ext-7662@work.hours>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Hello Linus,

please pull the second round of s390 fixes and features for 5.7.

Thank you,
Vasily

The following changes since commit ad0bf4eb91c2f9b93479b679e5472094ddb76da8:

  Merge tag 's390-5.7-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2020-04-04 09:45:50 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux tags/s390-5.7-2

for you to fetch changes up to 2bc55eaeb88d30accfc1b6ac2708d4e4b81ca260:

  s390/cio: generate delayed uevent for vfio-ccw subchannels (2020-04-06 14:02:28 +0200)

----------------------------------------------------------------
s390 updates for the 5.7 merge window #2

- The rest of fallthrough; annotations conversion.

- Couple of fixes for ADD uevents in the common I/O layer.

- Minor refactoring of the queued direct I/O code.

----------------------------------------------------------------
Cornelia Huck (2):
      s390/cio: avoid duplicated 'ADD' uevents
      s390/cio: generate delayed uevent for vfio-ccw subchannels

Joe Perches (1):
      s390/mm: use fallthrough;

Julian Wiedmann (6):
      s390/qdio: cleanly split alloc and establish
      zfcp: inline zfcp_qdio_setup_init_data()
      s390/qdio: allow for non-contiguous SBAL array in init_data
      s390/qdio: remove cdev from init_data
      s390/qdio: inline shared_ind()
      s390/qdio: clear DSCI early for polling drivers

 arch/s390/include/asm/qdio.h      | 16 +++++-----
 arch/s390/mm/fault.c              |  2 --
 drivers/s390/cio/device.c         | 13 +++++---
 drivers/s390/cio/qdio.h           |  1 -
 drivers/s390/cio/qdio_debug.c     | 16 +---------
 drivers/s390/cio/qdio_debug.h     |  3 +-
 drivers/s390/cio/qdio_main.c      | 63 +++++++++++++++++++++++++------------
 drivers/s390/cio/qdio_setup.c     | 10 +++---
 drivers/s390/cio/qdio_thinint.c   | 28 ++---------------
 drivers/s390/cio/vfio_ccw_drv.c   |  5 +++
 drivers/s390/net/qeth_core.h      |  5 +--
 drivers/s390/net/qeth_core_main.c | 65 ++++++++-------------------------------
 drivers/s390/scsi/zfcp_qdio.c     | 51 +++++++++++++-----------------
 13 files changed, 110 insertions(+), 168 deletions(-)
