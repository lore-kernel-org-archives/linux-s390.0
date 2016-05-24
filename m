From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH v6 00/21] ILP32 for ARM64
Date: Tue, 24 May 2016 03:04:29 +0300
Message-ID: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, libc-alpha@sourceware.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ynorov@caviumnetworks.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

This series enables aarch64 with ilp32 mode, and as supporting work,
introduces compat wrappers based on s390 solution, and also introduces
ARCH_32BIT_OFF_T configuration option that is enabled for existing
32-bit architectures but disabled for new arches (so 64-bit off_t is 
is used by new userspace).

This version is based on kernel v4.6.
It works with glibc-2.23, and tested with LTP.

It was tested on QEMU and ThunderX machines. No major differences found.

This is not RFC anymore, because ILP32 is now tested in big-endian mode;
signals, vDSO and other subsystems are tested, and look working

 v3: https://lkml.org/lkml/2014/9/3/704
 v4: https://lkml.org/lkml/2015/4/13/691
 v5: https://lkml.org/lkml/2015/9/29/911
 v6: ABI reworked significantly;
    - syscall input arguments are deloused with compat wrappers;
    - vDSO is now working for both BE and LE;
    - signal subsystem is reworked to handle signal context properly;
    - binfmt_elf is reworked, and now most of places where execution mode
      should be detected, are handled statically;
    - many other less-important fixes.

ILP32 glibc branch is available here:
https://github.com/norov/glibc/tree/ilp32-2.23

It is tested with this series with no major downsides. I will send it to 
glibc-alpha soon, after final revise. Please review and comment it as well.

Andrew Pinski (6):
  arm64: ensure the kernel is compiled for LP64
  arm64: rename COMPAT to AARCH32_EL0 in Kconfig
  arm64:uapi: set __BITS_PER_LONG correctly for ILP32 and LP64
  arm64: ilp32: add sys_ilp32.c and a separate table (in entry.S) to use
    it
  arm64: ilp32: introduce ilp32-specific handlers for sigframe and
    ucontext
  arm64:ilp32: add ARM64_ILP32 to Kconfig

Philipp Tomsich (1):
  arm64:ilp32: add vdso-ilp32 and use for signal return

Yury Norov (15):
  all: introduce COMPAT_WRAPPER option and enable it for s390
  all: s390: move wrapper infrastructure to generic headers
  all: s390: move compat_wrappers.c from arch/s390/kernel to kernel/
  all: wrap needed syscalls in generic unistd
  compat ABI: use non-compat openat and open_by_handle_at variants
  32-bit ABI: introduce ARCH_32BIT_OFF_T config option
  arm64: ilp32: add documentation on the ILP32 ABI for ARM64
  thread: move thread bits accessors to separated file
  arm64: introduce is_a32_task and is_a32_thread (for AArch32 compat)
  arm64: ilp32: add is_ilp32_compat_{task,thread} and TIF_32BIT_AARCH64
  arm64: introduce binfmt_elf32.c
  arm64: ilp32: introduce binfmt_ilp32.c
  arm64: ptrace: handle ptrace_request differently for aarch32 and ilp32
  arm64: signal: share lp64 signal routines to ilp32
  arm64: signal32: move ilp32 and aarch32 common code to separated file

 Documentation/arm64/ilp32.txt                 |  25 +++
 arch/Kconfig                                  |   8 +
 arch/arc/Kconfig                              |   1 +
 arch/arm/Kconfig                              |   1 +
 arch/arm64/Kconfig                            |  20 +-
 arch/arm64/Makefile                           |   5 +
 arch/arm64/include/asm/compat.h               |  19 +-
 arch/arm64/include/asm/elf.h                  |  35 +---
 arch/arm64/include/asm/fpsimd.h               |   2 +-
 arch/arm64/include/asm/ftrace.h               |   2 +-
 arch/arm64/include/asm/hwcap.h                |   6 +-
 arch/arm64/include/asm/is_compat.h            |  84 ++++++++
 arch/arm64/include/asm/memory.h               |   3 +-
 arch/arm64/include/asm/processor.h            |  11 +-
 arch/arm64/include/asm/ptrace.h               |   2 +-
 arch/arm64/include/asm/signal32.h             |   6 +-
 arch/arm64/include/asm/signal32_common.h      |  25 +++
 arch/arm64/include/asm/signal_common.h        |  33 +++
 arch/arm64/include/asm/signal_ilp32.h         |  34 ++++
 arch/arm64/include/asm/syscall.h              |   2 +-
 arch/arm64/include/asm/thread_info.h          |   4 +-
 arch/arm64/include/asm/unistd.h               |  11 +-
 arch/arm64/include/asm/unistd32.h             |   2 +-
 arch/arm64/include/asm/vdso.h                 |   6 +
 arch/arm64/include/uapi/asm/bitsperlong.h     |   9 +-
 arch/arm64/kernel/Makefile                    |  14 +-
 arch/arm64/kernel/asm-offsets.c               |   9 +-
 arch/arm64/kernel/binfmt_elf32.c              |  33 +++
 arch/arm64/kernel/binfmt_ilp32.c              |  91 +++++++++
 arch/arm64/kernel/cpufeature.c                |   8 +-
 arch/arm64/kernel/cpuinfo.c                   |   4 +-
 arch/arm64/kernel/entry.S                     |  16 +-
 arch/arm64/kernel/entry_ilp32.S               |  23 +++
 arch/arm64/kernel/head.S                      |   2 +-
 arch/arm64/kernel/hw_breakpoint.c             |  10 +-
 arch/arm64/kernel/perf_regs.c                 |   2 +-
 arch/arm64/kernel/process.c                   |   7 +-
 arch/arm64/kernel/ptrace.c                    |  67 ++++++-
 arch/arm64/kernel/signal.c                    | 100 ++++++----
 arch/arm64/kernel/signal32.c                  |  85 --------
 arch/arm64/kernel/signal32_common.c           | 115 +++++++++++
 arch/arm64/kernel/signal_ilp32.c              | 192 ++++++++++++++++++
 arch/arm64/kernel/sys32.c                     |   1 +
 arch/arm64/kernel/sys_ilp32.c                 |  86 ++++++++
 arch/arm64/kernel/traps.c                     |   5 +-
 arch/arm64/kernel/vdso-ilp32/.gitignore       |   2 +
 arch/arm64/kernel/vdso-ilp32/Makefile         |  74 +++++++
 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S     |  33 +++
 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S |  95 +++++++++
 arch/arm64/kernel/vdso.c                      |  65 ++++--
 arch/arm64/kernel/vdso/gettimeofday.S         |  20 +-
 arch/blackfin/Kconfig                         |   1 +
 arch/cris/Kconfig                             |   1 +
 arch/frv/Kconfig                              |   1 +
 arch/h8300/Kconfig                            |   1 +
 arch/hexagon/Kconfig                          |   1 +
 arch/m32r/Kconfig                             |   1 +
 arch/m68k/Kconfig                             |   1 +
 arch/metag/Kconfig                            |   1 +
 arch/microblaze/Kconfig                       |   1 +
 arch/mips/Kconfig                             |   1 +
 arch/mn10300/Kconfig                          |   1 +
 arch/nios2/Kconfig                            |   1 +
 arch/openrisc/Kconfig                         |   1 +
 arch/parisc/Kconfig                           |   1 +
 arch/powerpc/Kconfig                          |   1 +
 arch/s390/Kconfig                             |   1 +
 arch/s390/include/asm/compat.h                |  17 +-
 arch/s390/kernel/Makefile                     |   2 +-
 arch/s390/kernel/compat_linux.c               |   4 +
 arch/s390/kernel/compat_wrapper.c             | 180 -----------------
 arch/score/Kconfig                            |   1 +
 arch/sh/Kconfig                               |   1 +
 arch/sparc/Kconfig                            |   1 +
 arch/tile/Kconfig                             |   1 +
 arch/tile/kernel/compat.c                     |   3 +
 arch/unicore32/Kconfig                        |   1 +
 arch/x86/Kconfig                              |   1 +
 arch/x86/um/Kconfig                           |   1 +
 arch/xtensa/Kconfig                           |   1 +
 drivers/clocksource/arm_arch_timer.c          |   2 +-
 include/linux/compat.h                        | 277 ++++++++++++++++++++++++++
 include/linux/fcntl.h                         |   2 +-
 include/linux/ptrace.h                        |   6 +
 include/linux/syscalls.h                      |  57 +-----
 include/linux/syscalls_structs.h              |  60 ++++++
 include/linux/thread_bits.h                   |  55 +++++
 include/linux/thread_info.h                   |  44 +---
 include/uapi/asm-generic/unistd.h             | 231 ++++++++++-----------
 kernel/Makefile                               |   1 +
 kernel/compat_wrapper.c                       | 175 ++++++++++++++++
 kernel/ptrace.c                               |  10 +-
 92 files changed, 2024 insertions(+), 641 deletions(-)
 create mode 100644 Documentation/arm64/ilp32.txt
 create mode 100644 arch/arm64/include/asm/is_compat.h
 create mode 100644 arch/arm64/include/asm/signal32_common.h
 create mode 100644 arch/arm64/include/asm/signal_common.h
 create mode 100644 arch/arm64/include/asm/signal_ilp32.h
 create mode 100644 arch/arm64/kernel/binfmt_elf32.c
 create mode 100644 arch/arm64/kernel/binfmt_ilp32.c
 create mode 100644 arch/arm64/kernel/entry_ilp32.S
 create mode 100644 arch/arm64/kernel/signal32_common.c
 create mode 100644 arch/arm64/kernel/signal_ilp32.c
 create mode 100644 arch/arm64/kernel/sys_ilp32.c
 create mode 100644 arch/arm64/kernel/vdso-ilp32/.gitignore
 create mode 100644 arch/arm64/kernel/vdso-ilp32/Makefile
 create mode 100644 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S
 create mode 100644 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S
 delete mode 100644 arch/s390/kernel/compat_wrapper.c
 create mode 100644 include/linux/syscalls_structs.h
 create mode 100644 include/linux/thread_bits.h
 create mode 100644 kernel/compat_wrapper.c

-- 
2.5.0
