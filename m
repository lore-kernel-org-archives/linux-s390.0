Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 4 Aug 2011 13:53:24 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [GIT PULL] s390 updates for Linux 3.1
Message-ID: <20110804115324.GB5207@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from 'for-linus' branch of

	git://git390.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

Heiko Carstens (6):
      [S390] Add support for IBM zEnterprise 114
      [S390] asm offsets: fix coding style
      [S390] signal: convert to use set_current_blocked()
      [S390] cpu hotplug: on cpu start wait until being marked active
      [S390] smp: remove pointless comments in startup_secondary()
      [S390] signal: use set_restore_sigmask() helper

Jan Glauber (2):
      [S390] qdio: 2nd stage retry on SIGA-W busy conditions
      [S390] missing return in page_table_alloc_pgste

Mathias Krause (1):
      [S390] exec: remove redundant set_fs(USER_DS)

Michael Holzheu (3):
      [S390] Add PSW restart shutdown trigger
      [S390] Export store_status() function
      [S390] Use diagnose 308 for system reset

Peter Huewe (2):
      [S390] sclp_async: Use kstrtoul_from_user
      [S390] qdio: Use kstrtoul_from_user

Stefan Haberland (1):
      [S390] dasd: check if raw track access is supported

Stefan Weinhuber (1):
      [S390] dasd: use vmalloc for statistics input buffer

 arch/s390/Kconfig                 |    8 ++--
 arch/s390/include/asm/ipl.h       |    1 +
 arch/s390/include/asm/lowcore.h   |   11 ++++-
 arch/s390/include/asm/processor.h |    2 -
 arch/s390/include/asm/system.h    |    1 +
 arch/s390/kernel/asm-offsets.c    |   10 ++---
 arch/s390/kernel/base.S           |   36 ++++++++++++++++
 arch/s390/kernel/compat_signal.c  |   43 ++++++--------------
 arch/s390/kernel/entry.S          |   28 +++++++++++++
 arch/s390/kernel/entry64.S        |   20 +++++++++
 arch/s390/kernel/ipl.c            |   45 ++++++++++++++++++++-
 arch/s390/kernel/reipl64.S        |   80 +++++++++++++++++++++++++++---------
 arch/s390/kernel/setup.c          |   25 +++++++++++-
 arch/s390/kernel/signal.c         |   61 +++++++++-------------------
 arch/s390/kernel/smp.c            |   24 +++++++----
 arch/s390/mm/maccess.c            |   16 +++++++
 arch/s390/mm/pgtable.c            |    1 +
 drivers/s390/block/dasd.c         |    9 ++--
 drivers/s390/block/dasd_eckd.c    |    9 ++++
 drivers/s390/block/dasd_proc.c    |    4 +-
 drivers/s390/char/sclp_async.c    |    9 +---
 drivers/s390/cio/qdio.h           |    2 +
 drivers/s390/cio/qdio_debug.c     |   12 +----
 drivers/s390/cio/qdio_main.c      |   21 ++++++++-
 24 files changed, 337 insertions(+), 141 deletions(-)
