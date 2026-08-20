Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A463D566B;
	Thu, 20 Aug 2026 20:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787258017; cv=none; b=T9YKrYRh3yn974T5TTgM3dj2iO51Xd/qMOU0CNvlC93bSS2hyaS4uPkzorX4T0GaIWYpiRPGnM3oGllPamJKLUskz4a8CsojABE3HpRPf9YwUlE3LvLnc/X6Q+0ML/lhwobpI9a0zDdWEIQ0k0S1PrlGhGYJjTrv8a4h4Byvdmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787258017; c=relaxed/simple;
	bh=QQ7vrP0sQgM+gnn/ok7B/XPFWRBTfUok9ONa5vNjKg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DxzX9a+hClPhd5DT+0qkReU0aE7QkmdvN0bXtmSuFdcw3yTkxWyGdzdcgnE/GNYPz0hXNbUyTjp0AzR68mQDv+MRBjrbT4+aW+wl6ZkCYxjDSvGp5imNgofvcOckg7+hHws04WpGJVvfVZrS8OAHy0MwgZAdgHmuhohsuMIpRJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCeemXDr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCeemXDr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740DE1F00A3A;
	Thu, 20 Aug 2026 20:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787258013;
	bh=ag6f7PnyFF2V2rcTnBBNMFmhxwO6Y8y0IB8nmCOUq8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jCeemXDr5ETudPub0LUHXQIz4viBhBougmk0sYYQC5D/IN78Im+sXcVkWgy83XYA4
	 4RE1eBozoHrgsElsMK4b1WjKsqBs/3cTTozXl5eBBvFLcWQ/aQcWiIVzwhQJhD/6qe
	 AjYy4DpPXbO/Fx5mNecJOUSFUKh69yOQauz1cSJBeT/mtkRWCay1SWmGd8dNEyvVgy
	 +ITXNRHmBdA3AtNVtEVskQWMLXfimoB+VUvfP2H0VfIj9z8pe8OX4HjmyWYrQJQltJ
	 pxTfbODdYgXk8q1QKq4ri3f3/NjjyOu9Zs9CJ9NqfEKXFvvxgDD1l8L+8vJoNhRQCo
	 HnvQYPVauqcdw==
From: Jakub Kicinski <kuba@kernel.org>
To: hexlabsecurity@proton.me
Cc: Jakub Kicinski <kuba@kernel.org>,
	pabeni@redhat.com,
	twinkler@linux.ibm.com,
	wintera@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	netdev@vger.kernel.org,
	ursula.braun@de.ibm.com,
	linux-s390@vger.kernel.org,
	hidayath@linux.ibm.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net/iucv: send the window update outside message_q.lock
Date: Thu, 20 Aug 2026 13:33:31 -0700
Message-ID: <20260820203331.1134906-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815-b4-disp-8a791503-v1-2-fbae9a511144@proton.me>
References: <20260815-b4-disp-8a791503-v1-2-fbae9a511144@proton.me>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/iucv: send the window update outside message_q.lock

This moves the AF_IUCV_FLAG_WIN control send in iucv_sock_recvmsg() out of
the spin_lock_bh(&iucv->message_q.lock) section by latching a send_win
boolean under the lock and doing the send after the unlock.  The stated
reason is that iucv_send_ctrl() allocates with sock_alloc_send_skb() and
sk->sk_allocation (GFP_KERNEL), which may sleep inside the spinlock.

> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index 0bc4a15f4b565..e31ef3a87ec50 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -1241,6 +1241,7 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
>  	struct iucv_sock *iucv = iucv_sk(sk);
>  	unsigned int copied, rlen;
>  	struct sk_buff *skb, *rskb, *cskb;
> +	bool send_win = false;
>  	int err = 0;
>  	u32 offset;
>  
> @@ -1332,16 +1333,18 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
>  			if (!list_empty(&iucv->message_q.list))
>  				iucv_process_message_q(sk);
>  			if (iucv->transport == AF_IUCV_TRANS_HIPER &&
> -			    atomic_read(&iucv->msg_recv) >=
> -							iucv->msglimit / 2) {
> -				err = iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN);
> -				if (err) {
> -					sk->sk_state = IUCV_DISCONN;
> -					sk->sk_state_change(sk);
> -				}
> -			}
> +			    atomic_read(&iucv->msg_recv) >= iucv->msglimit / 2)
> +				send_win = true;
>  		}
>  		spin_unlock_bh(&iucv->message_q.lock);
> +
> +		if (send_win) {
> +			err = iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN);
> +			if (err) {
> +				sk->sk_state = IUCV_DISCONN;
> +				sk->sk_state_change(sk);
> +			}
> +		}
>  	}

[Severity: High]
The changelog notes the widened msg_recv race, but should the patch also
close it rather than leave it, given the Cc: stable tag?

iucv_sock_recvmsg() never takes lock_sock(), so message_q.lock was the only
thing serializing two recvmsg threads through the read-then-subtract of
iucv->msg_recv in afiucv_hs_send():

net/iucv/af_iucv.c:afiucv_hs_send() {
	...
	else if ((flags == AF_IUCV_FLAG_WIN) || !flags) {
		confirm_recv = atomic_read(&iucv->msg_recv);
		phs_hdr->window = confirm_recv;
	...
	err = dev_queue_xmit(skb);
	if (net_xmit_eval(err)) {
		atomic_dec(&iucv->skbs_in_xmit);
	} else {
		atomic_sub(confirm_recv, &iucv->msg_recv);
		WARN_ON(atomic_read(&iucv->msg_recv) < 0);
	}
}

Can two threads doing recvmsg() on the same HiperSockets socket both latch
send_win under the lock, both sample the same value N after the unlock, both
advertise N to the peer, and both subtract N, leaving msg_recv at -N and
tripping that WARN_ON() from unprivileged userspace?  iucv_sock_create()
requires no capability, and panic_on_warn turns the splat into a panic.

Does the negative counter then get truncated into the u16 window field of
struct af_iucv_trans_hdr, so that -1 is advertised as 65535?  On the peer
side afiucv_hs_callback_win() subtracts the wire value directly:

net/iucv/af_iucv.c:afiucv_hs_callback_win() {
	...
	atomic_sub(iucv_trans_hdr(skb)->window, &iucv->msg_sent);
}

so its msg_sent goes far negative and iucv_below_msglim() stops throttling
it.  The over-credited peer can then push more than msglimit messages, and
the receiver either takes the teardown path in iucv_sock_recvmsg():

	if (atomic_read(&iucv->msg_recv) > iucv->msglimit) {
		WARN_ON(1);
		iucv_sock_close(sk);
		return -EFAULT;
	}

or accumulates the excess in iucv->backlog_skb_q, which
afiucv_hs_callback_rx() fills with skb_queue_tail() without any length or
rmem accounting, so the growth is not bounded by SO_RCVBUF.

The same failure mode was already reachable before this patch through the
recvmsg-versus-sendmsg interleaving, since iucv_sock_sendmsg() calls
afiucv_hs_send() under lock_sock() only, a lock recvmsg does not take.  This
patch adds a new recvmsg-versus-recvmsg interleaving on top of that.

Would claiming the credit atomically before the transmit work here, for
example atomic_xchg()/atomic_fetch_sub() on msg_recv with a re-add on xmit
failure?  Alternatively, could the control skb be preallocated before
entering the locked section, or the deferred send be done under the socket
lock, instead of widening the window?

[Severity: High]
This isn't a bug introduced by this patch, but the deferred call appears to
lengthen an existing unlocked window around iucv->hs_dev and sk->sk_shutdown.

iucv_send_ctrl() dereferences hs_dev unconditionally and does an
unserialized read-modify-write of sk->sk_shutdown:

net/iucv/af_iucv.c:iucv_send_ctrl() {
	blen = sizeof(struct af_iucv_trans_hdr) +
	       LL_RESERVED_SPACE(iucv->hs_dev);
	if (sk->sk_shutdown & SEND_SHUTDOWN) {
		shutdown = sk->sk_shutdown;
		sk->sk_shutdown &= RCV_SHUTDOWN;
	}
	skb = sock_alloc_send_skb(sk, blen, 1, &err);
	...
	if (shutdown)
		sk->sk_shutdown = shutdown;
}

LL_RESERVED_SPACE() dereferences dev->hard_header_len and
dev->needed_headroom.  The only writer that clears hs_dev holds lock_sock()
only, which recvmsg never takes, and message_q.lock does not cover hs_dev
either (for HIPER sockets iucv->path is NULL, so iucv_sever_path() returns
without touching message_q.lock):

net/iucv/af_iucv.c:iucv_sock_close() {
	...
	if (iucv->hs_dev) {
		dev_put(iucv->hs_dev);
		iucv->hs_dev = NULL;
		sk->sk_bound_dev_if = 0;
	}
}

Can a second thread doing recvmsg() on the same socket reach the
WARN_ON(1)/iucv_sock_close() branch above and NULL and dev_put() hs_dev
while this thread is inside the deferred iucv_send_ctrl(), giving
LL_RESERVED_SPACE(NULL) or use of a net_device whose reference was just
dropped?

Separately, iucv_sock_shutdown() sets sk->sk_shutdown |= how under
lock_sock().  Can the unlocked save/clear/restore in iucv_send_ctrl()
overwrite that and drop a concurrently set SEND_SHUTDOWN bit, re-enabling
sends after shutdown?

Since the patch now allows the potentially sleeping sock_alloc_send_skb()
(sk->sk_allocation is GFP_KERNEL) to run inside this unlocked window, would
taking the socket lock around the deferred control send, or pinning hs_dev
with a local dev_hold(), be preferable?
