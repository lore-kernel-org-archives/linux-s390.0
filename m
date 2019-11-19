Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:38176 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbfKSDNK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 18 Nov 2019 22:13:10 -0500
Subject: Re: [PATCH V13 4/6] mdev: introduce mediated virtio bus
References: <20191118105923.7991-1-jasowang@redhat.com>
 <20191118105923.7991-5-jasowang@redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6c5f6e9e-0a4a-f514-2c26-08476b9a09f8@infradead.org>
Date: Mon, 18 Nov 2019 19:13:01 -0800
MIME-Version: 1.0
In-Reply-To: <20191118105923.7991-5-jasowang@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, alex.williamson@redhat.com, mst@redhat.com, tiwei.bie@intel.com, gregkh@linuxfoundation.org, jgg@mellanox.com
Cc: netdev@vger.kernel.org, cohuck@redhat.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com, freude@linux.ibm.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, christophe.de.dinechin@gmail.com, kevin.tian@intel.com, stefanha@redhat.com, hch@infradead.org, aadam@redhat.com, jakub.kicinski@netronome.com, jiri@mellanox.com, jeffrey.t.kirsher@intel.com

Hi,

On 11/18/19 2:59 AM, Jason Wang wrote:
> diff --git a/drivers/mdev/Kconfig b/drivers/mdev/Kconfig
> index 4561f2d4178f..cd84d4670552 100644
> --- a/drivers/mdev/Kconfig
> +++ b/drivers/mdev/Kconfig
> @@ -17,3 +17,13 @@ config VFIO_MDEV
>  	  more details.
>  
>  	  If you don't know what do here, say N.
> +
> +config MDEV_VIRTIO
> +       tristate "Mediated VIRTIO bus"
> +       depends on VIRTIO && MDEV
> +       default n
> +       help
> +	  Proivdes a mediated BUS for virtio. It could be used by

	  Provides

> +          either kenrel driver or userspace driver.

	            kernel

> +
> +	  If you don't know what do here, say N.

All of these lines should be indented with one tab, not spaces.

-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
