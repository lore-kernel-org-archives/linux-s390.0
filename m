From: Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH RFC 0/2] vfio-ccw: support for {halt,clear} subchannel
Date: Wed,  9 May 2018 17:48:20 +0200
Message-ID: <20180509154822.23510-1-cohuck@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Hi,

this (RFC) is an initial stab at passing the halt and clear subchannel
operations to the host device. Today, host userspace is emulating
those two operations, but we really want to execute them on the host
device (e.g. for error recovery situations).

The nice thing about this approach is that is independent from userspace
changes: Unless userspace forwards halt/clear requests, we behave as
before. Conversely, userspace can simply try to submit halt/clear, and
old kernels will simply indicate that it is not supported.

This survives triggering clear subchannel in the guest (hacked in by
myself) together with an update QEMU (to be posted in a moment).

Obviously, this needs some more work. Better support for async handling
comes to mind. We probably also want to support other channel I/O
instructions.

Cornelia Huck (2):
  s390/cio: export hsch to modules
  vfio-ccw: support for halt/clear subchannel

 drivers/s390/cio/ioasm.c        |  1 +
 drivers/s390/cio/vfio_ccw_drv.c | 10 ++++-
 drivers/s390/cio/vfio_ccw_fsm.c | 94 ++++++++++++++++++++++++++++++++++++-----
 3 files changed, 93 insertions(+), 12 deletions(-)

-- 
2.14.3
