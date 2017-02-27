Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 27 Feb 2017 08:07:15 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.11 merge window #2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170227080715.4c4ae517@mschwideX1>
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

Next to the usual bug fixes (including the TASK_SIZE fix), there is
one larger crypto item. It allows to use protected keys with the
in-kernel crypto API. The protected key support has two parts,
the pkey user space API to convert key formats and the paes crypto
module that uses a protected key instead of a standard AES key.

Colin Ian King (1):
      s390/dasd: fix spelling mistake: "supportet" -> "supported"

Dominik Dingel (1):
      s390/mm: use _SEGMENT_ENTRY_EMPTY in the code

Harald Freudenberger (6):
      s390/zcrypt: Enable request count reset for cards and queues.
      s390/crypto: Add PCKMO inline function
      s390/zcrypt: Cleanup leftover module code.
      s390/zcrypt: Rework CONFIG_ZCRYPT Kconfig text.
      s390/zcrypt: export additional symbols
      s390/pkey: Introduce pkey kernel module

Heiko Carstens (5):
      s390: rename CIF_ASCE to CIF_ASCE_PRIMARY
      s390: restore address space when returning to user space
      s390: opt into HAVE_COPY_THREAD_TLS
      s390/nmi: fix order of register validation
      s390/nmi: purge tlbs after control register validation

Martin Schwidefsky (2):
      s390/crypt: Add protected key AES module
      s390: TASK_SIZE for kernel threads

Peter Oberparleiter (1):
      s390/chsc: Add exception handler for CHSC instruction

 arch/s390/Kconfig                       |    1 +
 arch/s390/configs/default_defconfig     |    1 +
 arch/s390/configs/performance_defconfig |    1 +
 arch/s390/crypto/Makefile               |    2 +-
 arch/s390/crypto/paes_s390.c            |  619 +++++++++++++++++
 arch/s390/defconfig                     |    1 +
 arch/s390/include/asm/cpacf.h           |   46 +-
 arch/s390/include/asm/mmu_context.h     |    4 +-
 arch/s390/include/asm/pgtable.h         |   14 +-
 arch/s390/include/asm/pkey.h            |   90 +++
 arch/s390/include/asm/processor.h       |   19 +-
 arch/s390/include/asm/uaccess.h         |   23 +-
 arch/s390/include/uapi/asm/Kbuild       |    1 +
 arch/s390/include/uapi/asm/pkey.h       |  112 +++
 arch/s390/kernel/entry.S                |   33 +-
 arch/s390/kernel/entry.h                |    1 +
 arch/s390/kernel/nmi.c                  |   25 +-
 arch/s390/kernel/process.c              |   18 +-
 arch/s390/mm/gmap.c                     |    6 +-
 arch/s390/mm/hugetlbpage.c              |    2 +-
 drivers/crypto/Kconfig                  |   32 +-
 drivers/s390/block/dasd_eckd.c          |    2 +-
 drivers/s390/cio/ioasm.c                |    8 +-
 drivers/s390/crypto/Makefile            |    4 +
 drivers/s390/crypto/ap_bus.c            |   10 -
 drivers/s390/crypto/ap_card.c           |   24 +-
 drivers/s390/crypto/ap_queue.c          |   21 +-
 drivers/s390/crypto/pkey_api.c          | 1148 +++++++++++++++++++++++++++++++
 drivers/s390/crypto/zcrypt_api.c        |    5 +-
 drivers/s390/crypto/zcrypt_api.h        |    2 +
 30 files changed, 2182 insertions(+), 93 deletions(-)
 create mode 100644 arch/s390/crypto/paes_s390.c
 create mode 100644 arch/s390/include/asm/pkey.h
 create mode 100644 arch/s390/include/uapi/asm/pkey.h
 create mode 100644 drivers/s390/crypto/pkey_api.c
