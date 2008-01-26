Return-Path: <linux-kernel-owner+w=401wt.eu-S1754002AbYAZNYT@vger.kernel.org>
Subject: Please pull git390 'for-linus' branch
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Content-Type: text/plain
Date: Sat, 26 Jan 2008 14:23:54 +0100
Message-Id: <1201353834.16536.5.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

 Documentation/DocBook/s390-drivers.tmpl |    1 +
 Documentation/cpu-hotplug.txt           |    2 +-
 Documentation/kernel-parameters.txt     |    9 +-
 Documentation/s390/CommonIO             |    5 +
 arch/s390/Kconfig                       |    3 -
 arch/s390/crypto/Kconfig                |   60 --
 arch/s390/crypto/aes_s390.c             |    2 +-
 arch/s390/crypto/prng.c                 |    4 +-
 arch/s390/kernel/Makefile               |    4 -
 arch/s390/kernel/early.c                |    2 +-
 arch/s390/kernel/head64.S               |    2 +-
 arch/s390/kernel/ipl.c                  |  948 +++++++++++------
 arch/s390/kernel/process.c              |   18 +-
 arch/s390/kernel/ptrace.c               |   15 +-
 arch/s390/kernel/setup.c                |  139 +--
 arch/s390/kernel/signal.c               |   20 +-
 arch/s390/kernel/smp.c                  |  575 ++++++++---
 arch/s390/kernel/traps.c                |   20 +-
 arch/s390/kernel/vmlinux.lds.S          |   12 +-
 arch/s390/lib/spinlock.c                |   35 +-
 arch/s390/mm/extmem.c                   |    2 +-
 arch/s390/mm/vmem.c                     |   26 +-
 drivers/crypto/Kconfig                  |   63 ++-
 drivers/s390/block/Makefile             |    4 +-
 drivers/s390/block/dasd.c               | 1690 +++++++++++++++++--------------
 drivers/s390/block/dasd_3370_erp.c      |   84 --
 drivers/s390/block/dasd_3990_erp.c      |  360 +++-----
 drivers/s390/block/dasd_9336_erp.c      |   41 -
 drivers/s390/block/dasd_9343_erp.c      |   21 -
 drivers/s390/block/dasd_alias.c         |  903 +++++++++++++++++
 drivers/s390/block/dasd_devmap.c        |   94 +-
 drivers/s390/block/dasd_diag.c          |  107 ++-
 drivers/s390/block/dasd_eckd.c          |  789 +++++++++++----
 drivers/s390/block/dasd_eckd.h          |  125 +++-
 drivers/s390/block/dasd_eer.c           |   11 +-
 drivers/s390/block/dasd_erp.c           |   25 +-
 drivers/s390/block/dasd_fba.c           |  119 ++-
 drivers/s390/block/dasd_genhd.c         |   76 +-
 drivers/s390/block/dasd_int.h           |  209 +++--
 drivers/s390/block/dasd_ioctl.c         |  172 ++--
 drivers/s390/block/dasd_proc.c          |   23 +-
 drivers/s390/block/dcssblk.c            |    2 +-
 drivers/s390/char/Makefile              |    2 +-
 drivers/s390/char/monwriter.c           |    2 +-
 drivers/s390/char/raw3270.c             |    4 +-
 drivers/s390/char/sclp.h                |    4 +-
 drivers/s390/char/sclp_chp.c            |  200 ----
 drivers/s390/char/sclp_cmd.c            |  398 ++++++++
 drivers/s390/char/sclp_cpi.c            |  246 +-----
 drivers/s390/char/sclp_cpi_sys.c        |  400 ++++++++
 drivers/s390/char/sclp_cpi_sys.h        |   15 +
 drivers/s390/char/sclp_info.c           |  116 ---
 drivers/s390/char/sclp_rw.c             |    2 +-
 drivers/s390/char/tape_3590.c           |    2 +-
 drivers/s390/char/tape_core.c           |    2 +-
 drivers/s390/char/tape_proc.c           |    2 +-
 drivers/s390/char/vmlogrdr.c            |    2 +-
 drivers/s390/char/vmur.c                |    2 +-
 drivers/s390/char/zcore.c               |    2 +-
 drivers/s390/cio/airq.c                 |  171 +++-
 drivers/s390/cio/airq.h                 |   10 -
 drivers/s390/cio/blacklist.c            |    2 +-
 drivers/s390/cio/ccwgroup.c             |   25 +-
 drivers/s390/cio/chsc.c                 |  121 +--
 drivers/s390/cio/cio.c                  |  106 ++-
 drivers/s390/cio/cio.h                  |   89 +-
 drivers/s390/cio/cio_debug.h            |   22 +-
 drivers/s390/cio/css.c                  |  198 +++-
 drivers/s390/cio/css.h                  |   78 +--
 drivers/s390/cio/device.c               |  157 +++-
 drivers/s390/cio/device.h               |    5 +-
 drivers/s390/cio/device_fsm.c           |  124 ++-
 drivers/s390/cio/device_id.c            |    9 +-
 drivers/s390/cio/device_ops.c           |    2 +-
 drivers/s390/cio/device_pgid.c          |    6 +-
 drivers/s390/cio/device_status.c        |   13 +-
 drivers/s390/cio/io_sch.h               |  163 +++
 drivers/s390/cio/ioasm.h                |   66 --
 drivers/s390/cio/qdio.c                 |   38 +-
 drivers/s390/cio/qdio.h                 |    2 +-
 drivers/s390/net/claw.c                 |    2 +-
 drivers/s390/net/lcs.c                  |    2 +-
 drivers/s390/net/netiucv.c              |    3 +-
 drivers/s390/net/qeth_proc.c            |    4 +-
 drivers/s390/net/smsgiucv.c             |    2 +-
 drivers/s390/scsi/zfcp_erp.c            |    2 +-
 drivers/s390/scsi/zfcp_fsf.c            |   10 +-
 drivers/s390/scsi/zfcp_qdio.c           |    2 +-
 include/asm-s390/airq.h                 |   19 +
 include/asm-s390/cio.h                  |    4 +-
 include/asm-s390/dasd.h                 |    2 +-
 include/asm-s390/ipl.h                  |    8 +-
 include/asm-s390/mmu_context.h          |   27 +-
 include/asm-s390/pgtable.h              |   46 +-
 include/asm-s390/processor.h            |    4 -
 include/asm-s390/ptrace.h               |    8 +
 include/asm-s390/qdio.h                 |    2 +-
 include/asm-s390/rwsem.h                |    4 +-
 include/asm-s390/sclp.h                 |   20 +-
 include/asm-s390/smp.h                  |    5 +-
 include/asm-s390/spinlock.h             |   32 +-
 include/asm-s390/spinlock_types.h       |    1 -
 include/asm-s390/tlbflush.h             |   32 +-
 include/asm-s390/zcrypt.h               |    2 +-
 kernel/sysctl_check.c                   |    1 -
 105 files changed, 6216 insertions(+), 3658 deletions(-)
 delete mode 100644 arch/s390/crypto/Kconfig
 delete mode 100644 drivers/s390/block/dasd_3370_erp.c
 delete mode 100644 drivers/s390/block/dasd_9336_erp.c
 delete mode 100644 drivers/s390/block/dasd_9343_erp.c
 create mode 100644 drivers/s390/block/dasd_alias.c
 delete mode 100644 drivers/s390/char/sclp_chp.c
 create mode 100644 drivers/s390/char/sclp_cmd.c
 create mode 100644 drivers/s390/char/sclp_cpi_sys.c
 create mode 100644 drivers/s390/char/sclp_cpi_sys.h
 delete mode 100644 drivers/s390/char/sclp_info.c
 delete mode 100644 drivers/s390/cio/airq.h
 create mode 100644 drivers/s390/cio/io_sch.h
 create mode 100644 include/asm-s390/airq.h

Carsten Otte (1):
      [S390] add smp_call_function_mask

Christian Borntraeger (2):
      [S390] Change vmalloc defintions
      [S390] vmemmap: allocate struct pages before 1:1 mapping

Cornelia Huck (11):
      [S390] cio: Use helpers instead of container_of().
      [S390] cio: css_driver: Use consistent parameters.
      [S390] cio: Reset sch->driver.
      [S390] cio: Add css_driver_{register,unregister}.
      [S390] cio: Cleanup debug feature usage.
      [S390] cio: Introduce subchannel->private.
      [S390] cio: I/O subchannel specific fields.
      [S390] cio: Use dev_{g,s}et_drvdata().
      [S390] cio: Set driver->owner on css, ccw and ccwgroup busses.
      [S390] cio: Delete timer in ccw_device_verify_done().
      [S390] cio: Fix ungroup vs. machine check race in ccwgroup.

Denis Cheng (1):
      [S390] use LIST_HEAD instead of LIST_HEAD_INIT

Heiko Carstens (9):
      [S390] Standby cpu activation/deactivation.
      [S390] sclp: convert channel path configure code to use sync interface.
      [S390] Print kernel version in dump_stack() and show_regs().
      [S390] Get rid of HOLES_IN_ZONE requirement.
      [S390] Remove owner_pc member from raw_spinlock_t.
      [S390] Use new style spinlock initializer in __RWSEM_INITIALIZER.
      [S390] Get rid of additional_cpus kernel parameter.
      [S390] Remove appldata include from sysctl_check.c
      [S390] Allocate and free cpu lowcores and stacks when needed/possible.

Hisashi Hifumi (1):
      [S390] do local_irq_restore while spinning in spin_lock_irqsave.

Jan Engelhardt (1):
      [S390] constify function pointer tables.

Jan Glauber (1):
      [S390] crypto: move s390 Kconfig options.

Joe Perches (5):
      [S390] arch/s390: Add missing "space"
      [S390] drivers/s390: Add missing "space"
      [S390] arch/s390/: Spelling fixes
      [S390] include/asm-s390/: Spelling fixes
      [S390] drivers/s390/: Spelling fixes

Martin Schwidefsky (5):
      [S390] Fix tlb flushing with idte.
      [S390] Avoid warnings in tlblush.h
      [S390] Move NOTES and BUG_TABLE.
      [S390] Unused field / extern declaration in processor.h
      [S390] replace lock_cpu_hotplug with get_online_cpus

Michael Ernst (2):
      [S390] cio: memory leak in cio processing
      [S390] sclp: sysfs interface for SCLP cpi

Michael Holzheu (4):
      [S390] kernel: Shutdown Actions Interface
      [S390] Load disabled wait psw instead of stopping cpu on halt.
      [S390] Initialize sclp_ipl_info
      [S390] Use diag308 subcodes 3 and 6 for reboot and dump when possible.

Peter Oberparleiter (3):
      [S390] cio: Extend adapter interrupt interface.
      [S390] cio: reduce cpu utilization during device scan
      [S390] cio: introduce timed recovery procedure

Peter Tiedemann (1):
      [S390] usage of s390dbf: shrink number of debug areas to use.

Roland McGrath (1):
      [S390] single-step cleanup

Sebastian Ott (3):
      [S390] Cleanup in Documentation/kernel-parameters.txt.
      [S390] cio: Dump ccw device information in case of timeout.
      [S390] qdio: Remove double checked value.

Stefan Haberland (2):
      [S390] dasd: fix return value of dasd_generic_probe()
      [S390] dasd: fix loop in request expiration handling

Stefan Weinhuber (1):
      [S390] dasd: add hyper PAV support to DASD device driver, part 1

Ursula Braun (1):
      [S390] qdio: set QDIO_ACTIVATE_TIMEOUT to 5s

WANG Cong (1):
      [S390] Remove TOPDIR from Makefile
