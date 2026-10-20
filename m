Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792487194;
	b=lMIF5G8hSnIDsSNpEbkxFIjnUeYX1131ahtQPgSpZ7EmXcFQjcUCnZs3yDGLvRsYEduC
	 weyeUGAYof/M8ARnJjSaKY0Fk73RunXGChIbwhUE9LgyjDx7RYqYKjJhgjkEYpzPvNQuA
	 20lOF52d+DbHu7rxUIregTJqioGrdYKjicdJmmWMznhOGZBLO0CJ4I6zozPnhU3irSZu4
	 80pAU3dykihT7EWhTMk+CzCM4Kbr5N8/R0Z7OgF7Fba7IC19JLhG3gLL9fxSVQFdfpQLD
	 pDyEingtD0MCwmoygbHTGmFC3Rx3Whba2o3vstvkBteKh8YuB2ZoxO5ilOsQpAjm+Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487194;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=byMpnzMiLTG8THNjkNmp9UgpYnNMNTx0auzeW57yB8U=;
	b=DtLJAWSm6u9JGHTnz96Wvg+QhH2eX/jIcBCHC5FDpLnhaEai4CX9+EbmCPlMT/xG/T/g
	 CW0LzQ8qiZDZc3VWDwhcaY99OiGzizFQ0t2U5FFQkhNcLV+v3HAtyGQ76pnmQLyrKkFuM
	 6WTbm6m4w65C+8+0aeEDcUVMDd8nOTGWR04X3BX1VHFCqINf7WsDkl4BkXL1MaQt1j75B
	 nnR/TmjwXNweeA/9+yIp4ON5P9ocKrXSZ247duhXMK62Mc2RKKa0Eb85IJ3ZmRWAGYTx4
	 bes00efT0Q30H4rxHD38hjt3C/4coTTT41xK3DaGXIZlKuryyX+3FVvV7ngnxKzbwyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RtgQErrW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03763606A31B;
	Tue, 20 Oct 2026 09:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RtgQErrW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340EF1F000C4;
	Tue, 20 Oct 2026 09:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792487193;
	bh=byMpnzMiLTG8THNjkNmp9UgpYnNMNTx0auzeW57yB8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RtgQErrWcSXkn4om10fEUZVsYPQS8E0C/5ZMqJW739OOKCRRH5cgZYWz6k9JW+NEA
	 TXlyeYKprnZiyrNMoxCJbbwx/VXBq45YssFHz1sFkjxDHLYntyV8QmG1eGeLwBJeXZ
	 79cdAncfI+BcHaxn3CPdPzDm1iSaInRvneceLD7fGwATCqRl2B+GAqG6GeVWRk/KmF
	 VR1bAD3ZDJ9IabcZtURZJUnMDYc5qfuKlPdxlUDPi5+ksFEQyy+2HiccWtke1b315Y
	 4ytv3hocK/lsNGOKxbtNmiQHyzD5hUINETjPtNB7EMhCIC7slgaFYzF9BrNWaAmyJo
	 lDTQCa4S6emGw==
Date: Tue, 20 Oct 2026 11:06:18 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Allison Henderson <achender@kernel.org>, 
	kernel test robot <yi1.lai@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, wireguard@lists.zx2c4.com, 
	rds-devel@oss.oracle.com
Subject: Re: [linus:master] [sysctl]  8d75c338f0:
 BUG:KASAN:slab-use-after-free_in_touch_wq_lockdep_map
Message-ID: <atctwUB5NlRLk4Wy@hobbes>
References: <202610190310.9737b2e3-lkp@intel.com>
 <atYB0bm9eEXp8A2g@redhat.com>
 <atYW0K3t57puHeLW@hobbes>
 <atYuE1xnVYe0BDG4@redhat.com>
 <atY42k00k0Waj6o4@redhat.com>
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
	protocol="application/pgp-signature"; boundary="pcvh7stf5trtufk4"
Content-Disposition: inline
In-Reply-To: <atY42k00k0Waj6o4@redhat.com>


--pcvh7stf5trtufk4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [linus:master] [sysctl]  8d75c338f0:
 BUG:KASAN:slab-use-after-free_in_touch_wq_lockdep_map
MIME-Version: 1.0

On Mon, Oct 19, 2026 at 05:35:54PM +0200, Oleg Nesterov wrote:
> On 10/19, Oleg Nesterov wrote:
> >
> > But. rds_init() can also fail even if CONFIG_SYSCTL=3Dy, after
> > rds_sysctl_init(), so to me this looks like a bug in net/rds/.
> >
> >
> > In any case, I guess net/rds/ init paths should not fail if
> > CONFIG_SYSCTL=3Dn ?
>=20
> So I think that something like the uncompiled/untested patch below makes
> sense anyway even if doesn't fix all the potential problems with rds_wq.
>=20
> What do you think?

That is a good option. I also did not compile not test it, but guarding
the error inside an ifdef would work and is a pattern that is used
elsewhere.

You can also do this (also untested and not compiled):

diff --git i/net/rds/ib_sysctl.c w/net/rds/ib_sysctl.c
index 2af678e71e3c6..bc97a3eecad69 100644
--- i/net/rds/ib_sysctl.c
+++ w/net/rds/ib_sysctl.c
@@ -114,7 +114,7 @@ void rds_ib_sysctl_exit(void)
 int rds_ib_sysctl_init(void)
 {
        rds_ib_sysctl_hdr =3D register_net_sysctl(&init_net, "net/rds/ib", =
rds_ib_sysctl_table);
-       if (!rds_ib_sysctl_hdr)
+       if (!rds_ib_sysctl_hdr && IS_ENABLED(CONFIG_SYSCTL))
                return -ENOMEM;
        return 0;
 }
diff --git i/net/rds/sysctl.c w/net/rds/sysctl.c
index 025f518a43495..41c65b98c94bd 100644
--- i/net/rds/sysctl.c
+++ w/net/rds/sysctl.c
@@ -93,7 +93,8 @@ static struct ctl_table rds_sysctl_rds_table[] =3D {

 void rds_sysctl_exit(void)
 {
-       unregister_net_sysctl_table(rds_sysctl_reg_table);
+       if (rds_sysctl_reg_table)
+               unregister_net_sysctl_table(rds_sysctl_reg_table);
 }

 int rds_sysctl_init(void)
@@ -103,7 +104,7 @@ int rds_sysctl_init(void)

        rds_sysctl_reg_table =3D
                register_net_sysctl(&init_net, "net/rds", rds_sysctl_rds_ta=
ble);
-       if (!rds_sysctl_reg_table)
+       if (!rds_sysctl_reg_table && IS_ENABLED(CONFIG_SYSCTL))
                return -ENOMEM;
        return 0;
 }


Both are ok IMO.

Best

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

--pcvh7stf5trtufk4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmrXLwMACgkQupfNUreW
QU9Yjwv/cCHjunDrXXsuyNvatzPDExXb5X0UzfkQLy2qA3coR/DKb4c6DSrxHAXb
KpHrt6e9QT0I2SPoxXj4PltCuUz848uz0awIUBqnTzndf0VHj3hXQlnOzH0fZ65b
Wn0qAyxnEitEIbt1uSa7Xq24CfbATRcSjtPthG34yTnbF733Fz4lvwVkXbJi4TPl
uoyvrPEcXxnogCVN0W9XNu8u5UHk0CuHOFVj13NvhFcoykqRQbMQcpefAKpJzm2Y
0yUyZK+zZ2CyFchpYt4khOGyW5RLiwV0d1kER0UKqD9lnH4cznErsgqU0tb34Rn1
Xig5W0V/rLLEemKlyC6sdnq1ZeigxxSHlwcRUVMt1UOsECTmaTfaTaO79R2BVLSU
y8a8NvfPWzuASlTcNMV+AT03DA/syjvh2OihVN7ec7ExnUAdfEmpibahUar/MDZA
bBMHemB+kEmt61+nBWc6VAsa6/WJEzxKtDaaR4rMdSuyi20EQBPQsryOF1YPAYRT
Lm5E7bEc
=mg3e
-----END PGP SIGNATURE-----

--pcvh7stf5trtufk4--
