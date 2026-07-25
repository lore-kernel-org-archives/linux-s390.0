Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B4A231827
	for <linux-s390@vger.kernel.org>; Sat, 25 Jul 2026 00:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784939025; cv=none; b=uRTN8JIkP6iJO4Y9O5VZvIkV32gru1M2v837VcBozH+TmPXrSJViRaaM8NEm8MX4gBy9wmONJv1p8vHy9907NkKOApJmy8SEo8gy5uz5MjO0Xp2iDgIkzuNASj94CXAYiqXriHJnpQGqe4C5fKO61GoPXFC34rsi7LOyPQUgCYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784939025; c=relaxed/simple;
	bh=QZrcYCoXntfzqKbKnhrFBz8MOnN1WHj48T2+HtEwwB8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k2qOeZHiBx+PS6ULFxcBUY5WdazJz2UMmo/z2JspcidZRkjVUrlRS1asjroFtSi0xTfe2gWuCfFvFBuq0jp/tsF2uIbKuMK4bSsdmgcQnoV12T/TzoDnGzzvHyZSAZwcMqR6dWeAlPDGsa0/zcDsZKbtSW16tcP1CHvFemJMv4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvW6nDul; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvW6nDul"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765ED1F000E9;
	Sat, 25 Jul 2026 00:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784939023;
	bh=4p3+FR8LRA2uVfSMSmjLXOhAZKC1L0hwNh2kz/iUqUg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VvW6nDulT5S1cpO0A7GYtQmxhsk9f8xyGogYH7hxdui59NuI8+gnTLLtUiG2lRqOY
	 8BBPLcRzZiekQswfkyq3TNkq1G06krB6YGiZrYPaVAK3aoMK0Scp8ZzH9Hc6Gs2JI3
	 /CHH8qJC8LIOWIXpeiJem8ywT96UnbfBuPfrAWE9JWy/uAO4B6GRowauVwnuKOl8nK
	 R2tsYZVZBjme2znv89jMpbiqYrQin6J/y4F4PGp3pCOgnJSRJj+JzqDg42y2gCCwsf
	 EbP7x1xRL1dqkA8Rt0unh4xpAkAAKdxdrthINzh94OQ1vomS6R1okoOQ21Jd2SBezP
	 riXZ/NmGJ/ZLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 2/3] net/smc: bound the receive length to the RMB
 in smc_rx_recvmsg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260723-b4-disp-0d07164f-v5-2-6a9e235dbc4e@proton.me>
References: <20260723-b4-disp-0d07164f-v5-0-6a9e235dbc4e@proton.me>
 <20260723-b4-disp-0d07164f-v5-2-6a9e235dbc4e@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 00:23:42 +0000
Message-Id: <20260725002343.765ED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The patch fails to fully prevent out-of-bounds reads because u=
ncorrected negative `bytes_to_rcv` allows `MSG_PEEK` accumulations to excee=
d `2 * rmb_desc->len`, triggering a wrapping logic bug in `smc_curs_add()`.
- [Critical] In `smc_rx_splice()`, socket and page references are acquired =
*after* `splice_to_pipe()` returns, creating a race condition (Use-After-Fr=
ee) and a refcount underflow for multi-page splices.
- [High] The patch prevents an immediate out-of-bounds read but fails to co=
rrect the corrupted (negative) `bytes_to_rcv` state, leading to a persisten=
t denial of service, infinite garbage data reads, and corrupted `FIONREAD` =
ioctl results.
- [High] If `memcpy_to_msg()` or `smc_rx_splice()` fails on the second chun=
k of a wrapped read, `smc_rx_recvmsg()` returns success for the first chunk=
 but fails to update the consumer cursor.
- [Medium] The fallback release function `smc_rx_spd_release()` fails to fr=
ee the dynamically allocated `smc_spd_priv` object when `splice_to_pipe()` =
encounters an error or partial push.
--

--- Patch [2]: [PATCH net v5 2/3] net/smc: bound the receive length to the =
RMB in smc_rx_recvmsg() ---
commit 5ea7024a42bcb5dcdb8d823a5c82e7b6634aa7d2
Author: Bryam Vargas <hexlabsecurity@proton.me>

net/smc: bound the receive length to the RMB in smc_rx_recvmsg()

This commit bounds the receive length to the RMB length to prevent
out-of-bounds reads when a forged cursor causes a negative or oversized
accumulator. It clamps the local readable variable to the RMB size.

> diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
> index c1d9b923938da..f461cf10b0855 100644
> --- a/net/smc/smc_rx.c
> +++ b/net/smc/smc_rx.c
[ ... ]
> @@ -442,6 +442,18 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msgh=
dr *msg,
>  		/* initialize variables for 1st iteration of subsequent loop */
>  		/* could be just 1 byte, even after waiting on data above */
>  		readable =3D smc_rx_data_available(conn, peeked_bytes);
> +		/* bytes_to_rcv is accumulated from the peer's wire-controlled
> +		 * producer cursor; a forged cursor can drive it past the RMB,
> +		 * or overflow the signed accumulator to a negative value across
> +		 * many CDC messages (which a plain "> len" check would miss
> +		 * before the size_t cast below turns it huge).  Bound it to the
> +		 * RMB in either case so the wrap-around copy cannot run past
> +		 * rmb_desc->len.  This enforces the documented
> +		 * 0 <=3D bytes_to_rcv <=3D rmb_desc->len invariant at the consumer,
> +		 * race-free against the producer update in the receive tasklet.
> +		 */
> +		if (readable < 0 || readable > conn->rmb_desc->len)
> +			readable =3D conn->rmb_desc->len;

[Severity: High]
This isn't a bug introduced by this patch, but does this clamping leave the
underlying atomic counter corrupted?

By clamping the local readable variable here, the immediate read is bounded,
but the atomic counter conn->bytes_to_rcv remains negative. Later in
smc_rx_recvmsg(), the code does:

    atomic_sub(copylen, &conn->bytes_to_rcv);

Doesn't this subtract the clamped copylen from an already negative value,
driving it further away from the intended invariant?

If the counter remains negative, won't functions like smc_poll() continuous=
ly
see a non-zero value and signal EPOLLIN, causing an infinite read loop?
Additionally, won't the SIOCINQ ioctl in smc_ioctl() return this negative
value directly to userspace?

[Severity: Critical]
This is also a pre-existing issue, but does leaving bytes_to_rcv negative
allow a MSG_PEEK operation to trigger an out-of-bounds read?

If a caller uses MSG_PEEK, the atomic_sub() is skipped, and peeked_bytes
can continuously grow by rmb_desc->len. When peeked_bytes is added to the
cursor:

    if ((flags & MSG_PEEK) && peeked_bytes)
        smc_curs_add(conn->rmb_desc->len, &cons, peeked_bytes);

Looking at smc_curs_add():

    curs->count +=3D value;
    if (curs->count >=3D size) {
        curs->wrap++;
        curs->count -=3D size;
    }

Because this uses a single if statement rather than a loop or modulo, if the
added value is greater than or equal to 2 * size, doesn't curs->count remain
larger than size (rmb_desc->len)?

If cons.count exceeds rmb_desc->len, the calculation for chunk_len:

    chunk_len =3D min_t(size_t, copylen, conn->rmb_desc->len - cons.count);

would underflow, resulting in a massive size_t value and bypassing bounds
checks for the subsequent copy.

[ ... ]
>  		chunk_len_sum =3D chunk_len;
>  		chunk_off =3D cons.count;
>  		smc_rmb_sync_sg_for_cpu(conn);
>  		for (chunk =3D 0; chunk < 2; chunk++) {
>  			if (!(flags & MSG_TRUNC)) {
>  				if (msg) {
>  					rc =3D memcpy_to_msg(msg, rcvbuf_base +
>  							   chunk_off,
>  							   chunk_len);
>  				} else {
>  					rc =3D smc_rx_splice(pipe, rcvbuf_base +
>  							chunk_off, chunk_len,
>  							smc);
>  				}

[Severity: Critical]
This is a pre-existing issue, but does smc_rx_splice() have a race condition
and refcount mismatch?

Inside smc_rx_splice(), the code calls splice_to_pipe() before acquiring
references:

    bytes =3D splice_to_pipe(pipe, &spd);
    if (bytes > 0) {
        sock_hold(&smc->sk);
        ...
        get_page(smc->conn.rmb_desc->pages);
    }

Once splice_to_pipe() exposes the pages to the pipe, a concurrent pipe
reader can consume the buffer and trigger the asynchronous release handler,
smc_rx_pipe_buf_release():

    out:
        kfree(priv);
        put_page(buf->page);
        sock_put(sk);

Since the pipe reader can invoke the release handler before the producing
thread acquires the references with sock_hold() and get_page(), can this
cause a use-after-free?

Additionally, smc_rx_pipe_buf_release() drops the socket reference once per
page, but smc_rx_splice() only takes the socket reference once per splice.
Doesn't this guarantee a reference count underflow for multi-page splices?

[Severity: Medium]
This is a pre-existing issue, but does the fallback release function leak
the private data?

When splice_to_pipe() encounters an error or partial push, it invokes the
fallback handler smc_rx_spd_release():

    static void smc_rx_spd_release(struct splice_pipe_desc *spd,
                                   unsigned int i)
    {
        put_page(spd->pages[i]);
    }

This drops the page reference, but it lacks the kfree() for the dynamically
allocated private data (such as kfree((struct smc_spd_priv *)
spd->partial[i].private)). Will this cause a memory leak if the pipe is ful=
l?

>  				if (rc < 0) {
>  					if (!read_done)
>  						read_done =3D -EFAULT;
>  					goto out;
>  				}

[Severity: High]
This is a pre-existing issue, but does this error path cause silent data
corruption?

When reading across a ring buffer wrap, the copy is split into two chunks.
If the first chunk succeeds but the second chunk fails (for example, if a
local application provides a buffer that causes a page fault, returning
-EFAULT), the code takes this goto out path.

Because it jumps to out, it returns read_done (the successfully read first
chunk) but completely skips the cursor update logic at the end of the loop.

Since the socket's internal cursor is not advanced, won't the exact same da=
ta
be duplicated to the user on the next read?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-b4-disp-0d=
07164f-v5-0-6a9e235dbc4e@proton.me?part=3D2
