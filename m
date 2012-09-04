From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [RFC PATCH v2 0/4] s390: virtio-ccw guest kernel support.
Date: Tue,  4 Sep 2012 17:13:38 +0200
Message-ID: <1346771622-52763-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi,

here's the second revision of the guest support for virtio-ccw.

The first patch has gotten several changes and now handles checking
for s390-virtio support much more nicely.

The third patch has been adapted to the changed virtio-ccw interface.

Cornelia Huck (4):
  s390/kvm: Handle hosts not supporting s390-virtio.
  s390: Add a mechanism to get the subchannel id.
  s390/kvm: Add a channel I/O based virtio transport driver.
  s390/kvm: Split out early console code.

 arch/s390/include/asm/ccwdev.h  |   5 +
 arch/s390/include/asm/irq.h     |   1 +
 arch/s390/kernel/irq.c          |   1 +
 drivers/s390/cio/device_ops.c   |  12 +
 drivers/s390/kvm/Makefile       |   2 +-
 drivers/s390/kvm/early_printk.c |  42 +++
 drivers/s390/kvm/kvm_virtio.c   |  64 ++--
 drivers/s390/kvm/virtio_ccw.c   | 789 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 882 insertions(+), 34 deletions(-)
 create mode 100644 drivers/s390/kvm/early_printk.c
 create mode 100644 drivers/s390/kvm/virtio_ccw.c

-- 
1.7.11.5
