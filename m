From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 0/5] KVM: s390: Let user space control the cpu states
Date: Thu, 10 Jul 2014 15:09:30 +0200
Message-ID: <1404997775-28929-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

here is a preview of a rework of CPU state on s390x. Since we extend 
MP_STATE I wanted to send an RFC upfront. I will wait for some feedback
and send a proper pull request in the next week:

-----

This series enables the "KVM_SET_MP_STATE" ioctl on s390 to make the cpu
state settable by user space.

This helps us to avoid races in SIGP/Reset handling that happen because
some SIGPs are handled in QEMU, others in the KERNEL. 

As soon as the new interface is touched, user space takes complete control
of the cpu states. Otherwise the old way is used.
Therefore, the new kernel should continue to work fine with old QEMUs.


David Hildenbrand (5):
  KVM: s390: allow only one SIGP STOP (AND STORE STATUS) at a time
  KVM: s390: move finalization of SIGP STOP orders to kvm_s390_vcpu_stop
  KVM: s390: remove __cpu_is_stopped and expose is_vcpu_stopped
  KVM: prepare for KVM_(S|G)ET_MP_STATE on other architectures
  KVM: s390: implement KVM_(S|G)ET_MP_STATE for user space state control

 Documentation/virtual/kvm/api.txt | 31 ++++++++++++++---------
 arch/s390/include/asm/kvm_host.h  |  1 +
 arch/s390/kvm/diag.c              |  3 ++-
 arch/s390/kvm/intercept.c         | 32 ++++++++++--------------
 arch/s390/kvm/kvm-s390.c          | 52 +++++++++++++++++++++++++++++++--------
 arch/s390/kvm/kvm-s390.h          | 10 ++++++--
 arch/s390/kvm/sigp.c              |  7 +++++-
 include/uapi/linux/kvm.h          |  7 +++++-
 8 files changed, 98 insertions(+), 45 deletions(-)

-- 
1.8.4.2
