From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH v3 0/2] KVM: ioeventfd cookies
Date: Wed,  3 Jul 2013 15:50:37 +0200
Message-ID: <1372859439-18733-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Hi,

here's version 3 of the ioevent cookies patches.

Changes:
- x86 style fix
- fix returning index for reads
- refactored read/write functions to avoid double srcu_deference()

Cornelia Huck (2):
  KVM: kvm-io: support cookies
  KVM: s390: use cookies for ioeventfd

 arch/ia64/kvm/kvm-ia64.c   |   2 +-
 arch/powerpc/kvm/powerpc.c |   4 +-
 arch/s390/kvm/diag.c       |  15 +++++--
 arch/x86/kvm/x86.c         |   6 +--
 include/linux/kvm_host.h   |   4 ++
 virt/kvm/kvm_main.c        | 102 ++++++++++++++++++++++++++++++++++++++-------
 6 files changed, 109 insertions(+), 24 deletions(-)

-- 
1.8.2.2
