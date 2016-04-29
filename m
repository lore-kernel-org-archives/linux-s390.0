From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
Subject: [PATCH RFC 0/9] basic channel IO passthrough infrastructure based on vfio
Date: Fri, 29 Apr 2016 14:13:14 +0200
Message-ID: <1461932003-23830-1-git-send-email-renxiaof@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com
List-ID: <linux-s390.vger.kernel.org>

The patch series introduce a basic channel I/O passthrough
infrastructure based on vfio.
- Focus on supporting dasd-eckd(cu_type/dev_type = 0x3990/0x3390) as
  the target device. 
- Support new qemu parameters in the style of:
   "-machine s390-ccw-virtio(,s390-map-css=on|off) ... 
    -device vfio-ccw,id=xx,hostid=xx(,guestid=xx)".
  We want to support real (i.e. not virtual) channel devices even for
  guests that do not support MCSS-E (where guests may see devices from
  any channel subsystem image at once). As all virtio-ccw devices are in
  css 0xfe (and show up in the default css 0 for guests not activating
  MCSS-E), we need an option to map e.g. passed-through channel devices
  from their real css (0-3, or 0 for hosts not activating MCSS-E) into
  the default css, that is what the new machine option s390-map-css is
  added.
- According to the user-space ccw format, which was introduced by the
  vfio-ccw patches of the kernel part, assemble the ccw program in qemu.
  This 'ccw program' would then be transported to the kernel via a
  dedicated ioctl for further processing(e.g. translation in kernel
  space), and issuing it to the real device.
  Overview of the user-space ccw translation(translate 'guest ccw
  program' to 'user-space ccw program'):
  1. Allocate a 4K memory buffer in user-space to store all of the ccw
     program information.
     * Lower 2k of the buffer are used to store a maximum of 256 ccws.
       These ccws are copied from 'guest ccw program' and placed one
       after another.
     * Upper 2k of the buffer are used to store a maximum of 256
       corresponding cda data sets, each having a length of 8 bytes.
  2. For TIC ccw.
     * Locate the TIC target ccw inside the ccw area, and calculate its
       offset.
     * Store the offset to ccw.cda.
  3. For Direct ccw.
     * Find the cda entry with the same index as the ccw.
     * Store the user virtual address of the original ccw.cda to the cda
       entry.
     * Store the offset of the cda entry to ccw.cda.
  4. For IDAL ccw.
     * Find the cda entry with the same index as the ccw.
     * Prepare the user-space idaws. Store the virtual address of the
       idaws to the cda entry.
     * Store the offset of the cda entry to ccw.cda.
  5. Append a NOOP to the chain end.
  6. Expectations for the user-space ccw program I/O result:
     CPA of SCSW should be set to the offset of the ccw area of the
     current ccw.

Xiao Feng Ren (9):
  vfio: linux-headers update for vfio-ccw
  vfio: No-IOMMU mode support
  s390x/css: introduce ccw chain interfaces
  s390x/css: add s390-map-css machine option
  s390x/css: realize css_sch_build_schib
  s390x/css: device and bus support for s390-ccw passthrough
  vfio/ccw: vfio based ccw passthrough driver
  s390x/css: introduce and realize ccw-request callback
  s390x/css: ccws translation infrastructure

 default-configs/s390x-softmmu.mak  |   1 +
 hw/s390x/Makefile.objs             |   1 +
 hw/s390x/css.c                     | 283 ++++++++++++++++++++++--
 hw/s390x/css.h                     |  12 +
 hw/s390x/s390-ccw-bus.c            | 114 ++++++++++
 hw/s390x/s390-ccw-bus.h            |  30 +++
 hw/s390x/s390-ccw.c                | 189 ++++++++++++++++
 hw/s390x/s390-ccw.h                |  41 ++++
 hw/s390x/s390-ccwchain.c           | 441 +++++++++++++++++++++++++++++++++++++
 hw/s390x/s390-ccwchain.h           |  28 +++
 hw/s390x/s390-virtio-ccw.c         |  26 +++
 hw/s390x/virtio-ccw.c              |   1 +
 hw/s390x/virtio-ccw.h              |   2 -
 hw/vfio/Makefile.objs              |   1 +
 hw/vfio/ccw.c                      | 230 +++++++++++++++++++
 hw/vfio/common.c                   |  66 ++++--
 include/hw/s390x/s390-virtio-ccw.h |   1 +
 include/hw/vfio/vfio-common.h      |   3 +
 linux-headers/linux/vfio.h         |  32 +++
 qemu-options.hx                    |   6 +-
 target-s390x/cpu.h                 |  10 +
 target-s390x/ioinst.c              |   9 +
 22 files changed, 1493 insertions(+), 34 deletions(-)
 create mode 100644 hw/s390x/s390-ccw-bus.c
 create mode 100644 hw/s390x/s390-ccw-bus.h
 create mode 100644 hw/s390x/s390-ccw.c
 create mode 100644 hw/s390x/s390-ccw.h
 create mode 100644 hw/s390x/s390-ccwchain.c
 create mode 100644 hw/s390x/s390-ccwchain.h
 create mode 100644 hw/vfio/ccw.c

-- 
2.6.6
