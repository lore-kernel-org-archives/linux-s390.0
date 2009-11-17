From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [-next Nov 16] s390 build failure (arch/s390/kernel/time)
Date: Tue, 17 Nov 2009 16:25:46 +1100
Message-ID: <20091117162546.16bb00b0.sfr@canb.auug.org.au>
References: <20091116181453.b42247cf.sfr@canb.auug.org.au>
	<4B02283D.8040103@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__17_Nov_2009_16_25_46_+1100_i4uEOmwtO9lxykrM"
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <4B02283D.8040103@in.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-next@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Tejun Heo <tj@kernel.org>, Rusty Russell <rusty@rustcorp.com.au>, Christoph Lameter <cl@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Sachin Sant <sachinp@in.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

--Signature=_Tue__17_Nov_2009_16_25_46_+1100_i4uEOmwtO9lxykrM
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Nov 2009 10:06:13 +0530 Sachin Sant <sachinp@in.ibm.com> wrote:
>
> Next 20091116 build failed on a s390 box with
>=20
> arch/s390/kernel/time.c: In function 'get_sync_clock':
> arch/s390/kernel/time.c:337: error: 'clock_sync_sync' undeclared (first u=
se in this function)
> arch/s390/kernel/time.c:337: error: (Each undeclared identifier is report=
ed only once
> arch/s390/kernel/time.c:337: error: for each function it appears in.)
> arch/s390/kernel/time.c: In function 'check_sync_clock':
> arch/s390/kernel/time.c:387: error: 'clock_sync_sync' undeclared (first u=
se in this function)

Caused by commits 8283cb43ab3e92a039d3486a0f6253df95a5fa55 ("[S390] clock
sync mode flags") (which entered Linus' tree during 2.6.30-rc1) and
commit d2fec595511b5718bdb65645b3d5d99800d97943 ("[S390] stp support")
(which entered Linus' tree during 2.6.27-rc1) but only exposed by commit
e0fdb0e050eae331046385643618f12452aa7e73 ("percpu: add __percpu for
sparse") from the percpu tree.

Needs to be fixed in the s390 tree.  (put_per_cpu() now references its
argument, so that had better be a real variable :-))
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__17_Nov_2009_16_25_46_+1100_i4uEOmwtO9lxykrM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAksCM9oACgkQjjKRsyhoI8yoUgCgiRHFXFCVLJyeXMyLffNI42W6
ClYAn2LGaR+JicIpkmhEqRaLehWJOEHe
=nvtt
-----END PGP SIGNATURE-----

--Signature=_Tue__17_Nov_2009_16_25_46_+1100_i4uEOmwtO9lxykrM--
