Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from ozlabs.org ([203.11.71.1]:42111 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbgEDVId (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 4 May 2020 17:08:33 -0400
Date: Tue, 5 May 2020 07:08:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: Tree for May 4 --> mm: free_area_init: allow
 defining max_zone_pfn in descending order does increase memory use
Message-ID: <20200505070828.20fd21af@canb.auug.org.au>
In-Reply-To: <20200504154410.GF342687@linux.ibm.com>
References: <20200504173547.2cdd83bf@canb.auug.org.au>
        <9e9edd1e-6653-a585-0e22-69930a07dce1@de.ibm.com>
        <20200504154410.GF342687@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EC8ktDc27Ll0Q6ltM8Z62Nm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Marc Hartmayer <mhartmay@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

--Sig_/EC8ktDc27Ll0Q6ltM8Z62Nm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mike,

On Mon, 4 May 2020 18:44:10 +0300 Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> Ho Christian,
>=20
> On Mon, May 04, 2020 at 04:50:06PM +0200, Christian Borntraeger wrote:
> > Mike,
> > commit 51a2f644fd020d5f090044825c388444d11029d ("mm: free_area_init: al=
low defining max_zone_pfn in descending order")
> > does increase the memory use on s390 (e.g. 700 MB vs.1.8 GB).
> >=20
> > Something is odd in this patch. Any idea? =20
>=20
> Yeah, this patch is buggy. In short, it breaks zone size calculation on
> s390 and some other architectures.
>=20
> I've just replied at [1] with more details and a fix.
>=20
> [1] https://lore.kernel.org/linux-mm/20200504153901.GM14260@kernel.org/

I have added that to linux-next for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/EC8ktDc27Ll0Q6ltM8Z62Nm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6whEwACgkQAVBC80lX
0GzmWwf+JTR9NVgZ198HKHx7MTJLK6YQL0hAXJV5Dz/0wmzoL2UDKclFwic2HZv9
wK9ztJaqX20Vdxq6zbQMB/xvTiItLdbe8EosmrPdG46BeocBOKX0AInV/zRb9K9P
GgJPZemdo3HJqLPqY4Djw/CWTewa6g21M5xg5HMy5EbnTRSitEotZuHt69EHmJKo
nuPEFRG/cn8xXel/4963dNTFfTESCFOPs++wooDHFQ0mQzAnsR3nKMcEVZYFb1Br
T7wSanues09dSqhsC+lJDe37tyMwcU5N/y2NusDKahBn63aZEz/q/qXNrbBDhYgE
RqXCWfPt+gliNxsihqbuk5o9lYk/pQ==
=1Mmd
-----END PGP SIGNATURE-----

--Sig_/EC8ktDc27Ll0Q6ltM8Z62Nm--
