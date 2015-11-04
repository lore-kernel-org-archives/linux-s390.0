Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 4 Nov 2015 10:55:12 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for the 4.4 merge window
Message-ID: <20151104105512.1e35819e@mschwide>
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

There is only one new feature in this pull for the 4.4 merge window,
most of it is small enhancements, cleanup and bug fixes.

* Add the s390 backend for the software dirty bit tracking. This adds two
  new pgtable functions pte_clear_soft_dirty and pmd_clear_soft_dirty which
  is why there is a hit to arch/x86/include/asm/pgtable.h in this pull
  request.
* A series of cleanup patches for the AP bus, this includes the removal of
  the support for two outdated crypto cards (PCICC and PCICA).
* The irq handling / signaling on buffer full in the runtime instrumentation
  code is dropped.
* Some micro optimizations: remove unnecessary memory barriers for a couple
  of functions: [smb_]rmb, [smb_]wmb, atomics, bitops, and for spin_unlock.
  Use the builtin bswap if available and make test_and_set_bit_lock more
  cache friendly.
* Statistics and a tracepoint for the diagnose calls to the hypervisor.
* The CPU measurement facility support to sample KVM guests is improved.
* The vector instructions are now always enabled for user space processes
  if the hardware has the vector facility. This simplifies the FPU handling
  code. The fpu-internal.h header is split into fpu internals, api and types
  just like x86.
* Cleanup and improvements for the common I/O layer.
* Rework udelay to solve a problem with kprobe. udelay has busy loop
  semantics but still uses an idle processor state for the wait.

Alexander Kuleshov (1):
      s390/crash_dump: use for_each_mem_range

Christian Borntraeger (8):
      s390/dasd: mark DASD devices as non rotational
      s390/spinlock: use correct barriers
      s390/vdso: use correct memory barrier
      s390/barrier: avoid serialization in [smp_]rmb and [smp_]wmb
      s390/cpumf: rework program parameter setting to detect guest samples
      s390/compiler.h Fix sparse vs. hotpatch
      s390/spinlock: remove unneeded serializations at unlock
      s390/Kconfig: use builtin bswap

Heiko Carstens (14):
      s390/udelay: make udelay have busy loop semantics
      s390/flags: fix flag handling
      s390/flags: use _BITUL macro
      s390/nmi: change type of mcck_interruption_code lowcore field
      s390/cmpxchg: remove dead code
      s390/bitops: remove 31 bit related comments
      s390/etr,stp: fix possible deadlock on machine check
      s390: get rid of __set_psw_mask()
      s390: don't store registers on disabled wait anymore
      s390/nmi: remove pointless error strings
      s390/nmi: remove casts
      s390/nmi: fix terminology
      s390/nmi: reduce size of percpu variable
      s390/topology: reduce per_cpu() invocations

Hendrik Brueckner (4):
      s390/fpu: always enable the vector facility if it is available
      s390/fpu: add static FPU save area for init_task
      s390/entry: add assembler macro to conveniently tests under mask
      s390/fpu: split fpu-internal.h into fpu internals, api, and type headers

Ingo Tuchscherer (1):
      s390/zcrypt: enable odd RSA modulus sizes in CRT format

Martin Schwidefsky (20):
      mm: add architecture primitives for software dirty bit clearing
      s390/mm: implement soft-dirty bits for user memory change tracking
      s390/bitops: implement cache friendly test_and_set_bit_lock
      s390/diag: add a statistic for diagnose calls
      s390/diag: add tracepoint for diagnose calls
      s390/barrier: remove unnecessary serialization in atomics and bitops
      s390/mm: try to avoid storage key operation in ptep_set_access_flags
      s390/sclp: avoid merged message output
      s390/asm: make use of the OFFSET macro to define assember constants
      s390/zcrypt: remove duplicate low level functions
      s390/zcrypt: fix memory leak with ap configuration data
      s390/zcrypt: fix device unregister race
      s390/zcrypt: fix suspend/resume of AP bus devices
      s390/zcrypt: cleanup AP bus timer code
      s390/zcrypt: use explicit return code for flushed requests
      s390/zcrypt: introduce state machine for the AP bus
      s390/zcrypt: remove support for PCICC and PCICA cards
      s390/zcrypt: use system work queue for ap_scan_bus
      s390/kernel: fix ptrace peek/poke for floating point registers
      s390: remove runtime instrumentation interrupts

Michael Holzheu (1):
      s390/numa: write kernel message when emu_size has been increased

Pierre Morel (2):
      s390/css: unneeded initialization in for_each_subchannel
      s390/cio: de-duplicate subchannel validation

Sebastian Ott (11):
      s390/cio: cleanup cmb_enable sysfs attr
      s390/cio: use device_lock during cmb activation
      s390/cio: fix use after free in cmb processing
      s390/cio: improve locking during cmbe allocation
      s390/cio: fix memleak in channel measurement
      s390/cio: use kmem_cache for extended measurement block allocation
      s390/cio: reactivate cmf after hibernate
      s390/cio: introduce pathmask_to_pos
      s390/pci: reshuffle struct used to write debug data
      s390/cio: move ccw_device_call_handler
      s390/cio: move ccw_device_stlck functions

Stefan Haberland (4):
      s390/dasd: fix list_del corruption after lcu changes
      s390/dasd: fix double free in dasd_eckd_read_conf
      s390/dasd: fix invalid PAV assignment after suspend/resume
      s390/dasd: fix disconnected device with valid path mask

 arch/s390/Kconfig                                  |    2 +
 arch/s390/hypfs/hypfs_diag.c                       |   10 +-
 arch/s390/hypfs/hypfs_diag0c.c                     |    2 +
 arch/s390/hypfs/hypfs_sprp.c                       |    9 +-
 arch/s390/hypfs/hypfs_vm.c                         |    2 +
 arch/s390/include/asm/appldata.h                   |    2 +
 arch/s390/include/asm/atomic.h                     |    2 -
 arch/s390/include/asm/barrier.h                    |    8 +-
 arch/s390/include/asm/bitops.h                     |   55 +-
 arch/s390/include/asm/cio.h                        |   10 +
 arch/s390/include/asm/cmb.h                        |    1 +
 arch/s390/include/asm/cmpxchg.h                    |   30 +-
 arch/s390/include/asm/cpu_mf.h                     |    5 -
 arch/s390/include/asm/ctl_reg.h                    |    2 -
 arch/s390/include/asm/diag.h                       |   29 +
 arch/s390/include/asm/etr.h                        |   10 +-
 arch/s390/include/asm/fpu/api.h                    |   30 +
 .../include/asm/{fpu-internal.h => fpu/internal.h} |   51 +-
 arch/s390/include/asm/fpu/types.h                  |   25 +
 arch/s390/include/asm/idle.h                       |    2 +
 arch/s390/include/asm/irq.h                        |   14 +-
 arch/s390/include/asm/kvm_host.h                   |    2 +-
 arch/s390/include/asm/kvm_para.h                   |   67 +-
 arch/s390/include/asm/lowcore.h                    |   11 +-
 arch/s390/include/asm/nmi.h                        |   98 +-
 arch/s390/include/asm/pgtable.h                    |   66 +-
 arch/s390/include/asm/processor.h                  |   99 +-
 arch/s390/include/asm/ptrace.h                     |   11 +-
 arch/s390/include/asm/setup.h                      |   50 +-
 arch/s390/include/asm/spinlock.h                   |    3 -
 arch/s390/include/asm/switch_to.h                  |    2 +-
 arch/s390/include/asm/thread_info.h                |   22 +-
 arch/s390/include/asm/trace/diag.h                 |   43 +
 arch/s390/kernel/Makefile                          |    2 +
 arch/s390/kernel/asm-offsets.c                     |  290 +--
 arch/s390/kernel/compat_signal.c                   |    7 +-
 arch/s390/kernel/cpcmd.c                           |    2 +
 arch/s390/kernel/crash_dump.c                      |   16 +-
 arch/s390/kernel/diag.c                            |  134 +-
 arch/s390/kernel/early.c                           |   15 +-
 arch/s390/kernel/entry.S                           |  230 +--
 arch/s390/kernel/entry.h                           |    3 -
 arch/s390/kernel/head64.S                          |    7 +-
 arch/s390/kernel/ipl.c                             |    9 +-
 arch/s390/kernel/irq.c                             |    1 -
 arch/s390/kernel/nmi.c                             |  120 +-
 arch/s390/kernel/perf_cpum_sf.c                    |   10 +-
 arch/s390/kernel/process.c                         |   37 +-
 arch/s390/kernel/processor.c                       |    5 +-
 arch/s390/kernel/ptrace.c                          |   52 +-
 arch/s390/kernel/runtime_instr.c                   |   64 +-
 arch/s390/kernel/s390_ksyms.c                      |    3 +-
 arch/s390/kernel/signal.c                          |    7 +-
 arch/s390/kernel/smp.c                             |   10 +-
 arch/s390/kernel/time.c                            |   31 +-
 arch/s390/kernel/topology.c                        |   28 +-
 arch/s390/kernel/trace.c                           |   29 +
 arch/s390/kernel/traps.c                           |   41 +-
 arch/s390/kernel/vdso.c                            |    2 +-
 arch/s390/kvm/kvm-s390.c                           |    6 -
 arch/s390/lib/delay.c                              |   30 +-
 arch/s390/lib/find.c                               |    4 +-
 arch/s390/lib/spinlock.c                           |    4 +-
 arch/s390/mm/extmem.c                              |    3 +
 arch/s390/mm/fault.c                               |    7 +-
 arch/s390/mm/hugetlbpage.c                         |    2 +
 arch/s390/numa/mode_emu.c                          |   10 +-
 arch/s390/pci/pci_insn.c                           |    6 +-
 arch/x86/include/asm/pgtable.h                     |   10 +
 drivers/s390/block/dasd.c                          |    1 +
 drivers/s390/block/dasd_alias.c                    |    5 +-
 drivers/s390/block/dasd_diag.c                     |    2 +
 drivers/s390/block/dasd_eckd.c                     |   73 +-
 drivers/s390/char/diag_ftp.c                       |    2 +
 drivers/s390/char/sclp_rw.c                        |  136 +-
 drivers/s390/char/sclp_rw.h                        |   17 +-
 drivers/s390/char/sclp_tty.c                       |    8 +-
 drivers/s390/cio/cio.c                             |   33 +-
 drivers/s390/cio/cmf.c                             |  220 ++-
 drivers/s390/cio/css.c                             |    2 +-
 drivers/s390/cio/device.c                          |    4 +-
 drivers/s390/cio/device.h                          |    6 +-
 drivers/s390/cio/device_fsm.c                      |   38 +
 drivers/s390/cio/device_ops.c                      |  107 --
 drivers/s390/cio/device_pgid.c                     |   70 +-
 drivers/s390/crypto/Makefile                       |    4 +-
 drivers/s390/crypto/ap_bus.c                       | 1850 +++++++++-----------
 drivers/s390/crypto/ap_bus.h                       |   67 +-
 drivers/s390/crypto/zcrypt_api.c                   |    3 +-
 drivers/s390/crypto/zcrypt_cca_key.h               |    2 +-
 drivers/s390/crypto/zcrypt_msgtype50.c             |   28 +-
 drivers/s390/crypto/zcrypt_msgtype6.c              |   59 +-
 drivers/s390/crypto/zcrypt_pcica.c                 |  420 -----
 drivers/s390/crypto/zcrypt_pcica.h                 |  115 --
 drivers/s390/crypto/zcrypt_pcicc.c                 |  627 -------
 drivers/s390/crypto/zcrypt_pcicc.h                 |  174 --
 drivers/s390/virtio/virtio_ccw.c                   |   15 +-
 drivers/watchdog/diag288_wdt.c                     |    4 +
 fs/proc/task_mmu.c                                 |    4 +-
 include/asm-generic/pgtable.h                      |   10 +
 include/linux/compiler.h                           |    2 +-
 101 files changed, 2432 insertions(+), 3688 deletions(-)
 create mode 100644 arch/s390/include/asm/fpu/api.h
 rename arch/s390/include/asm/{fpu-internal.h => fpu/internal.h} (59%)
 create mode 100644 arch/s390/include/asm/fpu/types.h
 create mode 100644 arch/s390/include/asm/trace/diag.h
 create mode 100644 arch/s390/kernel/trace.c
 delete mode 100644 drivers/s390/crypto/zcrypt_pcica.c
 delete mode 100644 drivers/s390/crypto/zcrypt_pcica.h
 delete mode 100644 drivers/s390/crypto/zcrypt_pcicc.c
 delete mode 100644 drivers/s390/crypto/zcrypt_pcicc.h
