From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/1] KVM: s390: fix for 4.15 and stable
Date: Tue, 19 Dec 2017 09:19:20 +0100
Message-ID: <20171219081921.81670-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

While testing the qemu patch for > 8TB guests I stumbled over
this. This is the minimal fix -> also suitable for stable.

I think we can improve this code even more (e.g. by not allocating
a bitmap for memory holes), but this will be a followup later
on.

Christian Borntraeger (1):
  KVM: s390: fix cmma migration for multiple memory slots

 arch/s390/kvm/kvm-s390.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.13.4
