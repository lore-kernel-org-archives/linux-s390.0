From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/2] KVM: s390: fix and feature for kvm/next (4.3)
Date: Wed, 12 Aug 2015 20:49:27 +0200
Message-ID: <1439405369-60552-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

the following changes since commit c92ea7b9f7d256cabf7ee08a7627a5227e356dec:

  KVM: s390: log capability enablement and vm attribute changes (2015-07-29 11:02:36 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-20150812

for you to fetch changes up to 152b28392a8d9dd08e789b48b602eb75eef436fa:

  KVM: s390: Fix assumption that kvm_set_irq_routing is always run successfully (2015-08-07 12:15:23 +0200)

----------------------------------------------------------------
KVM: s390: fix and feature for kvm/next (4.3)

1. error handling for irq routes
2. Gracefully handle STP time changes
   s390 supports a protocol for syncing different systems via the stp
   protocol that will steer the TOD clocks to keep all participating
   clocks below the round trip time between the system. In case of
   specific out of sync event Linux can opt-in to accept sync checks.
   This will result in non-monotonic jumps of the TOD clock, which
   Linux will correct via time offsets to keep the wall clock time
   monotonic. Now: KVM guests also base their time on the host TOD,
   so we need to fixup the offset for them as well.

----------------------------------------------------------------
Fan Zhang (1):
      KVM: s390: host STP toleration for VMs

Nicholas Krause (1):
      KVM: s390: Fix assumption that kvm_set_irq_routing is always run successfully

Paolo Bonzini (1):
      Merge tag 'kvm-s390-next-20150728' of git://git.kernel.org/.../kvms390/linux into kvm-next

 arch/s390/include/asm/etr.h |  3 +++
 arch/s390/kernel/time.c     | 16 +++++++++++++---
 arch/s390/kvm/interrupt.c   | 10 +++++++++-
 arch/s390/kvm/kvm-s390.c    | 41 +++++++++++++++++++++++++++++++++++++++--
 arch/s390/kvm/priv.c        |  2 ++
 5 files changed, 66 insertions(+), 6 deletions(-)
