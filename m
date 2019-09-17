Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfIQRbf (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 17 Sep 2019 13:31:35 -0400
Date: Tue, 17 Sep 2019 11:31:25 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC PATCH 0/2] Mdev: support mutiple kinds of devices
Message-ID: <20190917113125.6b2970e5@x1.home>
In-Reply-To: <20190912094012.29653-1-jasowang@redhat.com>
References: <20190912094012.29653-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, mst@redhat.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch, cohuck@redhat.com, farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com, pmorel@linux.ibm.com, freude@linux.ibm.com, tiwei.bie@intel.com, virtualization@lists.linux-foundation.org, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, idos@mellanox.com, xiao.w.wang@intel.com, lingshan.zhu@intel.com, Parav Pandit <parav@mellanox.com>

[cc +Parav]

On Thu, 12 Sep 2019 17:40:10 +0800
Jason Wang <jasowang@redhat.com> wrote:

> Hi all:
> 
> During the development of virtio-mdev[1]. I find that mdev needs to be
> extended to support devices other than vfio mdev device. So this
> series tries to extend the mdev to be able to differ from different
> devices by:
> 
> - device id and matching for mdev bus
> - device speicfic callbacks and move vfio callbacks there
> 
> Sent for early reivew, compile test only!
> 
> Thanks
> 
> [1] https://lkml.org/lkml/2019/9/10/135

I expect Parav must have something similar in the works for their
in-kernel networking mdev support.  Link to discussion so far:

https://lore.kernel.org/kvm/20190912094012.29653-1-jasowang@redhat.com/T/#t

Thanks,
Alex


> Jason Wang (2):
>   mdev: device id support
>   mdev: introduce device specific ops
> 
>  drivers/gpu/drm/i915/gvt/kvmgt.c  | 16 ++++---
>  drivers/s390/cio/vfio_ccw_ops.c   | 16 ++++---
>  drivers/s390/crypto/vfio_ap_ops.c | 13 ++++--
>  drivers/vfio/mdev/mdev_core.c     | 14 +++++-
>  drivers/vfio/mdev/mdev_driver.c   | 14 ++++++
>  drivers/vfio/mdev/mdev_private.h  |  1 +
>  drivers/vfio/mdev/vfio_mdev.c     | 36 ++++++++++-----
>  include/linux/mdev.h              | 76 +++++++++++++++++++------------
>  include/linux/mod_devicetable.h   |  6 +++
>  samples/vfio-mdev/mbochs.c        | 18 +++++---
>  samples/vfio-mdev/mdpy.c          | 18 +++++---
>  samples/vfio-mdev/mtty.c          | 16 ++++---
>  12 files changed, 163 insertions(+), 81 deletions(-)
> 
