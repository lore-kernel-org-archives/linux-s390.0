From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/2] KVM: s390: two fixes for sthyi emulation
Date: Mon, 21 Aug 2017 17:34:48 +0200
Message-ID: <1503329690-34224-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

The following changes since commit 4f899147424a189b0ad1fdd6f35784ed5a642e83:

  KVM: s390: take srcu lock when getting/setting storage keys (2017-07-25 14:59:52 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-4.13-2

for you to fetch changes up to 857b8de96795646c5891cf44ae6fb19b9ff74bf9:

  KVM: s390: sthyi: fix specification exception detection (2017-08-21 15:34:54 +0200)

----------------------------------------------------------------
KVM: s390: two fixes for sthyi emulation

- missing inline assembly constraint
- wrong exception handling

----------------------------------------------------------------
Heiko Carstens (2):
      KVM: s390: sthyi: fix sthyi inline assembly
      KVM: s390: sthyi: fix specification exception detection

 arch/s390/kvm/sthyi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)
