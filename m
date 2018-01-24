From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Avoiding information leaks between users and between processes
 by default? [Was: : [PATCH 1/5] prctl: add PR_ISOLATE_BP process control]
Date: Wed, 24 Jan 2018 12:15:53 +0100
Message-ID: <20180124111552.GA24675@amd>
References: <1516712825-2917-1-git-send-email-schwidefsky@de.ibm.com>
 <1516712825-2917-2-git-send-email-schwidefsky@de.ibm.com>
 <20180123170719.GA4154@isilmar-4.linta.de>
 <20180124072953.50851fec@mschwideX1>
 <20180124083705.GA14868@light.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180124083705.GA14868@light.dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>, w@1wt.eu, keescook@chromium.org, thomas.lendacky@amd.com, dwmw@amazon.co.uk, ak@linux.intel.com
List-ID: <linux-s390.vger.kernel.org>


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Wed 2018-01-24 09:37:05, Dominik Brodowski wrote:
> On Wed, Jan 24, 2018 at 07:29:53AM +0100, Martin Schwidefsky wrote:
> > On Tue, 23 Jan 2018 18:07:19 +0100
> > Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> >=20
> > > On Tue, Jan 23, 2018 at 02:07:01PM +0100, Martin Schwidefsky wrote:
> > > > Add the PR_ISOLATE_BP operation to prctl. The effect of the process
> > > > control is to make all branch prediction entries created by the exe=
cution
> > > > of the user space code of this task not applicable to kernel code o=
r the
> > > > code of any other task. =20
> > >=20
> > > What is the rationale for requiring a per-process *opt-in* for this a=
dded
> > > protection?
> > >=20
> > > For KPTI on x86, the exact opposite approach is being discussed (see,=
 e.g.
> > > http://lkml.kernel.org/r/1515612500-14505-1-git-send-email-w@1wt.eu )=
: By
> > > default, play it safe, with KPTI enabled. But for "trusted" processes=
, one
> > > may opt out using prctrl.
> >=20
> > The rationale is that there are cases where you got code from *somewher=
e*
> > and want to run it in an isolated context. Think: a docker container th=
at
> > runs under KVM. But with spectre this is still not really safe. So you
> > include a wrapper program in the docker container to use the trap door
> > prctl to start the potential malicious program. Now you should be good,=
 no?
>=20
> Well, partly. It may be that s390 and its use cases are special -- but as=
 I
> understand it, this uapi question goes beyond this question:
>=20
> To my understanding, Linux traditionally tried to aim for the security go=
al
> of avoiding information leaks *between* users[+], probably even between
> processes of the same user. It wasn't a guarantee, and there always

It used to be guarantee. It still is, on non-buggy CPUs.

Leaks between users need to be prevented.

Leaks between one user should be prevented, too. There are various
ways to restrict the user these days, and for example sandboxed
chromium process should not be able to read my ~/.ssh.

can_ptrace() is closer to "can allow leaks between these two". Still
not quite there, as code might be running in process that
can_ptrace(), but the code has been audited by JIT or something not to
do syscalls.

> (and will be) information leaks -- and that is where additional safeguards
> such as seccomp come into play, which reduce the attack surface against
> unknown or unresolved security-related bugs. And everyone knew (or should
> have known) that allowing "untrusted" code to be run (be it by an user, be
> it JavaScript, etc.) is more risky. But still, avoiding information leaks
> between users and between processes was (to my understanding) at least a
> goal.[=A7]
>=20
> In recent days however, the outlook on this issue seems to have shifted:
>=20
> - Your proposal would mean to trust all userspace code, unless it is
>   specifically marked as untrusted. As I understand it, this would mean t=
hat
>   by default, spectre isn't fully mitigated cross-user and cross-process,
>   though the kernel could. And rogue user-run code may make use of that,
>   unless it is run with a special wrapper.

Yeah, well, that proposal does not fly, then.

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpoaugACgkQMOfwapXb+vJ9vgCghL66s+G4pVZmQ0EB+S/PsJ5A
6GsAoJsm1vNAcC06gBR0pbeG4rvPrpws
=A/aW
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
