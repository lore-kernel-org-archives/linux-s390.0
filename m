Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 28 Mar 2019 09:55:44 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 5.1 #2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190328095544.1930d8c7@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The following changes since commit 3717f613f48df0222311f974cf8a06c8a6c97bae:

  Merge branch 'core-rcu-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2019-03-05 14:49:11 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux tags/s390-5.1-2

for you to fetch changes up to b6ffdf27f3d4f1e9af56effe6f86989170d71e95:

  s390/cpumf: Fix warning from check_processor_id (2019-03-28 09:28:42 +0100)

----------------------------------------------------------------
s390 update with improvements and bug fixes for 5.1-rc2

 - Fix early free of the channel program in vfio

 - On AP device removal make sure that all messages are flushed
   with the driver still attached that queued the message

 - Limit brk randomization to 32MB to reduce the chance that the
   heap of ld.so is placed after the main stack

 - Add a rolling average for the steal time of a CPU, this will be
   needed for KVM to decide when to do busy waiting

 - Fix a warning in the CPU-MF code

 - Add a notification handler for AP configuration change to react
   faster to new AP devices

----------------------------------------------------------------
Cornelia Huck (1):
      vfio: ccw: only free cp on final interrupt

Harald Freudenberger (1):
      s390/zcrypt: revisit ap device remove procedure

Martin Schwidefsky (3):
      s390: limit brk randomization to 32MB
      s390/vtime: steal time exponential moving average
      Merge tag 'vfio-ccw-20190311' of git://git.kernel.org/.../kvms390/vfio-ccw into fixes

Thomas Richter (1):
      s390/cpumf: Fix warning from check_processor_id

Tony Krowiak (1):
      zcrypt: handle AP Info notification from CHSC SEI command

 arch/s390/include/asm/ap.h           | 11 +++++++
 arch/s390/include/asm/elf.h          | 11 ++++---
 arch/s390/include/asm/lowcore.h      | 61 ++++++++++++++++++------------------
 arch/s390/kernel/perf_cpum_cf_diag.c | 19 +++++++----
 arch/s390/kernel/smp.c               |  3 +-
 arch/s390/kernel/vtime.c             | 19 ++++++-----
 drivers/s390/cio/chsc.c              | 13 ++++++++
 drivers/s390/cio/vfio_ccw_drv.c      |  8 +++--
 drivers/s390/crypto/ap_bus.c         | 19 ++++++++++-
 drivers/s390/crypto/ap_bus.h         |  2 ++
 drivers/s390/crypto/ap_queue.c       | 26 ++++++++++++---
 drivers/s390/crypto/zcrypt_api.c     | 30 +++++++++++-------
 12 files changed, 154 insertions(+), 68 deletions(-)
