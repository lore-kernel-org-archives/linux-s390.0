From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL 0/4] KVM: s390: last fixes for next merge window
Date: Tue, 25 Mar 2014 14:35:19 +0100
Message-ID: <1395754523-43697-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

The following changes since commit 94b3ffcd41a90d2cb0b32ca23aa58a01111d5dc0:

  Merge tag 'kvm-s390-20140317' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD (2014-03-17 12:21:35 +0100)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-20140325

for you to fetch changes up to 2ed10cc15e7edf2daf22ce807a877a1266e97711:

  KVM: s390: clear local interrupts at cpu initial reset (2014-03-25 13:27:12 +0100)

I have verfied that there is no merge conflict with the irqfd
patches from Cornelia.

Christian

----------------------------------------------------------------
3 fixes
- memory leak on certain SIGP conditions
- wrong size for idle bitmap (always too big)
- clear local interrupts on initial CPU reset

1 performance improvement
- improve performance with many guests on certain workloads

----------------------------------------------------------------
Christian Borntraeger (1):
      KVM: s390: randomize sca address

Jens Freimann (2):
      KVM: s390: fix calculation of idle_mask array size
      KVM: s390: clear local interrupts at cpu initial reset

Thomas Huth (1):
      KVM: s390: Fix possible memory leak in SIGP functions

 arch/s390/include/asm/kvm_host.h |  3 +--
 arch/s390/kvm/interrupt.c        | 14 ++++++++++++++
 arch/s390/kvm/kvm-s390.c         |  6 ++++++
 arch/s390/kvm/kvm-s390.h         |  1 +
 arch/s390/kvm/sigp.c             | 14 ++++++--------
 5 files changed, 28 insertions(+), 10 deletions(-)
