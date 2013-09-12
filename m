From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/8] KVM: s390: fixes and cleanup
Date: Thu, 12 Sep 2013 10:33:41 +0200
Message-ID: <1378974829-46578-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Gleb,

here is a bunch of patch for kvm on s390.
The first 4 patches restructure the code to protect most of 
vcpu_run with the kvm->srcu lock. The old code was structured
in way that adding the lock was more complicated than necessary,
therefore, the rework.

The last 4 patches deal with instruction intercept handling.

Patches are against kvm.git queue. Please apply.


Thomas Huth (8):
  KVM: s390: Remove dead "rerun vcpu" code
  KVM: s390: Split up __vcpu_run into three parts
  KVM: s390: Push run loop into __vcpu_run
  KVM: s390: Lock kvm->srcu at the appropriate places
  KVM: s390: Allow NULL parameter for kvm_s390_get_regs_rre
  KVM: s390: Helper for converting real addresses to absolute
  KVM: s390: Implement TEST BLOCK
  KVM: s390: Intercept SCK instruction

 arch/s390/include/asm/kvm_host.h |  1 -
 arch/s390/kvm/diag.c             |  4 +-
 arch/s390/kvm/gaccess.h          | 21 ++++++----
 arch/s390/kvm/intercept.c        |  6 ---
 arch/s390/kvm/interrupt.c        |  3 ++
 arch/s390/kvm/kvm-s390.c         | 91 ++++++++++++++++++++++++++--------------
 arch/s390/kvm/kvm-s390.h         |  9 ++--
 arch/s390/kvm/priv.c             | 61 +++++++++++++++++++++++++++
 8 files changed, 144 insertions(+), 52 deletions(-)

-- 
1.8.3.1
