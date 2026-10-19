Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792439580;
	b=wgJ0tLup4h0X5hRCcFLYIA+N0hJZ+T9+RI8kKEuBmMF9I9D4O3aCLNUR/qZmaaK1mC7u
	 e31kqEb8e4Iu+z74jS2eVKvpoEgiu87esAfoKVr6eNlbqqjxVJcwIj4eWb7SpdFUCBrrj
	 cnRy9fvwiqvMm3OOkV9gn1Es2Bx88uhQlcs6p7epP0mEBQ3QvhDcuipTDulv8zKIqHW0P
	 oHDevc23KJvqgZhl3mqaH2KmUObELx5kdVpCF3Hm22E/QrKm7i1Ftj1yzH8aL5EpLdOCQ
	 N+3+icEkK2rfX80zhuj3mh8QClfS1bXyJmdYeBUyTd48GW9Gnz43VpKG5Dbpnbbew6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792439580;
	h=Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=/B8Sf2t/5DBguvLLrjlEO7Kkln0Oyn/55MT9a1pjZ1o=;
	b=KdOqvTeGH8L9TI3ybkVU17ky7T3JY5rDUkUDmlMCX70LYfSaGdiEtrnaUBx0jkHFW0i8
	 +eKVAQPPRGOwngyJtsG9v8YjDpx14Y7LjISGyT82Y9mYh6rc2Xe7RxDQsQhg2ccE7teNE
	 O3XQtO/gS/FxXIgj7p36wMYQW8Mk5V2d3hJ4ew7pQB2g/qiPxh76PDKpTGyAT0RRsrWNK
	 kLfI1uTvkmN3PsLsKBX+UHcqExFgU2rfd2HXtq9CXvTWxpLe26ecd9/nEye7aDky3XwiD
	 STjNdxxoTGK0npf4Rgz7oLH5YpHSXXqx6JHuw95BKYDN9hCsTetML1ktZgqKfAShl3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XuNF1GbO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539B9606A319;
	Mon, 19 Oct 2026 19:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XuNF1GbO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592F91F000C4;
	Mon, 19 Oct 2026 19:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792439579;
	bh=/B8Sf2t/5DBguvLLrjlEO7Kkln0Oyn/55MT9a1pjZ1o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XuNF1GbOzd2BBEAJU6p1RypmvBu3/DMrL0b3wWdC+D++Poq0HXIRFWesrR1Oo8lL/
	 mhtWvhuAYtWIocMai5rqtHzVncAteP+BI3w+hOW2hU6IBI6rvJPA15oR+4bdizjuTn
	 dsf8kxRwLKdwlPv9l424Xna5CgBVMDCcZ1Jcc/qlP4AB/uOupNzjZvqcz7BE6QGBD7
	 c7ltj0F3siFa6PMy6uq9tVAO//JSmGoFMld/h5nkyGLtrIXdadBY6yo0uZO+Vp3XbW
	 h5+bZIQfi4A3lXHhXdvAJPgvsYBe0a+zHp1pPcLAaAFO9pB5lh38SAOIcLgJAfdjpA
	 FaZxRbZ3iFzxw==
Message-ID: <42964fa071bd8dcafd418c89be6d66856def4dc5.camel@kernel.org>
Subject: Re: [linus:master] [sysctl]  8d75c338f0:
 BUG:KASAN:slab-use-after-free_in_touch_wq_lockdep_map
From: Allison Henderson <achender@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Joel Granados <joel.granados@kernel.org>
Cc: kernel test robot <yi1.lai@intel.com>, oe-lkp@lists.linux.dev, 
 lkp@intel.com, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org,  linux-s390@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,  netdev@vger.kernel.org,
 wireguard@lists.zx2c4.com, rds-devel@oss.oracle.com
Date: Mon, 19 Oct 2026 12:52:58 -0700
In-Reply-To: <atY42k00k0Waj6o4@redhat.com>
References: <202610190310.9737b2e3-lkp@intel.com>
	 <atYB0bm9eEXp8A2g@redhat.com> <atYW0K3t57puHeLW@hobbes>
	 <atYuE1xnVYe0BDG4@redhat.com> <atY42k00k0Waj6o4@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-10-19 at 17:35 +0200, Oleg Nesterov wrote:
> On 10/19, Oleg Nesterov wrote:

Hi Oleg, Joel,

Thanks for running this down.  Agreed we shouldn't just fail to init becaus=
e
sysctl is off.  Some comments below:


> >=20
> > But. rds_init() can also fail even if CONFIG_SYSCTL=3Dy, after
> > rds_sysctl_init(), so to me this looks like a bug in net/rds/.
> >=20
Yes that's a separate bug, so I'll send a separate fix for that.

> >=20
> > In any case, I guess net/rds/ init paths should not fail if
> > CONFIG_SYSCTL=3Dn ?
>=20
> So I think that something like the uncompiled/untested patch below makes
> sense anyway even if doesn't fix all the potential problems with rds_wq.
>=20
> What do you think?
>=20
> Oleg.
> ---
>=20
> diff --git a/net/rds/ib_sysctl.c b/net/rds/ib_sysctl.c
> index 2af678e71e3c..bccdb5c4df1d 100644
> --- a/net/rds/ib_sysctl.c
> +++ b/net/rds/ib_sysctl.c
> @@ -36,19 +36,10 @@
> =20
>  #include "ib.h"
> =20
> -static struct ctl_table_header *rds_ib_sysctl_hdr;
> -
>  unsigned long rds_ib_sysctl_max_send_wr =3D RDS_IB_DEFAULT_SEND_WR;
>  unsigned long rds_ib_sysctl_max_recv_wr =3D RDS_IB_DEFAULT_RECV_WR;
>  unsigned long rds_ib_sysctl_max_recv_allocation =3D (128 * 1024 * 1024) =
/ RDS_FRAG_SIZE;
> -static unsigned long rds_ib_sysctl_max_wr_min =3D 1;
> -/* hardware will fail CQ creation long before this */
> -static unsigned long rds_ib_sysctl_max_wr_max =3D (u32)~0;
> -
>  unsigned long rds_ib_sysctl_max_unsig_wrs =3D 16;
> -static unsigned long rds_ib_sysctl_max_unsig_wr_min =3D 1;
> -static unsigned long rds_ib_sysctl_max_unsig_wr_max =3D 64;
> -
>  /*
>   * This sysctl does nothing.
>   *
> @@ -61,6 +52,14 @@ static unsigned long rds_ib_sysctl_max_unsig_wr_max =
=3D 64;
>   */
>  unsigned int rds_ib_sysctl_flow_control =3D 0;
> =20
> +#ifdef CONFIG_SYSCTL
> +static unsigned long rds_ib_sysctl_max_wr_min =3D 1;
> +/* hardware will fail CQ creation long before this */
> +static unsigned long rds_ib_sysctl_max_wr_max =3D (u32)~0;
> +
> +static unsigned long rds_ib_sysctl_max_unsig_wr_min =3D 1;
> +static unsigned long rds_ib_sysctl_max_unsig_wr_max =3D 64;
> +
>  static struct ctl_table rds_ib_sysctl_table[] =3D {
>  	{
>  		.procname       =3D "max_send_wr",
> @@ -105,6 +104,8 @@ static struct ctl_table rds_ib_sysctl_table[] =3D {
>  	},
>  };
> =20
> +static struct ctl_table_header *rds_ib_sysctl_hdr;
> +
>  void rds_ib_sysctl_exit(void)
>  {
>  	if (rds_ib_sysctl_hdr)
> @@ -118,3 +119,15 @@ int rds_ib_sysctl_init(void)
>  		return -ENOMEM;
>  	return 0;
>  }


The real rds_sysctl_init() also does the runtime setup of
rds_sysctl_reconnect_min_jiffies (msecs_to_jiffies(1)).  Without
it, the reconnect back off is lost.

Also, if register_net_sysctl_sz() returns NULL in rds_tcp_init_net(),
it fails as an -ENOMEM.  So RDS/TCP would still fail to come up with
CONFIG_SYSCTL=3Dn.  A simpler fix might be to just handle the NULL at the
three call sites, e.g.:

        rds_sysctl_reg_table =3D
                register_net_sysctl(&init_net, "net/rds", rds_sysctl_rds_ta=
ble);
        if (!rds_sysctl_reg_table && IS_ENABLED(CONFIG_SYSCTL))
                return -ENOMEM;

And same for rds_ib_sysctl_init() and rds_tcp_init_net().  The exit
paths are ok, since unregister_net_sysctl_table() is already a
no-op stub when sysctl is off.

Let me know if you want to respin or if you'd rather I send it.
Either way is fine with me.

Thanks
Allison

> +
> +#else
> +
> +void rds_ib_sysctl_exit(void)
> +{
> +}
> +
> +int rds_ib_sysctl_init(void)
> +{
> +	return 0;
> +}
> +#endif
> diff --git a/net/rds/sysctl.c b/net/rds/sysctl.c
> index 025f518a4349..a0673a41633a 100644
> --- a/net/rds/sysctl.c
> +++ b/net/rds/sysctl.c
> @@ -36,11 +36,6 @@
> =20
>  #include "rds.h"
> =20
> -static struct ctl_table_header *rds_sysctl_reg_table;
> -
> -static unsigned long rds_sysctl_reconnect_min =3D 1;
> -static unsigned long rds_sysctl_reconnect_max =3D ~0UL;
> -
>  unsigned long rds_sysctl_reconnect_min_jiffies;
>  unsigned long rds_sysctl_reconnect_max_jiffies =3D HZ;
> =20
> @@ -49,6 +44,10 @@ unsigned int  rds_sysctl_max_unacked_bytes =3D (16 << =
20);
> =20
>  unsigned int rds_sysctl_ping_enable =3D 1;
> =20
> +#ifdef CONFIG_SYSCTL
> +static unsigned long rds_sysctl_reconnect_min =3D 1;
> +static unsigned long rds_sysctl_reconnect_max =3D ~0UL;
> +
>  static struct ctl_table rds_sysctl_rds_table[] =3D {
>  	{
>  		.procname       =3D "reconnect_min_delay_ms",
> @@ -91,6 +90,8 @@ static struct ctl_table rds_sysctl_rds_table[] =3D {
>  	},
>  };
> =20
> +static struct ctl_table_header *rds_sysctl_reg_table;
> +
>  void rds_sysctl_exit(void)
>  {
>  	unregister_net_sysctl_table(rds_sysctl_reg_table);
> @@ -107,3 +108,15 @@ int rds_sysctl_init(void)
>  		return -ENOMEM;
>  	return 0;
>  }
> +
> +#else
> +
> +void rds_sysctl_exit(void)
> +{
> +}
> +
> +int rds_sysctl_init(void)
> +{
> +	return 0;
> +}
> +#endif
>=20

