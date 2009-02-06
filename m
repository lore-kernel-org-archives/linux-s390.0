Return-Path: <linux-kernel-owner+w=401wt.eu-S1753549AbZBFNHO@vger.kernel.org>
Date: Sat, 7 Feb 2009 00:06:36 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Next 0205 build break : drivers/s390/block/dasd_proc.o
Message-Id: <20090207000636.ee67c759.sfr@canb.auug.org.au>
In-Reply-To: <498C03E1.1040204@in.ibm.com>
References: <498C03E1.1040204@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__7_Feb_2009_00_06_36_+1100_KnxsDh.GvvIKdnh2"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Sachin P. Sant" <sachinp@in.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Mel Gorman <mel@csn.ul.ie>, Alexey Dobriyan <adobriyan@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

--Signature=_Sat__7_Feb_2009_00_06_36_+1100_KnxsDh.GvvIKdnh2
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 06 Feb 2009 15:03:21 +0530 "Sachin P. Sant" <sachinp@in.ibm.com> wr=
ote:
>
> Next 0205 defconfig build on s390x fails with :
>=20
>   CC      drivers/s390/block/dasd_proc.o
> drivers/s390/block/dasd_proc.c: In function dasd_proc_init:
> drivers/s390/block/dasd_proc.c:321: error: struct proc_dir_entry has no m=
ember named owner
> drivers/s390/block/dasd_proc.c:335: error: struct proc_dir_entry has no m=
ember named owner
> make[1]: *** [drivers/s390/block/dasd_proc.o] Error 1
> make: *** [drivers/s390/block/dasd_proc.o] Error 2

Looks like commit 4d38a69c6bc847828ae89c2249e82671ed4061c5 ("proc 2/2:
remove struct prioc_dir_entry::owner") from the proc tree missed at least
a couple.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__7_Feb_2009_00_06_36_+1100_KnxsDh.GvvIKdnh2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmMNdwACgkQjjKRsyhoI8zbvgCgvX/BRPjilCD6rvtji++cXeNa
I1IAoLe9h1V9uGyHBaFnABLIXSmvYHMR
=vWP2
-----END PGP SIGNATURE-----

--Signature=_Sat__7_Feb_2009_00_06_36_+1100_KnxsDh.GvvIKdnh2--
