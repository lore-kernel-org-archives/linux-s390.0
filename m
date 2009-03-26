Return-Path: <linux-kernel-owner+w=401wt.eu-S1758631AbZCZOaW@vger.kernel.org>
Date: Thu, 26 Mar 2009 15:29:56 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for the 2.6.30 merge window
Message-ID: <20090326152956.2c22a502@skybase>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from 'for-linus' branch of

	git://git390.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

Andreas Krebbel (1):
      [S390] Add hwcap flag for the etf3 enhancement facility

Carsten Otte (2):
      [S390] check addressing mode in s390_enable_sie
      [S390] tape message cleanup

Christian Borntraeger (4):
      [S390] fix dump_stack vs. %p and (null)
      [S390] lockdep: trace hardirq off in smp_send_stop
      [S390] Fix hypervisor detection for KVM
      [S390] Fix comments in lowcore structure

Christian Ehrhardt (1):
      [S390] fix dfp elf hwcap/facility bit detection

Cornelia Huck (3):
      [S390] cio: Use unbind/bind instead of unregister/register.
      [S390] cio: Try harder to disable subchannel.
      [S390] cio: Use ccw_device_set_notoper().

Dan Smith (1):
      [S390] Expose a constant for the number of words representing the CRs

Eric Sesterhenn (1):
      [S390] list usage cleanup in s390

Felix Beck (1):
      [S390] Add zcrypt section in MAINTAINERS

Frank Munzert (2):
      [S390] Automatic IPL after dump
      [S390] Use csum_partial in checksum.h

Gerald Schaefer (1):
      [S390] kernel: Disable switch_amode by default

Heiko Carstens (18):
      [S390] page fault: invoke oom-killer
      [S390] dasd: enable compat ioctls
      [S390] move sysinfo.c from drivers/s390 to arch/s390/kernel
      [S390] delete drivers/s390/ebcdic.c
      [S390] arch/s390/kernel/process.c: fix whitespace damage
      [S390] cputime: initialize per thread timer values on fork
      [S390] ftrace: dont trace machine check handler
      [S390] split/move machine check handler code
      [S390] Remove CONFIG_MACHCHK_WARNING.
      [S390] convert bitmap definitions to C
      [S390] move EXPORT_SYMBOLs to definitions
      [S390] cio/crw: add/fix locking
      [S390] cio: ensure single load of irq handler pointer
      [S390] bitops: remove likely annotations
      [S390] use compiler builtin versions of strlen/strcpy/strcat
      [S390] smp: fix memory leak on __cpu_up
      [S390] smp: perform initial cpu reset before starting a cpu
      [S390] fix clock comparator save area usage

Hendrik Brueckner (3):
      [S390] hvc_iucv: Update and add missing kernel messages
      [S390] hvc_iucv: Provide IUCV z/VM user ID filtering
      [S390] remove duplicate nul-termination of string

Huang Weiyi (1):
      [S390] remove duplicated #includes

Jan Glauber (9):
      [S390] qdio: add missing tiq_list locking
      [S390] qdio: Dont call qdio_shutdown in case qdio_activate fails
      [S390] qdio: proper kill of qdio tasklets
      [S390] qdio: call qdio_free also if qdio_shutdown fails
      [S390] qdio: move ACK to newest buffer for devices without QEBSM
      [S390] qdio: seperate last move index and polling index
      [S390] qdio: tasklet termination in case of module unload
      [S390] qdio: report SIGA errors directly
      [S390] qdio: merge inbound and outbound handler functions

Jean-Baptiste Joret (1):
      [S390] dasd_eckd / Write format R0 is now allowed BB

Johannes Weiner (1):
      [S390] use kzfree()

Martin Schwidefsky (5):
      [S390] clock sync mode flags
      [S390] module function call optimization
      [S390] eliminate cpuinfo_S390 structure
      [S390] eliminate ipl_device from lowcore
      [S390] cleanup lowcore.h

Michael Holzheu (5):
      [S390] zfcpdump: Prevent zcore from beeing built as a kernel module.
      [S390] s390dbf: Remove redundant initilizations.
      [S390] s390dbf: Remove needless check for NULL pointer.
      [S390] ipl: Improve checking logic and remove switch defaults.
      [S390] Ensure that ipl panic notifier is called late.

Peter Oberparleiter (2):
      [S390] cio: incorrect status check in interrogate function
      [S390] cio: prevent workqueue deadlock

Rusty Russell (5):
      [S390] allow usage of string functions in linux/string.h
      [S390] cpumask: remove cpu_coregroup_map
      [S390] cpumask: prepare for iterators to only go to nr_cpu_ids/nr_cpumask_bits.
      [S390] cpumask: Use accessors code.
      [S390] cpumask: use mm_cpumask() wrapper

Sachin Sant (1):
      [S390] Fix appldata build break with !NET

Sebastian Ott (9):
      [S390] cio: ccw device online store - report rc from ccw driver.
      [S390] cio: device scan oom fallback.
      [S390] cio: airq - fix array boundary
      [S390] cio: ccw group online store - report rcs to the caller.
      [S390] cio: fix sanity checks in ccwgroup driver.
      [S390] cio: ccw group fix unbind behaviour.
      [S390] cio: fix wrong buffer access in cio_ignore_write
      [S390] cio: fix rc generation after chsc call
      [S390] cio: remove unused local variable

Stefan Haberland (1):
      [S390] dasd: message cleanup

Stefan Weinhuber (2):
      [S390] dasd: add large volume support
      [S390] dasd: add High Performance FICON support

Stoyan Gaydarov (1):
      [S390] BUG to BUG_ON changes

 Documentation/kernel-parameters.txt               |    3 +
 MAINTAINERS                                       |    9 +
 arch/s390/Kconfig                                 |   11 +-
 arch/s390/crypto/prng.c                           |    3 +-
 arch/s390/include/asm/bitops.h                    |   14 +-
 arch/s390/include/asm/crw.h                       |   68 ++
 arch/s390/include/asm/dasd.h                      |   10 +-
 arch/s390/include/asm/idals.h                     |   17 +-
 arch/s390/include/asm/lowcore.h                   |  653 ++++++-----
 arch/s390/include/asm/mmu_context.h               |    2 +-
 arch/s390/include/asm/nmi.h                       |   66 ++
 arch/s390/include/asm/processor.h                 |   16 +-
 arch/s390/include/asm/ptrace.h                    |    4 +-
 arch/s390/include/asm/qdio.h                      |    1 +
 arch/s390/include/asm/smp.h                       |    7 +-
 arch/s390/include/asm/string.h                    |   16 +-
 arch/s390/include/asm/sysinfo.h                   |    1 +
 arch/s390/include/asm/tlbflush.h                  |    4 +-
 arch/s390/include/asm/topology.h                  |    1 -
 arch/s390/include/asm/vtoc.h                      |   16 +-
 arch/s390/kernel/Makefile                         |    4 +-
 arch/s390/kernel/bitmap.S                         |   56 -
 arch/s390/kernel/bitmap.c                         |   54 +
 arch/s390/kernel/compat_ptrace.h                  |    3 +-
 arch/s390/kernel/debug.c                          |    9 +-
 arch/s390/kernel/early.c                          |   23 +-
 arch/s390/kernel/head.S                           |    2 +
 arch/s390/kernel/head31.S                         |    1 -
 arch/s390/kernel/head64.S                         |    1 -
 arch/s390/kernel/ipl.c                            |   74 +-
 arch/s390/kernel/module.c                         |   19 +-
 drivers/s390/s390mach.c => arch/s390/kernel/nmi.c |  278 +----
 arch/s390/kernel/process.c                        |   73 +-
 arch/s390/kernel/processor.c                      |   73 +-
 arch/s390/kernel/reipl64.S                        |   11 +-
 arch/s390/kernel/s390_ksyms.c                     |   44 -
 arch/s390/kernel/setup.c                          |   52 +-
 arch/s390/kernel/smp.c                            |   68 +-
 {drivers/s390 => arch/s390/kernel}/sysinfo.c      |   69 +-
 arch/s390/kernel/time.c                           |   71 +-
 arch/s390/kernel/topology.c                       |    2 +-
 arch/s390/kernel/traps.c                          |    4 +-
 arch/s390/kernel/vdso.c                           |    2 -
 arch/s390/kernel/vmlinux.lds.S                    |    2 +
 arch/s390/kvm/kvm-s390.c                          |    6 +-
 arch/s390/lib/delay.c                             |    2 +
 arch/s390/lib/string.c                            |    8 +
 arch/s390/mm/fault.c                              |   28 +-
 arch/s390/mm/init.c                               |    2 +
 arch/s390/mm/pgtable.c                            |    6 +-
 drivers/char/hvc_iucv.c                           |  259 ++++-
 drivers/s390/Makefile                             |    3 -
 drivers/s390/block/dasd.c                         |  249 +++--
 drivers/s390/block/dasd_3990_erp.c                |  871 ++++++++-------
 drivers/s390/block/dasd_alias.c                   |   35 +-
 drivers/s390/block/dasd_devmap.c                  |   43 +-
 drivers/s390/block/dasd_diag.c                    |   66 +-
 drivers/s390/block/dasd_eckd.c                    | 1297 +++++++++++++++++----
 drivers/s390/block/dasd_eckd.h                    |   49 +-
 drivers/s390/block/dasd_eer.c                     |   27 +-
 drivers/s390/block/dasd_erp.c                     |   21 +-
 drivers/s390/block/dasd_fba.c                     |   77 +-
 drivers/s390/block/dasd_genhd.c                   |    7 +-
 drivers/s390/block/dasd_int.h                     |   13 +-
 drivers/s390/block/dasd_ioctl.c                   |   46 +-
 drivers/s390/block/dasd_proc.c                    |   22 +-
 drivers/s390/char/tape.h                          |    2 -
 drivers/s390/char/tape_34xx.c                     |  161 ++--
 drivers/s390/char/tape_3590.c                     |  367 +++---
 drivers/s390/char/tape_block.c                    |   18 +-
 drivers/s390/char/tape_char.c                     |    7 -
 drivers/s390/char/tape_core.c                     |   68 +-
 drivers/s390/char/tape_proc.c                     |    3 -
 drivers/s390/char/tape_std.c                      |   25 +-
 drivers/s390/char/zcore.c                         |   90 ++-
 drivers/s390/cio/Makefile                         |    2 +-
 drivers/s390/cio/airq.c                           |    6 +-
 drivers/s390/cio/blacklist.c                      |    3 +-
 drivers/s390/cio/ccwgroup.c                       |   73 +-
 drivers/s390/cio/chp.c                            |    6 +-
 drivers/s390/cio/chsc.c                           |    7 +-
 drivers/s390/cio/cio.c                            |   21 +-
 drivers/s390/cio/crw.c                            |  159 +++
 drivers/s390/cio/css.c                            |   58 +-
 drivers/s390/cio/device.c                         |   44 +-
 drivers/s390/cio/device.h                         |    2 +-
 drivers/s390/cio/device_fsm.c                     |    8 +-
 drivers/s390/cio/device_ops.c                     |    2 +-
 drivers/s390/cio/qdio.h                           |    8 +-
 drivers/s390/cio/qdio_debug.c                     |    3 +-
 drivers/s390/cio/qdio_main.c                      |  222 ++--
 drivers/s390/cio/qdio_setup.c                     |    1 -
 drivers/s390/cio/qdio_thinint.c                   |   23 +-
 drivers/s390/crypto/zcrypt_api.c                  |    6 +-
 drivers/s390/crypto/zcrypt_pcixcc.c               |    3 +-
 drivers/s390/ebcdic.c                             |  246 ----
 drivers/s390/net/qeth_core_main.c                 |   55 +-
 drivers/s390/s390mach.h                           |  122 --
 fs/partitions/ibm.c                               |  101 ++-
 99 files changed, 4059 insertions(+), 2917 deletions(-)
 create mode 100644 arch/s390/include/asm/crw.h
 create mode 100644 arch/s390/include/asm/nmi.h
 delete mode 100644 arch/s390/kernel/bitmap.S
 create mode 100644 arch/s390/kernel/bitmap.c
 rename drivers/s390/s390mach.c => arch/s390/kernel/nmi.c (62%)
 rename {drivers/s390 => arch/s390/kernel}/sysinfo.c (88%)
 create mode 100644 drivers/s390/cio/crw.c
 delete mode 100644 drivers/s390/ebcdic.c
 delete mode 100644 drivers/s390/s390mach.h
