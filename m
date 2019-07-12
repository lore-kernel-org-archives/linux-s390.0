Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726449AbfGLOjn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 12 Jul 2019 10:39:43 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6CEc7lS130561
        for <linux-s390@vger.kernel.org>; Fri, 12 Jul 2019 10:39:41 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tpu5v2r48-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 12 Jul 2019 10:39:41 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Fri, 12 Jul 2019 15:39:39 +0100
Date: Fri, 12 Jul 2019 16:39:34 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [GIT PULL] s390 patches for the 5.3 merge window #2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Message-Id: <your-ad-here.call-01562942374-ext-9116@work.hours>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Hello Linus,

please pull the second round of s390 fixes and features for 5.3.

Thank you,
Vasily

The following changes since commit 1758feddb0f9751debdc865fefde94b45907c948:

  Merge tag 's390-5.3-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2019-07-08 10:06:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.3-2

for you to fetch changes up to 9a159190414d461fdac7ae5bb749c2d532b35419:

  s390/unwind: avoid int overflow in outside_of_stack (2019-07-11 20:40:02 +0200)

----------------------------------------------------------------
s390 updates for the 5.3 merge window #2

 - Fix integer overflow during stack frame unwind with invalid backchain.

 - Cleanup unused symbol export in zcrypt code.

 - Fix MIO addressing control activation in PCI code and expose its
   usage via sysfs.

 - Fix kernel image signature verification report presence detection.

 - Fix irq registration in vfio-ap code.

 - Add CPU measurement counters for newer machines.

 - Add base DASD thin provisioning support and code cleanups.

----------------------------------------------------------------
Christian Borntraeger (1):
      s390: vfio-ap: fix irq registration

Denis Efremov (1):
      s390/zcrypt: remove the exporting of ap_query_configuration

Jan Höppner (14):
      s390/dasd: Remove unused structs and function prototypes
      s390/dasd: Remove old defines and function
      s390/dasd: Make layout analysis ESE compatible
      s390/dasd: Put sub-order definitions in a separate section
      s390/dasd: Recognise data for ESE volumes
      s390/dasd: Add dynamic formatting support for ESE volumes
      s390/dasd: Fix whitespace
      s390/dasd: Add missing intensity definition
      s390/dasd: Add dasd_sleep_on_queue_interruptible()
      s390/dasd: Add new ioctl to release space
      s390/dasd: Make dasd_setup_queue() a discipline function
      s390/dasd: Use ALIGN_DOWN macro
      s390/dasd: Add discard support for ESE volumes
      s390/dasd: Handle out-of-space constraint

Philipp Rudo (1):
      s390/ipl: Fix detection of has_secure attribute

Sebastian Ott (2):
      s390: fix setting of mio addressing control
      s390/pci: add mio_enabled attribute

Thomas Richter (1):
      s390/cpumf: Add extended counter set definitions for model 8561 and 8562

Vasily Gorbik (1):
      s390/unwind: avoid int overflow in outside_of_stack

 arch/s390/include/asm/pci_insn.h       |  10 -
 arch/s390/include/asm/sclp.h           |   1 -
 arch/s390/include/uapi/asm/dasd.h      | 154 +++---
 arch/s390/kernel/early.c               |   2 -
 arch/s390/kernel/ipl.c                 |   7 +-
 arch/s390/kernel/perf_cpum_cf_events.c |   2 +
 arch/s390/kernel/unwind_bc.c           |   2 +-
 arch/s390/pci/pci.c                    |   4 +-
 arch/s390/pci/pci_sysfs.c              |  10 +
 drivers/s390/block/dasd.c              | 233 ++++++--
 drivers/s390/block/dasd_devmap.c       |  70 ++-
 drivers/s390/block/dasd_diag.c         |  22 +-
 drivers/s390/block/dasd_eckd.c         | 966 +++++++++++++++++++++++++++++++--
 drivers/s390/block/dasd_eckd.h         | 175 +++++-
 drivers/s390/block/dasd_eer.c          |   1 +
 drivers/s390/block/dasd_fba.c          |  45 +-
 drivers/s390/block/dasd_fba.h          |   5 +
 drivers/s390/block/dasd_int.h          |  33 +-
 drivers/s390/block/dasd_ioctl.c        |  56 ++
 drivers/s390/char/sclp_early.c         |   1 -
 drivers/s390/crypto/ap_bus.c           |   1 -
 drivers/s390/crypto/vfio_ap_ops.c      |   3 +-
 22 files changed, 1547 insertions(+), 256 deletions(-)
