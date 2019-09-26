Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725813AbfIZO6o (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 26 Sep 2019 10:58:44 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8QEqR95118380
        for <linux-s390@vger.kernel.org>; Thu, 26 Sep 2019 10:58:43 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v8x0dn8kq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 26 Sep 2019 10:58:43 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Thu, 26 Sep 2019 15:58:41 +0100
Date: Thu, 26 Sep 2019 16:58:34 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [GIT PULL] s390 patches for the 5.4 merge window #2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Message-Id: <your-ad-here.call-01569509914-ext-6285@work.hours>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Hello Linus,

please pull the second round of s390 fixes and features for 5.4.

Thank you,
Vasily

The following changes since commit d590284419b1d7cc2dc646e9bdde4da19061cf0f:

  Merge tag 's390-5.4-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2019-09-17 14:04:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.4-2

for you to fetch changes up to ab5758848039de9a4b249d46e4ab591197eebaf2:

  s390/cio: exclude subchannels with no parent from pseudo check (2019-09-23 23:27:53 +0200)

----------------------------------------------------------------
s390 updates for the 5.4 merge window #2

 - Fix 3 kasan findings.

 - Add PERF_EVENT_IOC_PERIOD ioctl support.

 - Add Crypto Express7S support and extend sysfs attributes for pkey.

 - Minor common I/O layer documentation corrections.

----------------------------------------------------------------
Cornelia Huck (1):
      s390/cio: fix intparm documentation

Harald Freudenberger (1):
      s390/zcrypt: CEX7S exploitation support

Ingo Franzki (1):
      s390/pkey: Add sysfs attributes to emit AES CIPHER key blobs

Thomas Richter (2):
      s390/cpum_sf: Support ioctl PERF_EVENT_IOC_PERIOD
      s390/cpumf: Remove mixed white space

Vasily Gorbik (3):
      s390/topology: avoid firing events before kobjs are created
      s390/cio: avoid calling strlen on null pointer
      s390/cio: exclude subchannels with no parent from pseudo check

 arch/s390/include/asm/cpu_mf.h      |  10 +--
 arch/s390/include/asm/perf_event.h  |   2 +
 arch/s390/include/uapi/asm/zcrypt.h |   4 +-
 arch/s390/kernel/perf_cpum_sf.c     | 165 +++++++++++++++++++++++++++---------
 arch/s390/kernel/topology.c         |   3 +-
 drivers/s390/cio/ccwgroup.c         |   2 +-
 drivers/s390/cio/css.c              |   2 +
 drivers/s390/cio/device_ops.c       |  23 +++--
 drivers/s390/crypto/ap_bus.c        |  12 +--
 drivers/s390/crypto/ap_bus.h        |   3 +-
 drivers/s390/crypto/pkey_api.c      | 113 ++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_drv.c   |   2 +
 drivers/s390/crypto/zcrypt_api.h    |   3 +-
 drivers/s390/crypto/zcrypt_cex4.c   |  72 +++++++++++-----
 14 files changed, 334 insertions(+), 82 deletions(-)
