Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14398 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727030AbgBVNEK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 22 Feb 2020 08:04:10 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01MD40Hf117370
        for <linux-s390@vger.kernel.org>; Sat, 22 Feb 2020 08:04:08 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yb1c4d1n5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sat, 22 Feb 2020 08:04:08 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Sat, 22 Feb 2020 13:04:06 -0000
Date: Sat, 22 Feb 2020 14:04:00 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [GIT PULL] s390 updates for 5.6-rc3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Message-Id: <your-ad-here.call-01582376640-ext-7410@work.hours>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.6-rc3. One of the changes touches
kernel/sysctl.c which simply removes s390 specific dead code.

Thank you,
Vasily

The following changes since commit 11a48a5a18c63fd7621bb050228cebf13566e4d8:

  Linux 5.6-rc2 (2020-02-16 13:16:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.6-4

for you to fetch changes up to 2db01da8d25f0420c411e788a9e1ba39269ae37b:

  s390/qdio: fill SBALEs with absolute addresses (2020-02-19 17:26:32 +0100)

----------------------------------------------------------------
s390 updates for 5.6-rc3

- Remove ieee_emulation_warnings sysctl which is a dead code.

- Avoid triggering rebuild of the kernel during make install.

- Enable protected virtualization guest support in default configs.

- Fix cio_ignore seq_file .next function to increase position index. And
  use kobj_to_dev instead of container_of in cio code.

- Fix storage block address lists to contain absolute addresses in
  qdio code.

- Few clang warnings and spelling fixes.

----------------------------------------------------------------
Christian Borntraeger (1):
      s390/defconfig: enable CONFIG_PROTECTED_VIRTUALIZATION_GUEST

Geert Uytterhoeven (1):
      s390/pkey/zcrypt: spelling s/crytp/crypt/

Julian Wiedmann (2):
      s390/qdio: fill SL with absolute addresses
      s390/qdio: fill SBALEs with absolute addresses

Masahiro Yamada (1):
      s390: make 'install' not depend on vmlinux

Nathan Chancellor (2):
      s390/mm: Explicitly compare PAGE_DEFAULT_KEY against zero in storage_key_init_range
      s390/kaslr: Fix casts in get_random

Stephen Kitt (1):
      s390: remove obsolete ieee_emulation_warnings

Vasily Averin (1):
      s390/cio: cio_ignore_proc_seq_next should increase position index

chenqiwu (1):
      s390/cio: use kobj_to_dev() API

 arch/s390/Makefile                    |  2 +-
 arch/s390/boot/Makefile               |  2 +-
 arch/s390/boot/kaslr.c                |  2 +-
 arch/s390/configs/debug_defconfig     | 28 ++++++++++-----------
 arch/s390/configs/defconfig           | 11 ++++-----
 arch/s390/include/asm/page.h          |  2 +-
 arch/s390/include/asm/processor.h     |  1 -
 arch/s390/include/asm/qdio.h          |  6 ++---
 drivers/s390/cio/blacklist.c          |  5 ++--
 drivers/s390/cio/chp.c                |  4 +--
 drivers/s390/cio/qdio_setup.c         |  3 ++-
 drivers/s390/crypto/zcrypt_ep11misc.c |  4 +--
 drivers/s390/net/qeth_core_main.c     | 46 +++++++++++++++++------------------
 drivers/s390/scsi/zfcp_fsf.c          |  2 +-
 drivers/s390/scsi/zfcp_qdio.c         |  6 ++---
 drivers/s390/scsi/zfcp_qdio.h         |  6 ++---
 kernel/sysctl.c                       |  9 -------
 17 files changed, 64 insertions(+), 75 deletions(-)
