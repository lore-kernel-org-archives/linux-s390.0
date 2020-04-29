Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgD2BzA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 28 Apr 2020 21:55:00 -0400
Date: Wed, 29 Apr 2020 11:54:56 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: Tree for Apr 28
Message-ID: <20200429115456.34d511a0@canb.auug.org.au>
In-Reply-To: <20200429013435.GA1133928@ubuntu-s3-xlarge-x86>
References: <20200428181006.06b4e3bc@canb.auug.org.au>
        <20200428190459.GA2299615@ubuntu-s3-xlarge-x86>
        <20200429012421.GA132200@google.com>
        <20200429013435.GA1133928@ubuntu-s3-xlarge-x86>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gasmWOgPFOuCsqK9DhGzRnS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-s390@vger.kernel.org

--Sig_/gasmWOgPFOuCsqK9DhGzRnS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 28 Apr 2020 18:34:35 -0700 Nathan Chancellor <natechancellor@gmail.=
com> wrote:
>
> On Tue, Apr 28, 2020 at 06:24:21PM -0700, Minchan Kim wrote:
> >=20
> > On Tue, Apr 28, 2020 at 12:04:59PM -0700, Nathan Chancellor wrote:=20
> > >=20
> > > I am seeing the following build error on s390 defconfig, caused by
> > > commit 743f242d65ec ("mm: support compat_sys_process_madvise").
> > > Apologies if it has already been reported, I did a search of lore and
> > > found nothing.
> > >=20
> > > Cheers,
> > > Nathan
> > >=20
> > > $ make -j$(nproc) -s ARCH=3Ds390 CROSS_COMPILE=3Ds390x-linux- defconf=
ig all
> > > ...
> > > mm/madvise.c: In function '__se_compat_sys_process_madvise':
> > > ./include/linux/compiler.h:394:38: error: call to '__compiletime_asse=
rt_162' declared with attribute error: BUILD_BUG_ON failed: sizeof(unsigned=
 long) > 4 && !__TYPE_IS_PTR(unsigned long)
> > >   394 |  _compiletime_assert(condition, msg, __compiletime_assert_, _=
_COUNTER__)
> > >       |                                      ^
> >=20
> > Could you try this patch? I think it should fix it.
> >=20
> > From 3f993353c310a027f138d822a79ce49770fe6e50 Mon Sep 17 00:00:00 2001
> > From: Minchan Kim <minchan@kernel.org>
> > Date: Tue, 28 Apr 2020 18:20:24 -0700
> > Subject: [PATCH] mm: fix s390 compat build error
> >=20
> > Nathan reported build error with sys_compat_process_madvise.
> > This patch should fix it.
> >=20
> > Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> > Signed-off-by: Minchan Kim <minchan@kernel.org> =20
>=20
> Tested-by: Nathan Chancellor <natechancellor@gmail.com> # build
>=20
> > ---
> >  include/linux/compat.h | 5 +++--
> >  mm/madvise.c           | 9 ++++++---
> >  2 files changed, 9 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/include/linux/compat.h b/include/linux/compat.h
> > index 1134ba3e61d0..19c524513cbb 100644
> > --- a/include/linux/compat.h
> > +++ b/include/linux/compat.h
> > @@ -820,9 +820,10 @@ asmlinkage long compat_sys_pwritev64v2(unsigned lo=
ng fd,
> >  		unsigned long vlen, loff_t pos, rwf_t flags);
> >  #endif
> > =20
> > -asmlinkage ssize_t compat_sys_process_madvise(int which,
> > +asmlinkage ssize_t compat_sys_process_madvise(compat_int_t which,
> >  		compat_pid_t upid, const struct compat_iovec __user *vec,
> > -		unsigned long vlen, int behavior, unsigned long flags);
> > +		compat_ulong_t vlen, compat_int_t behavior,
> > +		compat_ulong_t flags);
> > =20
> >  /*
> >   * Deprecated system calls which are still defined in
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 8fec261457a6..99c06d5f0785 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -1311,9 +1311,12 @@ SYSCALL_DEFINE6(process_madvise, int, which, pid=
_t, upid,
> >  }
> > =20
> >  #ifdef CONFIG_COMPAT
> > -COMPAT_SYSCALL_DEFINE6(process_madvise, int, which, compat_pid_t, upid,
> > -		const struct compat_iovec __user *, vec, unsigned long, vlen,
> > -		int, behavior, unsigned long, flags)
> > +COMPAT_SYSCALL_DEFINE6(process_madvise, compat_int_t, which,
> > +			compat_pid_t, upid,
> > +			const struct compat_iovec __user *, vec,
> > +			compat_ulong_t, vlen,
> > +			compat_int_t, behavior,
> > +			compat_ulong_t, flags)
> > =20
> >  {
> >  	ssize_t ret;

I have applied that fix to linux-next for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/gasmWOgPFOuCsqK9DhGzRnS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6o3nAACgkQAVBC80lX
0Gz+Igf9Hb8ZlJssg//EROPEfO1qasV0kDfSSXtR6c6fjxlGQTZhCNIsUkVWFAmM
k48ouvgZPo0b1BNiaKD8O32/d87JpVVhrPOyIFDk0qLu6Om2FSK3oDS2yLyeWJvb
jmTdDpcy2pgG3tgata6jXc8U7/xTIyNCkb+Y+5vRzCLbsd5wywMXTiy6yOWbAW+k
O1llVGbkle6+vLbQU9vP966BLIRh01GXX2yE/vtS2r4+Dyjbqt3zJP4NwinkRQgM
5KBTdFwEYLG2z/W41PdWDfPR6StT0dofRnRmZpc/DJyAlx1NuhnDBf4xww1bhrLj
d7YXTUbNMJQ63WW6rKrcs2DMjN01Ww==
=KlNm
-----END PGP SIGNATURE-----

--Sig_/gasmWOgPFOuCsqK9DhGzRnS--
