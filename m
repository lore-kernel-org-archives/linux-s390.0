Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793022;
	b=4kGhC9IgKHmi5tXDAdwL1Zj27dJqU0uv/uqTK/qokNRl7j/f6IZgSFUGjsCaS5qkEmvC
	 NbBkaHhGL+beV02nb2WBPh8H7kUDrqacAEsOD0FKUjj7iJKArtJwTWwAvtI96UfexNbkn
	 lSdyAv9q3IT3EkG/pmu08j3c75cGHy3FbSebXpKsa2hdMOMRppYisy0ccpWY51joazncj
	 KZIGQwcwb2HDX6rLuLcPrhtJFeUpZDwRnAzKZV0ddd1cjj/KyPeulaFD8tnmq77PLNKvX
	 V7Z6azqCHegjyXXuCqX1Vvkjsz4n9Ex/ZlGA/UvFAIJTxKfS/du5pnidIjVzOyJBIEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793022;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=iKnrS/b9SCofd7Qh4S8W0JsBiqq98GiWl3YeYKUJlb4=;
	b=jD7vH0nqy9P9pTySEpTbaHR4nZ2mNVFTSyvUI4DMq+5iZF2TmImX9jIzrkA681oh2Pym
	 QhKAwmcQZAB1Qej+lnOLPaDkeZMeRsua4pJc0QfvGZY4hVDm331wRefLO69Duf5kJlubi
	 K5VK6Y/Q9lLhTNCacBcegVFbnRpaAPlW9u+z8eilVd1AWwjVU3NNxnWRxc4ZPCj3U10+N
	 3QPgZHJHQ0OiJe4oKpA4onejZ1gikvfp5lwqpI4x+gfumQlaB7YzRqkDSgANXQk/neE5x
	 v+C1aAv1vdZ3+krlFYC6UudnSL8ih/A6rDU5Kg4VCKU/hKF0S8ymtaRD06pxRCCLMnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bRGxa82A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD1E606A323;
	Fri, 27 Nov 2026 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bRGxa82A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670D91F00A1B;
	Fri, 27 Nov 2026 15:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795793022;
	bh=iKnrS/b9SCofd7Qh4S8W0JsBiqq98GiWl3YeYKUJlb4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bRGxa82Ai2wtUjaOpuafmnymzlxYQJPyWfbzawbhhJgLoFwVwN7lld6zcnA2M0x45
	 xJk12S7ymJgztJepA1oej+pWNTbIP98lrWiySt2rlQu+SmP+OikRz9UeinR1SCGttm
	 OmI70FlOB7Mww8RtXa4haWq72FpI2fBLnB9zaRhsGCySaIYuXz2kf4siTwnMjjD7td
	 bHd+tc/hbJw13LChClRMPCUNKllBuB1Mz5CJ8e6WIImBrlGwVAGCGzyvxlAOf82e6n
	 7tUleuC6MSQGs+MMW0HH3nhvovEHOUrdMKnUjsz0FPB4Cjq3lz/eMWqPZunsn71csj
	 f7qpoep0eCfCA==
Subject: Re: [PATCH net v4] net/smc: drop the connection when the peer's
 failover cursor is impossible
From: netdev-bot+sashiko@kernel.org
To: piyus@iiitd.ac.in
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kapil@presceralabs.ai, stable@vger.kernel.org
Date: Fri, 27 Nov 2026 15:23:40 +0000
Message-ID: <179579302091.3135.11782943757959613052@kernel.org>
In-Reply-To: <20261126150848.2116315-1-piyus@iiitd.ac.in>
References: <20261126150848.2116315-1-piyus@iiitd.ac.in>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 3 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch's safety argument does not hold: the state it says the
  early check avoids already exists before smc_switch_cursor() runs, and…
- [High] In smc_cursor_cannot_be_honest() (net/smc/smc_core.c:1083-1084),
  `if (smc_curs_comp(conn->peer_rmbe_size, cons, fin) >= 0) return…
- [High] The check runs on snapshots, but the repair then modifies live
  cursors that smc_cdc_tx_handler() can change in between, so the…
- [Medium] The honesty test in smc_cursor_cannot_be_honest() compares two
  distances built from separately read cursors, so an honest send…
- [Medium] smc_cursor_cannot_be_honest() measures how far cons is ahead
  of fin with smc_curs_diff(), which only sees whether the wraps differ,…
- [Medium] Off-by-one in smc_cursor_cannot_be_honest(): `diff >=
  conn->peer_rmbe_size` (smc_core.c:1092) rejects diff ==…

--

net/smc: drop the connection when the peer's failover cursor is impossible

This commit adds smc_cursor_cannot_be_honest(), which checks the peer's
consumer cursor before smc_switch_cursor() repairs the send cursors during
link failover. If the cursor is judged impossible, the connection is
marked out_of_sync, the abort flag is set, and abort_work is queued before
any cursor is rewound.

Link: https://lore.kernel.org/all/20261122053223.2497832-2-piyus@iiitd.ac.in/

> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index a3164201c1420..e15629b4e384b 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -1050,6 +1050,48 @@ static int smc_write_space(struct smc_connection *conn)

[ ... ]

> +static bool smc_cursor_cannot_be_honest(struct smc_connection *conn,
> +					union smc_host_cursor *fin,
> +					union smc_host_cursor *cons)
> +{
> +	union smc_host_cursor tx_fin, tx_sent;
> +	int diff, unconfirmed;
> +
> +	if (smc_curs_comp(conn->peer_rmbe_size, cons, fin) >= 0)
> +		return false;

[Severity: High]

Can the cons->count bound below be reached when cons's wrap is behind
fin's? The commit message says "Three things make the cursor impossible,
and smc_cursor_cannot_be_honest() checks all three". However, this early
return skips the count check whenever smc_curs_comp() is >= 0.

smc_curs_comp() returns >= 0 for any cons with cons.wrap < fin.wrap,
whatever cons.count is. At the same wrap, smc_cdc_cursor_to_host() accepts
any count that is not smaller than the old one:

	if ((old.wrap == temp.wrap) &&
	    (old.count > temp.count))
		return;
	smc_curs_copy(local, &temp, conn);

So a peer could install cons = (fin.wrap - 1, peer_rmbe_size + X). The
helper returns false, prod is set to fin, and smc_switch_cursor() then
does:

	atomic_set(&smc->conn.peer_rmbe_space, smc_write_space(conn));

In smc_write_space(), the unsigned arithmetic in smc_curs_diff() wraps:
(size - (size + X)) + F gives F - X, so space becomes size - F + X. Then
tx_work is queued. smc_tx_rdma_writes() sees prod.wrap != cons.wrap and
takes this branch:

		dst_len = len;

Here dst_off = F and len can be as large as size - F + X. Would that write
X bytes past the end of the peer RMBE?

There is a second variant. If cons.wrap = fin.wrap + 1 and the count is
huge, the max_t(int, 0, ...) in smc_curs_diff() clamps to 0, so
smc_curs_comp() returns 0. smc_write_space() then stores a negative
peer_rmbe_space and the connection stops sending for good. The commit
message says a simple cap would cause exactly this.

Should cons.count be checked before any comparison?

> +
> +	smc_curs_copy(&tx_fin, &conn->tx_curs_fin, conn);
> +	smc_curs_copy(&tx_sent, &conn->tx_curs_sent, conn);

[Severity: Medium]

Can an honest send completion that races with these reads make a good
connection look dishonest?

smc_switch_cursor() reads fin from conn->local_tx_ctrl_fin before these
reads of tx_curs_fin and tx_curs_sent. The only lock held is
conn->send_lock, taken by smc_switch_conns(). smc_cdc_tx_handler() runs
under bh_lock_sock() only and writes the cursors in the opposite order:

		atomic_add(diff, &cdcpend->conn->sndbuf_space);
		...
		smc_curs_copy(&conn->tx_curs_fin, &cdcpend->cursor, conn);
		smc_curs_copy(&conn->local_tx_ctrl_fin, &cdcpend->p_cursor,
			      conn);

If a completion lands between the fin read and the tx_fin read, fin is
stale and tx_fin is fresh. diff = cons - fin_old stays large, while
unconfirmed = tx_sent - tx_fin_new shrinks.

For example, say the peer honestly consumed everything (cons == prod) and
the last in-flight CDC completes inside that window. unconfirmed becomes
0 and diff > unconfirmed, so the connection gets out_of_sync,
peer_conn_abort and abort_work.

Successful completions on the old link during the switch look possible.
smc_llc_process_cli_delete_link(), smc_llc_process_srv_delete_link() and
smc_llc_delete_asym_link() call smc_switch_conns() on a QP that still
works, and only drain pending sends afterwards.

Given this, is the v4 changelog statement "Both differences now come from
cursor snapshots, so they are consistent with each other" accurate?

> +	diff = smc_curs_diff(conn->peer_rmbe_size, fin, cons);

[Severity: Medium]

Does this distance handle a cons that is two or more wraps ahead of fin?
smc_curs_diff() only checks whether the wraps differ, not by how much, and
smc_cdc_cursor_to_host() accepts any larger wrap.

Take cons = (fin.wrap + 2, c) with c < fin.count = f. smc_curs_comp() is
negative, so the check runs, and:

  diff = (size - f) + c < size
  cons.count = c < size
  diff <= unconfirmed, as long as size - f + c bytes are in flight

All three tests pass. The repair then sets prod = (fin.wrap + 1, c), which
is exactly one full RMBE behind cons, and smc_write_space() returns 0. The
helper's comment says "prod lands on cons, not behind it", which this
seems to contradict.

prod.wrap would then never match cons.wrap. Would the next normal-looking
cons advance credit peer_rmbe_space and send smc_tx_rdma_writes() down the
unclamped dst_len = len branch past the end of the RMBE?

The diff >= peer_rmbe_size test also seems wrong in the other direction.
Once cons.count < size is known, f + diff = size + c < 2 * size, so the
single subtraction in smc_curs_add() always keeps prod.count in range.
What the test does reject is cons.wrap == fin.wrap + 1 with c >= f. The
repair would handle that case exactly (prod == cons).

If sndbuf_desc->len > peer_rmbe_size and send completions lag, could an
honest connection reach that state and be aborted?

> +	unconfirmed = smc_curs_diff(conn->sndbuf_desc->len, &tx_fin, &tx_sent);
> +
> +	return cons->count >= (u32)conn->peer_rmbe_size ||
> +	       diff >= conn->peer_rmbe_size || diff > unconfirmed;

[Severity: Medium]

Is diff >= conn->peer_rmbe_size off by one? diff == peer_rmbe_size is the
largest value an honest peer can produce, and the existing repair handles
it exactly.

This can happen in the following case:

- sndbuf_desc->len >= peer_rmbe_size, for example equal buffer sizes.
- A full peer RMBE was written after local_tx_ctrl_fin.
- The peer consumed all of it, so cons = (fin.wrap + 1, fin.count).
- The send CQEs for those CDCs were not processed yet, or were flushed on
  link failure.

Then unconfirmed == size, so diff > unconfirmed is false and only this
test fires.

The repair is exact in that state:

- smc_curs_add(size, &prod, size) gives (fin.wrap + 1, fin.count), which
  equals cons.
- tx_curs_sent needs only one subtraction, since
  tx_fin.count + size < 2 * len.
- sndbuf_space goes from len - size back to at most len.

That failover worked before this patch. With the patch, the connection is
aborted. The helper's comment says a difference of peer_rmbe_size "would
survive the single subtraction smc_curs_add() does", which also looks
wrong for diff == size.

Should this be diff > conn->peer_rmbe_size?

> +}
> +
>  static int smc_switch_cursor(struct smc_sock *smc, struct smc_cdc_tx_pend *pend,
>  			     struct smc_wr_buf *wr_buf)
>  {
> @@ -1058,11 +1100,33 @@ static int smc_switch_cursor(struct smc_sock *smc, struct smc_cdc_tx_pend *pend,
>  	int rc = 0;
>  	int diff;
>  
> -	smc_curs_copy(&conn->tx_curs_sent, &conn->tx_curs_fin, conn);
> +	/* Before anything is rewound.  Returning from inside the repair below
> +	 * would leave local_tx_ctrl.prod behind local_rx_ctrl.cons with
> +	 * peer_rmbe_space still holding the credit the forged message made,
> +	 * and the tx path tests conn->killed and
> +	 * local_rx_ctrl.conn_state_flags.peer_conn_abort rather than
> +	 * out_of_sync or the flag set here - so a send under lock_sock() could
> +	 * reach smc_tx_rdma_writes() with prod < cons before abort_work takes
> +	 * the socket lock, and with the wraps differing that takes the
> +	 * dst_len = len branch without clamping to peer_rmbe_size -
> +	 * prod.count and writes past the end of the peer RMBE.
> +	 */
>  	smc_curs_copy(&fin, &conn->local_tx_ctrl_fin, conn);
> +	smc_curs_copy(&cons, &conn->local_rx_ctrl.cons, conn);
> +	if (smc_cursor_cannot_be_honest(conn, &fin, &cons)) {
> +		conn->out_of_sync = 1;	/* prevent any further receives */
> +		conn->local_tx_ctrl.conn_state_flags.peer_conn_abort = 1;
> +		smc_wr_tx_put_slot(conn->lnk,
> +				   (struct smc_wr_tx_pend_priv *)pend);
> +		sock_hold(&smc->sk); /* sock_put in abort_work */
> +		if (!queue_work(smc_close_wq, &conn->abort_work))
> +			sock_put(&smc->sk);
> +		return 0;
> +	}

[Severity: High]

Does checking early actually prevent the overrun described in the comment
above and in the commit message?

The normal receive path stores and credits the forged cons, with or
without a failover. smc_cdc_msg_recv_action() does:

	diff_cons = smc_curs_diff(conn->peer_rmbe_size, &cons_old,
				  &conn->local_rx_ctrl.cons);
	if (diff_cons) {
		...
		atomic_add(diff_cons, &conn->peer_rmbe_space);

Nothing checks that cons is at or behind local_tx_ctrl.prod, or that
cons.count < peer_rmbe_size. smc_cdc_cursor_to_host() only rejects
cursors that move backwards.

So a forged wrap bump or over-consumption already leaves prod < cons with
inflated credit. The same function then starts the sender:

	if ((diff_cons && smc_tx_prepared_sends(conn)) ||
	...

That reaches the unclamped dst_len = len branch with no link switch
involved:

smc_tx_pending()
  smc_tx_sndbuf_nonempty()
    smcr_tx_sndbuf_nonempty()
      smc_tx_rdma_writes()

When a failover does happen, this branch returns before peer_rmbe_space
is recomputed. It sets only out_of_sync and
local_tx_ctrl.conn_state_flags.peer_conn_abort. The tx gate in
smc_tx_sndbuf_nonempty() checks neither of them:

	if (conn->killed ||
	    conn->local_rx_ctrl.conn_state_flags.peer_conn_abort) {

Could a sender on the new link still overrun the peer RMBE until
abort_work runs?

Would it be better to validate the peer cursor where it is accepted, in
smc_cdc_msg_recv_action() or smc_cdc_cursor_to_host()? That would cover
every connection and make the failover-time check unnecessary.

The commit message does not mention this receive path. A stable
backporter could read it as fixing the forged-cons RMBE overrun.

> +
> +	smc_curs_copy(&conn->tx_curs_sent, &conn->tx_curs_fin, conn);

[Severity: High]

smc_cursor_cannot_be_honest() ran on snapshots of tx_curs_fin and
tx_curs_sent, but the repair here works on the live cursors. Can
smc_cdc_tx_handler() change them in between?

The repair copies the live conn->tx_curs_fin into tx_curs_sent. It then
advances tx_curs_fin and local_tx_ctrl_fin by diff and does
atomic_add(diff, &conn->sndbuf_space), holding only send_lock.

smc_cdc_tx_handler() runs under bh_lock_sock(). Between the snapshot and
the repair it can confirm d bytes, add d to sndbuf_space, and move
tx_curs_fin forward by d.

Suppose tx_curs_prep == tx_curs_sent and diff == unconfirmed. An honest
peer that consumed everything gets there, and so does a peer that sets
cons to exactly that value. sndbuf_space then ends at:

  len - unconfirmed + d + unconfirmed = len + d

and tx_curs_sent and tx_curs_fin end at sent + d, past tx_curs_prep.

smc_tx_sendmsg() then computes:

		copylen = min_t(size_t, send_remaining, writespace);

The second memcpy_from_msg() chunk, at offset 0, could then be up to
prep.count + d long. Could that write user data past the end of the
sndbuf allocation, or overwrite data that has not been sent yet?

The old link can still complete sends successfully during the switch.
smc_llc_process_srv_delete_link() does:

		if (smc_switch_conns(lgr, lnk_del, false))
			smc_wr_tx_wait_no_pending_sends(lnk_del);

The underlying race existed before this patch. Still, the patch says it
restores 0 <= sndbuf_space <= sndbuf_desc->len and discusses the
concurrency with smc_cdc_tx_handler(), yet it applies a diff validated on
snapshots to live state.

>  	/* set prod cursor to old state, enforce tx_rdma_writes() */
>  	smc_curs_copy(&conn->local_tx_ctrl.prod, &fin, conn);
> -	smc_curs_copy(&cons, &conn->local_rx_ctrl.cons, conn);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261126150848.2116315-1-piyus%40iiitd.ac.in
