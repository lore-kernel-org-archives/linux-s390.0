Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493000;
	b=S2lU2uG59cx5f3MI3UK4EYNgBnN2RfPZiPwVVbrYbZxMVdkmVuQyzaYJqk/3o51V3olV
	 Yy/VzjTZOK0WRABilWWfV768NMjaKGjddQ8BfycQA2qfpZQnoSADb+rinVUg1CkDijX5R
	 nBoRH8yGXPc7o/IRbVkh5D8+qyHIecy5Sdxa7CVBY9g1Kru5jnjJL4ZP/MLcKo6nNrcuc
	 zWry6tVTeGkAKbt7JAICZwEjdBU2HC4Bkwn7X2eQomo1GpiSQl0mpP+GJmvuErZoWX33R
	 F+BqIlW7U54Tr8oPHo4rFufhNFXGAfSJnHhyE7meOBX+miI07IhBmxH4RZZNUf3VRgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493000;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1/383+dg5/KqVJ7YukiMnVebCTmoxJZhCn7AfSGB8Ik=;
	b=o4b1bUh35aRCZdLW8hsxJM0IxCqCAW0RiLhkPvXvj2ozqok69k3/gAba4r+oAdLqJCs8
	 d13t8yF198P31mODIbIwrlULpw6ZfN1uA+t1Sm2E6i7KfPyyfShgNJNnnwLcvA5vXdAsq
	 SGxNBIh31SnIZihSBpUTb/wzuNJjbKLM0AfR82DyjGfL30mpFbrfNZzrmCqB33kKMRlL4
	 zbfiwozPtGAU72D70A/A56tZBFqmEs6kPiNvwTBVAfTcp4GqJCpMzT/c6mPN7mxoLntZI
	 iGJH8um34YC9kIEkzxZhPysKjPrcUun6axYfHVeVMT4v6azHKsf86UXcozjI3ZoyUyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ouKnRxHA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912BA606A319;
	Tue, 20 Oct 2026 10:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ouKnRxHA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9C41F000C4;
	Tue, 20 Oct 2026 10:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792493000;
	bh=1/383+dg5/KqVJ7YukiMnVebCTmoxJZhCn7AfSGB8Ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ouKnRxHA9IgwkQPYOaU0mdNgp7A3hnt/aGmB+cahZX/2cC1ljckHfhjaTuUL9g4tF
	 Dd9bvTLTIzpLCW9RCvqIrP3Aux75d/KWxbNHmHdvioty7X3wX/i1vKSdxSNkqv9ulf
	 iCfYIQjgo/Hb65sQ9C4NQyyeUjf9T1GfDQmC/Q6YklZJtnFfbFxiqKAgppzPFaRu2G
	 jcPMuN2/x1/ErWEUS9z2uoF4Er535R1gInDllKsl1UmNyAb4cxyctzksp06UZTpduR
	 dG8WCdle4JA7dhBQdFDuFjPlQchDIciqkDmxc2hKv7YgN1SsgCctuoIhO5yfjx+al6
	 U3G+PZscxy4PA==
Date: Tue, 20 Oct 2026 12:43:14 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Allison Henderson <achender@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, kernel test robot <yi1.lai@intel.com>, 
	oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	netdev@vger.kernel.org, wireguard@lists.zx2c4.com, rds-devel@oss.oracle.com
Subject: Re: [linus:master] [sysctl]  8d75c338f0:
 BUG:KASAN:slab-use-after-free_in_touch_wq_lockdep_map
Message-ID: <atdE-TB8hkqcwp6g@hobbes>
References: <202610190310.9737b2e3-lkp@intel.com>
 <atYB0bm9eEXp8A2g@redhat.com>
 <atYW0K3t57puHeLW@hobbes>
 <atYuE1xnVYe0BDG4@redhat.com>
 <atY42k00k0Waj6o4@redhat.com>
 <42964fa071bd8dcafd418c89be6d66856def4dc5.camel@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k5tdk5zotfl6lrfn"
Content-Disposition: inline
In-Reply-To: <42964fa071bd8dcafd418c89be6d66856def4dc5.camel@kernel.org>


--k5tdk5zotfl6lrfn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [linus:master] [sysctl]  8d75c338f0:
 BUG:KASAN:slab-use-after-free_in_touch_wq_lockdep_map
MIME-Version: 1.0

On Mon, Oct 19, 2026 at 12:52:58PM -0700, Allison Henderson wrote:
> On Mon, 2026-10-19 at 17:35 +0200, Oleg Nesterov wrote:
> > On 10/19, Oleg Nesterov wrote:
>=20
> Hi Oleg, Joel,
>=20
> Thanks for running this down.  Agreed we shouldn't just fail to init beca=
use
> sysctl is off.  Some comments below:
>=20
>=20
> > >=20
> > > But. rds_init() can also fail even if CONFIG_SYSCTL=3Dy, after
> > > rds_sysctl_init(), so to me this looks like a bug in net/rds/.
> > >=20
> Yes that's a separate bug, so I'll send a separate fix for that.
>=20
> > >=20
> > > In any case, I guess net/rds/ init paths should not fail if
> > > CONFIG_SYSCTL=3Dn ?
> >=20
> > So I think that something like the uncompiled/untested patch below makes
> > sense anyway even if doesn't fix all the potential problems with rds_wq.
> >=20
> > What do you think?
> >=20
> > Oleg.
> > ---
> >=20
> > diff --git a/net/rds/ib_sysctl.c b/net/rds/ib_sysctl.c
> > index 2af678e71e3c..bccdb5c4df1d 100644
> > --- a/net/rds/ib_sysctl.c
> > +++ b/net/rds/ib_sysctl.c
> > @@ -36,19 +36,10 @@
> > =20
> >  #include "ib.h"
> > =20
> > -static struct ctl_table_header *rds_ib_sysctl_hdr;
> > -
> >  unsigned long rds_ib_sysctl_max_send_wr =3D RDS_IB_DEFAULT_SEND_WR;
> >  unsigned long rds_ib_sysctl_max_recv_wr =3D RDS_IB_DEFAULT_RECV_WR;
> >  unsigned long rds_ib_sysctl_max_recv_allocation =3D (128 * 1024 * 1024=
) / RDS_FRAG_SIZE;
> > -static unsigned long rds_ib_sysctl_max_wr_min =3D 1;
> > -/* hardware will fail CQ creation long before this */
> > -static unsigned long rds_ib_sysctl_max_wr_max =3D (u32)~0;
> > -
> >  unsigned long rds_ib_sysctl_max_unsig_wrs =3D 16;
> > -static unsigned long rds_ib_sysctl_max_unsig_wr_min =3D 1;
> > -static unsigned long rds_ib_sysctl_max_unsig_wr_max =3D 64;
> > -
> >  /*
> >   * This sysctl does nothing.
> >   *
> > @@ -61,6 +52,14 @@ static unsigned long rds_ib_sysctl_max_unsig_wr_max =
=3D 64;
> >   */
> >  unsigned int rds_ib_sysctl_flow_control =3D 0;
> > =20
> > +#ifdef CONFIG_SYSCTL
> > +static unsigned long rds_ib_sysctl_max_wr_min =3D 1;
> > +/* hardware will fail CQ creation long before this */
> > +static unsigned long rds_ib_sysctl_max_wr_max =3D (u32)~0;
> > +
> > +static unsigned long rds_ib_sysctl_max_unsig_wr_min =3D 1;
> > +static unsigned long rds_ib_sysctl_max_unsig_wr_max =3D 64;
> > +
> >  static struct ctl_table rds_ib_sysctl_table[] =3D {
> >  	{
> >  		.procname       =3D "max_send_wr",
> > @@ -105,6 +104,8 @@ static struct ctl_table rds_ib_sysctl_table[] =3D {
> >  	},
> >  };
> > =20
> > +static struct ctl_table_header *rds_ib_sysctl_hdr;
> > +
> >  void rds_ib_sysctl_exit(void)
> >  {
> >  	if (rds_ib_sysctl_hdr)
> > @@ -118,3 +119,15 @@ int rds_ib_sysctl_init(void)
> >  		return -ENOMEM;
> >  	return 0;
> >  }
>=20
>=20
> The real rds_sysctl_init() also does the runtime setup of
> rds_sysctl_reconnect_min_jiffies (msecs_to_jiffies(1)).  Without
> it, the reconnect back off is lost.
>=20
> Also, if register_net_sysctl_sz() returns NULL in rds_tcp_init_net(),
> it fails as an -ENOMEM.  So RDS/TCP would still fail to come up with
> CONFIG_SYSCTL=3Dn.  A simpler fix might be to just handle the NULL at the
> three call sites, e.g.:
>=20
>         rds_sysctl_reg_table =3D
>                 register_net_sysctl(&init_net, "net/rds", rds_sysctl_rds_=
table);
>         if (!rds_sysctl_reg_table && IS_ENABLED(CONFIG_SYSCTL))
>                 return -ENOMEM;
>=20

Remember to NULL check rds_sysctl_reg_table in rds_sysctl_exit(). You
might hit another UAF on exit if you don't.

> And same for rds_ib_sysctl_init() and rds_tcp_init_net().  The exit
> paths are ok, since unregister_net_sysctl_table() is already a
> no-op stub when sysctl is off.
>=20
> Let me know if you want to respin or if you'd rather I send it.
> Either way is fine with me.
>=20
> Thanks
> Allison
>=20
> > +
> > +#else
> > +
> > +void rds_ib_sysctl_exit(void)
> > +{
> > +}
> > +
> > +int rds_ib_sysctl_init(void)
> > +{
> > +	return 0;
> > +}
> > +#endif
> > diff --git a/net/rds/sysctl.c b/net/rds/sysctl.c
> > index 025f518a4349..a0673a41633a 100644
> > --- a/net/rds/sysctl.c
> > +++ b/net/rds/sysctl.c
> > @@ -36,11 +36,6 @@
> > =20
> >  #include "rds.h"
> > =20
> > -static struct ctl_table_header *rds_sysctl_reg_table;
> > -
> > -static unsigned long rds_sysctl_reconnect_min =3D 1;
> > -static unsigned long rds_sysctl_reconnect_max =3D ~0UL;
> > -
> >  unsigned long rds_sysctl_reconnect_min_jiffies;
> >  unsigned long rds_sysctl_reconnect_max_jiffies =3D HZ;
> > =20
> > @@ -49,6 +44,10 @@ unsigned int  rds_sysctl_max_unacked_bytes =3D (16 <=
< 20);
> > =20
> >  unsigned int rds_sysctl_ping_enable =3D 1;
> > =20
> > +#ifdef CONFIG_SYSCTL
> > +static unsigned long rds_sysctl_reconnect_min =3D 1;
> > +static unsigned long rds_sysctl_reconnect_max =3D ~0UL;
> > +
> >  static struct ctl_table rds_sysctl_rds_table[] =3D {
> >  	{
> >  		.procname       =3D "reconnect_min_delay_ms",
> > @@ -91,6 +90,8 @@ static struct ctl_table rds_sysctl_rds_table[] =3D {
> >  	},
> >  };
> > =20
> > +static struct ctl_table_header *rds_sysctl_reg_table;
> > +
> >  void rds_sysctl_exit(void)
> >  {
> >  	unregister_net_sysctl_table(rds_sysctl_reg_table);
> > @@ -107,3 +108,15 @@ int rds_sysctl_init(void)
> >  		return -ENOMEM;
> >  	return 0;
> >  }
> > +
> > +#else
> > +
> > +void rds_sysctl_exit(void)
> > +{
> > +}
> > +
> > +int rds_sysctl_init(void)
> > +{
> > +	return 0;
> > +}
> > +#endif
> >=20
>=20

--k5tdk5zotfl6lrfn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmrXRcEACgkQupfNUreW
QU9Vmwv+KABo8H66uC9zN+BIViG4BwkS+VmBjReZy2Xda/8BJbPnZtceZTHzD5Ah
UF/ntsWhxPNxWXpFluBxUWIbKVYnsLJ1H54JDOpS8on7zUQrAXCIB+fmHZJifIPu
dcpKfBKioVGOmFVlN/7W64s1aH/xwzxUUCAsIGPZZVdydRAhpVS6mISEhlJotNmx
dFDs9gMrdzltPNynitoyutyKYPAQh0qTnligX2Z2BXdxj8i1TCI/vzxhDD0FLtFp
zOFM5NmzrpOx9e0h3/GE42v3djnMRsgnlF45j5GTMs3udYCgPtNnqOA/MUq4fcRv
zYZgcKTrBGqqh0NMDlpXK7kB6dd25vv5a6SjyY32O+Bux12h0EF93Nk3mzFTuzZ3
zGyY13cNu5JMe2AaiZGuyKcnhZoHo5zGACHxsEWXcg69sfX98L/ubPy0w0Gj12sq
Alg/jYPMLj9LF+fA4qJNzY1oyNNBdWLpBRw/kUu4pB3LjvjZ5bVrobXcQmR2XvPQ
TNlrjkC5
=a2kQ
-----END PGP SIGNATURE-----

--k5tdk5zotfl6lrfn--
