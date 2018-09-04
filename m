From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] [RFC v2] Drop all 00-INDEX files from Documentation/
Date: Tue, 4 Sep 2018 13:30:30 +0200
Message-ID: <20180904113030.GB25177@amd>
References: <1536012923-16275-1-git-send-email-henrik@austad.us>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1037788062=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1536012923-16275-1-git-send-email-henrik@austad.us>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
List-Archive: <https://lore.kernel.org/dri-devel/>
To: Henrik Austad <henrik@austad.us>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org, linux-fbdev@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, James Hogan <jhogan@kernel.org>, Will Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Jan Kandziora <jjj@gmx.de>, Paul Mackerras <paulus@samba.org>, Henrik Austad <haustad@cisco.com>, "H. Peter Anvin" <hpa@zytor.com>, Evgeniy Polyakov <zbr@ioremap.net>, linux-s390@vger.kernel.org, Ian Kent <raven@themaw.net>, linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, Jonathan Corbet <corbet@lwn.net>, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>P
List-ID: <linux-s390.vger.kernel.org>


--===============1037788062==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The 00-INDEX files are supposed to give a summary of all files present
> in a directory, but these files are horribly out of date and their
> usefulness is brought into question. Often a simple "ls" would reveal
> the same information as the filenames are generally quite descriptive as
> a short introduction to what the file covers (it should not surprise


> -SAK.txt
> -	- info on Secure Attention Keys.
> -SM501.txt
> -	- Silicon Motion SM501 multimedia companion chip
> -btmrvl.txt
> -	- info on Marvell Bluetooth driver usage.

Well, I don't know what sm501 is, but description helps me. SAK is
similar. .. as is btmrvl.

I'd say this is still quite valueable, and it might be worth fixing,
rather then removing completely.

And yes, moving stuff to subdirectories and naming files reasonably
would help, too. "btmrvl" is really bad name...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluObNYACgkQMOfwapXb+vIEUgCfflpJ++Ke7RojgYEKLcv9wdCK
VcAAoJ44RGl6/ZbjcSM3g58FnjCGx/f+
=c4sE
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--

--===============1037788062==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1037788062==--
