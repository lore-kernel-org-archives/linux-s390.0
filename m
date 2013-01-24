From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH v7 0/2] s390: virtio-ccw transport.
Date: Thu, 24 Jan 2013 16:28:59 +0100
Message-ID: <1359041341-26301-1-git-send-email-cornelia.huck@de.ibm.com>
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
Cc: Carsten Otte <cotte@de.ibm.com>, Anthony Liguori <aliguori@us.ibm.com>, Gleb Natapov <gleb@redhat.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
List-ID: <linux-s390.vger.kernel.org>

Hi,

here's the next iteration of virtio-ccw and s390-ccw-virtio
support, with comments addressed and rebased against s390-next.

Cornelia Huck (2):
  s390: Add new channel I/O based virtio transport.
  s390: Add s390-ccw-virtio machine.

 hw/s390-virtio.h           |   1 +
 hw/s390x/Makefile.objs     |   2 +
 hw/s390x/s390-virtio-ccw.c | 134 +++++++
 hw/s390x/virtio-ccw.c      | 966 +++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/virtio-ccw.h      |  98 +++++
 trace-events               |   4 +
 6 files changed, 1205 insertions(+)
 create mode 100644 hw/s390x/s390-virtio-ccw.c
 create mode 100644 hw/s390x/virtio-ccw.c
 create mode 100644 hw/s390x/virtio-ccw.h

-- 
1.7.12.4
