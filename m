From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/1] KVM: more halt polling
Date: Tue, 17 May 2016 10:49:21 +0200
Message-ID: <1463474962-5941-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Matlack <dmatlack@google.com>, Wanpeng Li <kernellwp@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

looks like I messed up. While performance showed variant 2 to be
better (very aggressive shrinking) I send you variant 1 last week.

Please consider this addon patch to improve the halt polling for
s390 even further. (variant 1 is still better than the situation
before, so not a big issue, but still).



Christian Borntraeger (1):
  KVM: shrink halt polling even more for invalid wakeups

 virt/kvm/kvm_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.5.5
