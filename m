From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 0/2] KVM: s390: enable kvm_vpcu_kick/wake_up
Date: Fri, 17 Feb 2017 14:10:05 +0100
Message-ID: <1487337007-91063-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

David, I have certainly forgotten something, but I think
this should be good enough for all non-special cases that require
specific CPUs outside of the guest context and only need to handle
a request fast.

Christian Borntraeger (2):
  s390/smp: export smp_send_reschedule
  KVM: enable kvm_vcpu_kick/wake_up for s390

 arch/s390/kernel/smp.c   |  1 +
 arch/s390/kvm/kvm-s390.c | 12 ++++++++++--
 virt/kvm/kvm_main.c      |  2 --
 3 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.7.4
