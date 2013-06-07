From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC 0/2] KVM: s390: virtio-ccw adapter interrupts.
Date: Fri,  7 Jun 2013 12:37:09 +0200
Message-ID: <1370601431-46381-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

Hi,

here's the guest driver support for adapter interrupts in virtio-ccw.

We use one summary indicator per page of indicators. For each device,
we try to find a space in an indicator where all of its virtqueues fit.

Locking probably needs some more love, but it seems to work fine so far.

Cornelia Huck (2):
  KVM: s390: virtio-ccw: Handle command rejects.
  KVM: s390: virtio-ccw adapter interrupt support.

 arch/s390/include/asm/irq.h   |   1 +
 arch/s390/kernel/irq.c        |   1 +
 drivers/s390/kvm/virtio_ccw.c | 307 ++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 298 insertions(+), 11 deletions(-)

-- 
1.8.1.6
