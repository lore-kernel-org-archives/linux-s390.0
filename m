Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792810846;
	b=BneWZpG33KoWIFRSkp8dPRLtO9tO5ix2U6+5tV0CbpnN3G0MWoBn+FGWLysX1/ny7I2I
	 t9EgJi6tBIEmdhAqCkKGmk4+HYe1oW5DPZ2i1RdkKbdqcZazFmMqKz3TbI/YhP2Zwcn57
	 oh48umW/6ylz5J8VdNYv6N48e87UqsnvV2IIM5TPsZA7X0t1rP+5ElsHgdE9odtBHLrrM
	 L0UX37ds93C/PYKJOD2+IdR8V24JnHMM8vHxno9/jTP5is9tW8QOEGxE6hQNHT1+G/YkH
	 n1N9TQqLbaiEWv2WKSD7Ke8gsxrNa6mfs5+h+eHa5HVLotgvROXr5vOHvNZkWuNkDQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792810846;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IOSDXCpjwG7SPOkCHXEf3ctBnGYsbSBz9UgAYhYH2i4=;
	b=GXnYOpG+tpYmupMaSclVRaGFIXMBtD/UT1tTYc6AVEPtD6HmhF1RfHU6dn4fmnD7gD1g
	 hgVS+LC3uGkVaQJjsr4+uwWKrfegRWvZ6NwOvFpNvgVFJYfDs9DgiUkRJcZ4GMqNuv829
	 y9AP4x5dGMIfqiPxTFlRdQW9yKVCwHDeC9cIVF8VuLiXPcF3EuNr2A4d+84nCBZ/tLvw6
	 9ALsm36uR1ZAMikmVKpfnt4QS4EoTinii6b/1Xw10iaROvytiGa37MWXg1e7N2wBgdrvy
	 L+dZce5UAGU/9FSC930XlX8PsqX9OnMBtjN01BWQoYzXLLrojolZdtkBuqjWf1PYu1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JPehyEtv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B60606A31A
	for <linux-s390@vger.kernel.org>; Sat, 24 Oct 2026 03:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JPehyEtv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC27E1F01825;
	Sat, 24 Oct 2026 03:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792810846;
	bh=IOSDXCpjwG7SPOkCHXEf3ctBnGYsbSBz9UgAYhYH2i4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JPehyEtvwN2cL94F/3DlOg+d2WtAM+HWPUU/fnqVhEZzDkblLG+Jm2/+7p7d20kO6
	 ikGpq5S32au7DPlyk+g7YuRfXGHo1DPdlmCh2++rccrHkqgdBvvDb9IIe8O1r2kohi
	 TUbjBKizq/vDSsd30SDNglXxswlDP7otn21Y1pJuDZI6Oh7eAY6F5nVGsy9RjT5Hnb
	 CSSFnElptBW9VEQdeFbEX1VSABsSoFaCietQi4MyctqONoo6MRed9JqjBpDR7pP7ww
	 KtSyAHL7eV7CIc4hIaZ3uooJgaAUq2u3cwlj6q/ZaybEGmTwGOO2fDfdFXSB6fecEe
	 YFo8JyDStDhbg==
Message-ID: <sashiko-outbox-183527@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net-next v2 1/2] net/iucv: serialize HiperSockets
 receive with the socket lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261022-b4-disp-1d26b87a-v2-1-7ee1264d812a@proton.me>
References: <20261022-b4-disp-1d26b87a-v2-0-7ee1264d812a@proton.me>
 <20261022-b4-disp-1d26b87a-v2-1-7ee1264d812a@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 03:00:45 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] net/iucv: stray FIN in IUCV_BOUND recorded in afiucv_hs_record()=
 disconnects
- [Medium] net/iucv: post-FIN frames bypass deferred FIN in afiucv_hs_rcv_o=
wned()
- [Medium] net/iucv: zero msglimit_adv when SYN|ACK is accepted in IUCV_BOU=
ND before SYN
--

commit 96da64b0d53cef8300fe0a502b2a6c996d2ac838
Author: Bryam Vargas <hexlabsecurity@proton.me>

net/iucv: serialize HiperSockets receive with the socket lock

This commit serializes HiperSockets packet reception with the socket lock by
taking bh_lock_sock() in afiucv_hs_rcv(), recording control frames that
arrive while a task owns the socket to apply in release_cb, and locking the
socket during iucv_sock_recvmsg(). It also tracks the advertised receive
window in msglimit_adv and updates shutdown() and sendmsg() handling.

Link: https://lore.kernel.org/all/20260724222917.134769-1-hexlabsecurity@pr=
oton.me/

> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index 794a3cc8b79f0..15ce99e90c5bf 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c

[ ... ]

> @@ -2081,6 +2188,240 @@ static int afiucv_hs_callback_rx(struct sock *sk,=
 struct sk_buff *skb)
>  	return NET_RX_SUCCESS;
>  }
> =20
> +/*
> + * A frame that changes sk_state waits while a task owns the socket. Dat=
a, SHT
> + * and WIN frames do not change it, so they go through: a reader holding=
 the
> + * lock would otherwise wait for its own window. They wait while the rep=
ly to our
> + * SYN is pending, to be received connected, and never past frames alrea=
dy
> + * waiting: sk_backlog.len stays set until __release_sock() has run them=
 all.
> + */
> +static bool afiucv_hs_defer(struct sock *sk)
> +{
> +	return (iucv_sk(sk)->hs_pending & AF_IUCV_PEND_SYNREPLY) ||
> +	       sk->sk_backlog.len !=3D 0;
> +}
> +
> +/*
> + * A SYN|ACK, SYN|FIN or FIN that arrives while a task owns the socket is
> + * recorded, not queued: nothing resends one, and the backlog may not ke=
ep an
> + * skb from the pfmemalloc reserves (see sk_add_backlog()). The first re=
ply to
> + * our SYN decides, as on arrival; a FIN applies after it. Under sk_lock=
.slock.
> + */
> +static void afiucv_hs_record(struct sock *sk, struct sk_buff *skb, u8 fl=
ags)
> +{
> +	struct iucv_sock *iucv =3D iucv_sk(sk);
> +
> +	switch (flags) {
> +	case AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_ACK:
> +		if (!(iucv->hs_pending & AF_IUCV_PEND_SYNREPLY)) {
> +			iucv->hs_pending_window =3D iucv_trans_hdr(skb)->window;
> +			iucv->hs_pending |=3D AF_IUCV_PEND_SYNACK;
> +		}
> +		break;
> +	case AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_FIN:
> +		if (!(iucv->hs_pending & AF_IUCV_PEND_SYNREPLY))
> +			iucv->hs_pending |=3D AF_IUCV_PEND_SYNFIN;
> +		break;
> +	case AF_IUCV_FLAG_FIN:
> +		iucv->hs_pending |=3D AF_IUCV_PEND_FIN;
> +		break;
> +	}
> +	consume_skb(skb);
> +}
> +
> +/* the owner applies what afiucv_hs_record() kept, under sk_lock.slock */
> +static void afiucv_hs_apply(struct sock *sk, u8 mask)
> +{
> +	struct iucv_sock *iucv =3D iucv_sk(sk);
> +	u8 pending =3D iucv->hs_pending & mask;
> +
> +	iucv->hs_pending &=3D ~pending;
> +	/* closed meanwhile: __iucv_sock_close() leaves IUCV_BOUND as it is */
> +	if (sock_flag(sk, SOCK_ZAPPED))
> +		return;
> +	if ((pending & AF_IUCV_PEND_SYNACK) && sk->sk_state =3D=3D IUCV_BOUND)
> +		afiucv_hs_synack(sk, iucv->hs_pending_window);
> +	if ((pending & AF_IUCV_PEND_SYNFIN) && sk->sk_state =3D=3D IUCV_BOUND)
> +		afiucv_hs_synfin(sk);
> +	if ((pending & AF_IUCV_PEND_FIN) && sk->sk_state =3D=3D IUCV_CONNECTED)
> +		afiucv_hs_fin(sk);
> +}

[Severity: Medium]
What happens if a stray or delayed AF_IUCV_FLAG_FIN frame arrives while a
task owns the socket in IUCV_BOUND before the peer's SYN|ACK arrives?

When the socket is not owned by a user task, afiucv_hs_callback_fin() checks
sk->sk_state =3D=3D IUCV_CONNECTED on arrival and ignores a FIN in IUCV_BOU=
ND.

When sock_owned_by_user(sk) is true (for example, inside iucv_sock_connect()
or iucv_sock_setsockopt() while a SYN is in flight), afiucv_hs_stray()
returns false for AF_IUCV_FLAG_FIN regardless of sk->sk_state, and
afiucv_hs_rcv_owned() -> afiucv_hs_record() sets:

	case AF_IUCV_FLAG_FIN:
		iucv->hs_pending |=3D AF_IUCV_PEND_FIN;
		break;

even when sk->sk_state !=3D IUCV_CONNECTED and
!(iucv->hs_pending & AF_IUCV_PEND_SYNACK).

If the peer's valid SYN|ACK arrives afterwards while the task still holds
lock_sock(sk), afiucv_hs_record() sets AF_IUCV_PEND_SYNACK. When
release_sock(sk) runs afiucv_hs_release_cb() -> afiucv_hs_apply(), it
first applies AF_IUCV_PEND_SYNACK (transitioning sk->sk_state to
IUCV_CONNECTED) and then immediately applies the earlier AF_IUCV_PEND_FIN
against the new IUCV_CONNECTED state, calling afiucv_hs_fin(sk) and
disconnecting the socket with -ECONNREFUSED.

Should afiucv_hs_record() (or afiucv_hs_stray()) ignore AF_IUCV_FLAG_FIN
unless sk->sk_state =3D=3D IUCV_CONNECTED or AF_IUCV_PEND_SYNACK is already
set in iucv->hs_pending?

[ ... ]

> +/*
> + * Frames the dispatcher would only free, and a SYN it would only refuse=
, do
> + * not wait for the owner.
> + */
> +static bool afiucv_hs_stray(struct sock *sk, u8 flags)
> +{
> +	switch (flags) {
> +	case 0:
> +	case AF_IUCV_FLAG_SHT:
> +	case AF_IUCV_FLAG_WIN:
> +	case AF_IUCV_FLAG_FIN:
> +		return false;
> +	case AF_IUCV_FLAG_SYN:
> +		return sk->sk_state !=3D IUCV_LISTEN;
> +	case AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_ACK:
> +	case AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_FIN:
> +		return sk->sk_state !=3D IUCV_BOUND;
> +	}
> +	return true;
> +}

[Severity: Medium]
Can a HiperSockets socket in IUCV_BOUND accept an incoming SYN|ACK before a
SYN has been sent, leaving iucv->msglimit_adv at 0?

In afiucv_hs_send(), iucv->msglimit_adv is only initialized when an
AF_IUCV_FLAG_SYN frame is built:

	if (flags =3D=3D AF_IUCV_FLAG_SYN) {
		phs_hdr->window =3D iucv->msglimit;
		/* what the peer may send us, whatever msglimit becomes */
		iucv->msglimit_adv =3D iucv->msglimit;
	}

In iucv_sock_connect(), iucv->dst_user_id and iucv->dst_name are populated
on an IUCV_BOUND socket before calling iucv_send_ctrl(sock->sk,
AF_IUCV_FLAG_SYN):

	memcpy(iucv->dst_user_id, sa->siucv_user_id, 8);
	memcpy(iucv->dst_name, sa->siucv_name, 8);

	if (iucv->transport =3D=3D AF_IUCV_TRANS_HIPER)
		err =3D iucv_send_ctrl(sock->sk, AF_IUCV_FLAG_SYN);
	else
		err =3D afiucv_path_connect(sock, addr);
	if (err)
		goto done;

If iucv_send_ctrl() fails (-EAGAIN at the sk_sndbuf check or -ENOBUFS at
sock_wmalloc()), the socket remains in IUCV_BOUND with dst_user_id and
dst_name set and iucv->msglimit_adv =3D=3D 0 (or right after iucv_sock_bind=
()
before connect() or listen(), where dst_user_id and dst_name are 8 zero
bytes).

Because afiucv_hs_stray(), afiucv_hs_callback_synack(), and
afiucv_hs_apply() only check sk->sk_state =3D=3D IUCV_BOUND without checking
whether iucv->msglimit_adv !=3D 0, a matching SYN|ACK frame transitions
sk->sk_state to IUCV_CONNECTED with msglimit_adv =3D=3D 0. On the first
non-empty data frame, iucv_sock_recvmsg() then hits:

		if (iucv->transport =3D=3D AF_IUCV_TRANS_HIPER && rlen) {
			atomic_inc(&iucv->msg_recv);
			if (atomic_read(&iucv->msg_recv) > iucv->msglimit_adv) {
				__iucv_sock_close(sk);
				err =3D -EFAULT;
				goto out_err;
			}
		}

which closes the socket and returns -EFAULT.

[ ... ]

> +/* run by __release_sock() for each frame that waited; @sk is still owne=
d */
> +static int afiucv_hs_backlog_rcv(struct sock *sk, struct sk_buff *skb)
> +{
> +	struct net_device *dev =3D NULL;
> +
> +	/* the reply to our SYN came before any frame that waited */
> +	spin_lock_bh(&sk->sk_lock.slock);
> +	afiucv_hs_apply(sk, AF_IUCV_PEND_SYNREPLY);
> +	spin_unlock_bh(&sk->sk_lock.slock);
> +	if (iucv_trans_hdr(skb)->flags =3D=3D AF_IUCV_FLAG_SYN) {
> +		dev =3D skb->dev;		/* held by afiucv_hs_backlog_add() */
> +		if (sk->sk_state !=3D IUCV_LISTEN || sk_acceptq_is_full(sk)) {
> +			/* closed, or its accept queue filled, while the SYN
> +			 * waited: refused as a stray is, without a child
> +			 */
> +			afiucv_hs_callback_syn(NULL, skb);
> +			dev_put(dev);
> +			return 0;
> +		}
> +	}
> +	/* BH off: the callbacks take message_q.lock with spin_lock() */
> +	local_bh_disable();
> +	afiucv_hs_dispatch(sk, skb);
> +	local_bh_enable();
> +	dev_put(dev);
> +	return 0;
> +}
> +
> +/* a task owns @sk, under bh_lock_sock(): what each frame does meanwhile=
 */
> +static int afiucv_hs_rcv_owned(struct sock *sk, struct sk_buff *skb, u8 =
flags)
> +{
> +	switch (flags) {
> +	case AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_ACK:
> +	case AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_FIN:
> +	case AF_IUCV_FLAG_FIN:
> +		afiucv_hs_record(sk, skb, flags);
> +		return NET_RX_SUCCESS;
> +	case AF_IUCV_FLAG_SYN:
> +		break;
> +	default:
> +		if (!afiucv_hs_defer(sk))
> +			return afiucv_hs_dispatch(sk, skb);
> +	}
> +	afiucv_hs_backlog_add(sk, skb, flags);
> +	return NET_RX_SUCCESS;
> +}

[Severity: Medium]
When an AF_IUCV_FLAG_FIN frame arrives while a task owns a connected socket,
can subsequent data, SHT, and WIN frames bypass the deferred FIN before
release_sock(sk) applies it?

When sock_owned_by_user(sk) is true, afiucv_hs_rcv_owned() ->
afiucv_hs_record() records AF_IUCV_PEND_FIN in iucv->hs_pending while
leaving sk->sk_state =3D=3D IUCV_CONNECTED until afiucv_hs_release_cb() run=
s at
the end of release_sock(sk).

If a data (flags =3D=3D 0), AF_IUCV_FLAG_SHT, or AF_IUCV_FLAG_WIN frame arr=
ives
after that FIN while the task still owns sk:

1. When afiucv_hs_defer(sk) is false, afiucv_hs_rcv_owned() immediately
   calls afiucv_hs_dispatch(sk, skb).
2. When afiucv_hs_defer(sk) is true, afiucv_hs_backlog_add() queues the
   frame to sk_backlog, and __release_sock() runs afiucv_hs_backlog_rcv()
   (which only applies AF_IUCV_PEND_SYNREPLY) before afiucv_hs_release_cb()
   applies AF_IUCV_PEND_FIN.

In both cases, afiucv_hs_callback_rx() and afiucv_hs_callback_win() see
sk->sk_state =3D=3D IUCV_CONNECTED and process the post-FIN frames instead =
of
dropping them. Similarly, if the FIN arrives while iucv_sock_recvmsg() holds
lock_sock(sk), sk->sk_state is still IUCV_CONNECTED when iucv_sock_recvmsg()
checks:

		if (send_win && sk->sk_state =3D=3D IUCV_CONNECTED) {
			err =3D iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN);

so a window update is still sent after the peer's FIN.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-b4-disp-1d=
26b87a-v2-0-7ee1264d812a@proton.me?part=3D1
