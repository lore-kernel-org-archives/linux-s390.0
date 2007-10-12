Return-Path: <linux-kernel-owner+w=401wt.eu-S1756892AbXJLOW6@vger.kernel.org>
Subject: Please pull git390 'for-linus' branch
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Content-Type: text/plain
Date: Fri, 12 Oct 2007 16:22:46 +0200
Message-Id: <1192198966.8143.1.camel@localhost>
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

 Documentation/DocBook/Makefile          |    2 +-
 Documentation/DocBook/s390-drivers.tmpl |  149 ++++++++++++++++
 Documentation/s390/00-INDEX             |   26 +++
 Documentation/s390/CommonIO             |   51 +++---
 Documentation/s390/cds.txt              |    8 +-
 arch/s390/appldata/appldata_base.c      |   59 +------
 arch/s390/kernel/audit.c                |    7 +-
 arch/s390/kernel/audit.h                |   15 ++
 arch/s390/kernel/compat_audit.c         |    1 +
 arch/s390/kernel/cpcmd.c                |  100 ++++++-----
 arch/s390/kernel/dis.c                  |    5 +-
 arch/s390/kernel/ipl.c                  |    4 +-
 arch/s390/kernel/vmlinux.lds.S          |  234 ++++++++++++++-----------
 arch/s390/mm/fault.c                    |    2 +-
 drivers/block/Kconfig                   |    3 +-
 drivers/s390/block/dasd_int.h           |    3 +-
 drivers/s390/block/xpram.c              |    2 +-
 drivers/s390/char/con3215.c             |    3 +
 drivers/s390/char/con3270.c             |    3 +-
 drivers/s390/char/sclp.c                |    5 +-
 drivers/s390/char/tape_3590.c           |   26 ++-
 drivers/s390/char/tty3270.c             |    9 +-
 drivers/s390/char/tty3270.h             |   16 ++
 drivers/s390/char/vmwatchdog.c          |    4 +-
 drivers/s390/char/zcore.c               |    7 +-
 drivers/s390/cio/ccwgroup.c             |   67 ++++++--
 drivers/s390/cio/chp.c                  |   30 ++--
 drivers/s390/cio/cio.c                  |    5 +
 drivers/s390/cio/cmf.c                  |  232 ++++++++++++++++---------
 drivers/s390/cio/css.c                  |   98 ++++++++----
 drivers/s390/cio/css.h                  |    3 +-
 drivers/s390/cio/device.c               |   80 ++++++++--
 drivers/s390/cio/device.h               |    1 -
 drivers/s390/cio/device_fsm.c           |  147 +++-------------
 drivers/s390/cio/device_ops.c           |  241 ++++++++++++++++++++++----
 drivers/s390/cio/qdio.c                 |   39 ++--
 drivers/s390/crypto/ap_bus.c            |    5 +-
 drivers/s390/crypto/zcrypt_mono.c       |    4 +-
 drivers/s390/crypto/zcrypt_pcixcc.c     |    9 +-
 drivers/s390/crypto/zcrypt_pcixcc.h     |   45 -----
 drivers/s390/scsi/zfcp_ccw.c            |   10 +-
 drivers/s390/scsi/zfcp_dbf.c            |   10 +-
 drivers/s390/scsi/zfcp_erp.c            |   18 +-
 include/asm-s390/cache.h                |    2 -
 include/asm-s390/ccwdev.h               |   77 ++++-----
 include/asm-s390/ccwgroup.h             |   32 +++-
 include/asm-s390/cio.h                  |  288 +++++++++++++++++++++----------
 include/asm-s390/cmb.h                  |   73 ++------
 include/asm-s390/page.h                 |    3 +-
 include/asm-s390/pgtable.h              |   13 +-
 include/asm-s390/s390_ext.h             |    8 +-
 include/asm-s390/system.h               |   24 ++--
 include/asm-s390/zcrypt.h               |    4 +-
 53 files changed, 1427 insertions(+), 885 deletions(-)
 create mode 100644 Documentation/DocBook/s390-drivers.tmpl
 create mode 100644 Documentation/s390/00-INDEX
 create mode 100644 arch/s390/kernel/audit.h
 create mode 100644 drivers/s390/char/tty3270.h

Christian Borntraeger (2):
      [S390] disassembler: Remove redundant variable assignment
      [S390] remove packed attribute from ext_int_info_t.

Cornelia Huck (15):
      [S390] cio: rename css to channel_subsystems
      [S390] cio: remove subchannel_add_files()
      [S390] cio: Fix some coding style issues in cmf.
      [S390] cio: Kerneldoc comments for cmf.
      [S390] cio: Add docbook comments.
      [S390] cio: Add s390-drivers book.
      [S390] cio: Minor style fixes.
      [S390] cio: Disable channel path measurements on shutdown/reboot.
      [S390] cio: Introduce ccw_bus_type.shutdown.
      [S390] cio: Disable channel measurements (cmf) on shutdown/reboot.
      [S390] cio: Fix device attributes for early devices.
      [S390] Add Documentation/s390/00-INDEX.
      [S390] cio: Documentation update.
      [S390] cio: Avoid machine check vs. not operational races.
      [S390] 3215: Handle special console device.

Heiko Carstens (9):
      [S390] zcrypt: make init/exit functions static.
      [S390] Get rid of a bunch of sparse warnings again.
      [S390] Get rid of ARCH_KMALLOC_MINALIGN.
      [S390] qdio: dont cast function pointers and use them to call functions.
      [S390] Force link error if xchg/cmpxchg gets called with unsupported size.
      [S390] Make vmalloc area start at address > 4GB.
      [S390] cpcmd: fix inline assembly usage.
      [S390] vmwatchdog: fix broken inline assembly.
      [S390] pfault: Fix alignment of parameter list.

Martin Schwidefsky (2):
      [S390] disassembler: fix output for insns with 6 operands.
      [S390] xpram: fix bio_end{_,}io typo

Michael Holzheu (3):
      [S390] Use IPL CLEAR for reipl under z/VM
      [S390] zcore: fix inline assembly in memcpy_real()
      [S390] tape: Fix medium state handling

Ralph Wuerthner (3):
      [S390] zcrypt: remove duplicated struct CPRBX definition
      [S390] zcrypt: fix ap_reset_domain()
      [S390] zcrypt: fix PCIXCC/CEX2C error recovery

Robert P. J. Day (1):
      [S390] Remove obsolete recommendation for 8M ramdisk size.

Sam Ravnborg (2):
      [S390] s390: beautify vmlinux.lds
      [S390] s390: use PAGE_SIZE in vmlinux.lds

Satyam Sharma (2):
      [S390] appldata_base: Misc cpuinit annotations and bugfix
      [S390] appldata_base: Remove module_exit function and modular stuff

Ursula Braun (1):
      [S390] qdio: change QDIO performance_stats error message priority

vignesh babu (1):
      [S390] is_power_of_2 in drivers/s390/block/dasd_int.h

Diff too long ..
