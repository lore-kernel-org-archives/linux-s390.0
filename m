From: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 2/4] panic: Allow taint flag for warnings to be changed
 from TAINT_WARN
Date: Wed, 24 Mar 2010 22:11:15 +1100
Message-ID: <1269429075.2500.5.camel@concordia>
References: <1269126097.18314.111.camel@localhost>
	 <1269126340.18314.115.camel@localhost>
Reply-To: michael@ellerman.id.au
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-SQzw8iyBB5lB+1zvqHUK"
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1269126340.18314.115.camel@localhost>
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-s390@vger.kernel.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>
List-ID: <linux-s390.vger.kernel.org>


--=-SQzw8iyBB5lB+1zvqHUK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2010-03-20 at 23:05 +0000, Ben Hutchings wrote:
> WARN() is used in some places to report firmware or hardware bugs that
> are then worked-around.  These bugs do not affect the stability of the
> kernel and should not set the usual TAINT_WARN flag.  To allow for
> this, add WARN_TAINT() and WARN_TAINT_ONCE() macros that take a taint
> flag as argument.
..
> The architecture-specific changes here are untested and need to be
> reviewed by architecture maintainers.

I'm not one of them, but this at least builds on powerpc FWIW.

cheers

--=-SQzw8iyBB5lB+1zvqHUK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkup80wACgkQdSjSd0sB4dIztACgqdsQgORNZPCSzn7hLuXW0Lxs
CgMAn3Q8KMC7wAK7ce/Z3AZ9SQ+1QrUy
=p3xA
-----END PGP SIGNATURE-----

--=-SQzw8iyBB5lB+1zvqHUK--
