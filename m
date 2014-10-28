From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/9] KVM: s390: Fixes and cleanups for kvm/next (3.19)
Date: Tue, 28 Oct 2014 20:39:50 +0100
Message-ID: <1414525199-53989-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

the first bunch on s390 change for next:

The following changes since commit cac7f2429872d3733dc3f9915857b1691da2eb2f:

  Linux 3.18-rc2 (2014-10-26 16:48:41 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-20141028

for you to fetch changes up to a6cc3108567e0adc06c4a8031186f84ad1e1e194:

  KVM: s390: sigp: split handling of SIGP STOP (AND STORE STATUS) (2014-10-28 13:09:14 +0100)

----------------------------------------------------------------
KVM: s390: Fixes and cleanups

1. A small fix regarding program check handling (cc stable as it
   overwrites the wrong guest memory)
2. Improve the ipte interlock scalability for older hardware
3. current->mm to mm cleanup (currently a no-op)
4. several SIGP rework patches (more to come)

----------------------------------------------------------------
David Hildenbrand (6):
      KVM: s390: sigp: dispatch orders with one target in a separate function
      KVM: s390: sigp: move target cpu checks into dispatcher
      KVM: s390: sigp: separate preparation handlers
      KVM: s390: sigp: instruction counters for all sigp orders
      KVM: s390: sigp: inject emergency calls in a separate function
      KVM: s390: sigp: split handling of SIGP STOP (AND STORE STATUS)

Jason J. Herne (1):
      KVM: s390: Cleanup usage of current->mm in set_guest_storage_key

Thomas Huth (2):
      KVM: s390: Make the simple ipte mutex specific to a VM instead of global
      KVM: s390: Fix size of monitor-class number field

 arch/s390/include/asm/kvm_host.h |   9 ++
 arch/s390/include/asm/sigp.h     |   1 +
 arch/s390/kvm/gaccess.c          |  20 ++-
 arch/s390/kvm/interrupt.c        |   2 +-
 arch/s390/kvm/kvm-s390.c         |   8 ++
 arch/s390/kvm/sigp.c             | 269 ++++++++++++++++++++-------------------
 arch/s390/mm/pgtable.c           |   2 +-
 7 files changed, 168 insertions(+), 143 deletions(-)
