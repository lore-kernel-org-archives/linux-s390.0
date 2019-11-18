Return-Path: <netdev-owner@vger.kernel.org>
Date: Mon, 18 Nov 2019 16:45:10 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH V13 6/6] docs: sample driver to demonstrate how to
 implement virtio-mdev framework
Message-ID: <20191118164510.549c097b.cohuck@redhat.com>
In-Reply-To: <20191118105923.7991-7-jasowang@redhat.com>
References: <20191118105923.7991-1-jasowang@redhat.com>
        <20191118105923.7991-7-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, alex.williamson@redhat.com, mst@redhat.com, tiwei.bie@intel.com, gregkh@linuxfoundation.org, jgg@mellanox.com, netdev@vger.kernel.org, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com, freude@linux.ibm.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, christophe.de.dinechin@gmail.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jakub.kicinski@netronome.com, jiri@mellanox.com, jeffrey.t.kirsher@intel.com

On Mon, 18 Nov 2019 18:59:23 +0800
Jason Wang <jasowang@redhat.com> wrote:

[Note: I have not looked into the reworked architecture of this *at all*
so far; just something that I noted...]

> This sample driver creates mdev device that simulate virtio net device
> over virtio mdev transport. The device is implemented through vringh
> and workqueue. A device specific dma ops is to make sure HVA is used
> directly as the IOVA. This should be sufficient for kernel virtio
> driver to work.
>=20
> Only 'virtio' type is supported right now. I plan to add 'vhost' type
> on top which requires some virtual IOMMU implemented in this sample
> driver.
>=20
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  MAINTAINERS                        |   1 +
>  samples/Kconfig                    |  10 +
>  samples/vfio-mdev/Makefile         |   1 +
>  samples/vfio-mdev/mvnet_loopback.c | 690 +++++++++++++++++++++++++++++
>  4 files changed, 702 insertions(+)
>  create mode 100644 samples/vfio-mdev/mvnet_loopback.c
>=20

> +static struct mvnet_dev {
> +=09struct class=09*vd_class;
> +=09struct idr=09vd_idr;
> +=09struct device=09dev;
> +} mvnet_dev;

This structure embeds a struct device (a reference-counted structure),
yet it is a static variable. This is giving a bad example to potential
implementers; just allocate it dynamically.

> +static void mvnet_device_release(struct device *dev)
> +{
> +=09dev_dbg(dev, "mvnet: released\n");

And that also means you need a proper release function here, of
course.

> +}
