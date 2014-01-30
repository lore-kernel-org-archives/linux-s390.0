From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL 0/8] KVM: s390: floating interrupt controller and asyncpf
Date: Thu, 30 Jan 2014 13:53:41 +0100
Message-ID: <1391086429-43935-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Gleb,

The following changes since commit c760f5e29d92adf5184589f1e616a4be146fb57c:

  Merge tag 'kvm-s390-20140117' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into kvm-queue (2014-01-23 11:38:13 +0100)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-20140130

for you to fetch changes up to 536336c21697551ceca44bdffb9f53e6cc5f2f20:

  KVM: async_pf: Exploit one reg interface for pfault (2014-01-30 13:11:05 +0100)

The patches set should address all comments given.


Please pull into kvm/next.

Christian

----------------------------------------------------------------
Two new features are added by this patch set:
- The floating interrupt controller (flic) that allows us to inject,
  clear and inspect non-vcpu local interrupts. This also gives us an
  opportunity to fix deficiencies in our existing interrupt definitions.
- Support for asynchronous page faults via the pfault mechanism. Testing
  show significant guest performance improvements under host swap.

----------------------------------------------------------------
Dominik Dingel (5):
      KVM: s390: Add FAULT_FLAG_RETRY_NOWAIT for guest fault
      KVM: async_pf: Provide additional direct page notification
      KVM: async_pf: Allow to wait for outstanding work
      KVM: async_pf: Async page fault support on s390
      KVM: async_pf: Exploit one reg interface for pfault

Jens Freimann (3):
      KVM: s390: add and extend interrupt information data structs
      KVM: s390: add floating irq controller
      KVM: s390: limit floating irqs

 Documentation/virtual/kvm/devices/s390_flic.txt |  46 +++
 arch/s390/include/asm/kvm_host.h                |  58 ++--
 arch/s390/include/asm/pgtable.h                 |   2 +
 arch/s390/include/asm/processor.h               |   1 +
 arch/s390/include/uapi/asm/kvm.h                |  19 ++
 arch/s390/kvm/Kconfig                           |   2 +
 arch/s390/kvm/Makefile                          |   2 +-
 arch/s390/kvm/diag.c                            |  84 +++++
 arch/s390/kvm/interrupt.c                       | 389 ++++++++++++++++++++----
 arch/s390/kvm/kvm-s390.c                        | 135 +++++++-
 arch/s390/kvm/kvm-s390.h                        |   4 +
 arch/s390/kvm/sigp.c                            |   7 +
 arch/s390/kvm/trace.h                           |  46 +++
 arch/s390/mm/fault.c                            |  26 +-
 arch/x86/kvm/mmu.c                              |   2 +-
 include/linux/kvm_host.h                        |   3 +-
 include/uapi/linux/kvm.h                        |  66 ++++
 virt/kvm/Kconfig                                |   4 +
 virt/kvm/async_pf.c                             |  25 +-
 virt/kvm/kvm_main.c                             |   5 +
 20 files changed, 822 insertions(+), 104 deletions(-)
 create mode 100644 Documentation/virtual/kvm/devices/s390_flic.txt
