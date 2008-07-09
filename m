From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH linux-next] fix s390 compile error due to
 smp_call_function
Date: Thu, 10 Jul 2008 02:21:40 +1000
Message-ID: <20080710022140.0eaf9f8d.sfr@canb.auug.org.au>
References: <200807081625.50437.borntraeger@de.ibm.com>
	<20080709143639.GB24152@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__10_Jul_2008_02_21_40_+1000_/MVl4LXmSvP.+Eil"
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20080709143639.GB24152@osiris.boeblingen.de.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Jens Axboe <jens.axboe@oracle.com>, linux-next@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

--Signature=_Thu__10_Jul_2008_02_21_40_+1000_/MVl4LXmSvP.+Eil
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Heiko,

On Wed, 9 Jul 2008 16:36:39 +0200 Heiko Carstens <heiko.carstens@de.ibm.com=
> wrote:
>
> Stephen, could you add this patch to your build fixes?
> Currently it won't fit into git-s390 or Jens' smp_call_function
> tree, since these two call sites are introduced with a new
> patch in git-s390 (stp support).

Will do.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__10_Jul_2008_02_21_40_+1000_/MVl4LXmSvP.+Eil
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkh05ZQACgkQjjKRsyhoI8zu1gCfStFgg1wc+BVbiyklOm1/c/uJ
7nYAn1dgm8O/JhbRM3UCMLKq9sTRi9+H
=pmN/
-----END PGP SIGNATURE-----

--Signature=_Thu__10_Jul_2008_02_21_40_+1000_/MVl4LXmSvP.+Eil--
