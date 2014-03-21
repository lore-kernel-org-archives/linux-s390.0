From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH v3 0/5] qemu: irqfds for s390x
Date: Fri, 21 Mar 2014 13:52:32 +0100
Message-ID: <1395406357-14766-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, pbonzini@redhat.com, gleb@kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Here's the next iteration of the qemu patchset enabling irqfds for
s390x, again a companion patchset for "KVM: irqfds for s390".

Changes from v2:
- rebased against current master
- use object_resolve_path() to grab the flic
- more explicit return code check for enabling KVM_CAP_S390_IRQCHIP

Changes from v1:
- rebased against current master
- pick up changed capability numbers from the kvm patchset
- use c99 struct initializers in patch 3
- adapter interrupts are already upstream

The git branch at

https://github.com/cohuck/qemu.git s390x-irqfd

has been updated accordingly.

Cornelia Huck (5):
  linux-headers: add new interfaces
  kvm: add kvm_enable_cap_{vm,vcpu}
  s390x: Add I/O adapter registration.
  s390x/virtio-ccw: reference-counted indicators
  s390x/virtio-ccw: Wire up irq routing and irqfds.

 hw/intc/s390_flic.c          |   59 +++++++++++
 hw/s390x/css.c               |   51 +++++++++
 hw/s390x/css.h               |    4 +
 hw/s390x/virtio-ccw.c        |  241 +++++++++++++++++++++++++++++++++++++-----
 hw/s390x/virtio-ccw.h        |   16 ++-
 include/hw/s390x/adapter.h   |   23 ++++
 include/qemu/typedefs.h      |    1 +
 include/sysemu/kvm.h         |    6 ++
 kvm-all.c                    |   57 +++++++++-
 kvm-stub.c                   |    5 +
 linux-headers/asm-s390/kvm.h |   24 +++++
 linux-headers/linux/kvm.h    |   17 +++
 target-s390x/cpu.h           |   33 ++++++
 target-s390x/kvm.c           |    5 +
 14 files changed, 513 insertions(+), 29 deletions(-)
 create mode 100644 include/hw/s390x/adapter.h

-- 
1.7.9.5
