Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bilbo.ozlabs.org ([203.11.71.1]:58317 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbfHBAUa (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 1 Aug 2019 20:20:30 -0400
Date: Fri, 2 Aug 2019 10:20:19 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: Tree for Jul 31 - s390 crypto build breakage
Message-ID: <20190802102019.6a789c51@canb.auug.org.au>
In-Reply-To: <CAKv+Gu_1HP2NapMk5O_-XpJdga5zyFJDkVudTRT6CWm+tqPndA@mail.gmail.com>
References: <20190731163915.3fdfcb14@canb.auug.org.au>
        <20190731085819.GA3488@osiris>
        <20190731110816.GA20753@gondor.apana.org.au>
        <20190731111520.GC3488@osiris>
        <20190731113216.GA21068@gondor.apana.org.au>
        <20190731114453.GD3488@osiris>
        <20190801122849.GB4163@osiris>
        <CAKv+Gu_1HP2NapMk5O_-XpJdga5zyFJDkVudTRT6CWm+tqPndA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wVw44K.uM21QiDqGKSG=HiW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Harald Freudenberger <freude@linux.ibm.com>, Patrick Steuer <steuer@linux.ibm.com>, Ondrej Mosnacek <omosnace@redhat.com>

--Sig_/wVw44K.uM21QiDqGKSG=HiW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Herbert,

On Thu, 1 Aug 2019 20:28:56 +0300 Ard Biesheuvel <ard.biesheuvel@linaro.org=
> wrote:
>
> On Thu, 1 Aug 2019 at 15:28, Heiko Carstens <heiko.carstens@de.ibm.com> w=
rote:
> >
> > On Wed, Jul 31, 2019 at 01:44:54PM +0200, Heiko Carstens wrote: =20
> > > On Wed, Jul 31, 2019 at 09:32:16PM +1000, Herbert Xu wrote: =20
> > > > On Wed, Jul 31, 2019 at 01:15:20PM +0200, Heiko Carstens wrote: =20
> > > > >
> > > > > However that doesn't fix the simd.h header file breakage with the
> > > > > second patch :) =20
> > > >
> > > > That fix should be there now too. =20
> > >
> > > Yes, works now. Thank you! =20
> >
> > Still not... with linux-next as of today I get this (s390 defconfig):
> >
> > ERROR: "crypto_aegis128_decrypt_chunk_simd" [crypto/aegis128.ko] undefi=
ned!
> > ERROR: "crypto_aegis128_update_simd" [crypto/aegis128.ko] undefined!
> > ERROR: "crypto_aegis128_encrypt_chunk_simd" [crypto/aegis128.ko] undefi=
ned!
> > scripts/Makefile.modpost:105: recipe for target 'modules-modpost' failed
> > =20
>=20
> Hello Heiko,
>=20
> Apologies for the breakage. The first two fixes addressed obvious
> shortcomings in my code, but with this issue, I'm a bit puzzled tbh.
> The calls to these missing functions should be optimized away, since
> have_simd never gets assigned if CONFIG_CRYPTO_AEGIS128_SIMD is not
> defined, but for some reason, this isn't working. Which version of GCC
> are you using?
>=20
> Also, could you please try whether the patch below fixes the problem? Tha=
nks
>=20
> https://lore.kernel.org/linux-crypto/20190729074434.21064-1-ard.biesheuve=
l@linaro.org/

It might be time to revert all this series and try again.  The
implementation seems to have not been well thought through from a kernel
building point of view.  For a start the two commits

  7cdc0ddbf74a ("crypto: aegis128 - add support for SIMD acceleration")
  ecc8bc81f2fb ("crypto: aegis128 - provide a SIMD implementation based on =
NEON intrinsics")

seem to be in the wrong order (function used in the first before being
defined in the second).  There are a series of declarations of external
functions in crypto/aegis128-core.c that should be in a header file.
And there was the assumption that asm/simd.h was available everywhere.

Also crypto_aegis128_decrypt_chunk_simd() is referenced in a structure
initialisation (unprotected by any CONFIG_ variable - and so will be
referenced even if it does not exist).  The compiler will have a hard
time knowing that "have_simd" is effectively a constant zero (and
crypto_simd_usable() is not constant).
--=20
Cheers,
Stephen Rothwell

--Sig_/wVw44K.uM21QiDqGKSG=HiW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1DgcMACgkQAVBC80lX
0Gwx/Af/cVufoIrfiSSSl7Y9kjmf50nbufyfwr0bVq1E4/cox6s3YYwm5YjksyAv
0Va0rY0BckXUkkFT6wi27uqVnX61synIjcUUDB4Gossa1LtK3+BlBqyWc2i8KYWk
f04gN4Q8Y+CriSJPMkuXXy6mi0fp/kdxbfiJe4kag2Hs+5XCpVnDt3vwk4CP3Eci
iasyqK5spS0ZcUBr8T6KmtiW8QmkO7wtdNnJOjeCFcioNihAu+KAK6yhaKtjAsIW
/9uU761Bvzow2XqRp8uf71FXfWbiMKcJzJ+/ln5te2AS+4PFhU5vZtYeIYEZUN0w
tuGhZn+FzLeLjMP1ZoPUVFCy4b0qFw==
=WIXM
-----END PGP SIGNATURE-----

--Sig_/wVw44K.uM21QiDqGKSG=HiW--
