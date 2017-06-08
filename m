From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/1] KVM: s390: Fix for master (4.12)
Date: Thu,  8 Jun 2017 15:57:30 +0200
Message-ID: <1496930251-16710-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

The following changes since commit 55c315ee09d3bd37f9d71e85e54d6ebe675b6462:

  Merge tag 'kvm-arm-for-v4.12-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm (2017-05-18 14:40:32 +0200)

are available in the git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-master-4.12-1

for you to fetch changes up to 1ba15b24f07c44f68067959522639226c963e212:

  KVM: s390: fix ais handling vs cpu model (2017-05-31 19:54:49 +0200)

----------------------------------------------------------------
KVM: s390: Fix for master (4.12)

- The newly created AIS capability enables the feature unconditionally
  and ignores the cpu model

----------------------------------------------------------------
Christian Borntraeger (1):
      KVM: s390: fix ais handling vs cpu model

 arch/s390/include/asm/kvm_host.h | 1 -
 arch/s390/kvm/interrupt.c        | 4 ++--
 arch/s390/kvm/kvm-s390.c         | 2 --
 3 files changed, 2 insertions(+), 5 deletions(-)
