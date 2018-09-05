From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 05 Sep 2018 08:29:46 +0000
Subject: [GIT PULL 0/3] KVM: s390: Fixes for 4.19
Message-Id: <20180905082949.100517-1-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

2 fixes for the newly introduced hugetlbfs support (new for 4.19) and
one long standing bug in the nested kvm support for keywrapping.
Please pull for 4.19 (kvm/master)

The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-4.19-1

for you to fetch changes up to df88f3181f10565c6e3a89eb6f0f9e6afaaf15f1:

  KVM: s390: Properly lock mm context allow_gmap_hpage_1m setting (2018-09-04 11:40:26 +0200)

----------------------------------------------------------------
KVM: s390: Fixes for 4.19

- Fallout from the hugetlbfs support: pfmf interpretion and locking
- VSIE: fix keywrapping for nested guests

----------------------------------------------------------------
Janosch Frank (2):
      KVM: s390: Fix pfmf and conditional skey emulation
      KVM: s390: Properly lock mm context allow_gmap_hpage_1m setting

Pierre Morel (1):
      KVM: s390: vsie: copy wrapping keys to right place

 arch/s390/include/asm/mmu.h |  8 +++++++-
 arch/s390/kvm/kvm-s390.c    |  2 ++
 arch/s390/kvm/priv.c        | 30 ++++++++++++++++++------------
 arch/s390/kvm/vsie.c        |  3 ++-
 4 files changed, 29 insertions(+), 14 deletions(-)
