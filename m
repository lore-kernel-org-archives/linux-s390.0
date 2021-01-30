Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 30 Jan 2021 16:32:38 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [GIT PULL] s390 updates for 5.11-rc6
Message-ID: <your-ad-here.call-01612020758-ext-9054@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

Hello Linus,

please pull s390 fixes for 5.11-rc6.

Thank you,
Vasily

The following changes since commit 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04:

  Linux 5.11-rc5 (2021-01-24 16:47:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.11-4

for you to fetch changes up to e82080e1f456467cc185fe65ee69fe9f9bd0b576:

  s390: uv: Fix sysfs max number of VCPUs reporting (2021-01-27 13:00:04 +0100)

----------------------------------------------------------------
- Fix max number of VCPUs reported via ultravisor information sysfs interface.

- Fix memory leaks during vfio-ap resources clean up on KVM pointer
  invalidation notification.

- Fix potential specification exception by avoiding unnecessary interrupts
  disable after queue reset in vfio-ap.

----------------------------------------------------------------
Janosch Frank (1):
      s390: uv: Fix sysfs max number of VCPUs reporting

Tony Krowiak (2):
      s390/vfio-ap: clean up vfio_ap resources when KVM pointer invalidated
      s390/vfio-ap: No need to disable IRQ after queue reset

 arch/s390/boot/uv.c                   |   2 +-
 arch/s390/include/asm/uv.h            |   4 +-
 arch/s390/kernel/uv.c                 |   2 +-
 drivers/s390/crypto/vfio_ap_drv.c     |   6 +-
 drivers/s390/crypto/vfio_ap_ops.c     | 149 ++++++++++++++++++++--------------
 drivers/s390/crypto/vfio_ap_private.h |  12 +--
 6 files changed, 101 insertions(+), 74 deletions(-)
