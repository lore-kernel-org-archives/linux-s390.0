From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 00/12] KVM: s390: features and fixes for 3.16
Date: Fri, 16 May 2014 16:09:36 +0200
Message-ID: <1400249388-3969-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

the following changes since commit d9f89b88f5102ce235b75a5907838e3c7ed84b97:

  KVM: x86: Fix CR3 reserved bits check in long mode (2014-05-12 20:04:01 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-20140516

for you to fetch changes up to fda902cb8347da121025c4079b9e87748228a27e:

  KVM: s390: split SIE state guest prefix field (2014-05-16 14:57:31 +0200)

----------------------------------------------------------------
1. Correct locking for lazy storage key handling
   A test loop with multiple CPUs triggered a race in the lazy storage
   key handling as introduced by commit 934bc131efc3e4be6a52f7dd6c4dbf
   (KVM: s390: Allow skeys to be enabled for the current process). This
   race should not happen with Linux guests, but let's fix it anyway.
   Patch touches !/kvm/ code, but is from the s390 maintainer.

2. Better handling of broken guests
   If we detect a program check loop we stop the guest instead of
   wasting CPU cycles.

3. Better handling on MVPG emulation
   The move page handling is improved to be architecturally correct.

3. Trace point rework
   Let's rework the kvm trace points to have a common header file (for
   later perf usage) and provided a table based instruction decoder.

4. Interpretive execution of SIGP external call
   Let the hardware handle most cases of SIGP external call (IPI) and
   wire up the fixup code for the corner cases.

5. Initial preparations for the IBC facility
   Prepare the code to handle instruction blocking

----------------------------------------------------------------
Alexander Yarygin (4):
      KVM: s390: add sie exit reasons tables
      KVM: s390: Use trace tables from sie.h.
      KVM: s390: decoder of SIE intercepted instructions
      KVM: s390: Use intercept_insn decoder in trace event

David Hildenbrand (1):
      KVM: s390: interpretive execution of SIGP EXTERNAL CALL

Martin Schwidefsky (1):
      KVM: s390: correct locking for s390_enable_skey

Michael Mueller (2):
      s390/sclp: add sclp_get_ibc function
      KVM: s390: split SIE state guest prefix field

Thomas Huth (4):
      KVM: s390: Improve is_valid_psw()
      KVM: s390: Avoid endless loops of specification exceptions
      KVM: s390: Introduce helper function for faulting-in a guest page
      KVM: s390: Improved MVPG partial execution handler

 arch/s390/include/asm/kvm_host.h |   8 +-
 arch/s390/include/asm/sclp.h     |   1 +
 arch/s390/include/uapi/asm/sie.h | 245 +++++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/diag.c             |   2 +-
 arch/s390/kvm/gaccess.h          |   8 +-
 arch/s390/kvm/intercept.c        |  39 ++++---
 arch/s390/kvm/interrupt.c        |  30 ++++-
 arch/s390/kvm/kvm-s390.c         |  44 +++++--
 arch/s390/kvm/kvm-s390.h         |  12 +-
 arch/s390/kvm/priv.c             |   8 +-
 arch/s390/kvm/sigp.c             |  35 ++++++
 arch/s390/kvm/trace.h            |  60 ++++------
 arch/s390/mm/pgtable.c           |  22 ++--
 drivers/s390/char/sclp_early.c   |  12 +-
 14 files changed, 431 insertions(+), 95 deletions(-)
 create mode 100644 arch/s390/include/uapi/asm/sie.h
