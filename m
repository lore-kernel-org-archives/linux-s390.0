Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46452 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729117AbfHAQAa (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 1 Aug 2019 12:00:30 -0400
Message-ID: <ed5388412df78ad0a9ed69cdf3ac716eac075141.camel@suse.de>
Subject: Re: [PATCH 6/8] dma-direct: turn ARCH_ZONE_DMA_BITS into a variable
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date: Thu, 01 Aug 2019 17:59:34 +0200
In-Reply-To: <20190801140452.GB23435@lst.de>
References: <20190731154752.16557-1-nsaenzjulienne@suse.de>
         <20190731154752.16557-7-nsaenzjulienne@suse.de>
         <20190801140452.GB23435@lst.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-1xpVXG9aO5tI8LW1PkIr"
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: catalin.marinas@arm.com, wahrenst@gmx.net, marc.zyngier@arm.com, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, iommu@lists.linux-foundation.org, linux-mm@kvack.org, Marek Szyprowski <m.szyprowski@samsung.com>, phill@raspberryi.org, f.fainelli@gmail.com, will@kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, eric@anholt.net, mbrugger@suse.com, akpm@linux-foundation.org, frowand.list@gmail.com, linux-rpi-kernel@lists.infradead.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org


--=-1xpVXG9aO5tI8LW1PkIr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christoph, thanks for the review.

On Thu, 2019-08-01 at 16:04 +0200, Christoph Hellwig wrote:
> A few nitpicks, otherwise this looks great:
>=20
> > @@ -201,7 +202,7 @@ static int __init mark_nonram_nosave(void)
> >   * everything else. GFP_DMA32 page allocations automatically fall back=
 to
> >   * ZONE_DMA.
> >   *
> > - * By using 31-bit unconditionally, we can exploit ARCH_ZONE_DMA_BITS =
to
> > + * By using 31-bit unconditionally, we can exploit arch_zone_dma_bits =
to
> >   * inform the generic DMA mapping code.  32-bit only devices (if not
> > handled
> >   * by an IOMMU anyway) will take a first dip into ZONE_NORMAL and get
> >   * otherwise served by ZONE_DMA.
> > @@ -237,9 +238,18 @@ void __init paging_init(void)
> >  	printk(KERN_DEBUG "Memory hole size: %ldMB\n",
> >  	       (long int)((top_of_ram - total_ram) >> 20));
> > =20
> > +	/*
> > +	 * Allow 30-bit DMA for very limited Broadcom wifi chips on many
> > +	 * powerbooks.
> > +	 */
> > +	if (IS_ENABLED(CONFIG_PPC32))
> > +		arch_zone_dma_bits =3D 30;
> > +	else
> > +		arch_zone_dma_bits =3D 31;
> > +
>=20
> So the above unconditionally comment obviously isn't true any more, and
> Ben also said for the recent ppc32 hack he'd prefer dynamic detection.
>=20
> Maybe Ben and or other ppc folks can chime in an add a patch to the serie=
s
> to sort this out now that we have a dynamic ZONE_DMA threshold?

Noted, for now I'll remove the comment.

> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index 59bdceea3737..40dfc9b4ee4c 100644
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -19,9 +19,7 @@
> >   * Most architectures use ZONE_DMA for the first 16 Megabytes, but
> >   * some use it for entirely different regions:
> >   */
> > -#ifndef ARCH_ZONE_DMA_BITS
> > -#define ARCH_ZONE_DMA_BITS 24
> > -#endif
> > +unsigned int arch_zone_dma_bits __ro_after_init =3D 24;
>=20
> I'd prefer to drop the arch_ prefix and just calls this zone_dma_bits.
> In the long run we really need to find a way to just automatically set
> this from the meminit code, but that is out of scope for this series.
> For now can you please just update the comment above to say something
> like:
>=20
> /*
>  * Most architectures use ZONE_DMA for the first 16 Megabytes, but some u=
se it
>  * it for entirely different regions.  In that case the arch code needs t=
o
>  * override the variable below for dma-direct to work properly.
>  */

Ok perfect.


--=-1xpVXG9aO5tI8LW1PkIr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl1DDGYACgkQlfZmHno8
x/7w9wgAsuuhgVK1nlC7WgrB2sfSYqL6HTJlDfkLJ2RMgzu/WSw4RJsje86on5R9
NmRSTVntXnCdpTNiKcSEKP7MnrVtMh2TtopfTOCvgho/uDJsc4DPAqZaLHO4quzo
ZfimsWkcpC6n/E8ybEcew+6U7BIyqJPtqxgdkXz98gLQ1NK1wJU2x0Gt+KXT5a/0
hR3hA3whz8yIe4hwQTEiAzX/LnSP8+Yp+g1LLFjYveqt2RUbfC/udykYkLS7LdoO
SJ6j5S/1jRpvusBjENkY3PQiRGrhfRnT4qxVSdpkK/rMG6pLMW4l9YjfbQCLOFhn
8qxZKNifDs1KxpZjExjd4Lisum4nhw==
=nw8i
-----END PGP SIGNATURE-----

--=-1xpVXG9aO5tI8LW1PkIr--
