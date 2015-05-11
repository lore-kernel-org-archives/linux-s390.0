From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PREVIEW: GIT PULL 0/9] KVM: s390: Fixes and features for 4.2 (kvm/next)
Date: Mon, 11 May 2015 10:44:28 +0200
Message-ID: <1431333877-28700-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

the following changes since commit 5ebe6afaf0057ac3eaeb98defd5456894b446d22:

  Linux 4.1-rc2 (2015-05-03 19:22:23 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-20150508

for you to fetch changes up to 06b36753a6466239fc945b6756e12d635621ae5f:

  KVM: s390: drop handling of interception code 12 (2015-05-08 15:51:17 +0200)

----------------------------------------------------------------
KVM: s390: Fixes and features for 4.2 (kvm/next)

Mostly a bunch of fixes, reworks and optimizations for s390.
There is one new feature (EDAT-2 inside the guest), which boils
down to 2GB pages.

----------------------------------------------------------------
Christian Borntraeger (3):
      KVM: s390: optimize round trip time in request handling
      KVM: s390: make exit_sie_sync more robust
      KVM: s390: provide functions for blocking all CPUs

David Hildenbrand (3):
      KVM: s390: fix external call injection without sigp interpretation
      KVM: s390: factor out and optimize floating irq VCPU kick
      KVM: s390: drop handling of interception code 12

Guenther Hutzl (2):
      KVM: s390: make EDAT1 depend on host support
      KVM: s390: Enable guest EDAT2 support

Jens Freimann (1):
      KVM: s390: optimize interrupt handling round trip time

 arch/s390/include/asm/kvm_host.h |  4 +-
 arch/s390/kernel/entry.S         |  2 +-
 arch/s390/kvm/intercept.c        | 16 --------
 arch/s390/kvm/interrupt.c        | 87 +++++++++++++++++++++++-----------------
 arch/s390/kvm/kvm-s390.c         | 51 ++++++++++++++---------
 arch/s390/kvm/kvm-s390.h         | 25 ++++++++++--
 arch/s390/kvm/priv.c             |  8 +++-
 7 files changed, 116 insertions(+), 77 deletions(-)
