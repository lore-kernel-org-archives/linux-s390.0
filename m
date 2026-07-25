Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145A413A3F7
	for <linux-s390@vger.kernel.org>; Sat, 25 Jul 2026 06:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784960185; cv=none; b=UWNHa2jQ/342jLTH77Mz1Wh+atIwJIF0HVOwXeD6x69E38o7NDfvpFhL3IunjPEzFvfLyz9UTpOq/1r0Stbt6SQijJz6FDOywjhIKkrTwaO5QeK/z+fFpqmevDUg4yqYr+y9wiLUnZA8u9UfgzQgsN8s5+15Wq9W4+PRR2hKUPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784960185; c=relaxed/simple;
	bh=NiCe8Zk8J/HHO3iaei0ltFRpLyE9u/N+6c6AYE9qWOY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fnHiKUu0r0n+PIEkbDQhGLxjtoIoemPd8boc4nqF5c21ftw9H71kwSRZX9go5+Iq7nGgFfhMYDGzKz9N7EFS+pDPv25x92F+jWYBZzSq9okvb6yrTPPu22hoiw4OVwzamgzSAo0GJA9IjgJsNRHyAYGcH+lTPLk1W9ABpW6geMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnB6yMIS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnB6yMIS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559701F00A3A;
	Sat, 25 Jul 2026 06:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784960183;
	bh=tx0GUlz9xFqEC6nIq/bspIu3BgInc0Zjp/nqj3hBcAM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CnB6yMISOhjTvuyl1ypyekEQ25aq/hJ2v0kk5J9UoA1WoJGPOHb63xoB4hXs/FHpy
	 CAkdcJP7ZNeQEGGEhhmBNdpZxIxDGjv+SyofFSL7Ws/TQ4BOjPpTJurv/qmS1e0jqH
	 xsCptVqBb2U5qghPyFhBI9tx1QxMNJiuWl7L4bxbNRBxssXibS6Apb5RDZQZfwUOVw
	 z9XIe067oPpYUViJy6v7toa1Kz5wLxDss6vD4p9EK2u2CAM8pi7XGqRPSVuzfrrshY
	 xRoOS8SwxFR6XcTzZk4JDcwBLnkUMnUJMzpnCButW8GR8LUtWuhplBviUbJmMlgBuK
	 zJ600Pqtqu4kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] net/smc: fix out-of-bounds read of rkey array in
 SMC-Rv2 LLC processing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yehyeong Lee" <yhlee@isslab.korea.ac.kr>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260724061606.433735-1-yhlee@isslab.korea.ac.kr>
References: <20260724061606.433735-1-yhlee@isslab.korea.ac.kr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 06:16:22 +0000
Message-Id: <20260725061623.559701F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Data Race and Use-After-Overwrite in Asynchronous LLC Message Pr=
ocessing
--

--- Patch [1]: [PATCH net v2] net/smc: fix out-of-bounds read of rkey array=
 in SMC-Rv2 LLC processing ---
commit 63d9ad267ae12085da6001381c4f5b5b34c2bf73
Author: Yehyeong Lee <yhlee@isslab.korea.ac.kr>

net/smc: fix out-of-bounds read of rkey array in SMC-Rv2 LLC processing

This commit fixes an out-of-bounds read when processing SMC-Rv2 LLC messages
with oversized rkey counts in the non-shared receive-buffer layout. It
addresses the issue by copying the message body into the shared wr_rx_buf_v2
in the receive handler before the per-WR buffer is reposted.

> diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
> index 954b2ff1815c2..84d8d9024efa3 100644
> --- a/net/smc/smc_llc.c
> +++ b/net/smc/smc_llc.c

[ ... ]

> @@ -2104,6 +2105,26 @@ static void smc_llc_rx_handler(struct ib_wc *wc, v=
oid *buf)
>  	} else {
>  		if (llc->raw.hdr.length_v2 < sizeof(*llc))
>  			return; /* invalid message */
> +		/* For the non-shared v2 rxbuf layout the message body beyond
> +		 * SMC_WR_TX_SIZE lives only in the per-WR receive buffer, which
> +		 * is reposted as soon as this handler returns.  The LLC event
> +		 * handlers run later from a work item and read the body from
> +		 * wr_rx_buf_v2, so copy it there now - only the body, mirroring
> +		 * the shared-rxbuf layout where the spillover SGE DMAs the body
> +		 * into wr_rx_buf_v2 + SMC_WR_TX_SIZE.  The header is left to the
> +		 * handlers, which restore it from the per-qentry copy, so a later
> +		 * message reaching wr_rx_buf_v2 cannot clobber it.  wr_rx_buf_v2
> +		 * only exists for SMC_V2 link groups, so the link-group version
> +		 * is checked (not just the wire llc_version) to avoid a NULL
> +		 * dereference on a v1 link group.
> +		 */
> +		if (link->lgr->smc_version =3D=3D SMC_V2 &&
> +		    !smc_link_shared_v2_rxbuf(link) &&
> +		    wc->byte_len > SMC_WR_TX_SIZE)
> +			memcpy((u8 *)link->lgr->wr_rx_buf_v2 + SMC_WR_TX_SIZE,
> +			       (u8 *)llc + SMC_WR_TX_SIZE,
> +			       min_t(u32, wc->byte_len, SMC_WR_BUF_V2_SIZE) -
> +			       SMC_WR_TX_SIZE);

[Severity: Medium]
If a peer sends two oversized LLC messages in rapid succession, could this
memcpy() execute in the softirq handler while the first message is still
being processed by the smc_llc_event_work workqueue?

Since the workqueue reads from the same shared lgr->wr_rx_buf_v2 buffer:

smc_llc_rmt_delete_rkey() {
    ...
    if (smc_rtoken_delete(link, llcv2->rkey[i]))
    ...
}

Does this code introduce a data race regression causing torn reads, potenti=
ally
leading to the processing of mixed or overwritten payloads?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724061606.4337=
35-1-yhlee@isslab.korea.ac.kr?part=3D1
