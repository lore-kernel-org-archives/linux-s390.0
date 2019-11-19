Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:38060 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbfKSDLg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 18 Nov 2019 22:11:36 -0500
Subject: Re: [PATCH V13 3/6] mdev: move to drivers/
References: <20191118105923.7991-1-jasowang@redhat.com>
 <20191118105923.7991-4-jasowang@redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <195f2686-752c-67f0-0dba-04178a6f5dda@infradead.org>
Date: Mon, 18 Nov 2019 19:11:26 -0800
MIME-Version: 1.0
In-Reply-To: <20191118105923.7991-4-jasowang@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, alex.williamson@redhat.com, mst@redhat.com, tiwei.bie@intel.com, gregkh@linuxfoundation.org, jgg@mellanox.com
Cc: netdev@vger.kernel.org, cohuck@redhat.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com, freude@linux.ibm.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, christophe.de.dinechin@gmail.com, kevin.tian@intel.com, stefanha@redhat.com, hch@infradead.org, aadam@redhat.com, jakub.kicinski@netronome.com, jiri@mellanox.com, jeffrey.t.kirsher@intel.com

On 11/18/19 2:59 AM, Jason Wang wrote:
> diff --git a/drivers/mdev/Kconfig b/drivers/mdev/Kconfig
> new file mode 100644
> index 000000000000..4561f2d4178f
> --- /dev/null
> +++ b/drivers/mdev/Kconfig
> @@ -0,0 +1,19 @@
> +
> +config MDEV
> +	tristate "Mediated device driver framework"
> +	default n
> +	help
> +	  Provides a framework to virtualize devices.
> +
> +	  If you don't know what do here, say N.
> +
> +config VFIO_MDEV
> +	tristate "VFIO Mediated device driver"
> +        depends on VFIO && MDEV
> +        default n

Use tab on the 2 lines above, not spaces.

> +	help
> +	  Proivdes a mediated BUS for userspace driver through VFIO

	  Provides

> +	  framework. See Documentation/vfio-mediated-device.txt for
> +	  more details.
> +
> +	  If you don't know what do here, say N.


-- 
~Randy
