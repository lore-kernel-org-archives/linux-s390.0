Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458682;
	b=0nMkhXkfubuhNUw2dtHqtHdv+QZeh+kumKS/dANPCXQVlA4c1CdsB2t6+AcA+U+aaXjP
	 vszWW99dYtXAnNoaSn1YU2onim40MgTMgOjetpHrNczec1vZjDiw7OyivHTtTDTr19sX2
	 C1J/IIbNe7qmkUsbhaFOt19fgsr5iGIOklYd14hpBH65CafnDhOp/N+iN/pwElb1qxyBj
	 6C2AMwhvt2ivCcoH81s+/vRJ3RuKrvGLsC92cB2qC9J9VtVT7YGLZiPlSETSoHgqJDT0C
	 uphbo0wGbCA/RcbXmxtG+Ol3LCIDVnDWsYiqI5pt+tStR9YPJ3MTPfTxWouU8hyhROg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458682;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iaB2xZjkQsiHZeJLo1UomZRJ3RBDnszEW+eWkFRJiec=;
	b=Lu1+WYcK5FTa/i5UBA3+MNx88LTYyed1qNOVQLDO5g8NZZgiJ/iZ+JeLTo6o3JaegGjE
	 zt3lmIXNRu2iNdKiXEXETHouQSlK2+if78LqBke3PHC4F499kdyfzi/VWeSCAG0ItxYj0
	 dUO2i86Rs6ayArSWhXdLlBma5/NGvA3VYHn+Zy2vnnxOccvM19BeaKyG5hy+ANkaqgrxs
	 wQ0iDO2edtUkzwy70RVUVPpWS0QxrQxd29yxGbqgSFIR/82EfR2Mb6bW/+NRZJqzWRfM/
	 I5Hpcl2QvQLJFZV/yZwBZ5Y9u9pzNJ/f30FBkXeQau68dZ89VPhtC8LvhqSimgEsEBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l8sh7muA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F67606A321
	for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 04:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l8sh7muA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0391F00A05;
	Thu, 12 Nov 2026 04:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794458681;
	bh=iaB2xZjkQsiHZeJLo1UomZRJ3RBDnszEW+eWkFRJiec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l8sh7muA/8ZhZRoNLSF9FgBcnH/2lEJbqrv2Rb2kSvcJZQqBnGnjIVnW2KSAUY1P8
	 y7xw+8Yqcn+ZAX91XSBG7MNdh3ki4/VksPr0szrAa9xtyfPh/G8I8ALeS+inJW0hsg
	 RlVvP4f8KYS/OSKTChfgsOw4FwdSW77pU4EX26A/rJ16wyeApB/r03PsTScwN2om6F
	 JjAmEbMffSaX9N4BkENsOG3df+qp4zBzX116Sa9BKL47oqGzsrUC2cg9q4/WA+dwDA
	 hsyiUW4EHgq+xKKaVmuWgtyguzVHZtkbnGRTXwKKSs4JlmHjmWpdQAHcX4dM4a/3tZ
	 Wm/n5+J38oioQ==
Message-ID: <sashiko-outbox-210385@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net v3 3/7] net/iucv: run recvmsg() under the socket
 lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261110-b4-disp-2a6b4364-v3-3-35677b68e697@proton.me>
References: <20261110-b4-disp-2a6b4364-v3-0-35677b68e697@proton.me>
 <20261110-b4-disp-2a6b4364-v3-3-35677b68e697@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 04:44:41 +0000
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
- [Medium] net/iucv: missed shutdown wakeup in iucv_sock_sendmsg()
  during wmem wait
--

commit 16ffdad8f70763ae645ac7eca51d7e6e91eed12b
Author: Bryam Vargas <hexlabsecurity@proton.me>

net/iucv: run recvmsg() under the socket lock

This commit acquires the socket lock in iucv_sock_recvmsg() while dropping =
it
in sk_wait_event() when waiting for data, and drops the socket lock in
iucv_sock_sendmsg() while waiting for send buffer memory.

Link: https://lore.kernel.org/all/20260724222917.134769-1-hexlabsecurity@pr=
oton.me/

> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index 133c1d1886b2a..639725917f3f8 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -1041,7 +1041,17 @@ static int iucv_sock_sendmsg(struct socket *sock, =
struct msghdr *msg,
>  		}
>  	}
>  	skb =3D sock_alloc_send_pskb(sk, headroom + linear, len - linear,
> -				   noblock, &err, 0);
> +				   1, &err, 0);
> +	if (!skb && err =3D=3D -EAGAIN && !noblock) {
> +		/* Wait without the socket lock: recvmsg() takes it, and over
> +		 * z/VM the memory comes back only when the peer reads, which
> +		 * may wait for our own reader.
> +		 */
> +		release_sock(sk);
> +		skb =3D sock_alloc_send_pskb(sk, headroom + linear,
> +					   len - linear, 0, &err, 0);
> +		lock_sock(sk);
> +	}

[Severity: Medium]
Can a writer waiting in sock_alloc_send_pskb() without lock_sock(sk) miss a
concurrent shutdown(SHUT_WR) wakeup when iucv_send_ctrl() temporarily clears
SEND_SHUTDOWN?

net/iucv/af_iucv.c:iucv_send_ctrl() {
    ...
	if (sk->sk_shutdown & SEND_SHUTDOWN) {
		/* controlling flags should be sent anyway */
		shutdown =3D sk->sk_shutdown;
		sk->sk_shutdown &=3D RCV_SHUTDOWN;
	}
	skb =3D sock_alloc_send_skb(sk, blen, 1, &err);
	if (skb) {
		skb_reserve(skb, blen);
		err =3D afiucv_hs_send(NULL, sk, skb, flags);
	}
	if (shutdown)
		sk->sk_shutdown =3D shutdown;
    ...
}

Because sock_wait_for_wmem() now runs unlocked, it can race with
iucv_send_ctrl() (called under lock_sock(sk) by iucv_sock_recvmsg() for a
window update):

CPU0                              CPU1
iucv_sock_sendmsg()
  release_sock(sk)
  sock_alloc_send_pskb()
    sock_wait_for_wmem()
      prepare_to_wait(...)
                                  iucv_sock_shutdown(SHUT_WR)
                                    sk->sk_shutdown |=3D SEND_SHUTDOWN
                                    sk->sk_state_change(sk)
                                  iucv_sock_recvmsg()
                                    iucv_send_ctrl()
                                      sk->sk_shutdown &=3D RCV_SHUTDOWN
      if (sk->sk_shutdown & SEND_SHUTDOWN)
        /* false */
                                      sk->sk_shutdown =3D shutdown
      schedule_timeout(timeo)  <-- sleeps despite SHUT_WR

Since iucv_send_ctrl() restores SEND_SHUTDOWN without waking sk_sleep(sk),
iucv_sock_sendmsg() stays blocked in schedule_timeout() until send memory is
freed or SO_SNDTIMEO expires instead of returning -EPIPE immediately.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-b4-disp-2a=
6b4364-v3-0-35677b68e697@proton.me?part=3D3
