From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [RFC PATCH 0/4] s390: virtio-ccw guest kernel support.
Date: Tue,  7 Aug 2012 16:52:44 +0200
Message-ID: <1344351168-2568-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi,

the following patches are for Linux running as a guest under a
host with virtio-ccw support.

Patch 1 makes the kvm_virtio driver exit gracefully if the page
containing s390-virtio information it expects is not present; it
could probably go in seperately from the other patches.

Patch 2 exports a needed interface.

Patch 3 adds a driver handling virtio-ccw devices. The virtual
subchannels have ccw devices with a special CU id this driver
matches for. The virtio_ccw driver handles configuration and
operation via the special new channel commands.

Patch 4 is a split out of common code.

Cornelia Huck (4):
  s390/kvm: Handle hosts not supporting s390-virtio.
  s390: Add a mechanism to get the subchannel id.
  s390/kvm: Add a channel I/O based virtio transport driver.
  s390/kvm: Split out early console code.

 arch/s390/include/asm/ccwdev.h  |   5 +
 arch/s390/include/asm/irq.h     |   1 +
 arch/s390/kernel/irq.c          |   1 +
 drivers/s390/cio/device_ops.c   |  10 +
 drivers/s390/kvm/Makefile       |   2 +-
 drivers/s390/kvm/early_printk.c |  42 +++
 drivers/s390/kvm/kvm_virtio.c   |  46 ++-
 drivers/s390/kvm/virtio_ccw.c   | 760 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 841 insertions(+), 26 deletions(-)
 create mode 100644 drivers/s390/kvm/early_printk.c
 create mode 100644 drivers/s390/kvm/virtio_ccw.c

-- 
1.7.11.4
