Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571798;
	b=rlwSVO0ZCnRePMieEXUqgR5pGvrQ7rfXYALufTREtpVJWAHwAJHPLWumOx61EC8KuJM3
	 AoCP15RKP7j9mVOY8uB0gGNYa/VhDnFBmnrclRnBSh7d1VwmkX/syLxiogT5sPTRzBIiK
	 EANOsB8qOBHs9Y4JgOOh6mMGLl0SoNBqd2z7tjIkCik7PnLsg+sl7NrEhyJxWgAaF5eiC
	 fWKKuwYF37PMWa3D01Lcn1d+dkuIF3T8+mITIMnOHQnG2O10dfbSc/YE0mykzGQ/tCHqT
	 jobo765VekWNAk60iOe6ZmXVrbS9HI4sBprPh8abmxfe54ckez084U+s+Y/8jXatGCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571798;
	h=Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=9K9KRsEaxoM/l89/G7N6lVBzd9yD1GfxwhXMyc+Mzdk=;
	b=Zsbao67LUzrULRszENB5/1leF/ODU47xKmH0dKXzBpaprVqdvJ0b4mXMyA+/9Q+6tbe1
	 6G2uZAY6LovoHRMwGNtUbUUT6WMNnrlL3dxGgJhA1MCRYgopvaDNE18KmZdZMmd0BrGw3
	 IxQcTZ34G9peyJwXxiQkM0SndHTZAkRYVeIV9x0H6IQyGb7bgWC/D03A4G/KNS9F9DX+3
	 y3Gj/U3yXjBtwPbWZDLKFqCAS0er863G3rayxLCuU/XlrLRf1wrOtnUdCL5tJS7Jr3mrv
	 8ctMV5vLL5TdclczNvOn8IeKXAEFP0CJ42OVj4XZGW3g8iENIoVWsiI//N2j3Xys+Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyTAEOUl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D1C606A319;
	Wed, 21 Oct 2026 08:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyTAEOUl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D01C1F000C9;
	Wed, 21 Oct 2026 08:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792571797;
	bh=9K9KRsEaxoM/l89/G7N6lVBzd9yD1GfxwhXMyc+Mzdk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hyTAEOUlLJ/6crVLQzgFPw5YC+r+R5PbTBPw29STrIIYl2Cjfj+WPZsT/QLY5NUnu
	 urFfRgJEQfsgwZnOQV8u9PGNchT8igPnjOfz/w1Qy3Jgyn9HJlpVMrYXSeOONeklbH
	 Xj0kS2H2acSMiVJxLoxAqpEjUET8LaUL8UWCyPLd+GEsBSskNh8w/7I+TvaQwmPyri
	 APQ0zQgHqoFxXSLTeJX48AWyUagcUZaiu8Zsaip8tMiG89VE/eNmTLqXAnng4UZWx7
	 b/FDAEwBv0KglNmnfNdQkXU/MrQUO9sZQALThtBUm45H9CCpcRKzX+ZiFHLvlOEdFB
	 GIxBg8zxlrUCw==
Message-ID: <e7888169bdc76ea40fcfe782c2bc9b70e037dfc6.camel@kernel.org>
Subject: Re: rds_wq UAF
From: Allison Henderson <achender@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Joel Granados <joel.granados@kernel.org>, kernel test robot
	 <yi1.lai@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	netdev@vger.kernel.org, wireguard@lists.zx2c4.com, rds-devel@oss.oracle.com
Date: Wed, 21 Oct 2026 01:36:36 -0700
In-Reply-To: <atdoGiW_sHlWgOwt@redhat.com>
References: <202610190310.9737b2e3-lkp@intel.com>
	 <atYB0bm9eEXp8A2g@redhat.com> <atYW0K3t57puHeLW@hobbes>
	 <atYuE1xnVYe0BDG4@redhat.com> <atY42k00k0Waj6o4@redhat.com>
	 <42964fa071bd8dcafd418c89be6d66856def4dc5.camel@kernel.org>
	 <atdoGiW_sHlWgOwt@redhat.com>
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

On Tue, 2026-10-20 at 15:09 +0200, Oleg Nesterov wrote:
> (change subject)
>=20
> On 10/19, Allison Henderson wrote:
> >=20
> > On Mon, 2026-10-19 at 17:35 +0200, Oleg Nesterov wrote:
> > > >=20
> > > > But. rds_init() can also fail even if CONFIG_SYSCTL=3Dy, after
> > > > rds_sysctl_init(), so to me this looks like a bug in net/rds/.
> > > >=20
> >=20
> > Yes that's a separate bug, so I'll send a separate fix for that.
>=20
> Let me try to summarize.
>=20
> If rds_init() fails after rds_threads_init() for any reason,
> rds_threads_exit() will destroy/free rds_wq.
>=20
> If rds_rdma_init() is called after that, and rds_ib_init() fails
> after rds_ib_mr_init(), rds_ib_unregister_client() will try to
> flush the already freed rds_wq.
>=20
> But we have
>=20
> 	module_init(rds_init);		// net/rds/af_rds.c
> 	module_init(rds_rdma_init);	// net/rds/rdma_transport.c
>=20
> and IIUC the order of these initcalls is not defined. So if
> rds_rdma_init() -> rds_ib_init() is called before rds_init(), it
> can do flush_workqueue(rds_wq) when rds_wq =3D=3D NULL on failure.
It is sort of defined.  When built as modules the order is enforced by
symbol dependencies. rds_rdma and rds_tcp need symbols exported by rds
(rds_wq itself is one of them), so they can't be loaded unless rds_init()
succeeded.  So the rds_wq =3D=3D NULL case can't happen.

What can happen is what was reported: built in, rds_init() fails,
do_initcalls() keeps going, and rds_rdma_init()/rds_tcp_init() run against
a core that has already been torn down.


>=20
> With or without CONFIG_SYSCTL. Right?
>=20
> But it seems that rds_ib_init() doesn't need to flush rds_wq on failure,
> so how about the patch below? Of course, I have no idea if net/rds has
> more similar issues with rds_wq.
>=20
> Oleg.
> ---
>=20
> diff --git a/net/rds/ib.c b/net/rds/ib.c
> index 786f39169bc1..cde2d1bfabbd 100644
> --- a/net/rds/ib.c
> +++ b/net/rds/ib.c
> @@ -619,7 +619,7 @@ int rds_ib_init(void)
>  out_sysctl:
>  	rds_ib_sysctl_exit();
>  out_ibreg:
> -	rds_ib_unregister_client();
> +	ib_unregister_client(&rds_ib_client);

This works for when there are no IB devices, as in the report, but the flus=
h
is what ensures rds_ib_dev_free() has finished before rds_rdma.ko's text go=
es away. =C2=A0

If there is a device,  ib_register_client() has already called rds_ib_add_o=
ne().
Then ib_unregister_client() calls rds_ib_remove_one(), which drops the last
reference.  And then rds_ib_dev_put() does queue_work(rds_wq, ...) on the
freed workqueue anyway. =20

So I think the fix belongs at the transport init: if the core didn't
come up, rds_rdma_init() and rds_tcp_init() should return early,
before they register anything.  I can send that along with the
sysctl change tomorrow.

Thanks for working on this!
Allison



>  out_mr_exit:
>  	rds_ib_mr_exit();
>  out:
>=20

