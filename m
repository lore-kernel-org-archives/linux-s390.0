From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/6] KVM: s390: Fixes and features for 4.16
Date: Tue, 16 Jan 2018 16:03:08 +0100
Message-ID: <20180116150314.201352-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

the first chunk (of already reviewed) patches for 4.16 via kvm/next.


The following changes since commit ccff53fd86ee54022e3d841f3db9280b1deb22e4:

  KVM: x86: avoid unnecessary XSETBV on guest entry (2017-12-18 13:10:25 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-4.16-1

for you to fetch changes up to 715e0427049606f499ea6b485c997f93f0778c77:

  KVM: s390: cleanup struct kvm_s390_float_interrupt (2018-01-16 15:53:09 +0100)

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

David Hildenbrand (2):
      s390x/mm: cleanup gmap_pte_op_walk()
      KVM: s390: cleanup struct kvm_s390_float_interrupt

Michael Mueller (1):
      KVM: s390: drop use of spin lock in __floating_irq_kick

 arch/s390/include/asm/kvm_host.h |  3 ---
 arch/s390/kvm/interrupt.c        | 27 +++++++++++----------------
 arch/s390/kvm/kvm-s390.c         | 29 +++++++++++++++++++----------
 arch/s390/kvm/kvm-s390.h         |  2 +-
 arch/s390/kvm/sigp.c             | 12 ++++--------
 arch/s390/mm/gmap.c              | 23 ++++++++---------------
 kernel/configs/kvm_guest.config  |  1 +
 7 files changed, 44 insertions(+), 53 deletions(-)
