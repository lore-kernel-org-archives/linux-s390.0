Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54670 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727473AbgIOPnx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Sep 2020 11:43:53 -0400
From: Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 0/4] s390: set_fs() removal
Date: Tue, 15 Sep 2020 17:43:36 +0200
Message-Id: <20200915154340.4215-1-hca@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, linux-s390@vger.kernel.org

Hi Christoph,

as requested by you s390 specific set_fs() removal patches are
available here:

https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/log/?h=set_fs

See also this patch series. I'll ask Stephen to get the branch
included in linux-next. The above branch should not be considered
stable.. if something is broken fixes will be merged into the
corresponding commits.
Any review appreciated, of course!

Harald Freudenberger (1):
  s390/zcrypt: remove set_fs() invocation in zcrypt device driver

Heiko Carstens (3):
  s390/dis: get rid of set_fs() usage
  s390/uaccess: implement HAVE_GET_KERNEL_NOFAULT support
  s390/uaccess: remove set_fs() interface

 arch/s390/Kconfig                     |   1 -
 arch/s390/include/asm/futex.h         |  12 +--
 arch/s390/include/asm/mmu_context.h   |   7 +-
 arch/s390/include/asm/processor.h     |   4 +-
 arch/s390/include/asm/uaccess.h       | 129 ++++++++++++++++++++++----
 arch/s390/kernel/dis.c                |  24 +++--
 arch/s390/kernel/entry.S              |  19 +---
 arch/s390/kernel/entry.h              |   1 -
 arch/s390/kernel/process.c            |  15 +--
 arch/s390/lib/uaccess.c               |  76 +++++++--------
 arch/s390/mm/fault.c                  |   9 +-
 arch/s390/mm/pgalloc.c                |  11 +--
 arch/s390/pci/pci_mmio.c              |  12 +--
 drivers/s390/crypto/zcrypt_api.c      |  30 +++---
 drivers/s390/crypto/zcrypt_api.h      |  26 +++++-
 drivers/s390/crypto/zcrypt_ccamisc.c  |  32 ++-----
 drivers/s390/crypto/zcrypt_ep11misc.c |  28 +-----
 drivers/s390/crypto/zcrypt_msgtype6.c |  78 ++++++++--------
 drivers/s390/crypto/zcrypt_msgtype6.h |   4 +-
 19 files changed, 280 insertions(+), 238 deletions(-)

-- 
2.17.1
