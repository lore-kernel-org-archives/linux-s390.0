From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [RFC PATCH v2 0/2] KVM: s390: virtio-ccw adapter interrupts.
Date: Tue,  9 Jul 2013 13:34:15 +0200
Message-ID: <1373369657-51675-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

Hi,

next version of the guest exploitation of virtio-ccw adapter interrupts.

Changes from the last version:

- adapt to latest kvm-next
- changed housekeeping for indicator locations: we now use cacheline-sized
  and aligned areas
- minor tweaks

Cornelia Huck (2):
  KVM: s390: virtio-ccw: Handle command rejects.
  KVM: s390: virtio-ccw adapter interrupt support.

 arch/s390/include/asm/irq.h   |   1 +
 arch/s390/kernel/irq.c        |   1 +
 drivers/s390/kvm/virtio_ccw.c | 314 ++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 305 insertions(+), 11 deletions(-)

-- 
1.8.2.2
