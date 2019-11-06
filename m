Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:51038 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfKFWuh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Nov 2019 17:50:37 -0500
Subject: Re: [PATCH V9 6/6] docs: sample driver to demonstrate how to
 implement virtio-mdev framework
References: <20191106070548.18980-1-jasowang@redhat.com>
 <20191106070548.18980-7-jasowang@redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <88efad07-70aa-3879-31e7-ace4d2ad63a1@infradead.org>
Date: Wed, 6 Nov 2019 14:50:30 -0800
MIME-Version: 1.0
In-Reply-To: <20191106070548.18980-7-jasowang@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, alex.williamson@redhat.com, mst@redhat.com, tiwei.bie@intel.com
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, cohuck@redhat.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com, freude@linux.ibm.com, lingshan.zhu@intel.com, idos@mellanox.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, christophe.de.dinechin@gmail.com, kevin.tian@intel.com, stefanha@redhat.com

On 11/5/19 11:05 PM, Jason Wang wrote:
> diff --git a/samples/Kconfig b/samples/Kconfig
> index c8dacb4dda80..13a2443e18e0 100644
> --- a/samples/Kconfig
> +++ b/samples/Kconfig
> @@ -131,6 +131,16 @@ config SAMPLE_VFIO_MDEV_MDPY
>  	  mediated device.  It is a simple framebuffer and supports
>  	  the region display interface (VFIO_GFX_PLANE_TYPE_REGION).
>  
> +config SAMPLE_VIRTIO_MDEV_NET
> +	tristate "Build VIRTIO net example mediated device sample code -- loadable modules only"
> +	depends on VIRTIO_MDEV && VHOST_RING && m
> +	help
> +	  Build a networking sample device for use as a virtio
> +	  mediated device. The device coopreates with virtio-mdev bus

typo here:
	                              cooperates

> +	  driver to present an virtio ethernet driver for
> +	  kernel. It simply loopbacks all packets from its TX
> +	  virtqueue to its RX virtqueue.
> +
>  config SAMPLE_VFIO_MDEV_MDPY_FB
>  	tristate "Build VFIO mdpy example guest fbdev driver -- loadable module only"
>  	depends on FB && m

ciao.
-- 
~Randy
