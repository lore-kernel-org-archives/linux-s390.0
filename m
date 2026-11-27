Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795792005;
	b=wbOmZTK88lY0YfXfTrsPgc4p/kLc/UOrSTRXPQ7Hb9ovblhc5IxQEugiJF5ArB+0s0Vn
	 DI1ke7+0eu5BaZhqf+TGJiBq+03rE2p6PzjNWvWYqhOLxSZxrXITdNDmLDs+Xko+AexRe
	 zvzZcCEalKt4oL1fIt6Wq3nKgvaYM2yEbWK1RqW1ERo9p9hEDsJSTjXS09NqAE75O+5eg
	 5JPB04rNWGVcZzgxrpXYitDkEcbWDEkJDrbWbr6imo2aVUXg5WgyEUu2KBNU+Isj5mA/c
	 NP9/iahW2APQSho8Jasl6bSJpsxr0QA/r1Wq1r0pLVOud1xFMBP5k3/dra2nwKdZyow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795792005;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4ZyU0grJb14cy5TQI+qpI7bz6m1GMc0PZw1lYL4wEYg=;
	b=wsWlQNkzYzy7MqybDE8gV92AAGL3H7mCQkXL8ebCzuyXlq4//Ekv+v9hDHZarlQ9hFhe
	 SPHrVQZiHwNVAlt5g/kABssmM82tcBhw1C/3Aav8J5YzvTV0lToKfX0zaNxTqN5kqxWIX
	 B5oelcVzJso32PWYA1DWqcfDSl0K8yyO3+d0I1SEW9uYmV8Y9WiZPWZO+gjI1JOrzVVKJ
	 u/+5YvFL2XEAa/+9F2LYg0qE5XCXfcEjVsCV0PQ9e0H3kwoA6nWuZV+FFzj6WRcK5cr8y
	 6TiVSf8pgxeDlZt+3quqytO46HowbXs1BCkqU+PbIsrX10acdgi45AdygymSemGtYzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iG1znaua;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C18D606A31C
	for <linux-s390@vger.kernel.org>; Fri, 27 Nov 2026 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iG1znaua
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7231F0089B;
	Fri, 27 Nov 2026 15:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795792004;
	bh=4ZyU0grJb14cy5TQI+qpI7bz6m1GMc0PZw1lYL4wEYg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iG1znauafk8p2MWsNnuKkb/EVfVF7foJ2a7iLrcvlD1nK+Tl3QWfL9+vkdlcrZcZL
	 7U0jQ5gXuSWTzQ6S4gP/SaAOLb8Yg3SgxONRTFqt4GH/UKbcdlWzIZHWHMPUMVvJm+
	 XGq2szFX65E/U6EzgZS8aKEWLW73kLzDL99txw807ddnSvuuHKHBAOf2Zx83OzLuwC
	 H3z8mSPUpS9XhsYqvUk4aAWRyyLy7WBOq3EUjfTrbKXKONpZA0oPnwS/VYMhK0bkNG
	 68NiMEPOeTYiYPryF94knAidX2yZWcYVJfwYXCvOsOjOg0kc+AX/Sdq+k6H8exfa3x
	 54luwdIiLjRsw==
Message-ID: <sashiko-outbox-237677@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4] net/smc: bound the DMB-nocopy send-buffer credit
 by what was sent
Reply-To: sashiko-reviews@lists.linux.dev
To: "Piyus Kedia" <piyus@iiitd.ac.in>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261126150617.2113159-1-piyus@iiitd.ac.in>
References: <20261126150617.2113159-1-piyus@iiitd.ac.in>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 15:06:43 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] net/smc: unvalidated local_rx_ctrl.cons in
  smc_cdc_msg_recv_action()
--

commit a47271b7e81e3aca5ca10dfa516b5fde9599703f
Author: Piyus Kedia <piyus@iiitd.ac.in>

net/smc: bound the DMB-nocopy send-buffer credit by what was sent

This commit snapshots tx_curs_fin and tx_curs_sent on the SMC-D
DMB-nocopy receive path, bounds the send-buffer credit by the
unconfirmed sent bytes, and advances tx_curs_fin by that bounded amount.

Link: https://lore.kernel.org/all/179552966151.3135.8162716126718648323@ker=
nel.org/

> diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
> index 32d6d03df3214..8f4351e1d4adc 100644
> --- a/net/smc/smc_cdc.c
> +++ b/net/smc/smc_cdc.c
> @@ -333,6 +333,8 @@ static void smc_cdc_msg_recv_action(struct smc_sock *=
smc,
>  	union smc_host_cursor cons_old, prod_old;
>  	struct smc_connection *conn =3D &smc->conn;
>  	int diff_cons, diff_prod, diff_tx;
> +	union smc_host_cursor fin, sent;
> +	int unconfirmed;
> =20
>  	smc_curs_copy(&prod_old, &conn->local_rx_ctrl.prod, conn);
>  	smc_curs_copy(&cons_old, &conn->local_rx_ctrl.cons, conn);
> @@ -358,16 +360,55 @@ static void smc_cdc_msg_recv_action(struct smc_sock=
 *smc,
>  			/* Calculate consumed data and
>  			 * increment free send buffer space.
>  			 */
> +			/* Snapshots, not the live cursors.  smc_curs_diff()
> +			 * reads wrap and count with plain loads, and this runs
> +			 * in a tasklet under bh_lock_sock() while
> +			 * smc_tx_rdma_writes() advances tx_curs_sent under
> +			 * conn->send_lock, so reading it in place can pair a
> +			 * pre-wrap wrap with a post-wrap count.  Either the
> +			 * difference collapses to zero and the credit is lost,
> +			 * or it exceeds the buffer and the bound below does
> +			 * nothing.  smc_tx_prepared_sends() takes the same
> +			 * snapshots for the same reason.
> +			 */
> +			smc_curs_copy(&fin, &conn->tx_curs_fin, conn);
> +			smc_curs_copy(&sent, &conn->tx_curs_sent, conn);
>  			diff_tx =3D smc_curs_diff(conn->sndbuf_desc->len,
> -						&conn->tx_curs_fin,
> +						&fin,
>  						&conn->local_rx_ctrl.cons);
> +			/* This difference comes from the cursor the peer
> +			 * reported, which is taken as it arrives.  The peer
> +			 * can only have consumed what this side actually
> +			 * sent - smc_tx_rdma_writes() advances tx_curs_sent
> +			 * together with the producer cursor the peer sees -
> +			 * so bound it by that and advance tx_curs_fin by the
> +			 * bounded amount rather than assigning the reported
> +			 * cursor.  The invariant below then holds by
> +			 * construction, tx_curs_fin stays inside the send
> +			 * buffer, and it stays at or behind tx_curs_sent:
> +			 * bounding by sndbuf_desc->len - sndbuf_space would
> +			 * also admit bytes that are only PREPARED, which
> +			 * would move tx_curs_fin past tx_curs_sent and break
> +			 * the fin <=3D sent <=3D prep order the three cursors are
> +			 * documented with.
> +			 */
> +			unconfirmed =3D smc_curs_diff(conn->sndbuf_desc->len,
> +						    &fin, &sent);
> +			diff_tx =3D min_t(int, diff_tx, unconfirmed);
> +
>  			/* increase local sndbuf space and fin_curs */
>  			smp_mb__before_atomic();
>  			atomic_add(diff_tx, &conn->sndbuf_space);
>  			/* guarantee 0 <=3D sndbuf_space <=3D sndbuf_desc->len */
>  			smp_mb__after_atomic();
> -			smc_curs_copy(&conn->tx_curs_fin,
> -				      &conn->local_rx_ctrl.cons, conn);
> +			/* Advance the snapshot and write it back as one
> +			 * cursor.  smc_curs_add() sets count and then wrap
> +			 * with plain stores, and transiently leaves
> +			 * count >=3D sndbuf_desc->len, so in place it would
> +			 * replace an atomic 64-bit update with a torn one.
> +			 */
> +			smc_curs_add(conn->sndbuf_desc->len, &fin, diff_tx);
> +			smc_curs_copy(&conn->tx_curs_fin, &fin, conn);
> =20
>  			smc_tx_sndbuf_nonfull(smc);
>  		}

[Severity: High]
Does clamping only diff_tx and conn->tx_curs_fin leave
conn->local_rx_ctrl.cons out of sync and unvalidated?

Earlier in smc_cdc_msg_recv_action(), smc_cdc_msg_to_host() copies the
peer's raw consumer cursor directly into conn->local_rx_ctrl.cons, and
the DMB-nocopy block only runs when diff_cons is non-zero:

net/smc/smc_cdc.c:smc_cdc_msg_recv_action() {
	...
	smc_curs_copy(&cons_old, &conn->local_rx_ctrl.cons, conn);
	smc_cdc_msg_to_host(&conn->local_rx_ctrl, cdc, conn);

	diff_cons =3D smc_curs_diff(conn->peer_rmbe_size, &cons_old,
				  &conn->local_rx_ctrl.cons);
	if (diff_cons) {
		...
		atomic_add(diff_cons, &conn->peer_rmbe_space);
	...
}

When a peer reports a consumer cursor ahead of conn->tx_curs_sent,
conn->tx_curs_fin stops at conn->tx_curs_sent while
conn->local_rx_ctrl.cons keeps the over-reported value.  Subsequent CDC
messages acknowledging newly sent bytes up to that value then compute
diff_cons =3D=3D 0 and skip the DMB-nocopy block, losing send-buffer credit
and wedging the sender in smc_tx_wait() once conn->sndbuf_space fills.

Passing the unvalidated conn->local_rx_ctrl.cons to smc_curs_diff() can
also wrap 32-bit unsigned arithmetic or overflow the signed int cast in
max_t(int, 0, ...) when local_rx_ctrl.cons.count >=3D 0x80000000,
collapsing diff_tx to 0 after conn->local_rx_ctrl.cons has already moved,
while a backward cursor with a different wrap yields a positive diff_tx
and credits unconfirmed bytes.  In addition, diff_cons is still added
unbounded to conn->peer_rmbe_space before this block, allowing a peer to
push peer_rmbe_space past peer_rmbe_size or overflow it negative and halt
transmission in smc_tx_sndbuf_nonempty().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126150617.2113=
159-1-piyus@iiitd.ac.in?part=3D1
