Return-Path: <linux-kernel-owner+w=401wt.eu-S1753441AbXJVKyb@vger.kernel.org>
Subject: Please pull git390 'for-linus' branch
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Content-Type: text/plain
Date: Mon, 22 Oct 2007 12:54:19 +0200
Message-Id: <1193050460.22719.7.camel@localhost>
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

 arch/s390/defconfig            |  131 ++++++++-----
 arch/s390/kernel/ipl.c         |    2 +
 arch/s390/kernel/process.c     |   18 ++-
 arch/s390/kernel/smp.c         |   65 ++++++-
 arch/s390/lib/uaccess_pt.c     |   90 +++------
 arch/s390/mm/Makefile          |    2 +-
 arch/s390/mm/init.c            |   32 ++--
 arch/s390/mm/pgtable.c         |   94 +++++++++
 arch/s390/mm/vmem.c            |   53 ++++--
 drivers/s390/char/raw3270.c    |   26 +--
 drivers/s390/char/tape_class.c |   19 +--
 drivers/s390/char/tape_class.h |    4 +-
 drivers/s390/char/vmlogrdr.c   |   15 +-
 drivers/s390/cio/chp.c         |   12 +-
 drivers/s390/cio/css.c         |    9 +
 include/asm-s390/cpu.h         |   25 +++
 include/asm-s390/mmu_context.h |   50 +++---
 include/asm-s390/page.h        |    4 +
 include/asm-s390/pgalloc.h     |  250 ++++++++---------------
 include/asm-s390/pgtable.h     |  429 +++++++++++++++++++++-------------------
 include/asm-s390/processor.h   |   20 +--
 include/asm-s390/tlb.h         |  129 +++++++++++-
 include/asm-s390/tlbflush.h    |  152 ++++++---------
 23 files changed, 918 insertions(+), 713 deletions(-)
 create mode 100644 arch/s390/mm/pgtable.c
 create mode 100644 include/asm-s390/cpu.h

Cornelia Huck (3):
      [S390] cio: Use to_channelpath() for device to channel path conversion.
      [S390] cio: Fix incomplete commit for uevent suppression.
      [S390] struct class_device -> struct device conversion.

Heiko Carstens (1):
      [S390] Add per-cpu idle time / idle count sysfs attributes.

Martin Schwidefsky (6):
      [S390] Update default configuration.
      [S390] tlb flush fix.
      [S390] Remove unused user_seg from thread structure.
      [S390] Introduce follow_table in uaccess_pt.c
      [S390] Cleanup page table definitions.
      [S390] 4level-fixup cleanup

Michael Holzheu (1):
      [S390] kernel: Fix dump on panic for DASDs under LPAR.
