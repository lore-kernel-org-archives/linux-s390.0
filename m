Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34759 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726079AbfLCMci (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Dec 2019 07:32:38 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB3CMvOs076182
        for <linux-s390@vger.kernel.org>; Tue, 3 Dec 2019 07:32:37 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wnje9ervd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 03 Dec 2019 07:32:37 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Tue, 3 Dec 2019 12:32:35 -0000
Date: Tue, 3 Dec 2019 13:32:29 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [GIT PULL] s390 patches for the 5.5 merge window #2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Message-Id: <your-ad-here.call-01575376349-ext-1325@work.hours>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Hello Linus,

please pull the second round of s390 fixes and features for 5.5.

Thank you,
Vasily

The following changes since commit ea1f56fa16ae5f6e67f6ea03836b36c6053d33d1:

  Merge tag 's390-5.5-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2019-11-25 17:23:53 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux tags/s390-5.5-2

for you to fetch changes up to 2115fbf7210bd053ba55a95e7ebc366df41aa9cf:

  s390: remove compat vdso code (2019-12-01 12:48:49 +0100)

----------------------------------------------------------------
s390 updates for the 5.5 merge window #2

- Make stack unwinder reliable and suitable for livepatching. Add unwinder
  testing module.

- Fixes for CALL_ON_STACK helper used for stack switching.

- Fix unwinding from bpf code.

- Fix getcpu and remove compat support in vdso code.

- Fix address space control registers initialization.

- Save KASLR offset for early dumps.

- Handle new FILTERED_BY_HYPERVISOR reply code in crypto code.

- Minor perf code cleanup and potential memory leak fix.

- Add couple of error messages for corner cases during PCI device
  creation.

----------------------------------------------------------------
Gerald Schaefer (1):
      s390/kaslr: store KASLR offset for early dumps

Harald Freudenberger (1):
      s390/zcrypt: handle new reply code FILTERED_BY_HYPERVISOR

Heiko Carstens (3):
      s390/smp,vdso: fix ASCE handling
      s390/vdso: fix getcpu
      s390: remove compat vdso code

Ilya Leoshkevich (2):
      s390: implement perf_arch_fetch_caller_regs
      s390/unwind: add a test for the internal API

Miroslav Benes (2):
      s390/unwind: add stack pointer alignment sanity checks
      s390/livepatch: Implement reliable stack tracing for the consistency model

Niklas Schnelle (2):
      s390/pci: add error message for UID collision
      s390/pci: add error message on device number limit

Thomas Richter (4):
      s390/cpum_sf: Replace function name in debug statements
      s390/cpum_sf: Remove unnecessary check for pending SDBs
      s390/cpum_sf: Use TEAR_REG macro consistantly
      s390/cpum_sf: Check for SDBT and SDB consistency

Vasily Gorbik (18):
      s390: always inline disabled_wait
      s390: disable preemption when switching to nodat stack with CALL_ON_STACK
      s390/unwind: unify task is current checks
      s390: correct CALL_ON_STACK back_chain saving
      s390: avoid misusing CALL_ON_STACK for task stack setup
      s390/unwind: report an error if pt_regs are not on stack
      s390/unwind: make reuse_sp default when unwinding pt_regs
      s390/head64: correct init_task stack setup
      s390/unwind: stop gracefully at task pt_regs
      s390/unwind: always inline get_stack_pointer
      s390/test_unwind: require that unwinding ended successfully
      s390: fix register clobbering in CALL_ON_STACK
      s390/test_unwind: add CALL_ON_STACK tests
      s390/test_unwind: print verbose unwinding results
      s390/test_unwind: add irq context tests
      s390/test_unwind: add program check context tests
      s390/unwind: start unwinding from reliable state
      s390/unwind: filter out unreliable bogus %r14

 arch/s390/Kconfig                        |  18 +-
 arch/s390/Makefile                       |   1 -
 arch/s390/boot/startup.c                 |   5 +
 arch/s390/include/asm/cpu_mf.h           |   2 +-
 arch/s390/include/asm/perf_event.h       |   7 +
 arch/s390/include/asm/processor.h        |   2 +-
 arch/s390/include/asm/stacktrace.h       |  36 +++-
 arch/s390/include/asm/unwind.h           |   8 +-
 arch/s390/include/asm/vdso.h             |  13 +-
 arch/s390/kernel/Makefile                |   1 -
 arch/s390/kernel/asm-offsets.c           |   3 +-
 arch/s390/kernel/dumpstack.c             |   7 +-
 arch/s390/kernel/head64.S                |   2 +-
 arch/s390/kernel/machine_kexec.c         |   4 +-
 arch/s390/kernel/perf_cpum_sf.c          | 136 ++++++------
 arch/s390/kernel/setup.c                 |   9 +-
 arch/s390/kernel/smp.c                   |   7 +-
 arch/s390/kernel/stacktrace.c            |  43 ++++
 arch/s390/kernel/unwind_bc.c             |  80 ++++---
 arch/s390/kernel/vdso.c                  |  42 +---
 arch/s390/kernel/vdso32/.gitignore       |   1 -
 arch/s390/kernel/vdso32/Makefile         |  66 ------
 arch/s390/kernel/vdso32/clock_getres.S   |  44 ----
 arch/s390/kernel/vdso32/clock_gettime.S  | 179 ----------------
 arch/s390/kernel/vdso32/getcpu.S         |  33 ---
 arch/s390/kernel/vdso32/gettimeofday.S   | 103 ---------
 arch/s390/kernel/vdso32/note.S           |  13 --
 arch/s390/kernel/vdso32/vdso32.lds.S     | 142 -------------
 arch/s390/kernel/vdso32/vdso32_wrapper.S |  15 --
 arch/s390/kernel/vdso64/getcpu.S         |   4 +-
 arch/s390/lib/Makefile                   |   3 +
 arch/s390/lib/test_unwind.c              | 347 +++++++++++++++++++++++++++++++
 arch/s390/mm/maccess.c                   |  12 +-
 arch/s390/pci/pci.c                      |   5 +
 drivers/s390/crypto/zcrypt_error.h       |   2 +
 35 files changed, 627 insertions(+), 768 deletions(-)
 delete mode 100644 arch/s390/kernel/vdso32/.gitignore
 delete mode 100644 arch/s390/kernel/vdso32/Makefile
 delete mode 100644 arch/s390/kernel/vdso32/clock_getres.S
 delete mode 100644 arch/s390/kernel/vdso32/clock_gettime.S
 delete mode 100644 arch/s390/kernel/vdso32/getcpu.S
 delete mode 100644 arch/s390/kernel/vdso32/gettimeofday.S
 delete mode 100644 arch/s390/kernel/vdso32/note.S
 delete mode 100644 arch/s390/kernel/vdso32/vdso32.lds.S
 delete mode 100644 arch/s390/kernel/vdso32/vdso32_wrapper.S
 create mode 100644 arch/s390/lib/test_unwind.c
