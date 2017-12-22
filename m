From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/2] KVM: s390: Fixes for 4.15 (via kvm/master)
Date: Fri, 22 Dec 2017 15:51:26 +0100
Message-ID: <20171222145128.20836-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim

The following changes since commit ca76ec9ca871e67d8cd0b6caba24aca3d3ac4546:

  KVM: s390: Fix skey emulation permission check (2017-12-06 09:18:43 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-4.15-2

for you to fetch changes up to c2cf265d860882b51a200e4a7553c17827f2b730:

  KVM: s390: prevent buffer overrun on memory hotplug during migration (2017-12-22 15:22:41 +0100)

----------------------------------------------------------------
KVM: s390: fixes for cmma migration

Two fixes for potential bitmap overruns in the cmma migration
code.

----------------------------------------------------------------
Christian Borntraeger (2):
      KVM: s390: fix cmma migration for multiple memory slots
      KVM: s390: prevent buffer overrun on memory hotplug during migration

 arch/s390/kvm/kvm-s390.c | 9 +++++----
 arch/s390/kvm/priv.c     | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)
