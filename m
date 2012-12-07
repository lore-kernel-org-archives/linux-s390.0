From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH v4 0/5] s390: Host support for channel I/O.
Date: Fri,  7 Dec 2012 13:30:20 +0100
Message-ID: <1354883425-38531-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
Cc: Avi Kivity <avi.kivity@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi,

here are the host support patches for virtual channel I/O,
rebased against kvm/next.

Changes from v3:
- Corrected a wrong bitmask in machine check handling.
- Added Marcelo's Reviewed-by:

Please consider these patches for kvm/next.

Cornelia Huck (5):
  KVM: s390: Support for I/O interrupts.
  KVM: s390: Add support for machine checks.
  KVM: s390: In-kernel handling of I/O instructions.
  KVM: s390: Base infrastructure for enabling capabilities.
  KVM: s390: Add support for channel I/O instructions.

 Documentation/virtual/kvm/api.txt |  40 +++++-
 arch/s390/include/asm/kvm_host.h  |  11 ++
 arch/s390/kvm/intercept.c         |  22 ++-
 arch/s390/kvm/interrupt.c         | 264 +++++++++++++++++++++++++++++++++++-
 arch/s390/kvm/kvm-s390.c          |  38 ++++++
 arch/s390/kvm/kvm-s390.h          |   6 +
 arch/s390/kvm/priv.c              | 275 +++++++++++++++++++++++++++++++++++---
 arch/s390/kvm/trace-s390.h        |  26 +++-
 include/trace/events/kvm.h        |   2 +-
 include/uapi/linux/kvm.h          |  18 +++
 10 files changed, 673 insertions(+), 29 deletions(-)

-- 
1.7.12.4
