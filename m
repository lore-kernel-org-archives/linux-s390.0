Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38863 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732825AbfJOOh0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 15 Oct 2019 10:37:26 -0400
Date: Tue, 15 Oct 2019 15:37:20 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH V3 0/7] mdev based hardware virtio offloading support
Message-ID: <20191015143720.GA13108@stefanha-x1.localdomain>
References: <20191011081557.28302-1-jasowang@redhat.com>
 <20191014174946.GC5359@stefanha-x1.localdomain>
 <6d12ad8f-8137-e07d-d735-da59a326e8ed@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <6d12ad8f-8137-e07d-d735-da59a326e8ed@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, alex.williamson@redhat.com, mst@redhat.com, tiwei.bie@intel.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, cohuck@redhat.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com, freude@linux.ibm.com, lingshan.zhu@intel.com, idos@mellanox.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, christophe.de.dinechin@gmail.com, kevin.tian@intel.com


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2019 at 11:37:17AM +0800, Jason Wang wrote:
>=20
> On 2019/10/15 =E4=B8=8A=E5=8D=881:49, Stefan Hajnoczi wrote:
> > On Fri, Oct 11, 2019 at 04:15:50PM +0800, Jason Wang wrote:
> > > There are hardware that can do virtio datapath offloading while having
> > > its own control path. This path tries to implement a mdev based
> > > unified API to support using kernel virtio driver to drive those
> > > devices. This is done by introducing a new mdev transport for virtio
> > > (virtio_mdev) and register itself as a new kind of mdev driver. Then
> > > it provides a unified way for kernel virtio driver to talk with mdev
> > > device implementation.
> > >=20
> > > Though the series only contains kernel driver support, the goal is to
> > > make the transport generic enough to support userspace drivers. This
> > > means vhost-mdev[1] could be built on top as well by resuing the
> > > transport.
> > >=20
> > > A sample driver is also implemented which simulate a virito-net
> > > loopback ethernet device on top of vringh + workqueue. This could be
> > > used as a reference implementation for real hardware driver.
> > >=20
> > > Consider mdev framework only support VFIO device and driver right now,
> > > this series also extend it to support other types. This is done
> > > through introducing class id to the device and pairing it with
> > > id_talbe claimed by the driver. On top, this seris also decouple
> > > device specific parents ops out of the common ones.
> > I was curious so I took a quick look and posted comments.
> >=20
> > I guess this driver runs inside the guest since it registers virtio
> > devices?
>=20
>=20
> It could run in either guest or host. But the main focus is to run in the
> host then we can use virtio drivers in containers.
>=20
>=20
> >=20
> > If this is used with physical PCI devices that support datapath
> > offloading then how are physical devices presented to the guest without
> > SR-IOV?
>=20
>=20
> We will do control path meditation through vhost-mdev[1] and vhost-vfio[2=
].
> Then we will present a full virtio compatible ethernet device for guest.
>=20
> SR-IOV is not a must, any mdev device that implements the API defined in
> patch 5 can be used by this framework.

What I'm trying to understand is: if you want to present a virtio-pci
device to the guest (e.g. using vhost-mdev or vhost-vfio), then how is
that related to this patch series?

Does this mean this patch series is useful mostly for presenting virtio
devices to containers or the host?

Stefan

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2l2aAACgkQnKSrs4Gr
c8ji7wf9FHyYry8VO4FqVBdQWMz/h/mmNTgeyBCpCasw+joJ3LRHOyyGPsu2BiOX
IhAuZvK3azvtP7vh1etYaoBrCPmyFBTh2UXsIYoGK1qpUzPNkB7nuGYTBPJgZbxd
jmJNDjc9wrrn9sWBJjkJaFYSjEDfob63FtUG2VM6f109LXI4bTyt03KqS1tZ75Hi
SSjVt95GYQ1xENjKUcVqV9ULwfsv0Wz/WQ2XIvn8Oij7NK9bKHWl3HLirrUE62FP
y6/3Y2fKKhes58jmY09L37Ym625X95M//6g2WYv+uR5rTTfo7jQBlLZ1tklwNY/k
X8Sw0iHJKxZjvZqItbu49kJtRJwm9g==
=nOrh
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
