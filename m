From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [RFC PATCH v3 0/3] s390: channel I/O support in qemu.
Date: Wed, 31 Oct 2012 17:24:45 +0100
Message-ID: <1351700688-42353-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi,

here's the latest version of my patchset introducing virtio-ccw.

This has been reworked with the changed kernel interface: qemu
will now handle all channel I/O requests (except the I/O interrupt
related ones that are handled in-kernel in the kvm case). This
avoids duplicating code in qemu and in kvm.

There are some misc fixes as well (mainly related to virtio-ccw).
Use of mutexes has hopefully been exorcised for now.

Unfortuately, patch 2 is now rather large - but I couldn't think
of a good way to split it up.

I still know of various things that need looking into (memory
accesses, for one), but I'd like some feedback about the new
interface first.

Cornelia Huck (3):
  Update linux headers.
  s390: Virtual channel subsystem support.
  s390: Add new channel I/O based virtio transport.

 hw/s390-virtio.c                     |  282 ++++++--
 hw/s390x/Makefile.objs               |    2 +
 hw/s390x/css.c                       | 1209 ++++++++++++++++++++++++++++++++++
 hw/s390x/css.h                       |   90 +++
 hw/s390x/virtio-ccw.c                |  904 +++++++++++++++++++++++++
 hw/s390x/virtio-ccw.h                |   81 +++
 linux-headers/asm-generic/kvm_para.h |    5 +
 linux-headers/asm-powerpc/kvm.h      |   59 ++
 linux-headers/asm-powerpc/kvm_para.h |    7 +-
 linux-headers/asm-x86/kvm.h          |   17 +
 linux-headers/linux/kvm.h            |   61 +-
 target-s390x/Makefile.objs           |    2 +-
 target-s390x/cpu.h                   |  232 +++++++
 target-s390x/helper.c                |  146 ++++
 target-s390x/ioinst.c                |  737 +++++++++++++++++++++
 target-s390x/ioinst.h                |  213 ++++++
 target-s390x/kvm.c                   |  251 ++++++-
 target-s390x/misc_helper.c           |    6 +-
 18 files changed, 4204 insertions(+), 100 deletions(-)
 create mode 100644 hw/s390x/css.c
 create mode 100644 hw/s390x/css.h
 create mode 100644 hw/s390x/virtio-ccw.c
 create mode 100644 hw/s390x/virtio-ccw.h
 create mode 100644 linux-headers/asm-generic/kvm_para.h
 create mode 100644 target-s390x/ioinst.c
 create mode 100644 target-s390x/ioinst.h

-- 
1.7.12.4
