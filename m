From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/6] KVM: s390: Fixes and single VCPU speedup
Date: Tue, 29 Apr 2014 15:36:42 +0200
Message-ID: <1398778608-3887-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Gleb,

please consider belows pull request for 3.16. 
Thanks

Christian


The following changes since commit 198c74f43f0f5473f99967aead30ddc622804bc1:

  KVM: MMU: flush tlb out of mmu lock when write-protect the sptes (2014-04-23 17:49:52 -0300)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-20140429

for you to fetch changes up to 8ad357551797b1edc184fb9f6a4f80a6fa626459:

  KVM: s390: enable IBS for single running VCPUs (2014-04-29 15:01:54 +0200)

----------------------------------------------------------------
1. Guest handling fixes
The handling of MVPG, PFMF and Test Block is fixed to better follow
the architecture. None of these fixes is critical for any current
Linux guests, but let's play safe.

2. Optimization for single CPU guests
We can enable the IBS facility if only one VCPU is running (!STOPPED
state). We also enable this optimization for guest > 1 VCPU as soon
as all but one VCPU is in stopped state. Thus will help guests that
have tools like cpuplugd (from s390-utils) that do dynamic offline/
online of CPUs.

3. NOTES
There is one non-s390 change in include/linux/kvm_host.h that
introduces 2 defines for VCPU requests:
define KVM_REQ_ENABLE_IBS        23
define KVM_REQ_DISABLE_IBS       24

----------------------------------------------------------------
David Hildenbrand (2):
      KVM: s390: introduce kvm_s390_vcpu_{start,stop}
      KVM: s390: enable IBS for single running VCPUs

Thomas Huth (4):
      KVM: s390: Handle MVPG partial execution interception
      KVM: s390: Add a function for checking the low-address protection
      KVM: s390: Fixes for PFMF
      KVM: s390: Add low-address protection to TEST BLOCK

 arch/s390/include/asm/kvm_host.h |   2 +
 arch/s390/kvm/diag.c             |   2 +-
 arch/s390/kvm/gaccess.c          |  28 ++++++++
 arch/s390/kvm/gaccess.h          |   1 +
 arch/s390/kvm/intercept.c        |  58 +++++++++++++++-
 arch/s390/kvm/interrupt.c        |   2 +-
 arch/s390/kvm/kvm-s390.c         | 139 +++++++++++++++++++++++++++++++++++++--
 arch/s390/kvm/kvm-s390.h         |   2 +
 arch/s390/kvm/priv.c             |  21 ++++--
 arch/s390/kvm/trace-s390.h       |  43 ++++++++++++
 include/linux/kvm_host.h         |   2 +
 11 files changed, 287 insertions(+), 13 deletions(-)
