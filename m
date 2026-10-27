Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793069425;
	b=t+ot4aZbReBSBhJzW7XU6RXt7VgrKaWzp8x2nxFyexsXJuWz17XlTvMFfeW4Sr+9hUeL
	 9MHyrzQQci/bo4SIJhd9UpjUpWt0nRXAqzdKVLooEgwIA5JZLVvuPwvfLVJeVS7Yh+9oT
	 JpMTwpKY9jA+ucEGXmxw1S+ZGeRYzD0O+Ozq6OQuI66GOJR7HV4NS5dVF6lws8J//2t4d
	 3A0GPYKEbgBh7a7EUWaM7ZPVKFhzbLkd0DyLSjodBKdG7wChsANvPQ4DJHRj8Uu8M2VO4
	 kv5RsEpbiMIZ4dSOnOwt+N3lbfJwpTD92bfqspn7fe+/cC6YBLhbApsXuTs58WH5IRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793069425;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=xruDv2a3bHWNqXV8RGWxU+fquzBodGLGa5mXEY4Eiog=;
	b=GH95jV9O5Ub4ojm9dQr/SdFzwSM2rBa9+tNZEzKosrNGYHuV7wdRAd1I0AHwt0D2PLkb
	 KYKLaIt0bep6TXQFyliOlTq4m9ziLrWRdV+kkIjM3UTjexDuKIGSfQnV1iK5gQv1RROEK
	 OyPog8v9CVU+andYiCXAtV2yPKWfIDGZ1gOfbxXM//d9dz1X3/YJqC0vPKGZky5mAEPEZ
	 TmtLstLO4HixhWYBY6GXN9M0+iCZBMZgHSDAoleuxdTUCznI97PCmxDGn9TB94P1TauGQ
	 6P/d+fEK3WB9jtiwao/blgG3ZKCTMp9HOc/DVAnOOXunVldUiOmax0ihhhmhBBNvGzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QG9svXiu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DECB606A31A;
	Tue, 27 Oct 2026 02:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QG9svXiu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B9D1F01825;
	Tue, 27 Oct 2026 02:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793069424;
	bh=xruDv2a3bHWNqXV8RGWxU+fquzBodGLGa5mXEY4Eiog=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QG9svXiucGO/wO7RfIXOafyEtyGQSuvWea5zHZ+nm3mAMKp9+JdVsP08c2kUbazks
	 HxNfony/+gr7E+vLH0Iq1rMcSoRlDfyt5fO7D/OwqTFt3eWFImis13lUiqewnq6gH5
	 YcR5fImAri/wk71DY2W84GBtae05nQSgyeiUXfK+22eOzLPtQ40yGMruBPPS680oMH
	 4TcqysXhdvqJzdr+FhKTFs7EI57fok4ENX/riASJ/x2eeNwCJ7EYw038xj14FoDZQK
	 xFadJcZ/SyC3QY3eJyjOk4QgkvTU1H84cHI3PCpSy+FG3/5YNRd6UrcrIEia6Kk5jW
	 hyFVbmk0fnbDA==
Subject:
 Re: [PATCH net 1/2] net/iucv: clear hs_dev before dropping its reference
From: netdev-bot+sashiko@kernel.org
To: hexlabsecurity@proton.me
Cc: edumazet@kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, wintera@linux.ibm.com, twinkler@linux.ibm.com,
 nagamani@linux.ibm.com, netdev@vger.kernel.org, hidayath@linux.ibm.com,
 linux-s390@vger.kernel.org, horms@kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 27 Oct 2026 02:50:23 +0000
Message-ID: <179306942370.3134.2152050460964282662@kernel.org>
In-Reply-To: <20261022-b4-disp-b35a9153-v1-1-d74645876195@proton.me>
References: <20261022-b4-disp-b35a9153-v1-1-d74645876195@proton.me>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (3) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In afiucv_hs_callback_syn(), the child now takes a reference
  on skb->dev every time, instead of copying the listener's hs_dev.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  afiucv_netdev_event() walks iucv_sk_list with sk_for_each() and holds…
- [High] This problem wasn't introduced by this patch, but
  afiucv_hs_callback_syn() leaks the child socket it allocates on every…
- [High] This problem wasn't introduced by this patch, but the SYN
  callback can publish a child into a listener's accept_q while that…

--

net/iucv: clear hs_dev before dropping its reference

This patch changes iucv_sock_close() so that iucv->hs_dev is cleared
before dev_put(). It also marks the racing hs_dev and sk_bound_dev_if
accesses with READ_ONCE()/WRITE_ONCE(). Finally, afiucv_hs_callback_syn()
now takes the child's device reference and sk_bound_dev_if from skb->dev
instead of from the listener's fields.

Closes: https://lore.kernel.org/netdev/b3fea2ca-25ff-42c0-812c-f8cc6bb6667e@linux.ibm.com/

> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index db261ecd19af1..501e758c5e68a 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -447,9 +447,16 @@ static void iucv_sock_close(struct sock *sk)
>  	}
>  
>  	if (iucv->hs_dev) {
> -		dev_put(iucv->hs_dev);
> -		iucv->hs_dev = NULL;
> -		sk->sk_bound_dev_if = 0;
> +		struct net_device *dev = iucv->hs_dev;
> +
> +		/* afiucv_hs_rcv() matches frames on hs_dev under
> +		 * iucv_sk_list.lock, not the socket lock: clear it before the
> +		 * reference goes, so the match can no longer find a device
> +		 * this socket does not hold.
> +		 */
> +		WRITE_ONCE(iucv->hs_dev, NULL);
> +		WRITE_ONCE(sk->sk_bound_dev_if, 0);
> +		dev_put(dev);
>  	}

[Severity: High]
This is a pre-existing issue, but afiucv_netdev_event() also reads this
field, and it holds neither iucv_sk_list.lock nor the socket lock:

net/iucv/af_iucv.c:afiucv_netdev_event() {
    ...
	case NETDEV_GOING_DOWN:
		sk_for_each(sk, &iucv_sk_list.head) {
			iucv = iucv_sk(sk);
			if ((iucv->hs_dev == event_dev) &&
			    (sk->sk_state == IUCV_CONNECTED)) {
				if (event == NETDEV_GOING_DOWN)
					iucv_send_ctrl(sk, AF_IUCV_FLAG_FIN);
    ...
}

iucv_sock_close() runs under lock_sock() only. Can it move the socket out
of IUCV_CONNECTED and run this clear after the notifier's check but before
its call to iucv_send_ctrl()?

iucv_send_ctrl() reads hs_dev again and uses it without a NULL check:

	blen = sizeof(struct af_iucv_trans_hdr) +
	       LL_RESERVED_SPACE(iucv->hs_dev);

The list walk itself also looks unprotected. iucv_sock_link() and
iucv_sock_unlink() change the list under write_lock_bh(&iucv_sk_list.lock),
and rtnl does not exclude them.

Could a concurrent close() followed by iucv_sock_kill() unlink and free
the node the notifier is on?

Once this patch is applied, the notifier is the only unlocked,
unannotated reader of hs_dev left. The notes below the commit message
leave it to Nagamani PV's "net/iucv: fix races in afiucv_netdev_event()".

[ ... ]

> @@ -1912,9 +1919,14 @@ static int afiucv_hs_callback_syn(struct sock *sk, struct sk_buff *skb)
>  	memcpy(niucv->dst_user_id, trans_hdr->srcUserID, 8);
>  	memcpy(niucv->src_name, iucv->src_name, 8);
>  	memcpy(niucv->src_user_id, iucv->src_user_id, 8);
> -	nsk->sk_bound_dev_if = sk->sk_bound_dev_if;
> -	niucv->hs_dev = iucv->hs_dev;
> -	dev_hold(niucv->hs_dev);
> +	/* skb->dev is the device the lookup matched against the listener's
> +	 * hs_dev; the listener's own fields are cleared by close() under
> +	 * lock_sock(), which this softirq does not hold. nsk is in
> +	 * iucv_sk_list already: hold, then publish.
> +	 */
> +	WRITE_ONCE(nsk->sk_bound_dev_if, skb->dev->ifindex);
> +	dev_hold(skb->dev);
> +	WRITE_ONCE(niucv->hs_dev, skb->dev);

[Severity: Medium]
Can this leak a reference on skb->dev when the SYN races with close() of
the listener?

The callback holds only bh_lock_sock(sk). That does not exclude
iucv_sock_close() of the listener, which holds lock_sock(), and the
callback never checks sock_owned_by_user(). This sequence looks possible:

CPU1 (softirq)
afiucv_hs_callback_syn()
  bh_lock_sock(sk);
  sk->sk_state == IUCV_LISTEN, check passes

CPU2 (process context)
iucv_sock_close(listener)
  iucv_sock_cleanup_listen()
    drains accept_q
  WRITE_ONCE(iucv->hs_dev, NULL);
  dev_put(dev);

CPU1
  dev_hold(skb->dev);
  WRITE_ONCE(niucv->hs_dev, skb->dev);
  dev_queue_xmit(skb);
  iucv_accept_enqueue(sk, nsk);
  nsk->sk_state = IUCV_CONNECTED;

The child then sits in IUCV_CONNECTED on the accept_q of a listener that
has already been drained. Nothing accepts, closes or kills it.

Before this patch, the callback read the listener's hs_dev as NULL in
this interleaving, so dev_hold(NULL) did nothing and only the struct sock
leaked. Now the child holds the ingress device.

In the other interleaving, where hs_dev was read before the clear, the
old code already leaked the listener's device reference. This change
extends the device leak to the case that used to leak only the sock.

afiucv_netdev_event() does nothing on NETDEV_UNREGISTER. On
NETDEV_GOING_DOWN it only moves the child to IUCV_DISCONN.

Would unregister_netdevice() of that HiperSockets device then wait
forever in netdev_wait_allrefs()?

The notes below the commit message mention this orphaned child, and
that it now holds the device the frame arrived on.

>  	afiucv_swap_src_dest(skb);
>  	trans_hdr->flags = AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_ACK;
>  	trans_hdr->window = niucv->msglimit;

[Severity: High]
This isn't a bug introduced by this patch, but does
afiucv_hs_callback_syn() leak the child socket nsk on every refused SYN?

iucv_sock_alloc() runs before any of the checks. It clears SOCK_ZAPPED
and links nsk into iucv_sk_list:

net/iucv/af_iucv.c:iucv_sock_alloc() {
    ...
	sock_reset_flag(sk, SOCK_ZAPPED);

	sk->sk_protocol = proto;
	sk->sk_state	= IUCV_OPEN;

	iucv_sock_link(&iucv_sk_list, sk);
    ...
}

Two branches call iucv_sock_kill(nsk): the refusal branch (listener not
in IUCV_LISTEN, or sk_acceptq_is_full()) and the dev_queue_xmit() failure
branch. iucv_sock_kill() returns at once for a socket that is not zapped:

net/iucv/af_iucv.c:iucv_sock_kill() {
	if (!sock_flag(sk, SOCK_ZAPPED) || sk->sk_socket)
		return;
    ...
}

So nsk is never unlinked or freed. A HiperSockets peer can keep sending
SYNs to a bound socket, or to a listener with a full backlog. Each leaked
entry also makes the sk_for_each() walk in afiucv_hs_rcv() longer.

On the dev_queue_xmit() failure branch, the leaked child has already done
dev_hold(skb->dev) above.

Can that reference also block unregister_netdevice() of the ingress
device forever?

The notes below the commit message say Hidayath Khan reported this in
August and that his fix is pending.

[Severity: High]
This is a pre-existing issue, but can the child be published into the
listener's accept_q while the listener is being torn down, and then be
handled before it is fully set up?

The callback holds only bh_lock_sock(sk), while iucv_sock_close() holds
lock_sock(sk). iucv_accept_enqueue() makes the child visible before it
sets the child's parent:

net/iucv/af_iucv.c:iucv_accept_enqueue() {
    ...
	spin_lock_irqsave(&par->accept_q_lock, flags);
	list_add_tail(&iucv_sk(sk)->accept_q, &par->accept_q);
	spin_unlock_irqrestore(&par->accept_q_lock, flags);
	iucv_sk(sk)->parent = parent;
	sk_acceptq_added(parent);
}

iucv_sock_cleanup_listen() calls iucv_accept_dequeue(parent, NULL). That
function walks accept_q without accept_q_lock and, with newsock == NULL,
takes any child whatever its state. It then calls iucv_accept_unlink():

net/iucv/af_iucv.c:iucv_accept_unlink() {
    ...
	struct iucv_sock *par = iucv_sk(iucv_sk(sk)->parent);

	spin_lock_irqsave(&par->accept_q_lock, flags);
    ...
}

sk_alloc() zeroes the sock, so parent is still NULL if the store in
iucv_accept_enqueue() has not happened yet.

Is that a NULL pointer dereference?

If the parent store has happened, cleanup goes on to iucv_sock_close()
and iucv_sock_kill() the child, which drops both references. The callback
then still does:

		iucv_accept_enqueue(sk, nsk);
		nsk->sk_state = IUCV_CONNECTED;

Would the write to nsk->sk_state then be a use-after-free?

The commit message leaves the case of a SYN accepted while the listener
closes to the socket-locking rework.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022-b4-disp-b35a9153-v1-0-d74645876195%40proton.me
