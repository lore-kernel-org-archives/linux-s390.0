Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bilbo.ozlabs.org ([203.11.71.1]:55015 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727252AbgBXGny (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 24 Feb 2020 01:43:54 -0500
Date: Mon, 24 Feb 2020 14:38:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 0/2] virtio: decouple protected guest RAM form
 VIRTIO_F_IOMMU_PLATFORM
Message-ID: <20200224033853.GE1751@umbus.fritz.box>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <426e6972-0565-c931-e171-da0f58fbf856@redhat.com>
 <20200221155602.4de41fa7.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="48TaNjbzBVislYPb"
Content-Disposition: inline
In-Reply-To: <20200221155602.4de41fa7.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Michael Mueller <mimu@linux.ibm.com>


--48TaNjbzBVislYPb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2020 at 03:56:02PM +0100, Halil Pasic wrote:
> On Fri, 21 Feb 2020 14:22:26 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>=20
> >=20
> > On 2020/2/21 =E4=B8=8A=E5=8D=8812:06, Halil Pasic wrote:
> > > Currently if one intends to run a memory protection enabled VM with
> > > virtio devices and linux as the guest OS, one needs to specify the
> > > VIRTIO_F_IOMMU_PLATFORM flag for each virtio device to make the guest
> > > linux use the DMA API, which in turn handles the memory
> > > encryption/protection stuff if the guest decides to turn itself into
> > > a protected one. This however makes no sense due to multiple reasons:
> > > * The device is not changed by the fact that the guest RAM is
> > > protected. The so called IOMMU bypass quirk is not affected.
> > > * This usage is not congruent with  standardised semantics of
> > > VIRTIO_F_IOMMU_PLATFORM. Guest memory protected is an orthogonal reas=
on
> > > for using DMA API in virtio (orthogonal with respect to what is
> > > expressed by VIRTIO_F_IOMMU_PLATFORM).
> > >
> > > This series aims to decouple 'have to use DMA API because my (guest) =
RAM
> > > is protected' and 'have to use DMA API because the device told me
> > > VIRTIO_F_IOMMU_PLATFORM'.
> > >
> > > Please find more detailed explanations about the conceptual aspects in
> > > the individual patches. There is however also a very practical problem
> > > that is addressed by this series.
> > >
> > > For vhost-net the feature VIRTIO_F_IOMMU_PLATFORM has the following s=
ide
> > > effect The vhost code assumes it the addresses on the virtio descript=
or
> > > ring are not guest physical addresses but iova's, and insists on doin=
g a
> > > translation of these regardless of what transport is used (e.g. wheth=
er
> > > we emulate a PCI or a CCW device). (For details see commit 6b1e6cc785=
5b
> > > "vhost: new device IOTLB API".) On s390 this results in severe
> > > performance degradation (c.a. factor 10).
> >=20
> >=20
> > Do you see a consistent degradation on the performance, or it only=20
> > happen when for during the beginning of the test?
> >=20
>=20
> AFAIK the degradation is consistent.
>=20
> >=20
> > > BTW with ccw I/O there is
> > > (architecturally) no IOMMU, so the whole address translation makes no
> > > sense in the context of virtio-ccw.
> >=20
> >=20
> > I suspect we can do optimization in qemu side.
> >=20
> > E.g send memtable entry via IOTLB API when vIOMMU is not enabled.
> >=20
> > If this makes sense, I can draft patch to see if there's any difference.
>=20
> Frankly I would prefer to avoid IOVAs on the descriptor ring (and the
> then necessary translation) for virtio-ccw altogether. But Michael
> voiced his opinion that we should mandate F_IOMMU_PLATFORM for devices
> that could be used with guests running in protected mode. I don't share
> his opinion, but that's an ongoing discussion.

I'm a bit confused by this.  For the ccw specific case,
F_ACCESS_PLATFORM shouldn't have any impact: for you, IOVA =3D=3D GPA so
everything is easy.

> Should we end up having to do translation from IOVA in vhost, we are
> very interested in that translation being fast and efficient.
>=20
> In that sense we would be very happy to test any optimization that aim
> into that direction.
>=20
> Thank you very much for your input!
>=20
> Regards,
> Halil
>=20
> >=20
> > Thanks
> >=20
> >=20
> > >
> > > Halil Pasic (2):
> > >    mm: move force_dma_unencrypted() to mem_encrypt.h
> > >    virtio: let virtio use DMA API when guest RAM is protected
> > >
> > >   drivers/virtio/virtio_ring.c |  3 +++
> > >   include/linux/dma-direct.h   |  9 ---------
> > >   include/linux/mem_encrypt.h  | 10 ++++++++++
> > >   3 files changed, 13 insertions(+), 9 deletions(-)
> > >
> > >
> > > base-commit: ca7e1fd1026c5af6a533b4b5447e1d2f153e28f2
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--48TaNjbzBVislYPb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5TRUwACgkQbDjKyiDZ
s5KHhRAAzvCq4VbEVWbiYmB1ioNQU2Zls3KoMhs0PgZRddR+1P85yLT3xnHrw/LQ
g2UfyDDlqIqQgVjwHuHBTwoRWvNFm7Q72IUkh/Crwex4MlbvdSA0MIovpx9J3SSq
tjQ/No5y2xz2zsksr3T7KRh+w7EM62KyxJU1vnZj1NvlZQmHGG4tMtEpsv+rwa9R
13j0VvV9SqLMCPS7zMFge/kvOg59UqwGpFXIaILBx9TGPHAjjLNt2GZCAPAsOxmO
TIqzQwP2pooqNrLVnTvaXP3R4HUi/3V86Cys7oKnStuG95psLjB+2S8wxpfOTXS2
3pPHCTweu2xyQNReRbrjQq0aovnDdioNVFn6auGF0ilCd3xFrd0fYWG0vvW0d8f/
hlyZfoJCTCvKs60OcC7x45FKfpcU4+R8oHxdVJG/DPI6Uxbk9C5T0G/maOMxKLDO
40hJGP2SVIFtdmb8lNhlA4saVYjsR0OqH+Y+fLYi6dsl1S7FFNAhMEOOJrvhfE1O
cSSWeq2NsyY0mtTFeAtXv25yZ4t8Ed9oNnVvTXyNKkp8VKmVGz2qmH+sx1wHi4m8
UANxHkrr0V1IzMdE4Bz7TKeOVNdTQQN+0AQlwL6R+XZTpwgPAUXQbV5bLvwX+CEp
SqpVVhl9CnKeqyppaXy08CiYwdQIaze77BSX0VHTyIJq4WzI8YY=
=FeJg
-----END PGP SIGNATURE-----

--48TaNjbzBVislYPb--
