Return-Path: <linux-kernel-owner+w=401wt.eu-S1758852AbYJJNqt@vger.kernel.org>
Subject: [GIT PULL] s390 patches for 2.6.28
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Content-Type: text/plain
Date: Fri, 10 Oct 2008 15:32:37 +0200
Message-Id: <1223645557.5449.1.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

Christian Borntraeger (1):
      [S390] Fix checkstack for s390

Christoph Hellwig (1):
      [S390] s390: use sys_pause for 31bit pause entry point

Cornelia Huck (6):
      [S390] cio: Update cio_ignore documentation.
      [S390] cio: Exorcise cio_msg= from documentation.
      [S390] bus_id -> dev_set_name() changes
      [S390] more bus_id -> dev_name conversions
      [S390] Use s390_root_dev_* in kvm_virtio.
      [S390] bus_id -> dev_set_name() for css and ccw busses

Florian Funke (1):
      [S390] introduce dirty bit for kvm live migration

Heiko Carstens (3):
      [S390] cio: fix cio_tpi.
      [S390] Move private simple udelay function to arch/s390/lib/delay.c.
      [S390] 3215: Remove tasklet.

Holger Smolinski (1):
      [S390] console flush on panic / reboot

Hongjie Yang (1):
      [S390] dcssblk: add >2G DCSSs support and stacked contiguous DCSSs support.

Julia Lawall (1):
      [S390] cio: Correct use of ! and &

Kay Sievers (1):
      [S390] bus_id -> dev_name conversions

Klaus-Dieter Wacker (1):
      [S390] qdio enhanced SIGA (iqdio) support.

Martin Schwidefsky (4):
      [S390] bus_id ->dev_name() conversions in qdio
      [S390] ptrace changes
      [S390] xpram: per device block request queues.
      [S390] fix initialization of stp

Nigel Hislop (1):
      [S390] Add ioctl support for EMC Symmetrix Subsystem Control I/O

Peter Oberparleiter (3):
      [S390] cio: move device unregistration to dedicated work queue
      [S390] cio: introduce purge function for /proc/cio_ignore
      [S390] cio: inline assembly cleanup

Stefan Haberland (1):
      [S390] dasd: fix message flood for unsolicited interrupts

Ursula Braun (1):
      [S390] qdio: speed up multicast traffic on full HiperSocket queue

 Documentation/s390/CommonIO         |   11 +-
 arch/s390/Kconfig                   |    1 +
 arch/s390/include/asm/dasd.h        |   13 +
 arch/s390/include/asm/delay.h       |    1 +
 arch/s390/include/asm/pgtable.h     |   45 +++-
 arch/s390/include/asm/ptrace.h      |    1 +
 arch/s390/include/asm/qdio.h        |    8 +-
 arch/s390/include/asm/syscall.h     |   80 ++++++
 arch/s390/include/asm/thread_info.h |    2 +
 arch/s390/kernel/compat_linux.c     |    8 -
 arch/s390/kernel/compat_linux.h     |    1 -
 arch/s390/kernel/compat_wrapper.S   |    2 -
 arch/s390/kernel/entry.S            |   50 +++-
 arch/s390/kernel/entry64.S          |   42 +++-
 arch/s390/kernel/ptrace.c           |   61 +++--
 arch/s390/kernel/signal.c           |   13 +
 arch/s390/kernel/syscalls.S         |    2 +-
 arch/s390/kernel/time.c             |    2 +-
 arch/s390/lib/delay.c               |   13 +
 arch/s390/mm/extmem.c               |  251 ++++++++++++++---
 drivers/s390/block/dasd.c           |   32 +-
 drivers/s390/block/dasd_3990_erp.c  |    2 +-
 drivers/s390/block/dasd_devmap.c    |   28 +-
 drivers/s390/block/dasd_eckd.c      |  132 +++++++++-
 drivers/s390/block/dasd_eer.c       |    6 +-
 drivers/s390/block/dasd_fba.c       |    4 +-
 drivers/s390/block/dasd_int.h       |    4 +-
 drivers/s390/block/dasd_proc.c      |    2 +-
 drivers/s390/block/dcssblk.c        |  516 ++++++++++++++++++++++++++---------
 drivers/s390/block/xpram.c          |   37 +--
 drivers/s390/char/con3215.c         |   53 ++--
 drivers/s390/char/con3270.c         |   27 ++-
 drivers/s390/char/raw3270.c         |    4 +-
 drivers/s390/char/sclp_con.c        |   24 ++-
 drivers/s390/char/sclp_vt220.c      |   26 ++-
 drivers/s390/char/tape_3590.c       |  132 +++++-----
 drivers/s390/char/tape_block.c      |    2 +-
 drivers/s390/char/tape_core.c       |   21 +-
 drivers/s390/char/tape_proc.c       |    2 +-
 drivers/s390/char/tape_std.c        |   13 +-
 drivers/s390/char/vmlogrdr.c        |    5 +-
 drivers/s390/char/vmur.c            |    6 +-
 drivers/s390/cio/blacklist.c        |   11 +-
 drivers/s390/cio/ccwgroup.c         |    3 +-
 drivers/s390/cio/chp.c              |    3 +-
 drivers/s390/cio/chsc_sch.c         |    2 +-
 drivers/s390/cio/cio.c              |   56 ++--
 drivers/s390/cio/cio.h              |    4 +
 drivers/s390/cio/css.c              |    4 +-
 drivers/s390/cio/device.c           |  118 ++++++---
 drivers/s390/cio/device.h           |    1 +
 drivers/s390/cio/device_fsm.c       |    6 +-
 drivers/s390/cio/device_ops.c       |    2 +-
 drivers/s390/cio/io_sch.h           |   22 +-
 drivers/s390/cio/ioasm.h            |   49 ++--
 drivers/s390/cio/qdio.h             |   11 +
 drivers/s390/cio/qdio_debug.c       |    2 +-
 drivers/s390/cio/qdio_main.c        |   32 ++-
 drivers/s390/crypto/ap_bus.c        |    4 +-
 drivers/s390/kvm/kvm_virtio.c       |   15 +-
 drivers/s390/net/claw.c             |   36 ++-
 drivers/s390/net/claw.h             |    2 +-
 drivers/s390/net/ctcm_main.c        |   22 +-
 drivers/s390/net/ctcm_main.h        |    2 +-
 drivers/s390/net/lcs.c              |   34 ++-
 drivers/s390/net/netiucv.c          |    2 +-
 drivers/s390/net/qeth_core.h        |   10 +-
 drivers/s390/net/qeth_core_main.c   |   10 +-
 drivers/s390/s390_rdev.c            |    2 +-
 drivers/s390/scsi/zfcp_aux.c        |   10 +-
 drivers/s390/scsi/zfcp_def.h        |    4 +-
 drivers/s390/scsi/zfcp_erp.c        |    2 +-
 drivers/s390/scsi/zfcp_sysfs.c      |    2 +-
 scripts/checkstack.pl               |    5 +-
 74 files changed, 1551 insertions(+), 622 deletions(-)
 create mode 100644 arch/s390/include/asm/syscall.h


-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
