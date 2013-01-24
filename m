From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH v8 0/2] s390: virtio-ccw transport.
Date: Thu, 24 Jan 2013 17:08:54 +0100
Message-ID: <1359043736-6203-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
List-ID: <linux-s390.vger.kernel.org>

Hi,

patches against s390-next again, with coding style fixes.

Cornelia Huck (2):
  s390: Add new channel I/O based virtio transport.
  s390: Add s390-ccw-virtio machine.

 hw/s390-virtio.h           |   1 +
 hw/s390x/Makefile.objs     |   2 +
 hw/s390x/s390-virtio-ccw.c | 134 +++++++
 hw/s390x/virtio-ccw.c      | 960 +++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/virtio-ccw.h      |  98 +++++
 trace-events               |   4 +
 6 files changed, 1199 insertions(+)
 create mode 100644 hw/s390x/s390-virtio-ccw.c
 create mode 100644 hw/s390x/virtio-ccw.c
 create mode 100644 hw/s390x/virtio-ccw.h

-- 
1.7.12.4
