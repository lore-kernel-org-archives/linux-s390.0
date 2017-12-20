From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/5] preview of first chunk of s390 patches for kvm/next
Date: Wed, 20 Dec 2017 16:52:55 +0100
Message-ID: <20171220155300.102321-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Just to get some reviewable patches out before the holidays.

----------------------------------------------------------------
KVM: s390: Fixes and features for 4.16

- add the virtio-ccw transport for kvmconfig
- more debug tracing for cpu model
- cleanups and fixes

----------------------------------------------------------------
Christian Borntraeger (3):
      KVM: s390: use created_vcpus in more places
      KVM: s390: add debug tracing for cpu features of CPU model
      kvm_config: add CONFIG_S390_GUEST

David Hildenbrand (1):
      s390x/mm: cleanup gmap_pte_op_walk()

Michael Mueller (1):
      KVM: s390: drop use of spin lock in __floating_irq_kick

 arch/s390/kvm/interrupt.c       |  2 --
 arch/s390/kvm/kvm-s390.c        | 26 +++++++++++++++++++-------
 arch/s390/mm/gmap.c             | 23 ++++++++---------------
 kernel/configs/kvm_guest.config |  1 +
 4 files changed, 28 insertions(+), 24 deletions(-)
