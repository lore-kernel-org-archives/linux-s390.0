Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3A94302E5
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785509794; cv=none; b=a+rabqTcnso2QCgy+52NP80sJ0afCgmKXr9OXVdDfmg9fRGN0Inc+DH6OYtmCyIK9VWcqNpW3bZvWpzufCiIt7J85k3KzFMOCgaWJe9DEQrN7rMcfHbHxysSNW4gJqkXrygsr6cPfJ6Zlq80wpWwFYbraOXrvaLPqzjP8NHRst8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785509794; c=relaxed/simple;
	bh=m6DDCCsG1LoxSgNHmFyAoJ3gBLm74NaOiuLG1Whk3qc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H420Mj44sc8LUlCED1e2+IN0SnE3jo1TTCZUGs1ZtcMKY1T1MtZaBBSOWA3SkMSOpf+nDHJaNDyTcjVHmd7iwXd5Hla+5WRKq37BVBcX/jqC8rvlVwHuWlBkbZkiUbc0zUBOMnjjl2TEZA5XQXtJ8VU5Rm5SQIXeG5DXyc7F1aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnSQPWvM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnSQPWvM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B5E1F000E9;
	Fri, 31 Jul 2026 14:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785509787;
	bh=e1IgpV84CozkyG8uzJIo2LHODOOR1i1akvuLySrQTLE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SnSQPWvMG4S4jZ+H6vfkr0WDbryAjCnDwm6ra+CDqWAc65F9gZZQoISV8EUtlZ11C
	 SrMhDs3r9wQ8QFPrH1C+sc4/usQ6STy0JI8OaRqnXGv9lsjGRuCv5fdCgIcaG1Zuwg
	 SYt+zEKWtjVGGRxKEQC5OS7S6dPo0+PLIXHIYk9EJ81R3QtFS/fQOV2cQf+UYdm6vP
	 df9d8ER1/iSajovLZdwYHk2Jha4/ilVzKnQq4K9k4eWkZZDq0dnFjrq/TKZGkAQ+G5
	 QIwP1NEcGuPkXqAZzeIPHCwZ6It4nLPVPiRDd1bvPsFIPINGlGUd1zy+FzB9KrMqLc
	 D4g+p0qpDnZyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 1/1] net: smc: fix splice entry lifetime
 imbalance in smc_rx_splice
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ren Wei" <enjou1224z@gmail.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260730145552.360287-2-enjou1224z@gmail.com>
References: <20260730145552.360287-1-enjou1224z@gmail.com>
 <20260730145552.360287-2-enjou1224z@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 14:56:26 +0000
Message-Id: <20260731145627.27B5E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] SMC receive buffers (`rmb_desc`) are returned to the reusable =
pool when a connection is freed, even if those buffers are still mapped in =
a pipe via `splice_to_pipe`. A new connection can reuse the buffer, allowin=
g the old pipe reader to read the new connection's data.
- [High] `smc_rx_pipe_buf_release()` checks `sk->sk_state` outside the sock=
et lock, creating a TOCTOU race condition that leads to a Use-After-Free of=
 connection resources (like `conn->rmb_desc` and `conn->lgr`) if the socket=
 is closed concurrently.
--

--- Patch [1]: [PATCH net v2 1/1] net: smc: fix splice entry lifetime imbal=
ance in smc_rx_splice ---
commit c6407321bb893fb435f1c82222aefbb185ac53e0
Author: Daming Li <d4n.for.sec@gmail.com>

net: smc: fix splice entry lifetime imbalance in smc_rx_splice

smc_rx_splice() passes pages to splice_to_pipe() before taking the
references that cover the lifetime of each splice entry. Take the page and
socket references for every candidate entry before splice_to_pipe(), and
drop the matching private state, page reference, and socket reference from
smc_rx_spd_release() for entries that never get queued.

> diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
> index c1d9b923938da..5c9e4d8b57de4 100644
> --- a/net/smc/smc_rx.c
> +++ b/net/smc/smc_rx.c

[Severity: High]
This isn't a bug introduced by this patch, but could this state check in
smc_rx_pipe_buf_release() lead to a race condition?

net/smc/smc_rx.c:smc_rx_pipe_buf_release() {
    ...
	if (sk->sk_state =3D=3D SMC_CLOSED ||
	    sk->sk_state =3D=3D SMC_PEERFINCLOSEWAIT ||
	    sk->sk_state =3D=3D SMC_APPFINCLOSEWAIT)
		goto out;
	conn =3D &smc->conn;
	lock_sock(sk);
	smc_rx_update_cons(smc, priv->len);
    ...
}

If the socket state is checked outside the socket lock, can the state change
before lock_sock() is acquired?

For example, if close() runs concurrently, could it transition the state to
SMC_CLOSED and free the connection resources? When smc_rx_pipe_buf_release()
eventually acquires the lock, it doesn't recheck the state before calling
smc_rx_update_cons(), which might access the freed conn->rmb_desc->len.


[Severity: Critical]
This is also a pre-existing issue, but does smc_buf_unuse() return receive
buffers to the reusable pool while they might still be mapped in a splice
pipe?

net/smc/smc_core.c:smc_buf_unuse() {
    ...
	if (conn->rmb_desc) {
		bufsize =3D conn->rmb_desc->len;
		if (!is_smcd) {
			smcr_buf_unuse(conn->rmb_desc, true, lgr);
		} else {
    ...
}

When a socket is closed, smc_release() calls smc_conn_free(), which calls
smc_buf_unuse() to mark the buffer unused.

If a user had spliced data into a pipe, the buffer pages might still be
mapped. Could a new connection reuse this buffer and write its payload into
memory that is still accessible via the old pipe? This appears it might
allow an old pipe reader to read a new connection's data.

> @@ -150,7 +150,12 @@ static const struct pipe_buf_operations smc_pipe_ops=
 =3D {
>  static void smc_rx_spd_release(struct splice_pipe_desc *spd,
>  			       unsigned int i)
>  {
> +	struct smc_spd_priv *priv =3D (struct smc_spd_priv *)spd->partial[i].pr=
ivate;
> +	struct sock *sk =3D &priv->smc->sk;
> +
> +	kfree(priv);
>  	put_page(spd->pages[i]);
> +	sock_put(sk);
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730145552.3602=
87-2-enjou1224z@gmail.com?part=3D1
