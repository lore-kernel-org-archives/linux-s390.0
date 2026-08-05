Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1D647A87F;
	Wed,  5 Aug 2026 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945810; cv=none; b=rMQKL/AgUtQpjm5e2stUJUoHDy6BJqszN3+QvCQtTawLnIacXY5vS2yJLyre4Dgm4H/y6Zh+8qSmfAmeeVeo0rpjhBcFAUoSYMiPnaFQWCZx95RPErQTfpf+/UkIoet8OMdkSoJM///VUPa4PU3zd78vSk/0lBKe/qmlLMgFyAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945810; c=relaxed/simple;
	bh=VtJrWnXr55pY3CRZhFyDxSZbLjgbfYP294bPxt/06Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1fKkX+CMu0wMZY8otndy52wdVPiDLlBe3V1DIphYt1I7HY32OWEgClsZ6BPhzdCul+5jSMrgub0Tv61J2a8qsOn7nlrgxQHbSSnm2goJ7KAW2LLPnaAP6n6UalxTRCqqn01wT0bzU7JXNk1+sV80p8l3wEQ0dk8M2Wc3/Tmwxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKWIqJn6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKWIqJn6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351EA1F000E9;
	Wed,  5 Aug 2026 16:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785945801;
	bh=e+/e5gqfR/Jq5lsIZgPUzgBsDZ/9VWXD9hojNTKlGYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XKWIqJn6rRIPLtcTf0oEtCxJO5M9/L4jy1c4m7yc/4mxuAKndUblkkA3K3vEP4jQs
	 rbGkBk9qMgAcAQ34Ljz8Fj1gJQXi4ltCPvkKNxrAV9QNy5TrMYsECRAhsq9D8kLkhH
	 NT8155CH5l3SviDJlSfGVDVCR158xX6lglsXMaaOFOaCCsTpqdsLWASybaTbkfmha2
	 jiPKX0/gCnZ9nbbd3+bcmlusMAU8uWnkBxd3C+SvT6y9vt3I2Rz+PCvYHDEUeMJGnL
	 oYcQMc1IhVb6jcFoFRykB3kbfEjlhr7PK4y+1IaU23SyGESRqikRINPsMs32RhQqyv
	 Q3xhX6Il9CsLg==
Date: Wed, 5 Aug 2026 17:03:17 +0100
From: Simon Horman <horms@kernel.org>
To: Hidayath Khan <hidayath@linux.ibm.com>
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com, mjambigi@linux.ibm.com,
	andrew+netdev@lunn.ch, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pasic@linux.ibm.com,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net/smc: abort the connection when the peer
 overruns the RMB
Message-ID: <20260805160317.GW51943@horms.kernel.org>
References: <20260804141109.542202-1-hidayath@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804141109.542202-1-hidayath@linux.ibm.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260804141109.542202-1-hidayath@linux.ibm.com?part=1
---
--- Patch [1]: [PATCH net-next] net/smc: abort the connection when the peer overruns the RMB ---
commit fc7927463c41bac1e3a598538d104b46770ee787
Author: Hidayath Khan <hidayath@linux.ibm.com>

net/smc: abort the connection when the peer overruns the RMB

The patch factors the connection-abort sequence out of
smc_cdc_msg_validate() into a new helper smc_cdc_abort_conn(), and calls it
from smc_cdc_msg_recv_action() when the peer's producer cursor advance would
push conn->bytes_to_rcv past conn->rmb_desc->len.  The test is placed before
the atomic_add() and the rest of the message is abandoned.

A few questions about the new helper and its new caller below.

[Severity: Low]
[Finding: main-1-0]
[Sources: opus-5, old-prompts]
The commit message describes a peer-triggerable, user-visible defect
(SIOCINQ reporting a readable length that does not exist, poll() staying
readable with nothing for recvmsg() to return), but the patch carries
neither a Fixes: tag nor Cc: stable.

The accumulation site being repaired:

	atomic_add(diff_prod, &conn->bytes_to_rcv);
	/* guarantee 0 <= bytes_to_rcv <= rmb_desc->len */

is part of the original CDC receive implementation, so every stable release
carrying net/smc looks affected.  Could a Fixes: tag be added so backporters
know which releases to pick this up for?

Simon says: In a similar vein, if the above is so then perhaps
            the patch should be targeted at net rather than net-next?

> diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
> index 32d6d03df3214..d8f747bbc6f69 100644
> --- a/net/smc/smc_cdc.c
> +++ b/net/smc/smc_cdc.c
> @@ -305,6 +305,27 @@ static void smc_cdc_handle_urg_data_arrival(struct smc_sock *smc,
>  	sk_send_sigurg(&smc->sk);
>  }
>  
> +/* Drop a connection whose peer violated the CDC protocol.  @link is the link
> + * the offending message arrived on, or NULL when it is not known to the caller
> + * (SMC-D, and the shared receive path).  When @link is NULL conn->lnk is left
> + * unchanged: for SMC-R it already points to the right QP; for SMC-D there is
> + * no per-link QP to abort on.
> + */
> +static void smc_cdc_abort_conn(struct smc_sock *smc, struct smc_link *link)
> +{
> +	struct smc_connection *conn = &smc->conn;
> +
> +	conn->out_of_sync = 1;  /* prevent any further receives */

[Severity: Medium]
[Finding: main-2-6]
[Sources: opus-5, old-prompts]
The kerneldoc above states the link == NULL case covers SMC-D, and this
comment says the flag prevents any further receives.  Does
conn->out_of_sync actually stop receives on SMC-D?

The only reader of the flag is the SMC-R IB completion path:

net/smc/smc_cdc.c:smc_cdc_rx_handler() {
	...
	conn = smc_lgr_find_conn(ntohl(cdc->token), lgr);
	if (!conn || conn->out_of_sync) {
		read_unlock_bh(&lgr->conns_lock);
		return;
	}
	...
}

The SMC-D entry point gates on a different flag:

net/smc/smc_cdc.c:smcd_cdc_rx_tsklet() {
	...
	if (!conn || conn->killed)
		return;

	data_cdc = (struct smcd_cdc_msg *)conn->rmb_desc->cpu_addr;
	...
}

and conn->killed is only set later, inside smc_conn_kill(), once abort_work
actually runs.

For the window in between, can every further ISM DMB interrupt re-enter
smc_cdc_msg_recv_action() with peer-controlled cursors, keep updating
conn->local_rx_ctrl via smc_cdc_msg_to_host() and conn->peer_rmbe_space, and
trip the new test again?  Since queue_work() only fails while the item is
still pending, would a second abort_work run smc_conn_kill() on an
already-killed connection once the first one has started?

Would also testing conn->out_of_sync in smcd_cdc_rx_tsklet(), or at the top
of smc_cdc_msg_recv_action(), address this?

[Severity: Medium]
[Finding: main-5-17]
[Sources: opus-5, old-prompts]
This store now happens on the transport-shared receive path in softirq
context.  The flags share one storage unit:

net/smc/smc.h:struct smc_connection {
	...
	u8			killed : 1;	/* abnormal termination */
	u8			freed : 1;	/* normal termination */
	u8			out_of_sync : 1; /* out of sync with peer */
};

so conn->out_of_sync = 1 is a read-modify-write of that byte.
smc_conn_kill(), running from the abort_work queued right below, writes
conn->killed = 1 into the same byte from process context under lock_sock().

The receive path does not defer to the backlog when the socket is owned:

net/smc/smc_cdc.c:smc_cdc_msg_recv() {
	sock_hold(&smc->sk);
	bh_lock_sock(&smc->sk);
	smc_cdc_msg_recv_action(smc, cdc);
	bh_unlock_sock(&smc->sk);
	sock_put(&smc->sk); /* no free sk in softirq-context */
}

Can the two writers interleave and lose the killed update:

tasklet:    load the flags byte (killed == 0)
abort_work: store killed = 1
tasklet:    store the byte back with out_of_sync = 1 and killed == 0

Since smcd_cdc_rx_tsklet() gates only on conn->killed, would a lost killed
bit let a newly scheduled tasklet keep dereferencing conn->rmb_desc->cpu_addr
after smc_conn_kill() has already run smc_ism_unset_conn() and
smcd_buf_detach()?  And on SMC-R, would a lost out_of_sync bit defeat the
receive barrier this patch relies on?

> +	spin_lock_bh(&conn->send_lock);
> +	conn->local_tx_ctrl.conn_state_flags.peer_conn_abort = 1;
> +	if (link)
> +		conn->lnk = link;
> +	spin_unlock_bh(&conn->send_lock);
> +	sock_hold(&smc->sk); /* sock_put in abort_work */
> +	if (!queue_work(smc_close_wq, &conn->abort_work))
> +		sock_put(&smc->sk);
> +}

[Severity: High]
[Finding: main-3-9]
[Sources: opus-5, old-prompts]
This queues conn->abort_work with no is_smcd distinction, and the new caller
in smc_cdc_msg_recv_action() is reachable from smcd_cdc_rx_tsklet().  The
only other caller, smc_cdc_msg_validate(), runs from smc_cdc_rx_handler(),
an ib_wc handler, so is this the first path that can queue abort_work for an
SMC-D connection?

smc_conn_free() only cancels the work in its non-SMC-D branch:

net/smc/smc_core.c:smc_conn_free() {
	...
	if (lgr->is_smcd) {
		if (!list_empty(&lgr->list))
			smc_ism_unset_conn(conn);
		if (smc_ism_support_dmb_nocopy(lgr->smcd))
			smcd_buf_detach(conn);
		tasklet_kill(&conn->rx_tsklet);
	} else {
		smc_cdc_wait_pend_tx_wr(conn);
		if (current_work() != &conn->abort_work)
			cancel_work_sync(&conn->abort_work);
	}
	if (!list_empty(&lgr->list)) {
		smc_buf_unuse(conn, lgr); /* allow buffer reuse */
		smc_lgr_unregister_conn(conn);
	}
	...
	smc_lgr_put(lgr); /* lgr_hold in smc_conn_create() */
}

So if the peer trips the new test and the application then closes the
socket, can a still-pending abort_work outlive smc_conn_free() and later
run smc_conn_kill()?

net/smc/smc_core.c:smc_conn_kill() {
	if (conn->lgr->is_smcd && conn->lgr->peer_shutdown)
	...
	if (conn->lgr->is_smcd) {
		smc_ism_unset_conn(conn);
	...
}

Two things look problematic there.  conn->lgr is dereferenced
unconditionally although smc_conn_free() already dropped the connection's
reference with smc_lgr_put() and never NULLs conn->lgr.  And
smc_ism_unset_conn() uses a descriptor that smc_buf_unuse() already returned
to the reuse pool:

net/smc/smc_ism.c:smc_ism_unset_conn() {
	if (!conn->rmb_desc)
		return;

	spin_lock_irqsave(&conn->lgr->smcd->lock, flags);
	conn->lgr->smcd->conn[conn->rmb_desc->sba_idx] = NULL;
	spin_unlock_irqrestore(&conn->lgr->smcd->lock, flags);
}

Since smc_buf_get_slot() hands back any descriptor with used == 0 and the
new owner is registered via smc_ism_set_conn(), can this clear the
smcd->conn[] slot of a different, live connection and stop its receives?
The sock_hold() here keeps the smc_sock alive but does not pin the link
group or the buffer descriptor.

Simon says: I think the issue flagged below is out of scope for this patch.

[Severity: High]
[Finding: old-prompts-4-16]
[Sources: old-prompts]
This isn't a bug introduced by this patch, since smc_cdc_msg_validate() used
the same hold-and-queue idiom before, but the patch makes it reachable from
any peer-driven producer-cursor advance rather than only from
failover-validation messages, so it seems worth raising here.

The reference taken by sock_hold() is documented as released by abort_work,
and the only sock_put() is there:

net/smc/smc_core.c:smc_conn_abort_work() {
	...
	sock_put(&smc->sk); /* sock_hold done by schedulers of abort_work */
}

But smc_conn_free() discards the return value when it cancels a still
pending item:

	if (current_work() != &conn->abort_work)
		cancel_work_sync(&conn->abort_work);

cancel_work_sync() returns true exactly when the work was removed without
ever executing.  In that case smc_conn_abort_work() never runs, so does the
struct smc_sock leak because sk_refcnt never reaches zero and sk_free() is
never called?

The sibling work item uses the compensating put:

net/smc/smc_close.c:smc_close_cancel_work() {
	...
	if (cancel_work_sync(&smc->conn.close_work))
		sock_put(sk);
	...
}

Should the abort_work cancel path do the same?

> @@ -314,17 +335,8 @@ static void smc_cdc_msg_validate(struct smc_sock *smc, struct smc_cdc_msg *cdc,

[ ... ]

> @@ -376,6 +388,11 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
>  	diff_prod = smc_curs_diff(conn->rmb_desc->len, &prod_old,
>  				  &conn->local_rx_ctrl.prod);
>  	if (diff_prod) {
> +		if (diff_prod > conn->rmb_desc->len -
> +				atomic_read(&conn->bytes_to_rcv)) {
> +			smc_cdc_abort_conn(smc, NULL);
> +			return;
> +		}

Simon says: Also, seems out of scope for this patch

[Severity: Medium]
[Finding: main-1-1]
[Sources: opus-5, old-prompts]
This is a pre-existing issue, but two sibling accumulators in the same
function are fed by the same peer-controlled cursor and are still unbounded,
and both are updated before this new test runs:

	diff_cons = smc_curs_diff(conn->peer_rmbe_size, &cons_old,
				  &conn->local_rx_ctrl.cons);
	if (diff_cons) {
		...
		atomic_add(diff_cons, &conn->peer_rmbe_space);
		/* guarantee 0 <= peer_rmbe_space <= peer_rmbe_size */

and, on the SMC-D dmb-nocopy path:

			atomic_add(diff_tx, &conn->sndbuf_space);
			/* guarantee 0 <= sndbuf_space <= sndbuf_desc->len */

Both deltas come from conn->local_rx_ctrl.cons, which is as peer-controlled
as the prod cursor this patch defends against, and smcd_cdc_msg_to_host()
copies it verbatim while smc_cdc_cursor_to_host() only rejects a backwards
move.

The commit message says:

    The test precedes the atomic_add() so the counter is never left inflated

Is that only true for bytes_to_rcv?  Even the message that trips the new
check has already inflated peer_rmbe_space (and sndbuf_space on
loopback-ISM) by the time the abort is queued.  Should the wording be
narrowed to bytes_to_rcv, or should the same treatment be applied to the
cons-derived accumulators?

>  		if (conn->local_rx_ctrl.prod_flags.urg_data_present)
>  			smc_cdc_handle_urg_data_arrival(smc, &diff_prod);

Simon says: Also, seems out of scope for this patch

[Severity: Critical]
[Finding: main-6-20]
[Sources: opus-5, old-prompts]
This isn't a bug introduced by this patch, but the new test bounds only the
delta and the commit message explicitly dismisses bounding the cursor
("Bounding the cursor does not help"), so it seems worth stating that the
delta check does not protect the call directly below it.

smc_cdc_handle_urg_data_arrival() uses the absolute peer-supplied count as a
byte offset into the RMB:

net/smc/smc_cdc.c:smc_cdc_handle_urg_data_arrival() {
	...
	base = (char *)conn->rmb_desc->cpu_addr + conn->rx_off;
	if (conn->urg_curs.count)
		conn->urg_rx_byte = *(base + conn->urg_curs.count - 1);
	...
}

Can a peer keep prod.count out of range while still producing a small delta?
smc_curs_diff() computes the wrap case in unsigned int arithmetic:

net/smc/smc_cdc.h:smc_curs_diff() {
	if (old->wrap != new->wrap)
		return max_t(int, 0,
			     ((size - old->count) + new->count));

	return max_t(int, 0, (new->count - old->count));
}

With old = {wrap 0, count 0} and new = {wrap 1, count 0xfffffff0} this wraps
modulo 2^32 and yields len - 16, which passes

	diff_prod > conn->rmb_desc->len - atomic_read(&conn->bytes_to_rcv)

for small bytes_to_rcv, while prod.count stays near 4G.  A variant without
the wrap trick: a first message with count 0x80000000 gives
max_t(int, 0, negative) == 0 and is stored, then count 0x80000001 gives
diff_prod == 1.

Nothing clamps the absolute count: smc_cdc_cursor_to_host() only rejects a
backwards move, and smcd_cdc_msg_to_host() copies peer->prod.wrap and
peer->prod.count with no validation.  The byte read at that offset is then
handed to user space:

net/smc/smc_rx.c:smc_rx_recv_urg() {
	...
	rc = memcpy_to_msg(msg, &conn->urg_rx_byte, 1);
	...
}

so is this an out-of-bounds read at a peer-chosen offset that either leaks
kernel memory through recvmsg(MSG_OOB) or faults on unmapped memory?  Would
validating prod.count < conn->rmb_desc->len alongside the new delta test be
appropriate?

>  		/* bytes_to_rcv is decreased in smc_recvmsg */
