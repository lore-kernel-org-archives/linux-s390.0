Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 2 Jan 2019 08:43:54 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for the 4.21 merge window
Message-Id: <20190102084354.335d2272@mschwideX1>
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

please pull s390 fixes and features for 4.21

The following changes since commit 94f371cb73944b410a269d570d6946c042f2ddd0:

  Merge tag 'acpi-4.20-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm (2018-11-29 15:54:12 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-4.21-1

for you to fetch changes up to ec10574d00da0d8b6ec9d0099410aae8aad4695a:

  Merge tag 'vfio-ccw-20181213' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw into features (2018-12-13 10:44:18 +0100)

----------------------------------------------------------------
s390 updates for the 4.21 merge window

 - A larger update for the zcrypt / AP bus code
   + Update two inline assemblies in the zcrypt driver to make gcc happy
   + Add a missing reply code for invalid special commands for zcrypt
   + Allow AP device reset to be triggered from user space
   + Split the AP scan function into smaller, more readable functions

 - Updates for vfio-ccw and vfio-ap
   + Add maintainers and reviewer for vfio-ccw
   + Include facility.h in vfio_ap_drv.c to avoid fragile include chain
   + Simplicy vfio-ccw state machine

 - Use the common code version of bust_spinlocks

 - Make use of the DEFINE_SHOW_ATTRIBUTE

 - Fix three incorrect file permissions in the DASD driver

 - Remove bit spin-lock from the PCI interrupt handler

 - Fix GFP_ATOMIC vs GFP_KERNEL in the PCI code

----------------------------------------------------------------
Christian Borntraeger (1):
      MAINTAINERS/vfio-ccw: add Farhan and Eric, make Halil Reviewer

Harald Freudenberger (4):
      s390/ap: rework assembler functions to use unions for in/out register variables
      s390/zcrypt: improve special ap message cmd handling
      s390/zcrypt: make sysfs reset attribute trigger queue reset
      s390/zcrypt: rework ap scan bus code

Martin Schwidefsky (1):
      Merge tag 'vfio-ccw-20181213' of git://git.kernel.org/.../kvms390/vfio-ccw into features

Petr Tesarik (1):
      s390: vfio-ap: include <asm/facility> for test_facility()

Pierre Morel (1):
      vfio: ccw: Merge BUSY and BOXED states

Sebastian Ott (3):
      s390/drivers: fix proc/debugfs file permissions
      s390/pci: remove bit_lock usage in interrupt handler
      s390/pci: fix sleeping in atomic during hotplug

Sergey Senozhatsky (1):
      s390: use common bust_spinlocks()

Yangtao Li (1):
      s390: convert to DEFINE_SHOW_ATTRIBUTE

 MAINTAINERS                         |   4 +-
 arch/s390/include/asm/ap.h          |  28 ++--
 arch/s390/include/uapi/asm/zcrypt.h |   4 +-
 arch/s390/mm/fault.c                |  24 ----
 arch/s390/pci/pci.c                 |   4 +-
 arch/s390/pci/pci_clp.c             |   2 +-
 drivers/s390/block/dasd.c           |  15 +-
 drivers/s390/block/dasd_proc.c      |   3 +-
 drivers/s390/char/tape_proc.c       |   7 +-
 drivers/s390/cio/qdio_debug.c       |  18 +--
 drivers/s390/cio/vfio_ccw_fsm.c     |   7 +-
 drivers/s390/cio/vfio_ccw_private.h |   1 -
 drivers/s390/crypto/ap_bus.c        | 277 +++++++++++++++++++++---------------
 drivers/s390/crypto/ap_queue.c      |  23 ++-
 drivers/s390/crypto/vfio_ap_drv.c   |   1 +
 drivers/s390/crypto/zcrypt_error.h  |   2 +
 lib/bust_spinlocks.c                |   6 +-
 17 files changed, 222 insertions(+), 204 deletions(-)
