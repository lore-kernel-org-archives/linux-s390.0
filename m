Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 0/2] KVM: s390: vsie: simulate VCPU SIE entry/exit
Date: Thu,  9 Aug 2018 10:05:59 +0200
Message-Id: <20180809080601.31797-1-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

While discussing AP changes, we discovered that we will have to force
a CPU using the vSIE to regenerate/reload shadow data structures. For now,
we have no mechanism for that.

E.g. when clearing AP masks later, we could still have a vSIE CPU making
use of AP adapters as the masks might not be considered yet in the vSIE
data structures. We need a way to block entering the vSIE and regenerate
all shadow data structures once done.

Looks like we can achieve that by simply simulating an ordinary SIE
entry/exit in the VCPU sie control block (when executing sie64 in context
of the vSIE).

This way, we can support blocking and also synchronous CPU requests.

Only compile tested.

RFC -> v1:
- Move entry/exit simulation right to the sie64 code to minimize latency
- Added R-b's, dropped Tested-by.

David Hildenbrand (2):
  KVM: s390: vsie: simulate VCPU SIE entry/exit
  KVM: s390: introduce and use KVM_REQ_VSIE_RESTART

 arch/s390/include/asm/kvm_host.h |  1 +
 arch/s390/kvm/kvm-s390.c         | 16 ++++++++++++++--
 arch/s390/kvm/kvm-s390.h         |  1 +
 arch/s390/kvm/vsie.c             | 21 +++++++++++++++++----
 4 files changed, 33 insertions(+), 6 deletions(-)

-- 
2.17.1
