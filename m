Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43174389100
	for <linux-s390@vger.kernel.org>; Mon,  6 Jul 2026 07:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783324466; cv=none; b=fx4dZuLTQltl6llv6J8MCiSCsOfASgSixwTNdl1ogBcj4NOUxSCumXXds7rZANGw/TGQdZ0d77OqUNAEGGwUt0X75dLrlN6pRvesHkmPXgKqMHjcXBJgTnwJLp4YUCYvgOobk2TvcezkByRAVLlZuQx021np6OeCJ8uRAUKIx+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783324466; c=relaxed/simple;
	bh=OE+dNlJ7G6NpmYSpI35KOmLkfmnDzHo0hYWfWwjR9Vo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RuEScR3YjKnx59+41lgNa7HHRY9qpzXiqeaAeSSqT5aylJM4rO9Kn3xn4n3F5jeaTPY7z1LUZwuWUw62ucq7xbSkSRM9coQSqn49FDzNLIYJMYi6ICHKFeU32yG11+nAlJm5orGJYdnFL1As6DVplDHar/Ltc1w1gRR20FjQql0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXrdESbV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXrdESbV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E1B1F000E9;
	Mon,  6 Jul 2026 07:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783324458;
	bh=LsbcRb/91Tgkz/WFEYPJMHFfq9/72GXaX6o6kCrZIzU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TXrdESbVINt1qGyBL2w6mGmocUyj1+mZvrHpdT69bHdu2vs6cEtWe7Rwuzjq1pHvN
	 T851zYQyRShu5S6MdRcA2zDlPzvm36PwY2z/J4C3SMNR8+yU7dpqpjbDzyFH7HQYTo
	 Ew7nx55VTyYzICGNebFxKjOmyHT8aHneDkV76AvJS9K8FWgo0O7huPEiWjr6P3Pqcd
	 wtRkOnlSX68TfmuI6wSi96FlI22xQnGKclDYu4zv4Sn5Rn9bljudwYEGJfVsTwftbc
	 /q9FoMB0gp+gkneGu5tKjzwts+wVn3RAvqkouaMQSJGg7YAgecNuDs7l+57qUTd20X
	 05EbbkR3zesbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 2/3] net/smc: bound the receive length to the RMB
 in smc_rx_recvmsg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260705-b4-disp-28a1bbca-v4-2-be089b98acc6@proton.me>
References: <20260705-b4-disp-28a1bbca-v4-0-be089b98acc6@proton.me>
 <20260705-b4-disp-28a1bbca-v4-2-be089b98acc6@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 07:54:17 +0000
Message-Id: <20260706075418.24E1B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Concurrent `MSG_PEEK` and `recvmsg` calls can cause `readable`=
 to become negative, which the patch incorrectly clamps to the ring buffer =
size (`rmb_desc->len`). This transforms a temporary race condition into a m=
assive read of stale data. Furthermore, because the loop continues without =
correctly bounding `peeked_bytes`, `smc_curs_add` is eventually called with=
 a `peeked_bytes` value exceeding `2 * rmb_desc->len`. This triggers an und=
erflow in `smc_curs_add()`'s wrap-around logic, causing the consumer cursor=
 count to exceed the buffer length. The subsequent subtraction `conn->rmb_d=
esc->len - cons.count` produces a negative integer that is cast to a huge `=
size_t` value, entirely bypassing bounds checks and allowing an unprivilege=
d local user to read contiguous adjacent kernel memory.
- [Critical] Socket reference count underflow in `smc_rx_splice()` on succe=
ssful multi-page splice. When a virtually contiguous RMB is used, `smc_rx_s=
plice()` can push multiple pages into the pipe in a single `splice_to_pipe(=
)` call. It increments the socket reference count (`sock_hold()`) exactly o=
nce. However, the pipe mechanism will eventually call the release callback =
`smc_rx_pipe_buf_release()` individually for each pipe buffer (page) that w=
as pushed. `smc_rx_pipe_buf_release()` unconditionally calls `sock_put(sk)`=
 on the socket. If `N` pages are spliced, `sock_hold()` is called once, but=
 `sock_put()` is called `N` times, leading to a socket reference count unde=
rflow and Use-After-Free of the `smc_sock` structure.
- [High] Page reference count underflow and memory leak in `smc_rx_splice()=
` error handling. When `splice_to_pipe()` fails to push all pages (e.g., if=
 the pipe becomes full midway), it synchronously calls the pipe buffer rele=
ase callback `smc_rx_spd_release()` on the rejected pages. This callback un=
conditionally calls `put_page()`. However, `smc_rx_splice()` only increment=
s the page reference count (`get_page()`) AFTER `splice_to_pipe()` returns,=
 and only for the pages successfully pushed. This causes a page reference c=
ount underflow (Use-After-Free) for the rejected pages. Additionally, the c=
orresponding `smc_spd_priv` structures allocated for the rejected pages are=
 leaked, as `smc_rx_spd_release()` does not free them.
--

commit eb0d2eff9f593a1bd0c0a49450526ace209f8db1
Author: Bryam Vargas <hexlabsecurity@proton.me>

net/smc: bound the receive length to the RMB in smc_rx_recvmsg()

This commit bounds the readable length to rmb_desc->len in smc_rx_recvmsg()
to prevent a forged cursor from driving bytes_to_rcv past the RMB. It treats
negative values as out of range as well to prevent wrap-around copies from
exceeding the ring buffer.

Cc: stable@vger.kernel.org

> diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
> index c1d9b923938da..f461cf10b0855 100644
> --- a/net/smc/smc_rx.c
> +++ b/net/smc/smc_rx.c
> @@ -442,6 +442,18 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msgh=
dr *msg,
>  		/* initialize variables for 1st iteration of subsequent loop */
>  		/* could be just 1 byte, even after waiting on data above */
>  		readable =3D smc_rx_data_available(conn, peeked_bytes);
> +		/* bytes_to_rcv is accumulated from the peer's wire-controlled
[ ... ]
> +		 * 0 <=3D bytes_to_rcv <=3D rmb_desc->len invariant at the consumer,
> +		 * race-free against the producer update in the receive tasklet.
> +		 */
> +		if (readable < 0 || readable > conn->rmb_desc->len)
> +			readable =3D conn->rmb_desc->len;

[Severity: Critical]
This isn't a bug introduced by this patch, but does this clamp allow a
massive read of stale data when readable is negative?

If concurrent MSG_PEEK and recvmsg calls cause bytes_to_rcv - peeked_bytes
to become negative, clamping it to the full rmb_desc->len here allows the
copy loop to accumulate peeked_bytes indefinitely.

Because the loop continues without correctly bounding peeked_bytes,
smc_curs_add() is eventually called with a peeked_bytes value exceeding
2 * rmb_desc->len.

If value >=3D 2 * size, the wrap-around logic in smc_curs_add() fails to
wrap correctly:

net/smc/smc_cdc.h:smc_curs_add() {
    ...
    if (curs->count >=3D size) {
        curs->wrap++;
        curs->count -=3D size;
    }
    ...
}

Does this cause an underflow in the bounds check calculation
conn->rmb_desc->len - cons.count, resulting in a negative integer cast
to a huge size_t that bypasses bounds checks?


While reviewing this, I also noticed a couple of preexisting issues in
smc_rx_splice() and its pipe buffer callbacks:

[Severity: High]
This is a pre-existing issue, but does smc_rx_splice() leak memory and
cause a page reference count underflow if splice_to_pipe() fails partially?

When splice_to_pipe() rejects pages (e.g., pipe is nearly full), it calls
the release callback which unconditionally drops a reference:

net/smc/smc_rx.c:smc_rx_spd_release() {
    ...
    put_page(spd->pages[i]);
}

However, in smc_rx_splice(), get_page() is only called AFTER
splice_to_pipe() returns, and only for the successfully pushed pages:

net/smc/smc_rx.c:smc_rx_splice() {
    ...
    bytes =3D splice_to_pipe(pipe, &spd);
    if (bytes > 0) {
        sock_hold(&smc->sk);
        if (!lgr->is_smcd && smc->conn.rmb_desc->is_vm) {
            for (i =3D 0; i < PAGE_ALIGN(bytes + offset) / PAGE_SIZE; i++)
                get_page(pages[i]);
        } else {
            get_page(smc->conn.rmb_desc->pages);
        }
    ...
}

Does this result in an immediate page reference count underflow for the
rejected pages? Furthermore, are the corresponding smc_spd_priv structures
for the rejected pages leaked, since smc_rx_spd_release() doesn't free them?


[Severity: Critical]
This is a pre-existing issue, but does a successful multi-page splice
cause a socket reference count underflow?

In smc_rx_splice(), when pushing multiple pages into the pipe, sock_hold()
is called exactly once for the entire successful splice_to_pipe() operation:

net/smc/smc_rx.c:smc_rx_splice() {
    ...
    bytes =3D splice_to_pipe(pipe, &spd);
    if (bytes > 0) {
        sock_hold(&smc->sk);
    ...
}

However, as the pipe consumes the buffers, it calls the release callback
individually for every single pipe buffer (page), and unconditionally calls
sock_put() every time:

net/smc/smc_rx.c:smc_rx_pipe_buf_release() {
    ...
out:
    kfree(priv);
    put_page(buf->page);
    sock_put(sk);
}

If N pages are spliced (when using virtually contiguous memory,
is_vm =3D=3D true), is sock_put() called N times for a single sock_hold(),
leading to a use-after-free of the smc_sock structure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705-b4-disp-28=
a1bbca-v4-0-be089b98acc6@proton.me?part=3D2
