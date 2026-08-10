Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECA13B9D97;
	Mon, 10 Aug 2026 23:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786403957; cv=none; b=P3kTQ2qcfKNqqXt7yZn9PaGigMv9U/ua3Z2bn/XJaAVcdG8CZGcT4jTbcKPQYvBbMnD9eBpOJwWbysiEoiZyy6Qdhmy3fvgvOTIe1nMm7Vkh4buyTuAPtF/YEYCLkAxAPl7iU+y8ADJ8LALSgL/fJboN//ot6dcQoldjlZX+ePE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786403957; c=relaxed/simple;
	bh=L0AKXJBvAZGKXAPVIct0/GrD2ytU2lnsU3MeywuN4NU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxiY/2G3zPb5sQNxlAIwnEiVQztiDJPpEW6fIkNZrhwkzJcUVso2AZDGcOCcsxzB5ZhHtzSuyV0pym3JRK45fLdBeIx3E740VopfOFCysKmrJh/LW3WuUYCvEmdKFbZALlYthV/EgQM0BcWvXok5Gce9fOpp2SeKkkV5IBaJAC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCqLTf15; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCqLTf15"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACFD1F000E9;
	Mon, 10 Aug 2026 23:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786403955;
	bh=rgO7H61q+f+FhrghRlHGl5HqKQjbNf8XYgfJ8GAU0uY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CCqLTf150Y+7Pu00FGxWA+WBl4ChAyYlEGC3eglzJgxY+eQAOiK9UoW2UjYWujZAN
	 DCiNfqRHPL68FD5BrxX2KlYZ6sUjFK7E9C7S423VLb3qJwi4wUaCuXIXcWKxgoyZAu
	 r3tiJMX5bMJ7JndG/QqAOq/mC34Vr7ss/D5p3kHVQ7nrNTr/yXbsNXaowZNcy74flG
	 PERrRlDVQSTIqipZU9T9oCGx1MMupdmzpHB/4M2IPnnolRbl6LtpqWtntjf41fAg7w
	 vLRjA/5aMnFYr6Yza5XnN1AUXwf3NoKBQTWj087u7WfRbEKql8hKhyLcYjmrKEImyU
	 C+f/Sf30eoj+A==
From: Jakub Kicinski <kuba@kernel.org>
To: hidayath@linux.ibm.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	mjambigi@linux.ibm.com,
	andrew+netdev@lunn.ch,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	pasic@linux.ibm.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net/smc: drop the abort_work reference when the work is cancelled
Date: Mon, 10 Aug 2026 16:19:13 -0700
Message-ID: <20260810231913.969204-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806081549.595001-1-hidayath@linux.ibm.com>
References: <20260806081549.595001-1-hidayath@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email says "*shiko finds more issues with the work termination here.
Can you please TAL and fix these all in one series?"
---
net/smc: drop the abort_work reference when the work is cancelled

The patch makes smc_conn_free() drop the socket reference handed to
conn->abort_work when cancel_work_sync() reports that the work was still
pending, so the sock_hold() taken by the scheduler of the work is not
leaked.  It follows the pattern smc_close_cancel_work() already uses for
conn->close_work.

A few questions about the surrounding cancel logic follow.

> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index b4208cb186c5e..3d4a86d99dd6b 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -1252,6 +1252,7 @@ static void smc_buf_unuse(struct smc_connection *conn,
>  /* remove a finished connection from its link group */
>  void smc_conn_free(struct smc_connection *conn)
>  {
> +	struct smc_sock *smc = container_of(conn, struct smc_sock, conn);
>  	struct smc_link_group *lgr = conn->lgr;
>  
>  	if (!lgr || conn->freed)
> @@ -1275,8 +1276,13 @@ static void smc_buf_unuse(struct smc_connection *conn,
>  		tasklet_kill(&conn->rx_tsklet);
>  	} else {
>  		smc_cdc_wait_pend_tx_wr(conn);
> -		if (current_work() != &conn->abort_work)
> -			cancel_work_sync(&conn->abort_work);
> +		/* If the work was pending (cancel returns true) it never ran,
> +		 * so the sock_hold taken by its scheduler was never released.
> +		 */
> +		if (current_work() != &conn->abort_work) {
> +			if (cancel_work_sync(&conn->abort_work))
> +				sock_put(&smc->sk);
> +		}

[Severity: High]
This isn't a bug introduced by this patch, but can this cancel_work_sync()
deadlock against a already-running abort_work?

The worker takes the socket lock as its first action:

net/smc/smc_core.c:smc_conn_abort_work() {
	lock_sock(&smc->sk);
	smc_conn_kill(conn, true);
	release_sock(&smc->sk);
	sock_put(&smc->sk); /* sock_hold done by schedulers of abort_work */
}

and the callers of smc_conn_free() reach it while holding that same lock:

net/smc/af_smc.c:__smc_release()
	lock_sock(sk);
	...
	if (!smc->use_fallback)
		smc_conn_free(&smc->conn);

net/smc/smc_close.c:smc_close_passive_work()  (inside lock_sock(sk))
	if ((sk->sk_state == SMC_CLOSED) &&
	    (sock_flag(sk, SOCK_DEAD) || !sk->sk_socket)) {
		smc_conn_free(conn);

net/smc/smc_close.c:smc_close_active_abort()  (SMC_PEERCLOSEWAIT1/2,
SMC_PEERFINCLOSEWAIT, SMC_PROCESSABORT, SMC_APPFINCLOSEWAIT)
		smc_conn_free(&smc->conn);

So if abort_work has already started on another CPU and is blocked in
lock_sock(), the closing task holds the socket lock and waits in
cancel_work_sync() for that worker, which cannot proceed.  The
current_work() != &conn->abort_work test only covers the case where the
same task is running abort_work itself.

Note both abort_work and close_work are queued on smc_close_wq, so
close_work running smc_close_passive_work() can be the blocking canceller.

The commit message cites smc_close_cancel_work() as the model:

	if (cancel_work_sync(&smc->conn.close_work))
		sock_put(sk);

but that helper drops the socket lock around the cancel:

net/smc/smc_close.c:smc_close_cancel_work() {
	release_sock(sk);
	if (cancel_work_sync(&smc->conn.close_work))
		sock_put(sk);
	cancel_delayed_work_sync(&smc->conn.tx_work);
	lock_sock(sk);
}

Should the abort_work cancel do the same, and would that change where the
new sock_put() has to live?

[Severity: High]
This is a pre-existing ordering issue rather than something the patch adds,
but does cancel_work_sync() here actually keep abort_work from being
re-armed?

The cancel happens before smc_lgr_unregister_conn(conn), so the receive
path can still find the connection:

net/smc/smc_cdc.c:smc_cdc_rx_handler() {
	read_lock_bh(&lgr->conns_lock);
	conn = smc_lgr_find_conn(ntohl(cdc->token), lgr);
	if (!conn || conn->out_of_sync) {
		read_unlock_bh(&lgr->conns_lock);
		return;
	}
	smc = container_of(conn, struct smc_sock, conn);
	sock_hold(&smc->sk);
	read_unlock_bh(&lgr->conns_lock);

and then queue the work again:

net/smc/smc_cdc.c:smc_cdc_msg_validate() {
		sock_hold(&smc->sk); /* sock_put in abort_work */
		if (!queue_work(smc_close_wq, &conn->abort_work))
			sock_put(&smc->sk);

cancel_work_sync() passes cflags 0, so it re-enables the work before
returning:

kernel/workqueue.c:__cancel_work_sync() {
	ret = __cancel_work(work, cflags | WORK_CANCEL_DISABLE);
	...
	if (wq_online)
		__flush_work(work, true);

	if (!(cflags & WORK_CANCEL_DISABLE))
		enable_work(work);

which means a queue_work() issued after the cancel returns succeeds.  The
freshly queued worker then runs smc_conn_abort_work() -> smc_conn_kill() on
a connection with conn->freed == 1 whose lgr reference smc_conn_free()
already dropped, and dereferences conn->lgr:

net/smc/smc_core.c:smc_conn_kill() {
	if (conn->lgr->is_smcd && conn->lgr->peer_shutdown)

Would unregistering the connection from lgr->conns_all before cancelling,
or gating the queueing on conn->freed under conns_lock, close that window?

>  	}
>  	if (!list_empty(&lgr->list)) {
>  		smc_buf_unuse(conn, lgr); /* allow buffer reuse */

[Severity: High]
This is also a pre-existing problem and not something introduced here, but
the patch documents smc_conn_free() as the place that disposes of a pending
abort_work, and one exit path of the function skips that disposal:

net/smc/smc_core.c:smc_conn_free() {
	if (!smc_conn_lgr_valid(conn))
		/* Connection has already unregistered from
		 * link group.
		 */
		goto lgr_put;
	...
lgr_put:
	if (!lgr->is_smcd)
		smcr_link_put(conn->lnk); /* link_hold in smc_conn_create() */
	smc_lgr_put(lgr); /* lgr_hold in smc_conn_create() */
}

On that path neither the cancel nor the new sock_put() runs, yet the
connection's link and link-group references are still dropped, and
conn->lgr is not reset.  A pending abort_work then dereferences it:

net/smc/smc_core.c:smc_conn_kill() {
	if (conn->lgr->is_smcd && conn->lgr->peer_shutdown)

Concretely, a peer sends a CDC message with prod_flags.failover_validation
and a stale seqno, so smc_cdc_msg_validate() queues abort_work.  Meanwhile
__smc_lgr_terminate() calls smc_conn_kill(), which does
smc_lgr_unregister_conn() (clearing alert_token_local) and then
smc_close_active_abort() -> smc_conn_free(); smc_conn_lgr_valid(conn) is
now false, so the goto lgr_put path is taken.  __smc_lgr_terminate() then
calls smc_lgr_free(), whose smc_lgr_put() drops the last reference and
kfree()s the lgr while abort_work is still queued.

Can the queued abort_work read a freed struct smc_link_group here, and
should this exit path also cancel the work and return its reference?
