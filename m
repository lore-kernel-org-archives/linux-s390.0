From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/9] KVM: s390: Fixes and cleanups for 3.17
Date: Mon, 21 Jul 2014 21:14:16 +0200
Message-ID: <1405970065-3740-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

this should be the last bunch of s390 patches for 3.17 (on top of the
mp_state changes). Please consider to apply.

The following changes since commit 6352e4d2dd9a349024a41356148eced553e1dce4:

  KVM: s390: implement KVM_(S|G)ET_MP_STATE for user space state control (2014-07-10 14:11:17 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-20140721

for you to fetch changes up to e59d120f96687a606db0513c427f10e30a427cc4:

  KVM: s390: add ipte to trace event decoding (2014-07-21 13:22:47 +0200)

----------------------------------------------------------------
Bugfixes
--------
- add IPTE to trace event decoder
- document and advertise KVM_CAP_S390_IRQCHIP

Cleanups
--------
- Reuse kvm_vcpu_block for s390
- Get rid of tasklet for wakup processing

----------------------------------------------------------------
Christian Borntraeger (1):
      KVM: s390: add ipte to trace event decoding

Cornelia Huck (3):
      KVM: document target of capability enablement
      KVM: s390: document KVM_CAP_S390_IRQCHIP
      KVM: s390: advertise KVM_CAP_S390_IRQCHIP

David Hildenbrand (5):
      KVM: s390: cleanup handle_wait by reusing kvm_vcpu_block
      KVM: s390: remove _bh locking from local_int.lock
      KVM: s390: remove _bh locking from start_stop_lock
      KVM: s390: move vcpu wakeup code to a central point
      KVM: s390: remove the tasklet used by the hrtimer

 Documentation/virtual/kvm/api.txt |  27 ++++++++--
 arch/s390/include/asm/kvm_host.h  |   2 -
 arch/s390/include/uapi/asm/sie.h  |   1 +
 arch/s390/kvm/interrupt.c         | 100 ++++++++++++--------------------------
 arch/s390/kvm/kvm-s390.c          |  18 ++++---
 arch/s390/kvm/kvm-s390.h          |   2 +-
 arch/s390/kvm/sigp.c              |  36 ++++++--------
 7 files changed, 82 insertions(+), 104 deletions(-)
