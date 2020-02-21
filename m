Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bilbo.ozlabs.org ([203.11.71.1]:46591 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729636AbgBUD1u (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 20 Feb 2020 22:27:50 -0500
Date: Fri, 21 Feb 2020 13:59:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is
 protected
Message-ID: <20200221025915.GB2298@umbus.fritz.box>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-3-pasic@linux.ibm.com>
 <20200220161309.GB12709@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
In-Reply-To: <20200220161309.GB12709@lst.de>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Halil Pasic <pasic@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Michael Mueller <mimu@linux.ibm.com>


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2020 at 05:13:09PM +0100, Christoph Hellwig wrote:
> On Thu, Feb 20, 2020 at 05:06:06PM +0100, Halil Pasic wrote:
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 867c7ebd3f10..fafc8f924955 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -243,6 +243,9 @@ static bool vring_use_dma_api(struct virtio_device =
*vdev)
> >  	if (!virtio_has_iommu_quirk(vdev))
> >  		return true;
> > =20
> > +	if (force_dma_unencrypted(&vdev->dev))
> > +		return true;
>=20
> Hell no.  This is a detail of the platform DMA direct implementation.
> Drivers have no business looking at this flag, and virtio finally needs
> to be fixed to use the DMA API properly for everything but legacy devices.

So, this patch definitely isn't right as it stands, but I'm struggling
to understand what it is you're saying is the right way.

By "legacy devices" I assume you mean pre-virtio-1.0 devices, that
lack the F_VERSION_1 feature flag.  Is that right?  Because I don't
see how being a legacy device or not relates to use of the DMA API.

I *think* what you are suggesting here is that virtio devices that
have !F_IOMMU_PLATFORM should have their dma_ops set up so that the
DMA API treats IOVA=3D=3DPA, which will satisfy what the device expects.
Then the virtio driver can use the DMA API the same way for both
F_IOMMU_PLATFORM and !F_IOMMU_PLATFORM devices.

But if that works for !F_IOMMU_PLATFORM_DEVICES+F_VERSION_1 devices,
then AFAICT it will work equally well for legacy devices.

Using the DMA API for *everything* in virtio, legacy or not, seems
like a reasonable approach to me.  But, AFAICT, that does require the
DMA layer to have some kind of explicit call to turn on this
behaviour, which the virtio driver would call during initializsation.
I don't think we can do it 100% within the DMA layer, because only the
driver can reasonably know when a device has this weird non-standard
DMA behaviour.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5PR4EACgkQbDjKyiDZ
s5LraA/+KQYlg3wZ+0krCgI0rnOA1c4Rh7dkchkUxj0XPpjfegrcik9vB4AEk1uV
NViHfw9TklofjnE59FOo9Rexy90uk2aepCPMiba2Aidm0X+E9OMWIZ75l+9IyNod
fnTLSUCP45wGHQUcjIE1iL3TNJrTZ+F0bQkuu1rwZhtBHx+mKYmS005cUmOuiYQi
+gZAl8VlR/Ar3QktvDq1ChJai/rB22k+AWL9eL6fgpFGZv/E13hM25tKU61acUZh
WbtOBNEDoDs792CWCbIs9gqoeq1Whd555JS3nbAlDqNykTUMrfqDbbX/FdJlciPu
b1TlYEWQLmJDCv8xdPNj8Iep747a3Pc8pDhe7cALeEGvR8dEgbXE7+cx6l5rX6FW
glvHUQbw8/iD2tRbMLEfk1z/uyL7Gzugk7P6Xfeg+fNcGoL6ADR3DFCBUn1eD0Bf
EHyBM/WOmi1kn9p52fC3waAPg5BqftyrxFdGd2dI7mUjLvGeT/gxPnqfdaEDbdku
nlBw4/tcIdlesiIAiI+bCe4bX111KgcJvqVSjaRiS1YqFumJ1aySBzXpAfjqWW/p
2MU+m6v1xqCEDc7UY+aFtHrRw+CsByowyIFYfNcfSgDMvB9uFkvme4opmrdyAe+g
G/3fLNvewrGHvqTITJtkyQGQnyJEmHbcQMnWbSdQyqbQU+qO8tg=
=dMlk
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
