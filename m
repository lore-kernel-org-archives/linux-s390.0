Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3323231827
	for <linux-s390@vger.kernel.org>; Sat, 25 Jul 2026 00:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784939026; cv=none; b=V+JOGUk4CriEdI0WpiS2x0T3vrdqMxb0rEEJalV4NbUoIpcyRGC6yXWkj+xYfVFfTLlja3eEa0L16AmNh3Pk/jv1AiA+Ho7DxaeVK4VHG8lxxKg0VoLe217EBUoy5Q0qug+QkfY7GWPhnhhPpErpMn63p5mBxqH5aNgY5gidHtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784939026; c=relaxed/simple;
	bh=iPQpNG9oXFNm5GfqVklpQKteYJpiUJLAqarPA7/ketY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ko2B/Eyq6E7/T/Bb8QosVDxsoIBVE0dsgA8kZ9NzQMhPuzmlk3TRcqjH/ULvi0Qzcx4+Oa/kS02hesMBjoca9Ba/S8L7DpR4xGtqo4a9k8exbe49vK7ThT98E9FfuBE7SPxk5M12s5RICBq9dNXPuifnK/6yHUbIk+aaB+CWyV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sh9Jrvtm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sh9Jrvtm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB201F00A3D;
	Sat, 25 Jul 2026 00:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784939025;
	bh=55Ue42ZS0+Pto6i8CpTup6yPNPyLIbes4lVig6JWjl4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sh9JrvtmlYaIKMYG6l3NvQWqL7TZHZ3UVgKwYgKK/L8K1IPVZzzSzNc83OMx5WgsK
	 ZWHcBUVnbqQ6BvDQ+MbSlSdpnKiEBr6Vuvdv/suLf4dfq1GxUuGi+L4UL/kleqO2VK
	 mEZ492iqyG+wjkPEd67/2reKIh6+QDCTwi7x2Z9gxMv6TZF2J4PahPZJuTE0qGssv9
	 uVxeWrmc/HuuVtQ80zw8jBJ+pkZgF4z4IZRmLLYLjn6CHkUZt3dYDNYu+WtmON/BE4
	 ndCWhJzfo60fCqCFlJW488CzP6hUXQJ5EKWoaSsb5Hf8gAO9pBSiAUA31HGFAlLAVF
	 IpRDgTGo4gcPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 1/3] net/smc: bound the wire-controlled producer
 cursor to the RMB
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260723-b4-disp-0d07164f-v5-1-6a9e235dbc4e@proton.me>
References: <20260723-b4-disp-0d07164f-v5-0-6a9e235dbc4e@proton.me>
 <20260723-b4-disp-0d07164f-v5-1-6a9e235dbc4e@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 00:23:44 +0000
Message-Id: <20260725002345.1EB201F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] NULL pointer dereference by sending an early CDC message with a gu=
essed connection token before the connection's receive buffer (`rmb_desc`) =
is allocated.

Pre-existing issues:
- [Critical] Heap Out-of-Bounds Write due to unbounded consumer cursor infl=
ating `sndbuf_space`.
- [High] A malicious peer can continuously inflate `conn->bytes_to_rcv` bey=
ond the receive buffer size by manipulating the `wrap` field (or incrementa=
lly advancing the `count` field) of the producer cursor, leading to a massi=
ve out-of-bounds read during `recvmsg`.
--

--- Patch [1]: [PATCH net v5 1/3] net/smc: bound the wire-controlled produc=
er cursor to the RMB ---
commit bb6f7b4d6d71f8888e49e10514b07e9e257bfa1f
Author: Bryam Vargas <hexlabsecurity@proton.me>

net/smc: bound the wire-controlled producer cursor to the RMB

This patch bounds the producer cursor count to the receive buffer length at
the wire-to-host conversion for both SMC-R and SMC-D. It leaves the consumer
cursor unbounded, as it indexes the peer's RMB and clamping it would stall
transmit to peers with larger RMBs.

> diff --git a/net/smc/smc_cdc.h b/net/smc/smc_cdc.h
> index 696cc11f2303b..ca76ef6303566 100644
> --- a/net/smc/smc_cdc.h
> +++ b/net/smc/smc_cdc.h

[ ... ]

> @@ -235,6 +236,15 @@ static inline void smc_cdc_cursor_to_host(union smc_=
host_cursor *local,
>  	if ((old.wrap =3D=3D temp.wrap) &&
>  	    (old.count > temp.count))
>  		return;
> +	/* The peer producer cursor is wire-controlled and is later used as a
> +	 * raw index into our RMB by the urgent path; bound its count to the
> +	 * RMB.  max_count =3D=3D 0 leaves the consumer cursor unbounded here: =
it
> +	 * indexes the peer's RMB (bounded by peer_rmbe_size, not our
> +	 * rmb_desc->len), so clamping it to rmb_desc->len would under-credit
> +	 * peer_rmbe_space and stall transmit to peers with a larger RMB.
> +	 */
> +	if (max_count && temp.count > max_count)
> +		temp.count =3D max_count;

[Severity: High]
This is a pre-existing issue, but does bounding only the count field leave
the wrap field unchecked?

If a peer sends multiple CDC messages where wrap increments, or count
incrementally advances without exceeding rmb_desc->len, could smc_curs_diff=
()
compute a positive diff_prod?

net/smc/smc_cdc.c:smc_cdc_msg_recv_action() {
    ...
	diff_prod =3D smc_curs_diff(conn->rmb_desc->len, &prod_old,
				  &conn->local_rx_ctrl.prod);
	if (diff_prod) {
    ...
		atomic_add(diff_prod, &conn->bytes_to_rcv);
    ...
}

Could this unconditionally inflate conn->bytes_to_rcv beyond the receive
buffer size, causing copylen to exceed the buffer length in smc_rx_recvmsg(=
)?

net/smc/smc_rx.c:smc_rx_recvmsg() {
    ...
			chunk_len =3D copylen - chunk_len;
			rc =3D memcpy_to_msg(msg, rcvbuf_base, chunk_len);
    ...
}

Could this result in an out-of-bounds read of adjacent kernel memory?

>  	smc_curs_copy(local, &temp, conn);
>  }
> =20
> @@ -246,8 +256,13 @@ static inline void smcr_cdc_msg_to_host(struct smc_h=
ost_cdc_msg *local,
>  	local->len =3D peer->len;
>  	local->seqno =3D ntohs(peer->seqno);
>  	local->token =3D ntohl(peer->token);
> -	smc_cdc_cursor_to_host(&local->prod, &peer->prod, conn);
> -	smc_cdc_cursor_to_host(&local->cons, &peer->cons, conn);
> +	/* bound the wire-controlled producer cursor to our RMB (used as a raw
> +	 * index by the urgent path); leave the consumer cursor unbounded -- it
> +	 * indexes the peer's RMB and is bounded by peer_rmbe_size.
> +	 */
> +	smc_cdc_cursor_to_host(&local->prod, &peer->prod, conn,
> +			       conn->rmb_desc->len);

[Severity: High]
Can conn->rmb_desc be NULL here?

If a CDC message is received during connection setup before the receive
buffers are allocated:

net/smc/smc_cdc.c:smc_cdc_rx_handler() {
    ...
	conn =3D smc_lgr_find_conn(ntohl(cdc->token), lgr);
	if (!conn || conn->out_of_sync) {
		read_unlock_bh(&lgr->conns_lock);
		return;
	}
    ...
}

If the connection is found before smc_buf_create() completes, does
dereferencing conn->rmb_desc->len result in a NULL pointer dereference?

> +	smc_cdc_cursor_to_host(&local->cons, &peer->cons, conn, 0);

[Severity: Critical]
This is a pre-existing issue, but does leaving the consumer cursor unbounded
allow inflating conn->sndbuf_space?

If peer->cons.count is set to a very large value, could smc_curs_diff() ret=
urn
a large diff_tx?

net/smc/smc_cdc.c:smc_cdc_msg_recv_action() {
    ...
			diff_tx =3D smc_curs_diff(conn->sndbuf_desc->len,
						&conn->tx_curs_fin,
						&conn->local_rx_ctrl.cons);
			/* increase local sndbuf space and fin_curs */
			smp_mb__before_atomic();
			atomic_add(diff_tx, &conn->sndbuf_space);
    ...
}

When sendmsg() is subsequently called, could this inflated sndbuf_space cau=
se
copylen to be miscalculated?

net/smc/smc_tx.c:smc_tx_sendmsg() {
    ...
			chunk_len =3D copylen - chunk_len;
			rc =3D memcpy_from_msg(sndbuf_base, msg, chunk_len);
    ...
}

Could this lead to an out-of-bounds write from userspace into the
kernel heap?

>  	local->prod_flags =3D peer->prod_flags;
>  	local->conn_state_flags =3D peer->conn_state_flags;
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-b4-disp-0d=
07164f-v5-0-6a9e235dbc4e@proton.me?part=3D1
