Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795792147;
	b=UgSh8sV5iQZMEv3W+2JQG0JfWN/CAez5O2ekO8jY6P7h36+J60Prbi6qU3gvf2XhkWsM
	 mgn5E3W0Oh/OkKxMz+Hc6HA8wWjJszWir5UvDkSgbwk5voeBnzc6MOKjzCwwEgEQIR7cj
	 zemayQNqJV54VMa4D/xTh0oTExXo7bn0m1fatGg3W3sB73h0LvhrkOGGI/thIJQv2cLWq
	 yvOinvkLG06EtxoMm2pu4u3UzdeIDJsV/jah7fYwhczm5ZeanGB2ZP79RzO+BXhO7vQlM
	 KPgKnTpil51J32OBYVUKHazcJuk+xqm0dsQXUUS5PH8Ws8RkbkxcUEuNPGtsorM3R9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795792147;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8eXAPq9Wf8QN4MKWrmNyLzOxOTyiaNipFDAYMBWh1o4=;
	b=1Og9uetuvQYHvAryAks1t7m6VwiEF2AkD5BwyBAWA+vZXviUbLnkMOwekzoKxwAF8n2y
	 275cFD0Acj3s+W7B9DbFb78uYS+uVks6mPa9DzokjIl/DqekiLPMXRvzrWASr0AoNIlnd
	 lggJIJHyrHLR5NtFjITLoKt4fGAbjhyJWkb5JqBLpiG4n7PcNU5FLTJNCkoCUdeSqEXvQ
	 5pF4WImG11d16vilJVGxXiGoTjd6ify3Ob7ej08OcyAqFZpDHxVfIadW+g5WyquoYkkWW
	 mQIT3B9Jj1Cj0RxBvukYeTNC2OeNBwxEUjhU3C0vDSsIYdx5rBP2wYbOglE+OsH58Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cTXEImR8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCF6606A31F
	for <linux-s390@vger.kernel.org>; Fri, 27 Nov 2026 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cTXEImR8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DCC1F00893;
	Fri, 27 Nov 2026 15:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795792147;
	bh=8eXAPq9Wf8QN4MKWrmNyLzOxOTyiaNipFDAYMBWh1o4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cTXEImR8PYB8Shn8/gyiVRnMojna2RyryujxM9z9iel6gBzRflsgZGkI+8h+3440L
	 B1sc7/PdPphNNRLXhvPayrtLVOKT4WFjITWA26TLz1qCOMScBBHZjc4E5T/fsarZ1N
	 IL4ciY6rIrwSR74ZO0lSwcl7hSZyO3PxYYW5ny+IAAQR3TSbVoMlJTavvTHVz7eSYR
	 xYiWaDIhZ2FVnYo9NmJ+FcuKnKbwZu7NzIpk1yPbFNIUgat/MS1ndqURVIH2FjYXIu
	 zdJGxClyJbNGW7JCaqli+oUv+bl/HmsxF1MbXSHdctCXKndE0A+XV7jMoHPZOp+fR0
	 NodANvQKunOoA==
Message-ID: <sashiko-outbox-237679@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4] net/smc: drop the connection when the peer's
 failover cursor is impossible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Piyus Kedia" <piyus@iiitd.ac.in>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261126150848.2116315-1-piyus@iiitd.ac.in>
References: <20261126150848.2116315-1-piyus@iiitd.ac.in>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 15:09:06 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] net/smc: early smc_curs_comp() return in
  smc_cursor_cannot_be_honest() bypasses cons->count bounds check
- [High] net/smc: missing cons->wrap check in
  smc_cursor_cannot_be_honest() allows multi-wrap bypass
- [High] net/smc: abort path in smc_switch_cursor() still allows
  concurrent TX with prod < cons
- [Medium] net/smc: reversed fin cursor snapshots in smc_switch_cursor()
  race with smc_cdc_tx_handler()
--

commit 41a06dfcecfb34dfe46c69e23aff7e9f8c059778
Author: Piyus Kedia <piyus@iiitd.ac.in>

net/smc: drop the connection when the peer's failover cursor is impossible

This commit adds smc_cursor_cannot_be_honest() to validate the peer's
consumer cursor in smc_switch_cursor() before rewinding and repairing
the send cursors during link failover, aborting the connection if the
cursor is invalid.

Link: https://lore.kernel.org/all/20261122053223.2497832-2-piyus@iiitd.ac.i=
n/

> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index a3164201c1420..e15629b4e384b 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -1050,6 +1050,48 @@ static int smc_write_space(struct smc_connection *=
conn)
>  	return space;
>  }
> =20
> +/* Whether the peer's consumer cursor can honestly have reached where it=
 says.
[ ... ]
> + */
> +static bool smc_cursor_cannot_be_honest(struct smc_connection *conn,
> +					union smc_host_cursor *fin,
> +					union smc_host_cursor *cons)
> +{
> +	union smc_host_cursor tx_fin, tx_sent;
> +	int diff, unconfirmed;
> +
> +	if (smc_curs_comp(conn->peer_rmbe_size, cons, fin) >=3D 0)
> +		return false;

[Severity: High]
Can the early return on smc_curs_comp() >=3D 0 bypass the cons->count
bounds check below?

smc_cdc_cursor_to_host() does not bound cons->count, and smc_curs_diff()
casts unsigned 32-bit cursor arithmetic to signed int inside
max_t(int, 0, ...).  If a peer sends cons->count >=3D 0x80000000U with
cons->wrap > fin->wrap so that (size - fin->count) + cons->count has bit
31 set, smc_curs_diff() clamps the negative int to 0 and smc_curs_comp()
returns 0.  smc_cursor_cannot_be_honest() then returns false without
checking cons->count >=3D (u32)conn->peer_rmbe_size, leaving
smc_switch_cursor() to skip the repair with prod.wrap !=3D cons.wrap and
compute a positive peer_rmbe_space so smc_tx_rdma_writes() takes the
unclamped dst_len =3D len branch past the end of the peer RMBE.

> +
> +	smc_curs_copy(&tx_fin, &conn->tx_curs_fin, conn);
> +	smc_curs_copy(&tx_sent, &conn->tx_curs_sent, conn);
> +	diff =3D smc_curs_diff(conn->peer_rmbe_size, fin, cons);
> +	unconfirmed =3D smc_curs_diff(conn->sndbuf_desc->len, &tx_fin, &tx_sent=
);
> +
> +	return cons->count >=3D (u32)conn->peer_rmbe_size ||
> +	       diff >=3D conn->peer_rmbe_size || diff > unconfirmed;
> +}

[Severity: High]
Can a peer with cons->wrap more than one wrap ahead of fin->wrap pass
smc_cursor_cannot_be_honest() and leave conn->local_tx_ctrl.prod behind
conn->local_rx_ctrl.cons?

smc_curs_diff() only checks old->wrap !=3D new->wrap and ignores how many
wraps separate them:

net/smc/smc_cdc.h:smc_curs_diff() {
	if (old->wrap !=3D new->wrap)
		return max_t(int, 0,
			     ((size - old->count) + new->count));
...
}

If the peer sends cons->wrap >=3D fin->wrap + 2 with cons->count <
fin->count and diff <=3D unconfirmed, smc_cursor_cannot_be_honest() returns
false, but smc_curs_add() in smc_switch_cursor() increments
conn->local_tx_ctrl.prod.wrap at most once (to fin->wrap + 1).  That
leaves prod.wrap !=3D cons.wrap after the repair; any subsequent CDC update
that advances cons credits peer_rmbe_space > 0 while prod.wrap !=3D
cons.wrap, allowing smc_tx_rdma_writes() to take the unclamped
dst_len =3D len branch and write past the end of the peer RMBE.

> +
>  static int smc_switch_cursor(struct smc_sock *smc, struct smc_cdc_tx_pen=
d *pend,
>  			     struct smc_wr_buf *wr_buf)
>  {
> @@ -1058,11 +1100,33 @@ static int smc_switch_cursor(struct smc_sock *smc=
, struct smc_cdc_tx_pend *pend,
>  	int rc =3D 0;
>  	int diff;
> =20
> -	smc_curs_copy(&conn->tx_curs_sent, &conn->tx_curs_fin, conn);
> +	/* Before anything is rewound.  Returning from inside the repair below
> +	 * would leave local_tx_ctrl.prod behind local_rx_ctrl.cons with
> +	 * peer_rmbe_space still holding the credit the forged message made,
> +	 * and the tx path tests conn->killed and
> +	 * local_rx_ctrl.conn_state_flags.peer_conn_abort rather than
> +	 * out_of_sync or the flag set here - so a send under lock_sock() could
> +	 * reach smc_tx_rdma_writes() with prod < cons before abort_work takes
> +	 * the socket lock, and with the wraps differing that takes the
> +	 * dst_len =3D len branch without clamping to peer_rmbe_size -
> +	 * prod.count and writes past the end of the peer RMBE.
> +	 */
>  	smc_curs_copy(&fin, &conn->local_tx_ctrl_fin, conn);
> +	smc_curs_copy(&cons, &conn->local_rx_ctrl.cons, conn);
> +	if (smc_cursor_cannot_be_honest(conn, &fin, &cons)) {

[Severity: Medium]
Can reading conn->local_tx_ctrl_fin before conn->tx_curs_fin race with
smc_cdc_tx_handler() and falsely abort a healthy connection?

smc_switch_cursor() holds conn->send_lock, while smc_cdc_tx_handler()
runs under bh_lock_sock() without conn->send_lock and updates the two
cursors in the opposite order:

CPU0                                  CPU1 (<softirq>)
smc_switch_cursor()                   smc_cdc_tx_handler()
  smc_curs_copy(&fin,
    &conn->local_tx_ctrl_fin, conn)
                                        smc_curs_copy(&conn->tx_curs_fin,
                                          &cdcpend->cursor, conn)
                                        smc_curs_copy(&conn->local_tx_ctrl_=
fin,
                                          &cdcpend->p_cursor, conn)
  smc_cursor_cannot_be_honest()
    smc_curs_copy(&tx_fin,
      &conn->tx_curs_fin, conn)
    diff > unconfirmed  <-- false positive abort

Because fin has the pre-completion value while tx_fin has the
post-completion value, diff includes the newly confirmed bytes that an
honest peer may already have consumed, while unconfirmed has already
subtracted them.  Snapshotting conn->tx_curs_fin before
conn->local_tx_ctrl_fin avoids the false positive, though a completion
after the check can still cause the repair block below to use the older
fin snapshot.

> +		conn->out_of_sync =3D 1;	/* prevent any further receives */
> +		conn->local_tx_ctrl.conn_state_flags.peer_conn_abort =3D 1;
> +		smc_wr_tx_put_slot(conn->lnk,
> +				   (struct smc_wr_tx_pend_priv *)pend);
> +		sock_hold(&smc->sk); /* sock_put in abort_work */
> +		if (!queue_work(smc_close_wq, &conn->abort_work))
> +			sock_put(&smc->sk);
> +		return 0;
> +	}

[Severity: High]
Can a concurrent sender under lock_sock() still reach smc_tx_rdma_writes()
with prod < cons after this abort branch returns?

When the peer forges cons past what was ever sent (diff > unconfirmed),
smc_cdc_msg_recv_action() has already written the forged cursor to
conn->local_rx_ctrl.cons and credited conn->peer_rmbe_space, so
conn->local_tx_ctrl.prod (which sits at fin + unconfirmed) is already
behind conn->local_rx_ctrl.cons before smc_switch_cursor() runs.
smc_switch_conns() switches conn->lnk to the new active link right before
calling smc_switch_cursor():

CPU0                                  CPU1
smc_tx_sendmsg()
  lock_sock(&smc->sk)
                                      smc_switch_conns()
                                        spin_lock_bh(&conn->send_lock)
                                        smc_switch_link_and_count(conn, to_=
lnk)
                                        smc_switch_cursor()
                                          conn->out_of_sync =3D 1
                                          queue_work(..., &conn->abort_work)
                                        spin_unlock_bh(&conn->send_lock)
  smc_tx_sndbuf_nonempty()
    spin_lock_bh(&conn->send_lock)
    smc_tx_rdma_writes()  <-- prod < cons on to_lnk

Because smc_tx_sndbuf_nonempty() checks only peer_rmbe_space <=3D 0,
conn->killed, and conn->local_rx_ctrl.conn_state_flags.peer_conn_abort,
CPU0 is not stopped before abort_work acquires lock_sock(&smc->sk), and
can take the unclamped dst_len =3D len branch when prod.wrap !=3D cons.wrap.
Setting conn->killed =3D 1 or atomic_set(&conn->peer_rmbe_space, 0) before
dropping conn->send_lock would block the TX path immediately.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126150848.2116=
315-1-piyus@iiitd.ac.in?part=3D1
