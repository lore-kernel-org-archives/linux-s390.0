From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 00/11] KVM: s390: Fixes and features for 4.14
Date: Mon, 28 Aug 2017 10:07:27 +0200
Message-ID: <1503907651-65296-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

This is what I have pending for 4.14 in 
  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  kvm-s390-next-4.14-1

It contains 2 merges (on topic branch from Martin for the tlb flushing
and a back-merge from the s390 fixes for master to avoid merge conflicts
with followup fixes). 

"New" patches are marked (x) below. (patches 5,6,10,11).
Pull request will come later this week.

----------------------------------------------------------------
KVM: s390: Fixes and features for 4.14

- merge of topic branch tlb-flushing from the s390 tree to get the
  no-dat base features
- wire up the no-dat enhancements in KVM
- multiple epoch facility (z14 feature)
- Configuration z/Architecture Mode fixup
- merge of kvm/master to avoid conflicts with additional sthyi fixes
- more sthyi fixes

----------------------------------------------------------------
Christian Borntraeger (3):
      Merge branch 'tlb-flushing' of git://git.kernel.org/.../s390/linux  into kernelorgnext
      KVM: s390: take srcu lock when getting/setting storage keys
      Merge tag 'kvm-s390-master-4.13-2' into kvms390/next

Claudio Imbrenda (1):
(x)   KVM: s390: expose no-DAT to guest and migration support

Collin L. Walling (1):
(x)   KVM: s390: Multiple Epoch Facility support

Heiko Carstens (3):
      KVM: s390: sthyi: fix sthyi inline assembly
      KVM: s390: sthyi: fix specification exception detection
(x)   KVM: s390: sthyi: remove invalid guest write access

Jason J. Herne (1):
(x)   KVM: s390: Support Configuration z/Architecture Mode

Martin Schwidefsky (4):
      s390/mm: tag normal pages vs pages used in page tables
      s390/mm: add no-dat TLB flush optimization
      s390/mm: add guest ASCE TLB flush optimization
      s390/mm,kvm: use nodat PGSTE tag to optimize TLB flushing

 Documentation/virtual/kvm/devices/vm.txt |  14 ++-
 arch/s390/include/asm/kvm_host.h         |   6 +-
 arch/s390/include/asm/page-states.h      |   3 +-
 arch/s390/include/asm/page.h             |   3 +
 arch/s390/include/asm/pgtable.h          |  88 ++++++++++----
 arch/s390/include/asm/setup.h            |   9 +-
 arch/s390/include/asm/tlbflush.h         |   7 +-
 arch/s390/include/uapi/asm/kvm.h         |   6 +
 arch/s390/kernel/suspend.c               |  22 +++-
 arch/s390/kernel/vdso.c                  |   2 +
 arch/s390/kvm/kvm-s390.c                 | 117 +++++++++++++++++-
 arch/s390/kvm/kvm-s390.h                 |   2 +
 arch/s390/kvm/priv.c                     |   6 +-
 arch/s390/kvm/sigp.c                     |  36 +++---
 arch/s390/kvm/sthyi.c                    |  13 +-
 arch/s390/kvm/vsie.c                     |  10 ++
 arch/s390/mm/init.c                      |   2 +
 arch/s390/mm/page-states.c               | 196 ++++++++++++++++++++++++++++---
 arch/s390/mm/pageattr.c                  |   2 +-
 arch/s390/mm/pgalloc.c                   |   2 +
 arch/s390/mm/pgtable.c                   | 160 +++++++++++++++++++------
 arch/s390/tools/gen_facilities.c         |   2 +
 drivers/s390/char/sclp_early.c           |   6 +-
 23 files changed, 595 insertions(+), 119 deletions(-)
