From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 00/12] KVM: s390: exitless interrupt support for KVM
Date: Tue, 16 Jan 2018 21:02:05 +0100
Message-ID: <20180116200217.211897-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Here is a patch set that implements exitless interrupts for I/O adapter
interrupts. It was running for a while now internally so from a
"quality perspective" this seems to be good. Review is always welcome
though.

Jens Freimann (1):
  s390/bitops: add test_and_clear_bit_inv()

Michael Mueller (11):
  KVM: s390: reverse bit ordering of irqs in pending mask
  KVM: s390: define GISA format-0 data structure
  KVM: s390: implement GISA IPM related primitives
  s390/css: expose the AIV facility
  KVM: s390: exploit GISA and AIV for emulated interrupts
  KVM: s390: abstract adapter interruption word generation from ISC
  KVM: s390: add GISA interrupts to FLIC ioctl interface
  KVM: s390: make kvm_s390_get_io_int() aware of GISA
  KVM: s390: activate GISA for emulated interrupts
  s390/sclp: expose the GISA format facility
  KVM: s390: introduce the format-1 GISA

 arch/s390/include/asm/bitops.h    |   5 +
 arch/s390/include/asm/css_chars.h |   4 +-
 arch/s390/include/asm/kvm_host.h  | 102 ++++++++++++-----
 arch/s390/include/asm/sclp.h      |   1 +
 arch/s390/kvm/interrupt.c         | 233 +++++++++++++++++++++++++++++++++-----
 arch/s390/kvm/kvm-s390.c          |  11 ++
 arch/s390/kvm/kvm-s390.h          |   7 ++
 drivers/s390/char/sclp_early.c    |   3 +-
 8 files changed, 302 insertions(+), 64 deletions(-)

-- 
2.13.4
