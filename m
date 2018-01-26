From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 00/22] KVM: s390: Fixes and features for 4.16 part 2
Date: Fri, 26 Jan 2018 16:53:12 +0100
Message-ID: <20180126155334.52956-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

the 2nd bunch of changes for KVM on s390 for 4.16.

- It contains 2 patches touching arch/s390/mm/gmap.c, this is now ok
since we marked this file as now co-maintained by Martin/Heiko and
the kvm team
- it contains 3 patches touching non-kvm files:
arch/s390/include/asm/bitops.h, arch/s390/include/asm/css_chars.h,
arch/s390/include/asm/sclp.h, and drivers/s390/char/sclp_early.c.

all of these changes have an ACK from Martin

Please pull.

The following changes since commit a9f6c9a92f3771000493f6bbacbd7677b46d8706:

  KVM: s390: cleanup struct kvm_s390_float_interrupt (2018-01-16 16:15:18 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-4.16-2

for you to fetch changes up to 4b9f952577fb40875a2a163d80515a8daa0d6bef:

  KVM: s390: introduce the format-1 GISA (2018-01-26 14:13:58 +0100)

----------------------------------------------------------------
KVM: s390: Fixes and features for 4.16 part 2

- exitless interrupts for emulated devices (Michael Mueller)
- cleanup of cpuflag handling (David Hildenbrand)
- kvm stat counter improvements (Christian Borntraeger)
- vsie improvements (David Hildenbrand)
- mm cleanup (Janosch Frank)

----------------------------------------------------------------
Christian Borntraeger (2):
      KVM: s390: diagnoses are instructions as well
      KVM: s390: add vcpu stat counters for many instruction

David Hildenbrand (7):
      KVM: s390: vsie: use READ_ONCE to access some SCB fields
      KVM: s390: vsie: store guest addresses of satellite blocks in vsie_page
      s390x/mm: simplify gmap_protect_rmap()
      KVM: s390: rename __set_cpuflag() to kvm_s390_set_cpuflags()
      KVM: s390: reuse kvm_s390_set_cpuflags()
      KVM: s390: introduce and use kvm_s390_clear_cpuflags()
      KVM: s390: introduce and use kvm_s390_test_cpuflags()

Janosch Frank (1):
      s390/mm: Remove superfluous parameter

Jens Freimann (1):
      s390/bitops: add test_and_clear_bit_inv()

Michael Mueller (11):
      KVM: s390: reverse bit ordering of irqs in pending mask
      KVM: s390: define GISA format-0 data structure
      KVM: s390: implement GISA IPM related primitives
      s390/css: indicate the availability of the AIV facility
      KVM: s390: exploit GISA and AIV for emulated interrupts
      KVM: s390: abstract adapter interruption word generation from ISC
      KVM: s390: add GISA interrupts to FLIC ioctl interface
      KVM: s390: make kvm_s390_get_io_int() aware of GISA
      KVM: s390: activate GISA for emulated interrupts
      s390/sclp: expose the GISA format facility
      KVM: s390: introduce the format-1 GISA

 arch/s390/include/asm/bitops.h    |   5 +
 arch/s390/include/asm/css_chars.h |   4 +-
 arch/s390/include/asm/kvm_host.h  | 123 ++++++++++++-----
 arch/s390/include/asm/sclp.h      |   1 +
 arch/s390/kvm/diag.c              |   1 +
 arch/s390/kvm/interrupt.c         | 283 ++++++++++++++++++++++++++++++--------
 arch/s390/kvm/kvm-s390.c          |  74 ++++++----
 arch/s390/kvm/kvm-s390.h          |  20 ++-
 arch/s390/kvm/priv.c              |  38 ++++-
 arch/s390/kvm/sigp.c              |  14 +-
 arch/s390/kvm/vsie.c              |  91 +++++++-----
 arch/s390/mm/gmap.c               |  21 ++-
 drivers/s390/char/sclp_early.c    |   3 +-
 13 files changed, 498 insertions(+), 180 deletions(-)
