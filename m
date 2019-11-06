Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27065 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725906AbfKFLBS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Nov 2019 06:01:18 -0500
Date: Wed, 6 Nov 2019 12:00:47 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH V9 5/6] virtio: introduce a mdev based transport
Message-ID: <20191106120047.5bcf49c3.cohuck@redhat.com>
In-Reply-To: <20191106070548.18980-6-jasowang@redhat.com>
References: <20191106070548.18980-1-jasowang@redhat.com>
        <20191106070548.18980-6-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, alex.williamson@redhat.com, mst@redhat.com, tiwei.bie@intel.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com, freude@linux.ibm.com, lingshan.zhu@intel.com, idos@mellanox.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, christophe.de.dinechin@gmail.com, kevin.tian@intel.com, stefanha@redhat.com

On Wed,  6 Nov 2019 15:05:47 +0800
Jason Wang <jasowang@redhat.com> wrote:

> This patch introduces a new mdev transport for virtio. This is used to
> use kernel virtio driver to drive the mediated device that is capable
> of populating virtqueue directly.
>=20
> A new virtio-mdev driver will be registered to the mdev bus, when a
> new virtio-mdev device is probed, it will register the device with
> mdev based config ops. This means it is a software transport between
> mdev driver and mdev device. The transport was implemented through
> device specific ops which is a part of mdev_parent_ops now.
>=20
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/Kconfig       |  13 ++
>  drivers/virtio/Makefile      |   1 +
>  drivers/virtio/virtio_mdev.c | 406 +++++++++++++++++++++++++++++++++++
>  3 files changed, 420 insertions(+)
>  create mode 100644 drivers/virtio/virtio_mdev.c
>=20
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 078615cf2afc..558ac607d107 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -43,6 +43,19 @@ config VIRTIO_PCI_LEGACY
> =20
>  =09  If unsure, say Y.
> =20
> +config VIRTIO_MDEV
> +=09tristate "MDEV driver for virtio devices"
> +=09depends on VFIO_MDEV && VIRTIO
> +=09default n
> +=09help
> +=09  This driver provides support for virtio based paravirtual
> +=09  device driver over MDEV bus. This requires your environemnt
> +=09  has appropriate virtio mdev device implementation which may
> +=09  operate on the physical device that the datapath of virtio
> +=09  could be offloaded to hardware.

That sentence is a bit confusing to me... what about

"For this to be useful, you need an appropriate virtio mdev device
implementation that operates on a physical device to allow the datapath
of virtio to be offloaded to hardware."

?

> +
> +=09  If unsure, say M

Building this as a module should not hurt (but please add a trailing
'.' here :)

> +
>  config VIRTIO_PMEM
>  =09tristate "Support for virtio pmem driver"
>  =09depends on VIRTIO

With the changes above,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
