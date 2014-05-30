From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/6] KVM: s390: Fixes and cleanups for 3.16
Date: Fri, 30 May 2014 11:00:06 +0200
Message-ID: <1401440412-20472-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

The following changes since commit 1f854112553a1d65363ab27d4ee3dfb4b27075fb:

  KVM: vmx: DR7 masking on task switch emulation is wrong (2014-05-22 17:47:18 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-20140530

for you to fetch changes up to 5a5e65361f01b44caa51ba202e6720d458829fc5:

  KVM: s390: Intercept the tprot instruction (2014-05-30 09:39:40 +0200)

----------------------------------------------------------------
1. Several minor fixes and cleanups for KVM:
2. Fix flag check for gdb support
3. Remove unnecessary vcpu start
4. Remove code duplication for sigp interrupts
5. Better DAT handling for the TPROT instruction
6. Correct addressing exception for standby memory

----------------------------------------------------------------
David Hildenbrand (2):
      KVM: s390: check the given debug flags, not the set ones
      KVM: s390: a VCPU is already started when delivering interrupts

Jens Freimann (1):
      KVM: s390: clean up interrupt injection in sigp code

Matthew Rosato (1):
      KVM: s390: Intercept the tprot instruction

Thomas Huth (2):
      KVM: s390: Add a generic function for translating guest addresses
      KVM: s390: Enable DAT support for TPROT handler

 arch/s390/include/asm/kvm_host.h |  1 +
 arch/s390/kvm/gaccess.c          | 57 ++++++++++++++++++++++++++++++++++++++--
 arch/s390/kvm/gaccess.h          |  5 ++++
 arch/s390/kvm/interrupt.c        |  1 -
 arch/s390/kvm/kvm-s390.c         |  6 +++--
 arch/s390/kvm/priv.c             | 56 +++++++++++++++++++++++----------------
 arch/s390/kvm/sigp.c             | 56 +++++++++++++--------------------------
 7 files changed, 116 insertions(+), 66 deletions(-)
