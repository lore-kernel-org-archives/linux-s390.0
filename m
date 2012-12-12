From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH v4 0/4] s390: Guest support for virtio-ccw.
Date: Wed, 12 Dec 2012 17:36:37 +0100
Message-ID: <1355330201-36481-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi,

here's the next iteration of the virtio-ccw guest support patches,
hopefully ready for kvm/next now.

Changes from v3:
- The virtio console early printk support remains confined to
  the old s390-virtio transport.
- virtio-ccw passes the subchannel id directly in the register
  instead of casting.

Cornelia Huck (4):
  KVM: s390: Handle hosts not supporting s390-virtio.
  s390: Move css limits from drivers/s390/cio/ to include/asm/.
  s390: Add a mechanism to get the subchannel id.
  KVM: s390: Add a channel I/O based virtio transport driver.

 arch/s390/include/asm/ccwdev.h |   5 +
 arch/s390/include/asm/cio.h    |   2 +
 arch/s390/include/asm/irq.h    |   1 +
 arch/s390/kernel/irq.c         |   1 +
 drivers/s390/cio/css.h         |   3 -
 drivers/s390/cio/device_ops.c  |  12 +
 drivers/s390/kvm/Makefile      |   2 +-
 drivers/s390/kvm/kvm_virtio.c  |  38 +-
 drivers/s390/kvm/virtio_ccw.c  | 854 +++++++++++++++++++++++++++++++++++++++++
 9 files changed, 906 insertions(+), 12 deletions(-)
 create mode 100644 drivers/s390/kvm/virtio_ccw.c

-- 
1.7.12.4
