Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DE9223DE9
	for <linux-s390@vger.kernel.org>; Tue,  7 Jul 2026 03:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783394683; cv=none; b=AHIVeTkWW2m9bzfxgNiHIEjPwdX/TXWaGk4U8wyuAq7u+WBiIt2jr0/77AYl4wzYcDAQ/Ai0j3Zex0C1Gqn0+KR/Jl6DZjzriOoHmF85roQuTjnSoofpahsjWCJ22MpzW5g/y84W3u7lzLH3jYloQUiFAOt3KNZyJRCbaAj6URU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783394683; c=relaxed/simple;
	bh=mFQkYG6TqmpEunEBWNw3m5FRZKxs37kqn0qXBcZWq+g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J8ZYp0/gTlySDDWIJpIW6Fp10V822i8vqDF34lYJikGKs69ztWjhfNDt0qGNySdKG/XYzIocnvcb1qH2X1Czpddub3F3TvezVcFqZm7m0TjYLragTcJDzglbj1VDF7BndvD88HFsKfwfSQXQDxq3LSYXcqkesUGajzUsSRJvqjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvv1oL5I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvv1oL5I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FB31F00A3A;
	Tue,  7 Jul 2026 03:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783394681;
	bh=sBOeMQVqnwzQ1eE6R31oH8JOa6fGSwOTLbmB2mD9HlI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nvv1oL5I0ihi9SE3SfWbJxUY6kYhcXiyNkmZ1rraz87yy3FJQrriuwPjve2XnM2Pm
	 hVbHLgld7e//uM5v2FGSDfEzFn3VmA9LcBPCodQoE7QznXUgpFstNziJvBBlTwKr/c
	 gZpn133J0YY4SWOpDJZiod/zzIpzuq9dk+FvSMvjYuAAGy93CO9TGei5bVb4F7+e40
	 RyYc6ljWUEdwCOWgcldahYz+AsbD6addot0C8Pbv3rv6z75+FHrGcopAk3Wt4Lcng1
	 q95cseMTgfM4AKh0z9anARyYRcQm6HBRPkJzb9MGXv0nPAxlOB/QzdjOvVyplGaGj3
	 pTot2eak5pwkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net/iucv: take a reference on the socket found in
 afiucv_hs_rcv()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260705-b4-disp-fc79c0dc-v1-1-d2cdcb57afa9@proton.me>
References: <20260705-b4-disp-fc79c0dc-v1-1-d2cdcb57afa9@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 03:24:41 +0000
Message-Id: <20260707032441.B1FB31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] NULL Pointer Dereference in `afiucv_hs_callback_syn` error path.
- [High] Shared SKB Data Corruption by in-place modification.
- [High] Buffer Underflow panic due to unchecked `skb_push()`.
- [High] Memory leak of `message_q.list` elements on socket destruction.
- [High] Race Condition modifying socket state from softirq without checkin=
g `sock_owned_by_user()`.
--

commit 65314896d356a76bf086aa52125b656e444bcb3c
Author: Bryam Vargas <hexlabsecurity@proton.me>
Subject: net/iucv: take a reference on the socket found in afiucv_hs_rcv()

afiucv_hs_rcv() looks up the destination socket under iucv_sk_list.lock, dr=
ops
the lock, and passes the socket to handlers without holding a reference. Th=
is
commit takes a reference with sock_hold() while the socket is on the list a=
nd
releases it with sock_put() once the handler completes.

> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index fed240b453bd9..b85fb9767dec2 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c

[ ... ]

net/iucv/af_iucv.c:afiucv_hs_callback_syn() {
    nsk =3D iucv_sock_alloc(NULL, GFP_ATOMIC, sk->sk_type, sk->sk_protocol);
    if (!nsk) {
        ...
        goto out;
    }
...
out:
    iucv_sock_kill(nsk);
}

[Severity: High]
This is a pre-existing issue, but does this error path cause a NULL pointer
dereference when memory allocation fails?

If iucv_sock_alloc() returns NULL under memory pressure, we jump to the out
label and pass NULL to iucv_sock_kill().

net/iucv/af_iucv.c:iucv_sock_kill() {
    if (!sock_flag(sk, SOCK_ZAPPED) || sk->sk_socket)
        return;
...
}

Will iucv_sock_kill() immediately dereference the NULL sk pointer when chec=
king
the socket flags, causing a kernel panic?

[ ... ]

net/iucv/af_iucv.c:afiucv_hs_rcv() {
    ...
    trans_hdr =3D iucv_trans_hdr(skb);
    EBCASC(trans_hdr->destAppName, sizeof(trans_hdr->destAppName));
    EBCASC(trans_hdr->destUserID, sizeof(trans_hdr->destUserID));
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but does this in-place modificat=
ion
corrupt shared or cloned SKBs?

Since afiucv_hs_rcv() acts as a packet_type handler, the received SKB might=
 be
cloned or shared with other consumers. Should we be using skb_share_check()=
 or
skb_unshare() before destructively modifying the header with EBCASC()?

Similarly, in afiucv_swap_src_dest():

net/iucv/af_iucv.c:afiucv_swap_src_dest() {
    ...
    ASCEBC(trans_hdr->destUserID, sizeof(trans_hdr->destUserID));
    ...
}

Does this further modify the shared SKB payload in-place?

[ ... ]

net/iucv/af_iucv.c:afiucv_swap_src_dest() {
    ...
    skb_push(skb, ETH_HLEN);
    ...
}

[Severity: High]
This is a pre-existing issue, but does this skb_push() call cause a buffer
underflow panic?

When echoing packets back, this prepends a MAC header without verifying if =
the
SKB has sufficient headroom.

If a packet is injected locally or the incoming interface strips the MAC he=
ader
tightly, will the lack of skb_headroom() checks result in skb_under_panic()?

[ ... ]

net/iucv/af_iucv.c:iucv_sock_destruct() {
    ...
    skb_queue_purge(&sk->sk_receive_queue);
    skb_queue_purge(&sk->sk_error_queue);
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but does socket destruction leak
the dynamically allocated message_q.list items?

Incoming messages are allocated and appended to iucv->message_q.list in
iucv_callback_rx().

If the socket is destroyed before all messages are consumed by recvmsg(),
neither iucv_sock_destruct() nor iucv_sock_close() appears to iterate over =
and
free these elements:

net/iucv/af_iucv.c:iucv_sock_close() {
    ...
    skb_queue_purge(&iucv->send_skb_q);
    skb_queue_purge(&iucv->backlog_skb_q);
    ...
}

Could an abrupt disconnect permanently leak these unread items?

[ ... ]

net/iucv/af_iucv.c:afiucv_hs_callback_synack() {
    ...
    bh_lock_sock(sk);
    iucv->msglimit_peer =3D iucv_trans_hdr(skb)->window;
    sk->sk_state =3D IUCV_CONNECTED;
    sk->sk_state_change(sk);
    bh_unlock_sock(sk);
    ...
}

[Severity: High]
This is a pre-existing issue, but does modifying the socket state from a
softirq context corrupt the socket state machine?

Since this handler runs in softirq context when network packets arrive, it
acquires the socket spinlock and directly mutates sk->sk_state.=20

If a user process is concurrently executing a system call and holds the soc=
ket
mutex via lock_sock(), does bypassing the backlog mechanism by failing to c=
heck
sock_owned_by_user() cause race conditions?

[ ... ]

> @@ -2089,6 +2089,8 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struc=
t net_device *dev,
>  			}
>  		}
>  	}
> +	if (sk)
> +		sock_hold(sk);
>  	read_unlock(&iucv_sk_list.lock);
>  	if (!iucv)
>  		sk =3D NULL;
> @@ -2138,6 +2140,8 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struc=
t net_device *dev,
>  		kfree_skb(skb);
>  	}
> =20
> +	if (sk)
> +		sock_put(sk);
>  	return err;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705-b4-disp-fc=
79c0dc-v1-1-d2cdcb57afa9@proton.me?part=3D1
