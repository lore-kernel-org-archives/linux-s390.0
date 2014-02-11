From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 0/3] KVM: yield heuristic improvements
Date: Tue, 11 Feb 2014 12:45:29 +0100
Message-ID: <1392119132-50182-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Gleb,

here are 3 patches that improve the s390 guest performance on contended
systems. Basic idea is to also allow yielding to CPUs which still sleep
but are runnable. The patch set should be no-ops for !s390.

Michael Mueller (3):
  kvm: Introduction of kvm_arch_vcpu_dont_yield()
  s390/kvm: Platform specific kvm_arch_vcpu_dont_yield
  s390/kvm: Set preempted flag during vcpu wakeup and interrupt delivery

 arch/s390/kvm/Kconfig     | 1 +
 arch/s390/kvm/interrupt.c | 3 +++
 arch/s390/kvm/kvm-s390.c  | 7 +++++++
 include/linux/kvm_host.h  | 9 +++++++++
 virt/kvm/Kconfig          | 3 +++
 virt/kvm/kvm_main.c       | 2 +-
 6 files changed, 24 insertions(+), 1 deletion(-)

-- 
1.8.4.2
