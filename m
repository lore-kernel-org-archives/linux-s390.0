From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [RFC PATCH 0/3] kvm: Make ioeventfd usable on s390.
Date: Thu, 21 Feb 2013 14:12:57 +0100
Message-ID: <1361452380-50398-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
List-ID: <linux-s390.vger.kernel.org>

This patch series aims at making ioeventfds usable on s390.

For "normal" architectures, ioeventfds work by registering
notifications that trap on write operations on memory, making
it possible to handle those writes in the kernel. This won't
work on s390, however.

We want a mechanism that enables trapping of operations equivalent
to the memory writes on other architectures - for the use case
we care about, the diagnose 500 hypercall that performs
virtio notifications. (There's room for other types as well.)

Patch 1 is a preparation patch for kvm/s390.

Patch 2 tries to split out the parts of the ioeventfd mechanism
that need to be implemented differently on special architectures
(i. e. s390). If __KVM_HAVE_ARCH_IOEVENTFD is set, the architecture
will provide a set of kvm_arch_ioeventfd_* functions to be used
instead of the kvm_arch_ioeventfd_* functions implementing the
generic mechanism. Extra payload for the KVM_IOEVENTFD ioctl
can be provided in the existing data fields (renamed to data).
A new flag, KVM_IOEVENTFD_FLAG_ARCH, is used to indicate that an
architecture-specific implementation is used that makes use of
the extra data fields.

Patch 3 implements the kvm_arch_ioeventfd_* functions for s390
and hooks up ioeventfds with diagnose 500.

There's also a companion qemu patch series that makes use of this
for virtio-ccw.

(Patches are against kvm-next.)

Cornelia Huck (3):
  KVM: s390: Move out initialization code.
  KVM: Generalize ioeventfds.
  KVM: s390: Hook up ioeventfds.

 Documentation/virtual/kvm/api.txt |   5 +-
 arch/s390/include/asm/kvm_host.h  |  23 +++++
 arch/s390/kvm/Kconfig             |   1 +
 arch/s390/kvm/Makefile            |   6 +-
 arch/s390/kvm/diag.c              |  23 +++++
 arch/s390/kvm/init.c              |  52 +++++++++++
 arch/s390/kvm/kvm-s390.c          | 181 +++++++++++++++++++++++++++++++++-----
 arch/s390/kvm/kvm-s390.h          |   3 +
 include/linux/kvm_host.h          |  13 +++
 include/uapi/linux/kvm.h          |   4 +-
 virt/kvm/eventfd.c                | 181 ++++++++++++++++++++++++++------------
 11 files changed, 410 insertions(+), 82 deletions(-)
 create mode 100644 arch/s390/kvm/init.c

-- 
1.7.12.4
