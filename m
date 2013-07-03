From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH v4 0/2] KVM: ioeventfd cookies
Date: Wed,  3 Jul 2013 16:30:52 +0200
Message-ID: <1372861854-23043-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Hi,

fourth version of this patch set.

Changes:
- make the cookie-less read/write function return 0 again on success and
  drop the changes at the callsites

Cornelia Huck (2):
  KVM: kvm-io: support cookies
  KVM: s390: use cookies for ioeventfd

 arch/s390/kvm/diag.c     |  15 +++++--
 include/linux/kvm_host.h |   4 ++
 virt/kvm/kvm_main.c      | 106 ++++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 107 insertions(+), 18 deletions(-)

-- 
1.8.2.2
