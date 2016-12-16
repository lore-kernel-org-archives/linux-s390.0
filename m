Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 16 Dec 2016 07:45:06 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.10 merge window #2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20161216074506.1467a61c@mschwideX1>
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

Over 95% of the changes in this pull request are related to the zcrypt
driver. There are five improvements for zcrypt: the ID for the CEX6 cards
is added, workload balancing and multi-domain support are introduced,
the debug logs are overhauled and a set of tracepoints is added.

Then there are several patches in regard to inline assemblies. One compile
fix and several missing memory clobbers. As far as we can tell the omitted
memory clobbers have not caused any breakage.

A small change to the PCI arch code, the machine can tells us how big
the function measurement blocks are. The PCI function measurement will
be disabled for a device if the queried length is larger than the
allocated size for these blocks.

And two more patches to correct five printk messages.

That is it for s390 in regard to the 4.10 merge window. Happy holidays.

Harald Freudenberger (5):
      s390/zcrypt: Introduce CEX6 toleration
      s390/zcrypt: Correct function bits for CEX2x and CEX3x cards.
      s390/zcrypt: Improved invalid domain response handling.
      s390/zcrypt: Rework debug feature invocations.
      s390/zcrypt: tracepoint definitions for zcrypt device driver.

Heiko Carstens (6):
      s390: fix compile error with memmove_early() inline assembly
      s390/cpumf: fix qsi inline assembly
      s390/lib: add missing memory barriers to string inline assemblies
      s390/nmi: fix inline assembly constraints
      s390/extmem: add missing memory clobber to dcss_set_subcodes
      s390/zcrypt: add missing memory clobber to ap_qci inline assembly

Ingo Tuchscherer (6):
      s390/zcrypt: Move the ap bus into kernel
      s390/zcrypt: Introduce workload balancing
      s390/zcrypt: add multi domain support
      s390/zcrypt: Introduce new zcrypt device status API
      s390/zcrypt: Fixed attrition of AP adapters and domains
      s390/zcrypt: Fix ap_max_domain_id for older machine types

Martin Schwidefsky (4):
      s390/zcrypt: simplify message type handling
      s390/zcrypt: header for the AP inline assmblies
      s390/zcrypt: get rid of ap_poll_requests
      s390/setup: reword printk messages

Sebastian Ott (1):
      s390/pci: query fmb length

Stefan Haberland (1):
      s390/dasd: fix typos in DASD error messages

 arch/s390/include/asm/cpu_mf.h         |   10 +-
 arch/s390/include/asm/pci.h            |    1 +
 arch/s390/include/asm/pci_clp.h        |    3 +-
 arch/s390/include/asm/string.h         |    8 +-
 arch/s390/include/asm/trace/zcrypt.h   |  122 +++
 arch/s390/include/uapi/asm/zcrypt.h    |   37 +
 arch/s390/kernel/early.c               |    2 +-
 arch/s390/kernel/nmi.c                 |   19 +-
 arch/s390/kernel/setup.c               |    4 +-
 arch/s390/lib/string.c                 |   12 +-
 arch/s390/mm/extmem.c                  |    2 +-
 arch/s390/pci/pci.c                    |    2 +-
 arch/s390/pci/pci_clp.c                |    1 +
 drivers/s390/block/dasd_3990_erp.c     |    6 +-
 drivers/s390/crypto/Makefile           |   13 +-
 drivers/s390/crypto/ap_asm.h           |  191 +++++
 drivers/s390/crypto/ap_bus.c           | 1331 +++++++++-----------------------
 drivers/s390/crypto/ap_bus.h           |   98 ++-
 drivers/s390/crypto/ap_card.c          |  170 ++++
 drivers/s390/crypto/ap_debug.h         |   28 +
 drivers/s390/crypto/ap_queue.c         |  701 +++++++++++++++++
 drivers/s390/crypto/zcrypt_api.c       | 1137 +++++++++++++--------------
 drivers/s390/crypto/zcrypt_api.h       |   99 ++-
 drivers/s390/crypto/zcrypt_card.c      |  187 +++++
 drivers/s390/crypto/zcrypt_cex2a.c     |  214 +++--
 drivers/s390/crypto/zcrypt_cex4.c      |  319 +++++---
 drivers/s390/crypto/zcrypt_debug.h     |   50 +-
 drivers/s390/crypto/zcrypt_error.h     |  105 +--
 drivers/s390/crypto/zcrypt_msgtype50.c |  135 ++--
 drivers/s390/crypto/zcrypt_msgtype50.h |    5 +-
 drivers/s390/crypto/zcrypt_msgtype6.c  |  660 ++++++++++------
 drivers/s390/crypto/zcrypt_msgtype6.h  |   23 +-
 drivers/s390/crypto/zcrypt_pcixcc.c    |  376 ++++-----
 drivers/s390/crypto/zcrypt_queue.c     |  226 ++++++
 include/linux/mod_devicetable.h        |    3 +-
 35 files changed, 3915 insertions(+), 2385 deletions(-)
 create mode 100644 arch/s390/include/asm/trace/zcrypt.h
 create mode 100644 drivers/s390/crypto/ap_asm.h
 create mode 100644 drivers/s390/crypto/ap_card.c
 create mode 100644 drivers/s390/crypto/ap_debug.h
 create mode 100644 drivers/s390/crypto/ap_queue.c
 create mode 100644 drivers/s390/crypto/zcrypt_card.c
 create mode 100644 drivers/s390/crypto/zcrypt_queue.c
