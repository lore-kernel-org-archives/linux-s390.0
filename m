From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [RFC PATCH 0/2] qemu: ioeventfd for virtio-ccw.
Date: Thu, 21 Feb 2013 14:13:10 +0100
Message-ID: <1361452392-55867-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

This patch series makes use of the s390 ioeventfd implementation
to speed up virtio-ccw a bit.

We hook up virtio notifications via diagnose 500 as ioeventfds,
specifying a subchannel id and virtqueue index combination.

ioeventfds are used by default for all virtio devices; there's
an ioeventfd property that can be used to turn ioeventfd usage
off for a device (similar to virtio-pci).

A simple dd on a virtio-blk device
   dd if=/dev/vda of=/dev/null iflag=direct bs=4k count=10000
is now twice as fast :)

(Patches are against master.)

Cornelia Huck (2):
  linux-headers: Update with ioeventfd changes.
  virtio-ccw: Wire up ioeventfd.

 hw/s390x/css.c            |   2 +-
 hw/s390x/css.h            |   1 +
 hw/s390x/virtio-ccw.c     | 114 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/virtio-ccw.h     |   7 +++
 linux-headers/linux/kvm.h |   4 +-
 target-s390x/cpu.h        |  16 +++++++
 target-s390x/kvm.c        |  27 +++++++++++
 7 files changed, 169 insertions(+), 2 deletions(-)

-- 
1.7.12.4
