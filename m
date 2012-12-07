From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [RFC PATCH v4 0/8] s390: channel I/O support in qemu.
Date: Fri,  7 Dec 2012 13:50:18 +0100
Message-ID: <1354884626-15060-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
Cc: Carsten Otte <cotte@de.ibm.com>, Anthony Liguori <aliguori@us.ibm.com>, Gleb Natapov <gleb@redhat.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi,

just a quick dump of my qemu patch series for channel I/O.

I've managed to chop the virtual css patch into some smaller
chunks (patches 2-6), which are hopefully easier to review.

The virtio-ccw patch is still based upon the current virtio
infrastructure; I'll try to rebase it upon the virtio refactoring
once that has most of the infrastructure in place.

Cornelia Huck (8):
  Update linux headers.
  s390: Channel I/O basic defintions.
  s390: I/O interrupt and machine check injection.
  s390: Add channel I/O instructions.
  s390: Virtual channel subsystem support.
  s390: Wire up channel I/O in kvm.
  s390-virtio: Factor out some initialization code.
  s390: Add new channel I/O based virtio transport.

 hw/s390-virtio.c                     |  281 +++++---
 hw/s390x/Makefile.objs               |    2 +
 hw/s390x/css.c                       | 1195 ++++++++++++++++++++++++++++++++++
 hw/s390x/css.h                       |   92 +++
 hw/s390x/virtio-ccw.c                |  909 ++++++++++++++++++++++++++
 hw/s390x/virtio-ccw.h                |   81 +++
 linux-headers/asm-generic/kvm_para.h |    4 +
 linux-headers/asm-powerpc/kvm.h      |   59 ++
 linux-headers/asm-powerpc/kvm_para.h |    7 +-
 linux-headers/linux/kvm.h            |   36 +-
 target-s390x/Makefile.objs           |    2 +-
 target-s390x/cpu.h                   |  230 +++++++
 target-s390x/helper.c                |  145 +++++
 target-s390x/ioinst.c                |  726 +++++++++++++++++++++
 target-s390x/ioinst.h                |  223 +++++++
 target-s390x/kvm.c                   |  246 ++++++-
 trace-events                         |   18 +
 17 files changed, 4161 insertions(+), 95 deletions(-)
 create mode 100644 hw/s390x/css.c
 create mode 100644 hw/s390x/css.h
 create mode 100644 hw/s390x/virtio-ccw.c
 create mode 100644 hw/s390x/virtio-ccw.h
 create mode 100644 linux-headers/asm-generic/kvm_para.h
 create mode 100644 target-s390x/ioinst.c
 create mode 100644 target-s390x/ioinst.h

-- 
1.7.12.4
