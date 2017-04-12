From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH v5 00/13] basic channel IO passthrough infrastructure based on vfio
Date: Wed, 12 Apr 2017 07:21:02 +0200
Message-ID: <20170412052115.101657-1-bjsdjshi@linux.vnet.ibm.com>
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
    -machine s390-ccw-virtio(,s390-squash-mcss=on|off) \
    -device vfio-ccw,sysfsdev=$MDEV_PATH
  We want to support real (i.e. not virtual) channel devices even for
  guests that do not support MCSS-E (where guests may see devices from
  any channel subsystem image at once). As all virtio-ccw devices are in
  css 0xfe (and show up in the default css 0 for guests not activating
  MCSS-E), we need an option to squash e.g. passed-through channel devices
  from their real css (0-3, or 0 for hosts not activating MCSS-E) into
  the default css, that is what the new machine option s390-squash-css is
  added.

Build and install:
1. kernel configuration
  CONFIG_S390_CCW_IOMMU=m
  CONFIG_VFIO=m
  CONFIG_VFIO_MDEV=m
  CONFIG_VFIO_MDEV_DEVICE=m
  CONFIG_VFIO_CCW=m
2. modules required
  modprobe vfio.ko
  modprobe mdev.ko
  modprobe vfio_mdev.ko
  modprobe vfio_iommu_type1.ko
  modprobe vfio_ccw.ko
3. find a subchannel(0.0."%schid") of a DASD-ECKD device and bind it to
  vfio_ccw driver
  #find the dasd you can use with lsdasd on your host. e.g.:
  devno="7e52"
  schid="16ca"
  #unbind the ccw device from the subchannel
  echo 0.0."$devno" > /sys/bus/ccw/devices/0.0."$devno"/driver/unbind
  #unbind the subchannel from io_subchannel driver
  echo 0.0."$schid" > /sys/bus/css/devices/0.0."$schid"/driver/unbind
  #bind the subchannel with vfio_ccw driver
  echo 0.0."$schid" > /sys/bus/css/drivers/vfio_ccw/bind
4. create a mediated device
  #generate a uuid with uuidgen. e.g.:
  uuid="6dfd3ec5-e8b3-4e18-a6fe-57bc9eceb920"
  echo "$uuid" > \
  /sys/bus/css/devices/0.0."$schid"/mdev_supported_types/vfio_ccw-io/create
5. pass-through this device to a vm
  -M s390-ccw-virtio,s390-squash-css=on \
  -device vfio-ccw,sysfsdev=/sys/bus/mdev/devices/$uuid \
  ... ...

Change log:
v4 -> v5:
1. Rebase to git://github.com/cohuck/qemu s390-next.
2. New patch #1: update-linux-headers.
3. Patch #6: update s390_ccw_realize according to the new code base.
4. New patch #13: add maintainer for vfio-ccw.

v3 -> v4:
1. Adjustments of the s-o-b chains for some patches.

v2 -> v3:
1. Move vfio_ccw.h to uapi.
2. Adopt the vfio-ccw cmdline interface as vfio-pci with mdev devices.
3. Rename s390-map-css to s390-squash-mcss (patch 2), and update devno
   generation method (patch 5).
4. Patch 7: correct the validation of num_regions.
5. Patch 8: correct the validation of num_irqs.

v1 -> v2:
1. Rebase the implementation to the mdev framework approach.
2. Use pread and pwrite on an I/O region to issue I/O requests and
   receive results.

Dong Jia Shi (8):
  update-linux-headers: update for vfio-ccw
  vfio: linux-headers update for vfio-ccw
  s390x/css: realize css_create_sch
  s390x/css: device support for s390-ccw passthrough
  vfio/ccw: get io region info
  vfio/ccw: get irqs info and set the eventfd fd
  vfio/ccw: update sense data if a unit check is pending
  MAINTAINERS: Add vfio-ccw maintainer

Xiao Feng Ren (5):
  s390x/css: add s390-squash-mcss machine option
  s390x/css: realize css_sch_build_schib
  vfio/ccw: vfio based subchannel passthrough driver
  s390x/css: introduce and realize ccw-request callback
  s390x/css: ccw translation infrastructure

 MAINTAINERS                        |   5 +
 default-configs/s390x-softmmu.mak  |   1 +
 hw/s390x/Makefile.objs             |   1 +
 hw/s390x/css-bridge.c              |   2 +
 hw/s390x/css.c                     | 290 ++++++++++++++++++++++--
 hw/s390x/s390-ccw.c                | 146 ++++++++++++
 hw/s390x/s390-ccw.h                |  39 ++++
 hw/s390x/s390-virtio-ccw.c         |  35 ++-
 hw/s390x/virtio-ccw.c              |   7 +-
 hw/vfio/Makefile.objs              |   1 +
 hw/vfio/ccw.c                      | 441 +++++++++++++++++++++++++++++++++++++
 include/hw/s390x/css-bridge.h      |   1 +
 include/hw/s390x/css.h             |  67 +++---
 include/hw/s390x/s390-virtio-ccw.h |   1 +
 include/hw/vfio/vfio-common.h      |   1 +
 linux-headers/linux/vfio.h         |  17 ++
 linux-headers/linux/vfio_ccw.h     |  28 +++
 qemu-options.hx                    |   6 +-
 scripts/update-linux-headers.sh    |   2 +-
 target/s390x/cpu.h                 |  10 +
 target/s390x/ioinst.c              |   9 +
 21 files changed, 1061 insertions(+), 49 deletions(-)
 create mode 100644 hw/s390x/s390-ccw.c
 create mode 100644 hw/s390x/s390-ccw.h
 create mode 100644 hw/vfio/ccw.c
 create mode 100644 linux-headers/linux/vfio_ccw.h

-- 
2.10.2
