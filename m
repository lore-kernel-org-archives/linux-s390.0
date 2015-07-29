From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 00/16] KVM: s390: Fixes and features for kvm/next (4.3)
Date: Wed, 29 Jul 2015 11:05:50 +0200
Message-ID: <1438160766-108179-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

this time only some small changes for s390, mostly serviceability
changes and small fixes/optimizations.

Christian

The following changes since commit 5492830370171b6a4ede8a3bfba687a8d0f25fa5:

  KVM: svm: handle KVM_X86_QUIRK_CD_NW_CLEARED in svm_get_mt_mask (2015-07-23 08:30:27 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-20150728

for you to fetch changes up to c92ea7b9f7d256cabf7ee08a7627a5227e356dec:

  KVM: s390: log capability enablement and vm attribute changes (2015-07-29 11:02:36 +0200)

----------------------------------------------------------------
KVM: s390: Fixes and features for kvm/next (4.3)

1. Rework logging infrastructure (s390dbf) to integrate feedback learned
   when debugging performance and test issues
2. Some cleanups and simplifications for CMMA handling
3. Fix gdb debugging and single stepping on some instructions
4. Error handling for storage key setup

----------------------------------------------------------------
Christian Borntraeger (10):
      KVM: s390: add kvm stat counter for all diagnoses
      KVM: s390: Improve vcpu event debugging for diagnoses
      KVM: s390: VCPU_EVENT cleanup for prefix changes
      KVM: s390: add more debug data for the pfault diagnoses
      KVM: s390: Fixup interrupt vcpu event messages and levels
      KVM: s390: remove outdated documentation
      KVM: s390: improve debug feature usage
      KVM: s390: adapt debug entries for instruction handling
      KVM: s390: Provide global debug log
      KVM: s390: log capability enablement and vm attribute changes

David Hildenbrand (3):
      KVM: s390: filter space-switch events when PER is enforced
      KVM: s390: remove "from (user|kernel)" from irq injection messages
      KVM: s390: more irq names for trace events

Dominik Dingel (3):
      KVM: s390: propagate error from enable storage key
      KVM: s390: clean up cmma_enable check
      KVM: s390: only reset CMMA state if it was enabled before

 Documentation/s390/00-INDEX      |   2 -
 Documentation/s390/kvm.txt       | 125 ---------------------------------------
 arch/s390/include/asm/kvm_host.h |   4 +-
 arch/s390/kvm/diag.c             |  13 +++-
 arch/s390/kvm/guestdbg.c         |  35 +++++++++++
 arch/s390/kvm/interrupt.c        |  88 +++++++++++++--------------
 arch/s390/kvm/kvm-s390.c         |  73 +++++++++++++++++------
 arch/s390/kvm/kvm-s390.h         |  11 +++-
 arch/s390/kvm/priv.c             |  26 ++++----
 arch/s390/kvm/sigp.c             |  13 ++--
 arch/s390/kvm/trace-s390.h       |  33 ++++++-----
 include/uapi/linux/kvm.h         |   1 +
 12 files changed, 194 insertions(+), 230 deletions(-)
 delete mode 100644 Documentation/s390/kvm.txt
