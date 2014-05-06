From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/3] KVM: s390: Fixes
Date: Tue,  6 May 2014 15:58:26 +0200
Message-ID: <1399384709-21339-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Gleb,

the s390 queue has 3 fixes scheduled for 3.16.

The EFAULT fix fixes a bug that is only in kvm/next, and the
other fixes are long standing non-critical problems so no
cc stable.

Please apply.

The following changes since commit 57b5981cd38cbca3554c5e663b2361d9adea70c2:

  Merge tag 'kvm-s390-20140429' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into kvm-next (2014-04-30 12:29:41 +0200)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-20140506

for you to fetch changes up to f14d82e06a008b8977b64866a4907d2e152af939:

  KVM: s390: Fix external interrupt interception (2014-05-06 14:58:10 +0200)

----------------------------------------------------------------
1. Fixes an error return code for the breakpoint setup

2. External interrupt fixes
2.1. Some interrupt conditions like cpu timer or clock comparator
stay pending even after the interrupt is injected. If the external
new PSW is enabled for interrupts this will result in an endless
loop. Usually this indicates a programming error in the guest OS.
Lets detect such situations and go to userspace. We will provide
a QEMU patch that sets the guest in panicked/crashed state to avoid
wasting CPU cycles.
2.2 Resend external interrupts back to the guest if the HW could
not do it.
-

----------------------------------------------------------------
Dan Carpenter (1):
      KVM: s390: return -EFAULT if copy_from_user() fails

Thomas Huth (2):
      KVM: s390: Add clock comparator and CPU timer IRQ injection
      KVM: s390: Fix external interrupt interception

 Documentation/virtual/kvm/api.txt |  2 ++
 arch/s390/include/asm/kvm_host.h  |  5 +++-
 arch/s390/kvm/guestdbg.c          |  5 ++--
 arch/s390/kvm/intercept.c         | 49 +++++++++++++++++++++++++++++++++++----
 arch/s390/kvm/interrupt.c         | 32 +++++++++++++++++++++++++
 include/uapi/linux/kvm.h          |  2 ++
 6 files changed, 88 insertions(+), 7 deletions(-)
