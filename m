Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794792568;
	b=rdtiBWA58uy9QxygC6tV0O7QyX02PVSw9NA1Lm9v687nG5+RS+wbDpIu9gkJH1rxq78r
	 12ORum3P+aQjP9EPaob+utS9Td12yup9osykiAZwnXK9640yBb+QMgM+IJuEjLYpy/v1f
	 eyO10M62l1C0tmJQp7XWBWu4f17JI0T/BCV3oTppcF3qa3OtCJ0Qgo0o7LQlviAN/2aLC
	 aX+TfcvebEMEt+MHlbQtw25JhfmUM5AAWhUYgQlsbpeVxi0XcAfblIpxGVLqG/qaCswWN
	 ZuqQGH/bziUF9xq1RyuPZrHZ01vmGT3Cp4zTvSEGq9+l+9Avirjx3V3TvvVPdLLFsdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794792568;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MRSVAMYeABGCa3qBYb3YmTtrzBsgyMJR1YjWqaDXbR4=;
	b=ng50m8XFWAYvOJjUqcJoz3mVJr5CvBMGyl7chBKuNg7Qdx1UCwF036gttUWrkvPcUIvn
	 zwpGaXDPnA/RUCzTUFXPG24qN8Fylbe43t+AoFiqyF3EF4+u9F+8wZ96UX0ZhXkXsXTy6
	 BFZJsZLav2iZnVgKmM4R4toAh6dsb9uyqFOp3NDUb8zxE9nG0T+7yhEUg2MQ2MNnsV5pe
	 xZUXOktBlpooEQxQjxiXhMZ84Xau3U150ejm/cw2Yph3gTiZsTNKNemcMF/f444u9WcA6
	 vBQQKlH/D93L/+GwfRMcT//VBsbiqq0kz+7lcBiBND51Uymc1gC/aG5Z0wswMw1i1ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=grWqCpzM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4B5606A31C
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 01:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=grWqCpzM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA471F000C4;
	Mon, 16 Nov 2026 01:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794792567;
	bh=MRSVAMYeABGCa3qBYb3YmTtrzBsgyMJR1YjWqaDXbR4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=grWqCpzMbDJW3GUQGVkNQ2PMgekwJa+p5wXtDooyDbDuWqE5oo5PTQ0bnZgBqotUo
	 4ThXzu9Q8M8eqNgGkV97e1g9dQzSvnHZWmapBNET+hAJUDueis+rQx+vIFbZjA4C9Z
	 2ppI7z4ygwpetG0VEMoS8/4Y/mg8gYOq5VhY/9OpktEPHebV4/j5io0I7IG+3r76M4
	 JYP2oYLuLmbVwmXAyCHsm+gLtkAOLlze7p2BCYJtMbvRWbbeE2Rb9/65HBYVTLs+4n
	 UnpSFkFNWF0qcRPfR0bdhWP++Vuq/pT9HaXFj0vZmJ2Th1GsscgryAwTX6cRnNKBH+
	 wTP+qmbY0+XaQ==
Message-ID: <sashiko-outbox-215997@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net v4 6/8] net/iucv: serialize HiperSockets receive
 with the socket lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261114-b4-disp-fc0634a3-v4-6-f96c506447ce@proton.me>
References: <20261114-b4-disp-fc0634a3-v4-0-f96c506447ce@proton.me>
 <20261114-b4-disp-fc0634a3-v4-6-f96c506447ce@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 01:29:27 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] net/iucv: unapplied hs_pending control frames in
  iucv_sock_connect() and wait
- [Medium] net/iucv: afiucv_hs_stray() and afiucv_hs_defer() queue stray
  data frames
- [Low] net/iucv: missing SOCK_ZAPPED check in afiucv_hs_stray() for
  IUCV_BOUND sockets
--

commit c1273c23cdabb854289296a6ae44aec0ac20fc36
Author: Bryam Vargas <hexlabsecurity@proton.me>

net/iucv: serialize HiperSockets receive with the socket lock

This commit serializes HiperSockets receive handling with the socket lock by
taking bh_lock_sock() in afiucv_hs_rcv() and recording control frames or
queueing data and SYN frames in the socket backlog while a task owns the
socket.

Link: https://lore.kernel.org/all/20260724222917.134769-1-hexlabsecurity@pr=
oton.me/

> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index 957315bec2b45..2dd9f12bce625 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c

[ ... ]

> @@ -845,6 +897,15 @@ static int iucv_sock_connect(struct socket *sock, st=
ruct sockaddr_unsized *addr,
>  	if (err)
>  		goto done;
> =20
> +	/* The reply may be in already, recorded while we own the socket:
> +	 * apply it, or a non-blocking connect() misses it.
> +	 */
> +	if (iucv->transport =3D=3D AF_IUCV_TRANS_HIPER) {
> +		spin_lock_bh(&sk->sk_lock.slock);
> +		afiucv_hs_apply(sk, AF_IUCV_PEND_SYNREPLY);
> +		spin_unlock_bh(&sk->sk_lock.slock);
> +	}
> +
>  	if (sk->sk_state !=3D IUCV_CONNECTED)
>  		err =3D iucv_sock_wait(sk, iucv_sock_in_state(sk, IUCV_CONNECTED,
>  							    IUCV_DISCONN),

[Severity: Medium]
Can iucv_sock_connect() miss a SYN|ACK or SYN|FIN recorded in
iucv->hs_pending after this single afiucv_hs_apply() call?

iucv_sock_connect()
  spin_lock_bh(&sk->sk_lock.slock)
  afiucv_hs_apply(sk, AF_IUCV_PEND_SYNREPLY)
  spin_unlock_bh(&sk->sk_lock.slock)
  iucv_sock_wait()
    release_sock(sk)
    schedule_timeout()
    lock_sock(sk)
    <softirq>
      afiucv_hs_rcv()
        afiucv_hs_record()
          iucv->hs_pending |=3D AF_IUCV_PEND_SYNACK
    while (!(condition))  <-- sk_state is still IUCV_BOUND
      ret =3D -EAGAIN / -ERESTARTSYS
      break
  release_sock(sk)
    afiucv_hs_release_cb()
      afiucv_hs_synack()
        sk->sk_state =3D IUCV_CONNECTED

If a reply arrives after spin_unlock_bh() on a non-blocking connect(), or
after lock_sock(sk) reacquires ownership inside __iucv_sock_wait() (for
example, when woken by TX completion of the SYN via
afiucv_hs_callback_txnotify() -> iucv_sock_wake_msglim(), a signal, or a
timeout), iucv_sock_in_state() and the post-wait sk->sk_state check still s=
ee
IUCV_BOUND.  iucv_sock_connect() then returns -EAGAIN or -ERESTARTSYS while
release_sock(sk) applies the recorded reply, leaving the socket in
IUCV_CONNECTED (or in IUCV_DISCONN without returning -ECONNREFUSED) so a
subsequent connect() retry fails with -EBADFD.

Similarly, in iucv_sock_sendmsg(), an incoming FIN recorded as
AF_IUCV_PEND_FIN while the task owns the socket is not applied before
iucv_below_msglim() or the sk->sk_state !=3D IUCV_CONNECTED check.

[ ... ]

> @@ -2189,12 +2244,174 @@ static int afiucv_hs_callback_rx(struct sock *sk=
, struct sk_buff *skb)
>  	return NET_RX_SUCCESS;
>  }
> =20
> +/**
> + * afiucv_hs_stray() - test for a frame that no state of the socket can =
use
> + * @sk:		the socket the frame is for, under bh_lock_sock()
> + * @flags:	the flags of the frame
> + *
> + * A stray never waits for the owner. A SYN is one outside IUCV_LISTEN a=
nd a
> + * SYN|ACK or SYN|FIN outside IUCV_BOUND, the state tests of their
> + * callbacks; a full accept queue is not tested here. A FIN is one unless
> + * the socket is connected or a recorded SYN|ACK is about to connect it.
> + * Data, SHT and WIN are strays once the peer's FIN is recorded: the soc=
ket
> + * stays IUCV_CONNECTED until the owner applies it.
> + *
> + * Context: Softirq, under bh_lock_sock().
> + * Return: true if the frame is to be freed or, for a SYN, refused.
> + */
> +static bool afiucv_hs_stray(struct sock *sk, u8 flags)
> +{
> +	struct iucv_sock *iucv =3D iucv_sk(sk);
> +
> +	switch (flags) {
> +	case 0:
> +	case AF_IUCV_FLAG_SHT:
> +	case AF_IUCV_FLAG_WIN:
> +		return iucv->hs_pending & AF_IUCV_PEND_FIN;
> +	case AF_IUCV_FLAG_FIN:
> +		return sk->sk_state !=3D IUCV_CONNECTED &&
> +		       !(iucv->hs_pending & AF_IUCV_PEND_SYNACK);
> +	case AF_IUCV_FLAG_SYN:
> +		return sk->sk_state !=3D IUCV_LISTEN;
> +	case AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_ACK:
> +	case AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_FIN:
> +		return sk->sk_state !=3D IUCV_BOUND;
> +	}
> +	return true;
> +}
> +
> +/**
> + * afiucv_hs_defer() - test whether a data, SHT or WIN frame has to wait
> + * @sk:		the socket, owned by a task, under bh_lock_sock()
> + *
> + * These frames do not change sk_state and are handled on arrival, also
> + * while a task owns the socket. They wait in the socket backlog only if:
> + *
> + * - the reply to our SYN is recorded and not applied yet: the socket is
> + *   still IUCV_BOUND, where data is freed and a WIN ignored;
> + * - frames wait already: a later one must not overtake them, and
> + *   sk_backlog.len stays non-zero until __release_sock() has run them a=
ll.
> + *
> + * Context: Softirq, under bh_lock_sock().
> + * Return: true if the frame has to wait in the backlog.
> + */
> +static bool afiucv_hs_defer(struct sock *sk)
> +{
> +	return (iucv_sk(sk)->hs_pending & AF_IUCV_PEND_SYNREPLY) ||
> +	       sk->sk_backlog.len !=3D 0;
> +}

[Severity: Medium]
Do afiucv_hs_stray() and afiucv_hs_defer() allow data, SHT, and WIN frames
to be queued into sk->sk_backlog when the socket is neither connected nor
about to be connected by a recorded SYN|ACK?

For flags 0, AF_IUCV_FLAG_SHT, and AF_IUCV_FLAG_WIN, afiucv_hs_stray() only
checks iucv->hs_pending & AF_IUCV_PEND_FIN, and afiucv_hs_defer() tests
AF_IUCV_PEND_SYNREPLY (which includes AF_IUCV_PEND_SYNFIN) as well as
sk->sk_backlog.len !=3D 0.  If a task owns an IUCV_BOUND socket that has
recorded a SYN|FIN, or an IUCV_LISTEN socket with a SYN in sk->sk_backlog,
subsequent data, SHT, and WIN frames pass afiucv_hs_stray() and are queued
into sk->sk_backlog by afiucv_hs_backlog_add() instead of being freed in
afiucv_hs_rcv().

[ ... ]

> @@ -2311,18 +2596,25 @@ static int afiucv_hs_rcv(struct sk_buff *skb, str=
uct net_device *dev,
>  	if (!iucv)
>  		sk =3D NULL;
> =20
> -	/* no sock
> -	how should we send with no sock
> -	1) send without sock no send rc checking?
> -	2) introduce default sock to handle this cases
> -
> -	 SYN -> send SYN|ACK in good case, send SYN|FIN in bad case
> -	 data -> send FIN
> -	 SYN|ACK, SYN|FIN, FIN -> no action? */
> +	/* no socket: a SYN is refused, anything else freed */
> +	if (!sk)
> +		return afiucv_hs_dispatch(NULL, skb);
> =20
> -	err =3D afiucv_hs_dispatch(sk, skb);
> -	if (sk)
> -		sock_put(sk);
> +	bh_lock_sock(sk);
> +	if (afiucv_hs_stray(sk, trans_hdr->flags)) {
> +		if (trans_hdr->flags =3D=3D AF_IUCV_FLAG_SYN)
> +			afiucv_hs_callback_syn(NULL, skb);
> +		else if (trans_hdr->flags =3D=3D AF_IUCV_FLAG_FIN)
> +			consume_skb(skb);
> +		else
> +			kfree_skb_reason(skb, SKB_DROP_REASON_NO_SOCKET);
> +	} else if (sock_owned_by_user(sk)) {
> +		err =3D afiucv_hs_rcv_owned(sk, skb, trans_hdr->flags);
> +	} else {
> +		err =3D afiucv_hs_dispatch(sk, skb);
> +	}
> +	bh_unlock_sock(sk);
> +	sock_put(sk);
>  	return err;
>  }

[Severity: Low]
Should afiucv_hs_stray() also test sock_flag(sk, SOCK_ZAPPED) for SYN|ACK a=
nd
SYN|FIN frames?

CPU0                              CPU1 (<softirq>)
iucv_sock_close(sk)
  lock_sock_nested(sk, ...)
                                  afiucv_hs_rcv()
                                    read_lock(&iucv_sk_list.lock)
                                    sock_hold(sk)
                                    read_unlock(&iucv_sk_list.lock)
  __iucv_sock_close(sk)
    iucv->hs_dev =3D NULL
    sock_set_flag(sk, SOCK_ZAPPED)
  release_sock(sk)
                                    bh_lock_sock(sk)
                                    afiucv_hs_stray(sk, SYN|ACK) -> false
                                    sock_owned_by_user(sk) -> false
                                    afiucv_hs_dispatch(sk, skb)
                                      afiucv_hs_synack()  <-- connected aft=
er close

As noted in afiucv_hs_apply(), __iucv_sock_close() leaves sk->sk_state as
IUCV_BOUND and marks the socket with SOCK_ZAPPED.  If afiucv_hs_rcv() looks
up the socket just before iucv->hs_dev is cleared and acquires
bh_lock_sock(sk) after release_sock(sk), the unowned path bypasses
afiucv_hs_apply() and transitions the closed socket to IUCV_CONNECTED or
IUCV_DISCONN.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-b4-disp-fc=
0634a3-v4-0-f96c506447ce@proton.me?part=3D6
