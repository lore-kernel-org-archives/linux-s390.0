From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/2] KVM: s390: kvm stat counters rework
Date: Wed, 24 Jan 2018 12:32:33 +0100
Message-ID: <20180124113235.31485-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

These patches are the fallout of some incosistencies while debugging
a different issue.

Bikeshedding question: Shall I add a followup patch that sorts all
the counters alphabetically in kvm_host.h and kvm-s390.c?

Christian Borntraeger (2):
  KVM: s390: add vcpu stat counters for many instruction
  KVM: s390: diagnoses are instructions as well

 arch/s390/include/asm/kvm_host.h | 18 ++++++++++++++++--
 arch/s390/kvm/kvm-s390.c         | 30 ++++++++++++++++++++++--------
 arch/s390/kvm/priv.c             | 33 +++++++++++++++++++++++++++++++--
 3 files changed, 69 insertions(+), 12 deletions(-)

-- 
2.9.4
