Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13228 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388385AbhATLoQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 20 Jan 2021 06:44:16 -0500
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [kvm-unit-tests GIT PULL 00/11] s390x update
Date: Wed, 20 Jan 2021 06:41:47 -0500
Message-Id: <20210120114158.104559-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com

Dear Paolo,

please pull the following changes or merge them on gitlab:

* Moved to SPDX license identifiers and cleaning up licenses
* Added test_bit(_inv)() & SCLP feature bit checking
* Added first SIE lib and test for nesting tests
* Added diag318 emulation test
* Small UV fix


Gitlab merge request:
https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/merge_requests/4


The following changes since commit 4a54e8a3a88be171814e31dd6ab9b7a766644e32:

  lib/alloc_page: Properly handle requests for fresh blocks (2021-01-19 13:18:54 -0500)

are available in the Git repository at:

  https://gitlab.com/frankja/kvm-unit-tests.git tags/s390x-2021-20-01

for you to fetch changes up to 88fb0e5d52be357d3aab854c5c16303fe1608335:

  s390x: Fix uv_call() exception behavior (2021-01-20 04:15:21 -0500)


Janosch Frank (11):
  s390x: Move to GPL 2 and SPDX license identifiers
  s390x: lib: Move to GPL 2 and SPDX license identifiers
  s390x: Add test_bit to library
  s390x: Consolidate sclp read info
  s390x: SCLP feature checking
  s390x: Split assembly into multiple files
  s390x: sie: Add SIE to lib
  s390x: sie: Add first SIE test
  s390x: Add diag318 intercept test
  s390x: Fix sclp.h style issues
  s390x: Fix uv_call() exception behavior

 lib/s390x/asm-offsets.c     |  15 ++-
 lib/s390x/asm/arch_def.h    |  13 ++-
 lib/s390x/asm/asm-offsets.h |   4 +-
 lib/s390x/asm/barrier.h     |   4 +-
 lib/s390x/asm/bitops.h      |  26 +++++
 lib/s390x/asm/cpacf.h       |   1 +
 lib/s390x/asm/facility.h    |   7 +-
 lib/s390x/asm/float.h       |   4 +-
 lib/s390x/asm/interrupt.h   |   4 +-
 lib/s390x/asm/io.h          |   4 +-
 lib/s390x/asm/mem.h         |   4 +-
 lib/s390x/asm/page.h        |   4 +-
 lib/s390x/asm/pgtable.h     |   4 +-
 lib/s390x/asm/sigp.h        |   4 +-
 lib/s390x/asm/spinlock.h    |   4 +-
 lib/s390x/asm/stack.h       |   4 +-
 lib/s390x/asm/time.h        |   4 +-
 lib/s390x/asm/uv.h          |  24 +++--
 lib/s390x/css.h             |   4 +-
 lib/s390x/css_dump.c        |   4 +-
 lib/s390x/css_lib.c         |   4 +-
 lib/s390x/interrupt.c       |  11 +-
 lib/s390x/io.c              |   6 +-
 lib/s390x/mmu.c             |   4 +-
 lib/s390x/mmu.h             |   4 +-
 lib/s390x/sclp-console.c    |   5 +-
 lib/s390x/sclp.c            |  61 +++++++++--
 lib/s390x/sclp.h            | 183 ++++++++++++++++++---------------
 lib/s390x/sie.h             | 198 ++++++++++++++++++++++++++++++++++++
 lib/s390x/smp.c             |  31 +++---
 lib/s390x/smp.h             |   4 +-
 lib/s390x/stack.c           |   4 +-
 lib/s390x/vm.c              |   3 +-
 lib/s390x/vm.h              |   3 +-
 s390x/Makefile              |   7 +-
 s390x/cmm.c                 |   4 +-
 s390x/cpu.S                 | 121 ++++++++++++++++++++++
 s390x/cpumodel.c            |   4 +-
 s390x/css.c                 |   4 +-
 s390x/cstart64.S            | 123 +---------------------
 s390x/diag10.c              |   4 +-
 s390x/diag288.c             |   4 +-
 s390x/diag308.c             |   5 +-
 s390x/emulator.c            |   4 +-
 s390x/gs.c                  |   4 +-
 s390x/iep.c                 |   4 +-
 s390x/intercept.c           |  23 ++++-
 s390x/macros.S              |  77 ++++++++++++++
 s390x/pfmf.c                |   4 +-
 s390x/sclp.c                |   4 +-
 s390x/selftest.c            |   4 +-
 s390x/sie.c                 | 113 ++++++++++++++++++++
 s390x/skey.c                |   4 +-
 s390x/skrf.c                |   4 +-
 s390x/smp.c                 |   4 +-
 s390x/sthyi.c               |   4 +-
 s390x/sthyi.h               |   4 +-
 s390x/stsi.c                |   4 +-
 s390x/unittests.cfg         |   3 +
 s390x/uv-guest.c            |  16 ++-
 s390x/vector.c              |   4 +-
 61 files changed, 831 insertions(+), 392 deletions(-)
 create mode 100644 lib/s390x/sie.h
 create mode 100644 s390x/cpu.S
 create mode 100644 s390x/macros.S
 create mode 100644 s390x/sie.c

-- 
2.25.1
