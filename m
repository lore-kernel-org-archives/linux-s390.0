From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: PREVIEW: [GIT PULL 0/2] KVM: s390: Feature and fix for kvm/next (4.8) part 4
Date: Wed, 20 Jul 2016 14:39:58 +0200
Message-ID: <1469018400-8397-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

hopefully the last update for s390 for 4.8.
Please note the CAP number conflicts with kvmarm, when merging the one
or the other first. You might also need to adopt the number in
Documentation/virtual/kvm/api.txt in case arm has something in here as well.


The following changes since commit af1bae5497b98cb99d6b0492e6981f060420a00c:

  KVM: x86: bump KVM_MAX_VCPU_ID to 1023 (2016-07-14 09:29:35 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-4.8-4

for you to fetch changes up to 9acc317b183fdd3ed3bca218271875c0e808daae:

  KVM: s390: let ptff intercepts result in cc=3 (2016-07-18 14:15:00 +0200)

----------------------------------------------------------------
KVM: s390: : Feature and fix for kvm/next (4.8) part 4

1. Provide an exit to userspace for the invalid opcode 0 (used for
   software breakpoints)
2. "Fix" (by returning condition code 3) some unhandled PTFF subcodes

----------------------------------------------------------------
David Hildenbrand (2):
      KVM: s390: allow user space to handle instr 0x0000
      KVM: s390: let ptff intercepts result in cc=3

 Documentation/virtual/kvm/api.txt | 13 +++++++++++++
 arch/s390/include/asm/kvm_host.h  |  2 ++
 arch/s390/kvm/intercept.c         |  3 +++
 arch/s390/kvm/kvm-s390.c          | 26 ++++++++++++++++++++++++--
 arch/s390/kvm/priv.c              |  8 ++++++++
 include/uapi/linux/kvm.h          |  1 +
 6 files changed, 51 insertions(+), 2 deletions(-)
