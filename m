Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726797AbfKXNoj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sun, 24 Nov 2019 08:44:39 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAODgukS097359
        for <linux-s390@vger.kernel.org>; Sun, 24 Nov 2019 08:44:38 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wf266r80t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sun, 24 Nov 2019 08:44:38 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Sun, 24 Nov 2019 13:44:36 -0000
Date: Sun, 24 Nov 2019 14:44:29 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [GIT PULL] s390 patches for the 5.5 merge window
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Message-Id: <your-ad-here.call-01574603069-ext-2920@work.hours>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

Hello Linus,

please pull s390 fixes and features for 5.5.

Thank you,
Vasily

The following changes since commit da0c9ea146cbe92b832f1b0f694840ea8eb33cce:

  Linux 5.4-rc2 (2019-10-06 14:27:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.5-1

for you to fetch changes up to 6a82e23f45fe0aa821e7a935e39d0acb20c275c0:

  s390/cpumf: Adjust registration of s390 PMU device drivers (2019-11-20 17:16:01 +0100)

----------------------------------------------------------------
s390 updates for the 5.5 merge window

- Adjust PMU device drivers registration to avoid WARN_ON and few other
  perf improvements.

- Enhance tracing in vfio-ccw.

- Few stack unwinder fixes and improvements, convert get_wchan custom
  stack unwinding to generic api usage.

- Fixes for mm helpers issues uncovered with tests validating architecture
  page table helpers.

- Fix noexec bit handling when hardware doesn't support it.

- Fix memleak and unsigned value compared with zero bugs in crypto
  code. Minor code simplification.

- Fix crash during kdump with kasan enabled kernel.

- Switch bug and alternatives from asm to asm_inline to improve inlining
  decisions.

- Use 'depends on cc-option' for MARCH and TUNE options in Kconfig,
  add z13s and z14 ZR1 to TUNE descriptions.

- Minor head64.S simplification.

- Fix physical to logical CPU map for SMT.

- Several cleanups in qdio code.

- Other minor cleanups and fixes all over the code.

----------------------------------------------------------------
Eric Farman (4):
      vfio-ccw: Refactor how the traces are built
      vfio-ccw: Trace the FSM jumptable
      vfio-ccw: Add a trace for asynchronous requests
      vfio-ccw: Rework the io_fctl trace

Gerald Schaefer (4):
      s390/mm: make pmd/pud_bad() report large entries as bad
      s390/mm: simplify page table helpers for large entries
      s390/mm: properly clear _PAGE_NOEXEC bit when it is not supported
      s390/mm: add mm_pxd_folded() checks to pxd_free()

Heiko Carstens (9):
      s390/Kconfig: make use of 'depends on cc-option'
      s390/Kconfig: add z13s and z14 ZR1 to TUNE descriptions
      s390/bug: make use of asm_inline
      s390/alternatives: make use of asm_inline
      s390/time: remove monotonic_clock()
      s390/time: ensure get_clock_monotonic() returns monotonic values
      s390: always inline current_stack_pointer()
      s390/pkey: fix memory leak within _copy_apqns_from_user()
      s390/smp: fix physical to logical CPU map for SMT

Ilya Leoshkevich (3):
      s390/unwind: fix get_stack_pointer(NULL, NULL)
      s390: add error handling to perf_callchain_kernel
      s390/disassembler: don't hide instruction addresses

Julian Wiedmann (7):
      s390/qdio: use QDIO_BUFNR()
      s390/qdio: reduce log level for EQBS partial
      s390/qdio: remove a forward declaration
      s390/qdio: add statistics helper macro
      s390/qdio: simplify thinint device registration
      s390/qdio: don't attempt IRQ avoidance on Output SBALs
      s390/qdio: move SSQD Sniffer mask definition

Markus Elfring (1):
      s390/pkey: use memdup_user() to simplify code

Miroslav Benes (1):
      s390/unwind: drop unnecessary code around calling ftrace_graph_ret_addr()

Nick Desaulniers (1):
      s390/boot: fix section name escaping

Thomas Richter (4):
      s390/cpum_sf: Use consistant debug print format for sampling
      s390/cpum_sf: Replace function name in debug statements
      s390/cpum_sf: Assign error value to err variable
      s390/cpumf: Adjust registration of s390 PMU device drivers

Vasily Gorbik (7):
      s390: avoid double handling of "noexec" option
      s390/process: avoid custom stack unwinding in get_wchan
      Merge tag 'vfio-ccw-20191111' of https://git.kernel.org/.../kvms390/vfio-ccw into features
      s390/kasan: support memcpy_real with TRACE_IRQFLAGS
      s390/early: move control registers setup in C code
      s390/head64: remove unnecessary vdso_per_cpu_data setup
      s390/early: move access registers setup in C code

YueHaibing (1):
      s390/crypto: Fix unsigned variable compared with zero

 arch/s390/Kconfig                    |  28 +++++++---
 arch/s390/boot/startup.c             |   2 +-
 arch/s390/crypto/sha_common.c        |   7 ++-
 arch/s390/include/asm/alternative.h  |   4 +-
 arch/s390/include/asm/bug.h          |   4 +-
 arch/s390/include/asm/ctl_reg.h      |   1 +
 arch/s390/include/asm/pgalloc.h      |  16 +++++-
 arch/s390/include/asm/pgtable.h      |  97 +++++++++++---------------------
 arch/s390/include/asm/processor.h    |   2 +-
 arch/s390/include/asm/qdio.h         |   1 +
 arch/s390/include/asm/spinlock.h     |   2 +-
 arch/s390/include/asm/stacktrace.h   |   2 +-
 arch/s390/include/asm/timex.h        |  17 +++---
 arch/s390/kernel/dis.c               |  13 +++--
 arch/s390/kernel/early.c             |  38 +++++++------
 arch/s390/kernel/head64.S            |  18 +-----
 arch/s390/kernel/perf_cpum_cf.c      |  21 ++++---
 arch/s390/kernel/perf_cpum_cf_diag.c |  10 ++--
 arch/s390/kernel/perf_cpum_sf.c      | 104 +++++++++++++++++------------------
 arch/s390/kernel/perf_event.c        |   8 ++-
 arch/s390/kernel/process.c           |  36 ++++++------
 arch/s390/kernel/smp.c               |  80 ++++++++++++++++++---------
 arch/s390/kernel/time.c              |   9 ---
 arch/s390/kernel/unwind_bc.c         |  14 +----
 arch/s390/lib/spinlock.c             |   4 +-
 arch/s390/mm/maccess.c               |  12 ++--
 drivers/s390/cio/Makefile            |   4 +-
 drivers/s390/cio/qdio.h              |  26 ++++-----
 drivers/s390/cio/qdio_main.c         |  26 ++++-----
 drivers/s390/cio/qdio_setup.c        |   2 -
 drivers/s390/cio/qdio_thinint.c      |  41 +++++---------
 drivers/s390/cio/vfio_ccw_cp.h       |   1 +
 drivers/s390/cio/vfio_ccw_fsm.c      |  11 ++--
 drivers/s390/cio/vfio_ccw_private.h  |   1 +
 drivers/s390/cio/vfio_ccw_trace.c    |  14 +++++
 drivers/s390/cio/vfio_ccw_trace.h    |  76 ++++++++++++++++++++++---
 drivers/s390/crypto/pkey_api.c       |  26 ++-------
 drivers/s390/net/qeth_l3.h           |   2 -
 drivers/s390/net/qeth_l3_sys.c       |   2 +-
 39 files changed, 410 insertions(+), 372 deletions(-)
 create mode 100644 drivers/s390/cio/vfio_ccw_trace.c
