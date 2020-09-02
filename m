Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgIBRip (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 2 Sep 2020 13:38:45 -0400
Date: Wed, 2 Sep 2020 18:38:03 +0100
From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/3] arm64: Convert to ARCH_STACKWALK
Message-ID: <20200902173803.GE6162@sirena.org.uk>
References: <20200819124913.37261-1-broonie@kernel.org>
 <20200901160626.GE95447@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jTMWTj4UTAEmbWeb"
Content-Disposition: inline
In-Reply-To: <20200901160626.GE95447@C02TD0UTHF1T.local>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>


--jTMWTj4UTAEmbWeb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2020 at 05:06:26PM +0100, Mark Rutland wrote:

> Just to check, has the skipping logic been tested to work equivalently
> to what we had before? By inspection I think it should, but since it
> relies on function call boundaries it always strikes me as fragile.

> If you could confirm that (e.g. with LKDTM perhaps?)=A0that'd be great.
> Assuming that looks right, for the series:

I've tested this with LKDTM and otherwise and didn't spot any issues
(and just did a bit of retesting) but it is a pretty manual process so
it's possible I missed something.

--jTMWTj4UTAEmbWeb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9P2HoACgkQJNaLcl1U
h9BFyAf/WmL+czCJwJk4VCBeI8Qs2/FFr8HfxOjvcihHhHLoo47xrAWoGVeJcoGB
B0KxiGvi/sgW230Q8vgawFwzN5pte2FFt8RoXRKNste1aMWTVp2d66nHXg4T3Xa+
1tzhUh1MBWkQCDW2lKroA6RFs4UIX8b0ulYz26VFwpE/is4vcAv77AnCYNIMfqa1
cC/FbZO4VJfSu5vgdtrMSmt0NAczKRI5OpO056olErHtnSmBxagekOrMyDofUwjz
TKcOHNMwH/BdiQFL7BjqDZykxwV1MKNcaXSEd/HTsnCurMbMTCfAsakolqbDDDiL
DG06jT7beQldWH9+cTAb45lPf08ifQ==
=knFg
-----END PGP SIGNATURE-----

--jTMWTj4UTAEmbWeb--
