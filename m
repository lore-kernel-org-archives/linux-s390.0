From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/1] KVM: s390: another fix for 4.15 (via kvm/master)
Date: Wed, 24 Jan 2018 15:49:43 +0100
Message-ID: <20180124144944.42930-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

one last fix for 4.15. (if it is too late for 4.15 I can send it
for the next merge window together with the other pending patches, let
me know).

The following changes since commit c2cf265d860882b51a200e4a7553c17827f2b730:

  KVM: s390: prevent buffer overrun on memory hotplug during migration (2017-12-22 15:22:41 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-4.15-3

for you to fetch changes up to 1de1ea7efeb9e8543212210e34518b4049ccd285:

  KVM: s390: add proper locking for CMMA migration bitmap (2018-01-24 15:22:51 +0100)

----------------------------------------------------------------
KVM: s390: another fix for cmma migration

This fixes races and potential use after free in the
cmma migration code.

----------------------------------------------------------------
Christian Borntraeger (1):
      KVM: s390: add proper locking for CMMA migration bitmap

 arch/s390/kvm/kvm-s390.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)
