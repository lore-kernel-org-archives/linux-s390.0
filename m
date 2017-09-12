Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 12 Sep 2017 11:08:26 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 update for 4.14 merge window #2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170912110826.4f901546@mschwideX1>
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

"The second patch set for the 4.14 merge window:

 - Convert the dasd device driver to the blk-mq interface.

 - Provide three zcrypt interfaces for vfio_ap. These will be required
   for KVM guest access to the crypto cards attached via the AP bus.

 - A couple of memory management bug fixes."

Harald Freudenberger (2):
      s390/zcrypt: externalize AP config info query
      s390/zcrypt: externalize AP queue interrupt control

Martin Schwidefsky (4):
      s390/mm: use VM_BUG_ON in crst_table_[upgrade|downgrade]
      s390/mm: fix local TLB flushing vs. detach of an mm address space
      s390/mm: fix race on mm->context.flush_mm
      s390/mm: use a single lock for the fields in mm_context_t

Stefan Haberland (1):
      s390/dasd: blk-mq conversion

Tony Krowiak (1):
      s390/zcrypt: externalize test AP queue

 arch/s390/include/asm/ap.h          | 126 ++++++++++++++
 arch/s390/include/asm/mmu.h         |   7 +-
 arch/s390/include/asm/mmu_context.h |  10 +-
 arch/s390/include/asm/tlbflush.h    |  30 +---
 arch/s390/mm/gmap.c                 |   8 +-
 arch/s390/mm/pgalloc.c              |  20 +--
 drivers/s390/block/dasd.c           | 331 +++++++++++++++++++-----------------
 drivers/s390/block/dasd_devmap.c    |   8 +-
 drivers/s390/block/dasd_int.h       |  19 ++-
 drivers/s390/crypto/ap_asm.h        |   9 +-
 drivers/s390/crypto/ap_bus.c        |  49 ++++--
 drivers/s390/crypto/ap_bus.h        |  47 +----
 drivers/s390/crypto/ap_queue.c      |  26 ++-
 13 files changed, 416 insertions(+), 274 deletions(-)
 create mode 100644 arch/s390/include/asm/ap.h
