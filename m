Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC6542BC2D
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 10:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784890575; cv=none; b=Ntz6np9LRSzBvGviW6TKY6Vw7nuUq/btCR81O15iR3V7ct/BJ/zTaLNvUrweQ8PxlT31+ydM8k28Z42c3Q3WGtCqiSrdQUTe/sCWliuFy/jJwrYo7oWJxA9g2ig0GaSqoNlQzcFdyA6cySObZCIt5kLC11qq6sn5rrRvzFUvfCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784890575; c=relaxed/simple;
	bh=wnAjjJYmNOqEJhiNGq9dWggUpVKS/I/CVgsMPHi5AsI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CP3YykgKAdeY7s4MlfRUSzynuO2OEsfx/W7au7YaL/wOBkcdJhsdb3g4ZGExH2L09KabZw82ALMHVlBm42Rckhq7cFXWuos3P1p6TeAIsCCVgKfPKeDmJGVD/ntO0GxRz6yQ16qpyak6QCKA99qQWD2MWbAKsFzd7Kqe9PgkeKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWjSn+u/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWjSn+u/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42331F000E9;
	Fri, 24 Jul 2026 10:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784890573;
	bh=RDKZ/DAfNRS7dZMUR3Y3nXBaOjYzTmbCA83+5gaUeUA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZWjSn+u/dRQ9FFkGXe99NpJbYZ6azV62eYYJiM153b/bwkffqjw/IAZn6d4S7R6yT
	 9rBLuNUXwDqC+nLVLHdLf/FaULOkooHHdFpnS3lHo6MRj0p0z97b1V0DrnVMo7jy75
	 egossnfGu4cV+YIDCbOTsQnsQDlVTWgU+0FbOw6qAIZeuozQncZFa430zdozvyxqxx
	 DokeDWdXYIt1eSQNEOaVfgWdN38U6mL8J3oNngmDUf+S1bwFnpKDDUMXhV7Ip39e5H
	 MoS76eeYOglzksUhYFAXPJYiiXZtllMSSzlYPBB62h1JhrCWza3u44FAXdme0HNuye
	 gHZnSvY157fqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v1] net/smc: fix socket use-after-free during link
 group termination
Reply-To: sashiko-reviews@lists.linux.dev
To: xuanqiang.luo@linux.dev
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260723105454.87016-1-xuanqiang.luo@linux.dev>
References: <20260723105454.87016-1-xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 10:56:12 +0000
Message-Id: <20260724105612.A42331F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Socket reference count leak in smc_switch_conns() error path.
- [High] Concurrent execution of smc_close_active_abort() and smc_clcsock_r=
elease() can lead to a TOCTOU NULL pointer dereference or Use-After-Free.
--

--- Patch [1]: [PATCH net v1] net/smc: fix socket use-after-free during lin=
k group termination ---
commit d8af9113083c00ced5108b5d3f34199756d886c8
Author: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

net/smc: fix socket use-after-free during link group termination

This patch fixes a socket use-after-free in __smc_lgr_terminate() by
taking a reference on the socket while the link group connection lock
is still held.

> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index cf6b620fef05f..b4208cb186c5e 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -1572,10 +1572,10 @@ static void __smc_lgr_terminate(struct smc_link_g=
roup *lgr, bool soft)
>  	read_lock_bh(&lgr->conns_lock);
>  	node =3D rb_first(&lgr->conns_all);
>  	while (node) {
> -		read_unlock_bh(&lgr->conns_lock);
>  		conn =3D rb_entry(node, struct smc_connection, alert_node);
>  		smc =3D container_of(conn, struct smc_sock, conn);
>  		sock_hold(&smc->sk); /* sock_put below */
> +		read_unlock_bh(&lgr->conns_lock);
>  		lock_sock(&smc->sk);
>  		smc_conn_kill(conn, soft);

[Severity: High]
This is a pre-existing issue, but I noticed a potential race condition
involving smc_close_active_abort() when called via smc_conn_kill() from her=
e.

Does this code risk a use-after-free if smc_clcsock_release() is running
concurrently?

When another thread runs __smc_release(), it explicitly drops the socket lo=
ck
before calling smc_clcsock_release():

net/smc/af_smc.c:__smc_release() {
			release_sock(sk);
			smc_clcsock_release(smc);
			lock_sock(sk);
}

This allows smc_close_active_abort() to run concurrently and dereference
smc->clcsock without holding the clcsock_release_lock:

net/smc/smc_close.c:smc_close_active_abort() {
	if (sk->sk_state !=3D SMC_INIT && smc->clcsock && smc->clcsock->sk) {
		sk->sk_err =3D ECONNABORTED;
		if (smc->clcsock && smc->clcsock->sk)
			tcp_abort(smc->clcsock->sk, ECONNABORTED);
	}
}

If smc_clcsock_release() zeroes and frees the underlying TCP socket at the
exact same time, could passing smc->clcsock->sk to tcp_abort() crash?

>  		release_sock(&smc->sk);

[ ... ]

While reviewing the above, I also noticed another pre-existing issue in the
same file.

[Severity: High]
This isn't a bug introduced by this patch, but does the error path in
smc_switch_conns() leak a socket reference?

The loop acquires a socket reference to protect it across the sleepable
buffer fetch:

net/smc/smc_core.c:smc_switch_conns() {
		sock_hold(&smc->sk);
...
		if (rc)
			goto err_out;
}

However, the err_out label completely lacks the corresponding sock_put()
cleanup to balance the reference:

net/smc/smc_core.c:smc_switch_conns() {
err_out:
	smcr_link_down_cond_sched(to_lnk);
	smc_wr_tx_link_put(to_lnk);
	return NULL;
}

Could this cause memory exhaustion over time if a connection switch fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723105454.8701=
6-1-xuanqiang.luo@linux.dev?part=3D1
