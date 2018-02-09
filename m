Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 9 Feb 2018 14:07:13 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [GIT PULL] s390 updates for 4.16 merge window
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-Id: <20180209130713.GA3876@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hello Linus,

since Martin is on vacation you get the s390 pull request from me:

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

The main thing in this merge is the defense for the Spectre vulnerabilities.
But there are other updates as well, the changes in more detail:

* An s390 specific implementation of the array_index_mask_nospec function
  to the defense against spectre v1

* Two patches to utilize the new PPA-12/PPA-13 instructions to run the
  kernel and/or user space with reduced branch predicton.

* The s390 variant of the 'retpoline' spectre v2 defense called 'expoline'.
  There is no return instruction for s390, instead an indirect branch is
  used for function return. The s390 defense mechanism for indirect
  branches works by using an execute-type instruction with the indirect
  branch as the target of the execute. In effect that turns off the
  prediction for the indirect branch.

* Scrub registers in entry.S that contain user controlled values to
  prevent the speculative use of these values.

* Re-add the second parameter for the s390 specific runtime-instrumentation
  system call and move the header file to uapi. The second parameter will
  continue to do nothing but older kernel versions only accepted valid
  real-time signal numbers. The details will be documented in the man-page
  for the system call.

* Corrections and improvements for the s390 specific documentation

* Add a line to /proc/sysinfo to display the CPU model dependent
  license-internal-code identifier

* A header file include fix for eadm.

* An error message fix in the kprobes code.

* The removal of an outdated ARCH_xxx select statement.

Thanks,
Heiko

Cornelia Huck (3):
      s390/cmf: fix kerneldoc
      s390/docs: mention subchannel types
      s390/docs: reword airq section

Heiko Carstens (2):
      s390/runtime instrumentation: provide uapi header file
      s390/runtime_instrumentation: re-add signum system call parameter

Hendrik Brueckner (2):
      s390/sysinfo: add and display licensed internal code identifier
      s390/cpum_cf: correct counter number of LAST_HOST_TRANSLATIONS

Martin Schwidefsky (6):
      s390: scrub registers on kernel entry and KVM exit
      s390: add optimized array_index_mask_nospec
      s390/alternative: use a copy of the facility bit mask
      s390: add options to change branch prediction behaviour for the kernel
      s390: run user space and KVM guests with modified branch prediction
      s390: introduce execute-trampolines for branches

Masami Hiramatsu (1):
      s390/kprobes: Fix %p uses in error messages

Sebastian Ott (2):
      s390/eadm: fix CONFIG_BLOCK include dependency
      s390/cio: fix kernel-doc usage

Ulf Magnusson (1):
      s390/kconfig: Remove ARCH_WANTS_PROT_NUMA_PROT_NONE select

 Documentation/driver-api/s390-drivers.rst  |  32 +++-
 arch/s390/Kconfig                          |  46 +++++-
 arch/s390/Makefile                         |  10 ++
 arch/s390/include/asm/barrier.h            |  24 +++
 arch/s390/include/asm/eadm.h               |   2 +-
 arch/s390/include/asm/facility.h           |  18 +++
 arch/s390/include/asm/lowcore.h            |   9 +-
 arch/s390/include/asm/nospec-branch.h      |  18 +++
 arch/s390/include/asm/processor.h          |   4 +
 arch/s390/include/asm/runtime_instr.h      |  67 +-------
 arch/s390/include/asm/sysinfo.h            |   3 +-
 arch/s390/include/asm/thread_info.h        |   4 +
 arch/s390/include/uapi/asm/runtime_instr.h |  74 +++++++++
 arch/s390/kernel/Makefile                  |   4 +
 arch/s390/kernel/alternative.c             |  26 ++-
 arch/s390/kernel/early.c                   |   5 +
 arch/s390/kernel/entry.S                   | 249 ++++++++++++++++++++++++++---
 arch/s390/kernel/ipl.c                     |   1 +
 arch/s390/kernel/kprobes.c                 |   2 +-
 arch/s390/kernel/module.c                  |  62 +++++--
 arch/s390/kernel/nospec-branch.c           | 100 ++++++++++++
 arch/s390/kernel/perf_cpum_cf_events.c     |   2 +-
 arch/s390/kernel/processor.c               |  18 +++
 arch/s390/kernel/runtime_instr.c           |  10 +-
 arch/s390/kernel/setup.c                   |   8 +-
 arch/s390/kernel/smp.c                     |   7 +-
 arch/s390/kernel/sysinfo.c                 |   2 +
 arch/s390/kernel/vmlinux.lds.S             |  14 ++
 drivers/s390/char/Makefile                 |   2 +
 drivers/s390/cio/chp.c                     |  10 +-
 drivers/s390/cio/cio.c                     |   2 +-
 drivers/s390/cio/cmf.c                     |  15 +-
 drivers/s390/cio/itcw.c                    |   2 +-
 drivers/s390/cio/qdio_main.c               |   4 +-
 drivers/s390/cio/vfio_ccw_cp.c             |   2 +-
 35 files changed, 725 insertions(+), 133 deletions(-)
 create mode 100644 arch/s390/include/asm/nospec-branch.h
 create mode 100644 arch/s390/include/uapi/asm/runtime_instr.h
 create mode 100644 arch/s390/kernel/nospec-branch.c
