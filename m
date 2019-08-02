Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25324 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727024AbfHBOIS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 2 Aug 2019 10:08:18 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x72E7nTZ020930
        for <linux-s390@vger.kernel.org>; Fri, 2 Aug 2019 10:08:16 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u4p3r9nfj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 02 Aug 2019 10:08:16 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Fri, 2 Aug 2019 15:08:14 +0100
Date: Fri, 2 Aug 2019 16:08:08 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [GIT PULL] s390 updates for 5.3-rc3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Message-Id: <your-ad-here.call-01564754888-ext-1592@work.hours>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.3-rc3.

Thank you,
Vasily

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.3-4

for you to fetch changes up to 3cdd98606750a5a1d1c8bcda5b481cb86ed67b3b:

  s390/zcrypt: adjust switch fall through comments for -Wimplicit-fallthrough (2019-08-02 13:58:23 +0200)

----------------------------------------------------------------
s390 updates for 5.3-rc3

 - Default configs updates.

 - Minor qdio cleanup.

 - Sparse warnings fixes.

 - Implicit-fallthrough warnings fixes.

----------------------------------------------------------------
Heiko Carstens (3):
      s390: update configs
      s390/mm: add fallthrough annotations
      s390/tape: add fallthrough annotations

Julian Wiedmann (1):
      s390: clean up qdio.h

Vasily Gorbik (8):
      s390/boot: add missing declarations and includes
      s390/lib: add missing include
      s390/perf: make cf_diag_csd static
      s390/kexec: add missing include to machine_kexec_reloc.c
      s390/mm: make gmap_test_and_clear_dirty_pmd static
      s390/3215: add switch fall through comment for -Wimplicit-fallthrough
      vfio-ccw: make vfio_ccw_async_region_ops static
      s390/zcrypt: adjust switch fall through comments for -Wimplicit-fallthrough

 arch/s390/boot/boot.h                  |   1 +
 arch/s390/boot/kaslr.c                 |   1 +
 arch/s390/configs/debug_defconfig      | 330 ++++++++++++++++++++-------------
 arch/s390/configs/defconfig            | 233 ++++++++++++++---------
 arch/s390/configs/zfcpdump_defconfig   |  31 ++--
 arch/s390/include/asm/qdio.h           |  10 +-
 arch/s390/include/asm/setup.h          |   1 +
 arch/s390/kernel/machine_kexec_reloc.c |   1 +
 arch/s390/kernel/perf_cpum_cf_diag.c   |   2 +-
 arch/s390/lib/xor.c                    |   1 +
 arch/s390/mm/fault.c                   |   3 +
 arch/s390/mm/gmap.c                    |   4 +-
 drivers/s390/char/con3215.c            |   1 +
 drivers/s390/char/tape_core.c          |   3 +
 drivers/s390/cio/vfio_ccw_async.c      |   2 +-
 drivers/s390/crypto/ap_queue.c         |   1 +
 drivers/s390/crypto/zcrypt_msgtype6.c  |  17 +-
 17 files changed, 392 insertions(+), 250 deletions(-)
