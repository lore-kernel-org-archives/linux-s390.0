Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1F82F2910
	for <linux-s390@vger.kernel.org>; Fri, 17 Jul 2026 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784296255; cv=none; b=YN8iItZ+2QyrX7NlA18SV/m1wwRxGB6TpeH8FVZqQO++5AOdwAOX47jBSrENl8ZuvpymmVa3Rko6bMXybgRNymGHP4eX3x1RVXSUIj5Xau1sjLbL5s1GB9nm4+2zFVVsB686rOJI55BAMbhaa44QHR6+GxPxIbxqxNJoLuNmF8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784296255; c=relaxed/simple;
	bh=g1wrmPN9S8wBY+ubRa4Fe9omYJZtwgQ4INZCcNW6dDA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZjWXJwO1nqWxeX5cXgX3BqSXG6t9kwFMkIDfo46O2NFqZOrCHkMOpXzrJVmvWK8T8lOMub6zyiRGC05Ids8gTShRNQlcqPsTtPn+xIHCe54wZkTfZBxkb1aNMWo2dImcamRwDuyPg32vqNGcAO38jpuH1bDe+hjF5ubdXH8UzJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjKfkRfK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjKfkRfK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0883F1F000E9;
	Fri, 17 Jul 2026 13:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784296254;
	bh=IaDFo1RO1MloN07pVv8kDvbdfixSx7vzYT7mqc5YXSM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CjKfkRfKTytQrrwt82+2bulHEHIkCz25NrByvoFGbNW+sf68Tj5xziKJgVwzdhkV1
	 1+lk70FZIfFTwy1Ytcgi2hrrZouMiBCD71QWh1BA2D5xs9bgEiBaJrn4bu67sfUDKf
	 q19MI7hQ1gz68zP/WLIsovl6P1WrTRj86Uj+GqR3OuR1PdppgP+HG4z+8njzXclOAC
	 30DxUZhjqlt63TZCmDvjk5/WI6nK1TGNK8DJRepDo9swKHn77Rcg3g373ZZSUXGfWr
	 RjiXnj2Y8eWbCEsqBLj4+XQHvUDr4isMGBjZvJku8GWIXAoCN4zVaZzlxIaGUET1ot
	 AHfaH4pq+6adA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3] net/smc: order the CDC receive path against
 buffer publication
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260716-b4-disp-aa52955a-v3-1-03a4411a7549@proton.me>
References: <20260716-b4-disp-aa52955a-v3-1-03a4411a7549@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 13:50:53 +0000
Message-Id: <20260717135054.0883F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unvalidated CDC message cursor counts lead to remote Out-of-Bo=
unds Read and Write in kernel memory.
- [High] Use-After-Free due to connection teardown destroying and freeing b=
uffers before ensuring concurrent receive tasklets or handlers have finishe=
d.
- [High] TOCTOU NULL pointer dereference introduced by incomplete caching o=
f `sndbuf_desc`.
--

--- Patch [1]: [PATCH net v3] net/smc: order the CDC receive path against b=
uffer publication ---
commit 53d359a16d34c960781b7b6d70a6d71513349061
Author: Bryam Vargas <hexlabsecurity@proton.me>

net/smc: order the CDC receive path against buffer publication

This commit addresses orderings in the SMC CDC receive path against buffer
publication. It initializes the receive state first and publishes buffers
using smp_store_release(). Handlers consume buffers with smp_load_acquire()
to avoid dereferencing unset pointers.

Closes: https://sashiko.dev/#/patchset/20260714-b4-disp-835288a6-v2-1-58155=
5ef2145@proton.me?part=3D1

> diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
> index 32d6d03df3214..ea61b1e75c72c 100644
> --- a/net/smc/smc_cdc.c
> +++ b/net/smc/smc_cdc.c
[ ... ]
> @@ -351,14 +363,17 @@ static void smc_cdc_msg_recv_action(struct smc_sock=
 *smc,
> =20
>  		/* if local sndbuf shares the same memory region with
>  		 * peer RMB, then update tx_curs_fin and sndbuf_space
> -		 * here since peer has already consumed the data.
> +		 * here since peer has already consumed the data.  The ghost
> +		 * sndbuf_desc (acquired above) may still be unset in the SMC-D
> +		 * DMB-nocopy setup window, so skip the update while it is NULL.
>  		 */
>  		if (conn->lgr->is_smcd &&
> -		    smc_ism_support_dmb_nocopy(conn->lgr->smcd)) {
> +		    smc_ism_support_dmb_nocopy(conn->lgr->smcd) &&
> +		    sndbuf_desc) {
>  			/* Calculate consumed data and
>  			 * increment free send buffer space.
>  			 */
> -			diff_tx =3D smc_curs_diff(conn->sndbuf_desc->len,
> +			diff_tx =3D smc_curs_diff(sndbuf_desc->len,
>  						&conn->tx_curs_fin,
>  						&conn->local_rx_ctrl.cons);

[Severity: Critical]
This is a pre-existing issue, but does this cursor difference calculation l=
ack
upper bounds checking?

A peer can send a CDC message with an inflated cursor count value.

Since smc_curs_diff() returns max_t(int, 0, (new->count - old->count)),
the returned difference can be arbitrarily large.

This difference is then applied to sndbuf_space and bytes_to_rcv.

Could an inflated bytes_to_rcv value cause the remainder chunk_len to exceed
the buffer size, resulting in an out-of-bounds read?

net/smc/smc_rx.c:smc_rx_recvmsg() {
    ...
    chunk_len =3D copylen - chunk_len;
    ...
    rc =3D memcpy_to_msg(msg, rcvbuf_base + chunk_off, chunk_len);
}

Similarly, could an inflated sndbuf_space lead to an out-of-bounds write
when calculating the second chunk length?

net/smc/smc_tx.c:smc_tx_sendmsg() {
    ...
    rc =3D memcpy_from_msg(sndbuf_base + chunk_off, msg, chunk_len);
}

>  			/* increase local sndbuf space and fin_curs */
[ ... ]
> @@ -391,10 +406,15 @@ static void smc_cdc_msg_recv_action(struct smc_sock=
 *smc,
>  			conn->urg_state =3D SMC_URG_NOTYET;
>  	}
> =20
> -	/* trigger sndbuf consumer: RDMA write into peer RMBE and CDC */
> -	if ((diff_cons && smc_tx_prepared_sends(conn)) ||
> -	    conn->local_rx_ctrl.prod_flags.cons_curs_upd_req ||
> -	    conn->local_rx_ctrl.prod_flags.urg_data_pending) {
> +	/* trigger sndbuf consumer: RDMA write into peer RMBE and CDC.
> +	 * smc_tx_prepared_sends() and smc_tx_pending() dereference sndbuf_desc,
> +	 * so skip the whole trigger while it is unset (the SMC-D DMB-nocopy
> +	 * setup window): there is nothing to send without a send buffer.
> +	 */
> +	if (sndbuf_desc &&
> +	    ((diff_cons && smc_tx_prepared_sends(conn)) ||

[Severity: High]
This isn't a bug introduced by this patch, but could this still lead to a n=
ull
pointer dereference?

The condition checks the locally acquired sndbuf_desc, but
smc_tx_prepared_sends() fetches conn->sndbuf_desc again directly:

net/smc/smc_tx.h:smc_tx_prepared_sends() {
    ...
    return smc_curs_diff(conn->sndbuf_desc->len, &sent, &prep);
}

If a concurrent teardown clears conn->sndbuf_desc right after the local
sndbuf_desc check passes, does smc_tx_prepared_sends() dereference null?

> +	     conn->local_rx_ctrl.prod_flags.cons_curs_upd_req ||
> +	     conn->local_rx_ctrl.prod_flags.urg_data_pending)) {
>  		if (!sock_owned_by_user(&smc->sk))
>  			smc_tx_pending(conn);
>  		else
[ ... ]
> @@ -443,13 +463,21 @@ static void smcd_cdc_rx_tsklet(struct tasklet_struc=
t *t)
>  {
>  	struct smc_connection *conn =3D from_tasklet(conn, t, rx_tsklet);
>  	struct smcd_cdc_msg *data_cdc;
> +	struct smc_buf_desc *rmb_desc;
>  	struct smcd_cdc_msg cdc;
>  	struct smc_sock *smc;
> =20
>  	if (!conn || conn->killed)
>  		return;
> +	/* Pair with smp_store_release() in __smc_buf_create(): the connection
> +	 * is published before its RMB is allocated, so bail while rmb_desc is
> +	 * unset to avoid a NULL deref and a load of an uninitialised buffer.
> +	 */
> +	rmb_desc =3D smp_load_acquire(&conn->rmb_desc);
> +	if (!rmb_desc)
> +		return;

[Severity: High]
This isn't a bug introduced by this patch, but can the receive tasklet race
with connection teardown here?

In smc_conn_kill(), the buffer is detached before the tasklet is stopped:

net/smc/smc_core.c:smc_conn_kill() {
    ...
    if (smc_ism_support_dmb_nocopy(conn->lgr->smcd))
        smcd_buf_detach(conn);
    if (soft)
        tasklet_kill(&conn->rx_tsklet);
}

Additionally, in smc_conn_free(), the buffer is marked for reuse before the
connection is removed from the link group tree:

net/smc/smc_core.c:smc_conn_free() {
    ...
    if (!list_empty(&lgr->list)) {
        smc_buf_unuse(conn, lgr);
        smc_lgr_unregister_conn(conn);
    }
}

Could these sequences allow a concurrent receive tasklet or handler to acqu=
ire
the connection and access a freed or reused buffer descriptor?

> =20
> -	data_cdc =3D (struct smcd_cdc_msg *)conn->rmb_desc->cpu_addr;
> +	data_cdc =3D (struct smcd_cdc_msg *)rmb_desc->cpu_addr;
>  	smcd_curs_copy(&cdc.prod, &data_cdc->prod, conn);
>  	smcd_curs_copy(&cdc.cons, &data_cdc->cons, conn);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716-b4-disp-aa=
52955a-v3-1-03a4411a7549@proton.me?part=3D1
