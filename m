From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/2] KVM: s390: Small enhancements for 3.18 (next)
Date: Wed,  1 Oct 2014 16:02:48 +0200
Message-ID: <1412172170-13472-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

let's use the additional week that Linus gave us for growing next by
adding two small enhancements.

The following changes since commit cec26bc3c125b5dd12a02f04133cd91eae3f1622:

  KVM: PPC: BOOK3S: HV: CMA: Reserve cma region only in hypervisor mode (2014-09-29 15:36:33 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-20141001

for you to fetch changes up to ce2e4f0b75a567d25375b52476662c724304e476:

  KVM: s390: count vcpu wakeups in stat.halt_wakeup (2014-10-01 14:42:14 +0200)

----------------------------------------------------------------
KVM: s390: Small enhancements for 3.18 (next)

Provide TOD CLOCK steering to the guest and add cpu wakeup counter.

----------------------------------------------------------------
Christian Borntraeger (1):
      KVM: s390/facilities: allow TOD-CLOCK steering facility bit

David Hildenbrand (1):
      KVM: s390: count vcpu wakeups in stat.halt_wakeup

 arch/s390/include/asm/kvm_host.h | 1 +
 arch/s390/kvm/interrupt.c        | 1 +
 arch/s390/kvm/kvm-s390.c         | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)
