From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/1] KVM: s390: fix for 4.12 (via kvm/master)
Date: Thu, 22 Jun 2017 15:34:26 +0200
Message-ID: <1498138467-29808-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

a late bugfix for 4.12.

The following changes since commit 1ba15b24f07c44f68067959522639226c963e212:

  KVM: s390: fix ais handling vs cpu model (2017-05-31 19:54:49 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-4.12-2

for you to fetch changes up to addb63c18a0d52a9ce2611d039f981f7b6148d2b:

  KVM: s390: gaccess: fix real-space designation asce handling for gmap shadows (2017-06-22 12:53:34 +0200)

----------------------------------------------------------------
KVM: s390: fix shadow table handling for nested guests

Some odd-ball cases (real-space designation ASCEs) are handled wrong
for the shadow page tables. Fix it.

----------------------------------------------------------------
Heiko Carstens (1):
      KVM: s390: gaccess: fix real-space designation asce handling for gmap shadows

 arch/s390/kvm/gaccess.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)
