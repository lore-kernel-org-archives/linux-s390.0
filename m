Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58738 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727762AbfGRUyJ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 18 Jul 2019 16:54:09 -0400
Date: Thu, 18 Jul 2019 22:54:02 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH 1/1] s390/dma: provide proper ARCH_ZONE_DMA_BITS value
Message-ID: <20190718225402.6e8f31e0@ezekiel.suse.cz>
In-Reply-To: <20190718172120.69947-1-pasic@linux.ibm.com>
References: <20190718172120.69947-1-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4Ll9JpNP1hrR3Lz8kH3Tm9Z"; protocol="application/pgp-signature"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

--Sig_/4Ll9JpNP1hrR3Lz8kH3Tm9Z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Jul 2019 19:21:20 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On s390 ZONE_DMA is up to 2G, i.e. ARCH_ZONE_DMA_BITS should be 31 bits.
> The current value is 24 and makes __dma_direct_alloc_pages() take a
> wrong turn first (but __dma_direct_alloc_pages() recovers then).
>=20
> Let's correct ARCH_ZONE_DMA_BITS value and avoid wrong turns.
>=20
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Reported-by: Petr Tesarik <ptesarik@suse.cz>
> Fixes: c61e9637340e ("dma-direct: add support for allocation from
> ZONE_DMA and ZONE_DMA32")
> ---
>  arch/s390/include/asm/dma.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/s390/include/asm/dma.h b/arch/s390/include/asm/dma.h
> index 6f26f35d4a71..3b0329665b13 100644
> --- a/arch/s390/include/asm/dma.h
> +++ b/arch/s390/include/asm/dma.h
> @@ -10,6 +10,7 @@
>   * by the 31 bit heritage.
>   */
>  #define MAX_DMA_ADDRESS         0x80000000
> +#define ARCH_ZONE_DMA_BITS      31
> =20
>  #ifdef CONFIG_PCI
>  extern int isa_dma_bridge_buggy;

Looks good to me.

Petr T

--Sig_/4Ll9JpNP1hrR3Lz8kH3Tm9Z
Content-Type: application/pgp-signature
Content-Description: =?unknown-8bit?q?Digit=C3=A1ln=C3=AD?= podpis OpenPGP

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEHl2YIZkIo5VO2MxYqlA7ya4PR6cFAl0w3GoACgkQqlA7ya4P
R6cplggAueuZZMDHcHgPZXsVT6ZtElx6CMi1ODR2GMydMbgaHrsYUZVSNGsRZuUf
lQqeDk1Ssyg9Q4In6Fq9qkzhCoaGRr5jm8tBUlSg4ov9QX+XugmxPOT6YVRIuPAf
+ko+Wagwsb1BhbGJuE/jXJSOdis1ORZPTKE7TG+5cKNffwRgR9TEJUW2DmWOWeh/
c5hD1rJKSI5E+SNDKHcONOuoAut8UEFbi3my0a4luHxIov+UkxhG6oPQpjuHDCaI
c26k6RyPynGS2p/wY2oBw/5zHxZML+mm7F0dTLZyCQT55871mbFJqRCZSwbL/dmK
hZqlwPCjGe0Bu8GskCPmEMuHnQ+Lkw==
=lwF8
-----END PGP SIGNATURE-----

--Sig_/4Ll9JpNP1hrR3Lz8kH3Tm9Z--
