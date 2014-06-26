From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PULL 0/1] KVM: s390: fix for 3.16
Date: Thu, 26 Jun 2014 11:09:32 +0200
Message-ID: <1403773773-11279-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Gleb,

here's a fix for KVM/s390 for a change that was introduced during
the merge window; therefore, it should go into 3.16. Please pull.

The following changes since commit 5c02c392cd2320e8d612376d6b72b6548a680923:

  Merge tag 'virtio-next-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rusty/linux (2014-06-11 21:10:33 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvms390-20140626

for you to fetch changes up to d09a08e030acbb41aadf7fee7b31cb1c5391bb96:

  KVM: s390: add sie.h uapi header file to Kbuild and remove header dependency (2014-06-26 10:42:59 +0200)

----------------------------------------------------------------
Fix sie.h header related problems introduced during the 3.16 development
cycle.

----------------------------------------------------------------

Heiko Carstens (1):
  KVM: s390: add sie.h uapi header file to Kbuild and remove header
    dependency

 arch/s390/include/uapi/asm/Kbuild |    1 +
 arch/s390/include/uapi/asm/sie.h  |   26 ++++++++++++--------------
 2 files changed, 13 insertions(+), 14 deletions(-)

-- 
1.7.9.5
