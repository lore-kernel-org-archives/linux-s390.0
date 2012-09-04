From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [RFC PATCH v2 0/7] s390: virtual css host support.
Date: Tue,  4 Sep 2012 17:13:23 +0200
Message-ID: <1346771610-52423-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi,

here's the second revision of the virtual channel subsystem support for
s390.

I changed the representation of the channel subsystem, introducing channel
subsystem images, which brings it closer to the actual implementation. A
new ioctl for adding a new channel subsystem image has also been introduced.

Cornelia Huck (7):
  s390/kvm: Support for I/O interrupts.
  s390/kvm: Add support for machine checks.
  s390/kvm: In-kernel handling of I/O instructions.
  s390: Move css limits from drivers/s390/cio/ to include/asm/.
  s390: Make some css-related structures usable by non-cio code.
  s390/kvm: Base infrastructure for enabling capabilities.
  s390/kvm: In-kernel channel subsystem support.

 Documentation/virtual/kvm/api.txt | 155 +++++-
 arch/s390/include/asm/cio.h       |   2 +
 arch/s390/include/asm/kvm_host.h  |  63 +++
 arch/s390/include/asm/orb.h       |  69 +++
 arch/s390/include/asm/schib.h     |  52 ++
 arch/s390/kvm/Makefile            |   2 +-
 arch/s390/kvm/css.c               | 989 ++++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/intercept.c         |  22 +-
 arch/s390/kvm/interrupt.c         | 337 +++++++++++--
 arch/s390/kvm/ioinst.c            | 797 ++++++++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.c          |  70 +++
 arch/s390/kvm/kvm-s390.h          |  43 ++
 arch/s390/kvm/priv.c              | 194 +++++++-
 arch/s390/kvm/trace-s390.h        |  73 ++-
 arch/s390/kvm/trace.h             |  22 +
 drivers/s390/cio/cio.h            |  46 +-
 drivers/s390/cio/css.h            |   3 -
 drivers/s390/cio/io_sch.h         |   2 +-
 drivers/s390/cio/ioasm.h          |   2 +-
 drivers/s390/cio/orb.h            |  67 ---
 include/linux/kvm.h               |  67 +++
 include/trace/events/kvm.h        |   2 +-
 virt/kvm/kvm_main.c               |   3 +-
 23 files changed, 2908 insertions(+), 174 deletions(-)
 create mode 100644 arch/s390/include/asm/orb.h
 create mode 100644 arch/s390/include/asm/schib.h
 create mode 100644 arch/s390/kvm/css.c
 create mode 100644 arch/s390/kvm/ioinst.c
 delete mode 100644 drivers/s390/cio/orb.h

-- 
1.7.11.5
