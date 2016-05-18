Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 18 May 2016 12:14:34 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.7 merge window
Message-ID: <20160518121434.69a9fa37@mschwide>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

The s390 patches for the 4.7 merge window have the usual bug fixes and
cleanups, and the following new features:

 * An interface for dasd driver to query if a volume is online to
   another operating system

 * A new ioctl for the dasd driver to verify the format for a range
   of tracks

 * Following the example of x86 the struct fpu is now allocated with
   the task_struct

 * The 'report_error' interface for the PCI bus to send an adapter-error
   notification from user space to the service element of the machine

Anna-Maria Gleixner (2):
      s390/cpum_cf: Remove superfluous SMP function call
      s390/cpum_sf: Remove superfluous SMP function call

Heiko Carstens (8):
      s390/dumpstack: implement and use return_address()
      s390/cpuinfo: simplify locking and skip offline cpus early
      s390/cache: remove superfluous locking
      s390: make couple of variables and functions static
      s390: add missing declarations
      s390: add missing include statements
      s390/vmem: fix identity mapping
      s390/vmem: remove unused function parameter

Jan Höppner (1):
      s390/dasd: Add new ioctl BIODASDCHECKFMT

Martin Schwidefsky (10):
      s390/crypto: cleanup and move the header with the cpacf definitions
      s390/fpu: allocate 'struct fpu' with the task_struct
      s390/sclp: avoid compile warning in sclp_pci_report
      s390/Kconfig: make z196 the default processor type
      s390/3270: add missing tty_kref_put
      s390/3270: fix view reference counting
      s390/3270: fix garbled output on 3270 tty view
      s390/3270: avoid endless I/O loop with disconnected 3270 terminals
      s390/3270: handle reconnect of a tty with a different size
      s390/3270: hangup the 3270 tty after a disconnect

Peter Zijlstra (1):
      s390: Clarify pagefault interrupt

Sascha Silbe (1):
      Documentation: document the nosmt and smt s390 kernel parameters

Sebastian Ott (5):
      s390/sclp: move pci related commands to separate file
      s390/sclp: add error notification command
      s390/pci: add report_error attribute
      s390/sclp: event type macro cleanup
      s390/pci: fmb enhancements

Stefan Haberland (1):
      s390/dasd: add query host access to volume support

 Documentation/kernel-parameters.txt |  10 +
 arch/s390/Kconfig                   |   3 +-
 arch/s390/crypto/aes_s390.c         | 117 +++---
 arch/s390/crypto/crypt_s390.h       | 493 -------------------------
 arch/s390/crypto/des_s390.c         |  72 ++--
 arch/s390/crypto/ghash_s390.c       |  16 +-
 arch/s390/crypto/prng.c             |  60 ++--
 arch/s390/crypto/sha1_s390.c        |  10 +-
 arch/s390/crypto/sha256_s390.c      |  14 +-
 arch/s390/crypto/sha512_s390.c      |  14 +-
 arch/s390/crypto/sha_common.c       |  10 +-
 arch/s390/include/asm/cpacf.h       | 410 +++++++++++++++++++++
 arch/s390/include/asm/fpu/types.h   |  10 +-
 arch/s390/include/asm/ftrace.h      |   4 +-
 arch/s390/include/asm/pci.h         |  35 +-
 arch/s390/include/asm/processor.h   |   9 +-
 arch/s390/include/asm/sclp.h        |  13 +
 arch/s390/include/asm/thread_info.h |   1 +
 arch/s390/include/uapi/asm/dasd.h   |  32 ++
 arch/s390/kernel/cache.c            |   2 -
 arch/s390/kernel/crash_dump.c       |   2 +-
 arch/s390/kernel/dumpstack.c        |  24 ++
 arch/s390/kernel/entry.h            |   4 +
 arch/s390/kernel/perf_cpum_cf.c     |   9 +-
 arch/s390/kernel/perf_cpum_sf.c     |   9 +-
 arch/s390/kernel/process.c          |  24 +-
 arch/s390/kernel/processor.c        |  16 +-
 arch/s390/kernel/setup.c            |  17 +
 arch/s390/kernel/vtime.c            |   2 +
 arch/s390/mm/fault.c                |  41 ++-
 arch/s390/mm/mmap.c                 |   1 +
 arch/s390/mm/vmem.c                 |   8 +-
 arch/s390/pci/pci_debug.c           |  61 +++-
 arch/s390/pci/pci_sysfs.c           |  23 ++
 drivers/s390/block/dasd.c           |  92 ++++-
 drivers/s390/block/dasd_3990_erp.c  |  20 +-
 drivers/s390/block/dasd_devmap.c    |  27 ++
 drivers/s390/block/dasd_eckd.c      | 699 +++++++++++++++++++++++++++++++++++-
 drivers/s390/block/dasd_eckd.h      |  34 +-
 drivers/s390/block/dasd_int.h       |  17 +-
 drivers/s390/block/dasd_ioctl.c     |  61 ++++
 drivers/s390/char/Makefile          |   2 +
 drivers/s390/char/con3270.c         |   3 +-
 drivers/s390/char/fs3270.c          |   3 +-
 drivers/s390/char/raw3270.c         | 131 +++----
 drivers/s390/char/raw3270.h         |   8 +-
 drivers/s390/char/sclp.h            |  38 +-
 drivers/s390/char/sclp_cmd.c        |  61 ----
 drivers/s390/char/sclp_cpi_sys.c    |   2 +-
 drivers/s390/char/sclp_pci.c        | 193 ++++++++++
 drivers/s390/char/tty3270.c         |  86 ++++-
 drivers/s390/crypto/ap_bus.c        |   2 +-
 52 files changed, 2104 insertions(+), 951 deletions(-)
 delete mode 100644 arch/s390/crypto/crypt_s390.h
 create mode 100644 arch/s390/include/asm/cpacf.h
 create mode 100644 drivers/s390/char/sclp_pci.c
