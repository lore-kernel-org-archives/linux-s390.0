From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/2] KVM: s390: fixups for cmma migration (kvm/master)
Date: Thu, 21 Dec 2017 10:04:14 +0100
Message-ID: <20171221090416.17351-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This is targetted as minimal fixups. Claudio is reworking this
to handle this better in general (e.g. memory wholes).

I will wait for a review for patch2 (which is new) and then spin
a pull request as we now have 2 patches for master

Christian Borntraeger (2):
  KVM: s390: fix cmma migration for multiple memory slots
  KVM: s390: prevent buffer overrun on memory hotplug during migration

 arch/s390/kvm/kvm-s390.c | 9 +++++----
 arch/s390/kvm/priv.c     | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.13.4
