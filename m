Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:37972 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfKSDI7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 18 Nov 2019 22:08:59 -0500
Subject: Re: [PATCH V13 1/6] mdev: make mdev bus agnostic
References: <20191118105923.7991-1-jasowang@redhat.com>
 <20191118105923.7991-2-jasowang@redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <61f6a20c-3492-4144-9c7c-f62200718853@infradead.org>
Date: Mon, 18 Nov 2019 19:08:41 -0800
MIME-Version: 1.0
In-Reply-To: <20191118105923.7991-2-jasowang@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, alex.williamson@redhat.com, mst@redhat.com, tiwei.bie@intel.com, gregkh@linuxfoundation.org, jgg@mellanox.com
Cc: netdev@vger.kernel.org, cohuck@redhat.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com, freude@linux.ibm.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, christophe.de.dinechin@gmail.com, kevin.tian@intel.com, stefanha@redhat.com, hch@infradead.org, aadam@redhat.com, jakub.kicinski@netronome.com, jiri@mellanox.com, jeffrey.t.kirsher@intel.com

On 11/18/19 2:59 AM, Jason Wang wrote:
> diff --git a/drivers/vfio/mdev/Kconfig b/drivers/vfio/mdev/Kconfig
> index 5da27f2100f9..2e07ca915a96 100644
> --- a/drivers/vfio/mdev/Kconfig
> +++ b/drivers/vfio/mdev/Kconfig
> @@ -1,15 +1,24 @@
> -# SPDX-License-Identifier: GPL-2.0-only
>  
> -config VFIO_MDEV
> +config MDEV
>  	tristate "Mediated device driver framework"
> -	depends on VFIO
>  	default n
>  	help
>  	  Provides a framework to virtualize devices.
> -	  See Documentation/driver-api/vfio-mediated-device.rst for more details.
>  
>  	  If you don't know what do here, say N.
>  

Hi,

> +config VFIO_MDEV
> +	tristate "VFIO Mediated device driver"
> +        depends on VFIO && MDEV
> +        default n

The depends and default lines should be indented with tab, not spaces.

> +	help
> +	  Proivdes a mediated BUS for userspace driver through VFIO

	  Provides

> +	  framework. See Documentation/vfio-mediated-device.txt for
> +	  more details.
> +
> +	  If you don't know what do here, say N.
> +
> +
>  config VFIO_MDEV_DEVICE
>  	tristate "VFIO driver for Mediated devices"
>  	depends on VFIO && VFIO_MDEV


-- 
~Randy
