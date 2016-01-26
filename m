From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/3] Fixes for kvm/master (targeting 4.5)
Date: Tue, 26 Jan 2016 16:17:03 +0100
Message-ID: <1453821426-94778-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

here are some fixes for kvm/master (targeting 4.5)

The following changes since commit 7d1fc01afc5af35e5197e0e75abe900f6bd279b8:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jikos/trivial (2016-01-14 17:04:19 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-4.5-1

for you to fetch changes up to 9abc2a08a7d665b02bdde974fd6c44aae86e923e:

  KVM: s390: fix memory overwrites when vx is disabled (2016-01-26 15:40:21 +0100)

----------------------------------------------------------------
KVM: s390: Fixes for kvm/master (targeting 4.5)

1. Fallout of some bigger floating point/vector rework in s390
- memory leak -> stable 4.3+
- memory overwrite -> stable 4.4+

2. enable KVM-VFIO for s390

----------------------------------------------------------------
David Hildenbrand (2):
      KVM: s390: fix guest fprs memory leak
      KVM: s390: fix memory overwrites when vx is disabled

Dong Jia Shi (1):
      KVM: s390: Enable the KVM-VFIO device

 arch/s390/include/asm/kvm_host.h |   1 -
 arch/s390/kvm/Kconfig            |   1 +
 arch/s390/kvm/Makefile           |   2 +-
 arch/s390/kvm/kvm-s390.c         | 121 ++++++++++++++-------------------------
 4 files changed, 44 insertions(+), 81 deletions(-)
