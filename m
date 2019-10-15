Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46188 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727282AbfJOHs0 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Oct 2019 03:48:26 -0400
Message-ID: <384b42df01c0af973002fba0d5f02068e7f2e7b3.camel@suse.de>
Subject: Re: [PATCH RFC 0/5] ARM: Raspberry Pi 4 DMA support
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date: Tue, 15 Oct 2019 09:48:22 +0200
In-Reply-To: <20191014205859.GA7634@iMac-3.local>
References: <20191014183108.24804-1-nsaenzjulienne@suse.de>
         <20191014205859.GA7634@iMac-3.local>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-4pilC0luxewnjymcvLYk"
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-s390@vger.kernel.org, f.fainelli@gmail.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, hch@infradead.org, iommu@lists.linux-foundation.org, mbrugger@suse.com, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org, wahrenst@gmx.net


--=-4pilC0luxewnjymcvLYk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-10-14 at 21:59 +0100, Catalin Marinas wrote:
> On Mon, Oct 14, 2019 at 08:31:02PM +0200, Nicolas Saenz Julienne wrote:
> > the Raspberry Pi 4 offers up to 4GB of memory, of which only the first
> > is DMA capable device wide. This forces us to use of bounce buffers,
> > which are currently not very well supported by ARM's custom DMA ops.
> > Among other things the current mechanism (see dmabounce.c) isn't
> > suitable for high memory. Instead of fixing it, this series introduces =
a
> > way of selecting dma-direct as the default DMA ops provider which allow=
s
> > for the Raspberry Pi to make use of swiotlb.
>=20
> I presume these patches go on top of this series:
>=20
> http://lkml.kernel.org/r/20190911182546.17094-1-nsaenzjulienne@suse.de

Yes, forgot to mention it. It's relevant for the first patch.

>=20
> which I queued here:
>=20
>=20
https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=3Dfo=
r-next/zone-dma

Thanks!

A little off topic but I was wondering if you have a preferred way to refer=
 to
the arm architecture in a way that it unambiguously excludes arm64 (for exa=
mple
arm32 would work).

Regards,
Nicolas


--=-4pilC0luxewnjymcvLYk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl2lecYACgkQlfZmHno8
x/7lZQf7BpuyTA7KitVkqMXl3L4hWPGTsvKYE4a6JPGwACQaRTlyPLU+YRDvD5uG
3ulte/b7C+OKAXzI17fdpJvO8SBHGO+E0Y2G/j46W9pVezPmyccfF+M0uGKsP9d7
/tcaYEm0X5vNtneMFYydutqLSqQT1uFUcPdJ6M0AJVUcLOtANEfXEJjYEnj6s7wd
OyV2QaOXth+V85DGT+wgaPPOLRmxBmlMbVfZYJUVJ7+9o2FiuWBYDvQ4OA3dHAXf
mVw+II6YIOo4WghksiGES3JYt/0yd0cjqf6Qq7MbB9RIUdvhbJC28ZzRdKSgOA9Q
8PLdonhaeyOJ5k3hZqN+MFiGPt6QGw==
=0lDM
-----END PGP SIGNATURE-----

--=-4pilC0luxewnjymcvLYk--
