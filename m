From: Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 0/3] vfio-ccw: support hsch/csch (kernel part)
Date: Thu, 22 Nov 2018 17:54:29 +0100
Message-ID: <20181122165432.4437-1-cohuck@redhat.com>
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
List-ID: <linux-s390.vger.kernel.org>

[This is the Linux kernel part, git tree is available at
https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git vfio-ccw-caps

The companion QEMU patches are available at
https://github.com/cohuck/qemu vfio-ccw-caps]

Currently, vfio-ccw only relays START SUBCHANNEL requests to the real
device. This tends to work well for the most common 'good path' scenarios;
however, as we emulate {HALT,CLEAR} SUBCHANNEL in QEMU, things like
clearing pending requests at the device is currently not supported.
This may be a problem for e.g. error recovery.

This patch series introduces capabilities (similar to what vfio-pci uses)
and exposes a new async region for handling hsch/csch.

Very lightly tested (I can interact with a dasd as before; I have not
found a reliable way to trigger hsch/csch in the Linux dasd guest driver.)

Cornelia Huck (3):
  vfio-ccw: add capabilities chain
  s390/cio: export hsch to modules
  vfio-ccw: add handling for asnyc channel instructions

 drivers/s390/cio/Makefile           |   3 +-
 drivers/s390/cio/ioasm.c            |   1 +
 drivers/s390/cio/vfio_ccw_async.c   |  88 +++++++++++++
 drivers/s390/cio/vfio_ccw_drv.c     |  48 +++++--
 drivers/s390/cio/vfio_ccw_fsm.c     | 158 +++++++++++++++++++++-
 drivers/s390/cio/vfio_ccw_ops.c     | 195 ++++++++++++++++++++++++----
 drivers/s390/cio/vfio_ccw_private.h |  44 +++++++
 include/uapi/linux/vfio.h           |   5 +
 include/uapi/linux/vfio_ccw.h       |  12 ++
 9 files changed, 509 insertions(+), 45 deletions(-)
 create mode 100644 drivers/s390/cio/vfio_ccw_async.c

-- 
2.17.2
