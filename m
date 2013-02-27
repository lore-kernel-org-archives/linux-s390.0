From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] Consolidate CONFIG_DEBUG_STRICT_USER_COPY_CHECK
Date: Thu, 28 Feb 2013 09:45:10 +1100
Message-ID: <20130228094510.3341017130e4476e046bdd22@canb.auug.org.au>
References: <1361934016-22630-1-git-send-email-sboyd@codeaurora.org>
	<201302272032.21014.arnd@arndb.de>
	<512E6FA9.4060504@codeaurora.org>
	<512E8664.3070903@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__28_Feb_2013_09_45_10_+1100_i+n3.uHYzm3pPRiH"
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <512E8664.3070903@zytor.com>
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, Helge Deller <deller@gmx.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Chris Metcalf <cmetcalf@tilera.com>
List-ID: <linux-s390.vger.kernel.org>

--Signature=_Thu__28_Feb_2013_09_45_10_+1100_i+n3.uHYzm3pPRiH
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 27 Feb 2013 14:19:16 -0800 "H. Peter Anvin" <hpa@zytor.com> wrote:
>
> Although some of the cases I have seen being flagged as "false
> positives" have been real bugs.

[hijacking the thread :-)]

I have been getting this warning for a very long time ( which would be an
error if CONFIG_DEBUG_STRICT_USER_COPY_CHECK was set):

i386 defconfig
i386-linux-gcc (GCC) 4.6.3

In file included from arch/x86/include/asm/uaccess.h:537:0,
                 from include/linux/uaccess.h:5,
                 from include/linux/highmem.h:8,
                 from include/linux/pagemap.h:10,
                 from fs/binfmt_misc.c:27:
arch/x86/include/asm/uaccess_32.h: In function 'parse_command.part.2':
arch/x86/include/asm/uaccess_32.h:211:26: warning: call to 'copy_from_user_=
overflow' declared with attribute warning: copy_from_user() buffer size is =
not provably correct [enabled by default]

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Thu__28_Feb_2013_09_45_10_+1100_i+n3.uHYzm3pPRiH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJRLox2AAoJEECxmPOUX5FEAKwQAKmHBfYdwxb9iYsBLdeD9DnN
MkEc6ZrCNma+Q0YI5hKbSpZMSM5232+J7d4Ft2E0K7g3ysVt0lOGt+Pkt3FCCeMA
Dou3c5LOk1sALsqKvTVAkCRDqWJcKWlEdc82E+X1pqfvF+6Q2fS9B5OKZN4AfABn
3HDJRiVcXirrByOglAeEWI+l70RjQNAE1VsZzTpt6YRl1Dl1jfweQgz9IwCbPQWi
XCpYg9iuNX3+Ng2eF1jT5d9Vs5nQ0kUSdnae/BXKWfU8LidrQHBY1SuprQw6IYk+
OfJIH9uXLViuXtx+Z1TBvASUrsJ8wYwuuq1ghg7PnO60ldk7yEQHYz9uHbvGKTVH
fJZWagZS+p81+DLoeXjGyIUAP8FqepG5jIny4odu+wU0IWqD7quNVF10z4D33mOZ
iBMudKnnnFJ2bQGo5UuSabfKWyIoZPhAl31EkhHoAZm3+nMboAlUMygxmMJzt8Gw
GFtmgp0b8ThvMJKCWBl/b7Nolzwyer6U6k0dNRhjYhR9NVWbDz/7PnRbCBBC4DuP
tCVyZLP1S2hunSlHpCjAQMgKew4dQpxUtCagD1Z1XONXIpQvwdk1MARa+zviuyFf
ACZu5SQD2lSTHle7ensmlIK4dMPF0kBs+wn5wHvIptyD6hXndjwEgcAHuXF+pql+
YdfN39MR3E6j7sxOQIzB
=2dht
-----END PGP SIGNATURE-----

--Signature=_Thu__28_Feb_2013_09_45_10_+1100_i+n3.uHYzm3pPRiH--
