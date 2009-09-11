Return-Path: <linux-kernel-owner+w=401wt.eu-S1752200AbZIKMLE@vger.kernel.org>
Date: Fri, 11 Sep 2009 14:11:01 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for v2.6.31+
Message-ID: <20090911141101.11f39d43@skybase>
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

Christoph Hellwig (1):
      [S390] remove unused irq_cpustat_t defintion

Felix Beck (2):
      [S390] zcrypt: Use spin_lock_bh in suspend callback
      [S390] zcrypt: Free ap_device if dev_set_name fails.

Frank Munzert (1):
      [S390] tape: use init_timer_on_stack() rather than init_timer()

Hans-Joachim Picht (1):
      [S390] add call home support

Heiko Carstens (15):
      [S390] cio: move scsw helper functions to header file
      [S390] introduce get_clock_monotonic
      [S390] convert/optimize csum_fold() to C
      [S390] atomic ops: add effecient atomic64 support for 31 bit
      [S390] atomic ops: small cleanups
      [S390] hibernation: remove dead file
      [S390] hibernation: merge files and move to kernel/
      [S390] kernel: always keep machine flags in lowcore
      [S390] Initialize __LC_THREAD_INFO early.
      [S390] use generic scatterlist.h
      [S390] Enable guest page hinting by default.
      [S390] Limit cpu detection to 256 physical cpus.
      [S390] Get rid of cpuid.h header file.
      [S390] Remove smp_cpu_not_running.
      [S390] Wire up page fault events for software perf counters.

Hendrik Brueckner (5):
      [S390] kernel: Append scpdata to kernel boot command line
      [S390] kernel: Convert upper case scpdata to lower case
      [S390] move (io|sysc)_restore_trace_psw into .data section
      [S390] kernel: Print an error message if kernel NSS cannot be defined
      [S390] kvm: use console_initcall() to initialize s390 virtio console

Jan Glauber (2):
      [S390] qdio: continue polling if the queue is not finished
      [S390] qdio: remove limited number of debugfs entries

Martin Schwidefsky (2):
      [S390] improve mcount code
      [S390] fix recursive locking on page_table_lock

Michael Ernst (1):
      [S390] cio: failing set online/offline processing.

Michael Holzheu (6):
      [S390] vmur: Invalid allocation sequence for vmur class
      [S390] xpram: Remove checksum validation for suspend/resume
      [S390] hypfs: Use "%u" instead of "%d" for unsigned ints in snprintf
      [S390] s390dbf: Add description for usage of "%s" in sprintf events
      [S390] tape: Fix device online messages
      [S390] tape: Use pr_xxx instead of dev_xxx in shared driver code

Nelson Elhage (1):
      [S390] clean up linker script using new linker script macros.

Peter Oberparleiter (2):
      [S390] cio: fix ineffective verify event
      [S390] cio: consolidate subchannel intparm reset

Roel Kluin (1):
      [S390] tape: reversed order of labels

Sebastian Ott (9):
      [S390] cio: fix not oper handling after failed [on|off]line processing
      [S390] cio: increase trace level
      [S390] cio: ensure to hold a reference for deferred deregistration
      [S390] cio: fix use after free in s390 debug feature
      [S390] cio: fix memleak in subchannel validation
      [S390] cio: remove subchannel init_name
      [S390] cio: move final put_device to ccw_device_unregister
      [S390] cio: remove ccw_device init_name
      [S390] proper use of device register

Stefan Haberland (2):
      [S390] dasd: optimize cpu usage in goodcase
      [S390] dasd: fix message naming

Stefan Weinhuber (1):
      [S390] dasd: fail requests when device state is less then ready

Tim Abbott (1):
      [S390] Use macros for .data.page_aligned.

Vitaliy Gusev (1):
      [S390] hypfs: remove useless variable qname

 Documentation/s390/s390dbf.txt                     |    7 +
 Documentation/sysctl/kernel.txt                    |   16 +
 arch/s390/Kconfig                                  |    8 -
 arch/s390/Makefile                                 |    3 +-
 arch/s390/hypfs/inode.c                            |    6 +-
 arch/s390/include/asm/atomic.h                     |  205 +++++++++----
 arch/s390/include/asm/checksum.h                   |   25 +--
 arch/s390/include/asm/chsc.h                       |   28 ++
 arch/s390/include/asm/cio.h                        |  223 +-------------
 arch/s390/include/asm/cpu.h                        |   26 ++
 arch/s390/include/asm/cpuid.h                      |   25 --
 arch/s390/include/asm/debug.h                      |    9 +-
 arch/s390/include/asm/hardirq.h                    |    7 -
 arch/s390/include/asm/ipl.h                        |    5 +-
 arch/s390/include/asm/kvm_host.h                   |    6 +-
 arch/s390/include/asm/kvm_virtio.h                 |   10 -
 arch/s390/include/asm/lowcore.h                    |    6 +-
 arch/s390/include/asm/mmu.h                        |    1 +
 arch/s390/include/asm/page.h                       |    4 -
 arch/s390/include/asm/pgalloc.h                    |    1 +
 arch/s390/include/asm/processor.h                  |    4 +-
 arch/s390/include/asm/scatterlist.h                |   20 +-
 .../cio/scsw.c => arch/s390/include/asm/scsw.h     |  345 +++++++++++++-------
 arch/s390/include/asm/setup.h                      |    2 +-
 arch/s390/include/asm/smp.h                        |   32 +--
 arch/s390/include/asm/system.h                     |    4 -
 arch/s390/include/asm/timex.h                      |   14 +
 arch/s390/kernel/Makefile                          |    4 +-
 arch/s390/kernel/early.c                           |   74 +++--
 arch/s390/kernel/entry.S                           |   16 +-
 arch/s390/kernel/entry64.S                         |    4 +
 arch/s390/kernel/head.S                            |    1 +
 arch/s390/kernel/head31.S                          |    1 +
 arch/s390/kernel/head64.S                          |    9 +-
 arch/s390/kernel/ipl.c                             |  166 +++++++++-
 arch/s390/kernel/mcount.S                          |  147 +--------
 arch/s390/kernel/mcount64.S                        |   78 +++++
 arch/s390/kernel/setup.c                           |   10 +-
 arch/s390/kernel/smp.c                             |   39 ++-
 arch/s390/kernel/suspend.c                         |   73 ++++
 arch/s390/{power => kernel}/swsusp_asm64.S         |    2 +-
 arch/s390/kernel/time.c                            |    3 +-
 arch/s390/kernel/vmlinux.lds.S                     |   87 +-----
 arch/s390/mm/Makefile                              |    4 +-
 arch/s390/mm/fault.c                               |   13 +-
 arch/s390/mm/page-states.c                         |    6 +-
 arch/s390/mm/pgtable.c                             |   24 +-
 arch/s390/mm/vmem.c                                |    1 +
 arch/s390/power/Makefile                           |    8 -
 arch/s390/power/suspend.c                          |   40 ---
 arch/s390/power/swsusp.c                           |   42 ---
 arch/s390/power/swsusp_64.c                        |   17 -
 drivers/char/hvc_iucv.c                            |    2 +-
 drivers/s390/block/dasd.c                          |   26 +-
 drivers/s390/block/dasd_3990_erp.c                 |    2 +-
 drivers/s390/block/dasd_alias.c                    |    5 +-
 drivers/s390/block/dasd_diag.c                     |    5 +-
 drivers/s390/block/dasd_eckd.c                     |   47 ++--
 drivers/s390/block/dasd_eer.c                      |    4 +-
 drivers/s390/block/dasd_erp.c                      |    4 +-
 drivers/s390/block/dasd_fba.c                      |    9 +-
 drivers/s390/block/dasd_int.h                      |   11 +-
 drivers/s390/block/dasd_ioctl.c                    |   24 +-
 drivers/s390/block/xpram.c                         |   65 ----
 drivers/s390/char/Kconfig                          |   10 +
 drivers/s390/char/Makefile                         |    1 +
 drivers/s390/char/monreader.c                      |    2 +-
 drivers/s390/char/sclp.h                           |    4 +-
 drivers/s390/char/sclp_async.c                     |  224 +++++++++++++
 drivers/s390/char/tape_34xx.c                      |    2 +-
 drivers/s390/char/tape_3590.c                      |    4 +-
 drivers/s390/char/tape_block.c                     |   12 +-
 drivers/s390/char/tape_core.c                      |   18 +-
 drivers/s390/char/tape_std.c                       |    2 +-
 drivers/s390/char/vmlogrdr.c                       |    4 +-
 drivers/s390/char/vmur.c                           |   19 +-
 drivers/s390/char/zcore.c                          |    2 +-
 drivers/s390/cio/Makefile                          |    2 +-
 drivers/s390/cio/chp.c                             |    3 +-
 drivers/s390/cio/chsc.h                            |   24 --
 drivers/s390/cio/cio.c                             |   56 +---
 drivers/s390/cio/cio.h                             |    4 -
 drivers/s390/cio/css.c                             |   32 +-
 drivers/s390/cio/device.c                          |  172 ++++++-----
 drivers/s390/cio/device_fsm.c                      |   22 ++-
 drivers/s390/cio/qdio.h                            |    4 +-
 drivers/s390/cio/qdio_debug.c                      |   55 +---
 drivers/s390/cio/qdio_main.c                       |    4 +-
 drivers/s390/crypto/ap_bus.c                       |   17 +-
 drivers/s390/kvm/kvm_virtio.c                      |    8 +-
 drivers/s390/net/netiucv.c                         |    9 +-
 drivers/s390/net/smsgiucv.c                        |    6 +-
 92 files changed, 1475 insertions(+), 1362 deletions(-)
 create mode 100644 arch/s390/include/asm/cpu.h
 delete mode 100644 arch/s390/include/asm/cpuid.h
 rename drivers/s390/cio/scsw.c => arch/s390/include/asm/scsw.h (70%)
 create mode 100644 arch/s390/kernel/mcount64.S
 create mode 100644 arch/s390/kernel/suspend.c
 rename arch/s390/{power => kernel}/swsusp_asm64.S (99%)
 delete mode 100644 arch/s390/power/Makefile
 delete mode 100644 arch/s390/power/suspend.c
 delete mode 100644 arch/s390/power/swsusp.c
 delete mode 100644 arch/s390/power/swsusp_64.c
 create mode 100644 drivers/s390/char/sclp_async.c
