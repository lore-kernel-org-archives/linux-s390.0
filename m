From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL v2] KVM: s390: Fixes and features for 4.16
Date: Tue, 16 Jan 2018 16:20:40 +0100
Message-ID: <20180116152040.279900-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

here is the pull request on top of 4.15-rc3. Patches are unchanged (and
not sent again).

The following changes since commit 50c4c4e268a2d7a3e58ebb698ac74da0de40ae36:

  Linux 4.15-rc3 (2017-12-10 17:56:26 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-4.16-1

for you to fetch changes up to a9f6c9a92f3771000493f6bbacbd7677b46d8706:

  KVM: s390: cleanup struct kvm_s390_float_interrupt (2018-01-16 16:15:18 +0100)

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
