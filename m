From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [RFC PATCH 0/7] s390: virtual css host support.
Date: Tue,  7 Aug 2012 16:52:12 +0200
Message-ID: <1344351139-1793-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi,

the following patches implement support for a virtual channel
subsystem in the host (virtio-ccw on the host is handled by
user space).

Patches 1 and 2 add support for injecting I/O interrupts and
(some) machine checks via the already existing mechanisms.
The most important parts are those handling interrupt delivery.

Patch 3 prepares for in-kernel handling of I/O instructions.

Patches 4 and 5 make it possible for kvm to re-use some css-related
definitions already used by the s390 common I/O layer.

Patch 6 introduces the interface to dynamically enable capabilities
already in use on ppc to s390.

Patch 7 (the big one) adds in-kernel implementations of most I/O
instructions (leaving out some facilities that were too complex and
are not currently needed; these can convieniently be marked as
not supported). Some operations (which are executed asynchronically
on real hardware) are outsourced to user space. This in-kernel
channel subsystem support can be enabled by user space via a new
capability.

Cornelia Huck (7):
  s390/kvm: Support for I/O interrupts.
  s390/kvm: Add support for machine checks.
  s390/kvm: In-kernel handling of I/O instructions.
  s390: Move css limits from drivers/s390/cio/ to include/asm/.
  s390: Make some css-related structures usable by non-cio code.
  s390/kvm: Base infrastructure for enabling capabilities.
  s390/kvm: In-kernel channel subsystem support.

 Documentation/virtual/kvm/api.txt | 129 +++++-
 arch/s390/include/asm/cio.h       |   2 +
 arch/s390/include/asm/kvm_host.h  |  58 +++
 arch/s390/include/asm/orb.h       |  69 +++
 arch/s390/include/asm/schib.h     |  52 +++
 arch/s390/kvm/Makefile            |   2 +-
 arch/s390/kvm/css.c               | 945 ++++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/intercept.c         |  22 +-
 arch/s390/kvm/interrupt.c         | 337 ++++++++++++--
 arch/s390/kvm/ioinst.c            | 797 ++++++++++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.c          |  61 +++
 arch/s390/kvm/kvm-s390.h          |  42 ++
 arch/s390/kvm/priv.c              | 194 +++++++-
 arch/s390/kvm/trace-s390.h        |  73 ++-
 arch/s390/kvm/trace.h             |  22 +
 drivers/s390/cio/cio.h            |  46 +-
 drivers/s390/cio/css.h            |   3 -
 drivers/s390/cio/io_sch.h         |   2 +-
 drivers/s390/cio/ioasm.h          |   2 +-
 drivers/s390/cio/orb.h            |  67 ---
 include/linux/kvm.h               |  60 +++
 include/trace/events/kvm.h        |   2 +-
 virt/kvm/kvm_main.c               |   3 +-
 23 files changed, 2816 insertions(+), 174 deletions(-)
 create mode 100644 arch/s390/include/asm/orb.h
 create mode 100644 arch/s390/include/asm/schib.h
 create mode 100644 arch/s390/kvm/css.c
 create mode 100644 arch/s390/kvm/ioinst.c
 delete mode 100644 drivers/s390/cio/orb.h

-- 
1.7.11.4
