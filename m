From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 23 Feb 2018 08:11:40 +0000
Subject: [PATCH 0/2] KVM: s390: misc changes
Message-Id: <20180223081142.46406-1-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Christian Borntraeger (2):
  KVM: document KVM_CAP_S390_[BPB|PSW|GMAP|COW]
  KVM: s390: add exit io request stats and simplify code

 Documentation/virtual/kvm/api.txt | 29 +++++++++++++++++++++++++++++
 arch/s390/include/asm/kvm_host.h  |  1 +
 arch/s390/kvm/intercept.c         | 19 +++++--------------
 arch/s390/kvm/kvm-s390.c          |  1 +
 4 files changed, 36 insertions(+), 14 deletions(-)

-- 
2.14.3
