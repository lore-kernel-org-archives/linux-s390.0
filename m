From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/4] KVM: s390: Fixes for 4.15 (via kvm/master)
Date: Wed,  6 Dec 2017 09:37:26 +0100
Message-ID: <20171206083730.3452-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-4.15-1

for you to fetch changes up to ca76ec9ca871e67d8cd0b6caba24aca3d3ac4546:

  KVM: s390: Fix skey emulation permission check (2017-12-06 09:18:43 +0100)

----------------------------------------------------------------
KVM: s390: Fixes for 4.15

- SPDX tags
- Fence storage key accesses from problem state
- Make sure that irq_state.flags is not used in the future

----------------------------------------------------------------
Christian Borntraeger (1):
      KVM: s390: mark irq_state.flags as non-usable

Greg Kroah-Hartman (2):
      KVM: s390: add SPDX identifiers to the remaining files
      KVM: s390: Remove redundant license text

Janosch Frank (1):
      KVM: s390: Fix skey emulation permission check

 Documentation/virtual/kvm/api.txt | 15 ++++++++++++---
 arch/s390/kvm/Makefile            |  5 +----
 arch/s390/kvm/diag.c              |  5 +----
 arch/s390/kvm/gaccess.h           |  5 +----
 arch/s390/kvm/guestdbg.c          |  5 +----
 arch/s390/kvm/intercept.c         |  5 +----
 arch/s390/kvm/interrupt.c         |  5 +----
 arch/s390/kvm/irq.h               |  5 +----
 arch/s390/kvm/kvm-s390.c          | 11 +++++------
 arch/s390/kvm/kvm-s390.h          |  5 +----
 arch/s390/kvm/priv.c              | 16 ++++++++++------
 arch/s390/kvm/sigp.c              |  5 +----
 arch/s390/kvm/vsie.c              |  5 +----
 include/uapi/linux/kvm.h          |  4 ++--
 14 files changed, 39 insertions(+), 57 deletions(-)
