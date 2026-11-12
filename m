Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458680;
	b=Uy+fFtMewrvig5Ta5N9OOsipZ5HKDLMcX1XMGm7KmAsBgnvNuU6p1Cijx20SUwWX3Uba
	 uVj+zaxk+tDunOcQ+esbO2sLF3W2fnecaoUnc1G9UpKvYaa+qKNvZevv1shrVMBTIx55R
	 ePusrkq0KBqU1fTClwqqrgGIEcUpWXogOlHIESK1owHKdZp+ccRBCNycaFkY35xMonuYA
	 +piPFGN1tJzUpwCKfCVd1D6c2mQS2W06CAOptllqLH93GKXRKK6kB3ZjiGCLy234K2AyZ
	 Z0abMrtE3fUCJBttm1wvLXFQlLJh3b/aw5yZz+ZxMZmOf+ZcxHFZvzCU76EPsLcyNoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458680;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fcPJCRmdu+P6XyBizHpaGO0Fz97duxt+6ILfD0XU0ds=;
	b=Yr8tf1H2I96bbzGrrEHl5sVyM4+f6Qna7itUCuD3wvWgo7lBvcVSkZFht7VQ2OV9Tv0Z
	 EnrG1miKX9ISwK+dKYI1dvKHtmgdZa8M7xOgZAto6ms8Oy0i6ca1UZte8VdTRdGnMsVOH
	 tPWvDuLhkkV9HaVuiQg+CcErZDRTJ5XEcaEcmKkLkB7JarCHqPAUYIzlty6IdPEjLxSTj
	 ucgdKYQ5/ciOyH6dqNQfRsn2G/GxsqV/FUCSD+FVJ/lxDVeF6Di6q47pZsSbKzkhQInxz
	 SRtdx7UR3214W973vqiIbDCGZoPmxMv1Q+dhsXM5ajJmB8fDGTgIFozP5xXFXb0WZ6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kv4VyDNQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D27606A321
	for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 04:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kv4VyDNQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB561F00A05;
	Thu, 12 Nov 2026 04:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794458680;
	bh=fcPJCRmdu+P6XyBizHpaGO0Fz97duxt+6ILfD0XU0ds=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kv4VyDNQ6uqKHUgZpKpkuhXmr7Fox7kh2uKjcSF8m+LT6YLxn2m79P3qMbHj3xmQd
	 9RGb+F6CupHotDntcKySsEhiYzUFko9lNq39kxUqA0Lyq6k29Qtf6+R/KaW8mualqX
	 YcbMqtQr8MVacZzR9qyoNI83m6RDXA2avtEZyGab5xS8yfdtxw0NfOxOQ1f9i/141Y
	 nFnjdPobXRyCl8BNgd+NrvyHS04KpnZ8XQO3cmc7Xt0N/6/iKgsII+hYpXSimOQJz1
	 wGF7TNjS+FbbovR5VGRcP3yKsXHTf2JXSgAqCSCOQXK0CayDBWGtJbDQwcO2FvRy3D
	 RwyS/lRyoQjDQ==
Message-ID: <sashiko-outbox-210383@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net v3 1/7] net/iucv: keep the window given to the
 peer in a field of its own
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261110-b4-disp-2a6b4364-v3-1-35677b68e697@proton.me>
References: <20261110-b4-disp-2a6b4364-v3-0-35677b68e697@proton.me>
 <20261110-b4-disp-2a6b4364-v3-1-35677b68e697@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 04:44:38 +0000
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
- [Medium] net/iucv: premature and unconditional msglimit_adv write in
  afiucv_hs_send()
--

commit 8534ba296d230681179bb7448129eaebb9ecfc26
Author: Bryam Vargas <hexlabsecurity@proton.me>

net/iucv: keep the window given to the peer in a field of its own

This commit records the receive window advertised in HiperSockets SYN and
SYN|ACK frames in a separate msglimit_adv field, and uses it in
iucv_sock_recvmsg() so later SO_MSGLIMIT changes do not alter window
accounting for that connection.

> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index ce13fe3c85b52..657c61161dbdc 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c

[ ... ]

> @@ -208,8 +222,11 @@ static int afiucv_hs_send(struct iucv_message *imsg,=
 struct sock *sock,
>  	phs_hdr->magic =3D ETH_P_AF_IUCV;
>  	phs_hdr->version =3D 1;
>  	phs_hdr->flags =3D flags;
> -	if (flags =3D=3D AF_IUCV_FLAG_SYN)
> +	if (flags =3D=3D AF_IUCV_FLAG_SYN) {
>  		phs_hdr->window =3D iucv->msglimit;
> +		/* what the peer may send us, whatever msglimit becomes */
> +		iucv->msglimit_adv =3D iucv->msglimit;
> +	}

[Severity: Medium]
Can setting iucv->msglimit_adv here cause it to diverge from the window the
peer actually received?

afiucv_hs_send() writes iucv->msglimit_adv before the device and MTU checks
and dev_queue_xmit(), and overwrites it on every AF_IUCV_FLAG_SYN call.
After a non-blocking or interrupted connect() sends a SYN and leaves
sk->sk_state as IUCV_BOUND, changing SO_MSGLIMIT and calling connect() again
overwrites iucv->msglimit_adv even if the peer's SYN|ACK to the first SYN is
already in flight or the second send fails with -ENETDOWN.  When the peer
sends frames up to the window from the first SYN, iucv_sock_recvmsg() then
hits WARN_ON(1), closes the socket and returns -EFAULT if SO_MSGLIMIT was
lowered, or fails to send AF_IUCV_FLAG_WIN updates if it was raised.

Similarly, if an initial connect() fails before transmitting a SYN and
SO_MSGLIMIT is changed before an incoming SYN|ACK connects the bound socket,
afiucv_hs_window() returns the stale msglimit_adv from the failed connect()
instead of iucv->msglimit.  In addition, iucv_sock_connect() checks
sk->sk_state before lock_sock(sk) without rechecking under the lock, so a
concurrent connect() can still enter afiucv_hs_send() and overwrite
iucv->msglimit_adv after the socket reaches IUCV_CONNECTED.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-b4-disp-2a=
6b4364-v3-0-35677b68e697@proton.me?part=3D1
