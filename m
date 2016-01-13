Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 13 Jan 2016 10:25:39 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.5 merge window
Message-ID: <20160113102539.1251d16c@mschwide>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

Among the traditional bug fixes and cleanups are some improvements:
- A tool to generated the facility lists, generating the bit fields
  by hand has been a source of bugs in the past
- The spinlock loop is reordered to avoid bursts of hypervisor calls
- Add support for the open-for-business interface to the service element
- The get_cpu call is added to the vdso
- A set of tracepoints is defined for the common I/O layer
- The deprecated sclp_cpi module is removed
- Update default configuration

There is a trivial merge conflict with a patch from Al, I hope it
is not too much of a hassle to fix it.

Ard Biesheuvel (1):
      s390: fix normalization bug in exception table sorting

Aya Mahfouz (1):
      s390/hmcdrv: constify hmcdrv_ftp_ops structs

Christian Borntraeger (6):
      s390/dis: Fix printing of the register numbers
      s390/traps: Remove unused variable
      s390/fault: remove unused variable
      s390/extmem: remove unused variable
      s390/sysinfo: Remove unused variables
      s390/setup: cleanup machine flags

David Hildenbrand (1):
      s390: get_user_pages_fast() might sleep

Gerald Schaefer (1):
      s390/pci_dma: fix DMA table corruption with > 4 TB main memory

Heiko Carstens (19):
      s390: remove is_32bit_task() helper
      s390/facilities: use stfl mnemonic instead of insn magic
      s390/facilities: always use lowcore's stfle field for storing facility bits
      s390/facilities: add helper tool to generate facility lists
      s390/facilities: make use of generated facility list
      s390/facilities: remove unneeded facility bits
      s390/facilities: optimize test_facility()
      s390/facilities: add z13 als bit
      kbuild: add AFLAGS_REMOVE_(basename).o option
      s390: compile head.S always with -march=z900
      s390/smp: save timestamp on external calls
      s390/Kconfig: remove pointless 64 bit dependencies
      s390: get rid of CONFIG_SCHED_MC and CONFIG_SCHED_BOOK
      s390/sysinfo: add missing SYSIB 1.2.2 multithreading fields
      s390/ptrace: get rid of long longs in psw_bits
      s390/mem_detect: use unsigned longs
      s390: rename struct _lowcore to struct lowcore
      s390/configs: update default configurations
      s390/sclp: fix possible control register corruption

Hendrik Brueckner (1):
      s390/sclp_cpi: remove sclp_cpi module in favor of sysfs interface

Jochen Schweflinghaus (1):
      s390/sclp: add open for business support

Julia Lawall (1):
      s390/cio: add NULL test

Markus Elfring (1):
      s390: Delete unnecessary checks before the function call "debug_unregister"

Martin Schwidefsky (13):
      s390/zcore: remove invalid kfree in init_cpu_info
      s390/zcore: copy vector registers into the image data
      s390/zcore: remove /sys/kernel/debug/zcore/mem
      s390/kdump: remove code to create ELF notes in the crashed system
      s390/dump: streamline oldmem copy functions
      s390/zcore: simplify memcpy_hsa
      s390/kvm: remove dependency on struct save_area definition
      s390/dump: remove SAVE_AREA_BASE
      s390/dump: rework CPU register dump code
      s390/dump: cleanup CPU save area handling
      s390/spinlock: avoid diagnose loop
      s390/spinlock: do not yield to a CPU in udelay/mdelay
      s390/vdso: optimize getcpu system call

Michael Holzheu (1):
      s390: add 'install' target to 'make help'

Michael S. Tsirkin (1):
      s390: drop smp_mb in vdso_init

Peter Oberparleiter (5):
      s390/cio: Remove unused inline assemblies
      s390/cio: Fix incorrect xsch opcode specification
      s390/cio: Consolidate inline assemblies and related data definitions
      s390/cio: Introduce common I/O layer tracepoints
      s390/cio: Change I/O instructions from inline to normal functions

Pierre Morel (1):
      s390/con3270: testing return kzalloc retval

Sascha Silbe (1):
      s390/sclp: Add VT220 support to early sclp console

Stefan Haberland (1):
      s390/dasd: fix failfast for disconnected devices

 Documentation/s390/zfcpdump.txt         |  22 +-
 arch/s390/Kconfig                       |  11 +-
 arch/s390/Makefile                      |   9 +
 arch/s390/configs/default_defconfig     |  27 +-
 arch/s390/configs/gcov_defconfig        |  24 +-
 arch/s390/configs/performance_defconfig |  24 +-
 arch/s390/configs/zfcpdump_defconfig    |  10 +-
 arch/s390/defconfig                     |  30 ++-
 arch/s390/include/asm/compat.h          |   2 +-
 arch/s390/include/asm/crw.h             |  14 -
 arch/s390/include/asm/elf.h             |  11 +-
 arch/s390/include/asm/facilities_src.h  |  58 ++++
 arch/s390/include/asm/facility.h        |  17 +-
 arch/s390/include/asm/fpu/internal.h    |  10 +-
 arch/s390/include/asm/ipl.h             |  14 +-
 arch/s390/include/asm/lowcore.h         |  27 +-
 arch/s390/include/asm/os_info.h         |   2 +-
 arch/s390/include/asm/pci_dma.h         |   2 +
 arch/s390/include/asm/processor.h       |  12 +
 arch/s390/include/asm/ptrace.h          |  38 +--
 arch/s390/include/asm/reset.h           |   3 +-
 arch/s390/include/asm/sclp.h            |  13 +-
 arch/s390/include/asm/setup.h           |  31 +--
 arch/s390/include/asm/smp.h             |   2 +-
 arch/s390/include/asm/sysinfo.h         |  17 +-
 arch/s390/include/asm/thread_info.h     |   2 -
 arch/s390/include/asm/topology.h        |   6 +-
 arch/s390/include/asm/vdso.h            |   6 +-
 arch/s390/kernel/Makefile               |   8 +-
 arch/s390/kernel/asm-offsets.c          | 175 ++++++------
 arch/s390/kernel/crash_dump.c           | 454 ++++++++++++++-----------------
 arch/s390/kernel/dis.c                  |   4 +-
 arch/s390/kernel/early.c                |   9 +
 arch/s390/kernel/entry.S                |   2 +
 arch/s390/kernel/head.S                 |  47 ++--
 arch/s390/kernel/head64.S               |   2 +-
 arch/s390/kernel/ipl.c                  |  21 +-
 arch/s390/kernel/machine_kexec.c        | 110 ++++----
 arch/s390/kernel/os_info.c              |   7 +-
 arch/s390/kernel/reipl.S                |  94 ++++---
 arch/s390/kernel/sclp.c                 |  65 +++--
 arch/s390/kernel/setup.c                |  23 +-
 arch/s390/kernel/smp.c                  | 161 ++++++-----
 arch/s390/kernel/sysinfo.c              |  20 +-
 arch/s390/kernel/traps.c                |   3 -
 arch/s390/kernel/vdso.c                 |  17 +-
 arch/s390/kernel/vdso32/Makefile        |   2 +-
 arch/s390/kernel/vdso32/getcpu.S        |  43 +++
 arch/s390/kernel/vdso32/vdso32.lds.S    |   1 +
 arch/s390/kernel/vdso64/Makefile        |   2 +-
 arch/s390/kernel/vdso64/getcpu.S        |  42 +++
 arch/s390/kernel/vdso64/vdso64.lds.S    |   1 +
 arch/s390/kvm/interrupt.c               |   4 +-
 arch/s390/kvm/kvm-s390.c                |  30 +--
 arch/s390/kvm/priv.c                    |   2 +-
 arch/s390/lib/spinlock.c                |  45 +++-
 arch/s390/mm/extable.c                  |   8 +-
 arch/s390/mm/extmem.c                   |   4 +-
 arch/s390/mm/fault.c                    |   2 -
 arch/s390/mm/gup.c                      |   1 +
 arch/s390/mm/maccess.c                  |   4 +-
 arch/s390/mm/mem_detect.c               |   7 +-
 arch/s390/pci/pci.c                     |   3 +-
 arch/s390/pci/pci_dma.c                 |  19 +-
 arch/s390/tools/.gitignore              |   1 +
 arch/s390/tools/Makefile                |  15 ++
 arch/s390/tools/gen_facilities.c        |  67 +++++
 drivers/s390/block/dasd.c               |   8 +-
 drivers/s390/char/Kconfig               |  21 +-
 drivers/s390/char/Makefile              |   5 +-
 drivers/s390/char/con3215.c             |   2 +
 drivers/s390/char/con3270.c             |   2 +
 drivers/s390/char/hmcdrv_ftp.c          |   6 +-
 drivers/s390/char/sclp.c                |   5 +-
 drivers/s390/char/sclp_config.c         | 102 ++++++-
 drivers/s390/char/sclp_cpi.c            |  40 ---
 drivers/s390/char/zcore.c               | 461 ++++----------------------------
 drivers/s390/cio/Makefile               |   5 +-
 drivers/s390/cio/airq.c                 |   1 +
 drivers/s390/cio/chsc_sch.c             |   5 +-
 drivers/s390/cio/cio.c                  |  37 ++-
 drivers/s390/cio/cio.h                  |  12 +
 drivers/s390/cio/crw.c                  |   1 +
 drivers/s390/cio/css.c                  |   2 +-
 drivers/s390/cio/device_fsm.c           |   2 +-
 drivers/s390/cio/io_sch.h               |  45 ----
 drivers/s390/cio/ioasm.c                | 224 ++++++++++++++++
 drivers/s390/cio/ioasm.h                | 169 ++----------
 drivers/s390/cio/qdio_debug.c           |   6 +-
 drivers/s390/cio/trace.c                |  24 ++
 drivers/s390/cio/trace.h                | 363 +++++++++++++++++++++++++
 drivers/s390/crypto/zcrypt_api.c        |   6 +-
 scripts/Makefile.lib                    |   3 +-
 93 files changed, 1948 insertions(+), 1578 deletions(-)
 create mode 100644 arch/s390/include/asm/facilities_src.h
 create mode 100644 arch/s390/kernel/vdso32/getcpu.S
 create mode 100644 arch/s390/kernel/vdso64/getcpu.S
 create mode 100644 arch/s390/tools/.gitignore
 create mode 100644 arch/s390/tools/Makefile
 create mode 100644 arch/s390/tools/gen_facilities.c
 delete mode 100644 drivers/s390/char/sclp_cpi.c
 create mode 100644 drivers/s390/cio/ioasm.c
 create mode 100644 drivers/s390/cio/trace.c
 create mode 100644 drivers/s390/cio/trace.h
