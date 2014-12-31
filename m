From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 31 Dec 2014 05:56:59 +0000
Subject: enabling kvm w/SPLIT_PTLOCK_CPUS > NR_CPUS fails to build in pgtable.c
Message-Id: <20141231055659.GD3906@vapier.wh0rd.info>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--GyRA7555PLgSTuth"
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


--GyRA7555PLgSTuth
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

i've configured my kernel to have:
	CONFIG_KVM=3Dy
	CONFIG_NR_CPUS=3D2
	CONFIG_SPLIT_PTLOCK_CPUS=3D4

and that makes the build very unhappy:
	  CC      arch/s390/mm/pgtable.o
	arch/s390/mm/pgtable.c: In function =E2=80=98__gmap_segment_gaddr=E2=80=99:
	arch/s390/mm/pgtable.c:327:2: error: implicit declaration of function=20
	=E2=80=98pmd_to_page=E2=80=99 [-Werror=3Dimplicit-function-declaration]
	  page =3D pmd_to_page((pmd_t *) entry);
	  ^

this is because include/linux/mm_types.h has:
	#define USE_SPLIT_PMD_PTLOCKS	(USE_SPLIT_PTE_PTLOCKS && \
			IS_ENABLED(CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK))

and include/linux/mm.h has:
	#if USE_SPLIT_PMD_PTLOCKS
	static struct page *pmd_to_page(pmd_t *pmd)
	...

i did set NR_CPUS down on purpose (this system only has two cpus), but=20
apparently tweaking SPLIT_PTLOCK_CPUS isn't an option :).  in mm/Kconfig:
	config SPLIT_PTLOCK_CPUS
		int
		default "4"
-mike

--GyRA7555PLgSTuth
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUo5ArAAoJEEFjO5/oN/WBqBAP/3u2ZRVeWDeCy1yjSKxFC4nA
UG6iilpYCjmcIrAkSH90ATEkazyDwgeAVvaYaXbnX7mAoYSaz1l7CbtK8/kMLqqm
U5Sz0qHAmbFMhKufczKDZp4IzrXOXooy3hVdBJKuOPr2+hdNr6Zs4KYFnp5bQdgQ
q8dJMJ1XEmVUyn6VcDzU3E+KvS6/WaBwBP51mHSUdbHQfbeI4ufrGm0aZ+vLwcpA
weI98vx8Vq2fxyQxcMAEAn5Z5H2kK6gJ8Aup1nr3p6lgdMv9qB9VW0jRACsN6VZo
7Wth0Lxko9TbMuOO0y6VSpzj/9xGMWStNM7xdxIjRq7XjGmBNA77TzyFw1Bo3abr
x2a1ExPSw+3bN4f/XhZySeObkfoNvJ4hr8aZxLATgbtFYZitUiGSx4FXdwG6YFjQ
d8Jy3AS9V7Fp7QLEd+ZQOeW8ygrHb+dYcU/DTaGAy+tx+2mut/DKN59e95/icows
UV2JHtmaqQrzrDcM25NjkYk+7bqk2Csy9uEre6a6XB3x7enWc9pmi1eZwXVSv8Qd
xd46ZzBW7Xar1Ae3MT++XbIBPSGAzWinSH4qhzUEQ+V7bKr7cqNpvYfL6pxJ37zg
OqwIv6Yy4qnGKKInQdJTuuZ9+Su/kJ9AJUhCGgAxHNyQisvSZ9yU15QcGMnRO95Y
h/ZXXDIIkBnUeEzHkQua
=ZKud
-----END PGP SIGNATURE-----

--GyRA7555PLgSTuth--
