Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E43040D57F
	for <linux-s390@vger.kernel.org>; Sun, 28 Jun 2026 01:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782611407; cv=none; b=kqzx5SinRZ9Hg+00v8jhFyTcRU4Cxtyhh1pf1oZSGkBf9FDX2Tx2u8BGGh4VJH7yvXl9oYmtQbpJJHmL3vP/P6DAqKBef4Cr1QtQFoxGxTggmfkMxGdL1x36eLgp4GDyKp5Mj6HAifiptIy34KBZgJeEAMdz2pQ5Nj/Yzp+y8D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782611407; c=relaxed/simple;
	bh=tFJsC1hNb2rcq/N1n9QC2cM5HFEcsjhPl9dO9JKOTJc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q5WmPIXF4PuTfu9J66ikNtjOkQLqMNO2XA1E+DOkQ9TGHstrLCrSduim3NHxhhHJp/4cxkzNF/jRBvsxdXl2nxQPxPsrSlIOMpPPy3ujrGqcfz+tfgh65g9EbIr5g3cerGJnU/qq+kCmzRa/Sb29B1egJfffXxJEdUZ7tAH+aFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ny3TuQ6S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ny3TuQ6S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709CB1F000E9;
	Sun, 28 Jun 2026 01:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782611405;
	bh=O+077YBXxjCYJibgquhRtFegZxIBPU+7a8w9fP+v6A8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ny3TuQ6SaepBVBYbOxUEc6RrqX9EyVRk/ZUARYUe5pXov8YCa2jsAm6YewfAkm73C
	 iW256wNWeeYJW64PI4lPbu3sHV1mHG9ZNM4880kfemBAJzu2mTEu4VeIueRgFoCPML
	 2IdvNG2u2bWshtZ14llpHZWT4cIGTYKk2mkcubnjwGHXkxi4qLauppcxXfZLtv6POm
	 EPPlOXnt4CsKyFCg/SfiSvz1xrWfltuTax1UNmUSn7DLGGBMY2UWgaHzF7WADT0mXU
	 ft1ZPUpTQVAQzsj83CMSqw5cGdMvF5cQ0HcHZKCkZ7/TVTUGqch8QokFIs35U0wiB/
	 /2LaALlMrzRZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net/smc: fix UAF in smc_cdc_rx_handler() by pinning
 the socket
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xiang Mei" <xmei5@asu.edu>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260627014948.3049512-1-xmei5@asu.edu>
References: <20260627014948.3049512-1-xmei5@asu.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 01:50:04 +0000
Message-Id: <20260628015005.709CB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Asynchronous `tx_work` can be queued during socket release and exe=
cute after the socket is freed, leading to a Use-After-Free.
- [High] Concurrent execution of `smc_conn_free()` and `smc_cdc_rx_handler(=
)` causes a Use-After-Free on connection buffers and the link group.
- [High] Concurrent modification of bitfields (`out_of_sync`, `freed`, `kil=
led`) in `struct smc_connection` causes torn writes and lost state updates.
- [High] Cancelling `abort_work` in `smc_conn_free()` without checking its =
return value leaks a socket reference.
--

commit 2ba91a5beb3d341e982b17474cb075d5a25cb381
Author: Xiang Mei <xmei5@asu.edu>

net/smc: fix UAF in smc_cdc_rx_handler() by pinning the socket

smc_cdc_rx_handler() looks up the connection by token under the link
group's conns_lock, drops the lock, and then dereferences conn and the
smc_sock derived from it. This patch takes the socket reference while
still holding conns_lock to prevent the socket from being freed
concurrently, and drops the reference once the handler is done.

> diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
> index 619b3bab38248..b809139d7e870 100644
> --- a/net/smc/smc_cdc.c
> +++ b/net/smc/smc_cdc.c
> @@ -483,21 +483,27 @@ static void smc_cdc_rx_handler(struct ib_wc *wc, vo=
id *buf)
>  	lgr =3D smc_get_lgr(link);
>  	read_lock_bh(&lgr->conns_lock);
>  	conn =3D smc_lgr_find_conn(ntohl(cdc->token), lgr);
> +	if (conn && !conn->out_of_sync)
> +		sock_hold(&container_of(conn, struct smc_sock, conn)->sk);
> +	else
> +		conn =3D NULL;
>  	read_unlock_bh(&lgr->conns_lock);

[Severity: High]
This is a pre-existing issue, but does dropping lgr->conns_lock here leave =
the
connection buffers and link group vulnerable to concurrent freeing?

Looking at net/smc/smc_core.c:smc_conn_free(), the buffers can be freed
concurrently:

    smc_buf_unuse(conn, lgr); /* allow buffer reuse */

Because smc_conn_free() doesn't synchronize with the RX handler for SMC-R,
could the subsequent call to smc_cdc_msg_recv_action() dereference freed me=
mory
when it accesses conn->rmb_desc->len or conn->lgr?

> -	if (!conn || conn->out_of_sync)
> +	if (!conn)
>  		return;
>  	smc =3D container_of(conn, struct smc_sock, conn);
> =20
>  	if (cdc->prod_flags.failover_validation) {
>  		smc_cdc_msg_validate(smc, cdc, link);

[Severity: High]
This isn't a bug introduced by this patch, but can concurrent bitfield
modifications lead to lost state updates here?

In net/smc/smc_cdc.c:smc_cdc_msg_validate(), conn->out_of_sync is set witho=
ut a
lock from the softirq context:

    conn->out_of_sync =3D 1; /* prevent any further receives */

Concurrently, net/smc/smc_core.c:smc_conn_free() modifies another bit in the
same byte from process context:

    conn->freed =3D 1;

Since these bitfields share the same byte in struct smc_connection, could t=
he
read-modify-write on these bitfields cause the freed =3D 1 update to be
lost, resulting in a double-free if the connection is torn down again?

[Severity: High]
This is another pre-existing issue, but does cancelling the abort work with=
out
checking its return value cause a socket reference leak?

In net/smc/smc_cdc.c:smc_cdc_msg_validate():

    sock_hold(&smc->sk);
    if (!queue_work(smc_close_wq, &conn->abort_work))
        sock_put(&smc->sk);

If net/smc/smc_core.c:smc_conn_free() successfully cancels this pending wor=
k:

    if (current_work() !=3D &conn->abort_work)
        cancel_work_sync(&conn->abort_work);

The work function won't execute to drop the reference. Since smc_conn_free()
ignores the return value of cancel_work_sync(), does the socket reference
remain permanently leaked?

> -		return;
> +		goto out;
>  	}
>  	if (smc_cdc_before(ntohs(cdc->seqno),
>  			   conn->local_rx_ctrl.seqno))
>  		/* received seqno is old */
> -		return;
> +		goto out;
> =20
>  	smc_cdc_msg_recv(smc, cdc);

[Severity: High]
This is a pre-existing issue, but can this lead to a use-after-free of the
smc socket during release?

In net/smc/smc_cdc.c:smc_cdc_msg_recv_action(), if the socket lock is held
by the release thread, the handler sets a flag instead of queuing work:

    conn->tx_in_release_sock =3D true;

When net/smc/af_smc.c:smc_release() runs, it invokes release_sock(), causing
net/smc/af_smc.c:smc_release_cb() to queue the work asynchronously:

    smc_tx_pending(&smc->conn);

Since smc_release() drops the final socket reference right after this:

    sock_put(sk); /* final sock_put */

Could the asynchronous net/smc/smc_tx.c:smc_tx_work() execute after the soc=
ket
is freed, resulting in a use-after-free when it dereferences the socket
structure?

> +out:
> +	sock_put(&smc->sk);
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627014948.3049=
512-1-xmei5@asu.edu?part=3D1
