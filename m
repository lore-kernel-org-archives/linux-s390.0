Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3E637FF47
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 19:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711070; cv=none; b=kZrZobqvGjt70Uq1WqFpBnI/yZNg8JpI3VrDJWs89Ouf1TWApmBhtoPqgya6EXvkq0suWl6iM9jdIEqnryZ+zfI00n6+n32sLRF+Vjvamn12OMfGilLjTwKM2TMgFB9psyQtIVGyFw10NzW+FWdPxAnE51I5DJP7Wa6y8MJgGUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711070; c=relaxed/simple;
	bh=8SvHQiiE/6i1UCg1Q0UWnDTS081ZZ4628qoGXqzCbi8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=taAClBU+kzmd/2T3Bzh7KcKM7d3jxoz/UVHoiZLWPy8aqvewjDnGmVcIgWwkTX37IwdfUR5HssbfQCjWd1WCqxxzNyhNcbwVZBxbJd5nvfOoRzI0Ol0Dt6tOhYzoE0x2z1j5krGwco79zNhn+nZAgCTOunwj6VVgVoezBzeOVg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WN4NblCQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WN4NblCQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D651F000E9;
	Fri, 10 Jul 2026 19:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783711069;
	bh=PFngFLxk/qUqIyOf6A1eKm6noo+w/17BsJuGfxjmRPY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WN4NblCQDISQ89+Bw53yK8NKuOSnfdc6ogZhvqfSWYmP+YEiVnWTeJf3MwgwF2pn6
	 ioGqfLSaLVzh8NHzzJideI0gun9Zo192mUy7pzCEgrzeXzDRqNI3QBprO9jW7bu9m3
	 LlnU2sfI911u4XBr1ZsaI8Jn1jbEt9MblHgoszsS06jjhf9h7oTRnFjIkJcS4s6dUb
	 TCXJH05SP9Dt+dCyinsZgQDAFv4wNg7SBrDLFd3LDNtJ/b8wcKAzsF37Wm1+1igOBu
	 maFQ1g0ZfN6FYmA7PaZAD3VOqItORBlEFRsDTKb4yUjtTuJ230mh0RAh4NPGoYp865
	 gOPD4GkqC+smQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net/af_iucv: fix NULL deref in
 afiucv_hs_callback_syn()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hidayath Khan" <hidayath@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260709191732.124092-1-hidayath@linux.ibm.com>
References: <20260709191732.124092-1-hidayath@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 19:17:48 +0000
Message-Id: <20260710191748.E2D651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Newly allocated sockets and their pinned net_devices are permanent=
ly leaked on error paths because iucv_sock_kill() ignores sockets without t=
he SOCK_ZAPPED flag.
- [High] Missing socket reference count (sock_hold) when searching the glob=
al socket list leads to a Use-After-Free vulnerability.
- [High] In-place modification of potentially shared/cloned SKBs corrupts d=
ata for concurrent consumers, and missing headroom checks cause panics.
- [High] Unlocked traversal of the accept_q leads to list corruption and da=
ta races.
--

--- Patch [1]: [PATCH net] net/af_iucv: fix NULL deref in afiucv_hs_callbac=
k_syn() ---
commit df9d50569da59293e9b6bc6ce2e2ee48847f1ed8
Author: Hidayath Khan <hidayath@linux.ibm.com>

net/af_iucv: fix NULL deref in afiucv_hs_callback_syn()

afiucv_hs_callback_syn() allocates the child socket with GFP_ATOMIC.
If the allocation fails, nsk is NULL. The connection-refused path
unconditionally calls iucv_sock_kill(nsk), resulting in a NULL pointer
dereference, which this patch fixes by checking if nsk is valid.

> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index fed240b453bd9..f5b1ec44b6ae3 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -1872,7 +1872,8 @@ static int afiucv_hs_callback_syn(struct sock *sk, =
struct sk_buff *skb)

[Severity: High]
This is a pre-existing issue, but is there a missing reference count when
looking up sockets?

In afiucv_hs_rcv(), the socket is found and the list lock is dropped without
acquiring a reference:

net/iucv/af_iucv.c:afiucv_hs_rcv() {
    ...
    read_unlock(&iucv_sk_list.lock);
    if (!iucv)
        sk =3D NULL;
    ...
    err =3D afiucv_hs_callback_syn(sk, skb);
}

Could another CPU concurrently close and destroy the socket, causing a
use-after-free when afiucv_hs_callback_syn() calls bh_lock_sock(sk)?

>  		afiucv_swap_src_dest(skb);

[Severity: High]
This isn't a bug introduced by this patch, but does afiucv_swap_src_dest()
safely modify the SKB?

The SKB payload is modified in-place, but there is no check to ensure
exclusive ownership:

net/iucv/af_iucv.c:afiucv_hs_rcv() {
    ...
    trans_hdr =3D iucv_trans_hdr(skb);
    EBCASC(trans_hdr->destAppName, sizeof(trans_hdr->destAppName));
    ...
}

Could this corrupt packet data for concurrent consumers if the SKB is shared
or cloned?

Additionally, afiucv_swap_src_dest() unconditionally pushes into the SKB
headroom:

net/iucv/af_iucv.c:afiucv_swap_src_dest() {
    ...
    skb_push(skb, ETH_HLEN);
    memset(skb->data, 0, ETH_HLEN);
}

If an untrusted packet is received with 0 headroom, will this cause an
skb_under_panic?

>  		trans_hdr->flags =3D AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_FIN;
>  		err =3D dev_queue_xmit(skb);
> -		iucv_sock_kill(nsk);
> +		if (nsk)
> +			iucv_sock_kill(nsk);

[Severity: High]
This is a pre-existing issue, but does iucv_sock_kill() actually clean up t=
he
socket here?

When iucv_sock_alloc() creates the socket, the SOCK_ZAPPED flag is cleared.
However, iucv_sock_kill() immediately returns if SOCK_ZAPPED is not set:

net/iucv/af_iucv.c:iucv_sock_kill() {
    if (!sock_flag(sk, SOCK_ZAPPED) || sk->sk_socket)
        return;
    ...
}

Does this mean newly allocated sockets and their pinned net_devices are
permanently leaked on this error path?

>  		bh_unlock_sock(sk);
>  		goto out;
>  	}

[Severity: High]
This is a pre-existing issue, but is the accept queue safely protected agai=
nst
concurrent modifications?

In iucv_accept_dequeue(), the queue is traversed without holding
accept_q_lock:

net/iucv/af_iucv.c:iucv_accept_dequeue() {
    ...
    list_for_each_entry_safe(isk, n, &iucv_sk(parent)->accept_q, accept_q) {
    ...
}

Meanwhile, iucv_accept_enqueue() modifies the same list from softirq context
using the lock:

net/iucv/af_iucv.c:iucv_accept_enqueue() {
    ...
    spin_lock_irqsave(&par->accept_q_lock, flags);
    list_add_tail(&iucv_sk(sk)->accept_q, &par->accept_q);
    spin_unlock_irqrestore(&par->accept_q_lock, flags);
}

Since lock_sock(parent) does not block softirqs from acquiring bh_lock_sock,
can iucv_accept_enqueue() run concurrently and corrupt the list pointers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709191732.1240=
92-1-hidayath@linux.ibm.com?part=3D1
