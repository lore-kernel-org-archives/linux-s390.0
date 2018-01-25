From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 00/12] KVM: s390: exitless interrupt support for KVM
Date: Thu, 25 Jan 2018 14:28:36 +0100
Message-ID: <20180125132848.175942-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Here is ithe 2nd version of the exitless interrupts for I/O adapter
interrupts. Lots of fixes and changes from Michael and myself:

- use BITS_PER_BYTE
- remove the aligned statement (since the structure is aligned naturally)
- put_guest_lc are on one line now
- comment about injecting the interrupt via SW if not yet done by hw
- rework return code handling
- unexport some gisa helpers by moving them before the users
- spaces before ":" for bitfields
- fix comments
- added acked and reviewed-bys

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
 arch/s390/include/asm/kvm_host.h  | 102 +++++++++++-----
 arch/s390/include/asm/sclp.h      |   1 +
 arch/s390/kvm/interrupt.c         | 237 ++++++++++++++++++++++++++++++++------
 arch/s390/kvm/kvm-s390.c          |  11 ++
 arch/s390/kvm/kvm-s390.h          |   3 +
 drivers/s390/char/sclp_early.c    |   3 +-
 8 files changed, 300 insertions(+), 66 deletions(-)

-- 
2.9.4
