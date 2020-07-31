Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9072 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731922AbgGaJq0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 31 Jul 2020 05:46:26 -0400
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests GIT PULL 00/11] s390x patches
Date: Fri, 31 Jul 2020 11:45:56 +0200
Message-Id: <20200731094607.15204-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.vnet.ibm.com, david@redhat.com, thuth@redhat.com, pmorel@linux.ibm.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com

Hi Paolo,

The following changes since commit 82147b77199bbfec2c61c97685cfb34f3f97c889:

  fw_cfg: avoid index out of bounds (2020-07-30 17:57:55 -0400)

are available in the Git repository at:

  https://github.com/frankjaa/kvm-unit-tests.git tags/s390x-2020-31-07

for you to fetch changes up to c2f4799a861993b82950b9e5a3a44fc65ba05ec6:

  s390x: fix inline asm on gcc10 (2020-07-31 04:35:33 -0400)

----------------------------------------------------------------
* IO tests from Pierre
* GCC 10 compile fix from Claudio
* CPU model test fix from Thomas
----------------------------------------------------------------

Claudio Imbrenda (1):
  s390x: fix inline asm on gcc10

Pierre Morel (9):
  s390x: saving regs for interrupts
  s390x: I/O interrupt registration
  s390x: export the clock get_clock_ms() utility
  s390x: clock and delays calculations
  s390x: define function to wait for interrupt
  s390x: Library resources for CSS tests
  s390x: css: stsch, enumeration test
  s390x: css: msch, enable test
  s390x: css: ssch/tsch with sense and interrupt

Thomas Huth (1):
  s390x/cpumodel: The missing DFP facility on TCG is expected

 lib/s390x/asm/arch_def.h |  14 ++
 lib/s390x/asm/cpacf.h    |   5 +-
 lib/s390x/asm/time.h     |  50 ++++++
 lib/s390x/css.h          | 294 +++++++++++++++++++++++++++++++++++
 lib/s390x/css_dump.c     | 152 +++++++++++++++++++
 lib/s390x/css_lib.c      | 320 +++++++++++++++++++++++++++++++++++++++
 lib/s390x/interrupt.c    |  23 ++-
 lib/s390x/interrupt.h    |   8 +
 lib/s390x/vm.c           |  46 ++++++
 lib/s390x/vm.h           |  14 ++
 s390x/Makefile           |   4 +
 s390x/cpumodel.c         |  19 ++-
 s390x/css.c              | 150 ++++++++++++++++++
 s390x/cstart64.S         |  41 ++++-
 s390x/emulator.c         |  25 +--
 s390x/intercept.c        |  11 +-
 s390x/unittests.cfg      |   4 +
 17 files changed, 1147 insertions(+), 33 deletions(-)
 create mode 100644 lib/s390x/asm/time.h
 create mode 100644 lib/s390x/css.h
 create mode 100644 lib/s390x/css_dump.c
 create mode 100644 lib/s390x/css_lib.c
 create mode 100644 lib/s390x/interrupt.h
 create mode 100644 lib/s390x/vm.c
 create mode 100644 lib/s390x/vm.h
 create mode 100644 s390x/css.c

-- 
2.25.4
