Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134E92D12EE
	for <linux-s390@vger.kernel.org>; Thu, 11 Jun 2026 08:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781167724; cv=none; b=LlLgmyAUJyCWVeuqHYCxlTO1t7Y23b9v7jnrXJTs4Km7wYcC5Q08f3yAq8+puwhNIe2zFv6M9m6ioLyqXRXjKtw2TjAKVs7fU8TQ5y9RSTAhzJqPhiS3vfur7CD8oReKB/LGiwCX4Q0rXHxNKyFk2N4F8TXrEPNy1QcOWry2lNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781167724; c=relaxed/simple;
	bh=UqRS/76CbcjJiROIPXK85nDsiyp1M2q3vAL+Z73psN4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FCHGuCAWcVpoG2vFJodMWjO0g83QuM7QJ2jcmiMyOGB93bSQIBZ3hbPsv322qUUgXX5Zz4Uj3dO91bTo19O+HYdLnsTBJkaqw3YGAzGtiSI93PHMa6B6CeSt7q/eeAJ3ceYlBWP8Z9EuI5iJXvHzTxn0ybwvVoud0mLBiw6sFpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGhNGqi/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGhNGqi/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721531F00893;
	Thu, 11 Jun 2026 08:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781167722;
	bh=ib/tn5S4Xc7cWAvg4Ju2zhZw4C3fK2KRqWqSmig084I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eGhNGqi/A0Fat34nwJWB+/5hUzw71elRGsmiQ+jPeFpgRq7suI/RnkbWg6Q80CM7O
	 xCLz3gh9oNZgmO3UAwiPMHLY63w38Kz2/JHIy6Y3uwJqBIcx89IyVw/jUHMP4oS3OH
	 APnOJjMk2Rr1/uo/vnLt69HCEJ1DkjEAexUEYMetCNoYKfn2IXs4xm3RlaudH4wHwR
	 Lp9prfuDw6b7TkjIaZSqE3tztid/tFbRsstm31n8qL329gJgwz+xupLlG9v6Q5Wu4x
	 3sddOw53UxAzL1MlbBHCDFgpYv2YwFem5uPc9wzeDUOZj8ZHhifXJevxtX2i7qb0wW
	 PgNvvSGEa0Tjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] net/smc: bound the peer producer cursor on SMC-D and
 SMC-R CDC receive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260610084803.186516-1-hexlabsecurity@proton.me>
References: <20260610084803.186516-1-hexlabsecurity@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 08:48:42 +0000
Message-Id: <20260611084842.721531F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Incorrect clamping of SMC-R consumer cursor permanently stalls con=
nections with asymmetric buffer sizes.
- [High] A Time-of-Check to Time-of-Use (TOCTOU) race condition in clamping=
 `conn->bytes_to_rcv` allows out-of-bounds reads and data corruption.

Pre-existing issues:
- [Critical] Unbounded consumer cursor in SMC-D leaves a kernel heap buffer=
 overflow vulnerability unpatched in the send path.
--

commit c64247d450ada1697a0e227038dd52be750039e2
Author: Bryam Vargas <hexlabsecurity@proton.me>

net/smc: bound the peer producer cursor on SMC-D and SMC-R CDC receive

This commit adds bounds checking to the peer producer cursor in the SMC-D
and SMC-R receive paths to prevent out-of-bounds reads. It also clamps the
bytes_to_rcv metric to the receive buffer length.

> diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
> index 619b3bab38248..738c45fd5cd08 100644
> --- a/net/smc/smc_cdc.c
> +++ b/net/smc/smc_cdc.c
> @@ -382,6 +382,8 @@ static void smc_cdc_msg_recv_action(struct smc_sock *=
smc,
>  		smp_mb__before_atomic();
>  		atomic_add(diff_prod, &conn->bytes_to_rcv);
>  		/* guarantee 0 <=3D bytes_to_rcv <=3D rmb_desc->len */
> +		if (atomic_read(&conn->bytes_to_rcv) > conn->rmb_desc->len)
> +			atomic_set(&conn->bytes_to_rcv, conn->rmb_desc->len);

[Severity: High]
Does this non-atomic clamping sequence introduce a race condition?

If a peer sends a forged producer cursor to inflate diff_prod, bytes_to_rcv
will temporarily exceed rmb_desc->len during the window between the
atomic_add() and the atomic_set().

If smc_rx_recvmsg() is running concurrently in process context on another
CPU, could it read this transiently inflated value?

net/smc/smc_rx.c:smc_rx_recvmsg() {
    ...
    copylen =3D min_t(size_t, read_remaining, readable);
    ...
    chunk_len =3D copylen - chunk_len; /* remainder */
    ...
    rc =3D memcpy_to_msg(msg, rcvbuf_base + chunk_off, chunk_len);
}

If smc_rx_recvmsg() calculates a copylen larger than the buffer length based
on the oversized bytes_to_rcv, would this lead to an out-of-bounds read on
the second chunk?

Additionally, if smc_rx_recvmsg() executes an atomic_sub() during this exact
window, wouldn't the subsequent atomic_set() overwrite the subtracted value,
artificially inflating bytes_to_rcv again?

>  		smp_mb__after_atomic();
>  		smc->sk.sk_data_ready(&smc->sk);

[ ... ]

> diff --git a/net/smc/smc_cdc.h b/net/smc/smc_cdc.h
> index 696cc11f2303b..7fa6e0d3817f8 100644
> --- a/net/smc/smc_cdc.h
> +++ b/net/smc/smc_cdc.h
> @@ -230,6 +230,12 @@ static inline void smc_cdc_cursor_to_host(union smc_=
host_cursor *local,
>  	smc_curs_copy_net(&net, peer, conn);
>  	temp.count =3D ntohl(net.count);
>  	temp.wrap =3D ntohs(net.wrap);
> +	/* the peer producer cursor is wire-controlled; bound the SMC-R count to
> +	 * our RMB before it is used as a raw index by the urgent path, mirrori=
ng
> +	 * the SMC-D conversion in smcd_cdc_msg_to_host().
> +	 */
> +	if (temp.count > conn->rmb_desc->len)
> +		temp.count =3D conn->rmb_desc->len;

[Severity: High]
Does this hardcoded clamp permanently stall connections that use asymmetric
buffer sizes?

This function is used by smcr_cdc_msg_to_host() to parse both the producer
and consumer cursors:

net/smc/smc_cdc.h:smcr_cdc_msg_to_host() {
    smc_cdc_cursor_to_host(&local->prod, &peer->prod, conn);
    smc_cdc_cursor_to_host(&local->cons, &peer->cons, conn);
}

The consumer cursor represents the peer's read position within its own
receive buffer, so its natural limit is conn->peer_rmbe_size. If a
connection has a peer_rmbe_size larger than the local rmb_desc->len,
legitimate consumer cursor updates will be truncated by this new clamp.

When smc_curs_diff() computes the consumed space using this truncated
cursor, it yields zero. Does this prevent peer_rmbe_space from being
replenished, causing the sender to falsely believe the peer's buffer is
full and stalling the connection?

>  	if ((old.wrap > temp.wrap) && temp.wrap)
>  		return;

[ ... ]

> @@ -260,6 +266,12 @@ static inline void smcd_cdc_msg_to_host(struct smc_h=
ost_cdc_msg *local,
> =20
>  	temp.wrap =3D peer->prod.wrap;
>  	temp.count =3D peer->prod.count;
> +	/* the peer producer cursor is wire-controlled; a count past our RMB is
> +	 * used as a raw index by the urgent path (smc_cdc_handle_urg_data_arri=
val)
> +	 * and as a length by the recv path.  Bound it to the RMB.
> +	 */
> +	if (temp.count > conn->rmb_desc->len)
> +		temp.count =3D conn->rmb_desc->len;
>  	smc_curs_copy(&local->prod, &temp, conn);
> =20
>  	temp.wrap =3D peer->cons.wrap;

[Severity: Critical]
This is a pre-existing issue, but it appears the consumer cursor in
smcd_cdc_msg_to_host() is still left unbounded.

While the producer cursor is clamped, the consumer cursor is copied
directly:

net/smc/smc_cdc.h:smcd_cdc_msg_to_host() {
    temp.wrap =3D peer->cons.wrap;
    temp.count =3D peer->cons.count;
    smc_curs_copy(&local->cons, &temp, conn);
}

If a peer sends an SMC-D CDC message with an unexpectedly large consumer
count, this unbounded cursor is passed to smc_curs_diff() in
smc_cdc_msg_recv_action(), which generates an oversized diff_tx and inflates
conn->sndbuf_space past conn->sndbuf_desc->len.

When the local sender transmits data, can this inflated sndbuf_space allow
copylen to exceed the send buffer size in smc_tx_sendmsg()?

net/smc/smc_tx.c:smc_tx_sendmsg() {
    ...
    chunk_len =3D copylen - chunk_len; /* remainder */
    ...
    rc =3D memcpy_from_msg(sndbuf_base + chunk_off, msg, chunk_len);
}

During wrap-around, wouldn't the second chunk's length exceed the allocated
buffer bounds, resulting in an out-of-bounds memcpy_from_msg() into
adjacent memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610084803.1865=
16-1-hexlabsecurity@proton.me?part=3D1
