Return-Path: <linux-kernel-owner+w=401wt.eu-S1759030AbYDQGZf@vger.kernel.org>
Date: Thu, 17 Apr 2008 08:25:22 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [GIT PULL] s390 patches for 2.6.26
Message-ID: <20080417062522.GA5581@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

Since Martin is on vacation the pull request comes from me this time.

Besides the usual fixes and cleanups the tree contains new features that
exploit the new z10 hardware. Large page support is currently missing since it
depends on a patch in -mm.

Two patches touch common code: one is from Russel King ("genirq/clockevents:
move irq affinity prototypes/inlines to interrupt.h") which moves irq affinity
functions around.
This is needed so we can convert s390 to GENERIC_CLOCKEVENTS.

The second one ("hw_random: allow rng_dev_read() to return hardware errors.")
is required for the zcrypt large random numbers support patch. This has been
agreed on with Herbert Xu.

Shortlog and diffstat:

Christian Borntraeger (2):
      [S390] KVM preparation: split sysinfo definitions for kvm use
      [S390] kernel: show last breaking-event-address on oops

Cornelia Huck (2):
      [S390] cio: Fix race for "fast" path gone/path back situations.
      [S390] cio: Trigger verification on device/path not operational.

Felix Beck (1):
      [S390] zcrypt: Comments and kernel-doc cleanup

Frank Munzert (1):
      [S390] vmur: Use wait queue instead of mutex to serialize open

Harvey Harrison (1):
      [S390] replace remaining __FUNCTION__ occurrences

Heiko Carstens (12):
      [S390] Protect against sigaltstack wraparound.
      [S390] sclp: Get rid of in_atomic() use.
      [S390] exec_protect: Fix incorrect extern declarations.
      [S390] Export stfle.
      [S390] cpu topology support for s390.
      [S390] Vertical cpu management.
      [S390] crypto: use more descriptive function names for init/exit routines.
      [S390] Convert monitor calls to function calls.
      [S390] Convert s390 to GENERIC_CLOCKEVENTS.
      [S390] Fix a lot of sparse warnings.
      [S390] uaccess: Always access the correct address space.
      [S390] lowcore: Change type of lowcores softirq_pending to __u32.

Jan Glauber (1):
      [S390] switch sched_clock to store-clock-extended.

Johannes Weiner (1):
      [S390] remove redundant display of free swap space in show_mem()

Josef 'Jeff' Sipek (1):
      [S390] dasd: fix double elevator_exit call when deadline iosched fails to load

Martin Schwidefsky (3):
      [S390] allnoconfig build error.
      [S390] Add new fields for System z10 to /proc/sysinfo
      [S390] Remove code duplication from monreader / dcssblk.

Michael Ernst (1):
      [S390] cio: fix parallel cm_enable processing.

Michael Holzheu (2):
      [S390] tape: duplicate sysfs filename when setting tape device online
      [S390] Add debug_register_mode() function to debug feature API

Ralph Wuerthner (2):
      [S390] hw_random: allow rng_dev_read() to return hardware errors.
      [S390] zcrypt: add support for large random numbers

Russell King (1):
      [S390] genirq/clockevents: move irq affinity prototypes/inlines to interrupt.h

Stefan Haberland (2):
      [S390] dasd: use GFP_DMA for fba private data allocation
      [S390] dasd: add sim handling.

Ursula Braun (3):
      [S390] qdio: Unrecognized inbound traffic if many FCP devices are online
      [S390] qdio: remove outdated developerworks link.
      [S390] qdio (new feature): enhancing info-retrieval from QDIO-adapters

 Documentation/s390/s390dbf.txt       |   21 ++
 arch/s390/Kconfig                    |   33 +---
 arch/s390/crypto/aes_s390.c          |    8 +-
 arch/s390/crypto/des_s390.c          |    8 +-
 arch/s390/crypto/sha1_s390.c         |    8 +-
 arch/s390/crypto/sha256_s390.c       |    8 +-
 arch/s390/defconfig                  |    1 +
 arch/s390/kernel/Makefile            |    2 +-
 arch/s390/kernel/compat_linux.h      |   73 +++++++
 arch/s390/kernel/compat_signal.c     |   11 +
 arch/s390/kernel/debug.c             |   53 ++++--
 arch/s390/kernel/early.c             |    1 +
 arch/s390/kernel/entry.h             |   60 ++++++
 arch/s390/kernel/entry64.S           |    2 +
 arch/s390/kernel/ipl.c               |    2 +-
 arch/s390/kernel/kprobes.c           |    2 +-
 arch/s390/kernel/process.c           |   77 ++++----
 arch/s390/kernel/ptrace.c            |    1 +
 arch/s390/kernel/s390_ext.c          |   14 +-
 arch/s390/kernel/setup.c             |   15 ++-
 arch/s390/kernel/signal.c            |   16 +-
 arch/s390/kernel/smp.c               |   91 ++++++++-
 arch/s390/kernel/sys_s390.c          |    2 +-
 arch/s390/kernel/time.c              |  259 ++++++++------------------
 arch/s390/kernel/topology.c          |  314 +++++++++++++++++++++++++++++++
 arch/s390/kernel/traps.c             |   17 +-
 arch/s390/lib/delay.c                |   14 +-
 arch/s390/lib/uaccess_pt.c           |   59 ++++--
 arch/s390/mm/extmem.c                |   67 +++++--
 arch/s390/mm/fault.c                 |   21 +--
 arch/s390/mm/init.c                  |    1 -
 drivers/char/hw_random/core.c        |    4 +
 drivers/crypto/Kconfig               |    1 +
 drivers/s390/block/Kconfig           |    1 +
 drivers/s390/block/dasd.c            |   10 +-
 drivers/s390/block/dasd_3990_erp.c   |   34 ++++
 drivers/s390/block/dasd_alias.c      |   49 ++---
 drivers/s390/block/dasd_eckd.c       |    7 +
 drivers/s390/block/dasd_fba.c        |    3 +-
 drivers/s390/block/dasd_int.h        |    6 +
 drivers/s390/block/dcssblk.c         |   53 +-----
 drivers/s390/char/monreader.c        |   54 +-----
 drivers/s390/char/sclp_tty.c         |    2 +-
 drivers/s390/char/sclp_vt220.c       |   13 +-
 drivers/s390/char/tape_34xx.c        |    2 +-
 drivers/s390/char/tape_char.c        |    4 +-
 drivers/s390/char/tape_class.c       |    5 +-
 drivers/s390/char/tape_class.h       |    2 +-
 drivers/s390/char/vmur.c             |   24 ++-
 drivers/s390/char/vmur.h             |    4 +-
 drivers/s390/char/vmwatchdog.c       |    4 +-
 drivers/s390/char/zcore.c            |    2 +-
 drivers/s390/cio/chsc.c              |   15 +-
 drivers/s390/cio/cio.c               |   30 ++--
 drivers/s390/cio/cio.h               |    1 +
 drivers/s390/cio/css.c               |   16 ++-
 drivers/s390/cio/css.h               |    1 +
 drivers/s390/cio/device.c            |    1 -
 drivers/s390/cio/device.h            |    1 +
 drivers/s390/cio/device_ops.c        |    9 +-
 drivers/s390/cio/device_status.c     |    8 +-
 drivers/s390/cio/qdio.c              |  180 +++++++++---------
 drivers/s390/cio/qdio.h              |   28 +++
 drivers/s390/crypto/ap_bus.c         |  189 ++++++++++++-------
 drivers/s390/crypto/ap_bus.h         |   15 ++-
 drivers/s390/crypto/zcrypt_api.c     |  181 ++++++++++++++++--
 drivers/s390/crypto/zcrypt_api.h     |   16 ++-
 drivers/s390/crypto/zcrypt_cca_key.h |    4 +-
 drivers/s390/crypto/zcrypt_error.h   |    2 +-
 drivers/s390/crypto/zcrypt_pcicc.c   |    4 +-
 drivers/s390/crypto/zcrypt_pcixcc.c  |  201 ++++++++++++++++++++-
 drivers/s390/net/claw.c              |  344 +++++++++++++++++-----------------
 drivers/s390/net/netiucv.c           |   97 +++++-----
 drivers/s390/s390mach.c              |    8 +-
 drivers/s390/s390mach.h              |    4 +
 drivers/s390/scsi/zfcp_def.h         |    2 +-
 drivers/s390/sysinfo.c               |  116 ++----------
 include/asm-s390/cio.h               |    4 +
 include/asm-s390/cpu.h               |    8 +
 include/asm-s390/debug.h             |    5 +
 include/asm-s390/extmem.h            |   11 +-
 include/asm-s390/hardirq.h           |    2 +-
 include/asm-s390/lowcore.h           |   11 +-
 include/asm-s390/processor.h         |    7 +
 include/asm-s390/smp.h               |    3 +
 include/asm-s390/sysinfo.h           |  116 ++++++++++++
 include/asm-s390/system.h            |    2 +
 include/asm-s390/timex.h             |   13 +-
 include/asm-s390/tlbflush.h          |   36 +++--
 include/asm-s390/topology.h          |   23 +++
 include/linux/interrupt.h            |   19 ++
 include/linux/irq.h                  |   10 -
 kernel/time/tick-broadcast.c         |    2 +-
 kernel/time/tick-common.c            |    4 +-
 kernel/time/tick-oneshot.c           |    2 +-
 95 files changed, 2180 insertions(+), 1116 deletions(-)
 create mode 100644 arch/s390/kernel/entry.h
 create mode 100644 arch/s390/kernel/topology.c
 create mode 100644 include/asm-s390/sysinfo.h
