From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH v6 00/11] s390: channel I/O support in qemu.
Date: Thu, 24 Jan 2013 13:28:00 +0100
Message-ID: <1359030491-46725-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
List-ID: <linux-s390.vger.kernel.org>

Hi,

another round for virtual channel I/O in qemu.

The patches have been respun against current master; changelogs
are in the patches themselves.

Changes are mostly some cleanups; of note are the preparations
for VirtioBus and some changes for making the code endianness
aware.

Making s390-ccw-virtio the default machine has been deferred until
after tcg support is available.

Alexander Graf (1):
  s390: Add default support for SCLP console

Cornelia Huck (10):
  s390: Lowcore mapping helper.
  s390: Add mapping helper functions.
  s390: Channel I/O basic definitions.
  s390: I/O interrupt and machine check injection.
  s390: Add channel I/O instructions.
  s390: Virtual channel subsystem support.
  s390: Wire up channel I/O in kvm.
  s390: Add new channel I/O based virtio transport.
  s390-virtio: Factor out some initialization code.
  s390: Add s390-ccw-virtio machine.

 hw/boards.h                |    1 +
 hw/s390-virtio.c           |  118 ++--
 hw/s390-virtio.h           |    6 +
 hw/s390x/Makefile.objs     |    3 +
 hw/s390x/css.c             | 1277 ++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/css.h             |   99 ++++
 hw/s390x/s390-virtio-ccw.c |  134 +++++
 hw/s390x/virtio-ccw.c      |  947 ++++++++++++++++++++++++++++++++
 hw/s390x/virtio-ccw.h      |   94 ++++
 target-s390x/Makefile.objs |    2 +-
 target-s390x/cpu.h         |  247 ++++++++-
 target-s390x/helper.c      |  200 ++++++-
 target-s390x/ioinst.c      |  752 ++++++++++++++++++++++++++
 target-s390x/ioinst.h      |  223 ++++++++
 target-s390x/kvm.c         |  239 ++++++++-
 trace-events               |   18 +
 vl.c                       |   48 ++
 17 files changed, 4333 insertions(+), 75 deletions(-)
 create mode 100644 hw/s390x/css.c
 create mode 100644 hw/s390x/css.h
 create mode 100644 hw/s390x/s390-virtio-ccw.c
 create mode 100644 hw/s390x/virtio-ccw.c
 create mode 100644 hw/s390x/virtio-ccw.h
 create mode 100644 target-s390x/ioinst.c
 create mode 100644 target-s390x/ioinst.h

-- 
1.7.12.4
