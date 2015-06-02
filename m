From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/2] KVM: s390: Fix and cleanup for 4.2 (kvm/next)
Date: Tue,  2 Jun 2015 10:14:08 +0200
Message-ID: <1433232850-9578-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

one fix and one cleanup for 4.2.



The following changes since commit 06b36753a6466239fc945b6756e12d635621ae5f:

  KVM: s390: drop handling of interception code 12 (2015-05-08 15:51:17 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-20150602

for you to fetch changes up to ea2cdd27dce66dc498c623adacd807ea3a350443:

  KVM: s390: introduce KMSG_COMPONENT for kvm-s390 (2015-06-02 09:39:20 +0200)

----------------------------------------------------------------
KVM: s390: Fix and cleanup for 4.2 (kvm/next)

One small fix for a commit targetted for 4.2 and one cleanup
regarding our printks.

----------------------------------------------------------------
David Hildenbrand (2):
      KVM: s390: call exit_sie() directly on vcpu block/request
      KVM: s390: introduce KMSG_COMPONENT for kvm-s390

 arch/s390/kvm/kvm-s390.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)
