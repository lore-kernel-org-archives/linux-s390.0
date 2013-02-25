From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH v3 0/5] kvm: Make ioeventfd usable on s390.
Date: Mon, 25 Feb 2013 16:27:45 +0100
Message-ID: <1361806070-62465-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
List-ID: <linux-s390.vger.kernel.org>

Here's the latest version of my patch series enabling ioeventfds
on s390, again against kvm-next.

Patches 1 and 2 (cleaning up initialization and exporting the virtio-ccw
api) would make sense even independent of the ioeventfd enhancements.

Patches 3-5 are concerned with adding a new type of ioeventfds for
virtio-ccw notifications on s390. The naming is now hopefully clearer.
We won't add ioeventfd support for the legacy s390-virtio transport.

Please consider applying.

v2 -> v3:
- Added a patch exporting the virtio-ccw api and use it for the
  diagnose implementation.
- Better naming: We're dealing with virtio-ccw notifications only.
v1 -> v2:
- Move irqfd initialization from a module init function to kvm_init,
  eliminating the need for a second module for kvm/s390.
- Use kvm_io_device for s390 css devices.

Cornelia Huck (5):
  KVM: Initialize irqfd from kvm_init().
  KVM: s390: Export virtio-ccw api.
  KVM: Introduce KVM_VIRTIO_CCW_NOTIFY_BUS.
  KVM: ioeventfd for virtio-ccw devices.
  KVM: s390: Wire up ioeventfd.

 Documentation/virtual/kvm/api.txt       |  8 ++++++++
 arch/s390/include/uapi/asm/Kbuild       |  1 +
 arch/s390/include/uapi/asm/virtio-ccw.h | 21 +++++++++++++++++++++
 arch/s390/kvm/Kconfig                   |  1 +
 arch/s390/kvm/Makefile                  |  2 +-
 arch/s390/kvm/diag.c                    | 26 ++++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.c                |  1 +
 drivers/s390/kvm/virtio_ccw.c           |  5 +----
 include/linux/kvm_host.h                | 14 ++++++++++++++
 include/uapi/linux/kvm.h                |  3 +++
 virt/kvm/eventfd.c                      | 21 ++++++++++++++-------
 virt/kvm/kvm_main.c                     |  6 ++++++
 12 files changed, 97 insertions(+), 12 deletions(-)
 create mode 100644 arch/s390/include/uapi/asm/virtio-ccw.h

-- 
1.7.12.4
