From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 0/2] KVM: enable ioeventfd cookies
Date: Wed,  3 Jul 2013 10:56:18 +0200
Message-ID: <1372841780-29645-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Hi,

the following two patches enable cookies to speed up lookups for
virtio-ccw ioeventfds on s390. I originally wrote that code when I
enabled ioeventfds back in March, but wanted to run it through some
testing before submitting it and then promptly forgot to post it again.

As this has been well tested by our internal test team :), I'd like to
see it applied now.

Cornelia Huck (2):
  KVM: kvm-io: support cookies
  KVM: s390: use cookies for ioeventfd

 arch/s390/kvm/diag.c     | 17 ++++++++++++++---
 include/linux/kvm_host.h |  2 ++
 virt/kvm/kvm_main.c      | 44 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 3 deletions(-)

-- 
1.8.2.2
