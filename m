Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Fri, 24 Aug 2018 09:42:25 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for the 4.19 merge window #2
Message-Id: <20180824094225.68b2adc6@mschwideX1>
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

- A couple of patches for the zcrypt driver
  + Add two masks to determine which AP cards and queues are host devices,
    this will be useful for KVM AP device passthrough
  + Add-on patch to improve the parsing of the new apmask and aqmask
  + Some code beautification

- Second try to reenable the GCC plugins, the first patch set had a
  patch to do this but the merge somehow missed this

- Remove the s390 specific GCC version check and use the generic one

- Three patches for kdump, two bug fixes and one cleanup

- Three patches for the PCI layer, one bug fix and two cleanups

Harald Freudenberger (5):
      s390/zcrypt: fix ap_instructions_available() returncodes
      s390/zcrypt: switch return type to bool for ap_instructions_available()
      s390/zcrypt: code beautify
      s390/zcrypt: AP bus support for alternate driver(s)
      s390/zcrypt: hex string mask improvements for apmask and aqmask.

Heiko Carstens (2):
      s390: reenable gcc plugins for real
      s390: remove gcc version check (4.3 or newer)

Philipp Rudo (3):
      s390/kdump: Make elfcorehdr size calculation ABI compliant
      s390/kdump: Fix memleak in nt_vmcoreinfo
      s390/kdump: Remove kzalloc_panic

Sebastian Ott (3):
      s390/pci: fix out of bounds access during irq setup
      s390/pci: remove stale rc
      s390/pci: remove fmb address from debug output

 arch/s390/Kconfig                      |   2 +-
 arch/s390/include/asm/ap.h             |  14 +-
 arch/s390/include/uapi/asm/zcrypt.h    |  72 +++---
 arch/s390/kernel/asm-offsets.c         |   8 -
 arch/s390/kernel/crash_dump.c          |  70 +++---
 arch/s390/pci/pci.c                    |   3 +-
 arch/s390/pci/pci_debug.c              |   1 -
 drivers/s390/crypto/ap_bus.c           | 432 ++++++++++++++++++++++++++++++---
 drivers/s390/crypto/ap_bus.h           |  36 ++-
 drivers/s390/crypto/ap_card.c          |  50 ++--
 drivers/s390/crypto/ap_queue.c         |  38 +--
 drivers/s390/crypto/pkey_api.c         |  91 +++----
 drivers/s390/crypto/zcrypt_api.c       |  30 ++-
 drivers/s390/crypto/zcrypt_api.h       |   2 +-
 drivers/s390/crypto/zcrypt_card.c      |  29 ++-
 drivers/s390/crypto/zcrypt_cca_key.h   |  12 +-
 drivers/s390/crypto/zcrypt_cex2a.c     |   2 +
 drivers/s390/crypto/zcrypt_cex2a.h     |  18 +-
 drivers/s390/crypto/zcrypt_cex4.c      |   2 +
 drivers/s390/crypto/zcrypt_error.h     |   2 +-
 drivers/s390/crypto/zcrypt_msgtype50.c |  17 +-
 drivers/s390/crypto/zcrypt_msgtype50.h |   8 +-
 drivers/s390/crypto/zcrypt_msgtype6.c  |  34 ++-
 drivers/s390/crypto/zcrypt_msgtype6.h  |   2 +-
 drivers/s390/crypto/zcrypt_pcixcc.c    |   6 +-
 drivers/s390/crypto/zcrypt_pcixcc.h    |   2 +-
 drivers/s390/crypto/zcrypt_queue.c     |  23 +-
 27 files changed, 706 insertions(+), 300 deletions(-)
