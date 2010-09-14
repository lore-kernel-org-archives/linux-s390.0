From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [-next Sept 10] Build break - arch/s390/mm/pgtable.c
 (INIT_RCU_HEAD)
Date: Tue, 14 Sep 2010 18:36:48 +1000
Message-ID: <20100914183648.b4371ae5.sfr@canb.auug.org.au>
References: <4C89E8A0.1050905@in.ibm.com>
	<20100910122806.05548325@mschwide.boeblingen.de.ibm.com>
	<4C8F2EBF.4060606@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__14_Sep_2010_18_36_48_+1000_j5hN0zhtopU=GyLv"
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <4C8F2EBF.4060606@in.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Sachin Sant <sachinp@in.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

--Signature=_Tue__14_Sep_2010_18_36_48_+1000_j5hN0zhtopU=GyLv
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sachin, Martin,

On Tue, 14 Sep 2010 13:43:51 +0530 Sachin Sant <sachinp@in.ibm.com> wrote:
>
> Martin Schwidefsky wrote:
> > On Fri, 10 Sep 2010 13:43:20 +0530
> > Sachin Sant <sachinp@in.ibm.com> wrote:
> >
> >  =20
> >> Today's next fails to build on a s390 box with
> >>
> >> arch/s390/mm/pgtable.c: In function 'rcu_table_freelist_finish':
> >> arch/s390/mm/pgtable.c:79: error: implicit declaration of function 'IN=
IT_RCU_HEAD'
> >> make[2]: *** [arch/s390/mm/pgtable.o] Error 1
> >>
> >> This code in question was added via following commit:
> >>
> >> commit e726023d9ff7e4968e3e0622782174a4695d68a4
> >> S390] lockless get_user_pages_fast()
> >>    =20
> >
> > I guess that there is an #include <linux/rcupdate.h> missing in pgtable=
.c. I'll
> > add it to the patch.
> >  =20
> I don't see definition for INIT_RCU_HEAD in rcupdate.h so adding rcupdate=
.h might
> not help.
>=20
> Infact i can't find usage/implementation of INIT_RCU_HEAD anywhere else i=
n the code.
> Is this macro deprecated ?

It has been removed by commit 5e8067adfdbaf97039a97540765b1e16eb8d61cc
("rcu head remove init") from the rcu and tip trees.

It was just initialising two internal pointers to NULL, so should not be
needed (for non automatic definitions) even in Linus' current tree.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__14_Sep_2010_18_36_48_+1000_j5hN0zhtopU=GyLv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMjzQgAAoJEDMEi1NhKgbsSHIIAIku9YGyfuORv/gsevgRftLH
T9FYZ3R6YeQty7IDRebxUnH277DibcdR1ltR8uwwyrPIGMYHJvU9BnPBrJdYMj3F
tZ+pudC8KpUrlA+B3QN+l4bM39qQDyuLytCPNShKVyLwjvcwaKBXg418gqdy/Jbr
tYM7OoyBvvTkrZ/PBNEqCo2K3RTK+h/yE4HOKnhfDZSZtlH2iDN7ENWCVjJFYLyC
Q+PVToLBy4qBOvjtnchYpxJzLpUzMvOlCYE9SvBkxCJtGzMmZCMPN0flJicWyxs/
ADgo46DjAT8HjgYTjW1+vMPsqfCxECj38fdzsnDUV2abYB8hMQP3OpNGMrbtwXE=
=ZUIq
-----END PGP SIGNATURE-----

--Signature=_Tue__14_Sep_2010_18_36_48_+1000_j5hN0zhtopU=GyLv--
