From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/4] KVM: s390: Fixes for 4.15
Date: Tue,  5 Dec 2017 09:33:17 +0100
Message-ID: <20171205083321.102933-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This is what I have as fixes for 4.15, please review the new
patch
"KVM: s390: Fix skey emulation permission check"

Pull request will follow if there are no concerns.

text for pull request:

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
