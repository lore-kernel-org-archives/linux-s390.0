Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53660 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727295AbfKFW6S (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Nov 2019 17:58:18 -0500
Date: Wed, 6 Nov 2019 15:58:00 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH V9 6/6] docs: sample driver to demonstrate how to
 implement virtio-mdev framework
Message-ID: <20191106155800.0b8418ec@x1.home>
In-Reply-To: <88efad07-70aa-3879-31e7-ace4d2ad63a1@infradead.org>
References: <20191106070548.18980-1-jasowang@redhat.com>
        <20191106070548.18980-7-jasowang@redhat.com>
        <88efad07-70aa-3879-31e7-ace4d2ad63a1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, mst@redhat.com, tiwei.bie@intel.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, cohuck@redhat.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com, freude@linux.ibm.com, lingshan.zhu@intel.com, idos@mellanox.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, christophe.de.dinechin@gmail.com, kevin.tian@intel.com, stefanha@redhat.com

On Wed, 6 Nov 2019 14:50:30 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 11/5/19 11:05 PM, Jason Wang wrote:
> > diff --git a/samples/Kconfig b/samples/Kconfig
> > index c8dacb4dda80..13a2443e18e0 100644
> > --- a/samples/Kconfig
> > +++ b/samples/Kconfig
> > @@ -131,6 +131,16 @@ config SAMPLE_VFIO_MDEV_MDPY
> >  =09  mediated device.  It is a simple framebuffer and supports
> >  =09  the region display interface (VFIO_GFX_PLANE_TYPE_REGION).
> > =20
> > +config SAMPLE_VIRTIO_MDEV_NET
> > +=09tristate "Build VIRTIO net example mediated device sample code -- l=
oadable modules only"
> > +=09depends on VIRTIO_MDEV && VHOST_RING && m
> > +=09help
> > +=09  Build a networking sample device for use as a virtio
> > +=09  mediated device. The device coopreates with virtio-mdev bus =20
>=20
> typo here:
> =09                              cooperates
>=20

I can fix this on commit relative to V10 if there are no other issues
raised:

diff --git a/samples/Kconfig b/samples/Kconfig
index 13a2443e18e0..b7116d97cbbe 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -136,7 +136,7 @@ config SAMPLE_VIRTIO_MDEV_NET
        depends on VIRTIO_MDEV && VHOST_RING && m
        help
          Build a networking sample device for use as a virtio
-         mediated device. The device coopreates with virtio-mdev bus
+         mediated device. The device cooperates with virtio-mdev bus
          driver to present an virtio ethernet driver for
          kernel. It simply loopbacks all packets from its TX
          virtqueue to its RX virtqueue.

Thanks,
Alex
