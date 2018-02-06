From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/2] KVM: s390: avoid jump tables
Date: Tue,  6 Feb 2018 11:21:25 +0000
Message-ID: <20180206112127.19014-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Some old patches refreshed.

Christian Borntraeger (2):
  KVM: s390: use switch vs jump table in priv.c
  KVM: s390: use switch vs jump table in intercept.c

 arch/s390/kvm/intercept.c |  54 +++++++-------
 arch/s390/kvm/kvm-s390.h  |   2 -
 arch/s390/kvm/priv.c      | 183 +++++++++++++++++++++++-----------------------
 3 files changed, 119 insertions(+), 120 deletions(-)

-- 
2.14.3
