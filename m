Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795627867;
	b=yGYfWF291hoqdfMZKI36K1cPkVJX+pR5LrTds0vdV7hQ/4R1fEPf2pms+B/9eOhjaBeF
	 mCHEOtipD10EWKUQ/rzhc1zmvrre6Yro9mNQJPL/IakEsnCSE2RNAU6TmnHqibr3KHgtj
	 NTX/B54zi7GxRUsEY3vCSIx0qXq9Uzn6P6sKjGU98COiV3d0/jDDLWJZhY6J3ppCSK9/3
	 IwsPN2VC6grwgURQoRq1jcWqvjz7N9iEOluVfAk8xX27U19kj49tDKXKCT7c7Cgs9cH7X
	 TFsnmlmioc+r4JbvNWGASWpaYdY4GeMWyQ2Z8gEPH1bbHCYtWhoXpvf7R8g5yaMABGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627867;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iiMnNjRta3hVGzUOVMXhNzlxzjWjeBy54qF1SM6D6h0=;
	b=sUI0pju295kmKX9qWuSoHqUtP/ZS8xDuwgziZDUgbIK0FV/R32T6kO/jAIdbi6JcQ22U
	 +/X/FlSJ4JAzLtSo3wge6BOLX2h/daMrF463TnS7e2yKYgVeMRMt3S2AmE8l9ts7STjaD
	 DSddWpkDrW7wxAiWTvIxk/dN98LpA2H8LlOCX9s1eLaxJzezLUcWhiybTqhzpUpuiXyYs
	 NQElyZv+Oi6QSFy5xuHS5TIQoELJZad/J1S093WsNcTkA+/mgYc+0vav3Y2J3cwO3hrWE
	 Sc01Vnltbg0DtY8vWrgvkszAAUyMVO7rELeZg/io3xqmZjKcyi+XDtR6laFTgSsHG0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F7wy1Sqa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166D0606A31E
	for <linux-s390@vger.kernel.org>; Wed, 25 Nov 2026 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F7wy1Sqa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061191F000C4;
	Wed, 25 Nov 2026 17:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795627866;
	bh=iiMnNjRta3hVGzUOVMXhNzlxzjWjeBy54qF1SM6D6h0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F7wy1SqaYknsXUdahlG4oRU7NC6FgaKAaFhcZhMVqUjL+PJrhCrvXuYnsZdvJnsCp
	 CB0ylle+ySOE+6DsJATOI6ypArr1D9w6mCOiPnAF8Ad+t/7rBKiaTLtasIKUazy/u3
	 EXzO0Yu5MU1sC8A7tVUzr7clLo15WFvI56nMD0bzUSkCRmDRnD8mzpozrCm/Hzeues
	 kod8VzJnmjiXq+OJNLV5v2vOr8okmSFGdhFYymXrEfJoBMI+6PkZbqAi8TMATxUPFU
	 QaAUdmUjhigPWxoEnDHWb68pbcYH7DXw/KPfpESBdaV0Be1aGv/cLv76+7ZNP68QR9
	 4CkY5loxcniLw==
Message-ID: <sashiko-outbox-233843@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3] net/smc: drop the connection when the peer's
 failover cursor is impossible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Piyus Kedia" <piyus@iiitd.ac.in>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261124173044.591937-1-piyus@iiitd.ac.in>
References: <20261124173044.591937-1-piyus@iiitd.ac.in>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 17:31:05 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] net/smc: premature cursor rewind before abort check in
  smc_switch_cursor()
- [High] net/smc: incomplete peer consumer cursor validation in
  smc_switch_cursor()
- [Medium] net/smc: false-positive abort in smc_switch_cursor() racing
  tx completion
--

commit d3ead3890b762ec4e3d6c5169a82d5ec4fde7de0
Author: Piyus Kedia <piyus@iiitd.ac.in>

net/smc: drop the connection when the peer's failover cursor is impossible

This commit aborts the SMC connection in smc_switch_cursor() when the
peer's consumer cursor advances past the unconfirmed send buffer bytes
during link failover.

Link: https://lore.kernel.org/all/20261122053223.2497832-2-piyus@iiitd.ac.i=
n/

> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index a3164201c1420..ccfc3b1dc8498 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -1055,6 +1055,7 @@ static int smc_switch_cursor(struct smc_sock *smc, =
struct smc_cdc_tx_pend *pend,
>  {
>  	struct smc_connection *conn =3D &smc->conn;
>  	union smc_host_cursor cons, fin;
> +	int unconfirmed;
>  	int rc =3D 0;
>  	int diff;
> =20
> @@ -1069,6 +1070,38 @@ static int smc_switch_cursor(struct smc_sock *smc,=
 struct smc_cdc_tx_pend *pend,
>  		 * fin above, so now prod is smaller than cons. Fix that.
>  		 */
>  		diff =3D smc_curs_diff(conn->peer_rmbe_size, &fin, &cons);
> +		/* The peer's consumer cursor is taken as it arrives, so diff
> +		 * is a value the peer chose.  It cannot honestly exceed what
> +		 * this side has prepared and not yet had confirmed, which is
> +		 * sndbuf_desc->len - sndbuf_space: smc_tx_sendmsg() lowers
> +		 * sndbuf_space as data is copied in, and smc_cdc_tx_handler()
> +		 * raises it again as the peer confirms.  A larger diff credits
> +		 * sndbuf_space past the end of the send buffer - breaking the
> +		 * "0 <=3D sndbuf_space <=3D sndbuf_desc->len" that the tx path
> +		 * depends on - and pushes tx_curs_sent out of the ring, which
> +		 * smc_tx_rdma_writes() then uses as a source offset.
> +		 *
> +		 * Simply capping diff is not enough: the cap would leave
> +		 * local_tx_ctrl.prod behind local_rx_ctrl.cons, which is the
> +		 * state this block exists to repair, so smc_write_space()
> +		 * could return a negative peer_rmbe_space and the connection
> +		 * would stop sending for good.  A peer that reports consuming
> +		 * what was never prepared has broken the protocol, so drop the
> +		 * connection, as smc_cdc_msg_validate() does for a sequence
> +		 * number that cannot be honest.
> +		 */
> +		unconfirmed =3D conn->sndbuf_desc->len -
> +			      atomic_read(&conn->sndbuf_space);
> +		if (diff > max_t(int, unconfirmed, 0)) {

[Severity: High]
Is checking diff against unconfirmed sufficient to validate the peer's
consumer cursor?

First, when conn->sndbuf_desc->len exceeds conn->peer_rmbe_size,
unconfirmed can be larger than conn->peer_rmbe_size (or even twice that).
A forged diff in (conn->peer_rmbe_size, unconfirmed] passes this check,
and because smc_curs_add(conn->peer_rmbe_size, &conn->local_tx_ctrl.prod,
diff) subtracts peer_rmbe_size at most once, local_tx_ctrl.prod.count can
be left >=3D conn->peer_rmbe_size.

Second, unconfirmed is tx_curs_prep - tx_curs_fin, which includes data
copied into the send buffer that has not been sent yet.  A diff greater
than tx_curs_sent - tx_curs_fin advances tx_curs_sent and tx_curs_fin past
unsent bytes in sndbuf, silently dropping them.

Third, smc_cdc_cursor_to_host() does not enforce cons.count <
conn->peer_rmbe_size or bound cons.wrap jumps, and smc_curs_diff() ignores
multi-wrap differences and uses 32-bit arithmetic.  A peer can send a
cursor with cons.wrap >=3D fin.wrap + 2 or an out-of-range cons.count that
wraps in smc_curs_diff() to a small diff <=3D unconfirmed; advancing
local_tx_ctrl.prod by diff then leaves it behind local_rx_ctrl.cons so
smc_write_space() stays <=3D 0 and halts sending.

[Severity: Medium]
Can an in-flight TX completion on the old link race with this check and
abort a valid connection?

smc_switch_cursor() holds only spin_lock_bh(&conn->send_lock), whereas
smc_cdc_tx_handler() runs under bh_lock_sock(&smc->sk) and credits
conn->sndbuf_space before updating conn->local_tx_ctrl_fin:

CPU0                                  CPU1 (<softirq>)
smc_switch_cursor()                   smc_cdc_tx_handler()
  smc_curs_copy(&fin,
    &conn->local_tx_ctrl_fin, conn)
                                        atomic_add(diff,
                                          &cdcpend->conn->sndbuf_space)
                                        smc_curs_copy(
                                          &conn->local_tx_ctrl_fin, ...)
  diff =3D smc_curs_diff(..., &fin, &cons)
  unconfirmed =3D len -
    atomic_read(&conn->sndbuf_space)
  if (diff > max_t(int, unconfirmed, 0))
    queue_work(..., &conn->abort_work)  <-- false-positive abort

Here diff is computed from the pre-completion fin cursor while unconfirmed
reflects the post-completion sndbuf_space, so diff exceeds unconfirmed on
an honest connection.

> +			conn->out_of_sync =3D 1;	/* prevent any further receives */
> +			conn->local_tx_ctrl.conn_state_flags.peer_conn_abort =3D 1;
> +			smc_wr_tx_put_slot(conn->lnk,
> +					   (struct smc_wr_tx_pend_priv *)pend);
> +			sock_hold(&smc->sk); /* sock_put in abort_work */
> +			if (!queue_work(smc_close_wq, &conn->abort_work))
> +				sock_put(&smc->sk);
> +			return 0;
> +		}

[Severity: High]
Does returning early here leave conn->tx_curs_sent and
conn->local_tx_ctrl.prod rewound while TX can still run before abort_work
acquires the socket lock?

At the start of smc_switch_cursor(), before this check runs, the cursors
are already overwritten:

net/smc/smc_core.c:smc_switch_cursor() {
	...
	smc_curs_copy(&conn->tx_curs_sent, &conn->tx_curs_fin, conn);
	smc_curs_copy(&fin, &conn->local_tx_ctrl_fin, conn);
	/* set prod cursor to old state, enforce tx_rdma_writes() */
	smc_curs_copy(&conn->local_tx_ctrl.prod, &fin, conn);
	...
}

Returning here leaves local_tx_ctrl.prod behind local_rx_ctrl.cons and
skips recalculating conn->peer_rmbe_space, which still holds the positive
credit computed when the forged CDC message arrived.  Meanwhile, the TX
path checks conn->killed and local_rx_ctrl.conn_state_flags.peer_conn_abort
rather than conn->out_of_sync or
local_tx_ctrl.conn_state_flags.peer_conn_abort:

net/smc/smc_tx.c:smc_tx_sndbuf_nonempty() {
	...
	if (conn->killed ||
	    conn->local_rx_ctrl.conn_state_flags.peer_conn_abort) {
		rc =3D -EPIPE;    /* connection being aborted */
		goto out;
	}
	...
}

Until conn->abort_work runs and takes lock_sock(&smc->sk) to call
smc_conn_kill(), concurrent TX under lock_sock(&smc->sk) (such as
smc_tx_sendmsg(), smc_release_cb(), or smc_tx_work()) can call
smc_tx_rdma_writes() with prod < cons.  When prod.wrap !=3D cons.wrap,
smc_tx_rdma_writes() takes the "dst_len =3D len" branch without clamping to
conn->peer_rmbe_size - prod.count, posting an RDMA write past the end of
the peer RMBE.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124173044.5919=
37-1-piyus@iiitd.ac.in?part=3D1
