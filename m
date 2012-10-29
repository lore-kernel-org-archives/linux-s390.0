From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 0/5] s390: Guest support for virtio-ccw.
Date: Mon, 29 Oct 2012 14:07:21 +0100
Message-ID: <1351516046-30037-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Avi, Marcelo,

I'd like to propose inclusion of the guest support patches for
virtio-ccw into 3.8.

I'm confident that the host <-> guest interface for virtio-ccw
is fine now, and the patches have been extensively tested by our
internal test team.

Patch 1 might conceivably be 3.7 material, though I fear it's a
bit late for that.

Patch 2 has been moved over from the host-support patchset since
the limits are needed by the guest driver as well.

Patch 4 has seen some further bugfixes (feature bits, 2G and 4G
problems, device detach handling) and is working well in our
internal environment.

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
 drivers/s390/kvm/virtio_ccw.c   | 841 ++++++++++++++++++++++++++++++++++++++++
 10 files changed, 936 insertions(+), 37 deletions(-)
 create mode 100644 drivers/s390/kvm/early_printk.c
 create mode 100644 drivers/s390/kvm/virtio_ccw.c

-- 
1.7.12.4
