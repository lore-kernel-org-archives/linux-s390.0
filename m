Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702C8469825
	for <linux-s390@vger.kernel.org>; Wed, 29 Jul 2026 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343988; cv=none; b=DMjMFbFjPcoDdgVGZRXhkpGEMYQTO6drj834yb/s5BPimSWXj56Ekc/FiLG/sM7c/6v4K7rlW1KYv9cmzWoyd+Jn4Q+5LfwxY8ZU/PJ7fGyLq8G0fXt8kTh9nNNKnCRyNCFGItCYzK2Z76qTK7zGnWWCFnig+VTgG8Ilp4+IEPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343988; c=relaxed/simple;
	bh=G959MEJWX4nkncmOo6m5fxFl26zKyxqIRIu05SkidJ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PgJc+z6pvzkN96SeoR6DId2fIk6MqeJL/s4keh/kr0T/iWzW5dLxdDnUInjqnRO7gSqVdDII5R+iPGp/sbVvxXZ5ESLQkTiACriXoVnYCRA56r3Ef1XtmsWJlDNah4+bbEsGvJx8pHNun1sQWkzvaIrSKBopCvZ8sqmRBs4BFZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYTUUbZB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYTUUbZB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7C21F000E9;
	Wed, 29 Jul 2026 16:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785343987;
	bh=dnCpvFez96YHaOGXshMb5LQeZQY03JpJklJWP5VLaYM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OYTUUbZBGYCGD8N4SupTyV59j+k2hw4IHiatokeqp+6yPxm6tIQU7s5LdSawajtdX
	 AAZMXhBlXNB74PNYgTX1fGU6wk4cXQW/P70eirFtCvEBl/vO0b2F//ZJVkwZH8SRyb
	 CmrmEUXEUE2MnGnt29iMTqdroRagyQzS4c33JTHdzhQr5R9Q4ytET5ppwgHrVBrNrZ
	 jYPs5PFqLRvGOlKyFlGtUTQQRDNmz9ocPlxb29kf4r9t6N4T7J/nNEkmvFqi56cF66
	 VHZfSCTcRaNYZI8w87CVNoSa3wVWCyc1Ix07fpfQp1HehmffrGRx1McIzbxI40dsw7
	 hUUbiokQxivBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4] net/smc: order the CDC receive path against
 buffer publication
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260728-b4-disp-52ee4e7d-v4-1-0dda94b0f397@proton.me>
References: <20260728-b4-disp-52ee4e7d-v4-1-0dda94b0f397@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 16:53:06 +0000
Message-Id: <20260729165306.BE7C21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Time-Of-Check to Time-Of-Use (TOCTOU) vulnerability leading to NUL=
L pointer dereference in CDC receive path.
- [High] Improper teardown ordering allows Use-After-Free of SMC-D send buf=
fer descriptor.
- [High] Premature buffer freeing in `smc_conn_free` causes Use-After-Free =
of `rmb_desc` during CDC receive.
--

--- Patch [1]: [PATCH net v4] net/smc: order the CDC receive path against b=
uffer publication ---
commit 4253ee2293b7503f954eb700f0d01241f120e824
Author: Bryam Vargas <hexlabsecurity@proton.me>

net/smc: order the CDC receive path against buffer publication

This commit fixes a vulnerability where SMC CDC receive handlers dereference
unpublished buffer descriptors. It ensures the receive state is initialized
first and the buffers are published last using smp_store_release() and
smp_load_acquire().

Closes: https://sashiko.dev/#/patchset/20260714-b4-disp-835288a6-v2-1-58155=
5ef2145@proton.me?part=3D1

> diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
> index 32d6d03df3214..ea61b1e75c72c 100644
> --- a/net/smc/smc_cdc.c
> +++ b/net/smc/smc_cdc.c
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
> +	     conn->local_rx_ctrl.prod_flags.cons_curs_upd_req ||
> +	     conn->local_rx_ctrl.prod_flags.urg_data_pending)) {

[Severity: High]
This is a pre-existing issue, but does this create a Time-Of-Check to
Time-Of-Use vulnerability?

The code caches conn->sndbuf_desc into the local variable sndbuf_desc and
checks it for NULL, but then execution continues into smc_tx_prepared_sends=
(conn).

Looking at smc_tx_prepared_sends() in net/smc/smc_tx.h:

net/smc/smc_tx.h:smc_tx_prepared_sends() {
    union smc_host_cursor sent, prep;

    smc_curs_copy(&sent, &conn->tx_curs_sent, conn);
    smc_curs_copy(&prep, &conn->tx_curs_prep, conn);
    return smc_curs_diff(conn->sndbuf_desc->len, &sent, &prep);
}

Doesn't this helper re-read the global conn->sndbuf_desc? If a concurrent
teardown thread calls smcd_buf_detach() and nullifies it after the local
check, couldn't this lead to a NULL pointer dereference or use-after-free?

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but could there be a use-after-f=
ree
in the SMC-D send buffer descriptor teardown?

Looking at smc_conn_free() in net/smc/smc_core.c:

net/smc/smc_core.c:smc_conn_free() {
    ...
    if (smc_ism_support_dmb_nocopy(lgr->smcd))
        smcd_buf_detach(conn);
    tasklet_kill(&conn->rx_tsklet);
    ...
}

Because smcd_buf_detach() unconditionally frees conn->sndbuf_desc before
the receive tasklet is killed, and the tasklet runs concurrently in softirq
context, could the tasklet access the freed buffer descriptor if a peer
sends a CDC message during teardown?

[Severity: High]
This is a pre-existing issue, but does the teardown order in smc_conn_free()
allow a use-after-free of the receive buffer?

Looking at smc_conn_free() in net/smc/smc_core.c:

net/smc/smc_core.c:smc_conn_free() {
    ...
    smc_buf_unuse(conn, lgr);
    smc_lgr_unregister_conn(conn);
    ...
}

If the buffer had a registration error, smc_buf_unuse() will free the
rmb_desc. However, the connection is still in the link group's connection
tree at this point.

Could a concurrent IB receive handler (smc_cdc_rx_handler) look up the
connection and extract the dangling conn->rmb_desc pointer before it is
unregistered, leading to a use-after-free when smc_cdc_msg_recv_action()
dereferences it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-b4-disp-52=
ee4e7d-v4-1-0dda94b0f397@proton.me?part=3D1
