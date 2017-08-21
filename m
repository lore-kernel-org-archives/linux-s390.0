From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/2] KVM: s390: two fixes for sthyi emulation (4.13)
Date: Mon, 21 Aug 2017 14:27:43 +0200
Message-ID: <1503318465-19013-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

I plan to submit a pull request for these 2 patches soon. 

Heiko Carstens (2):
      KVM: s390: sthyi: fix sthyi inline assembly
      KVM: s390: sthyi: fix specification exception detection

 arch/s390/kvm/sthyi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

Feedback welcome.

Christian
