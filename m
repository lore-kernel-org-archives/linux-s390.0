From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCHv5 0/7] aync page fault support for s390 (plus flic)
Date: Tue,  8 Oct 2013 16:54:53 +0200
Message-ID: <1381244100-59056-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Gleb, Paolo,

here is a set of patches containing the floating interrupt controller
and the async page fault patches on top of them. (It took a bit
longer than expected)

Several changes since v4 of the async patches mostly to make life 
migration possible:
- Please have a look at patch 5. This one is new: We need to a
  way to let all workers finish to inject the completion interrupt.
  Otherwise guest processes will stall forever. (there is no wake all
  in the exisiting guest interface)
- pfault is moved into flic. Reason is simple: The completion interrupts
  are floating,  therefore we must serialize the flushing of pfault and
  creation of the completion interrupts (which are floating) with migrating
  all floating interrupts.
- prepare pfault context for migration
- bugfixes
Everything else should look similar to what you already know.

Changes since v3 of flic
- new device number
- no anonymous union
- fixed sparse warning
- get rid of KVM_S390_INT_MAX, which was a leftover from an earlier version
This is what Alex approved (with known todos/cleanups for future patches)



Let me know if you still have some concerns, otherwise, feel free to pull
git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/flic_pfault

Christian

Dominik Dingel (5):
  KVM: s390: Add FAULT_FLAG_RETRY_NOWAIT for guest fault
  KVM: async_pf: Provide additional direct page notification
  KVM: async_pf: Allow to wait for outstanding work
  KVM: async_pf:  Async page fault support on s390
  KVM: async_pf: Exploit one reg interface for pfault

Jens Freimann (2):
  KVM: s390: add and extend interrupt information data structs
  KVM: s390: add floating irq controller

 Documentation/virtual/kvm/devices/s390_flic.txt |  36 +++
 arch/s390/include/asm/kvm_host.h                |  57 ++--
 arch/s390/include/asm/pgtable.h                 |   2 +
 arch/s390/include/asm/processor.h               |   1 +
 arch/s390/include/uapi/asm/kvm.h                |  11 +
 arch/s390/kvm/Kconfig                           |   2 +
 arch/s390/kvm/Makefile                          |   2 +-
 arch/s390/kvm/diag.c                            |  84 ++++++
 arch/s390/kvm/interrupt.c                       | 364 ++++++++++++++++++++----
 arch/s390/kvm/kvm-s390.c                        | 134 ++++++++-
 arch/s390/kvm/kvm-s390.h                        |   4 +
 arch/s390/kvm/sigp.c                            |   7 +
 arch/s390/kvm/trace.h                           |  46 +++
 arch/s390/mm/fault.c                            |  26 +-
 arch/x86/kvm/mmu.c                              |   2 +-
 arch/x86/kvm/x86.c                              |   8 +-
 include/linux/kvm_host.h                        |   5 +-
 include/uapi/linux/kvm.h                        |  66 +++++
 virt/kvm/Kconfig                                |   4 +
 virt/kvm/async_pf.c                             |  28 +-
 virt/kvm/kvm_main.c                             |   5 +
 21 files changed, 782 insertions(+), 112 deletions(-)
 create mode 100644 Documentation/virtual/kvm/devices/s390_flic.txt

-- 
1.8.3.1
