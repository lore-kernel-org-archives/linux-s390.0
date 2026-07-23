Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F76E3D45E6
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 10:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801925; cv=none; b=Q64iY2OExNDkNi+v0hx6IhcKh1aKdbNkzBSxj6JZJZ6q2IHuFUPyj3daxENKRMX6IZZCm7QV9f+VOUPUWLEwaFpsaiajkpj5LR/pi+6Ey7qGXEjKUCSSNcH6lEy0cQHiYh+DqyzaXEzmhhZWFQVAV0RBbzTn4l2tTtLt7KkL7V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801925; c=relaxed/simple;
	bh=FO/q1R7mOKKHRXhkAOl2xA7XUR+uAoJjCN/r0w9kWaA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ozf4dlpOvRwmU8DMAR+tsuCMSASAIWDUROclELYhUCDyariOjTkwH1gp3kzrLn1zLzc1gCiQeHn87ro1OSe6Ooqhc1tjQ/7Uc5zbiX3wsSaUc/B8Pk5p3AGloD0W58PTW/VC5DBXUkpl8G/IygQITxgyZFUNOqj1islp9IOpsIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnxgRMMt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnxgRMMt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66001F000E9;
	Thu, 23 Jul 2026 10:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784801924;
	bh=At7U8niYNKEIKXr8/EHpIvNXoZlnKtO25p26ACwAiko=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WnxgRMMtZeLbrdnxZ+Mu0OS92urRI19qikpzS0/k2GNEYdhfIjE5PErYU6Y9C0R0R
	 atCPDBiYv9jEV1GPlHh8p+q+InCB/Zx9I+AwQjiOkOl5bmMMRXQxXhzl9Sx9OeVwJP
	 VqmQDwbdlvkZEYCPPCcXs+pZynkl7sa4KLPTa5ar2RPRV33f8iyM5FxiQHwKMUVmoi
	 p146VeNiMGpiDF+yHTO98Q3po7c3k54y85KNw0jd5PtRpii1u6MzJK7rWCtHwKzA+L
	 DQggXLxuWUT6rpVzQOehHwFkT7eJYbA4MG7EDUm9kHH+fEyPSvs+EKREzbYGiMNx6L
	 XnnCXiNaNhKyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] net/smc: validate peer CDC cursor against RMBE
 size before accepting it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ibrahim Hashimov" <security@auditcode.ai>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260722101758.37817-1-security@auditcode.ai>
References: <20260722101758.37817-1-security@auditcode.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 10:18:43 +0000
Message-Id: <20260723101843.B66001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The patch bounds the cursor advance of a single CDC message bu=
t fails to limit the cumulative accumulation of `bytes_to_rcv` across multi=
ple messages. An attacker can repeatedly advance the cursor to inflate `byt=
es_to_rcv` beyond the buffer limits, resulting in the same out-of-bounds ke=
rnel memory read the patch attempted to fix.
- [Critical] The exact same remote kernel memory disclosure vulnerability r=
emains unfixed for SMC-D connections, as `smcd_cdc_msg_to_host()` skips cur=
sor validation.
- [High] Incoming CDC messages can be processed before connection buffers a=
re allocated, leading to a NULL pointer dereference on `conn->rmb_desc`.
- [High] On 32-bit systems, reading the 64-bit cursor from the SMC-D shared=
 DMA memory is protected only by a local OS spinlock, failing to prevent to=
rn reads against concurrent hardware modifications by the peer.
--

--- Patch [1]: [PATCH net v2] net/smc: validate peer CDC cursor against RMB=
E size before accepting it ---
commit 7b6c0d41f37fa23577369a83f25810b1711838f7
Author: Ibrahim Hashimov <security@auditcode.ai>

net/smc: validate peer CDC cursor against RMBE size before accepting it

This commit adds boundary checks to SMC-R CDC cursors at ingress to prevent
out-of-bounds reads. It introduces a size parameter to
smc_cdc_cursor_to_host() to reject cursors that exceed the buffer limits or
advance more than one buffer size.

> diff --git a/net/smc/smc_cdc.h b/net/smc/smc_cdc.h
> index 696cc11f2303b..b0ae4d43b0171 100644
> --- a/net/smc/smc_cdc.h
> +++ b/net/smc/smc_cdc.h

[ ... ]

> @@ -235,6 +236,21 @@ static inline void smc_cdc_cursor_to_host(union smc_=
host_cursor *local,
>  	if ((old.wrap =3D=3D temp.wrap) &&
>  	    (old.count > temp.count))
>  		return;
> +	/* count is an offset into the RMBE and must always stay inside
> +	 * it (see smc_curs_add()); the peer is untrusted, so reject an
> +	 * out-of-range wire cursor the same way an out-of-order one is
> +	 * already rejected above, instead of letting it drive
> +	 * bytes_to_rcv / the urgent-byte offset past the buffer end
> +	 */
> +	if (temp.count >=3D size)
> +		return;
> +	/* Bound the advance too: a wrap increment with temp.count above
> +	 * old.count makes smc_curs_diff() report more than one bufferful,
> +	 * which would inflate bytes_to_rcv / peer_rmbe_space past the buffer
> +	 * in smc_cdc_msg_recv_action(). Reject such a cursor.
> +	 */
> +	if (smc_curs_diff(size, &old, &temp) > size)
> +		return;

[Severity: Critical]
This is a pre-existing issue, but does this security check miss the stateful
cumulative buildup of the cursor?

By only validating single-message advances, could an attacker repeatedly
advance the cursor to inflate bytes_to_rcv beyond the buffer limits?

This could result in an out-of-bounds read if a malicious peer sends multip=
le
valid CDC messages that each advance the cursor within the single-message
bounds. These advances would continually add to bytes_to_rcv without clampi=
ng
to rmb_desc->len in smc_cdc_msg_recv_action():

smc_cdc_msg_recv_action() {
    ...
    atomic_add(diff_prod, &conn->bytes_to_rcv);
    ...
}

A subsequent user-space read via smc_rx_recvmsg() could then use this
inflated bytes_to_rcv value to read past the boundaries of the buffer:

smc_rx_recvmsg() {
    ...
    chunk_len =3D copylen - chunk_len; /* remainder */
    chunk_len_sum +=3D chunk_len;
    chunk_off =3D 0; /* modulo offset in recv ring buffer */
    ...
}

>  	smc_curs_copy(local, &temp, conn);
>  }
> =20
> @@ -246,8 +262,10 @@ static inline void smcr_cdc_msg_to_host(struct smc_h=
ost_cdc_msg *local,
>  	local->len =3D peer->len;
>  	local->seqno =3D ntohs(peer->seqno);
>  	local->token =3D ntohl(peer->token);
> -	smc_cdc_cursor_to_host(&local->prod, &peer->prod, conn);
> -	smc_cdc_cursor_to_host(&local->cons, &peer->cons, conn);
> +	smc_cdc_cursor_to_host(&local->prod, &peer->prod,
> +			       conn->rmb_desc->len, conn);

[Severity: High]
This isn't a bug introduced by this patch, but could this unconditional
dereference of conn->rmb_desc->len cause a kernel panic if rmb_desc is NULL?

If an attacker on an existing link group anticipates the predictable
alert_token_local and sends a matching CDC message right after
smc_lgr_register_conn() exposes the connection, the RX tasklet might
access conn->rmb_desc->len in smcr_cdc_msg_to_host() before
smc_buf_create() has allocated the buffer descriptors.

[Severity: Critical]
This is a pre-existing issue, but are SMC-D connections vulnerable to the s=
ame
remote kernel memory disclosure?

In smcd_cdc_msg_to_host(), the untrusted SMC-D cursor values appear to be
directly copied without applying the boundary checks introduced here for
SMC-R:

smcd_cdc_msg_to_host() {
    ...
    temp.wrap =3D peer->prod.wrap;
    temp.count =3D peer->prod.count;
    smc_curs_copy(&local->prod, &temp, conn);
    ...
}

Could a malicious peer over SMC-D (ISM) send a CDC message with an inflated
cursor, bypassing standard sanity checks and calculating arbitrary
differentials via smc_curs_diff() to inflate bytes_to_rcv?

[Severity: High]
This is a pre-existing issue, but does the spinlock in smcd_curs_copy()
actually protect against concurrent hardware DMA or cross-LPAR shared memory
modifications?

smcd_curs_copy() {
    ...
    spin_lock_irqsave(&conn->acurs_lock, flags);
    tgt->acurs =3D src->acurs;
    spin_unlock_irqrestore(&conn->acurs_lock, flags);
    ...
}

On 32-bit systems (where KERNEL_HAS_ATOMIC64 is not defined), reading the
64-bit cursor from the SMC-D shared DMA memory is protected by a local OS
spinlock.

Since the spinlock does not serialize with the peer's DMA/memory writes,
could this lead to a torn read of the 64-bit cursor if the compiler emits t=
wo
32-bit loads that interleave with the peer's writes?

> +	smc_cdc_cursor_to_host(&local->cons, &peer->cons,
> +			       conn->peer_rmbe_size, conn);
>  	local->prod_flags =3D peer->prod_flags;
>  	local->conn_state_flags =3D peer->conn_state_flags;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722101758.3781=
7-1-security@auditcode.ai?part=3D1
