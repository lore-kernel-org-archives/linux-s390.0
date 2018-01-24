From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Avoiding information leaks between users and between processes
 by default? [Was: : [PATCH 1/5] prctl: add PR_ISOLATE_BP process control]
Date: Wed, 24 Jan 2018 20:01:05 +0100
Message-ID: <20180124190105.GA30107@amd>
References: <1516712825-2917-1-git-send-email-schwidefsky@de.ibm.com>
 <1516712825-2917-2-git-send-email-schwidefsky@de.ibm.com>
 <20180123170719.GA4154@isilmar-4.linta.de>
 <20180124072953.50851fec@mschwideX1>
 <20180124083705.GA14868@light.dominikbrodowski.net>
 <20180124111552.GA24675@amd>
 <20180124134803.3e11c6d6@mschwideX1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180124134803.3e11c6d6@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>, w@1wt.eu, keescook@chromium.org, thomas.lendacky@amd.com, dwmw@amazon.co.uk, ak@linux.intel.com
List-ID: <linux-s390.vger.kernel.org>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
> > On Wed 2018-01-24 09:37:05, Dominik Brodowski wrote:
> > > On Wed, Jan 24, 2018 at 07:29:53AM +0100, Martin Schwidefsky wrote: =
=20
> > > > On Tue, 23 Jan 2018 18:07:19 +0100
> > > > Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> > > >  =20
> > > > > On Tue, Jan 23, 2018 at 02:07:01PM +0100, Martin Schwidefsky wrot=
e: =20

> > > Well, partly. It may be that s390 and its use cases are special -- bu=
t as I
> > > understand it, this uapi question goes beyond this question:
> > >=20
> > > To my understanding, Linux traditionally tried to aim for the securit=
y goal
> > > of avoiding information leaks *between* users[+], probably even betwe=
en
> > > processes of the same user. It wasn't a guarantee, and there always =
=20
> >=20
> > It used to be guarantee. It still is, on non-buggy CPUs.
>=20
> In a perfect world none of this would have ever happened.
> But reality begs to differ.

Ok, so: "Linux traditionally guarantees lack of information leaks
between PIDs". Yes, you can use ptrace, but that should be it.

> > Leaks between users need to be prevented.
> >=20
> > Leaks between one user should be prevented, too. There are various
> > ways to restrict the user these days, and for example sandboxed
> > chromium process should not be able to read my ~/.ssh.
>=20
> Interesting that you mention the use case of a sandboxed browser process.
> Why do you sandbox it in the first place? Because your do not trust it
> as it might download malicious java-script code which uses some form of
> attack to read the content of your ~/.ssh files. That is the use case for
> the new prctl, limit this piece of code you *identified* as
> untrusted.

See Alan Cox's replies.

Anyway. There's more than one way to mark process as untrusted,
(setuid nobody, seccomp, chroot nowhere, ptrace jail, ...). Do not
attempt to add prctl() to the list.

> > > In recent days however, the outlook on this issue seems to have shift=
ed:
> > >=20
> > > - Your proposal would mean to trust all userspace code, unless it is
> > >   specifically marked as untrusted. As I understand it, this would me=
an that
> > >   by default, spectre isn't fully mitigated cross-user and cross-proc=
ess,
> > >   though the kernel could. And rogue user-run code may make use of th=
at,
> > >   unless it is run with a special wrapper. =20
> >=20
> > Yeah, well, that proposal does not fly, then.
> =20
> It does not fly as a solution for the general case if cross-process attac=
ks.
> But for the special case where you can identify all of the potential untr=
usted
> code in your setup it should work just fine, no?

Well.. you can identify all of the untrusted code. Anything that does
not have CAP_HW_ACCESS is untrusted :-).

Anyway, no need to add prctl(), if A can ptrace B and B can ptrace A,
leaking info between them should not be a big deal. You can probably
find existing macros doing neccessary checks.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpo1/EACgkQMOfwapXb+vKqmwCeKaJUknH5s8oNaYKBOsUcEZJi
NeEAnRQ6hjNSiH05Wu3m0+UYr9lnGRWZ
=c2XZ
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
