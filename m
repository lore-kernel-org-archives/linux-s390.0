From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH v2 0/2] KVM: ioeventfd cookies
Date: Wed,  3 Jul 2013 14:48:34 +0200
Message-ID: <1372855716-49016-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Hi,

here's the second version of the ioeventfd cookies support. Changes:

- provide kvm_io_bus_read_cookie as well
- refactoring of the cookie code in kvm_main.c
- adapt callers to changes

Cornelia Huck (2):
  KVM: kvm-io: support cookies
  KVM: s390: use cookies for ioeventfd

 arch/ia64/kvm/kvm-ia64.c   |  2 +-
 arch/powerpc/kvm/powerpc.c |  4 ++--
 arch/s390/kvm/diag.c       | 15 +++++++++---
 arch/x86/kvm/x86.c         |  8 ++++---
 include/linux/kvm_host.h   |  4 ++++
 virt/kvm/kvm_main.c        | 58 +++++++++++++++++++++++++++++++++++++++++++++-
 6 files changed, 81 insertions(+), 10 deletions(-)

-- 
1.8.2.2
