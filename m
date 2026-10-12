Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91343750D7;
	Mon, 12 Oct 2026 19:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791834316; cv=none; b=E6wWgnifWBbxt94tyB6dB5F60gQDdznKVSs7I7LxwQS9gx6MP3zEO+XhmdYqAHUrzuy183cfKv8rC5mnGvX7FIEXqNAi8BBoPjMSTAKyTxSdIWawPxxp//eZOT1nVUDWGuCMDhXdOHjJT5Kx67GYfoUwB1rXu/5Q9oSnXs4DYPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791834316; c=relaxed/simple;
	bh=cc+Ex5Pf9MIkayOb7OWzUPtrUX1g6irviRgr90qyPkY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VZ/UzGca1TeYwdbKaA5jkLWOGj5IQMFtAdpUWzi8ln6P2F4ceLsZ7Op0g2W1xhVybJOOirvSFu/QV4PybBUXQNUhpXGhbi4HWqVamglPS6ulaGJjv1oiGTQ9yHptguujrlopJXQi1bwhQaHNU7ZEitiStB3j5nMjv9ldvK+Z/YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwIp+PW3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwIp+PW3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35751F0089B;
	Mon, 12 Oct 2026 19:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791834314;
	bh=DXWntqGWQj73+xnSqgXATZJNzk0A8N0jjDplCxsKpH0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hwIp+PW3HaOTTMBYr9WRzn0dwzZXqdSlW/55xedlbRrKk5zqs1lOfvynxr8ZI5Tus
	 vERcOpjekc+IdnLxgS0stOMX9qbYpolSESAiUYFMIdiQcY0+oy6nHtNhaXezvyCKOy
	 O6ruVfoPSKfB5WPgpenAfjxgxx9b7ZqVczvaBADPx2quiWaoZrnVZ1i66MzxbV/vZG
	 0vqTjW02Bj90z95VZSahk6SgJtxhcDggUzIYnMiUIiLObA6/lO66ZTrE17pWsVNuZo
	 UJi5TqyLtH465nrhdbH7BHMFP05xbwoag/I6CusBrtSyySRXOZezzWb4ETkr+XhxTI
	 F2dMOnxmuEIVw==
Subject: Re: [PATCH net-next] net/iucv: serialize HiperSockets receive with
 the socket lock
From: netdev-bot+sashiko@kernel.org
To: hexlabsecurity@proton.me
Cc: pabeni@redhat.com, kuba@kernel.org, twinkler@linux.ibm.com,
 edumazet@kernel.org, wintera@linux.ibm.com, davem@davemloft.net,
 nagamani@linux.ibm.com, hidayath@linux.ibm.com, netdev@vger.kernel.org,
 horms@kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 12 Oct 2026 19:45:13 +0000
Message-ID: <179183431327.434549.446348148837850426@kernel.org>
In-Reply-To: <20261011-b4-disp-410518f4-v1-1-753bf3258292@proton.me>
References: <20261011-b4-disp-410518f4-v1-1-753bf3258292@proton.me>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 3 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] afiucv_hs_backlog_add() takes the data budget from the live
  READ_ONCE(iucv->msglimit) + 1, on the assumption that this equals the…
- [Medium] The comments on afiucv_hs_defer() and afiucv_hs_backlog_add()
  size both budgets on one claim: data and WIN frames only ever wait…
- [Medium] Repeated SHT frames can still push msg_recv past msglimit, so
  recvmsg() takes WARN_ON(1), __iucv_sock_close() and -EFAULT instead of…
- [Low] The commit message describes user-visible bugs that date back to
  3881ac441f64 ("af_iucv: add HiperSockets transport"): a FIN or SYN|ACK…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is high
  severity.
- [Low] In iucv_sock_recv_skb(), a reader that is asleep when the peer's
  FIN arrives gets -ENOTCONN, while a recvmsg() that starts after the…

--

net/iucv: serialize HiperSockets receive with the socket lock

This patch makes afiucv_hs_rcv() take bh_lock_sock() once. While a task
owns the socket, frames are deferred to the socket backlog, which is
bounded by frame count and drained by a per-socket sk_backlog_rcv. It also
runs recvmsg() under lock_sock(), lets sendmsg() wait for send memory
without the lock, and sends the FIN and first SHT past sk_sndbuf.

Link: https://lore.kernel.org/all/20260724222917.134769-1-hexlabsecurity@proton.me/

> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index 5ba875798aa41..1fcb47a087551 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c

[ ... ]

> @@ -374,26 +377,28 @@ static void iucv_sever_path(struct sock *sk, int with_user_data)
>  static int iucv_send_ctrl(struct sock *sk, u8 flags)
>  {

[ ... ]

> -	skb = sock_alloc_send_skb(sk, blen, 1, &err);
> -	if (skb) {
> -		skb_reserve(skb, blen);
> -		err = afiucv_hs_send(NULL, sk, skb, flags);
> +	/* Control frames go out after a shutdown too. The FIN and the first SHT
> +	 * end the stream and may exceed sk_sndbuf, like TCP's FIN; at sk_sndbuf
> +	 * the others get -EAGAIN and arm SIGIO, as sock_alloc_send_skb() does.
> +	 */
> +	force = flags == AF_IUCV_FLAG_FIN ||
> +		(flags == AF_IUCV_FLAG_SHT &&
> +		 !(sk->sk_shutdown & SEND_SHUTDOWN));

[Severity: Low]
The only trailers are Suggested-by, Link and Signed-off-by. There is no
Fixes: tag.

The changelog describes bugs users can see that go back to 3881ac441f64
("af_iucv: add HiperSockets transport"):

- a SHT or FIN lost to a full send buffer
- a window update that fails and keeps its credit, so recvmsg() hits
  WARN_ON(1) and returns -EFAULT

The notes below the --- line say this iucv_send_ctrl() change could go to
net on its own with Fixes: 3881ac441f64. They also say the credit drop in
recvmsg() fixes a bug in net today.

If both stay folded into one net-next patch, will stable pick them up?
Could the iucv_send_ctrl() fix, and possibly the credit drop, go to net
as separate patches with Fixes: tags?

[ ... ]

> @@ -1245,6 +1267,47 @@ static void iucv_process_message_q(struct sock *sk)
>  	}
>  }
>
> +/*
> + * Like skb_recv_datagram(), but sleep with the socket lock released, so that
> + * release_sock() runs the backlog and a deferred FIN reaches the reader.
> + */
> +static struct sk_buff *iucv_sock_recv_skb(struct sock *sk, int flags, int *err)
> +{

[ ... ]

> +		if (!timeo)
> +			break;
> +		if (sk->sk_state != IUCV_CONNECTED) {
> +			*err = -ENOTCONN;
> +			break;
> +		}

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch. A
reader that is asleep here when the peer's FIN arrives gets -ENOTCONN. A
recvmsg() that starts after the FIN returns 0 through the IUCV_DISCONN
shortcut at the top of iucv_sock_recvmsg().

The old path, skb_recv_datagram()->__skb_wait_for_more_packets(), also
returned -ENOTCONN in this case, because IUCV_CONNECTED equals
TCP_ESTABLISHED. So this keeps the existing behaviour.

Should a blocked reader also see EOF here, like a reader that arrives
after the FIN?

[ ... ]

> @@ -1322,8 +1386,9 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
>  			atomic_inc(&iucv->msg_recv);
>  			if (atomic_read(&iucv->msg_recv) > iucv->msglimit) {
>  				WARN_ON(1);
> -				iucv_sock_close(sk);
> -				return -EFAULT;
> +				__iucv_sock_close(sk);
> +				err = -EFAULT;
> +				goto out_err;
>  			}
>  		}
>
> @@ -1350,13 +1415,18 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
>  		}
>  		spin_unlock_bh(&iucv->message_q.lock);
>
> -		if (send_win) {
> +		if (send_win && sk->sk_state == IUCV_CONNECTED) {
>  			err = iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN);
>  			if (err) {
>  				sk->sk_state = IUCV_DISCONN;
>  				sk->sk_state_change(sk);
>  			}
>  		}
> +		/* the peer won't take this credit: drop it, or a SHT's
> +		 * zero-length skb counts past msglimit
> +		 */
> +		if (send_win && sk->sk_state != IUCV_CONNECTED)
> +			atomic_set(&iucv->msg_recv, 0);

[Severity: Medium]
Can repeated SHT frames still drive recvmsg() into the WARN_ON(1) and
-EFAULT above?

On the peer, every shutdown(SHUT_WR) while connected sends another SHT:

iucv_sock_shutdown()
    ...
    } else
        iucv_send_ctrl(sk, AF_IUCV_FLAG_SHT);

These SHTs don't use any window, since only sendmsg() increments
msg_sent. Here, each one becomes a zero-length skb, and consuming it does
atomic_inc(&iucv->msg_recv).

msg_recv is only reset through send_win. send_win is only set when
backlog_skb_q is empty after the requeue loop, and the new credit drop
depends on send_win too.

Suppose the peer sends a full window of data, then enough repeated SHTs
that the receive queue spills into backlog_skb_q. backlog_skb_q may then
stay non-empty while msg_recv keeps climbing.

Would the first SHT read then push msg_recv past iucv->msglimit? That
would make recvmsg() call __iucv_sock_close() and return -EFAULT instead
of EOF. The comment in afiucv_hs_backlog_add() says "a repeated one
carries nothing", but such an SHT still seems to count here.

[ ... ]

> @@ -1894,7 +1966,6 @@ static int afiucv_hs_callback_syn(struct sock *sk, struct sk_buff *skb)
>  	}
>
>  	nsk = iucv_sock_alloc(NULL, sk->sk_protocol, GFP_ATOMIC, 0);
> -	bh_lock_sock(sk);
>  	if ((sk->sk_state != IUCV_LISTEN) ||
>  	    sk_acceptq_is_full(sk) ||
>  	    !nsk) {
> @@ -1904,7 +1975,6 @@ static int afiucv_hs_callback_syn(struct sock *sk, struct sk_buff *skb)
>  		err = dev_queue_xmit(skb);
>  		if (nsk)
>  			iucv_sock_kill(nsk);
> -		bh_unlock_sock(sk);
>  		goto out;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but does this refusal path
leak nsk?

iucv_sock_kill() does nothing unless SOCK_ZAPPED is set:

static void iucv_sock_kill(struct sock *sk)
{
	if (!sock_flag(sk, SOCK_ZAPPED) || sk->sk_socket)
		return;
	...
}

iucv_sock_alloc() clears SOCK_ZAPPED, and only __iucv_sock_close() sets
it. None of these paths call __iucv_sock_close(). So each SYN refused
here seems to leave a whole iucv_sock linked on iucv_sk_list, still
holding its sk_alloc() reference. That covers a listener not in
IUCV_LISTEN and a full accept queue.

The same applies to the iucv_sock_kill(nsk) after a failed
dev_queue_xmit() of the SYN|ACK further down. There, the
dev_hold(niucv->hs_dev) reference would leak too, and
unregister_netdev() of that device could wait forever.

A peer on the HiperSockets LAN can repeat connect() against a listener
with a full accept queue, so this can grow without bound. The leaked
sockets also lengthen the iucv_sk_list walk in afiucv_hs_rcv() for every
frame.

With this patch, deferred SYNs reach the same path through
afiucv_hs_backlog_rcv()->afiucv_hs_dispatch()->afiucv_hs_callback_syn().
The changelog also names the full-accept-queue refusal as the model for
the new refusal past the budget.

[ ... ]

> @@ -2066,6 +2131,64 @@ static int afiucv_hs_callback_rx(struct sock *sk, struct sk_buff *skb)
>  	return NET_RX_SUCCESS;
>  }
>
> +/* data, SHT and WIN frames: they leave sk_state alone */
> +static bool afiucv_hs_is_data(u8 flags)
> +{
> +	return !flags || flags == AF_IUCV_FLAG_SHT || flags == AF_IUCV_FLAG_WIN;
> +}
> +
> +/*
> + * Frames that change sk_state wait while the user owns the socket. Data, SHT
> + * and WIN frames go through, but never past waiting ones: sk_backlog.len stays
> + * set until __release_sock() has run them all. So they wait only behind a FIN,
> + * which voids them, or a SYN|ACK, when we have sent nothing for a WIN to ack.
> + */
> +static bool afiucv_hs_defer(struct sock *sk, u8 flags)
> +{
> +	return !afiucv_hs_is_data(flags) || sk->sk_backlog.len != 0;
> +}

[Severity: Medium]
Does this classification hold up for frames the dispatcher doesn't act
on?

While the socket is owned, every flags value outside {0, SHT, WIN} is
deferred and charged to sk_backlog_ctrl. That includes values that
afiucv_hs_dispatch() only frees in its default case. It also includes a
SYN|ACK or SYN|FIN for a socket that isn't IUCV_BOUND, which the
callbacks just drop.

On a socket that isn't listening, the control limit is
sk_max_ack_backlog + 2, which is 2. Two such frames in one ownership
period would leave no room for a real FIN. The FIN would then go to
kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_BACKLOG) and never be
resent.

Each deferred stray frame also makes sk_backlog.len non-zero. Later data
and pure WIN frames are then deferred too and charged to the
msglimit + 1 data budget.

With traffic in both directions, msglimit data frames plus two or more
pure WINs, could data frames be dropped as well? Before this patch these
stray frames were freed right away.

Would it make sense to drop unknown flags in afiucv_hs_rcv() before
deciding whether to defer?

> +
> +/*
> + * Not sk_add_backlog(): its limit is in bytes, and nothing resends a frame it
> + * drops. Count frames instead. Data, SHT and WIN frames get msglimit + 1: a
> + * peer that keeps to the window has at most msglimit data frames and one SHT
> + * waiting (a repeated one carries nothing); WINs need no room (see above). The
> + * rest get sk_max_ack_backlog + 2: a SYN|ACK and a FIN, or a listener's SYNs up
> + * to its accept queue and one more. Both counts restart only once
> + * __release_sock() has run every frame: a flood cannot keep the owner draining.
> + */
> +static void afiucv_hs_backlog_add(struct sock *sk, struct sk_buff *skb,
> +				  u8 flags)
> +{
> +	struct iucv_sock *iucv = iucv_sk(sk);
> +	unsigned int *count, limit;
> +
> +	if (!sk->sk_backlog.len) {
> +		iucv->sk_backlog_data = 0;
> +		iucv->sk_backlog_ctrl = 0;
> +	}
> +	if (afiucv_hs_is_data(flags)) {
> +		count = &iucv->sk_backlog_data;
> +		limit = READ_ONCE(iucv->msglimit) + 1;

[Severity: Medium]
Can this budget end up smaller than the window the peer was granted?

The SYN advertises the msglimit that is current at connect() time:

afiucv_hs_send()
	if (flags == AF_IUCV_FLAG_SYN)
		phs_hdr->window = iucv->msglimit;

However, iucv_sock_setsockopt(SO_MSGLIMIT) still accepts the option in
IUCV_BOUND. A HiperSockets socket stays in IUCV_BOUND from the moment
iucv_sock_connect() sends its SYN until the SYN|ACK arrives. That window
is open after:

- a non-blocking, timed-out or interrupted connect()
- another thread calls setsockopt() while a blocking connect() sleeps in
  iucv_sock_wait() with the lock released

If msglimit is lowered in that window, the peer can still send a full
window of the old size. Those frames wait behind the deferred SYN|ACK.
Every frame past the new msglimit + 1 is dropped here with
SKB_DROP_REASON_SOCKET_BACKLOG and never resent, so stream data is lost
without any error. The msg_recv > iucv->msglimit check in
iucv_sock_recvmsg() would also use the lowered value.

The notes below the --- line call this the one remaining gap, but the
code still allows it. Could SO_MSGLIMIT be rejected once a HiperSockets
SYN has gone out? Alternatively, could the advertised window be saved and
used for this budget?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011-b4-disp-410518f4-v1-1-753bf3258292%40proton.me
