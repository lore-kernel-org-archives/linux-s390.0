Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from ozlabs.org ([203.11.71.1]:54715 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729984AbgB1BEy (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Feb 2020 20:04:54 -0500
Date: Fri, 28 Feb 2020 11:23:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 1/2] mm: move force_dma_unencrypted() to mem_encrypt.h
Message-ID: <20200228002353.GA1842@umbus.fritz.box>
References: <20200220161146.GA12709@lst.de>
 <4369f099-e4e4-4a58-b38b-642cf53ccca6@de.ibm.com>
 <20200220163135.GA13192@lst.de>
 <20200221032727.GC2298@umbus.fritz.box>
 <20200221140639.54928efe.pasic@linux.ibm.com>
 <20200221104724-mutt-send-email-mst@kernel.org>
 <20200221190702.68fd57fc.pasic@linux.ibm.com>
 <20200224033314.GC1751@umbus.fritz.box>
 <20200224194953.37c0d6b8.pasic@linux.ibm.com>
 <20200225190802.753cffef.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <20200225190802.753cffef.cohuck@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@lst.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Jason Wang <jasowang@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Janosch Frank <frankja@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Michael Mueller <mimu@linux.ibm.com>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2020 at 07:08:02PM +0100, Cornelia Huck wrote:
> On Mon, 24 Feb 2020 19:49:53 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
>=20
> > On Mon, 24 Feb 2020 14:33:14 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > > On Fri, Feb 21, 2020 at 07:07:02PM +0100, Halil Pasic wrote: =20
> > > > On Fri, 21 Feb 2020 10:48:15 -0500
> > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > >  =20
> > > > > On Fri, Feb 21, 2020 at 02:06:39PM +0100, Halil Pasic wrote: =20
> > > > > > On Fri, 21 Feb 2020 14:27:27 +1100
> > > > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > > >  =20
> > > > > > > On Thu, Feb 20, 2020 at 05:31:35PM +0100, Christoph Hellwig w=
rote: =20
> > > > > > > > On Thu, Feb 20, 2020 at 05:23:20PM +0100, Christian Borntra=
eger wrote: =20
> > > > > > > > > >From a users perspective it makes absolutely perfect sen=
se to use the =20
> > > > > > > > > bounce buffers when they are NEEDED.=20
> > > > > > > > > Forcing the user to specify iommu_platform just because y=
ou need bounce buffers
> > > > > > > > > really feels wrong. And obviously we have a severe perfor=
mance issue
> > > > > > > > > because of the indirections. =20
> > > > > > > >=20
> > > > > > > > The point is that the user should not have to specify iommu=
_platform.
> > > > > > > > We need to make sure any new hypervisor (especially one tha=
t might require
> > > > > > > > bounce buffering) always sets it, =20
> > > > > > >=20
> > > > > > > So, I have draft qemu patches which enable iommu_platform by =
default.
> > > > > > > But that's really because of other problems with !iommu_platf=
orm, not
> > > > > > > anything to do with bounce buffering or secure VMs.
> > > > > > >=20
> > > > > > > The thing is that the hypervisor *doesn't* require bounce buf=
fering.
> > > > > > > In the POWER (and maybe s390 as well) models for Secure VMs, =
it's the
> > > > > > > *guest*'s choice to enter secure mode, so the hypervisor has =
no reason
> > > > > > > to know whether the guest needs bounce buffering.  As far as =
the
> > > > > > > hypervisor and qemu are concerned that's a guest internal det=
ail, it
> > > > > > > just expects to get addresses it can access whether those are=
 GPAs
> > > > > > > (iommu_platform=3Doff) or IOVAs (iommu_platform=3Don). =20
> > > > > >=20
> > > > > > I very much agree!
> > > > > >  =20
> > > > > > >  =20
> > > > > > > > as was a rather bogus legacy hack =20
> > > > > > >=20
> > > > > > > It was certainly a bad idea, but it was a bad idea that went =
into a
> > > > > > > public spec and has been widely deployed for many years.  We =
can't
> > > > > > > just pretend it didn't happen and move on.
> > > > > > >=20
> > > > > > > Turning iommu_platform=3Don by default breaks old guests, som=
e of which
> > > > > > > we still care about.  We can't (automatically) do it only for=
 guests
> > > > > > > that need bounce buffering, because the hypervisor doesn't kn=
ow that
> > > > > > > ahead of time. =20
>=20
> We could default to iommu_platform=3Don on s390 when the host has active
> support for protected virtualization... but that's just another kind of
> horrible, so let's just pretend I didn't suggest it.

Yeah, that would break migration between hosts with the feature and
hosts without - for everything, not just protected guests.  In general
any kind of guest visible configuration change based on host
properties is incompatible with the qemu/KVM migration model.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5YXZcACgkQbDjKyiDZ
s5LdKA//U9QbJilQoiEQCinA1xGVHP1Hm7w/1rqgbm4B30D4A7I3ioERM/uwdqkQ
ks4shzQNPfx3O2Bkiit5DGE/A4C9CODYVqjvPw0pDpMaYJI6tDVcjd3bgYhyE2QI
Gp5oQ4l40a4C5oUH9YYoOS7eyx0rg6q1HstQDyTtTUP8MURr5XsqMIU4086N8bDI
JrYkBRXTU/W5FCuHnKR8wUwuKGUqTu64yEtzlT40YuWCrUw2PRtaG6jjP9CMisqL
BS2ISdY2UeTZXNnavX0LycUAwUDo4gy/ux4TcSuzSii7A0ztiqqrbs/UFNs/GCUg
pfcr9JbU7dsT4po/YKERdQ/6PiYuVufHASLOhDdDw6pNVLyuTnzHgmRkWSrRV4NP
haSVx1u2JbRmJmO66RgJdt774tVxyDVIRhZprWlvg5yX0ad0TAHvx2MqitDgjCiV
XZdu7rCfKQVCXU35ODteapV9n+CguP8f2KYIVWXJIHCbjLg65nVr4moJNupn/5nd
kvhC+2MOoszj0PXtMEPTWe7N/H9KDfp4Vv861JhZL5pe3GluF9qsHDk/vHWuovCK
Vab8lroMXU5o345o4w70Cu/X+PO1lkVeml+MTI3c+hfZHcaGlvnsVehQGDYhwX4I
XvNb0jeVjkJJRHVxOIIgzD4PxiBaYtpfFV+cBvysaDf5aaCX2Zk=
=MCKa
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
