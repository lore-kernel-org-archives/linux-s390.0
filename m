Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 27 Feb 2010 15:00:22 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 2.6.33+
Message-ID: <20100227150022.04bcdf86@mschwide.boeblingen.de.ibm.com>
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

Alexey Dobriyan (1):
      [S390] seq_file: convert drivers/s390/

Gerald Schaefer (1):
      [S390] spinlock: check virtual cpu running status

Heiko Carstens (13):
      [S390] uaccess: implement strict user copy checks
      [S390] cio: fix storage key handling
      [S390] zfcpdump: remove cross arch dump support
      [S390] smp: rename and add lowcore defines
      [S390] smp: always reboot on cpu 0
      [S390] smp: rework sigp code
      [S390] sysinfo: fix SYSIB 3,2,2 structure
      [S390] Replace ENOTSUPP usage with EOPNOTSUPP
      [S390] free_initmem: reduce code duplication
      [S390] Cleanup struct _lowcore usage and defines.
      [S390] bug: use relative pointers in bug table entries
      [S390] use kprobes_built_in() in mm/fault code
      [S390] time: remove unused code

Jan Glauber (2):
      [S390] qdio: account processed SBAL during queue scan
      [S390] qdio: optimize cache line usage of struct qdio_irq

Martin Schwidefsky (6):
      [S390] use inline assembly contraints available with gcc 3.3.3
      [S390] add MACHINE_IS_LPAR flag
      [S390] add z9-ec/z10 instruction to kernel disassembler
      [S390] codepage conversion of kernel parameter line
      [S390] add support for compressed kernels
      [S390] correct vdso version string

Michael Holzheu (2):
      [S390] Define new s390 ELF note sections in elf.h
      [S390] zcore: Add prefix registers to dump header

Sebastian Ott (6):
      [S390] cio: consolidate workqueues
      [S390] cio: introduce cio_settle
      [S390] cio: wait for channel report
      [S390] cio: make wait_events interruptible
      [S390] ccw_device_notify: improve return codes
      [S390] cio: trigger subchannel event at resume time

Stefan Haberland (3):
      [S390] dasd: fix online/offline race
      [S390] dasd: fix refcounting.
      [S390] dasd: correct offline processing

Ursula Braun (1):
      [S390] adapt text to cu3088-removal

 Documentation/s390/CommonIO             |    6 +
 Documentation/s390/driver-model.txt     |    4 +-
 arch/s390/Kconfig                       |    6 +
 arch/s390/Kconfig.debug                 |   13 +
 arch/s390/Makefile                      |   13 +-
 arch/s390/boot/Makefile                 |    8 +
 arch/s390/boot/compressed/Makefile      |   60 +++++
 arch/s390/boot/compressed/head31.S      |   51 +++++
 arch/s390/boot/compressed/head64.S      |   48 ++++
 arch/s390/boot/compressed/misc.c        |  158 +++++++++++++
 arch/s390/boot/compressed/vmlinux.lds.S |   55 +++++
 arch/s390/boot/compressed/vmlinux.scr   |   10 +
 arch/s390/defconfig                     |    7 +
 arch/s390/hypfs/hypfs_diag.c            |    4 +-
 arch/s390/include/asm/atomic.h          |   86 +-------
 arch/s390/include/asm/bitops.h          |   83 ++------
 arch/s390/include/asm/bug.h             |   10 +-
 arch/s390/include/asm/crw.h             |    1 +
 arch/s390/include/asm/etr.h             |   12 +-
 arch/s390/include/asm/irqflags.h        |   36 ---
 arch/s390/include/asm/lowcore.h         |  250 +++++----------------
 arch/s390/include/asm/page.h            |    3 -
 arch/s390/include/asm/processor.h       |   18 +-
 arch/s390/include/asm/qdio.h            |    3 +-
 arch/s390/include/asm/rwsem.h           |  147 ++++++------
 arch/s390/include/asm/setup.h           |    9 +-
 arch/s390/include/asm/sigp.h            |  142 ++++++------
 arch/s390/include/asm/smp.h             |   38 +++-
 arch/s390/include/asm/spinlock.h        |   18 --
 arch/s390/include/asm/swab.h            |   16 +-
 arch/s390/include/asm/sysinfo.h         |    3 +-
 arch/s390/include/asm/system.h          |  168 +++++++-------
 arch/s390/include/asm/thread_info.h     |    2 +-
 arch/s390/include/asm/timex.h           |   22 +--
 arch/s390/include/asm/uaccess.h         |   12 +
 arch/s390/include/asm/vdso.h            |    2 +-
 arch/s390/kernel/Makefile               |    3 +
 arch/s390/kernel/asm-offsets.c          |   99 ++++++++-
 arch/s390/kernel/base.S                 |    2 +-
 arch/s390/kernel/dis.c                  |  369 ++++++++++++++++++++++++-------
 arch/s390/kernel/early.c                |   22 ++-
 arch/s390/kernel/entry.S                |    1 -
 arch/s390/kernel/entry64.S              |    2 -
 arch/s390/kernel/ftrace.c               |    2 +-
 arch/s390/kernel/head.S                 |   60 ++----
 arch/s390/kernel/head31.S               |   16 +-
 arch/s390/kernel/head64.S               |   92 +-------
 arch/s390/kernel/ipl.c                  |   41 +++--
 arch/s390/kernel/machine_kexec.c        |   10 +-
 arch/s390/kernel/reipl.S                |    2 +-
 arch/s390/kernel/reipl64.S              |    2 +-
 arch/s390/kernel/sclp.S                 |   36 +++-
 arch/s390/kernel/setup.c                |   11 +-
 arch/s390/kernel/smp.c                  |  108 +++++----
 arch/s390/kernel/switch_cpu.S           |   58 +++++
 arch/s390/kernel/switch_cpu64.S         |   51 +++++
 arch/s390/kernel/swsusp_asm64.S         |    2 +-
 arch/s390/kernel/time.c                 |    8 -
 arch/s390/kernel/vdso.c                 |    1 +
 arch/s390/kvm/diag.c                    |    4 +-
 arch/s390/kvm/intercept.c               |   18 +-
 arch/s390/kvm/interrupt.c               |   12 +-
 arch/s390/kvm/kvm-s390.c                |   23 +-
 arch/s390/kvm/priv.c                    |    2 +-
 arch/s390/kvm/sigp.c                    |    4 +-
 arch/s390/lib/Makefile                  |    2 +-
 arch/s390/lib/spinlock.c                |   53 +++--
 arch/s390/lib/usercopy.c                |    8 +
 arch/s390/mm/extmem.c                   |   12 +-
 arch/s390/mm/fault.c                    |    5 +-
 arch/s390/mm/init.c                     |   33 ++--
 drivers/s390/block/dasd.c               |   48 +++--
 drivers/s390/block/dasd_devmap.c        |   13 +-
 drivers/s390/block/dasd_genhd.c         |    1 +
 drivers/s390/block/dasd_int.h           |    1 +
 drivers/s390/block/dasd_proc.c          |  109 ++++-----
 drivers/s390/char/zcore.c               |  163 ++++++--------
 drivers/s390/cio/ccwreq.c               |    2 +-
 drivers/s390/cio/chsc.c                 |    2 +-
 drivers/s390/cio/chsc_sch.c             |    4 +-
 drivers/s390/cio/cio.c                  |   14 +-
 drivers/s390/cio/crw.c                  |   29 ++--
 drivers/s390/cio/css.c                  |   79 ++++++-
 drivers/s390/cio/css.h                  |    5 +-
 drivers/s390/cio/device.c               |  160 +++++++-------
 drivers/s390/cio/device.h               |    3 +-
 drivers/s390/cio/device_fsm.c           |   43 +++-
 drivers/s390/cio/qdio.h                 |   92 +++++---
 drivers/s390/cio/qdio_debug.c           |   23 ++-
 drivers/s390/cio/qdio_main.c            |   28 +++-
 drivers/s390/cio/qdio_setup.c           |   20 ++-
 drivers/s390/cio/qdio_thinint.c         |    4 +-
 drivers/s390/crypto/zcrypt_api.c        |  158 ++++++-------
 drivers/s390/kvm/kvm_virtio.c           |    4 +-
 include/linux/elf.h                     |    5 +
 95 files changed, 2207 insertions(+), 1501 deletions(-)
 create mode 100644 arch/s390/boot/compressed/Makefile
 create mode 100644 arch/s390/boot/compressed/head31.S
 create mode 100644 arch/s390/boot/compressed/head64.S
 create mode 100644 arch/s390/boot/compressed/misc.c
 create mode 100644 arch/s390/boot/compressed/vmlinux.lds.S
 create mode 100644 arch/s390/boot/compressed/vmlinux.scr
 create mode 100644 arch/s390/kernel/switch_cpu.S
 create mode 100644 arch/s390/kernel/switch_cpu64.S
 create mode 100644 arch/s390/lib/usercopy.c
