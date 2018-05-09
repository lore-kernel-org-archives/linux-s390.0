From: Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH RFC 0/2] vfio-ccw: exploit halt/clear subchannel support
Date: Wed,  9 May 2018 17:49:08 +0200
Message-ID: <20180509154910.23578-1-cohuck@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Hi,

this is the QEMU companion patchset to "vfio-ccw: support for {halt,clear}
subchannel", but is interface-wise independent of it.

With an old host kernel, things should work as before. With a new host
kernel, guest halt/clear requests should get passed through to the host.

I tested this with a hacked-up guest kernel to issue clears on demand.

Cornelia Huck (2):
  vfio-ccw: forward halt/clear to device if supported
  s390/css: add some tracing for pass-through handling

 hw/s390x/css.c         | 38 ++++++++++++++++++++++++++++++++++----
 hw/s390x/trace-events  |  4 ++++
 hw/vfio/ccw.c          | 11 +++++++++--
 include/hw/s390x/css.h | 10 +++++++---
 4 files changed, 54 insertions(+), 9 deletions(-)

-- 
2.14.3
