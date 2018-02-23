From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 23 Feb 2018 11:10:23 +0000
Subject: [PATCH v2 0/2] KVM: s390: misc changes
Message-Id: <20180223111025.130315-1-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

v1->v2:
- add statement to bpb about guest facilities
- use return instead of break to not check for PER on interrupt
  requests

Christian Borntraeger (2):
  KVM: document KVM_CAP_S390_[BPB|PSW|GMAP|COW]
  KVM: s390: add exit io request stats and simplify code

 Documentation/virtual/kvm/api.txt | 30 ++++++++++++++++++++++++++++++
 arch/s390/include/asm/kvm_host.h  |  1 +
 arch/s390/kvm/intercept.c         | 17 ++++-------------
 arch/s390/kvm/kvm-s390.c          |  1 +
 4 files changed, 36 insertions(+), 13 deletions(-)

-- 
2.14.3
