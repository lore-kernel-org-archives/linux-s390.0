Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49440 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728561AbfJaR0R (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 31 Oct 2019 13:26:17 -0400
Message-ID: <9c051b0f2d89baa36fd3d3669a107f549c310d49.camel@suse.de>
Subject: Re: [PATCH RFC 1/5] dma/direct: turn ARCH_ZONE_DMA_BITS into a
 variable
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date: Thu, 31 Oct 2019 18:26:10 +0100
In-Reply-To: <20191031133831.GA21509@infradead.org>
References: <20191014183108.24804-1-nsaenzjulienne@suse.de>
         <20191014183108.24804-2-nsaenzjulienne@suse.de>
         <20191030214914.GA15939@infradead.org>
         <8c525f66c1c0d9f07e0cff4948d1ec3229756220.camel@suse.de>
         <20191031133831.GA21509@infradead.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-HUsDE4pCuvQagD+CYqmq"
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, ChristophHellwig <hch@infradead.org>, iommu@lists.linux-foundation.org, Marek Szyprowski <m.szyprowski@samsung.com>, mbrugger@suse.com, f.fainelli@gmail.com, wahrenst@gmx.net, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org


--=-HUsDE4pCuvQagD+CYqmq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-10-31 at 06:38 -0700, Christoph Hellwig wrote:
> On Thu, Oct 31, 2019 at 11:30:36AM +0100, Nicolas Saenz Julienne wrote:
> > On Wed, 2019-10-30 at 14:49 -0700, Christoph Hellwig wrote:
> > > On Mon, Oct 14, 2019 at 08:31:03PM +0200, Nicolas Saenz Julienne wrot=
e:
> > > > Some architectures, notably ARM, are interested in tweaking this
> > > > depending on their runtime DMA addressing limitations.
> > > >=20
> > > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > >=20
> > > Do you want me to pick this up for the 5.5 dma-mapping tree, or do yo=
u
> > > want me to wait for the rest to settle?
> >=20
> > I'd say take it, this will be ultimately needed once we push forward wi=
th
> > ARM.
>=20
> Can you resend a version that applies against 5.4-rc?  The current one
> has conflicts in the arm64 code.

Hi Catalin,
would you mind taking this patch on top of the arm64 ZONE_DMA series?

I tried to go though Christoph's tree but it ultimately clashes with the
ZONE_DMA series. It's simpler to apply it on top of your tree.

Regrads,
Nicolas


--=-HUsDE4pCuvQagD+CYqmq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl27GTIACgkQlfZmHno8
x/6rAgf/ZoMMGW7IRaV6x5ZwhpeWmnDuHERj4vzVJa0/eBKTyeFHQYuyNBygdzOW
JGunOdpAkJNo6DdJKxyUt8u5d8vvnq3mIm+g0xkoz6PxzzUtPlEuFZ1fgP1oGYIT
BdBcYj23cYMrYjtqcJJkBoBu+5JBkx28Mu5oGyWeRojupXkK+9NN53qUZMmYcFD+
Lw9i3nBQmiozrdeHMiErrYTXOkz93sipx2zeo2jF4CsOtj67BfJMhmsRogeQTIe+
Z5A6Ik+LQ8AejhKOAisJzXidZPdUwaENRKw2qicQFBoifWbqinhT6JxmrEk/AHR1
eg9iA75sotbQfuNiAzn6qCofWaKfcg==
=jqtB
-----END PGP SIGNATURE-----

--=-HUsDE4pCuvQagD+CYqmq--
