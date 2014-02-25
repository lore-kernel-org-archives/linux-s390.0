From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 0/6] qemu: irqfds for s390x
Date: Tue, 25 Feb 2014 18:25:14 +0100
Message-ID: <1393349120-18228-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, pbonzini@redhat.com, gleb@kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi,

here's the companion patchset to "KVM: irqfds for s390", based on
Christian's s390-next branch.

Patch 1 adds support for adapter interrupts to virtio-ccw. This has been
posted before, modulo some fixes.

Patch 2 grabs the interfaces introduced by the kernel patchset. Will be
replaced by a normal headers update.

Patch 3 introduces simple wrappers for enabling capabilities. We can convert
existing users later on.

Patch 4 registers an I/O adapter when we enable adapter interrupts for a
device. We just have one virtio-ccw adapter for one interruption subclass.

Patch 5 adds reference counting for indicators. This is needed because we
want to map and pin indicator pages and drop them again when the last user
is gone.

Patch 6 finally enables irqfds via irq routing on s390x/virtio-ccw. We've
done most of the work in qemu already, so the kernel basically only needs
to write to the correct memory location and inject an interrupt.

A git branch with the patches is available at

https://github.com/cohuck/qemu.git s390x-irqfd


Cornelia Huck (6):
  s390x/virtio-ccw: Adapter interrupt support.
  linux-headers: add new interfaces
  kvm: add kvm_enable_cap_{vm,vcpu}
  s390x: Add I/O adapter registration.
  s390x/virtio-ccw: reference-counted indicators
  s390x/virtio-ccw: Wire up irq routing and irqfds.

 hw/intc/s390_flic.c          |   66 +++++++++
 hw/s390x/css.c               |   61 ++++++++
 hw/s390x/css.h               |    6 +
 hw/s390x/virtio-ccw.c        |  325 +++++++++++++++++++++++++++++++++++++++---
 hw/s390x/virtio-ccw.h        |   18 ++-
 include/hw/s390x/adapter.h   |   23 +++
 include/qemu/typedefs.h      |    1 +
 include/sysemu/kvm.h         |    6 +
 kvm-all.c                    |   57 +++++++-
 kvm-stub.c                   |    5 +
 linux-headers/asm-s390/kvm.h |   22 +++
 linux-headers/linux/kvm.h    |   16 +++
 target-s390x/cpu.h           |   33 +++++
 target-s390x/ioinst.h        |    2 +
 target-s390x/kvm.c           |   13 +-
 trace-events                 |    1 +
 16 files changed, 627 insertions(+), 28 deletions(-)
 create mode 100644 include/hw/s390x/adapter.h

-- 
1.7.9.5
