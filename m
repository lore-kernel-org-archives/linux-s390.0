Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669684C6815
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 11:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788868069; cv=none; b=Ac2WV0n2oNm0NU8TNWHweba8So2ZjB7A/1TQ5gcgz+GR0D//zJ2iJ8GPQJNde91lMDyS4kQlr+Z3MUJuu3S6qIVZEVj2HBLOOA80zefyhHm9fNJPrACoA+dC69sECn/LcVMk9NoTuwBrb58XaK/gKCXj0Qj+4yiTfq56LAFyviY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788868069; c=relaxed/simple;
	bh=gcuPsISrSPewD9pluTq1mY4nVU4KM02XIEoCoDGKvQk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JmymP5s2bbpQRniK4up4muAVZee9N3Y/NrZWmr0k/ZIJ0kHUGGxBZCnYFRrZdFaXVONhTiaf54N1JK/0+hKniEw3zdEwqiSXp1+djXCwzKbrG/G+OkGQ/5lCG7tUDGQXyDYOlfxJnIFWDkH0uA2yJKkI7E1S/BxooB+bk1SKTgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkZPVBpM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkZPVBpM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481841F00A3A;
	Tue,  8 Sep 2026 11:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788868063;
	bh=EjDmFyf38QZBeT5N8ew4uhOcmJUKMoOri8aOtQHO2Qg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mkZPVBpMhb/LJTVOi+Cq+zDBX4hPKmD8H688vP1YYc+4+W2fCQ+ue9G4pDBqYfQ7K
	 EXO6nj+6LuX1EKZJMXEuW8R+RcaXwG5TkAlF0JCMVkyKEPTif7VJy8/5pMQ5EL8S7s
	 SOmvXYThwDUJ708Nryb5pTLag+FjIl6W4IGcdl7xgCt6tEUkfF9FncIXplHQsFgFHM
	 t+H7RdMblcR9z2ifdK8eZOeABnXfC/Jl5FtZUw/teN/+GxAqNnJdZ2nDPPjBS6TTQz
	 zNW9qyRLku+yvhd6ItdQC+/7V51N2LFh6TUV4e4wZLwCVbaxcfOFi0dUEAyOuoPr91
	 JbVNgmEfQH/Yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] net/smc: fix abort_work termination in
 smc_conn_free()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hidayath Khan" <hidayath@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260907114721.1303498-1-hidayath@linux.ibm.com>
References: <20260907114721.1303498-1-hidayath@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 11:47:42 +0000
Message-Id: <20260908114743.481841F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Late-queued `tx_work` can execute on a freed socket because it=
 does not hold a socket reference, causing a use-after-free.
--

commit ea8d2d358addfe3a2e07acf0170476ee1325ff01
Author: Hidayath Khan <hidayath@linux.ibm.com>

net/smc: fix abort_work termination in smc_conn_free()

This commit addresses deadlocks, reference leaks, and late-queued work races
related to abort_work in smc_conn_free(). It drops the socket lock around
cancel_work_sync() and uses a freed flag to prevent late-queued work from
processing a destroyed connection.

Link: https://lore.kernel.org/netdev/20260806081549.595001-1-hidayath@linux=
.ibm.com/

> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index 04aedd957543a..9a109eae73b92 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
[ ... ]
> @@ -1276,8 +1295,7 @@ void smc_conn_free(struct smc_connection *conn)
>  			smcd_buf_detach(conn);
>  	} else {
>  		smc_cdc_wait_pend_tx_wr(conn);
> -		if (current_work() !=3D &conn->abort_work)
> -			cancel_work_sync(&conn->abort_work);
> +		smc_conn_cancel_abort_work(conn);

[Severity: Critical]
This is a pre-existing issue, but while fixing the exact same design flaw f=
or
abort_work, does this leave tx_work vulnerable to a similar late-queue race?

If a local user closes an SMC socket, smc_close_cancel_work() cancels tx_wo=
rk.
However, before the socket is fully destroyed, a remote peer sending a CDC
message (or a local user reading spliced data triggering
smc_rx_pipe_buf_release()) can cause the incoming message handler
smc_cdc_msg_recv_action() to call smc_tx_pending(). This can re-queue the w=
ork
after it was cancelled:

net/smc/smc_tx.c:smc_tx_consumer_update() {
    ...
    queue_delayed_work(conn->lgr->tx_wq, &conn->tx_work, SMC_TX_WORK_DELAY);
    ...
}

Because tx_work does not hold a socket reference, it can be queued late and
outlive the socket. If the socket destruction completes and frees the socke=
t,
and then tx_work expires and executes, it will dereference the freed socket
memory:

net/smc/smc_tx.c:smc_tx_work() {
    ...
    lock_sock(&smc->sk);
    ...
}

Could this lead to a use-after-free if it is reliably reachable by a local
unprivileged user via splice() or by a remote peer sending timed CDC messag=
es
during socket teardown?

>  	}
>  	if (!list_empty(&lgr->list)) {
>  		smc_buf_unuse(conn, lgr); /* allow buffer reuse */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907114721.1303=
498-1-hidayath@linux.ibm.com?part=3D1
