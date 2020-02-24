Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bilbo.ozlabs.org ([203.11.71.1]:45701 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgBXGv1 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 24 Feb 2020 01:51:27 -0500
Date: Mon, 24 Feb 2020 17:50:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is
 protected
Message-ID: <20200224065053.GM1751@umbus.fritz.box>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-3-pasic@linux.ibm.com>
 <20200220161309.GB12709@lst.de>
 <20200221025915.GB2298@umbus.fritz.box>
 <20200221163645.GB10054@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tv2SIFopg1r47n4a"
Content-Disposition: inline
In-Reply-To: <20200221163645.GB10054@lst.de>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Halil Pasic <pasic@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Michael Mueller <mimu@linux.ibm.com>


--tv2SIFopg1r47n4a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2020 at 05:36:45PM +0100, Christoph Hellwig wrote:
> On Fri, Feb 21, 2020 at 01:59:15PM +1100, David Gibson wrote:
> > > Hell no.  This is a detail of the platform DMA direct implementation.
> > > Drivers have no business looking at this flag, and virtio finally nee=
ds
> > > to be fixed to use the DMA API properly for everything but legacy dev=
ices.
> >=20
> > So, this patch definitely isn't right as it stands, but I'm struggling
> > to understand what it is you're saying is the right way.
> >=20
> > By "legacy devices" I assume you mean pre-virtio-1.0 devices, that
> > lack the F_VERSION_1 feature flag.  Is that right?  Because I don't
> > see how being a legacy device or not relates to use of the DMA API.
>=20
> No.   "legacy" is anything that does not set F_ACCESS_PLATFORM.

Hm, I see.

The trouble is I think we can only reasonably call things "legacy"
when essentially all currently in use OSes have support for the new,
better way of doing things.  That is, alas, not really the case for
F_ACCESS_PLATFORM.

> > I *think* what you are suggesting here is that virtio devices that
> > have !F_IOMMU_PLATFORM should have their dma_ops set up so that the
> > DMA API treats IOVA=3D=3DPA, which will satisfy what the device expects.
> > Then the virtio driver can use the DMA API the same way for both
> > F_IOMMU_PLATFORM and !F_IOMMU_PLATFORM devices.
>=20
> No.  Those should just keep using the existing legacy non-dma ops
> case and be done with it.  No changes to that and most certainly
> no new features.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tv2SIFopg1r47n4a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5TckoACgkQbDjKyiDZ
s5K3ZRAAhMCdmN1OrUKfgLFhJWQQeC89dOZY69wRPSGHIRGqp2vdz/84iVFYTXtM
KJIVtt/k4q5tdpB8FDlRYkPkBjAxZxwUXCQ5ErZ8bUW+1l9qidMcmM81ud6CuDo5
JnNILm61f05ut+aJtoH8N9pHLWVp6Xd7D0U2EuZm3O1E1Ru7eWh89XVqZszqy/0v
wU+HF11K6jWai0ZBUmsbHzRzklrXB832SfHRxREYTgaAnfIJciC+VoYClfLDdz5l
IHqFw/HkmOM0gbiuTsirWTmIZYgdiGm2luvqn3UJRSUeMur5r1KAQb54VdTXoxm6
85M7AILjY82m3QKG4xWbSzH778IFxv3fhbfNo1lOT0f4IAn3bJ3xNrlP72vmzq03
mnU3XYWDD7Bi7ohPJmNL/KatbmLDSBGW55f6VxdcydKUEWC4EOdLhAm3D1L9GOI7
m9MOyhkKifhvysv3yA4+Wu6lEhJS7C/xLLzZIKuXS/2YWeplK4meqBoIgBnLD9L1
oD4EK/yI9AQu0WLj2SPUP5jWzMxaUzKHrseBf8Lzk1i/IrMrOxqYF3+Mz6hHZkey
+3lNPAAPuD+FeZC34MWsH7jL/JPT3RPDGHjtIf7fP2f/VPZygVJCOUh5/vYnX4dI
v2Jd5yIETXGCRsGnZcxnszGVK3J0zN+skCNsyIZKwRBsZuBTLj0=
=Q89/
-----END PGP SIGNATURE-----

--tv2SIFopg1r47n4a--
