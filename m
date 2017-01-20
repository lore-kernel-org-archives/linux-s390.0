From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/1] KVM: s390: Fix for 4.10 (via kvm/master)
Date: Fri, 20 Jan 2017 16:04:58 +0100
Message-ID: <1484924699-183878-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

a fix for 4.10 (and stable).

The following changes since commit a121103c922847ba5010819a3f250f1f7fc84ab8:

  Linux 4.10-rc3 (2017-01-08 14:18:17 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-4.10-1

for you to fetch changes up to 04478197416e3a302e9ebc917ba1aa884ef9bfab:

  KVM: s390: do not expose random data via facility bitmap (2017-01-20 15:29:34 +0100)

----------------------------------------------------------------
KVM: s390: Fix for 4.10 (via kvm/master)

Fix a kernel memory exposure.

----------------------------------------------------------------
Christian Borntraeger (1):
      KVM: s390: do not expose random data via facility bitmap

 arch/s390/kvm/kvm-s390.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
