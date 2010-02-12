From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: mmotm 2010-02-10 - BUG at fs/dcache.c:677!
Date: Fri, 12 Feb 2010 16:30:42 +1100
Message-ID: <20100212163042.da2fb31d.sfr@canb.auug.org.au>
References: <201002110043.o1B0hKxW008835@imap1.linux-foundation.org>
	<8576.1265942657@localhost>
	<20100211191427.6ff9aec6.akpm@linux-foundation.org>
	<4B74DE40.5030401@ce.jp.nec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__12_Feb_2010_16_30_42_+1100_EI7capKdFqWUTW+I"
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <4B74DE40.5030401@ce.jp.nec.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-fsdevel/>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
To: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-s390@vger.kernel.org, linux-next@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

--Signature=_Fri__12_Feb_2010_16_30_42_+1100_EI7capKdFqWUTW+I
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 12 Feb 2010 13:51:12 +0900 "Jun'ichi Nomura" <j-nomura@ce.jp.nec.co=
m> wrote:
>
> So the bug seems introduced between next-20100205 and next-20100208.
>=20
> Isn't this change missing the equivalent of "dput(old)"?
>=20
> In patch-v2.6.33-rc7-next-20100208:
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 94a5e60..a056dad 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -689,33 +689,17 @@ static __always_inline void follow_dotdot(struct =
nameidata *nd)
> ...
> > -               spin_lock(&dcache_lock);
> >                 if (nd->path.dentry !=3D nd->path.mnt->mnt_root) {
> > -                       nd->path.dentry =3D dget(nd->path.dentry->d_par=
ent);
> > -                       spin_unlock(&dcache_lock);
> > -                       dput(old);
> > +                       /* rare case of legitimate dget_parent()... */
> > +                       nd->path.dentry =3D dget_parent(nd->path.dentry=
);
> >                         break;
> >                 }

That is part of commit 12578f932a8ad5f01bbf957d9c941760ef0dc575 ("Clean
follow_dotdot() up a bit") from the vfs tree.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__12_Feb_2010_16_30_42_+1100_EI7capKdFqWUTW+I
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkt054IACgkQjjKRsyhoI8z9GQCgltc6fMqphIlmMAGEK5nIgNoT
DXoAn2oOV/HE4Cb/sd7dzahyuvDMdneh
=dyUk
-----END PGP SIGNATURE-----

--Signature=_Fri__12_Feb_2010_16_30_42_+1100_EI7capKdFqWUTW+I--
