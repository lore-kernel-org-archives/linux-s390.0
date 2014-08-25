From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/2] KVM: s390: Fixes for 3.17
Date: Mon, 25 Aug 2014 15:10:09 +0200
Message-ID: <1408972211-27122-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

the following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-20140825

for you to fetch changes up to ab3f285f227fec62868037e9b1b1fd18294a83b8:

  KVM: s390/mm: try a cow on read only pages for key ops (2014-08-25 14:35:28 +0200)

----------------------------------------------------------------
Here are two fixes for s390 KVM code that prevent:
1. a malicious user to trigger a kernel BUG
2. a malicious user to change the storage key of read-only pages

----------------------------------------------------------------
Christian Borntraeger (2):
      KVM: s390: Fix user triggerable bug in dead code
      KVM: s390/mm: try a cow on read only pages for key ops

 arch/s390/kvm/kvm-s390.c | 13 -------------
 arch/s390/mm/pgtable.c   | 10 ++++++++++
 2 files changed, 10 insertions(+), 13 deletions(-)
