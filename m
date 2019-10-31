Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51478 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726867AbfJaKam (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 31 Oct 2019 06:30:42 -0400
Message-ID: <8c525f66c1c0d9f07e0cff4948d1ec3229756220.camel@suse.de>
Subject: Re: [PATCH RFC 1/5] dma/direct: turn ARCH_ZONE_DMA_BITS into a
 variable
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date: Thu, 31 Oct 2019 11:30:36 +0100
In-Reply-To: <20191030214914.GA15939@infradead.org>
References: <20191014183108.24804-1-nsaenzjulienne@suse.de>
         <20191014183108.24804-2-nsaenzjulienne@suse.de>
         <20191030214914.GA15939@infradead.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-c/h1zpmiYL5xA/R3DgLo"
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, Marek Szyprowski <m.szyprowski@samsung.com>, mbrugger@suse.com, f.fainelli@gmail.com, wahrenst@gmx.net, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org


--=-c/h1zpmiYL5xA/R3DgLo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-10-30 at 14:49 -0700, Christoph Hellwig wrote:
> On Mon, Oct 14, 2019 at 08:31:03PM +0200, Nicolas Saenz Julienne wrote:
> > Some architectures, notably ARM, are interested in tweaking this
> > depending on their runtime DMA addressing limitations.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>=20
> Do you want me to pick this up for the 5.5 dma-mapping tree, or do you
> want me to wait for the rest to settle?

I'd say take it, this will be ultimately needed once we push forward with A=
RM.


--=-c/h1zpmiYL5xA/R3DgLo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl26t8wACgkQlfZmHno8
x/6Bvgf8CKw0zktkkeQiMRg7+/wfA7jkI0EdKaeR38AVackkoByc3ab5S2A4Qepy
XpQVhaciStaOBkqCzcHLVJnucMd/6d9YH+49GubC64NT12ukfjVwUBbfzgVHTJH2
SOf3YpmsDw+8RokSUatZQZwY4D+b+jezcgK12EYOj244ip65tNEnM87G5ZUZVG1U
2rXnFOH4ne4LmUn6u6Gdgydn5j7pSJnvYH0U0DRU0PLK7kV2uxOrllqSnvdENiRz
QLSjWe2SON35T0OsddsecCq/FWrNzYBYa6bEfc2NsA0qdNAEJVaXQEn3p9bROBPw
I2SkWEPTaKCtL9hUC1eiqUx1nLTY8g==
=5BcM
-----END PGP SIGNATURE-----

--=-c/h1zpmiYL5xA/R3DgLo--
