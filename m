Return-Path: <linux-kernel-owner+w=401wt.eu-S1765023AbXFRSVe@vger.kernel.org>
From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [patch] use __asm__ and __volatile__ in i386/arm/s390 byteorder.h
Date: Mon, 18 Jun 2007 14:21:37 -0400
References: <200706171833.29046.vapier@gentoo.org> <200706180124.25574.arnd@arndb.de> <20070618181101.GA15922@infradead.org>
In-Reply-To: <20070618181101.GA15922@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart49264213.hn2yi6jotN";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200706181421.38355.vapier@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Arjan van de Ven <arjan@infradead.org>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, rmk@arm.linux.org.uk
List-ID: <linux-s390.vger.kernel.org>

--nextPart49264213.hn2yi6jotN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 18 June 2007, Christoph Hellwig wrote:
> On Mon, Jun 18, 2007 at 01:24:24AM +0200, Arnd Bergmann wrote:
> > On Monday 18 June 2007, Arjan van de Ven wrote:
> > > On Sun, 2007-06-17 at 18:33 -0400, Mike Frysinger wrote:
> > > > This changes asm() to __asm__() and volatile to __volatile__ so that
> > > > these headers can be used with gcc's -std=3Dc99.
> > >
> > > hmm but the kernel doesn't use -std=3Dc99...
> >
> > The byteorder headers are exported to user space through
> > include/asm-generic/Kbuild.asm, and they are used by a number
> > of other exported headers, so they should work with any
> > gcc flags that a user might want to use.
>
> No, they should not be exported and the headers using them
> should be fixed to not require this.  Userspace has it's own
> endianess handling already.

user applications arent pulling these things in themselves ... you have to=
=20
also think of the cascading of header includes ... asm/byteorder.h gets=20
pulled in by many other things

if we want to scrub the userspace headers so that asm/byteorder.h isnt even=
=20
installed, that works for me as well, however i wouldnt discount the patch =
i=20
proposed on this alone ... the headers are inconsistent between using asm a=
nd=20
__asm__ and if anything, my patch makes them consistent
=2Dmike

--nextPart49264213.hn2yi6jotN
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)

iQIVAwUARnbNMkFjO5/oN/WBAQJJIw/8D/5S/CFGcqtp2AlUkYWEGdOm/W4o3x8q
wiD3/fc8IpAs3UibySeBuioCjE9zHy1d5i673+dOBLaGRThRJsm8q/79zfk6kZvv
SO2CkKq2tfG4mnPbUebnV+C8W8oIEzU/IxXgD0vRCe/QzNeKqdZWGU+j5bXHqB38
vou41Avaflju5xyRCnOZujXXhL6ydAtSJfy3ow9G8ekmnRDRGrlyNP3I7u0QCjTK
jyIu7Oj9U8p0VQFOIg/PNObscNRyfYTdyiPp5hGkg0A5FEKGPNUBBbDnR/ZlF5WL
d+fI/ctXVBJFEoQC8EXIPR0QNC3Xs8K6LnCo8QZs7cQS1a3FxfEnc8MAXXmwwE+P
zjR1w5Z532zt2tYMMHXforrI7lN872VYZj0VWge6ZKRPwXdUZgGhc4nX2krXa+uw
VITQXgTAI7KkNsWMX37Tx5cO2yyfOrt2U4+gULUuO64Y0LRN9u0A/PLbySZRFdLw
iNcZ97GkdgMeTXqMwnAkvailkGsTVUvSBd//DzBCUZNHp61stNtYJzjFZxg+ZgoH
Y4KHGq3kc2ykV2XzHh+A+XoQeYxkR34ayXuWOnLsoUX5NpZG09ui5sNVCvtzBagX
cZp7OZ0uXKLUyuDgqCz0K/a0cMbnOW6bce4PBEMp11uBWwCY4ZPOicHrlwEEkT1i
iq2N3DJHBvQ=
=qOCl
-----END PGP SIGNATURE-----

--nextPart49264213.hn2yi6jotN--
