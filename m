From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 31 Jul 2018 08:43:46 +0000
Subject: [GIT PULL 00/19] KVM: s390: Features for 4.19
Message-Id: <20180731084405.28953-1-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

here are the s390 updates for KVM for 4.19. Most important change is
the initial support for host large pages. As this touches KVM and
s390/mm in an intermingled way we have created a topic branch that
is merged here and in Martins tree. In this way all merge conflicts
are nicely handled and avoided.


The following changes since commit 6f0d349d922ba44e4348a17a78ea51b7135965b1:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-06-25 15:58:17 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-4.19-1

for you to fetch changes up to 2375846193663a1282c0ef7093640ed3210dc09f:

  Merge tag 'hlp_stage1' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into kvms390/next (2018-07-30 23:20:48 +0200)

----------------------------------------------------------------
KVM: s390: Features for 4.19

- initial version for host large page support. Must be enabled with
  module parameter hpage=1 and will conflict with the nested=1
  parameter.
- enable etoken facility for guests
- Fixes

----------------------------------------------------------------
Christian Borntraeger (2):
      KVM: s390/vsie: avoid sparse warning
      KVM: s390: add etoken support for guests

Claudio Imbrenda (2):
      KVM: s390: a utility function for migration
      KVM: s390: Fix storage attributes migration with memory slots

Dominik Dingel (2):
      s390/mm: Clear huge page storage keys on enable_skey
      s390/mm: hugetlb pages within a gmap can not be freed

Janosch Frank (14):
      KVM: s390: Replace clear_user with kvm_clear_guest
      s390/mm: Make gmap_protect_range more modular
      s390/mm: Abstract gmap notify bit setting
      s390/mm: Add gmap pmd linking
      s390/mm: Add gmap pmd notification bit setting
      s390/mm: Add gmap pmd invalidation and clearing
      s390/mm: Add huge page dirty sync support
      s390/mm: Clear skeys for newly mapped huge guest pmds
      s390/mm: Add huge pmd storage key handling
      KVM: s390: Add skey emulation fault handling
      KVM: s390: Beautify skey enable check
      s390/mm: Add huge page gmap linking support
      KVM: s390: Add huge page enablement control
      Merge tag 'hlp_stage1' of git://git.kernel.org/.../kvms390/linux into kvms390/next

 Documentation/virtual/kvm/api.txt   |  16 ++
 arch/s390/include/asm/gmap.h        |  10 +
 arch/s390/include/asm/hugetlb.h     |   5 +-
 arch/s390/include/asm/kvm_host.h    |  11 +-
 arch/s390/include/asm/mmu.h         |   2 +
 arch/s390/include/asm/mmu_context.h |   1 +
 arch/s390/include/asm/pgtable.h     |  13 +-
 arch/s390/include/uapi/asm/kvm.h    |   5 +-
 arch/s390/kvm/kvm-s390.c            | 387 +++++++++++++++++++-----------
 arch/s390/kvm/priv.c                | 143 ++++++++----
 arch/s390/kvm/vsie.c                |  11 +-
 arch/s390/mm/gmap.c                 | 454 ++++++++++++++++++++++++++++++++++--
 arch/s390/mm/hugetlbpage.c          |  24 ++
 arch/s390/mm/pageattr.c             |   6 +-
 arch/s390/mm/pgtable.c              | 159 +++++++++----
 arch/s390/tools/gen_facilities.c    |   3 +-
 include/linux/kvm_host.h            |   7 +
 include/uapi/linux/kvm.h            |   1 +
 virt/kvm/kvm_main.c                 |   2 +-
 19 files changed, 989 insertions(+), 271 deletions(-)
