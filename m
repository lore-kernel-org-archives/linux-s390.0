From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL 0/8] KVM: s390,virtio-ccw: Features, cleanups and fixes
Date: Tue,  4 Mar 2014 12:27:10 +0100
Message-ID: <1393932438-58848-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heinz Graalfs <graalfs@linux.vnet.ibm.com>, Thomas Huth <thuth@linux.vnet.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

The following changes since commit d3714010c307d26df251c45be9cd12ab6d41f0c4:

  KVM: x86: emulator_cmpxchg_emulated should mark_page_dirty (2014-02-26 10:11:08 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-20140304

for you to fetch changes up to 96b14536d935848cffd904f583f67c66169002d8:

  virtio-ccw: virtio-ccw adapter interrupt support. (2014-03-04 10:41:04 +0100)

The pull target is kvm/queue.

----------------------------------------------------------------
this is the next round of patches for KVM: s390:
- It contains the guest kernel part for adapter interrupt support
  for virtio-ccw, no irqfd yet
- cleanups, getting rid of some interrupt data structure
- ONEREG access to GBEA and PP
- Fixes for virtio-ccw, sigp

----------------------------------------------------------------
Christian Borntraeger (2):
      KVM: s390: Provide access to program parameter
      KVM: s390: expose gbea register to userspace

Cornelia Huck (1):
      virtio-ccw: virtio-ccw adapter interrupt support.

Heinz Graalfs (1):
      virtio_ccw: fix vcdev pointer handling issues

Jens Freimann (2):
      KVM: s390: Simplify online vcpus counting for stsi
      KVM: s390: get rid of local_int array

Martin Schwidefsky (1):
      s390/airq: add support for irq ranges

Michael Mueller (3):
      KVM: s390: implementation of kvm_arch_vcpu_runnable()
      KVM: add kvm_arch_vcpu_runnable() test to kvm_vcpu_on_spin() loop
      KVM/s390: Set preempted flag during vcpu wakeup and interrupt delivery

Takuya Yoshikawa (1):
      KVM: x86: Break kvm_for_each_vcpu loop after finding the VP_INDEX

Thomas Huth (1):
      KVM: s390: Fixed CC of SIGP SET_PREFIX handler

 arch/s390/include/asm/airq.h     |  14 +-
 arch/s390/include/asm/irq.h      |   1 +
 arch/s390/include/asm/kvm_host.h |   5 +-
 arch/s390/include/uapi/asm/kvm.h |   2 +
 arch/s390/kernel/irq.c           |   1 +
 arch/s390/kvm/interrupt.c        |   9 +-
 arch/s390/kvm/kvm-s390.c         |  26 +++-
 arch/s390/kvm/priv.c             |   7 +-
 arch/s390/kvm/sigp.c             | 148 ++++++++----------
 arch/x86/kvm/x86.c               |   7 +-
 drivers/s390/cio/airq.c          |  66 +++++----
 drivers/s390/kvm/virtio_ccw.c    | 313 ++++++++++++++++++++++++++++++++++++---
 virt/kvm/kvm_main.c              |   2 +-
 13 files changed, 448 insertions(+), 153 deletions(-)
