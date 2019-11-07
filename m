Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from ozlabs.org ([203.11.71.1]:34557 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbfKGGfD (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 7 Nov 2019 01:35:03 -0500
Date: Thu, 7 Nov 2019 17:34:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Please add powerpc topic/kasan-bitops branch to linux-next
Message-ID: <20191107173451.6be74953@canb.auug.org.au>
In-Reply-To: <87r22k5nrz.fsf@mpe.ellerman.id.au>
References: <87r22k5nrz.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QLj.mRHKb6JGbFGyiT8jLoU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-next@vger.kernel.org, christophe.leroy@c-s.fr, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com, Daniel Axtens <dja@axtens.net>

--Sig_/QLj.mRHKb6JGbFGyiT8jLoU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Thu, 07 Nov 2019 15:11:12 +1100 Michael Ellerman <mpe@ellerman.id.au> wr=
ote:
>
> Can you please add the topic/kasan-bitops tree of the powerpc repository
> to linux-next.
>=20
> powerpc         git     git://git.kernel.org/pub/scm/linux/kernel/git/pow=
erpc/linux.git#topic/kasan-bitops
>=20
> See:
>   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/log/?=
h=3Dtopic/kasan-bitops
>=20
> This will be a (hopefully) short lived branch to carry some cross
> architecture KASAN related patches for v5.5.

Added from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/QLj.mRHKb6JGbFGyiT8jLoU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3DuwsACgkQAVBC80lX
0Gx+nQf+Kb9/DdUAxGd+w9sWu1q0Z+Hiq9qD8vwzOM0/tFtNdMhWLOJRM0idUy9Q
NHHN0yi54olE5bolHbOqmXXITBE+Dy7RyRUchaPSMkUgAAI8n+iteHy4/ZakmJr+
6lYeGHjGzM9+9q5eYl6yD7hj6cAAyI4wBUu0fMYBcuWix/xOImWZAe/6iGRhgRLf
UAzDGUbnyqpox0S0v10SJjbTkGXyuvaxzs27pGUBZbRODNPbZYEX7hpo5TnQxzBq
ZMkJaRdxAKi0szigouKz9d75XPKNmc4zz5tY9gCShmBlE6bjJHzVF0ntNGrge78W
mMgfvcvatGMcL/fbSn8nu3+vqMnFpg==
=XNA5
-----END PGP SIGNATURE-----

--Sig_/QLj.mRHKb6JGbFGyiT8jLoU--
