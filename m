Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7A42F7EFF
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 14:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785939132; cv=none; b=UDPYiMeZK0LgwORR6MlJDmRqd5jLrd1TlPSXHdU6eU0BwuSxbH16l0eseOzSBmVg+1ARXhGVj9CiiGafJhiyUZUOsSpE+1l98QdoYFDAcFK+V9sMwsidHNac7s95aqi2EOf4habuxIiPbccsHwVDxDkrNrvfDK32xZeCka1Ujzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785939132; c=relaxed/simple;
	bh=r4AwMjBLaK/8mx5amGTMx+Tbofu+OR02awuZ78dhEjU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XErRL7fHVuvoatLjXZQzZfG285Y5mZLwb2KQ2NJgYqapW8hNXTQJVEnDK4WRZiT/73OO7SzZIfUmWVOvBvc3ixxUbg/1eVSRcNUEBTb8PQ+jv+FTbP6A+s7hIn7ylxDZwXj94ngmHdwwOimEoaj8bWtNfBggzf70WPnDXBa3hbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikjWfM3U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikjWfM3U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BFF1F000E9;
	Wed,  5 Aug 2026 14:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785939130;
	bh=ff/1fcU0UTqoQqYMgX6DQcwHHo+Uslm3RdTAicjtSxg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ikjWfM3U0eszZH7a3TYhKjR4g5HyWcDmXjeITlf3oJOZNwuu6TnzSlpDVJ1ECdroP
	 MSbbmCP+HPyyr3fiDpaIgpytCUu7NJXehdwf4TqrTaL0kpNORPRxhHYWi21UiiSV/l
	 zyYJZhI9mW1DdOy+2OaI9nPTlId4cQmfRaP/pXv053lKtFi5KY1G8UNd5b4k86FjJb
	 9UQqXsD/LGy+2MkMzl6iFWzrKWQc9A151C2D7A8b8REOZ+V0G8L72LyMlzFZ1DoW/H
	 7G7z6vHv/Oxn6/7dONPpW1ZjKMrb5RPGYRgElv05zBAO8lZcHc8fAo0klUD6v3PAFe
	 fuRpW9ECg7JSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next] net/smc: abort the connection when the peer
 overruns the RMB
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hidayath Khan" <hidayath@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260804141109.542202-1-hidayath@linux.ibm.com>
References: <20260804141109.542202-1-hidayath@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 14:12:09 +0000
Message-Id: <20260805141209.E1BFF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] SMC-D ignores the `out_of_sync` flag, allowing further malicious o=
r corrupted packets to be processed after an abort.

Pre-existing issues:
- [Critical] The patch adds a bounds check for `diff_prod` but fails to app=
ly the same bounds check for the peer's consumer cursor (`diff_tx` and `dif=
f_cons`), leading to a critical heap buffer overflow in `smc_tx_sendmsg()`.
- [Critical] Integer overflow in `smc_curs_diff()` bypasses the newly intro=
duced bounds check for `diff_prod`, leading to a remote kernel panic via ou=
t-of-bounds read.
- [High] Unprotected concurrent modifications to the `out_of_sync`, `killed=
`, and `freed` bitfields lead to torn writes and lost state updates.
--

--- Patch [1]: [PATCH net-next] net/smc: abort the connection when the peer=
 overruns the RMB ---
commit f23554c53b371c00958c1ef783733772b67bb8fe
Author: Hidayath Khan <hidayath@linux.ibm.com>

net/smc: abort the connection when the peer overruns the RMB

This patch addresses an issue where a non-compliant peer could inflate the=
=20
bytes_to_rcv accumulator without bound. It adds a bounds check on the=20
producer cursor advance and drops the connection if an overrun is detected.

> diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
> index 32d6d03df3214..d8f747bbc6f69 100644
> --- a/net/smc/smc_cdc.c
> +++ b/net/smc/smc_cdc.c
> @@ -305,6 +305,27 @@ static void smc_cdc_handle_urg_data_arrival(struct s=
mc_sock *smc,
>  	sk_send_sigurg(&smc->sk);
>  }
> =20
> +/* Drop a connection whose peer violated the CDC protocol.  @link is the=
 link
> + * the offending message arrived on, or NULL when it is not known to the=
 caller
> + * (SMC-D, and the shared receive path).  When @link is NULL conn->lnk i=
s left
> + * unchanged: for SMC-R it already points to the right QP; for SMC-D the=
re is
> + * no per-link QP to abort on.
> + */
> +static void smc_cdc_abort_conn(struct smc_sock *smc, struct smc_link *li=
nk)
> +{
> +	struct smc_connection *conn =3D &smc->conn;
> +
> +	conn->out_of_sync =3D 1;  /* prevent any further receives */

[Severity: High]
This is a pre-existing issue, but does setting this bitfield without locks
cause torn writes?

The bitfields killed, freed, and out_of_sync share the same byte in
struct smc_connection. This code sets conn->out_of_sync =3D 1 from softirq
context without holding locks, while smc_conn_kill() sets conn->killed =3D 1
from process context (holding lock_sock).

Could this read-modify-write interleaving result in a lost update for killed
or out_of_sync, leaving the connection incompletely terminated?

[Severity: High]
Can SMC-D connections continue processing packets after this flag is set?

The patch relies on setting conn->out_of_sync =3D 1 here to stop further
receives immediately. However, SMC-D's receive tasklet (smcd_cdc_rx_tsklet)
only checks conn->killed, not conn->out_of_sync:

net/smc/smc_cdc.c:smcd_cdc_rx_tsklet() {
    ...
    if (!conn || conn->killed)
        return;
    ...
}

Because abort_work runs asynchronously to actually kill the connection, is
there a race window where SMC-D will continue passing packets to
smc_cdc_msg_recv_action(), bypassing this protection entirely?

> +	spin_lock_bh(&conn->send_lock);
> +	conn->local_tx_ctrl.conn_state_flags.peer_conn_abort =3D 1;
> +	if (link)
> +		conn->lnk =3D link;
> +	spin_unlock_bh(&conn->send_lock);
> +	sock_hold(&smc->sk); /* sock_put in abort_work */
> +	if (!queue_work(smc_close_wq, &conn->abort_work))
> +		sock_put(&smc->sk);
> +}

[ ... ]

> @@ -376,6 +388,11 @@ static void smc_cdc_msg_recv_action(struct smc_sock =
*smc,
>  	diff_prod =3D smc_curs_diff(conn->rmb_desc->len, &prod_old,
>  				  &conn->local_rx_ctrl.prod);
>  	if (diff_prod) {
> +		if (diff_prod > conn->rmb_desc->len -
> +				atomic_read(&conn->bytes_to_rcv)) {

[Severity: Critical]
This is a pre-existing issue, but can an integer overflow in smc_curs_diff()
bypass this new bounds check?

smc_curs_diff() computes the difference using 32-bit unsigned arithmetic:
(size - old->count) + new->count.

If a malicious peer provides an extremely large new->count via CDC messages
(e.g., 0xFFFF0001 when size is 65536 and old->count is 0), the arithmetic
wraps to produce a small positive integer (e.g., 1), which trivially passes
this check.

This out-of-bounds cursor is later used as an array index in
smc_cdc_handle_urg_data_arrival():

net/smc/smc_cdc.c:smc_cdc_handle_urg_data_arrival() {
    ...
    conn->urg_rx_byte =3D *(base + conn->urg_curs.count - 1);
    ...
}

Could this lead to an out-of-bounds read and remote kernel panic?

[Severity: Critical]
This is a pre-existing issue, but does the peer's consumer cursor logic
earlier in this function also need bounds checking?

A malicious peer can provide an inflated cons cursor via CDC messages.
Earlier in smc_cdc_msg_recv_action(), diff_cons is calculated from this
unvalidated cursor and added directly to conn->sndbuf_space without bounds
checking in SMC-D nocopy mode:

net/smc/smc_cdc.c:smc_cdc_msg_recv_action() {
    ...
    diff_cons =3D smc_curs_diff(conn->peer_rmbe_size, &cons_old,
                              &conn->local_rx_ctrl.cons);
    ...
    atomic_add(diff_tx, &conn->sndbuf_space);
    ...
}

This inflated sndbuf_space is later used in smc_tx_sendmsg() to bound
copylen, which can drastically exceed the actual allocation size of
sndbuf_desc->len. The chunking logic then generates a massive size for the
second chunk, resulting in an out-of-bounds write:

net/smc/smc_tx.c:smc_tx_sendmsg() {
    ...
    chunk_len =3D copylen - chunk_len; /* remainder */
    ...
    rc =3D memcpy_from_msg(sndbuf_base + chunk_off, msg, chunk_len);
    ...
}

Could this lead to a heap buffer overflow?

> +			smc_cdc_abort_conn(smc, NULL);
> +			return;
> +		}
>  		if (conn->local_rx_ctrl.prod_flags.urg_data_present)
>  			smc_cdc_handle_urg_data_arrival(smc, &diff_prod);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804141109.5422=
02-1-hidayath@linux.ibm.com?part=3D1
