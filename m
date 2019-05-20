Return-Path: <SRS0=Q8yj=TU=vger.kernel.org=kvm-owner@kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/2] KVM: s390: Fixes for 5.2-rc2
Date: Mon, 20 May 2019 12:30:53 +0200
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190520103055.246818-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Wei Yongjun <weiyongjun1@huawei.com>
List-ID: <linux-s390.vger.kernel.org>


Paolo, Radim,

two small changes for rc2 via kvm/master. One is a fix for typo that
was merged during this merge window, the other is a CPU consumption 
improvement for halt polling on s390.

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-5.2-1

for you to fetch changes up to 6e9b622d1c3628fae65217465a148b157a361c2a:

  KVM: s390: change default halt poll time to 50us (2019-05-20 09:40:39 +0200)

----------------------------------------------------------------
KVM: s390: Fixes for s390

- Fix typo in module paramter description
- Change default poll timer to improve cpu consumption

----------------------------------------------------------------
Christian Borntraeger (1):
      KVM: s390: change default halt poll time to 50us

Wei Yongjun (1):
      KVM: s390: fix typo in parameter description

 arch/s390/include/asm/kvm_host.h | 2 +-
 arch/s390/kvm/kvm-s390.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
