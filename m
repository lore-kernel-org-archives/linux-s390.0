From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 31 May 2018 21:07:53 +0000
Subject: [GIT PULL 0/7] KVM: s390: Cleanups for 4.18
Message-Id: <20180531210800.137347-1-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

only a small set of patches for KVM on s390. Neither crypto (AP), nor
large page support is "ready enough" right now.
This also contains a merge of the "kvm-s390-master-4.17-1" tag to
prevent a merge conflict.

The following changes since commit 75bc37fefc4471e718ba8e651aa74673d4e0a9eb:

  Linux 4.17-rc4 (2018-05-06 16:57:38 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-4.18-1

for you to fetch changes up to 2c8180e885c1b2844a24dcaf4a675972b8ce8edc:

  KVM: s390: vsie: simplify < 8k address checks (2018-05-17 13:34:21 +0200)

----------------------------------------------------------------
KVM: s390: Cleanups for 4.18

- cleanups for nested, clock handling, crypto, storage keys and
control register bits

----------------------------------------------------------------
Christian Borntraeger (1):
      Merge tag 'kvm-s390-master-4.17-1'

David Hildenbrand (5):
      KVM: s390: introduce defines for control registers
      KVM: s390: no need to inititalize kvm->arch members to 0
      KVM: s390: generalize kvm_s390_get_tod_clock_ext()
      KVM: s390: vsie: fix < 8k check for the itdba
      KVM: s390: vsie: simplify < 8k address checks

Janosch Frank (1):
      KVM: s390: Add storage key facility interpretation control

Tony Krowiak (1):
      KVM: s390: reset crypto attributes for all vcpus

 arch/s390/include/asm/ctl_reg.h     | 12 ++++++++
 arch/s390/include/asm/kvm_host.h    |  1 +
 arch/s390/include/asm/mmu.h         |  2 +-
 arch/s390/include/asm/mmu_context.h |  2 +-
 arch/s390/include/asm/pgtable.h     |  4 +--
 arch/s390/kvm/guestdbg.c            |  2 +-
 arch/s390/kvm/interrupt.c           | 20 ++++++-------
 arch/s390/kvm/kvm-s390.c            | 59 +++++++++++++++++++------------------
 arch/s390/kvm/kvm-s390.h            | 13 ++++++++
 arch/s390/kvm/priv.c                | 28 ++++++++++--------
 arch/s390/kvm/vsie.c                | 10 +++----
 arch/s390/mm/gmap.c                 |  6 ++--
 arch/s390/mm/pgtable.c              |  4 +--
 13 files changed, 98 insertions(+), 65 deletions(-)
