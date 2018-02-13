From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/2] small optimizations for exitless interrupts
Date: Tue, 13 Feb 2018 12:28:56 +0000
Message-ID: <20180213122858.74748-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Some small optimizations for the exitless interrupts

Christian Borntraeger (2):
  KVM: s390: optimize wakeup for exitless interrupts
  KVM: s390: do not set intervention requests for GISA interrupts

 arch/s390/kvm/interrupt.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

-- 
2.14.3
