From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [s390] next Feb 18: defconfig build break
Date: Wed, 18 Feb 2009 22:45:41 +1100
Message-ID: <20090218224541.fe6e0355.sfr@canb.auug.org.au>
References: <20090218191640.0b023029.sfr@canb.auug.org.au>
	<499BE300.5090405@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__18_Feb_2009_22_45_41_+1100_kRpz=/9NwJbJjCX5"
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <499BE300.5090405@in.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: "Sachin P. Sant" <sachinp@in.ibm.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-s390@vger.kernel.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

--Signature=_Wed__18_Feb_2009_22_45_41_+1100_kRpz=/9NwJbJjCX5
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sachin,

On Wed, 18 Feb 2009 15:59:20 +0530 "Sachin P. Sant" <sachinp@in.ibm.com> wr=
ote:
>
> Next Feb 18 defconfig build on s390 fails with following error.
>=20
>   CC      arch/s390/lib/string.o
> In file included from include/linux/bitmap.h:8,
>                  from include/linux/cpumask.h:142,
>                  from include/linux/smp.h:12,
>                  from /usr/local/autobench/var/tmp/build/linux/arch/s390/=
include/asm/spinlock.h:14,
>                  from include/linux/spinlock.h:88,
>                  from include/linux/seqlock.h:29,
>                  from include/linux/time.h:8,
>                  from include/linux/stat.h:60,
>                  from include/linux/module.h:10,
>                  from arch/s390/lib/string.c:13:
> include/linux/string.h: In function 'strstarts':
> include/linux/string.h:124: error: implicit declaration of function 'strl=
en'
> include/linux/string.h:124: warning: incompatible implicit declaration of=
 built-in function 'strlen'
> make[1]: *** [arch/s390/lib/string.o] Error 1
> make: *** [arch/s390/lib] Error 2

That would be a side effect of commit 43a47c6ca0e0b5479ae316e188a28b7e625d4=
1e5 ("misc:strstarts") from the rr tree.  Rusty cc'd.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__18_Feb_2009_22_45_41_+1100_kRpz=/9NwJbJjCX5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmb9OYACgkQjjKRsyhoI8wSdACgmbvoEX84JVRouyp8V7FTgUyk
2QAAnRFApYlwwuo6OdMthzmigXBnPFxr
=GUlX
-----END PGP SIGNATURE-----

--Signature=_Wed__18_Feb_2009_22_45_41_+1100_kRpz=/9NwJbJjCX5--
