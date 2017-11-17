Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 17 Nov 2017 14:47:25 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for the 4.15 merge window #2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20171117144725.73dd9047@mschwideX1>
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

The second part of the s390 patches for the 4.15 merge window:

 - Rework of the vdso code to avoid the use of the access register mode

 - Use perf AUX buffers for the transport of diagnostic sample data

 - Add perf_regs and user stack dump support

 - Enable perf call graphs for user space programs

 - Add perf register support for floating-point registers

 - All remaining s390 related timer_setup conversions

 - Bug fixes and cleanups.

The shortlog:

Heiko Carstens (8):
      s390/vdso: add missing boot_vdso_data declaration
      s390/spinlock: fix indentation
      s390/mm: remove unused code
      s390/nmi: remove unused code
      s390: enable CPU alternatives unconditionally
      s390/perf: add perf_regs support and user stack dump
      s390/perf: add support for perf_regs and libdw
      s390: remove unused parameter from Makefile

Hendrik Brueckner (6):
      s390/cpum_sf: do not register PMU if no sampling mode is authorized
      s390/perf: define common DWARF register string table
      s390/perf: extend perf_regs support to include floating-point registers
      s390/perf: add perf register support for floating-point registers
      s390/cpum_sf: load program parameter at sampler enablement
      s390/cpum_sf: correctly set the PID and TID in perf samples

Kees Cook (5):
      s390: qdio: Convert timers to use timer_setup()
      s390/cio: Convert timers to use timer_setup()
      s390/sclp: Convert timers to use timer_setup()
      s390/ap_bus: Convert timers to use timer_setup()
      s390/scsi: Convert timers to use timer_setup()

Martin Schwidefsky (2):
      s390/mm,kvm: improve detection of KVM guest faults
      s390: remove all code using the access register mode

Michael Holzheu (1):
      s390: Remove CONFIG_HARDENED_USERCOPY

Pu Hou (4):
      s390/cpumf: introduce AUX buffer for dump diagnostic sample data
      s390/cpumf: enable using AUX buffer
      s390/perf: add callback to perf to enable using AUX buffer
      s390/cpumf: remove raw event support in basic-only sampling mode

Steffen Maier (1):
      zfcp: purely mechanical update using timer API, plus blank lines

Vasily Gorbik (3):
      s390: correct some inline assembly constraints
      s390/kbuild: get rid of a warning when compiling with KCOV
      s390/disassembler: increase show_code buffer size

 arch/s390/Kconfig                               |  19 +-
 arch/s390/configs/default_defconfig             |   5 +-
 arch/s390/configs/gcov_defconfig                |   4 -
 arch/s390/configs/performance_defconfig         |   4 -
 arch/s390/include/asm/alternative.h             |  20 +-
 arch/s390/include/asm/cpu_mf.h                  |   8 +-
 arch/s390/include/asm/futex.h                   |   9 +-
 arch/s390/include/asm/lowcore.h                 |  37 +-
 arch/s390/include/asm/mmu_context.h             |  36 +-
 arch/s390/include/asm/perf_event.h              |  17 -
 arch/s390/include/asm/processor.h               |   6 +-
 arch/s390/include/asm/ptrace.h                  |   2 +
 arch/s390/include/asm/setup.h                   |   2 +-
 arch/s390/include/asm/uaccess.h                 |  29 +-
 arch/s390/include/asm/vdso.h                    |   1 +
 arch/s390/include/uapi/asm/perf_regs.h          |  43 ++
 arch/s390/kernel/Makefile                       |   5 +-
 arch/s390/kernel/asm-offsets.c                  |   2 +-
 arch/s390/kernel/dis.c                          |   4 +-
 arch/s390/kernel/entry.S                        |  33 +-
 arch/s390/kernel/head64.S                       |   2 +-
 arch/s390/kernel/module.c                       |  15 +-
 arch/s390/kernel/nmi.c                          |   2 -
 arch/s390/kernel/perf_cpum_sf.c                 | 768 ++++++++++++++++++------
 arch/s390/kernel/perf_regs.c                    |  70 +++
 arch/s390/kernel/vdso.c                         |  44 +-
 arch/s390/kernel/vdso32/getcpu.S                |  16 +-
 arch/s390/kernel/vdso64/clock_gettime.S         |  19 +-
 arch/s390/kernel/vdso64/getcpu.S                |  15 +-
 arch/s390/lib/spinlock.c                        |   7 +-
 arch/s390/lib/uaccess.c                         |  90 ++-
 arch/s390/mm/fault.c                            | 110 ++--
 arch/s390/mm/gmap.c                             |   9 +-
 arch/s390/mm/init.c                             |   1 +
 arch/s390/mm/pgalloc.c                          |   4 +-
 arch/s390/tools/Makefile                        |   2 +-
 drivers/s390/char/con3215.c                     |   6 +-
 drivers/s390/char/con3270.c                     |  10 +-
 drivers/s390/char/sclp.c                        |  45 +-
 drivers/s390/char/sclp_con.c                    |   5 +-
 drivers/s390/char/sclp_tty.c                    |   5 +-
 drivers/s390/char/sclp_vt220.c                  |   6 +-
 drivers/s390/char/tape_core.c                   |  14 +-
 drivers/s390/char/tty3270.c                     |   8 +-
 drivers/s390/cio/device.c                       |   8 +-
 drivers/s390/cio/device.h                       |   2 +
 drivers/s390/cio/device_fsm.c                   |  10 +-
 drivers/s390/cio/eadm_sch.c                     |   9 +-
 drivers/s390/cio/qdio.h                         |   2 +-
 drivers/s390/cio/qdio_main.c                    |   4 +-
 drivers/s390/cio/qdio_setup.c                   |   3 +-
 drivers/s390/crypto/ap_bus.c                    |  10 +-
 drivers/s390/crypto/ap_bus.h                    |   2 +-
 drivers/s390/crypto/ap_queue.c                  |   2 +-
 drivers/s390/scsi/zfcp_erp.c                    |  15 +-
 drivers/s390/scsi/zfcp_ext.h                    |   2 +-
 drivers/s390/scsi/zfcp_fsf.c                    |  14 +-
 tools/perf/Makefile.config                      |   6 +-
 tools/perf/arch/s390/include/dwarf-regs-table.h |  71 ++-
 tools/perf/arch/s390/include/perf_regs.h        |  95 +++
 tools/perf/arch/s390/util/Build                 |   3 +
 tools/perf/arch/s390/util/auxtrace.c            | 118 ++++
 tools/perf/arch/s390/util/dwarf-regs.c          |  11 +-
 tools/perf/arch/s390/util/unwind-libdw.c        |  63 ++
 64 files changed, 1429 insertions(+), 580 deletions(-)
 create mode 100644 arch/s390/include/uapi/asm/perf_regs.h
 create mode 100644 arch/s390/kernel/perf_regs.c
 create mode 100644 tools/perf/arch/s390/include/perf_regs.h
 create mode 100644 tools/perf/arch/s390/util/auxtrace.c
 create mode 100644 tools/perf/arch/s390/util/unwind-libdw.c
