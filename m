From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 0/7] KVM: irqfds for s390
Date: Tue, 25 Feb 2014 18:24:38 +0100
Message-ID: <1393349085-18122-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, pbonzini@redhat.com, gleb@kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi,

here's my current patchset enabling irqfds for s390, based on current
kvm/queue.

It introduces adapter interrupts for virtio-ccw (these have been specced
for virtio-1.0 in the virtio oasis standard that is currently under work).
We use two-staged indicators for the queue indicator area (summary indicator)
and the queue indicators. Mainly fixes compared to the last time I posted
this as an RFC (it has been some time...)

For implementing irqfds, we exploit the common infrastructure via adding
a new interrupt routing type for adapter interrupts. Each of these routes
contains several parameters like the matching I/O adapter and the locations
of the summary and queue indicators - one route per virtqueue.

Patches 1 and 2 are relevant for guest support for adapter interrupts.
Patch 1 will be pushed upstream via the s390 architecture tree.

Patch 3 tries to fix a problem in the common irqfd code I managed to trigger;
it might make sense to push this on its own.

Patch 4 introduces infrastructure to enable capabilities on a per-vm basis
(instead of only per-vcpu). It might be of common interest, but will be
used in this patchset to introduce a s390-specific irqchip capability that
needs to be enabled by userspace.

Patch 5 introduces the concept of I/O adapters that act as adapter interrupt
sources. They contain various characteristics, not all of them relevant for
virtio-ccw but of general use for other types of adapter interrupts. They
are registered and modified via the new s390 floating interrupt controller.

Patch 6 finally wires up irqfds for virtio-ccw adapter interrupts. The
capability for this needs to be explicitly enabled by userspace to avoid
older qemus choking on newer kernels.

Patch 7 is providing a stop-gap measure to let us run not-quite-as-small
guests: we gobble up irqroutes fairly quickly. There must be a better way.

A git branch with the patches is available at

git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git kvms390-irqfd


Cornelia Huck (6):
  KVM: s390: virtio-ccw adapter interrupt support.
  KVM: eventfd: Fix lock order inversion.
  KVM: Add per-vm capability enablement.
  KVM: s390: adapter interrupt sources
  KVM: s390: irq routing for adapter interrupts.
  KVM: Bump KVM_MAX_IRQ_ROUTES for s390

Martin Schwidefsky (1):
  s390/airq: add support for irq ranges

 Documentation/virtual/kvm/api.txt               |   27 ++-
 Documentation/virtual/kvm/devices/s390_flic.txt |   45 ++++
 arch/s390/include/asm/airq.h                    |   14 +-
 arch/s390/include/asm/irq.h                     |    1 +
 arch/s390/include/asm/kvm_host.h                |   30 +++
 arch/s390/include/uapi/asm/kvm.h                |   22 ++
 arch/s390/kernel/irq.c                          |    1 +
 arch/s390/kvm/Kconfig                           |    2 +
 arch/s390/kvm/Makefile                          |    2 +-
 arch/s390/kvm/interrupt.c                       |  287 ++++++++++++++++++++++-
 arch/s390/kvm/irq.h                             |   22 ++
 arch/s390/kvm/kvm-s390.c                        |   42 ++++
 arch/s390/kvm/kvm-s390.h                        |    2 +
 drivers/s390/cio/airq.c                         |   66 ++++--
 drivers/s390/kvm/virtio_ccw.c                   |  276 +++++++++++++++++++++-
 include/linux/kvm_host.h                        |   13 +
 include/uapi/linux/kvm.h                        |   16 ++
 virt/kvm/eventfd.c                              |    8 +-
 18 files changed, 827 insertions(+), 49 deletions(-)
 create mode 100644 arch/s390/kvm/irq.h

-- 
1.7.9.5
