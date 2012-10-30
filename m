From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH v2 0/5] s390: Guest support for virtio-ccw.
Date: Tue, 30 Oct 2012 16:56:38 +0100
Message-ID: <1351612603-31036-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi,

here's the respin of the virtio-ccw guest support patches
(from http://marc.info/?l=kvm&m=135151606921361&w=2).

Changes to the last version:

- cc'ed stable for patch 1
- coding style fixes in patches 4 and 5

Cornelia Huck (5):
  KVM: s390: Handle hosts not supporting s390-virtio.
  s390: Move css limits from drivers/s390/cio/ to include/asm/.
  s390: Add a mechanism to get the subchannel id.
  KVM: s390: Add a channel I/O based virtio transport driver.
  KVM: s390: Split out early console code.

 arch/s390/include/asm/ccwdev.h  |   5 +
 arch/s390/include/asm/cio.h     |   2 +
 arch/s390/include/asm/irq.h     |   1 +
 arch/s390/kernel/irq.c          |   1 +
 drivers/s390/cio/css.h          |   3 -
 drivers/s390/cio/device_ops.c   |  12 +
 drivers/s390/kvm/Makefile       |   2 +-
 drivers/s390/kvm/early_printk.c |  42 ++
 drivers/s390/kvm/kvm_virtio.c   |  64 ++-
 drivers/s390/kvm/virtio_ccw.c   | 843 ++++++++++++++++++++++++++++++++++++++++
 10 files changed, 938 insertions(+), 37 deletions(-)
 create mode 100644 drivers/s390/kvm/early_printk.c
 create mode 100644 drivers/s390/kvm/virtio_ccw.c

-- 
1.7.12.4
