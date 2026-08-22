Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9674346E67
	for <linux-s390@vger.kernel.org>; Sat, 22 Aug 2026 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787397460; cv=none; b=n15AsPvFiLBPq6YC3sgJCvk0zieeBqnzC+XOVa22y1yjiDuauPcKY2HUf2R6JD7WworM0HEStgHqC/Pj1PX3DKtSc91Nb8kOyyubY8BxT6v5W4Ljdde/4tZj01yvEWRMNLuvC1whPqGVDPEoxollkfuxt/RAI4BlQPhVrFgNKcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787397460; c=relaxed/simple;
	bh=hc2njnwhE2BdZC8uozgVpCjCArniERp3f7lqh49oDfI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nBC+1w6Oyx3TZpgj9YZq2ivZv9In1+QSpd70LvjbFJyuXCNrYbmgj+ySs3xJAewADDK9lxLyUU25/8dOkuVuxKzRN5CB0BZZpXHs5DyO1S12jU95+pkrzTPluE7f3pdgVPMOXq1GZOqbAMNVbIHpEuW1Yo9me5zMKtz90QtqXqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuTu9v0i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuTu9v0i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E771F00A3A;
	Sat, 22 Aug 2026 11:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787397458;
	bh=YmsDItaIZ54Xm30EjytbsgtAKKpmWMl8X7UNJSILHJk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TuTu9v0is4xYU59ZwP4196VDLJOVSNB+dtRZB1ZoduyFWzEtymGlC5/eScLx8ia30
	 2BUEn8/hy4re11rKQHlbiE4beehtZ7wrgVoOC1D0ZXR88+5dNGOKcm0YZVla1jpbBz
	 j7NjzdVZSBKkBGEgHkUNRdhie18Siu6pqSM3nm2FNMrlaDa9udPq8l7FpaULwaA4ZZ
	 xil4H0xZWds/kGfo4u7XgZtwQQXS9Wcv1+wbZlMRWlyMlnZGI63NVJ21XcRdCCh77R
	 /FTpsRBtiKEkHV3HElHBaGsxA/x7JUHYqPwDXGgJ/OchUtu9VQNJlYfQvAlN9rXUqH
	 JSOry8k9uvEfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 2/3] net/iucv: claim the receive credit
 atomically
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260821-b4-disp-3a6e8695-v2-2-37597ff723a8@proton.me>
References: <20260821-b4-disp-3a6e8695-v2-0-37597ff723a8@proton.me>
 <20260821-b4-disp-3a6e8695-v2-2-37597ff723a8@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 11:17:38 +0000
Message-Id: <20260822111738.62E771F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Positive network drop errors leak to userspace as partial success
- [High] Silent data loss for SOCK_STREAM when packet length exceeds MTU
--

--- Patch [2]: [PATCH net v2 2/3] net/iucv: claim the receive credit atomic=
ally ---
commit 20117da9fdf439cdc2d9a9928d88d8e19d4f0e83
Author: Bryam Vargas <hexlabsecurity@proton.me>

net/iucv: claim the receive credit atomically

This commit addresses a race condition in the af_iucv HiperSockets
transport where the receive credit counter could be subtracted multiple tim=
es.
It modifies the code to claim the window using atomic_xchg() right before
queueing the packet to ensure the counter reads zero while the transmit
is in flight.

> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index 0bc4a15f4b565..492a45bb2bba6 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c

[ ... ]

> @@ -250,13 +244,22 @@ static int afiucv_hs_send(struct iucv_message *imsg=
, struct sock *sock,
>  	}
>  	skb->protocol =3D cpu_to_be16(ETH_P_AF_IUCV);

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential issue =
with
the MTU check just above this line in afiucv_hs_send():

	if (skb->len > skb->dev->mtu) {
		if (sock->sk_type =3D=3D SOCK_SEQPACKET) {
			err =3D -EMSGSIZE;
			goto err_free;
		}
		err =3D pskb_trim(skb, skb->dev->mtu);
		if (err)
			goto err_free;
	}

For SOCK_STREAM sockets, if the packet is larger than the MTU, the skb is
silently truncated via pskb_trim().

However, iucv_sock_sendmsg() isn't aware of this truncation and returns the=
 full
original length to userspace on success:

	err =3D afiucv_hs_send(&txmsg, sk, skb, 0);
	...
	release_sock(sk);
	return len;

Does this result in silent data loss, since userspace believes the entire b=
uffer
was successfully sent?

> =20
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
>  	if (net_xmit_eval(err)) {
>  		atomic_dec(&iucv->skbs_in_xmit);
> -	} else {
> -		atomic_sub(confirm_recv, &iucv->msg_recv);
> -		WARN_ON(atomic_read(&iucv->msg_recv) < 0);
> +		atomic_add(confirm_recv, &iucv->msg_recv);
>  	}
>  	return net_xmit_eval(err);

[Severity: High]
This is a pre-existing issue, but I wanted to ask about the return value he=
re.

When dev_queue_xmit() drops a packet, it returns NET_XMIT_DROP (0x01).
net_xmit_eval() translates NET_XMIT_DROP to 1, and returning this positive =
value
propagates to iucv_sock_sendmsg().

Since iucv_sock_sendmsg() passes positive error codes back to the socket la=
yer:

	err =3D afiucv_hs_send(&txmsg, sk, skb, 0);
	if (err) {
		atomic_dec(&iucv->msg_sent);
		goto out;
	}

Could sys_sendmsg interpret the return value of 1 as 1 byte successfully se=
nt,
causing userspace to incorrectly assume partial success and potentially ent=
er
an infinite loop retrying the remaining data?

Should this be returning net_xmit_errno(err) instead of net_xmit_eval(err)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-b4-disp-3a=
6e8695-v2-0-37597ff723a8@proton.me?part=3D2
