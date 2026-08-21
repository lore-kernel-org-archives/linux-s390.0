Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4603B3BE7
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 07:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787298426; cv=none; b=YEoisuFSZSkeyYH4LBt2L8jdK/fgy0ibUW9w4nW9SN87SYkecapgZdjDuU/6Jj7wXybS2SnQwPDMq3U9coIz3suDR+m/BdvI5eEfGYHL7xLS4hZb4R6qVttTtr4byG+Ci5Ks4vHZtbVqHULLaPUh14xsm7hJYwTt1/5NpaG2IyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787298426; c=relaxed/simple;
	bh=jj/HmZnQexGxmuw+YX5YAvPwEANqWELjo59hnRKW6CQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iCDuhFb6AqLEl7P8SisRlWWUd87OIjf8gK2WlTy3kwcrlMt759ajRq2wWgferY/A661o7pAiXSgrJVZkGkdzV0p/Vx9JPolIhNnZgNpFCSG6jJh8FQNqQXzv4Ef6BGe0NGKQw/s+Esv4kMayChBOvglw7xyiaPecBbkIBTMY4rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0dZADcb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0dZADcb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DFC1F00A3E;
	Fri, 21 Aug 2026 07:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787298423;
	bh=fuoPRtQlKEOkMdkPZNfjIPi88Pv/D4Xkl/BXo2lMMVw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G0dZADcbdWRXiFKuG7U697HXAKGoCdEda4t0wLPz5EvzYyfjWHjYQXuhrtYp3Dgfg
	 knC6t7j6h8y5AdwqpoikR0ZffsimJmhLbY7xdOPiE/g/jMHSUWjyAwZylekhSuP381
	 06uJXzEYw3FgS+RdrcBG7yamo7UREHuAZK1U2EOk/Q5HekiHpVyU5eaGMLiFItPRAe
	 W/Lxc4zc7xO4eO96Uc51NimPZ7ayqmeeIS3/IDQlEpC24UuTpQUe+22qKEcTreJxHM
	 Ot9N08hE/SFM4hCC58pEZwZt6Uc7gAVoKiisayZ30+NwZNlBn++BiYs2oZr3v9bTB+
	 Ht6zgBwgby8rQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 2/2] net/smc: fix use-after-free in
 smc_rx_pipe_buf_release()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hidayath Khan" <hidayath@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260820074642.966856-3-hidayath@linux.ibm.com>
References: <20260820074642.966856-1-hidayath@linux.ibm.com>
 <20260820074642.966856-3-hidayath@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 07:47:02 +0000
Message-Id: <20260821074703.23DFC1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The Receive Message Buffer (RMB) pages are recycled to the link gr=
oup pool without waiting for pending `splice()` readers to finish, leading =
to cross-connection data leaks.
- [High] Leaving `conn->rmb_desc` and `conn->sndbuf_desc` non-NULL after fr=
eeing causes exploitable Use-After-Free vulnerabilities in concurrent softi=
rq and sock_diag paths.
--

--- Patch [2]: [PATCH net v2 2/2] net/smc: fix use-after-free in smc_rx_pip=
e_buf_release() ---
commit 05af7c6044c758c4b405394cc407668af77828fd
Author: Hidayath Khan <hidayath@linux.ibm.com>
Subject: net/smc: fix use-after-free in smc_rx_pipe_buf_release()

This patch fixes a use-after-free in smc_rx_pipe_buf_release() by checking=
=20
if the connection has been freed while holding the socket lock. The approac=
h=20
replaces a previous version that set conn->rmb_desc to NULL.

Cc: stable@vger.kernel.org

> v2: Replace conn->rmb_desc =3D NULL with a conn->freed check under the
>     socket lock. The NULL store exposed two paths without a NULL check:
>     smc_cdc_msg_recv_action() in softirq and the sock_diag dump without
>     the socket lock.

[Severity: High]
This isn't a bug introduced by this patch, but does leaving conn->rmb_desc
and conn->sndbuf_desc non-NULL after freeing them cause a use-after-free in
these exposed paths?

In smcr_buf_unuse(), the buffer descriptor is unconditionally freed on the
is_reg_err path:

net/smc/smc_core.c:smcr_buf_unuse() {
    ...
    if (buf_desc->is_reg_err) {
        ...
        smc_buf_free(lgr, is_rmb, buf_desc);
    }
    ...
}

If conn->rmb_desc is not set to NULL, it seems concurrent paths could access
the freed memory. For instance, in __smc_diag_dump():

net/smc/smc_diag.c:__smc_diag_dump() {
    ...
    .sndbuf_size =3D conn->sndbuf_desc ? conn->sndbuf_desc->len : 0,
    .rmbe_size =3D conn->rmb_desc ? conn->rmb_desc->len : 0,
    ...
}

And similarly in smc_cdc_msg_recv_action():

net/smc/smc_cdc.c:smc_cdc_msg_recv_action() {
    ...
    diff_prod =3D smc_curs_diff(conn->rmb_desc->len, &prod_old,
                              &conn->local_rx_ctrl.prod);
    ...
}

Could this lead to memory corruption when these lockless or softirq paths
dereference the dangling pointer?

> diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
> index 5c9e4d8b57de4..197fddc6271f0 100644
> --- a/net/smc/smc_rx.c
> +++ b/net/smc/smc_rx.c
> @@ -115,16 +115,15 @@ static void smc_rx_pipe_buf_release(struct pipe_ino=
de_info *pipe,
>  				    struct pipe_buffer *buf)
>  {
>  	struct smc_spd_priv *priv =3D (struct smc_spd_priv *)buf->private;
> +	struct smc_connection *conn =3D &priv->smc->conn;
>  	struct smc_sock *smc =3D priv->smc;
> -	struct smc_connection *conn;
>  	struct sock *sk =3D &smc->sk;
> =20
> -	if (sk->sk_state =3D=3D SMC_CLOSED ||
> -	    sk->sk_state =3D=3D SMC_PEERFINCLOSEWAIT ||
> -	    sk->sk_state =3D=3D SMC_APPFINCLOSEWAIT)
> -		goto out;
> -	conn =3D &smc->conn;
>  	lock_sock(sk);
> +	if (conn->freed) {
> +		release_sock(sk);
> +		goto out;
> +	}
>  	smc_rx_update_cons(smc, priv->len);
>  	release_sock(sk);
>  	if (atomic_sub_and_test(priv->len, &conn->splice_pending))
>  		smc_rx_wake_up(sk);

[Severity: High]
This is a pre-existing issue, but does the connection cleanup wait for
splice_pending to drop to zero before recycling the Receive Message Buffer
(RMB) pages?

In smc_rx_splice(), the buffer pages are pinned and passed to the pipe,
incrementing splice_pending:

net/smc/smc_rx.c:smc_rx_splice() {
    ...
    for (i =3D 0; i < nr_pages; i++) {
        get_page(pages[i]);
        sock_hold(&smc->sk);
    }
    ...
    if (bytes > 0)
        atomic_add(bytes, &smc->conn.splice_pending);
    ...
}

However, in smc_conn_free(), the buffer is released back to the link group
pool without waiting for the pipe readers to finish:

net/smc/smc_core.c:smc_conn_free() {
    ...
    smc_buf_unuse(conn, lgr); /* allow buffer reuse */
    smc_lgr_unregister_conn(conn);
    ...
}

If a socket is closed while a splice() operation is pending, could this lead
to a cross-connection data leak when another connection reuses the same
buffer and the pipe reader consumes the new payload?

>  out:
>  	kfree(priv);
>  	put_page(buf->page);
>  	sock_put(sk);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820074642.9668=
56-1-hidayath@linux.ibm.com?part=3D2
