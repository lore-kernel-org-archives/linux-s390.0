Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A4C431A2B;
	Thu,  6 Aug 2026 09:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008060; cv=none; b=Bk2d9ehNORMj2rCzNc7F/yFgoDoNlTKAdRbv5mcFQFfa6jpqS/Qqej8zR0tn4E3ixOZn0emywHb4mDv4Vjva27lA+G4BQmCfbvnQ5ObHqIEx64l2NqEcx2UwxAc3iuWkbEu/jAE5vwCqz1zhcxQ0lwZlXfXWKwf2cPtIUXJMiHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008060; c=relaxed/simple;
	bh=Rj2ZkKqK6RL+viYdwlruvZzP6MLzQql0LuRjsmfUx0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTrZ2yUO09DnZ71+aSX334dMF/Bf20MNKRkgU1RL7CGwH4QP3aLDkBpVlJn05NqGi7ajBe/mbZDNsX6faGM+p4j6Mfct5m+OemTK8YOLoYQC35Xir3GjQe/6gyfpPL73OcOkYn1ddH87aPnHwxfQIJ7wzj3k9PKVOLEJ7qN2RVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=r84GRn6w; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="r84GRn6w"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786008054; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=nFt5XC6qJL3jq1W5fsS5A7pLtf+tp21ckrhuUR4laoY=;
	b=r84GRn6wOSLUb7p/x0yFcVRo9LMVaLnkrz/Jk3gxlXdksmbcehtA50k+HHNTBLpYV045Jlw8rAg7NN8rcwNdq2bLBic2dkT5BFIvil0/GqQBE2/BiEKnaUOIATg8uw94pzHcGrVE18ZkFm8RTrJ1PKP00NxwFOi3ui8HUBvYjQI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0X8TZBB-_1786008053;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0X8TZBB-_1786008053 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 06 Aug 2026 17:20:54 +0800
Date: Thu, 6 Aug 2026 17:20:53 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Hidayath Khan <hidayath@linux.ibm.com>, alibuda@linux.alibaba.com,
	sidraya@linux.ibm.com, mjambigi@linux.ibm.com,
	andrew+netdev@lunn.ch
Cc: tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, pasic@linux.ibm.com, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net/smc: drop the abort_work reference when the work
 is cancelled
Message-ID: <anRR9doLcvlPAj4Q@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20260806081549.595001-1-hidayath@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806081549.595001-1-hidayath@linux.ibm.com>

On 2026-08-06 10:15:49, Hidayath Khan wrote:
>The schedulers of conn->abort_work hand a socket reference to the work
>item and rely on it to give the reference back:
>
>        sock_hold(&smc->sk); /* sock_put in abort_work */
>        if (!queue_work(smc_close_wq, &conn->abort_work))
>                sock_put(&smc->sk);
>
>The queue_work() failure case is handled, but the cancellation case is
>not. smc_conn_free() cancels a still-pending abort_work:
>
>        if (current_work() != &conn->abort_work)
>                cancel_work_sync(&conn->abort_work);
>
>and discards the return value.  When cancel_work_sync() returns true the
>work was queued but had not started, so smc_conn_abort_work() never runs
>and its sock_put() never happens.  The reference is lost.
>
>As in smc_switch_conns(), a leaked sk_refcnt means the smc_sock is never
>destroyed: its buffers stay allocated and the network namespace reference
>a user socket holds is never released, so the netns cannot be torn down.
>
>smc_cdc_msg_validate() queues abort_work from the receive tasklet when a
>peer sends a CDC message with an out-of-order sequence number, so a
>remote peer combined with a concurrent local close is enough to reach it.
>
>Drop the reference when the work is cancelled, matching the pattern
>smc_close_cancel_work() already uses for conn->close_work:
>
>        if (cancel_work_sync(&smc->conn.close_work))
>                sock_put(sk);
>
>The sock_put() is safe here: every caller of smc_conn_free() passes the
>connection of a socket it holds a reference to, so this cannot release
>the last one.
>
>Fixes: b286a0651e44 ("net/smc: handle incoming CDC validation message")
>Cc: stable@vger.kernel.org
>Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
>Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
>Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

Best regards,
Dust

>---
> net/smc/smc_core.c | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)
>
>diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
>index c0027d2fe4e8..dd9fffbe41e0 100644
>--- a/net/smc/smc_core.c
>+++ b/net/smc/smc_core.c
>@@ -1254,6 +1254,7 @@ static void smc_buf_unuse(struct smc_connection *conn,
> /* remove a finished connection from its link group */
> void smc_conn_free(struct smc_connection *conn)
> {
>+	struct smc_sock *smc = container_of(conn, struct smc_sock, conn);
> 	struct smc_link_group *lgr = conn->lgr;
> 
> 	if (!lgr || conn->freed)
>@@ -1277,8 +1278,13 @@ void smc_conn_free(struct smc_connection *conn)
> 		tasklet_kill(&conn->rx_tsklet);
> 	} else {
> 		smc_cdc_wait_pend_tx_wr(conn);
>-		if (current_work() != &conn->abort_work)
>-			cancel_work_sync(&conn->abort_work);
>+		/* If the work was pending (cancel returns true) it never ran,
>+		 * so the sock_hold taken by its scheduler was never released.
>+		 */
>+		if (current_work() != &conn->abort_work) {
>+			if (cancel_work_sync(&conn->abort_work))
>+				sock_put(&smc->sk);
>+		}
> 	}
> 	if (!list_empty(&lgr->list)) {
> 		smc_buf_unuse(conn, lgr); /* allow buffer reuse */
>
>base-commit: 2b1c2bc2355fd59cc75045e42d9dc5470ef5fa9a
>-- 
>2.52.0
