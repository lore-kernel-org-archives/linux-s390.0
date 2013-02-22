From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [RFC PATCH v2 0/4] kvm: Make ioeventfd usable on s390.
Date: Fri, 22 Feb 2013 13:09:45 +0100
Message-ID: <1361534989-38884-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Here's the second attempt at implementing ioeventfd for s390.

Rather than the architecture-specific functions used in v1, we
now try to integrate with the kvm_io_device infrastructure.
Calls to diagnose 500 subcode 3 are now mapped to _write.
These devices are created on a new KVM_CSS_BUS when using a
new flag KVM_IOEVENTFD_FLAG_CSS. addr and datamatch are (ab)used
to contain the subchannel id and the virtqueue.

A drawback is that this interface is not easily extendable should
we want to attach other hypercalls or carry more payload.

Another limitation is the limit of 1000 io devices per bus, which
we would hit easily with a few hundred devices, but that should
be fixable.

v1 -> v2:
- Move irqfd initialization from a module init function to kvm_init,
  eliminating the need for a second module for kvm/s390.
- Use kvm_io_device for s390 css devices.


Cornelia Huck (4):
  KVM: Initialize irqfd from kvm_init().
  KVM: Introduce KVM_CSS_BUS.
  KVM: ioeventfd for s390 css devices.
  KVM: s390: Wire up ioeventfd.

 Documentation/virtual/kvm/api.txt |  7 +++++++
 arch/s390/kvm/Kconfig             |  1 +
 arch/s390/kvm/Makefile            |  2 +-
 arch/s390/kvm/diag.c              | 25 +++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.c          |  1 +
 include/linux/kvm_host.h          | 14 ++++++++++++++
 include/uapi/linux/kvm.h          |  2 ++
 virt/kvm/eventfd.c                | 15 ++++++++-------
 virt/kvm/kvm_main.c               |  6 ++++++
 9 files changed, 65 insertions(+), 8 deletions(-)

-- 
1.7.12.4
