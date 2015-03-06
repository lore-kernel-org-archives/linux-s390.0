From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 00/20] KVM: s390: Features and Fixes for 4.1 (kvm/next)
Date: Fri,  6 Mar 2015 14:16:32 +0100
Message-ID: <1425647812-61838-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Marcelo, Paolo,

here is the first bunch of fixes and features for 4.1 on s390.
This pull request does contain the same fixes as the last pull
for master to avoid a merge conflict in the next merge window.


The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-20150306

for you to fetch changes up to 13211ea7b47db3d8ee2ff258a9a973a6d3aa3d43:

  KVM: s390: Enable vector support for capable guest (2015-03-06 13:49:35 +0100)

----------------------------------------------------------------
KVM: s390: Features and Fixes for 4.1 (kvm/next)

1. Several Fixes and enhancements
---------------------------------
- These 3 patches have cc stable:
b75f4c9 KVM: s390: Zero out current VMDB of STSI before including level3 data.
261520d KVM: s390: fix handling of write errors in the tpi handler
15462e3 KVM: s390: reinjection of irqs can fail in the tpi handler

2. SIMD support the kernel part (introduced with z13)
-----------------------------------------------------
- two KVM-generic changes in kvm.h:
1. New capability that can be enabled: KVM_CAP_S390_VECTOR_REGISTERS
2. increased padding size for sync regs in struct kvm_run to clarify that
   sync regs can be larger than 1k. This is fine as this is the last
   element in the structure.

----------------------------------------------------------------
Alexander Yarygin (1):
      KVM: s390: Use the read_guest_abs() in guest debug functions

Christian Borntraeger (1):
      KVM: s390/cpacf: Fix kernel bug under z/VM

David Hildenbrand (3):
      KVM: s390: fix handling of write errors in the tpi handler
      KVM: s390: reinjection of irqs can fail in the tpi handler
      KVM: s390: fix instruction interception trace point

Ekaterina Tumanova (1):
      KVM: s390: Zero out current VMDB of STSI before including level3 data.

Eric Farman (5):
      KVM: s390: Allocate and save/restore vector registers
      KVM: s390: Vector exceptions
      KVM: s390: Add new SIGP order to kernel counters
      KVM: s390: Machine Check
      KVM: s390: Enable vector support for capable guest

Michael Mueller (4):
      KVM: s390: fix in memory copy of facility lists
      KVM: s390: include guest facilities in kvm facility test
      KVM: s390: non-LPAR case obsolete during facilities mask init
      KVM: s390: perform vcpu model setup in a function

Thomas Huth (3):
      KVM: s390: Nullify instruction for certain program exceptions
      KVM: s390: Forward PSW to next instruction for addressing exceptions
      KVM: s390: Use insn_length() to calculate length of instruction

Tony Krowiak (1):
      KVM: s390/cpacf: Enable key wrapping by default

Yannick Guerrini (1):
      KVM: s390: Fix trivial typo in comments

 Documentation/virtual/kvm/api.txt |  10 ++
 arch/s390/include/asm/kvm_host.h  |  28 ++++--
 arch/s390/include/uapi/asm/kvm.h  |   4 +
 arch/s390/include/uapi/asm/sie.h  |   4 +-
 arch/s390/kernel/asm-offsets.c    |   1 +
 arch/s390/kvm/gaccess.c           |   2 +-
 arch/s390/kvm/guestdbg.c          |   8 +-
 arch/s390/kvm/intercept.c         |   1 +
 arch/s390/kvm/interrupt.c         |  34 +++++--
 arch/s390/kvm/kvm-s390.c          | 192 +++++++++++++++++++++++++++-----------
 arch/s390/kvm/kvm-s390.h          |  10 +-
 arch/s390/kvm/priv.c              |  44 +++++----
 arch/s390/kvm/sigp.c              |   3 +
 include/uapi/linux/kvm.h          |   3 +-
 14 files changed, 246 insertions(+), 98 deletions(-)
