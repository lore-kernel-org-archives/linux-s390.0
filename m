Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53754 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409957AbgJPPY1 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 16 Oct 2020 11:24:27 -0400
Date: Fri, 16 Oct 2020 17:24:19 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: Is OS_INFO_VMCOREINFO unimplemented?
Message-ID: <20201016172419.3abfdeda@ezekiel.suse.cz>
In-Reply-To: <20201016161125.2fcf494d@ibm>
References: <20201013145303.6f99fe89@ezekiel.suse.cz>
        <20201016161125.2fcf494d@ibm>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/J0NdDn94vZ/rqqA9iOHb9hf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
List-ID: <linux-s390.vger.kernel.org>
To: Philipp Rudo <prudo@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Michael Holzheu <holzheu@linux.vnet.ibm.com>

--Sig_/J0NdDn94vZ/rqqA9iOHb9hf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Philipp,

On Fri, 16 Oct 2020 16:11:25 +0200
Philipp Rudo <prudo@linux.ibm.com> wrote:

> Hi Petr,
>=20
> sorry for the late reply.

No problem. ;-)

> It's an interface for non-Linux systems for the stand-alone kdump.
>=20
> But that's all I'm sure of. I'm afraid only Michael knows the full history
> behind the implementation. Unfortunately he left IBM ~2 years ago so this=
 piece
> of knowledge is lost...
>=20
> My theory is that originally it was planned to use this mechanism for the
> "normal" kdump as well. But for kdump common code "corrupts" the vmcorein=
fo by
> adding the CRASHTIME shortly before kexec'ing the crash kernel. So the cr=
ash
> kernel would refuse to load the os_info anyway and thus it is never set.

Sure, the checksum would have to be recalculated after setting CRASHTIME. B=
ut that's perfectly possible.

> Hope this helps you at least a little

Yes, to some extent. The reason I asked was that I also implemented parsing=
 of OS_INFO_VMCOREINFO in libkdumpfile a few years ago, but it has no test =
coverage. So, I looked around a bit and to my surprise all dump files conta=
ined a NULL pointer there, which looked somewhat suspicious.

Anyway, if nobody knows for certain, then my plan is to add the necessary c=
ode to the Linux kernel. Patch coming soon on the mailing list. ;-)

Thanks,
Petr T

> Philipp
>=20
>=20
> On Tue, 13 Oct 2020 14:53:03 +0200
> Petr Tesarik <ptesarik@suse.cz> wrote:
>=20
> > Hi all,
> >=20
> > I've been looking into kernel crash dump analysis for some time now,
> > and I've noticed that none of my sample dumps for z/Architecture sets
> > OS_INFO_VMCOREINFO.
> >=20
> > Commit 4857d4bbe9821c8d732cb84455e18e12b3d79add suggests that the
> > "os_info" structure should contain vmcoreinfo, but it seems that the
> > corresponding fields are always zero, and a quick grep for
> > OS_INFO_VMCOREINFO finds only code that tries to read this entry in the
> > panic kernel, but no code that would initialize it in the old (crashed)
> > kernel.
> >=20
> > In short, the panic kernel always prints an informational message that
> > entry 0 is not available and falls back to get_vmcoreinfo_old().
> >=20
> > Is this a bug, or is this interface used by a non-Linux operating
> > system that I'm not aware of?
> >=20
> > TIA,
> > Petr Tesarik
> > SUSE HW Enablement =20


--Sig_/J0NdDn94vZ/rqqA9iOHb9hf
Content-Type: application/pgp-signature
Content-Description: =?unknown-8bit?q?Digit=C3=A1ln=C3=AD?= podpis OpenPGP

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEHl2YIZkIo5VO2MxYqlA7ya4PR6cFAl+JuyMACgkQqlA7ya4P
R6fZagf/UHB0waAsfcrsiS//sAu6FX4k+7elra51TeeYl2YvFeDL9wpCa47GkjC+
sNDcksMRFm0KsND/mShSKFhUJ7Va6OMD1g+GqlmLEeJTNn2LyzIBcmcYRtJRd+jU
nhPXebUWoWX3T91w8eLHumxPnan8eZt64XiMgje6Fd+3YQHDupCgqHDFSAAlV7RE
oxEqZfjsJpFERts5+4u9b4OLtOLqB8NFqQrcDW0R8/cVrapINoGQWXDpEvCjud9v
Dhb57HmsJdHHIRJiyB8V37sVjs5Z5gmi5VHL3Xwf16Zs6Urm9iydTgVJCxD077Iy
EB6sRCLrjxHVRegdQaF0oioJ1w0IVw==
=t6Be
-----END PGP SIGNATURE-----

--Sig_/J0NdDn94vZ/rqqA9iOHb9hf--
