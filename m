From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PULL 0/6] KVM: s390: patches for kvm-next
Date: Wed, 11 Dec 2013 19:57:43 +0100
Message-ID: <1386788269-20249-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Gleb, Paolo,

here are some more fixes and improvements that have been sitting
in our tree. Please consider pulling.

The following changes since commit d6d63b51fe3bfea0cf596993afa480b0b3b02c32:

  Merge tag 'kvm-s390-20131128' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into kvm-next (2013-11-28 15:30:16 +0100)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-20131211

for you to fetch changes up to ff1f3cb4b3ac5d039f02679f34cb1498d110d241:

  KVM: s390: ioeventfd: ignore leftmost bits (2013-12-11 19:05:41 +0100)

----------------------------------------------------------------
Some further s390 patches for kvm-next.

Various improvements and bugfixes in the signal processor handling.
Document kvm support for diagnose (s390 hypercalls). And last but
not least, fix a bug in the s390 ioeventfd backend that was causing
us grief in scenarios with 4G+ memory.

----------------------------------------------------------------
Cornelia Huck (1):
  KVM: s390: diagnose call documentation

Dominik Dingel (1):
  KVM: s390: ioeventfd: ignore leftmost bits

Thomas Huth (4):
  KVM: s390: Use helper function to set CC in SIGP handler
  KVM: s390: Add the SIGP order CONDITIONAL EMERGENCY SIGNAL
  KVM: s390: Reworked SIGP RESTART order
  KVM: s390: SIGP START has to report BUSY while stopping a CPU

 Documentation/virtual/kvm/hypercalls.txt |    3 ++
 Documentation/virtual/kvm/s390-diag.txt  |   80 ++++++++++++++++++++++++++++++
 arch/s390/include/asm/sigp.h             |    2 +
 arch/s390/kvm/diag.c                     |    2 +-
 arch/s390/kvm/sigp.c                     |   64 ++++++++++++++++++++----
 5 files changed, 139 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/virtual/kvm/s390-diag.txt

-- 
1.7.9.5
