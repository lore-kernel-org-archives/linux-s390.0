Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793594856;
	b=wxJFZY614ewNYAGV17w45XK7VT7dbYYj6pIQ+Kc1SwDc2T7sT9jo70FIvfj+uHVkDGcK
	 9A2ZEw6asryOp/aXV9m11UALw3/qh8Kc6M4+SgpeC5CogVToOXJwuInJ8mlXGl1K19HYp
	 z8j00bKyR3FXR6bGd7o82QVO8/EfbNPKB51spB7ZjLMoAtqAOD+gm1leTVoIBhhb8YTuo
	 gpP9GwGk+grmJou8LcG3dy+wxXG/zcVqwtrVSezsW0IeYFitTbOa2VuZaw3y4QsViOai+
	 HtNb5eYHTim+Axxxv+cIgbjOIq2qaerWMJ91QBCLGvWzGN4IdMTumlLCLmbJ5IZmcjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793594856;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=phz6cV4352AYCVoVzl3w++aGmHhAYFGjNLqr6kwT9W4=;
	b=aWYQ+8VXxcryGqE9wgmiM3ipQaMtf/hlP9O9a/ww8HftrJHzFsk+i7rpre1nmR7gSMDS
	 OEy9g0QvHCuYN9WxxQCym+db+HYg9csrk3TIdHKfx9eRNSFqC7VHuI7Mz8T66QBvMdLxx
	 ONEoT/jWiGW9grJqBXdavw4boTQsbXaQ1tfALTz8O1sAhSK0tx7R4PByWG4fQZK2w02YY
	 fH0ejImeE61UMxPqjuC0RzkBpqouTCoEanoPa6NcAicT4L1UUJ3GwEcLelVamFKie3nQ0
	 ivdwQzNkmMMrZx99lP60Ed+hFg0rCJd39jHmP6D4QE9zan4sZ7DEq3dnKexnS11T2jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lo6lD3Xw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F8C606A324;
	Mon,  2 Nov 2026 04:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lo6lD3Xw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89461F000C1;
	Mon,  2 Nov 2026 04:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793594855;
	bh=phz6cV4352AYCVoVzl3w++aGmHhAYFGjNLqr6kwT9W4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lo6lD3XwA4Quunz8AaEeBCfdKC1N1j8raKlpQw1Sp7NintqZfpmtwtkXqLCgaKBXV
	 tj4duF3MR3pE9z1w5M+IWipCqgRKOWTKRJji19dS8frzIIYsyxn6y4BazCEQZffEQ+
	 Z1lMtRebqrYwiR6imvMWdThhLzJJ8sJUMEQNKFXXbWe+a8rEBHUprtqP5DxkGvtgX3
	 B9MhsjcXgGLz2JeNSXzjXensx76fqc8otVhcNyz1BTLjH04hreMmHpTUplSoIKNQI5
	 kcz3aWz98oTfW0aohuII/uuxhXXJ+lhQaxdQOWiZB2eFZRCGcTY4okRJjzdXHMJl9j
	 ZOAyz1oK07+sA==
Subject:
 Re: [PATCH net v2 1/2] net/iucv: clear hs_dev before dropping its reference
From: netdev-bot+sashiko@kernel.org
To: hexlabsecurity@proton.me
Cc: twinkler@linux.ibm.com, davem@davemloft.net, kuba@kernel.org,
 wintera@linux.ibm.com, edumazet@kernel.org, pabeni@redhat.com,
 linux-s390@vger.kernel.org, nagamani@linux.ibm.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, hidayath@linux.ibm.com,
 horms@kernel.org
Date: Mon, 02 Nov 2026 04:47:34 +0000
Message-ID: <179359485426.3131.5871050350296378168@kernel.org>
In-Reply-To: <20261028-b4-disp-dd3e4ebb-v2-1-3747658d59bd@proton.me>
References: <20261028-b4-disp-dd3e4ebb-v2-1-3747658d59bd@proton.me>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (2) · Medium: 2 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The clear-before-put reorder in __iucv_sock_close() does not
  give the guarantee its new comments describe.
- [Medium] afiucv_hs_callback_syn() now always takes a device reference
  from skb->dev (line 1936) instead of copying the listener's hs_dev.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  afiucv_hs_callback_syn()'s error paths leak the child socket, and on…
- [High] This problem wasn't introduced by this patch, but
  afiucv_netdev_event() can dereference a NULL hs_dev.
- [Medium] afiucv_hs_callback_syn() checks the raw dev_queue_xmit()
  result with `if (!err)` (lines 1942-1948).

--

net/iucv: clear hs_dev before dropping its reference

This patch changes __iucv_sock_close() to clear iucv->hs_dev and
sk_bound_dev_if before calling dev_put(). It marks the accesses that race
with the afiucv_hs_rcv() lookup with READ_ONCE()/WRITE_ONCE(). It also
changes afiucv_hs_callback_syn() to take the child's device and ifindex
from skb->dev instead of from the listener's fields.

Closes: https://lore.kernel.org/netdev/b3fea2ca-25ff-42c0-812c-f8cc6bb6667e@linux.ibm.com/

> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index 5ba875798aa41..5bab6aea910e1 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -450,9 +450,16 @@ static void __iucv_sock_close(struct sock *sk)
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

[Severity: Medium]
Does this ordering give the guarantee the comment describes? The clear
and the dev_put() run under lock_sock(sk) only. afiucv_hs_rcv() reads
hs_dev under read_lock(&iucv_sk_list.lock), which this path never takes,
so the two sides don't exclude each other:

CPU1 (softirq)                        CPU2 (process context)
afiucv_hs_rcv()
  read_lock(&iucv_sk_list.lock)
  READ_ONCE(iucv_sk(sk)->hs_dev) == dev
                                      __iucv_sock_close()
                                        WRITE_ONCE(iucv->hs_dev, NULL);
                                        dev_put(dev);
  memcmp() name checks match
  sock_hold(sk)

In that case the lookup still matches the socket after the device
reference is gone. That is the situation the commit message describes
("Between the two it compares a pointer the socket no longer holds"),
with a smaller window.

The new comment in afiucv_hs_rcv() makes the same claim:

	/* Cleared before iucv_sock_close() drops the reference:
	 * whichever value is read is a device the socket still
	 * holds, or NULL.
	 */
	if (READ_ONCE(iucv_sk(sk)->hs_dev) != dev)

Under LKMM, dev_put() is also not release-ordered after the WRITE_ONCE().
The KCSAN report goes away because of the READ_ONCE()/WRITE_ONCE()
marking. The reorder doesn't add a cross-CPU guarantee.

There's no memory-safety effect today, since the lookup only compares the
value against the ingress dev. Could these comments lead a later change to
dereference hs_dev from the lookup, which would then be a use-after-free?

If the guarantee is wanted, would it work to do the clear under
write_lock_bh(&iucv_sk_list.lock), the way iucv_sock_bind() stores
hs_dev, and call dev_put() after the unlock? Otherwise, could the comments
say that the change only annotates the race for KCSAN?

[Severity: High]
This is a pre-existing issue, not one introduced by this patch, but can
this NULL store race with afiucv_netdev_event()?

On NETDEV_GOING_DOWN the notifier walks iucv_sk_list holding only RTNL. It
takes neither the socket lock nor iucv_sk_list.lock, and it holds no
socket reference:

afiucv_netdev_event() {
	...
		if ((iucv->hs_dev == event_dev) &&
		    (sk->sk_state == IUCV_CONNECTED)) {
			if (event == NETDEV_GOING_DOWN)
				iucv_send_ctrl(sk, AF_IUCV_FLAG_FIN);
	...
}

iucv_send_ctrl() loads hs_dev again and dereferences it before any NULL
check:

	blen = sizeof(struct af_iucv_trans_hdr) +
	       LL_RESERVED_SPACE(iucv->hs_dev);

Suppose close() of a connected HIPER socket runs between the notifier's
check and that second load. It sends its FIN, goes through
DISCONN/CLOSING/CLOSED and iucv_sever_path(), then reaches the
WRITE_ONCE(iucv->hs_dev, NULL) above. Wouldn't LL_RESERVED_SPACE() then
dereference NULL? The !skb->dev check in afiucv_hs_send() comes too late
to help.

This can be triggered by a HiperSockets device going down (ip link set
down, or a qeth recovery or offline event) while a user closes a connected
socket on it.

The walk holds no socket reference. Can a socket that iucv_sock_kill()
unlinks and frees during the walk also be used after it is freed?

Neither the clear-before-put order nor marking the notifier's compare
serializes this check-then-use sequence. The cover letter leaves the
notifier to Nagamani PV's pending patch.

[ ... ]

> @@ -1920,9 +1927,14 @@ static int afiucv_hs_callback_syn(struct sock *sk, struct sk_buff *skb)
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
Can this unconditional dev_hold(skb->dev) pin the HiperSockets device when
the child ends up orphaned?

afiucv_hs_callback_syn() only takes bh_lock_sock(sk) and doesn't check
sock_owned_by_user(). It can therefore pass its sk_state != IUCV_LISTEN
check while __iucv_sock_close() holds lock_sock() on the listener.
iucv_sock_cleanup_listen() drains accept_q only once:

	while ((sk = iucv_accept_dequeue(parent, NULL))) {
		...
	}

	parent->sk_state = IUCV_CLOSED;

If iucv_accept_enqueue(sk, nsk) runs after that drain, the child is never
accepted, closed or killed. Its sk_socket is NULL and SOCK_ZAPPED is never
set, so it never reaches the dev_put() in __iucv_sock_close().

afiucv_netdev_event() ignores NETDEV_UNREGISTER. Wouldn't unregistering
the device then wait forever for this reference ("waiting for <dev> to
become free")?

The orphan race and the pin when the read comes before the clear both
predate this patch, as the cover letter notes. Before this patch, though,
an orphan that read iucv->hs_dev after close() cleared it got NULL, and
dev_hold(NULL) did nothing. With skb->dev that case now holds a reference
too.

Would it help to refuse the SYN when the listener's hs_dev has already
been cleared?

>  	afiucv_swap_src_dest(skb);
>  	trans_hdr->flags = AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_ACK;
>  	trans_hdr->window = niucv->msglimit;

[Severity: High]
This isn't a bug introduced by this patch, but do the error paths in
afiucv_hs_callback_syn() leak nsk?

iucv_sock_alloc() links nsk into iucv_sk_list and clears SOCK_ZAPPED. Two
error paths call iucv_sock_kill(nsk):

  - the rejection path (listener not in IUCV_LISTEN, or accept queue
    full)
  - the dev_queue_xmit() failure path

On a never-closed child, iucv_sock_kill() returns at once:

static void iucv_sock_kill(struct sock *sk)
{
	if (!sock_flag(sk, SOCK_ZAPPED) || sk->sk_socket)
		return;
	...
}

Only __iucv_sock_close() sets SOCK_ZAPPED, so nsk is never unlinked or
freed. On the transmit-failure path the child also keeps the reference
taken by dev_hold(skb->dev) above. That reference then blocks
unregistration of the device.

nsk is allocated before the state and backlog checks. Can a peer on the
HiperSockets LAN send matching SYN frames to a bound but non-listening
socket, or to a listener with a full backlog, and leak one socket per
frame?

The leaked sockets stay on iucv_sk_list, so every afiucv_hs_rcv() lookup
and every bind() name scan gets slower.

The cover letter says Hidayath Khan flagged this in August and that his
fix is pending.

[Severity: Medium]
This is also a pre-existing issue, not one introduced by this patch.
Should the dev_queue_xmit() result below go through net_xmit_eval()?

afiucv_hs_callback_syn() {
	...
	err = dev_queue_xmit(skb);
	if (!err) {
		iucv_accept_enqueue(sk, nsk);
		nsk->sk_state = IUCV_CONNECTED;
	...
}

__dev_xmit_skb() returns the qdisc enqueue result unchanged.
fq_codel_enqueue() can return NET_XMIT_CN after it drops packets from the
head of the same flow, so a SYN-ACK queued at the tail can still be sent.

In that case the peer considers itself connected. Locally, the child is
never enqueued and stays in IUCV_OPEN, and afiucv_hs_callback_rx() drops
the peer's data.

afiucv_hs_send() in the same file already uses net_xmit_eval().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028-b4-disp-dd3e4ebb-v2-0-3747658d59bd%40proton.me
