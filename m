From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [RFC PATCH 0/5] qemu: s390: virtual css and virtio-ccw
Date: Tue,  7 Aug 2012 16:52:48 +0200
Message-ID: <1344351173-2716-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi,

following are the qemu parts for supporting virtual channel I/O
and the new virtio-ccw transport.

Patch 1 pulls in the new interface definitions.

Patch 2 contains the ground work for supporting virtual subchannels
(kvm only).

Patch 3 implements the new virtio-ccw transport.

Patch 4 makes virtual subchannels available for !kvm as well. Note
that this patch is completely untested; it basically contains my
initial channel subsystem code before I moved most of it into the
kernel.

Patch 5 is a hack needed to make virtio-ccw work with the alias stuff
for now. The correct solution is to rework the virtio layering as
has been proposed for virtio-mmio (see
http://comments.gmane.org/gmane.comp.emulators.qemu/148224).

The patches still have some TODOs in them (but nothing major), and
likely some things need to be done differently. I hope, however,
that the architectural part is fine.

Cornelia Huck (5):
  Update headers for upcoming s390 changes.
  s390: Virtual channel subsystem support.
  s390: Add new channel I/O based virtio transport.
  s390: Virtual channel subsystem support for !KVM.
  [HACK] Handle multiple virtio aliases.

 blockdev.c                        |    6 +-
 hw/qdev-monitor.c                 |   90 +--
 hw/s390-virtio.c                  |  268 ++++++---
 hw/s390x/Makefile.objs            |    2 +
 hw/s390x/css.c                    | 1202 +++++++++++++++++++++++++++++++++++++
 hw/s390x/css.h                    |   89 +++
 hw/s390x/virtio-ccw.c             |  962 +++++++++++++++++++++++++++++
 hw/s390x/virtio-ccw.h             |   77 +++
 linux-headers/asm-s390/kvm.h      |    2 +-
 linux-headers/asm-s390/kvm_para.h |    2 +-
 linux-headers/linux/kvm.h         |   63 ++
 target-s390x/Makefile.objs        |    2 +-
 target-s390x/cpu.h                |  261 ++++++++
 target-s390x/helper.c             |  140 +++++
 target-s390x/ioinst.c             |  734 ++++++++++++++++++++++
 target-s390x/ioinst.h             |  206 +++++++
 target-s390x/kvm.c                |  265 +++++++-
 target-s390x/op_helper.c          |   22 +-
 vl.c                              |    7 +-
 19 files changed, 4260 insertions(+), 140 deletions(-)
 create mode 100644 hw/s390x/css.c
 create mode 100644 hw/s390x/css.h
 create mode 100644 hw/s390x/virtio-ccw.c
 create mode 100644 hw/s390x/virtio-ccw.h
 create mode 100644 target-s390x/ioinst.c
 create mode 100644 target-s390x/ioinst.h

-- 
1.7.11.4
