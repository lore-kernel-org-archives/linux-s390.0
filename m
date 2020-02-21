Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 21 Feb 2020 14:27:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 1/2] mm: move force_dma_unencrypted() to mem_encrypt.h
Message-ID: <20200221032727.GC2298@umbus.fritz.box>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-2-pasic@linux.ibm.com>
 <20200220161146.GA12709@lst.de>
 <4369f099-e4e4-4a58-b38b-642cf53ccca6@de.ibm.com>
 <20200220163135.GA13192@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Content-Disposition: inline
In-Reply-To: <20200220163135.GA13192@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Janosch Frank <frankja@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Michael Mueller <mimu@linux.ibm.com>


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2020 at 05:31:35PM +0100, Christoph Hellwig wrote:
> On Thu, Feb 20, 2020 at 05:23:20PM +0100, Christian Borntraeger wrote:
> > >From a users perspective it makes absolutely perfect sense to use the
> > bounce buffers when they are NEEDED.=20
> > Forcing the user to specify iommu_platform just because you need bounce=
 buffers
> > really feels wrong. And obviously we have a severe performance issue
> > because of the indirections.
>=20
> The point is that the user should not have to specify iommu_platform.
> We need to make sure any new hypervisor (especially one that might require
> bounce buffering) always sets it,

So, I have draft qemu patches which enable iommu_platform by default.
But that's really because of other problems with !iommu_platform, not
anything to do with bounce buffering or secure VMs.

The thing is that the hypervisor *doesn't* require bounce buffering.
In the POWER (and maybe s390 as well) models for Secure VMs, it's the
*guest*'s choice to enter secure mode, so the hypervisor has no reason
to know whether the guest needs bounce buffering.  As far as the
hypervisor and qemu are concerned that's a guest internal detail, it
just expects to get addresses it can access whether those are GPAs
(iommu_platform=3Doff) or IOVAs (iommu_platform=3Don).

> as was a rather bogus legacy hack

It was certainly a bad idea, but it was a bad idea that went into a
public spec and has been widely deployed for many years.  We can't
just pretend it didn't happen and move on.

Turning iommu_platform=3Don by default breaks old guests, some of which
we still care about.  We can't (automatically) do it only for guests
that need bounce buffering, because the hypervisor doesn't know that
ahead of time.

> that isn't extensibe for cases that for example require bounce buffering.

In fact bounce buffering isn't really the issue from the hypervisor
(or spec's) point of view.  It's the fact that not all of guest memory
is accessible to the hypervisor.  Bounce buffering is just one way the
guest might deal with that.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5PTh0ACgkQbDjKyiDZ
s5KxuA/8Dp0u3ClHJcvgYS9sPsWYf3cIiL0ssD718l7m06uHYCC8BZhGbCeMhbfK
jDV3bIOPMI6f+L4KTSrPkH71KAYKLKbt52Si354kI/7xkDmCu3B8SmL/u+ptC0Y/
UYD0ZFkgyOLQaOS/jN5zMae3337n6qPRZuOP12epFWZ9QpP4v55Dba2ICuJXkbU1
5QaQIcCLwSBcEYxZOuLqc7s7tWfOt/NeNmvgMnCGJie035XlK0c8q2v7XqRnH8ec
5tej0mQvwOyKgZkYhr35Q/4t2V0LxPDvD+8W636WdH0O9h6wjeMeKlVoq8IpgMyz
NkYNX7yaPfnkh3fvqWa7NMmmi32Rt9/85Kk/3I4YD1KCMSzv7AGJ1TBnUMumisYJ
F2rB+Q07oGi/r/UNg2VSUE2S4rGgq1k9hD2Xb0yE+3+l1TvowJ+2ly30W1TSo5Hu
LZZ/XX0uzsCnrlw4aqzyh4+u4++QcgnlwvDgdfadNXVd3gQdPEoxAP+vV6FhTinx
29Dus3s83/aCpkNeU63NfDWXSIOPTUspWC8Ny1qGE1Vt0Dfie5K+6j7iZdYX0HZT
duIb419GYkR2DBTS0vS6jFh9QFN+jThVs4qc4uRqR6ibwocNlXSdxt+jT7QNkaqO
8HtGwkfqQZCCm4Z0uNnoFv4NY9kLB21wa/z0xOVmDJZtVD8Jgto=
=NO4r
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
