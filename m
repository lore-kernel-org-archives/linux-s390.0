Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 15 Feb 2020 13:27:27 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [GIT PULL] s390 updates for 5.6-rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Message-Id: <your-ad-here.call-01581769647-ext-0154@work.hours>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.6-rc2. One of the changes touches
crypto/testmgr.c which has been acked-by Herbert Xu.

Thank you,
Vasily

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.6-3

for you to fetch changes up to c7ff8573ad21dcdcbcffd66fbfca3b53cd67d2b1:

  crypto/testmgr: enable selftests for paes-s390 ciphers (2020-02-13 17:53:24 +0100)

----------------------------------------------------------------
s390 updates for 5.6-rc2

- Enable paes-s390 cipher selftests in testmgr (acked-by Herbert Xu).

- Fix protected key length update in PKEY_SEC2PROTK ioctl and increase
  card/queue requests counter to 64-bit in crypto code.

- Fix clang warning in get_tod_clock.

- Fix ultravisor info length extensions handling.

- Fix style of SPDX License Identifier in vfio-ccw.

- Avoid unnecessary GFP_ATOMIC and simplify ACK tracking in qdio.

----------------------------------------------------------------
Christian Borntraeger (1):
      s390/uv: Fix handling of length extensions

Harald Freudenberger (3):
      s390/pkey: fix missing length of protected key on return
      s390/zcrypt: fix card and queue total counter wrap
      crypto/testmgr: enable selftests for paes-s390 ciphers

Julian Wiedmann (2):
      s390/qdio: simplify ACK tracking
      s390/qdio: don't allocate *aob array with GFP_ATOMIC

Nathan Chancellor (1):
      s390/time: Fix clk type in get_tod_clock

Nishad Kamdar (1):
      vfio-ccw: Use the correct style for SPDX License Identifier

Vasily Gorbik (1):
      Merge tag 'vfio-ccw-20200206' of https://git.kernel.org/.../kvms390/vfio-ccw into HEAD

 arch/s390/boot/uv.c               |  3 ++-
 arch/s390/include/asm/timex.h     |  2 +-
 crypto/testmgr.c                  | 36 ++++++++++++++++++++++++++++++++++++
 drivers/s390/cio/qdio.h           |  4 +---
 drivers/s390/cio/qdio_debug.c     |  5 ++---
 drivers/s390/cio/qdio_main.c      | 29 +++++++++++------------------
 drivers/s390/cio/qdio_setup.c     |  2 +-
 drivers/s390/cio/vfio_ccw_trace.h |  4 ++--
 drivers/s390/crypto/ap_bus.h      |  4 ++--
 drivers/s390/crypto/ap_card.c     |  8 ++++----
 drivers/s390/crypto/ap_queue.c    |  6 +++---
 drivers/s390/crypto/pkey_api.c    |  2 +-
 drivers/s390/crypto/zcrypt_api.c  | 16 +++++++++-------
 13 files changed, 75 insertions(+), 46 deletions(-)
