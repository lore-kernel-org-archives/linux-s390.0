From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [-next Jan 18] Boot failure on s390 with DEVTMPFS=y
Date: Wed, 20 Jan 2010 10:49:16 +1100
Message-ID: <20100120104916.e1a2653e.sfr@canb.auug.org.au>
References: <20100118195743.b45f119e.sfr@canb.auug.org.au>
	<4B546E7B.2080900@in.ibm.com>
	<ac3eb2511001180631r5209dff6s83ecdaee708e0b0b@mail.gmail.com>
	<20100119211422.GA10319@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__20_Jan_2010_10_49_16_+1100_YdH.d1HFjOPkHKsi"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756049Ab0ASXt1@vger.kernel.org>
In-Reply-To: <20100119211422.GA10319@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Greg KH <greg@kroah.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>, Sachin Sant <sachinp@in.ibm.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

--Signature=_Wed__20_Jan_2010_10_49_16_+1100_YdH.d1HFjOPkHKsi
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Tue, 19 Jan 2010 13:14:22 -0800 Greg KH <greg@kroah.com> wrote:
>
> On Mon, Jan 18, 2010 at 03:31:09PM +0100, Kay Sievers wrote:
> >=20
> > Heiko Carstens posted a simple patch to work around the issue that
> > s390 write-protects the string, the option parser tries to modify.
> > When Greg has pick it up, this should be fixed.
>=20
> Yes, I've now queued it up in my trees.

Great.  Another one bites the dust :-)
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__20_Jan_2010_10_49_16_+1100_YdH.d1HFjOPkHKsi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAktWRPwACgkQjjKRsyhoI8xMggCfUm1LRYqNAvL0GjpzcEG4NPVY
U8QAn3RuB7bpY1ApMJikSi7F4Fw5WuUl
=B4Ub
-----END PGP SIGNATURE-----

--Signature=_Wed__20_Jan_2010_10_49_16_+1100_YdH.d1HFjOPkHKsi--
