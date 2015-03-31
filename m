From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/8] KVM: s390: Features and fixes for 4.1 (kvm/next)
Date: Tue, 31 Mar 2015 15:01:55 +0200
Message-ID: <1427806923-21910-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Marcelo,

here is (hopefully) the last bunch of changes for 4.1 in KVM.

As we have again new interfaces, please review and consider for
kvm/next.

Christian


The following changes since commit 18280d8b4bcd4a2b174ee3cd748166c6190acacb:

  KVM: s390: represent SIMD cap in kvm facility (2015-03-17 16:33:14 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-20150331

for you to fetch changes up to dee6cea97c02f4f7d6efcfd1a0c8459b2b9adf7a:

  KVM: s390: migrate vcpu interrupt state (2015-03-31 13:49:18 +0200)

----------------------------------------------------------------
Features and fixes for 4.1 (kvm/next)

1. Assorted changes
1.1 allow more feature bits for the guest
1.2 Store breaking event address on program interrupts

2. Interrupt handling rework
2.1 Fix copy_to_user while holding a spinlock (cc stable)
2.2 Rework floating interrupts to follow the priorities
2.3 Allow to inject all local interrupts via new ioctl
2.4 allow to get/set the full local irq state, e.g. for migration
    and introspection

----------------------------------------------------------------
Christian Borntraeger (1):
      KVM: s390: enable more features that need no hypervisor changes

David Hildenbrand (2):
      KVM: s390: store the breaking-event address on pgm interrupts
      KVM: s390: cpu timer irq priority

Jens Freimann (5):
      KVM: s390: fix get_all_floating_irqs
      KVM: s390: deliver floating interrupts in order of priority
      KVM: s390: add ioctl to inject local interrupts
      KVM: s390: refactor vcpu injection function
      KVM: s390: migrate vcpu interrupt state

 Documentation/virtual/kvm/api.txt               |  117 +++
 Documentation/virtual/kvm/devices/s390_flic.txt |    3 +
 arch/s390/include/asm/kvm_host.h                |   30 +-
 arch/s390/kvm/interrupt.c                       | 1075 ++++++++++++++---------
 arch/s390/kvm/kvm-s390.c                        |   54 +-
 arch/s390/kvm/kvm-s390.h                        |    6 +-
 arch/s390/kvm/priv.c                            |    9 +-
 include/uapi/linux/kvm.h                        |   14 +
 virt/kvm/kvm_main.c                             |    2 +-
 9 files changed, 908 insertions(+), 402 deletions(-)
