From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/3] KVM: s390: Fixups for kvm/next (3.19)
Date: Thu,  4 Dec 2014 17:14:02 +0100
Message-ID: <1417709645-63747-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

some last minute changes for 3.19 as followup for the latest interrupt
rework + a small architectural compliance fix.

Christian

The following changes since commit be06b6bece19be5b167d863fd6c5271e4ec8f1fa:

  Merge tag 'kvm-s390-next-20141128' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD (2014-12-03 15:20:11 +0100)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-20141204

for you to fetch changes up to 99e20009aeee47049900ac152d7a88d4f68697d3:

  KVM: s390: clean up return code handling in irq delivery code (2014-12-04 16:39:00 +0100)

----------------------------------------------------------------
KVM: s390: Fixups for kvm/next (3.19)

Here we have two fixups of the latest interrupt rework and
one architectural fixup.

----------------------------------------------------------------
David Hildenbrand (1):
      KVM: s390: some ext irqs have to clear the ext cpu addr

Jens Freimann (2):
      KVM: s390: use atomic bitops to access pending_irqs bitmap
      KVM: s390: clean up return code handling in irq delivery code

 arch/s390/kvm/interrupt.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)
