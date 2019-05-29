Return-Path: <SRS0=5+JM=T5=vger.kernel.org=kvm-owner@kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/2] KVM: s390: fixes for 5.2-rc3
Date: Wed, 29 May 2019 14:50:43 +0200
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190529125045.42935-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

The following changes since commit cd6c84d8f0cdc911df435bb075ba22ce3c605b07:

  Linux 5.2-rc2 (2019-05-26 16:49:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-5.2-2

for you to fetch changes up to a86cb413f4bf273a9d341a3ab2c2ca44e12eb317:

  KVM: s390: Do not report unusabled IDs via KVM_CAP_MAX_VCPU_ID (2019-05-28 15:52:19 +0200)

----------------------------------------------------------------
KVM: s390: Fixes

- fix compilation for !CONFIG_PCI
- fix the output of KVM_CAP_MAX_VCPU_ID

----------------------------------------------------------------
Christian Borntraeger (1):
      kvm: fix compile on s390 part 2

Thomas Huth (1):
      KVM: s390: Do not report unusabled IDs via KVM_CAP_MAX_VCPU_ID

 arch/mips/kvm/mips.c       | 3 +++
 arch/powerpc/kvm/powerpc.c | 3 +++
 arch/s390/kvm/kvm-s390.c   | 1 +
 arch/x86/kvm/x86.c         | 3 +++
 virt/kvm/arm/arm.c         | 3 +++
 virt/kvm/kvm_main.c        | 4 ++--
 6 files changed, 15 insertions(+), 2 deletions(-)
