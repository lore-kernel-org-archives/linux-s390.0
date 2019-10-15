Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50072 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbfJOK00 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Oct 2019 06:26:26 -0400
Date: Tue, 15 Oct 2019 12:26:07 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH V3 1/7] mdev: class id support
Message-ID: <20191015122607.126e3960.cohuck@redhat.com>
In-Reply-To: <20191011081557.28302-2-jasowang@redhat.com>
References: <20191011081557.28302-1-jasowang@redhat.com>
        <20191011081557.28302-2-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, alex.williamson@redhat.com, mst@redhat.com, tiwei.bie@intel.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com, freude@linux.ibm.com, lingshan.zhu@intel.com, idos@mellanox.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, christophe.de.dinechin@gmail.com, kevin.tian@intel.com

On Fri, 11 Oct 2019 16:15:51 +0800
Jason Wang <jasowang@redhat.com> wrote:

> Mdev bus only supports vfio driver right now, so it doesn't implement
> match method. But in the future, we may add drivers other than vfio,
> the first driver could be virtio-mdev. This means we need to add
> device class id support in bus match method to pair the mdev device
> and mdev driver correctly.
> 
> So this patch adds id_table to mdev_driver and class_id for mdev
> device with the match method for mdev bus.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  Documentation/driver-api/vfio-mediated-device.rst |  7 ++++++-
>  drivers/gpu/drm/i915/gvt/kvmgt.c                  |  1 +
>  drivers/s390/cio/vfio_ccw_ops.c                   |  1 +
>  drivers/s390/crypto/vfio_ap_ops.c                 |  1 +
>  drivers/vfio/mdev/mdev_core.c                     | 11 +++++++++++
>  drivers/vfio/mdev/mdev_driver.c                   | 14 ++++++++++++++
>  drivers/vfio/mdev/mdev_private.h                  |  1 +
>  drivers/vfio/mdev/vfio_mdev.c                     |  6 ++++++
>  include/linux/mdev.h                              |  8 ++++++++
>  include/linux/mod_devicetable.h                   |  8 ++++++++
>  samples/vfio-mdev/mbochs.c                        |  1 +
>  samples/vfio-mdev/mdpy.c                          |  1 +
>  samples/vfio-mdev/mtty.c                          |  1 +
>  13 files changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/vfio-mediated-device.rst b/Documentation/driver-api/vfio-mediated-device.rst
> index 25eb7d5b834b..2035e48da7b2 100644
> --- a/Documentation/driver-api/vfio-mediated-device.rst
> +++ b/Documentation/driver-api/vfio-mediated-device.rst
> @@ -102,12 +102,14 @@ structure to represent a mediated device's driver::
>        * @probe: called when new device created
>        * @remove: called when device removed
>        * @driver: device driver structure
> +      * @id_table: the ids serviced by this driver
>        */
>       struct mdev_driver {
>  	     const char *name;
>  	     int  (*probe)  (struct device *dev);
>  	     void (*remove) (struct device *dev);
>  	     struct device_driver    driver;
> +	     const struct mdev_class_id *id_table;
>       };
>  
>  A mediated bus driver for mdev should use this structure in the function calls
> @@ -165,12 +167,15 @@ register itself with the mdev core driver::
>  	extern int  mdev_register_device(struct device *dev,
>  	                                 const struct mdev_parent_ops *ops);
>  
> +It is also required to specify the class_id through::
> +
> +	extern int mdev_set_class(struct device *dev, u16 id);

Should the document state explicitly that this should be done in the
->create() callback? Also, I think that the class_id might be different
for different mdevs (even if the parent is the same) -- should that be
mentioned explicitly?

> +
>  However, the mdev_parent_ops structure is not required in the function call
>  that a driver should use to unregister itself with the mdev core driver::
>  
>  	extern void mdev_unregister_device(struct device *dev);
>  
> -
>  Mediated Device Management Interface Through sysfs
>  ==================================================
>  
(...)

Looks reasonable to me.
