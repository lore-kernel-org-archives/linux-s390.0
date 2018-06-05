Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 5 Jun 2018 08:34:07 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for the 4.18 merge window
Message-Id: <20180605083407.75d14c96@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
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

 - A rework for the s390 arch random code, the TRNG instruction is rather
   slow and should not be used on the interrupt path

 - A fix for a memory leak in the zcrypt driver

 - Changes to the early boot code to add a compile time check for code that
   may not use the .bss section, with the goal to avoid initrd corruptions

 - Add an interface to get the physical network ID (pnetid), this is
   useful to group network devices that are attached to the same network

 - Some cleanup for the linker script

 - Some code improvement for the dasd driver

 - Two fixes for the perf sampling support


Harald Freudenberger (2):
      s390/archrandom: Rework arch random implementation.
      s390/zcrypt: Fix CCA and EP11 CPRB processing failure memory leak.

Heiko Carstens (3):
      s390/early: get rid of memmove_early
      s390/early: get rid of #ifdef CONFIG_BLK_DEV_INITRD
      s390/early: move functions which may not access bss section to extra file

Martin Schwidefsky (1):
      s390: remove closung punctuation from spectre messages

Masahiro Yamada (1):
      s390: remove no-op macro VMLINUX_SYMBOL()

Sebastian Ott (3):
      s390/cio: add helper to query utility strings per given ccw device
      s390/cio: add test for ccwgroup device
      s390/dasd: simplify locking in dasd_times_out

Thomas Richter (2):
      perf: fix invalid bit in diagnostic entry
      s390/cpum_sf: Add data entry sizes to sampling trailer entry

Ursula Braun (1):
      s390/net: add pnetid support

Vasily Gorbik (1):
      s390: introduce compile time check for empty .bss section

 arch/s390/Kconfig                     |   4 ++
 arch/s390/crypto/arch_random.c        | 103 ++++++++++++++++++++++++++++++++--
 arch/s390/include/asm/archrandom.h    |  13 +----
 arch/s390/include/asm/ccwdev.h        |   1 +
 arch/s390/include/asm/ccwgroup.h      |  10 ++++
 arch/s390/include/asm/cpu_mf.h        |   6 +-
 arch/s390/include/asm/pnet.h          |  23 ++++++++
 arch/s390/kernel/Makefile             |  27 +++++----
 arch/s390/kernel/early.c              |  80 --------------------------
 arch/s390/kernel/early_nobss.c        |  65 +++++++++++++++++++++
 arch/s390/kernel/entry.h              |   1 +
 arch/s390/kernel/head64.S             |   8 ++-
 arch/s390/kernel/nospec-branch.c      |   4 +-
 arch/s390/kernel/vmlinux.lds.S        |   4 +-
 arch/s390/lib/Makefile                |   3 +
 arch/s390/net/Makefile                |   1 +
 arch/s390/net/pnet.c                  |  80 ++++++++++++++++++++++++++
 arch/s390/scripts/Makefile.chkbss     |  14 +++++
 drivers/s390/block/dasd.c             |  31 +++++-----
 drivers/s390/char/Makefile            |   3 +
 drivers/s390/cio/ccwgroup.c           |   6 ++
 drivers/s390/cio/device_ops.c         |  31 ++++++++++
 drivers/s390/crypto/ap_bus.h          |  17 ++++--
 drivers/s390/crypto/zcrypt_api.c      |  15 ++++-
 drivers/s390/crypto/zcrypt_msgtype6.c |  51 +++++++----------
 25 files changed, 435 insertions(+), 166 deletions(-)
 create mode 100644 arch/s390/include/asm/pnet.h
 create mode 100644 arch/s390/kernel/early_nobss.c
 create mode 100644 arch/s390/net/pnet.c
 create mode 100644 arch/s390/scripts/Makefile.chkbss
