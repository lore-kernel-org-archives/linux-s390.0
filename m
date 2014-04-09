From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULLv2] KVM: s390: memory management and migration
Date: Wed,  9 Apr 2014 21:56:03 +0200
Message-ID: <1397073363-5747-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Marcelo, Gleb, (Paolo,)

here is the 2nd spin of the s390 patches.

The following changes since commit 7cbb39d4d4d530dff12f2ff06ed6c85c504ba91a:

  Merge tag 'kvm-3.15-1' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2014-04-02 14:50:10 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-20140409

for you to fetch changes up to e31a06aaa22f66ba868148ae4f8e270d2ebb9c2b:

  KVM: s390: Add proper dirty bitmap support to S390 kvm. (2014-04-09 21:22:06 +0200)

----------------------------------------------------------------
here are two changes for KVM on s390:
- newer Linux version don't use the storage keys for dirty and
  reference tracking. We can optimize the guest handling for
  those guests for faults as well as page-in and page-out by
  simply not caring about the guest visible storage key. We trap
  guest storage key instruction to enable  those keys only on demand.
- Migration bitmap: Until now s390 never provided a proper dirty
  bitmap.  Let's provide a proper migration bitmap for s390. We also
  change the user dirty tracking to a fault based mechanism. This
  makes the host completely independent from the storage keys. Long
  term this will allow us to back guest memory with large pages.

Please note:
The first patch commit 96959051904c2e07a102ee13887166e93d349f05
(KVM: s390: also set guest pages back to stable on kexec/kdump)
is only included to avoid a compile error in the calls to
page_table_reset_pgste. This commit already made its way into Linus
git as commit id 1b6a19b34d54d3d56b9042 and we need to adopt
the new call as well.
The merge conflict between Linus tree and kvm tree is easy to solve.
(kvm tree has the final result)

All patches that touch s390 memory management are either ACKed or
written by the s390 maintainers.

----------------------------------------------------------------
Christian Borntraeger (1):
      kvm/s390: also set guest pages back to stable on kexec/kdump

Dominik Dingel (5):
      KVM: s390: Adding skey bit to mmu context
      KVM: s390: Clear storage keys
      KVM: s390: Allow skeys to be enabled for the current process
      KVM: s390: Don't enable skeys by default
      s390/mm, kvm: new gmap_test_and_clear_dirty function

Jason J. Herne (1):
      KVM: s390: Add proper dirty bitmap support to S390 kvm.

Martin Schwidefsky (1):
      s390/mm,kvm: use software dirty bit detection for user dirty tracking

 arch/s390/include/asm/kvm_host.h    |   3 +
 arch/s390/include/asm/mmu.h         |   2 +
 arch/s390/include/asm/mmu_context.h |   1 +
 arch/s390/include/asm/pgalloc.h     |   3 +-
 arch/s390/include/asm/pgtable.h     | 169 +++++++++++++++++-------------------
 arch/s390/kvm/diag.c                |   8 +-
 arch/s390/kvm/kvm-s390.c            |  52 ++++++++++-
 arch/s390/kvm/priv.c                |  14 +++
 arch/s390/kvm/trace.h               |  14 +++
 arch/s390/mm/pgtable.c              |  93 +++++++++++++++++---
 virt/kvm/kvm_main.c                 |   2 -
 11 files changed, 253 insertions(+), 108 deletions(-)
