Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from ozlabs.org ([203.11.71.1]:44553 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbgBXGny (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 24 Feb 2020 01:43:54 -0500
Date: Mon, 24 Feb 2020 16:44:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 0/2] virtio: decouple protected guest RAM form
 VIRTIO_F_IOMMU_PLATFORM
Message-ID: <20200224054428.GF1751@umbus.fritz.box>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220163055-mutt-send-email-mst@kernel.org>
 <20200221164151.GD10054@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nHwqXXcoX0o6fKCv"
Content-Disposition: inline
In-Reply-To: <20200221164151.GD10054@lst.de>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Jason Wang <jasowang@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Michael Mueller <mimu@linux.ibm.com>


--nHwqXXcoX0o6fKCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2020 at 05:41:51PM +0100, Christoph Hellwig wrote:
> On Thu, Feb 20, 2020 at 04:33:35PM -0500, Michael S. Tsirkin wrote:
> > So it sounds like a host issue: the emulation of s390 unnecessarily com=
plicated.
> > Working around it by the guest looks wrong ...
>=20
> Yes.  If your host (and I don't care if you split hypervisor,
> ultravisor and megavisor out in your implementation) wants to
> support a VM architecture where the host can't access all guest
> memory you need to ensure the DMA API is used.  Extra points for
> simply always setting the flag and thus future proofing the scheme.

Moving towards F_ACCESS_PLATFORM everywhere is a good idea (for other
reasons), but that doesn't make the problem as it exists right now go
away.

But, "you need to ensure the DMA API is used" makes no sense from the
host point of view.  The existence of the DMA API is an entirely guest
side, and Linux specific detail, the host can't make decisions based
on that.

For POWER - possibly s390 as well - the hypervisor has no way of
knowing at machine construction time whether it will be an old kernel
(or non Linux OS) which can't support F_ACCESS_PLATFORM, or a guest
which will enter secure mode and therefore requires F_ACCESS_PLATFORM
(according to you).  That's the fundamental problem here.

The normal virtio model of features that the guest can optionally
accept would work nicely here - except that that wouldn't work for the
case of hardware virtio devices, where the access limitations come
=66rom "host" (platform) side and therefore can't be disabled by that
host.

We really do have two cases here: 1) access restrictions originating
with the host/platform (e.g. hardware virtio) and 2) access
restrictions originating with the guest (e.g. secure VMs).  What we
need to do to deal with them is basically the same at the driver
level, but it has subtle and important differences at the platform
level.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nHwqXXcoX0o6fKCv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5TYrkACgkQbDjKyiDZ
s5LgfA//XEY3lmBePwheA7+ZxvP//i1z+aeebGoX04iO9GIleC4oyEM4gwYIBsyE
wN2BIrmBL7Zv5wxxna4aFmlHWVHtjclnMlbnScF3iSkYjcAqB0WowhE+uMerv86z
0SQsaZBBEzM2AUCdyWpi1NvPPH6qWbB1BAlZ1gS18mpsYePFvZ5Yx7v8HlXoSdti
nHf9vONIz4DjMutYICE0h4wRSG8fE0Glav04Rlvy4G024l5rW3o3Hd4Fg6hlL6Bx
lG9vYtmbznT2FaqV1vvs9LHFQ+luXOqLisBYunWFHDGSBLqQdfWnVApMfHpmkudT
pVFwEZmU3Vdy0MgEF6mMunZ2vw0PqQaQSIw2KUm4KJXSLjrR2qI+XUY878F+hI5h
fvAxlo4FDEBDVgeIudJY28B/57nJdaMZCpxZB6YFHGtuQJU5VHFRLA1wi96A3mFr
W29jfmZcozEl2fpJyr7lg/znfmjbrAx63AeNJkKQ9lWpDGilVd90xHaWcEy+t28L
U9GggmVjYO4KOGiOTjkrY+wskuPj/qZaoEWFra3bzryLW5muVLoCT12H2X+NtcjF
2Poa8kmUAlBjnnrf3QLCh2rQQVuHNXMbS7eYpeSBfld+gHjj7FBMS5ymAnEK0X3B
WySnu4ZlVaDEYjtHlp6tvfiRlkt1PGQswZY8OhtHA6QBkQVs4t0=
=snSR
-----END PGP SIGNATURE-----

--nHwqXXcoX0o6fKCv--
