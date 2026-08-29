Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374253191D3
	for <linux-s390@vger.kernel.org>; Sat, 29 Aug 2026 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788030471; cv=none; b=QYr55KGcFpA2gsBDmPwqYih/79t9l7P1mF5wr1MqrVGiZCWw2hQdhIu92ACIZvVa6ZyADGboOt0O5ySuV9Sd2Z8k4fNj/XBa9zQYexizPYF90vA48mzsVHgTVJ7aGxT2N88ufMh0KhRZKWLY2tWVT2L97JmZSxECFbuxSk7VSY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788030471; c=relaxed/simple;
	bh=J6950hmevqv1yXDeqV9X8RlEx+5a2FtVOylELNxhF8w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CEwWi+h8C9Ekt2TPwa/vvqORILcuP2DImoqdpUdMX+BZI7eTsqlWSx1DfFK7KQ2CMBiTHxOEgPkCfDS+4CvZEOJpBxCTseLheBii7nqK8Iv3n5LbPBwW+ier6YdoV0ZODwML2QnJ17PNzlxNpgIDd5sbmy+ImRuWxuvBuaZFTao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpBp++ba; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpBp++ba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C471F000E9;
	Sat, 29 Aug 2026 19:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788030469;
	bh=BeOCESbWifaPhKE/aYUIFn2tlbwgdumqMPFH12Zlk2c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kpBp++bad79PO+YR3WWPfcH0I4hq4LqyHKy6FLMQtYuTaMd7zwYwBh9oxXIRLflQd
	 Utx0THlwnD8CDha0Rjpfn0lRF1wACbmWt9R/qDTb8NU1KKx3p4T9zkSr4e0Z7Z1MEE
	 bQYqn77GR2/YWUKDvbz00lMWuu+cu4BvVE45LBp6R1SLFxsCdOVXVqycmQnR+yU+wJ
	 4CoJs7x4vyZ17SAHsK4+detsAize58lm5efBhyHK3fa3AWxo1ELiJaHSgwp4IX5Xjt
	 uQLG8WlT8x4M1d1AGIijBe7Anm1NaMaIeDaUgLn4yIj02b+yhRwD+PLhAcQJmXv1Uw
	 pe5KBlw2eFNGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3] net/iucv: fix the recvmsg window update
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260828-b4-disp-33fac0ed-v3-1-e6d061880ee0@proton.me>
References: <20260828-b4-disp-33fac0ed-v3-1-e6d061880ee0@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 19:07:49 +0000
Message-Id: <20260829190749.81C471F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless modification of sk->sk_shutdown and sk->sk_state leads to=
 data races and lost state updates.
- [High] Silent data truncation for SOCK_STREAM over HiperSockets when mess=
age size exceeds MTU.
--

commit 9ec78889adee8ffda3665e319fc36af7e52f542f
Author: Bryam Vargas <hexlabsecurity@proton.me>

    net/iucv: fix the recvmsg window update

    This commit attempts to fix a spurious disconnect in HiperSockets by
    properly checking the transport before sending an AF_IUCV_FLAG_WIN
    message. It also addresses a counter race by claiming the window credit
    after ruling out error exits.

> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index 4e5cc9da6e068..db261ecd19af1 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -250,13 +244,22 @@ static int afiucv_hs_send(struct iucv_message *imsg=
, struct sock *sock,
>  	}
>  	skb->protocol =3D cpu_to_be16(ETH_P_AF_IUCV);

[Severity: High]
This is a pre-existing issue, but just above this point in afiucv_hs_send(),
large buffers are silently truncated:

	if (skb->len > skb->dev->mtu) {
		if (sock->sk_type =3D=3D SOCK_SEQPACKET) {
			err =3D -EMSGSIZE;
			goto err_free;
		}
		err =3D pskb_trim(skb, skb->dev->mtu);
		if (err)
			goto err_free;
	}

If pskb_trim() succeeds for a SOCK_STREAM socket, afiucv_hs_send() returns
success. Does iucv_sock_sendmsg() then return the full original requested
length to user-space instead of the truncated length, masking the truncation
and causing silent data loss?

> +	/* Claim the receive credit here, not while building the header: every
> +	 * way this frame can be dropped has now been ruled out, so the window
> +	 * is zeroed only for as long as the transmit itself takes.
> +	 */
> +	if (flags =3D=3D AF_IUCV_FLAG_WIN || !flags) {
> +		confirm_recv =3D atomic_xchg(&iucv->msg_recv, 0);
> +		phs_hdr->window =3D confirm_recv;
> +		if (confirm_recv)
> +			phs_hdr->flags =3D phs_hdr->flags | AF_IUCV_FLAG_WIN;
> +	}
> +
>  	atomic_inc(&iucv->skbs_in_xmit);
>  	err =3D dev_queue_xmit(skb);

[ ... ]

> @@ -1331,16 +1335,20 @@ static int iucv_sock_recvmsg(struct socket *sock,=
 struct msghdr *msg,
>  		if (skb_queue_empty(&iucv->backlog_skb_q)) {
>  			if (!list_empty(&iucv->message_q.list))
>  				iucv_process_message_q(sk);
> -			if (atomic_read(&iucv->msg_recv) >=3D
> -							iucv->msglimit / 2) {
> -				err =3D iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN);
> -				if (err) {
> -					sk->sk_state =3D IUCV_DISCONN;
> -					sk->sk_state_change(sk);
> -				}
> -			}
> +			if (iucv->transport =3D=3D AF_IUCV_TRANS_HIPER &&
> +			    atomic_read(&iucv->msg_recv) >=3D
> +							iucv->msglimit / 2)
> +				send_win =3D true;
>  		}
>  		spin_unlock_bh(&iucv->message_q.lock);
> +
> +		if (send_win) {
> +			err =3D iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN);

[Severity: High]
This is a pre-existing issue, but does calling iucv_send_ctrl() here without
holding lock_sock() cause data races?

In net/iucv/af_iucv.c:iucv_send_ctrl():

	if (sk->sk_shutdown & SEND_SHUTDOWN) {
		/* controlling flags should be sent anyway */
		shutdown =3D sk->sk_shutdown;
		sk->sk_shutdown &=3D RCV_SHUTDOWN;
	}
[ ... ]
	if (shutdown)
		sk->sk_shutdown =3D shutdown;

Could this lockless temporary modification overwrite concurrent updates to
sk_shutdown (e.g., losing a RCV_SHUTDOWN flag set by shutdown()), leading to
an application hanging indefinitely in recvmsg?

> +			if (err) {
> +				sk->sk_state =3D IUCV_DISCONN;

[Severity: High]
This is also a pre-existing issue, but is it safe to update sk_state lockle=
ssly
here? This appears to violate core socket locking rules, potentially corrup=
ting
the state machine.

> +				sk->sk_state_change(sk);
> +			}
> +		}
>  	}
> =20
>  done:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-b4-disp-33=
fac0ed-v3-1-e6d061880ee0@proton.me?part=3D1
