Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 5 Nov 2019 19:33:36 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH V8 5/6] virtio: introduce a mdev based transport
Message-ID: <20191105193336.570e8e3a.cohuck@redhat.com>
In-Reply-To: <20191105093240.5135-6-jasowang@redhat.com>
References: <20191105093240.5135-1-jasowang@redhat.com>
        <20191105093240.5135-6-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, alex.williamson@redhat.com, mst@redhat.com, tiwei.bie@intel.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com, freude@linux.ibm.com, lingshan.zhu@intel.com, idos@mellanox.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, christophe.de.dinechin@gmail.com, kevin.tian@intel.com, stefanha@redhat.com

On Tue,  5 Nov 2019 17:32:39 +0800
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
>  drivers/virtio/Kconfig       |   7 +
>  drivers/virtio/Makefile      |   1 +
>  drivers/virtio/virtio_mdev.c | 407 +++++++++++++++++++++++++++++++++++
>  3 files changed, 415 insertions(+)
>  create mode 100644 drivers/virtio/virtio_mdev.c

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
