Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D99B3B6346;
	Tue, 11 Aug 2026 12:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450759; cv=none; b=f3YpK8n5TYVqGhysZVtSMOdz224YqUwoe7/uz6kr8AnBwqq0JsETGQ4TUav8F9j92m1lfIdV+7lh88gRLFnFFQ9A6WUD5BZD2oMfPnBrOQqvEdN1dKVXYHmOky7s3sKlsMv3EIBjr1UIz2ib5CO/2yEB/tlpCvRYdo4fs/SbcqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450759; c=relaxed/simple;
	bh=ZsfJkkF+3s7Cw2VC+bVec0eQIPKX+EYKXWihETGaVqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VI9iR2mPWvoiQ9fDNXpG01wtx0d0mxgtwCzeKVmEmQGSZrafz3S34I2+NKtjENmUKCTCkttYFJGeGeb1nYxGBQ4xHWzb7z2OC1AeLYFUzxA5zR6U8dtQnpIiUC/kfnH5SEeD/BBIEvlRVUSHyMjGZumnRqq1aVCKRGKk3GJSggE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXNMjobD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXNMjobD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F85C1F000E9;
	Tue, 11 Aug 2026 12:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786450757;
	bh=Xvzc+EeNb8Im8dB3S7R/NiVmDdjq/C66nQ7WBuXB2zI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TXNMjobDbIc63sDdOlI10Nh7q+mnPvAo/JjD3mXhc/Dl6aXE+nsN3rUP2cAaVyW1L
	 Z7o2I8sszdUezbEQLc5RmQXjA479gzmknsqjoZ8u3YbqkZYsltanbXordLkwxhAGY2
	 5G/AP2+nIs7Us0k7/N9hnbNk0PdTqusrMBKZ78wBdCOc2NhwlTXPjnaDUTJD/v6/xQ
	 W3UVqF9Gx2/dEEvrP2SLTIEAy9TMw6gPO2TIL27uMCUL5YjrkpZcV6QHhxGfMyBU7m
	 7XqGq5BghAS/BtC9jOPRhTMG1LJI2pTzoq/wwsa0PhjCSHxyppnWfmgwaF3qRvdVD9
	 zocZhajt+iBig==
Date: Tue, 11 Aug 2026 13:19:13 +0100
From: Simon Horman <horms@kernel.org>
To: Hidayath Khan <hidayath@linux.ibm.com>
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com, mjambigi@linux.ibm.com,
	andrew+netdev@lunn.ch, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pasic@linux.ibm.com,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net/smc: fix use-after-free in
 smc_rx_pipe_buf_release()
Message-ID: <20260811121913.GD51943@horms.kernel.org>
References: <20260810064041.720441-1-hidayath@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810064041.720441-1-hidayath@linux.ibm.com>

On Mon, Aug 10, 2026 at 08:40:41AM +0200, Hidayath Khan wrote:
> smc_rx_splice() hands RMB pages to a pipe and takes a socket reference for
> each entry, so the smc_sock survives until the reader is done.  The
> connection does not: a close in between runs smc_conn_free(), which
> releases the link group and returns the receive buffer to the link group's
> pool.
> 
> smc_rx_pipe_buf_release() tries to detect that by testing sk_state, but it
> does so before taking the socket lock, and then dereferences the connection
> anyway:
> 
>         if (sk->sk_state == SMC_CLOSED || ...)
>                 goto out;
>         conn = &smc->conn;
>         lock_sock(sk);
>         smc_rx_update_cons(smc, priv->len);
> 
> smc_rx_update_cons() reads conn->rmb_desc->len twice and then calls
> smc_tx_consumer_update(), which walks conn->lgr and conn->lnk.  The state
> can change between the test and the lock, and on the is_reg_err path
> smcr_buf_unuse() does not recycle the descriptor but frees it outright, so
> this is a use-after-free rather than a stale read.
> 
> sk_state is also the wrong thing to test.  Take the socket lock first so
> the test and the cursor update cannot be separated, and test the receive
> buffer itself, which is what the code goes on to dereference.
> 
> For that test to mean anything, smc_buf_unuse() has to stop leaving a
> pointer to a descriptor it has just released; clear conn->rmb_desc there.
> Nothing in smc_conn_free() reads it afterwards, and smc_ism_unset_conn()
> already returns early on a NULL rmb_desc, so an SMC-D teardown that reaches
> it twice becomes a no-op instead of indexing smcd->conn[] with a stale
> sba_idx.
> 
> Fixes: 9014db202cb7 ("smc: add support for splice()")
> Cc: stable@vger.kernel.org
> Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
> Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
> ---
>  net/smc/smc_core.c |  1 +
>  net/smc/smc_rx.c   | 10 ++++++----
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index c0027d2fe4e8..def65ebc0b53 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -1248,6 +1248,7 @@ static void smc_buf_unuse(struct smc_connection *conn,
>  			WRITE_ONCE(conn->rmb_desc->used, 0);
>  		}
>  		SMC_STAT_RMB_SIZE(smc, is_smcd, true, false, bufsize);
> +		conn->rmb_desc = NULL;
>  	}
>  }

Hi,

The AI-generated review at [1] flags the following.
Could you take a look?

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260810064041.720441-1-hidayath%40linux.ibm.com

AI-generated review text:

  Before this change conn->rmb_desc stayed non-NULL once it was set, so
  readers that never take the socket lock could only ever see a stale (still
  mapped) descriptor.  Can this new store turn those into NULL
  dereferences?

  Two paths look exposed.  First, the SMC-R CDC receive path.  In
  smc_conn_free() the buffer is released before the conn leaves the link
  group:

  net/smc/smc_core.c:smc_conn_free() {
	...
	if (!list_empty(&lgr->list)) {
		smc_buf_unuse(conn, lgr); /* allow buffer reuse */
		smc_lgr_unregister_conn(conn);
	}
	...
  }

  So there is a window where the conn is still in lgr->conns_all with
  rmb_desc == NULL.  smc_cdc_rx_handler() finds it there, and
  smc_cdc_msg_recv() only takes bh_lock_sock():

  net/smc/smc_cdc.c:smc_cdc_msg_recv() {
	sock_hold(&smc->sk);
	bh_lock_sock(&smc->sk);
	smc_cdc_msg_recv_action(smc, cdc);
	bh_unlock_sock(&smc->sk);
	...
  }

  bh_lock_sock() takes sk->sk_lock.slock and does not exclude a
  process-context lock_sock() owner running smc_release() ->
  __smc_release() -> smc_conn_free(), which is why
  smc_cdc_msg_recv_action() itself has to check sock_owned_by_user().  That
  same function then does:

  net/smc/smc_cdc.c:smc_cdc_msg_recv_action() {
	...
	diff_prod = smc_curs_diff(conn->rmb_desc->len, &prod_old,
				  &conn->local_rx_ctrl.prod);
	...
  }

  and on urgent data smc_cdc_handle_urg_data_arrival() does:

  net/smc/smc_cdc.c:smc_cdc_handle_urg_data_arrival() {
	base = (char *)conn->rmb_desc->cpu_addr + conn->rx_off;
	if (conn->urg_curs.count)
		conn->urg_rx_byte = *(base + conn->urg_curs.count - 1);
	else
		conn->urg_rx_byte = *(base + conn->rmb_desc->len - 1);
	...
  }

  Neither has a NULL check, and this runs in softirq/tasklet context.  Would
  it be safer to clear rmb_desc after smc_lgr_unregister_conn(), once the
  conn can no longer be found by the CDC handler?

  Second, the sock_diag dump.  smc_diag_dump_proto() walks the sockets under
  read_lock(&prot->h.smc_hash->lock) only, never lock_sock(), and
  __smc_diag_dump() tests the pointer in the condition:

  net/smc/smc_diag.c:__smc_diag_dump() {
	...
	if (smc_conn_lgr_valid(&smc->conn) && smc->conn.lgr->is_smcd &&
	    (req->diag_ext & (1 << (SMC_DIAG_DMBINFO - 1))) &&
	    !list_empty(&smc->conn.lgr->list) && smc->conn.rmb_desc) {
	...
		dinfo.token = conn->rmb_desc->token;
	...
  }

  Can a close on another CPU clear the pointer between that test and the
  conn->rmb_desc->token dereference?  The same file also does the plain
  double load

	.rmbe_size = conn->rmb_desc ? conn->rmb_desc->len : 0,

  with no READ_ONCE, which the compiler may reload after the test.
