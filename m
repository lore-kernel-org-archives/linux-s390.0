Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502533;
	b=Hchevto4XdS07e6jmDDuCoShocFtatUdyaqXNouYsdpssNBF8+l0OHpNKd5aV5BYtfWc
	 kf4vM9r8m4l9GiRWE61Gyk2q2hHj3MEq34oLKRnYIwC1ZAdtYaDNSvPsLo+VwmrF8m9cq
	 DlY4eOJy6yQCQlNRIO3A8o4IFQGhbvzv4xgotO1xXA480N4H5IpDLjcpDmScsTFHNTTdk
	 mq8BL2EoaMVL5x0c3gMh8pjdjFTXIPt0nNWd5g6El+k7+yOP3IEGYcY732Po4M/2Uiu71
	 prPGTpOxfNzBf5dRe53Qm7lEoNtbUnwKm9dBAwSN6nfhHiFRnYrKVnjdxwmhOrcNd4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502533;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0fYFtzCEXyz583Gech+vxV/e5Ww4NkY0BMXaWl9uddY=;
	b=F+tsfqDKf+WsJKsnx4vNQ15JKIFrA+RVaWlPkrKCDQ3V8jsUVolfsCnrKnK2URGxxaPL
	 KPQU38felpbDocisgKZqg8FKC24KC59YsBiAri7q2BkdlL2Sd0O9VD1TadCAt3j85XWKr
	 SysWkkf/6qQ6WI7IZ0YYBpZGR/HVLCxOXvGqn8FCvNPhccgAQJ4AyUtD6u0DwHXbkgx+R
	 eXhYv8U/29QALQB6ACPGbVZfkLg3UuKRmtz4HmaxuaP3pOIjS7tiquXfV6PcW5gpV4yos
	 eXC16qWddAUym2+L+ivg2pqEg9lZxVuHFB26qs8qlnMyVkrTrqG1LcHNjsOlWeJixHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LI1iuMeW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEBF606A31B
	for <linux-s390@vger.kernel.org>; Tue, 20 Oct 2026 13:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LI1iuMeW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E541F000C4;
	Tue, 20 Oct 2026 13:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792502532;
	bh=0fYFtzCEXyz583Gech+vxV/e5Ww4NkY0BMXaWl9uddY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LI1iuMeW32/R854CKUYKhQ5Sr+CrYS9GNdbtjLHRDe2F+Y7KaXssNaIOPBA4yOgLf
	 eAoUFiuoXPkdfW1mWBw5EHx3JSA2T8TaFMLS212s7Q0zYhn4zS26T5rwV6okpVI1TE
	 7FfFoxbJcBPSK4gcUwvDfWYxfMU00y8/8prkW7RryS+t8AjnHlCcQ1D2bZ4GkAPQTd
	 bMxPkKuHQwfmGhejDY8mzH9Q5Z/JFR9dmku9otXxiXIiz7FOw8Ne91ppoWWk3NYc+e
	 MpBK/x/HBvE/hHSyoPGzlcOrRbLZ5iFyvHLa+J/Q9xQlnkUZ7Lhq2I/YrBGGFvWawM
	 uFmyGO+Og/yAQ==
Message-ID: <sashiko-outbox-179016@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] iucv: fix lockless sk_for_each in afiucv_netdev_event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haoran Wang" <haoranwangsec@gmail.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <179241612354.5916.12881323209252769976@whr>
References: <179241612354.5916.12881323209252769976@whr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 13:22:10 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] iucv: softirq deadlock in afiucv_netdev_event() due to read_lock()
- [High] iucv: race with iucv_sock_close() in afiucv_netdev_event() out-of-=
lock loop
--

commit 7da7cd5e3cce2986228a27e227a58eb1b118ea15
Author: Haoran Wang <haoranwangsec@gmail.com>

iucv: fix lockless sk_for_each in afiucv_netdev_event

This commit acquires iucv_sk_list.lock around the sk_for_each() traversal in
afiucv_netdev_event(), collecting matching sockets with sock_hold() into a
dynamically allocated array before running iucv_send_ctrl() and
sk_state_change() outside the lock.

> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index db261ecd19af1..20c8943b85cd2 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -2222,18 +2222,49 @@ static int afiucv_netdev_event(struct notifier_bl=
ock *this,
> =20
>  	switch (event) {
>  	case NETDEV_REBOOT:
> -	case NETDEV_GOING_DOWN:
> +	case NETDEV_GOING_DOWN: {
> +		struct sock **matches;
> +		int i, n =3D 0, count =3D 0;
> +
> +		read_lock(&iucv_sk_list.lock);
>  		sk_for_each(sk, &iucv_sk_list.head) {
>  			iucv =3D iucv_sk(sk);
> -			if ((iucv->hs_dev =3D=3D event_dev) &&
> -			    (sk->sk_state =3D=3D IUCV_CONNECTED)) {
> -				if (event =3D=3D NETDEV_GOING_DOWN)
> -					iucv_send_ctrl(sk, AF_IUCV_FLAG_FIN);
> -				sk->sk_state =3D IUCV_DISCONN;
> -				sk->sk_state_change(sk);
> +			if (iucv->hs_dev =3D=3D event_dev &&
> +			    sk->sk_state =3D=3D IUCV_CONNECTED)
> +				count++;
> +		}
> +		read_unlock(&iucv_sk_list.lock);
> +
> +		if (!count)
> +			break;
> +		matches =3D kmalloc_array(count, sizeof(*matches), GFP_KERNEL);
> +		if (!matches)
> +			break;
> +
> +		read_lock(&iucv_sk_list.lock);
> +		sk_for_each(sk, &iucv_sk_list.head) {
> +			if (n =3D=3D count)
> +				break;
> +			iucv =3D iucv_sk(sk);
> +			if (iucv->hs_dev =3D=3D event_dev &&
> +			    sk->sk_state =3D=3D IUCV_CONNECTED) {
> +				sock_hold(sk);
> +				matches[n++] =3D sk;
>  			}
>  		}
> +		read_unlock(&iucv_sk_list.lock);

[Severity: High]
Should both passes in afiucv_netdev_event() use read_lock_bh() and
read_unlock_bh() instead of bare read_lock() and read_unlock()?

afiucv_netdev_event() runs in process context with bottom halves enabled,
unlike the other two read_lock(&iucv_sk_list.lock) sites in afiucv_hs_rcv()
and iucv_callback_connreq(), which already run with bottom halves disabled.

Writers to iucv_sk_list can be invoked from softirq context:

afiucv_hs_rcv()
  afiucv_hs_callback_syn()
    iucv_sock_alloc()
      iucv_sock_link()
        write_lock_bh(&l->lock)

and on error in afiucv_hs_callback_syn():

    iucv_sock_kill()
      iucv_sock_unlink()
        write_lock_bh(&l->lock)

If NET_RX_SOFTIRQ interrupts afiucv_netdev_event() on the same CPU while it
holds read_lock(&iucv_sk_list.lock), can write_lock_bh(&iucv_sk_list.lock)
spin forever waiting for the preempted reader?

> +
> +		for (i =3D 0; i < n; i++) {
> +			sk =3D matches[i];
> +			if (event =3D=3D NETDEV_GOING_DOWN)
> +				iucv_send_ctrl(sk, AF_IUCV_FLAG_FIN);
> +			sk->sk_state =3D IUCV_DISCONN;
> +			sk->sk_state_change(sk);
> +			sock_put(sk);
> +		}

[Severity: High]
Can this loop race with a concurrent iucv_sock_close() and dereference a NU=
LL
iucv->hs_dev pointer in iucv_send_ctrl()?

sock_hold(sk) pins the struct sock memory, but once iucv_sk_list.lock is
dropped (or before iucv_sock_kill() unlinks the socket), a concurrent
iucv_sock_release() -> iucv_sock_close() can run under lock_sock(sk):

net/iucv/af_iucv.c:iucv_sock_close() {
	...
	if (iucv->hs_dev) {
		dev_put(iucv->hs_dev);
		iucv->hs_dev =3D NULL;
		sk->sk_bound_dev_if =3D 0;
	}
	sk->sk_state =3D IUCV_CLOSED;
	...
}

When afiucv_netdev_event() then processes matches[i] without holding
lock_sock(sk) or rechecking sk->sk_state and iucv->hs_dev, iucv_send_ctrl()
evaluates LL_RESERVED_SPACE(iucv->hs_dev):

net/iucv/af_iucv.c:iucv_send_ctrl() {
	...
	blen =3D sizeof(struct af_iucv_trans_hdr) +
	       LL_RESERVED_SPACE(iucv->hs_dev);
	...
}

In addition, wouldn't unconditionally setting sk->sk_state =3D IUCV_DISCONN
outside lock_sock(sk) overwrite IUCV_CLOSING or IUCV_CLOSED set by a
concurrent close, and race on sk->sk_shutdown in iucv_send_ctrl()?

> +		kfree(matches);
>  		break;
> +	}
>  	case NETDEV_DOWN:
>  	case NETDEV_UNREGISTER:
>  	default:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179241612354.5916.1=
2881323209252769976@whr?part=3D1
