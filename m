From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/2] KVM: s390: 4.7: fixup and missing stat
Date: Fri, 10 Jun 2016 12:04:34 +0200
Message-ID: <1465553076-155323-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

two patches for 4.7 from the s390 side.

The following changes since commit af8c34ce6ae32addda3788d54a7e340cad22516b:

  Linux 4.7-rc2 (2016-06-05 14:31:26 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-4.7-1

for you to fetch changes up to 9ec6de19235889ab0118e970ee732cb33c9efc06:

  KVM: s390: Add stats for PEI events (2016-06-10 10:24:24 +0200)

----------------------------------------------------------------
KVM: s390: fixup and missing stat

1. A fixup for a bug that was introduced in 4.7-rc1 if userspace uses
   the cpu model ioctls
2. Add the missing kvm stat for pei events

----------------------------------------------------------------
Alexander Yarygin (1):
      KVM: s390: Add stats for PEI events

David Hildenbrand (1):
      KVM: s390: ignore IBC if zero

 arch/s390/include/asm/kvm_host.h | 1 +
 arch/s390/kvm/intercept.c        | 2 ++
 arch/s390/kvm/kvm-s390.c         | 3 ++-
 3 files changed, 5 insertions(+), 1 deletion(-)
