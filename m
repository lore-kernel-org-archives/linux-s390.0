From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [RFC PATCH v2 0/5] qemu: s390: virtual css and virtio-ccw.
Date: Tue,  4 Sep 2012 17:13:48 +0200
Message-ID: <1346771633-53081-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi,

here's the second version of virtual channel I/O and the new virtio-ccw
transport.

Changes to the first version include coding style fixes, changes in the
organization of objects (not quite finished yet), adaptions to changes
in the kernel interface and implementation of the improved virtio-ccw
primitives.

Cornelia Huck (5):
  Update headers for upcoming s390 changes.
  s390: Virtual channel subsystem support.
  s390: Add new channel I/O based virtio transport.
  s390: Virtual channel subsystem support for !KVM.
  [HACK] Handle multiple virtio aliases.

 blockdev.c                           |    6 +-
 hw/qdev-monitor.c                    |   90 ++-
 hw/s390-virtio.c                     |  277 ++++++--
 hw/s390x/Makefile.objs               |    2 +
 hw/s390x/css.c                       | 1280 ++++++++++++++++++++++++++++++++++
 hw/s390x/css.h                       |   89 +++
 hw/s390x/virtio-ccw.c                |  875 +++++++++++++++++++++++
 hw/s390x/virtio-ccw.h                |   79 +++
 linux-headers/asm-generic/kvm_para.h |    5 +
 linux-headers/asm-x86/kvm.h          |    1 +
 linux-headers/linux/kvm.h            |   80 ++-
 target-s390x/Makefile.objs           |    2 +-
 target-s390x/cpu.h                   |  277 ++++++++
 target-s390x/helper.c                |  140 ++++
 target-s390x/ioinst.c                |  734 +++++++++++++++++++
 target-s390x/ioinst.h                |  206 ++++++
 target-s390x/kvm.c                   |  282 +++++++-
 target-s390x/op_helper.c             |   22 +-
 vl.c                                 |    7 +-
 19 files changed, 4313 insertions(+), 141 deletions(-)
 create mode 100644 hw/s390x/css.c
 create mode 100644 hw/s390x/css.h
 create mode 100644 hw/s390x/virtio-ccw.c
 create mode 100644 hw/s390x/virtio-ccw.h
 create mode 100644 linux-headers/asm-generic/kvm_para.h
 create mode 100644 target-s390x/ioinst.c
 create mode 100644 target-s390x/ioinst.h

-- 
1.7.11.5
