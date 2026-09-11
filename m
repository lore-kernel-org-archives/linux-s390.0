Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C43A348896
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144187; cv=none; b=AwjBR5B6dfoUe5jwfxLvw/HJb2NMfl/Hn0FsSFwZslb9m/dkM10Gu45CSob0Hp3DpmBMj00VUZewnCtfWotCNQLtyyBtLrlpKOg4JL3uD80J8Iw/HFOE+XMcuoIIE5PR3xswnlJaC5QMSxJ50DOAHlf8QAEj/TGZQt3fHONwouw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144187; c=relaxed/simple;
	bh=fveB6SHDsCnPbgvUGBXKgSryT8Sm8Ie/4ozCvC+bfIY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KMiGyl15d7FKRDLazyvkaV7RrDxvyL96PcVuivz9HSSFKudPN7rgOiTwTE0ETAn590W6SefSHBX321vQfxVBKr9X5vSLe1ZccaX0xABmyv52hDqTAXdQBiIa/nOJNPXMuiH9wK22o+WlZ5GIaAWlzyc63MXgYl8g2ItgxCMHuNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3NGXYDP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3NGXYDP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92321F000FF;
	Fri, 11 Sep 2026 16:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789144186;
	bh=gbghJXWhObBJybEWNvNblfakapCc/xdsMe1BA2XqOs0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W3NGXYDPuq2w2Q5VOvCsZu4vOwTaSmQl1kzwfM9Riuq7WvGt5ll3VzswUkSxxNVAf
	 /Lwo4BeGzW1aKxl6/DFN9fb5Zd0OnjSJwwZBqIj8rT2h/BW0TXEXof4oF1+1P0rHjv
	 jCofeO3vLKrcAugYsqIqbbAlFRZm2N0Mmans5RgCZQVc41Sc9c+N28Frtx+HVxEdFv
	 0WfXjNuDILVbVI7rbt1W9cKdJcQSZRxbiJdXMtVHaVp+mWnnnvLuzw6j+TAOjXhvsu
	 b9aZ6NqTG6LeKBKVXmw7ZgSXlzCrL4lSktCf7QSYWOs3UYDjRIjTeiW1Msah1ueDdT
	 kNDxy7dR4hj5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next] net/iucv: Add lock nesting annotation in
 iucv_sock_close()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexandra Winter" <wintera@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260910162919.2100124-1-wintera@linux.ibm.com>
References: <20260910162919.2100124-1-wintera@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 16:29:45 +0000
Message-Id: <20260911162945.B92321F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Lockless traversal of accept_q causes list corruption and use-=
after-free due to concurrent modifications from softirq context.
- [High] Newly allocated sockets are permanently leaked on error paths beca=
use iucv_sock_kill() returns early if SOCK_ZAPPED is not set.
- [High] Child socket leak in iucv_sock_cleanup_listen due to late state up=
date leaving a race window.
- [High] Unprotected state modifications in iucv_callback_connack cause sta=
te desynchronization.
--

commit dd0ad2a384eeaa590848b51235abdb105f4560db
Author: Alexandra Winter <wintera@linux.ibm.com>

net/iucv: Add lock nesting annotation in iucv_sock_close()

This commit splits off __iucv_sock_close() to allow it to be called
without lock nesting. It also adds a lockdep annotation to
iucv_sock_close() to avoid a false-positive recursive locking warning.

> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index db261ecd19af1..dc906f5f7c42d 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c

[ ... ]

> @@ -302,7 +303,9 @@ static void iucv_sock_cleanup_listen(struct sock *par=
ent)
> =20
>  	/* Close non-accepted connections */
>  	while ((sk =3D iucv_accept_dequeue(parent, NULL))) {

[Severity: Critical]
This is a pre-existing issue, but I have a question about how
iucv_accept_dequeue() is interacting with the softirq context here.

Does lockless traversal of accept_q cause list corruption or use-after-free
due to concurrent modifications from softirq context?

iucv_accept_dequeue() (and iucv_accept_poll()) traverses the accept_q list
using list_for_each_entry_safe() without holding accept_q_lock:

net/iucv/af_iucv.c:iucv_accept_dequeue() {
    ...
	list_for_each_entry_safe(isk, n, &iucv_sk(parent)->accept_q, accept_q) {
    ...
}

Concurrently, an incoming connection triggers iucv_callback_connreq() in
softirq, which acquires accept_q_lock via iucv_accept_enqueue() and modifies
the list using list_add_tail(). Since list_for_each_entry_safe() is not safe
against concurrent modifications from another context, does this result in a
data race and list corruption when poll() or accept() are called?

> -		iucv_sock_close(sk);
> +		lock_sock(sk);
> +		__iucv_sock_close(sk);
> +		release_sock(sk);
>  		iucv_sock_kill(sk);
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but looking at the loop above,
could this leave a race window where child sockets are permanently leaked?

iucv_sock_cleanup_listen() drains the accept_q completely, but since it is
executed under lock_sock(parent) (which releases the slock spinlock), could
a softirq executing iucv_callback_connreq() concurrently enqueue a new
socket?

Since parent->sk_state =3D IUCV_CLOSED is updated after the loop finishes:

net/iucv/af_iucv.c:iucv_sock_cleanup_listen() {
    ...
	while ((sk =3D iucv_accept_dequeue(parent, NULL))) {
		lock_sock(sk);
		__iucv_sock_close(sk);
		release_sock(sk);
		iucv_sock_kill(sk);
	}

	parent->sk_state =3D IUCV_CLOSED;
}

Can a softirq successfully enqueue a new child socket to accept_q just as t=
he
loop terminates, leaving it leaked forever since iucv_sock_destruct() does
not purge accept_q?


[Severity: High]
This is another pre-existing issue, but does iucv_sock_kill() silently leak
newly allocated sockets on error paths?

In error paths, newly allocated sockets are passed to iucv_sock_kill():

net/iucv/af_iucv.c:iucv_callback_connreq() {
    ...
	if (err) {
		iucv_sever_path(nsk, 1);
		iucv_sock_kill(nsk);
		goto fail;
	}
    ...
}

And also in afiucv_hs_callback_syn():

net/iucv/af_iucv.c:afiucv_hs_callback_syn() {
    ...
	err =3D dev_queue_xmit(skb);
	if (!err) {
		...
	} else
		iucv_sock_kill(nsk);
    ...
}

Since iucv_sock_alloc() creates sockets with the SOCK_ZAPPED flag cleared,
and iucv_sock_kill() returns early if !sock_flag(sk, SOCK_ZAPPED), doesn't
this mean the socket is left forever in iucv_sk_list without its reference
being dropped? Could this allow a remote unauthenticated user to cause a
Denial of Service via memory exhaustion by spamming SYN requests?

> =20
> @@ -394,15 +397,16 @@ static int iucv_send_ctrl(struct sock *sk, u8 flags)
>  	return err;
>  }
> =20
> -/* Close an IUCV socket */
> -static void iucv_sock_close(struct sock *sk)
> +/**
> + * __iucv_sock_close() - close socket, caller holds lock_sock(sk)
> + * @sk: network socket
> + */
> +static void __iucv_sock_close(struct sock *sk)
>  {
>  	struct iucv_sock *iucv =3D iucv_sk(sk);
>  	unsigned long timeo;
>  	int err =3D 0;
> =20
> -	lock_sock(sk);
> -
>  	switch (sk->sk_state) {

[Severity: High]
This isn't a bug introduced by this patch, but could unprotected state
modifications in iucv_callback_connack() cause state desynchronization
and resource leaks?

iucv_callback_connack() executes in interrupt context when the peer accepts
a connection, and it directly modifies the socket state without acquiring
bh_lock_sock(sk):

net/iucv/af_iucv.c:iucv_callback_connack() {
    ...
	sk->sk_state =3D IUCV_CONNECTED;
	sk->sk_state_change(sk);
    ...
}

Since this write is unprotected, can it race with other operations (like
__iucv_sock_close() checking sk->sk_state here) that are concurrently
transitioning the socket to IUCV_CLOSING or IUCV_CLOSED under lock_sock(sk)?
Would this blindly overwrite the state with IUCV_CONNECTED during a
concurrent teardown sequence, leaving the socket in an inconsistent state
forever?

>  	case IUCV_LISTEN:
>  		iucv_sock_cleanup_listen(sk);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910162919.2100=
124-1-wintera@linux.ibm.com?part=3D1
