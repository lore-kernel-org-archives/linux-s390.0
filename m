From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH v2 0/5] KVM: irqfds for s390
Date: Mon, 17 Mar 2014 19:11:34 +0100
Message-ID: <1395079899-29239-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, pbonzini@redhat.com, gleb@kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi,

here's the next iteration of my patchset introducing irqfds for s390.

Changes from v1:
- rebased against current kvm/queue, bumping capability numbers
- guest adapter interrupt support is already in the kvm tree

I'd really like to get some feedback for the architecture independent
changes (and perhaps some thoughts on the restrictions described in the
last patch).

Again, find it on

git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git kvms390-irqfd

Cornelia Huck (5):
  KVM: eventfd: Fix lock order inversion.
  KVM: Add per-vm capability enablement.
  KVM: s390: adapter interrupt sources
  KVM: s390: irq routing for adapter interrupts.
  KVM: Bump KVM_MAX_IRQ_ROUTES for s390

 Documentation/virtual/kvm/api.txt               |   27 ++-
 Documentation/virtual/kvm/devices/s390_flic.txt |   45 ++++
 arch/s390/include/asm/kvm_host.h                |   30 +++
 arch/s390/include/uapi/asm/kvm.h                |   22 ++
 arch/s390/kvm/Kconfig                           |    2 +
 arch/s390/kvm/Makefile                          |    2 +-
 arch/s390/kvm/interrupt.c                       |  287 ++++++++++++++++++++++-
 arch/s390/kvm/irq.h                             |   22 ++
 arch/s390/kvm/kvm-s390.c                        |   42 ++++
 arch/s390/kvm/kvm-s390.h                        |    2 +
 include/linux/kvm_host.h                        |   13 +
 include/uapi/linux/kvm.h                        |   16 ++
 virt/kvm/eventfd.c                              |    8 +-
 13 files changed, 506 insertions(+), 12 deletions(-)
 create mode 100644 arch/s390/kvm/irq.h

-- 
1.7.9.5
