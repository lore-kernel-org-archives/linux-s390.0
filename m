Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493513;
	b=X4eo1GGtmg4A42S+HA7a3xzl4bgZnIO/gZGavZWVN3kDsEPoieuxScrUqjW4v9Qy3Yuv
	 Tt2dHfAfmabakX8/erCyMFDSEkR43Bp/XrEO/jdnMSgzSbccM+VUjpAAooha0z9+ZqETj
	 dVIEzBGDko95NeMLAuJjubIccc9H9zN8ujKapVXwmvRwIbxcwFnK1fc5UH/xEYQoVdv5Z
	 U0YE3rj022kiFNGolBIr2AqhRrbQ3tmaSfZ2SBeuxXvb8Ai2J+8q8I1cp7KOwYHTtbx/7
	 geMCFDTMMNUaWxWLKuM5j6dS+nQkfvCUqB5Xa+puUpL7xEiFOdTGfVgk/23CSZ2T9Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493513;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Z9MRs6w+WliIIZKiShqiKYZW4iBNHOE0H2f3xTlWCCM=;
	b=nmYW+OkHbdNFOpN1xtEpEfRuOkVFexz1S1Yyfi45xHumnVy7mwJynW1Ed2rXkvSkwuBk
	 nZ0nnbSI+nVdiW2i8sI+QaX3k3CbEMQ6x2ShYwkqLxBAM/vgDfcW2vYfAiWnJ28rXkmPq
	 6C+tOo9nq406AoAu5E7tdO69TxxhgR9EB/tYfTth0n718ek5NLwMx6ZE6JyuR+k18A/YD
	 bmDuFHGG5RsfEBj7zFsI8ODp+0BLt9ilLlvIeWDkzIuYKRnVPVx2r1xcaEiZBI4ERp7fX
	 Rc7GfxaWqfRSehGkXHMLt4MLrF+VVX7l4Mo09gb1LgF1WB/KpnHVqNvwa9KMZucRK5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VxowElf6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99DA606A334;
	Tue, 20 Oct 2026 10:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VxowElf6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD381F000CB;
	Tue, 20 Oct 2026 10:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792493512;
	bh=Z9MRs6w+WliIIZKiShqiKYZW4iBNHOE0H2f3xTlWCCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VxowElf6bpFXMlwPoquDUhFpMQX+FFEOQVyC2+bP97DbC6XxVBYlVypXpz0avrCst
	 QtL22MOS9EGomdHJiTBNviyaPQvCJn67hRDuDq0DEUjDbbFupMO9a6VHpZOJdWnj9e
	 X9nqKxRcHsDlEyIWeJT6SMKh1i0QL9hsH5DyKd04NPK1AZdmrEwDjUT/q1P+bfGjXA
	 sKVHePOFNqQET44l1GCPjIrfytR0vw4SHTd6t0ZwGvztQd6tksbTldxhvTlRvbOkwN
	 Duwu5qBNsVWdhRNoASIcBA/ey3QEpXuawM+PsS4NcuqTMR8vY4QAHu/taK58DE30v8
	 EXwnTSIt7pDMg==
Date: Tue, 20 Oct 2026 12:51:47 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Allison Henderson <achender@kernel.org>, 
	kernel test robot <yi1.lai@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, wireguard@lists.zx2c4.com, 
	rds-devel@oss.oracle.com
Subject: Re: [linus:master] [sysctl]  8d75c338f0:
 BUG:KASAN:slab-use-after-free_in_touch_wq_lockdep_map
Message-ID: <atdGZg2FCJk0WncT@hobbes>
References: <202610190310.9737b2e3-lkp@intel.com>
 <atYB0bm9eEXp8A2g@redhat.com>
 <atYW0K3t57puHeLW@hobbes>
 <atYuE1xnVYe0BDG4@redhat.com>
 <atY42k00k0Waj6o4@redhat.com>
 <42964fa071bd8dcafd418c89be6d66856def4dc5.camel@kernel.org>
 <atcwdTkjj5fY0QHU@redhat.com>
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
	protocol="application/pgp-signature"; boundary="2q5pjfxl3jaesakr"
Content-Disposition: inline
In-Reply-To: <atcwdTkjj5fY0QHU@redhat.com>


--2q5pjfxl3jaesakr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [linus:master] [sysctl]  8d75c338f0:
 BUG:KASAN:slab-use-after-free_in_touch_wq_lockdep_map
MIME-Version: 1.0

On Tue, Oct 20, 2026 at 11:12:21AM +0200, Oleg Nesterov wrote:
> Hi Allison,
>=20
> On 10/19, Allison Henderson wrote:
> >
> > The real rds_sysctl_init() also does the runtime setup of
> > rds_sysctl_reconnect_min_jiffies (msecs_to_jiffies(1)).  Without
> > it, the reconnect back off is lost.
>=20
> Yes, thanks, I missed that.
>=20
> > Also, if register_net_sysctl_sz() returns NULL in rds_tcp_init_net(),
> > it fails as an -ENOMEM.  So RDS/TCP would still fail to come up with
> > CONFIG_SYSCTL=3Dn.
>=20
> Yes, I didn't even try to grep other files.
>=20
> Hmm. I am m just curious how difficult it is to create a "complete" patch
> which puts all the sysctl-related code under ifdef(SYSCTL)... May be some=
thing
> like below but I don't understand net/rds, most probably it is wrong and =
I am
> not sure it makes a lot of sense. Plus I have not idea how to test it.
>=20
> > A simpler fix might be to just handle the NULL at the
> > three call sites, e.g.:
> >
> >         rds_sysctl_reg_table =3D
> >                 register_net_sysctl(&init_net, "net/rds", rds_sysctl_rd=
s_table);
> >         if (!rds_sysctl_reg_table && IS_ENABLED(CONFIG_SYSCTL))
> >                 return -ENOMEM;
>=20
> Yes, I thought about a simpler patch too. Perhaps just
>=20
> 	--- x/net/rds/Kconfig
> 	+++ x/net/rds/Kconfig
> 	@@ -2,7 +2,7 @@
> 	=20
> 	 config RDS
> 		tristate "The Reliable Datagram Sockets Protocol"
> 	-	depends on INET
> 	+	depends on INET && SYSCTL
> 		help
> 		  The RDS (Reliable Datagram Sockets) protocol provides reliable,
> 		  sequenced delivery of datagrams over Infiniband or TCP.
>=20
> for the start? CONFIG_SYSCTL=3Dn is not a common case.
Indeed CONFIG_SYSCTL=3Dn is not common. On the other hand why would RDS
depend on SYSCTL being configured in? Shouldn't RDS just work with
default values when CONFIG_SYSCTL=3Dn?

Best

>=20
> > Let me know if you want to respin or if you'd rather I send it.
> > Either way is fine with me.
>=20
> Allison, up to you. Whatever you prefer.
>=20
> Oleg.
> ---
>=20
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
> index 025f518a4349..47e8782b1aa3 100644
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
> @@ -107,3 +108,16 @@ int rds_sysctl_init(void)
>  		return -ENOMEM;
>  	return 0;
>  }
> +
> +#else
> +
> +int rds_sysctl_init(void)
> +{
> +	rds_sysctl_reconnect_min_jiffies =3D msecs_to_jiffies(1);
> +	return 0;
> +}
> +
> +void rds_sysctl_exit(void)
> +{
> +}
> +#endif
> diff --git a/net/rds/tcp.c b/net/rds/tcp.c
> index 774a71f88d37..372899a2ec81 100644
> --- a/net/rds/tcp.c
> +++ b/net/rds/tcp.c
> @@ -53,13 +53,71 @@ static atomic_t rds_tcp_unloading =3D ATOMIC_INIT(0);
> =20
>  static struct kmem_cache *rds_tcp_conn_slab;
> =20
> +#ifdef CONFIG_SYSCTL
> +static int rds_tcp_min_sndbuf =3D SOCK_MIN_SNDBUF;
> +static int rds_tcp_min_rcvbuf =3D SOCK_MIN_RCVBUF;
> +
> +/* when sysctl is used to modify some kernel socket parameters,this
> + * function  resets the RDS connections in that netns  so that we can
> + * restart with new parameters.  The assumption is that such reset
> + * events are few and far-between.
> + */
> +static void rds_tcp_sysctl_reset(struct net *net)
> +{
> +	struct rds_tcp_connection *tc, *_tc;
> +
> +	spin_lock_irq(&rds_tcp_conn_lock);
> +	list_for_each_entry_safe(tc, _tc, &rds_tcp_conn_list, t_tcp_node) {
> +		struct net *c_net =3D read_pnet(&tc->t_cpath->cp_conn->c_net);
> +
> +		if (net !=3D c_net || !tc->t_sock)
> +			continue;
> +
> +		/* reconnect with new parameters */
> +		rds_conn_path_drop(tc->t_cpath, false);
> +	}
> +	spin_unlock_irq(&rds_tcp_conn_lock);
> +}
> +
> +static int rds_tcp_skbuf_handler(struct rds_tcp_net *rtn,
> +				 const struct ctl_table *ctl, int write,
> +				 void *buffer, size_t *lenp, loff_t *fpos)
> +{
> +	int err;
> +
> +	err =3D proc_dointvec_minmax(ctl, write, buffer, lenp, fpos);
> +	if (err < 0) {
> +		pr_warn("Invalid input. Must be >=3D %d\n",
> +			*(int *)(ctl->extra1));
> +		return err;
> +	}
> +
> +	if (write && rtn->rds_tcp_listen_sock && rtn->rds_tcp_listen_sock->sk) {
> +		struct net *net =3D sock_net(rtn->rds_tcp_listen_sock->sk);
> +
> +		rds_tcp_sysctl_reset(net);
> +	}
> +
> +	return 0;
> +}
> +
>  static int rds_tcp_sndbuf_handler(const struct ctl_table *ctl, int write,
> -				  void *buffer, size_t *lenp, loff_t *fpos);
> +				  void *buffer, size_t *lenp, loff_t *fpos)
> +{
> +	struct rds_tcp_net *rtn =3D container_of(ctl->data, struct rds_tcp_net,
> +					       sndbuf_size);
> +
> +	return rds_tcp_skbuf_handler(rtn, ctl, write, buffer, lenp, fpos);
> +}
> +
>  static int rds_tcp_rcvbuf_handler(const struct ctl_table *ctl, int write,
> -				  void *buffer, size_t *lenp, loff_t *fpos);
> +				  void *buffer, size_t *lenp, loff_t *fpos)
> +{
> +	struct rds_tcp_net *rtn =3D container_of(ctl->data, struct rds_tcp_net,
> +					       rcvbuf_size);
> =20
> -static int rds_tcp_min_sndbuf =3D SOCK_MIN_SNDBUF;
> -static int rds_tcp_min_rcvbuf =3D SOCK_MIN_RCVBUF;
> +	return rds_tcp_skbuf_handler(rtn, ctl, write, buffer, lenp, fpos);
> +}
> =20
>  static struct ctl_table rds_tcp_sysctl_table[] =3D {
>  #define	RDS_TCP_SNDBUF	0
> @@ -82,6 +140,61 @@ static struct ctl_table rds_tcp_sysctl_table[] =3D {
>  	},
>  };
> =20
> +static __net_init int rds_tcp_init_net_sysctl(struct net *net)
> +{
> +	struct rds_tcp_net *rtn =3D net_generic(net, rds_tcp_netid);
> +	struct ctl_table *tbl;
> +
> +	/* {snd, rcv}buf_size default to 0, which implies we let the
> +	 * stack pick the value, and permit auto-tuning of buffer size.
> +	 */
> +	if (net =3D=3D &init_net) {
> +		tbl =3D rds_tcp_sysctl_table;
> +	} else {
> +		tbl =3D kmemdup(rds_tcp_sysctl_table,
> +			      sizeof(rds_tcp_sysctl_table), GFP_KERNEL);
> +		if (!tbl) {
> +			pr_warn("could not set allocate sysctl table\n");
> +			return -ENOMEM;
> +		}
> +		rtn->ctl_table =3D tbl;
> +	}
> +	tbl[RDS_TCP_SNDBUF].data =3D &rtn->sndbuf_size;
> +	tbl[RDS_TCP_RCVBUF].data =3D &rtn->rcvbuf_size;
> +	rtn->rds_tcp_sysctl =3D register_net_sysctl_sz(net, "net/rds/tcp", tbl,
> +						     ARRAY_SIZE(rds_tcp_sysctl_table));
> +	if (!rtn->rds_tcp_sysctl) {
> +		pr_warn("could not register sysctl\n");
> +		if (net !=3D &init_net)
> +			kfree(tbl);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static void __net_exit rds_tcp_exit_net_sysctl(struct net *net)
> +{
> +	struct rds_tcp_net *rtn =3D net_generic(net, rds_tcp_netid);
> +
> +	if (rtn->rds_tcp_sysctl) {
> +		unregister_net_sysctl_table(rtn->rds_tcp_sysctl);
> +		rtn->rds_tcp_sysctl =3D NULL;
> +	}
> +
> +	if (net !=3D &init_net)
> +		kfree(rtn->ctl_table);
> +}
> +#else
> +static inline int rds_tcp_init_net_sysctl(struct net *net)
> +{
> +	return 0;
> +}
> +static inline void rds_tcp_exit_net_sysctl(struct net *net)
> +{
> +}
> +#endif
> +
>  u32 rds_tcp_write_seq(struct rds_tcp_connection *tc)
>  {
>  	/* seq# of the last byte of data in tcp send buffer */
> @@ -612,36 +725,15 @@ void rds_tcp_accept_work(struct rds_tcp_net *rtn)
>  static __net_init int rds_tcp_init_net(struct net *net)
>  {
>  	struct rds_tcp_net *rtn =3D net_generic(net, rds_tcp_netid);
> -	struct ctl_table *tbl;
>  	int err =3D 0;
> =20
>  	memset(rtn, 0, sizeof(*rtn));
> =20
>  	mutex_init(&rtn->rds_tcp_accept_lock);
> =20
> -	/* {snd, rcv}buf_size default to 0, which implies we let the
> -	 * stack pick the value, and permit auto-tuning of buffer size.
> -	 */
> -	if (net =3D=3D &init_net) {
> -		tbl =3D rds_tcp_sysctl_table;
> -	} else {
> -		tbl =3D kmemdup(rds_tcp_sysctl_table,
> -			      sizeof(rds_tcp_sysctl_table), GFP_KERNEL);
> -		if (!tbl) {
> -			pr_warn("could not set allocate sysctl table\n");
> -			return -ENOMEM;
> -		}
> -		rtn->ctl_table =3D tbl;
> -	}
> -	tbl[RDS_TCP_SNDBUF].data =3D &rtn->sndbuf_size;
> -	tbl[RDS_TCP_RCVBUF].data =3D &rtn->rcvbuf_size;
> -	rtn->rds_tcp_sysctl =3D register_net_sysctl_sz(net, "net/rds/tcp", tbl,
> -						     ARRAY_SIZE(rds_tcp_sysctl_table));
> -	if (!rtn->rds_tcp_sysctl) {
> -		pr_warn("could not register sysctl\n");
> -		err =3D -ENOMEM;
> -		goto fail;
> -	}
> +	err =3D rds_tcp_init_net_sysctl(net);
> +	if (err)
> +		return err;
> =20
>  #if IS_ENABLED(CONFIG_IPV6)
>  	rtn->rds_tcp_listen_sock =3D rds_tcp_listen_init(net, true);
> @@ -656,21 +748,14 @@ static __net_init int rds_tcp_init_net(struct net *=
net)
>  		rtn->rds_tcp_listen_sock =3D rds_tcp_listen_init(net, false);
>  		if (!rtn->rds_tcp_listen_sock) {
>  #endif
> -			unregister_net_sysctl_table(rtn->rds_tcp_sysctl);
> -			rtn->rds_tcp_sysctl =3D NULL;
> -			err =3D -EAFNOSUPPORT;
> -			goto fail;
> +			rds_tcp_exit_net_sysctl(net);
> +			return -EAFNOSUPPORT;
>  #if IS_ENABLED(CONFIG_IPV6)
>  		}
>  #endif
>  	}
>  	INIT_WORK(&rtn->rds_tcp_accept_w, rds_tcp_accept_worker);
>  	return 0;
> -
> -fail:
> -	if (net !=3D &init_net)
> -		kfree(tbl);
> -	return err;
>  }
> =20
>  static void rds_tcp_kill_sock(struct net *net)
> @@ -704,14 +789,7 @@ static void rds_tcp_kill_sock(struct net *net)
> =20
>  static void __net_exit rds_tcp_exit_net(struct net *net)
>  {
> -	struct rds_tcp_net *rtn =3D net_generic(net, rds_tcp_netid);
> -
> -	if (rtn->rds_tcp_sysctl)
> -		unregister_net_sysctl_table(rtn->rds_tcp_sysctl);
> -
> -	if (net !=3D &init_net)
> -		kfree(rtn->ctl_table);
> -
> +	rds_tcp_exit_net_sysctl(net);
>  	rds_tcp_kill_sock(net);
>  }
> =20
> @@ -733,68 +811,6 @@ void *rds_tcp_listen_sock_def_readable(struct net *n=
et)
>  	return lsock->sk->sk_user_data;
>  }
> =20
> -/* when sysctl is used to modify some kernel socket parameters,this
> - * function  resets the RDS connections in that netns  so that we can
> - * restart with new parameters.  The assumption is that such reset
> - * events are few and far-between.
> - */
> -static void rds_tcp_sysctl_reset(struct net *net)
> -{
> -	struct rds_tcp_connection *tc, *_tc;
> -
> -	spin_lock_irq(&rds_tcp_conn_lock);
> -	list_for_each_entry_safe(tc, _tc, &rds_tcp_conn_list, t_tcp_node) {
> -		struct net *c_net =3D read_pnet(&tc->t_cpath->cp_conn->c_net);
> -
> -		if (net !=3D c_net || !tc->t_sock)
> -			continue;
> -
> -		/* reconnect with new parameters */
> -		rds_conn_path_drop(tc->t_cpath, false);
> -	}
> -	spin_unlock_irq(&rds_tcp_conn_lock);
> -}
> -
> -static int rds_tcp_skbuf_handler(struct rds_tcp_net *rtn,
> -				 const struct ctl_table *ctl, int write,
> -				 void *buffer, size_t *lenp, loff_t *fpos)
> -{
> -	int err;
> -
> -	err =3D proc_dointvec_minmax(ctl, write, buffer, lenp, fpos);
> -	if (err < 0) {
> -		pr_warn("Invalid input. Must be >=3D %d\n",
> -			*(int *)(ctl->extra1));
> -		return err;
> -	}
> -
> -	if (write && rtn->rds_tcp_listen_sock && rtn->rds_tcp_listen_sock->sk) {
> -		struct net *net =3D sock_net(rtn->rds_tcp_listen_sock->sk);
> -
> -		rds_tcp_sysctl_reset(net);
> -	}
> -
> -	return 0;
> -}
> -
> -static int rds_tcp_sndbuf_handler(const struct ctl_table *ctl, int write,
> -				  void *buffer, size_t *lenp, loff_t *fpos)
> -{
> -	struct rds_tcp_net *rtn =3D container_of(ctl->data, struct rds_tcp_net,
> -					       sndbuf_size);
> -
> -	return rds_tcp_skbuf_handler(rtn, ctl, write, buffer, lenp, fpos);
> -}
> -
> -static int rds_tcp_rcvbuf_handler(const struct ctl_table *ctl, int write,
> -				  void *buffer, size_t *lenp, loff_t *fpos)
> -{
> -	struct rds_tcp_net *rtn =3D container_of(ctl->data, struct rds_tcp_net,
> -					       rcvbuf_size);
> -
> -	return rds_tcp_skbuf_handler(rtn, ctl, write, buffer, lenp, fpos);
> -}
> -
>  static void rds_tcp_exit(void)
>  {
>  	rds_tcp_set_unloading();
> diff --git a/net/rds/tcp.h b/net/rds/tcp.h
> index 39c86347188c..12b58d76c089 100644
> --- a/net/rds/tcp.h
> +++ b/net/rds/tcp.h
> @@ -13,8 +13,10 @@ struct rds_tcp_net {
>  	struct socket		*rds_tcp_listen_sock;
>  	struct socket		*rds_tcp_accepted_sock;
>  	struct work_struct	rds_tcp_accept_w;
> +#ifdef CONFIG_SYSCTL
>  	struct ctl_table_header	*rds_tcp_sysctl;
>  	const struct ctl_table	*ctl_table;
> +#endif
>  	int			sndbuf_size;
>  	int			rcvbuf_size;
>  };
>=20

--2q5pjfxl3jaesakr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmrXR8IACgkQupfNUreW
QU/uDgv+KFCXUulytQ2K8Ag0x3y6yIgJ4nYYp56qqb8GygnrPiJoLZJ05miyKb7f
GuENMH5LNUZ2vVtEUU76w/+At/I1EmZBdmllvnZXdlHBnk5g3BUfeKXWH2xVnNmi
vOUZkvt9hiUpNDgcUy342V3FBfmbgZiRrdV3uKKW678eOhfOci7v19TYYUBp28o+
7pOIIm0MIH9lz9Ge5J6D4puaAZDklF3qPPC65Dk3KW8Ynb+ROKPuZ1yUAgeD/dSJ
Jjl9XDAcP76iNl6UbMooRad8tK39e9/p3ZEm076A6wG5j/Nm5W+QCuU8ySfYRU8M
NrmL1xN3GhMF76HK2b+nipNFZOdP39+O9wHGC8UN7Dq+e5xnU7bfNhdPZyCWwdAy
GLUFyYbWDsJaxP0gd6yj5JMZi7m9YrYkpAG8mBAQ3h15YXqA/kxOkc4n/57Uw9RW
TKTB1aqZ0l8Sov5ELGi273MxUj4VTGHtLPgUpHZUrQdNQ4hPUaQI3+F3DaACnHPQ
qqo8+RAA
=4/wU
-----END PGP SIGNATURE-----

--2q5pjfxl3jaesakr--
