Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 4 Mar 2019 13:44:33 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for the 5.1 merge window
MIME-Version: 1.0
Message-Id: <20190304134433.5fa966f4@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8:

  Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux tags/s390-5.1-1

for you to fetch changes up to c533b46e552711575e6120a2ada2b5a7e2354573:

  Revert "s390/cpum_cf: Add kernel message exaplanations" (2019-03-04 08:25:00 +0100)

----------------------------------------------------------------
s390 updates for the 5.1 merge window

 - A copy of Arnds compat wrapper generation series

 - Pass information about the KVM guest to the host in form the control
   program code and the control program version code

 - Map IOV resources to support PCI physical functions on s390

 - Add vector load and store alignment hints to improve performance

 - Use the "jdd" constraint with gcc 9 to make jump labels working again

 - Remove amode workaround for old z/VM releases from the DCSS code

 - Add support for in-kernel performance measurements using the
   CPU measurement counter facility

 - Introduce a new PMU device cpum_cf_diag to capture counters and
   store thenn as event raw data.

 - Bug fixes and cleanups

----------------------------------------------------------------
Arnd Bergmann (5):
      s390: open-code s390_personality syscall
      ipc: introduce ksys_ipc()/compat_ksys_ipc() for s390
      s390: use generic UID16 implementation
      s390: autogenerate compat syscall wrappers
      s390: remove compat_wrapper.c

Christoph Hellwig (1):
      s390: remove the ptep_modify_prot_{start,commit} exports

Collin Walling (1):
      s390/setup: set control program code via diag 318

Eric Farman (2):
      s390/cio: Fix vfio-ccw handling of recursive TICs
      s390/cio: Use cpa range elsewhere within vfio-ccw

Farhan Ali (1):
      vfio-ccw: Don't assume there are more ccws after a TIC

Gerald Schaefer (4):
      s390/setup: remove obsolete #ifdef
      s390: remove dead code
      s390/extmem: remove code for 31 bit addressing mode
      s390/extmem: print DCSS range with %px

Greg Kroah-Hartman (3):
      s390/hypfs: no need to check return value of debugfs_create functions
      s390: pci: no need to check return value of debugfs_create functions
      s390: no need to check return value of debugfs_create functions

Gustavo A. R. Silva (1):
      s390/hypfs: Use struct_size() in kzalloc()

Harald Freudenberger (1):
      s390/zcrypt: use new state UNBOUND during queue driver rebind

Heiko Carstens (1):
      s390: fix system call tracing

Hendrik Brueckner (11):
      s390/cpum_cf: move counter set controls to a new header file
      s390/cpum_cf: prepare for in-kernel counter measurements
      s390/cpum_cf: rename per-CPU counter facility structure and variables
      s390/cpu_mf: move struct cpu_cf_events and per-CPU variable to header file
      s390/cpum_cf: introduce kernel_cpumcf_alert() to obtain measurement alerts
      s390/cpum_cf: Add minimal in-kernel interface for counter measurements
      s390/cpu_mf: add store cpu counter multiple instruction support
      s390/cpu_mf: replace stcctm5() with the stcctm() function
      s390/cpum_cf: introduce kernel_cpumcf_avail() function
      s390/cpum_cf: move common functions into a separate file
      s390/cpum_cf: add ctr_stcctm() function

Ilya Leoshkevich (1):
      s390/jump_label: Use "jdd" constraint on gcc9

Ingo Franzki (1):
      pkey: Indicate old mkvp only if old and current mkvp are different

Julian Wiedmann (1):
      s390/qdio: make SBAL address array type-safe

Martin Schwidefsky (10):
      Merge branch 'compat' of git://git.kernel.org/.../s390/linux into features
      s390/mmap: take stack_guard_gap into account for mmap_base
      s390: add alignment hints to vector load and store
      Merge tag 'vfio-ccw-20190204' of git://git.kernel.org/.../kvms390/vfio-ccw into features
      s390/setup: fix early warning messages
      s390/setup: fix boot crash for machine without EDAT-1
      Merge tag 'vfio-ccw-20190227' of git://git.kernel.org/.../kvms390/vfio-ccw into features
      s390/suspend: fix prefix register reset in swsusp_arch_resume
      s390/dasd: fix read device characteristic with CONFIG_VMAP_STACK=y
      Revert "s390/cpum_cf: Add kernel message exaplanations"

Pierre Morel (1):
      s390: vfio_ap: link the vfio_ap devices to the vfio_ap bus subsystem

Sebastian Ott (3):
      s390/pci: improve bar check
      s390/pci: map IOV resources
      s390/ism: ignore some errors during deregistration

Thomas Richter (3):
      s390/cpum_cf_diag: Add support for s390 counter facility diagnostic trace
      s390/cpum_cf: Add kernel message exaplanations
      s390/cpum_cf: Handle EBUSY return code from CPU counter facility reservation

Vasily Gorbik (5):
      s390/kasan: improve string/memory functions checks
      s390/als: remove duplicated in-place implementation of stfle
      s390: clean up redundant facilities list setup
      s390: allow overriding facilities via command line
      s390: warn about clearing als implied facilities

YueHaibing (1):
      s390: remove unused including <linux/version.h>

 arch/s390/Kconfig                        |   2 +
 arch/s390/boot/als.c                     |  20 +-
 arch/s390/boot/boot.h                    |   2 +
 arch/s390/boot/ipl_parm.c                |  66 ++-
 arch/s390/boot/startup.c                 |   1 +
 arch/s390/boot/string.c                  |   1 +
 arch/s390/hypfs/hypfs.h                  |   6 +-
 arch/s390/hypfs/hypfs_dbfs.c             |   8 +-
 arch/s390/hypfs/hypfs_diag.c             |   9 +-
 arch/s390/hypfs/hypfs_diag0c.c           |   6 +-
 arch/s390/hypfs/hypfs_sprp.c             |   6 +-
 arch/s390/hypfs/hypfs_vm.c               |   3 +-
 arch/s390/hypfs/inode.c                  |  11 +-
 arch/s390/include/asm/cpu_mcf.h          | 126 ++++++
 arch/s390/include/asm/cpu_mf-insn.h      |  22 +
 arch/s390/include/asm/cpu_mf.h           |  18 +-
 arch/s390/include/asm/diag.h             |  12 +
 arch/s390/include/asm/ftrace.h           |  25 ++
 arch/s390/include/asm/jump_label.h       |  14 +-
 arch/s390/include/asm/pci.h              |   1 -
 arch/s390/include/asm/perf_event.h       |   2 +-
 arch/s390/include/asm/qdio.h             |   4 +-
 arch/s390/include/asm/sclp.h             |   1 +
 arch/s390/include/asm/string.h           |  28 +-
 arch/s390/include/asm/syscall_wrapper.h  | 135 ++++++
 arch/s390/include/asm/vx-insn.h          |   8 +-
 arch/s390/include/uapi/asm/posix_types.h |   6 +
 arch/s390/kernel/Makefile                |   6 +-
 arch/s390/kernel/compat_linux.c          | 235 +----------
 arch/s390/kernel/compat_wrapper.c        | 186 ---------
 arch/s390/kernel/debug.c                 |   6 -
 arch/s390/kernel/diag.c                  |   1 +
 arch/s390/kernel/early.c                 |   2 -
 arch/s390/kernel/entry.S                 |   4 +-
 arch/s390/kernel/head64.S                |   2 -
 arch/s390/kernel/kdebugfs.c              |   2 -
 arch/s390/kernel/perf_cpum_cf.c          | 224 ++--------
 arch/s390/kernel/perf_cpum_cf_common.c   | 201 +++++++++
 arch/s390/kernel/perf_cpum_cf_diag.c     | 693 +++++++++++++++++++++++++++++++
 arch/s390/kernel/perf_cpum_cf_events.c   |   1 +
 arch/s390/kernel/setup.c                 |  60 ++-
 arch/s390/kernel/swsusp.S                |   6 +-
 arch/s390/kernel/sys_s390.c              |  16 +-
 arch/s390/kernel/syscalls/syscall.tbl    | 286 ++++++-------
 arch/s390/kernel/sysinfo.c               |   2 -
 arch/s390/kernel/vtime.c                 |   4 +-
 arch/s390/lib/string.c                   |  28 ++
 arch/s390/mm/extmem.c                    | 133 +-----
 arch/s390/mm/kasan_init.c                |   2 -
 arch/s390/mm/mmap.c                      |  33 +-
 arch/s390/mm/pgtable.c                   |   2 -
 arch/s390/pci/pci.c                      |  22 +-
 arch/s390/pci/pci_debug.c                |  15 +-
 drivers/s390/block/dasd.c                |  19 +-
 drivers/s390/char/sclp.h                 |   4 +-
 drivers/s390/char/sclp_early.c           |   2 +
 drivers/s390/cio/qdio_setup.c            |   6 +-
 drivers/s390/cio/vfio_ccw_cp.c           |  55 ++-
 drivers/s390/crypto/ap_bus.c             |  19 +-
 drivers/s390/crypto/ap_bus.h             |   3 +-
 drivers/s390/crypto/ap_queue.c           |   7 +-
 drivers/s390/crypto/pkey_api.c           |   2 +-
 drivers/s390/crypto/vfio_ap_drv.c        |  44 +-
 drivers/s390/crypto/vfio_ap_ops.c        |   4 +-
 drivers/s390/crypto/vfio_ap_private.h    |   1 +
 drivers/s390/net/ism_drv.c               |  12 +-
 drivers/s390/net/qeth_core_main.c        |   4 +-
 drivers/s390/scsi/zfcp_qdio.c            |   4 +-
 include/linux/syscalls.h                 |   4 +
 ipc/syscall.c                            |  20 +-
 kernel/sys_ni.c                          |   1 +
 71 files changed, 1846 insertions(+), 1080 deletions(-)
 create mode 100644 arch/s390/include/asm/cpu_mcf.h
 create mode 100644 arch/s390/include/asm/cpu_mf-insn.h
 create mode 100644 arch/s390/include/asm/syscall_wrapper.h
 delete mode 100644 arch/s390/kernel/compat_wrapper.c
 create mode 100644 arch/s390/kernel/perf_cpum_cf_common.c
 create mode 100644 arch/s390/kernel/perf_cpum_cf_diag.c
