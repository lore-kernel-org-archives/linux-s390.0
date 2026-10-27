Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793069426;
	b=I+C4ET7KkpH7yVxhGRlm8xGsfwDDL2xeMUZJHWYOyUGv7OhOWhLpPCTMFYXG2xtHyDrp
	 QnNlg5LqkBywJEZjxnkjC9yi7iLPv614n/O1ijf2kyt5d/dXqHZZBTVBRr7QulZ1feuYo
	 B9lL7HfPhcYFSKBI0ayh6BvsB8WMN5qgjARpodDzxlboM6x60Yb6ebcF4YgNjb0mkaU68
	 OQ7tY5JBtyCxLfPt+mff6lZHMUGqwKXCaDd7BPCEHY69ECmqGlboKDd+wrGxFLgAZgsZh
	 dW9z8x3o9JCH0SaGPF75eL9sv0Hui/tcoGeomUfjRt4g3GjZJB187Nbvj9L7xO5/UTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793069426;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=IyyCULW8SkmvNw1xg0vXA/Ay8zzqUNH3Bx42peKvByI=;
	b=SDZ3MtLXhG4IFcvPUIMUoTGyFQn6nmsisZXtpAB+DwL18jYi0zot4KPTn0DBfSkbxg5x
	 iGu2mHN0/HFSYmHH+c2ilhW88XWueOYtQ8YcdrDfGF3Ds847KmVnV2bVfgdRf+47TqapX
	 qA8RE0WsR9o0FCVO6L6RqFRaVMJAw4yBOFBa7c3YkrbzzNgoXVVY6OruTB4IptQzEDisu
	 OJdtroY2UTLT1ONPZrM3wqzlegeWJ6dorljIWiRSUMLZ/fhwFo+pAIVmtuqFcTY32DzqV
	 DuMsYJeZ+o7pC42y2K28/mFBF62s6ovnZW0lHseaEVLMlBYocCtwzevOZ9BkrwsjUvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WmVIItqG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB73606A324;
	Tue, 27 Oct 2026 02:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WmVIItqG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843C71F01828;
	Tue, 27 Oct 2026 02:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793069426;
	bh=IyyCULW8SkmvNw1xg0vXA/Ay8zzqUNH3Bx42peKvByI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WmVIItqGCc5A4Ch6+AJmWJ3GM99Atb2ADWthQMCYMPbKENNZvMV84BgCXqvo6wAJ2
	 AuvTP9dURmQ71BFq4o51cXwzIX3/MZF/qK93w447xvcQf0LS+xuaFg+5DdnWqvaiuL
	 gGg1HtMwAfrCoh1IFrU7HnufVlCWtHHARYellARFN18LEX6UU6MN/huDHyIUO5OiNA
	 HJ/ymwXyZzhFVcE83+qy9wsaBMrtCwPR0T1Bt/poWPZ3jofhqhklzXdUPxSQMp+lke
	 zBTNrjU2AU2vUACQmz7Wb/fKyMlYLeGWmN2iyRHKXSUkmHGqU1eNTNg+68/c9HpaZe
	 s+bmVoY6Wt+Mg==
Subject: Re: [PATCH net 2/2] net/iucv: do not count the SHT frame against the
 receive window
From: netdev-bot+sashiko@kernel.org
To: hexlabsecurity@proton.me
Cc: edumazet@kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, wintera@linux.ibm.com, twinkler@linux.ibm.com,
 nagamani@linux.ibm.com, netdev@vger.kernel.org, hidayath@linux.ibm.com,
 linux-s390@vger.kernel.org, horms@kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 27 Oct 2026 02:50:25 +0000
Message-ID: <179306942509.3134.1109951482403010755@kernel.org>
In-Reply-To: <20261022-b4-disp-b35a9153-v1-2-d74645876195@proton.me>
References: <20261022-b4-disp-b35a9153-v1-2-d74645876195@proton.me>
X-sashiko-severity: High
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

Critical: 0 · High: 1 (1) · Medium: 0 (3) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch adds `&& rlen` to the counting branch in
  iucv_sock_recvmsg() (net/iucv/af_iucv.c:1324).

Pre-existing issues:
- [High] A peer can grow iucv->backlog_skb_q without limit.
- [Medium] A conforming HiperSockets peer can still end up in the
  `msg_recv > msglimit` close in iucv_sock_recvmsg().
- [Medium] On HiperSockets, a zero-length sendmsg() leaks one slot of the
  peer's window when a receive credit is piggybacked on it.
- [Medium] The classic IUCV transport still has a WARN that a peer can
  trigger.
- [Low] Two unsynchronized writes to sk->sk_shutdown can lose
  RCV_SHUTDOWN.

--

net/iucv: do not count the SHT frame against the receive window

This patch changes iucv_sock_recvmsg() so that zero-length HiperSockets
frames, such as the SHT frame sent by shutdown(SHUT_WR), no longer count
against msg_recv. It also removes the WARN_ON(1) from the over-window
path, which still closes the socket and returns -EFAULT.

Closes: https://lore.kernel.org/netdev/179183431327.434549.446348148837850426@kernel.org/

> A zero-length data frame sets RCV_SHUTDOWN, after which
> afiucv_hs_callback_rx() drops every later data frame uncounted; the one
> slot this patch no longer credits for it is lost like the slots of the
> frames dropped after it.

[Severity: Medium]
This is a pre-existing issue, but does a zero-length data frame always
arrive at the receiver as an empty data frame?

iucv_sock_sendmsg() has no zero-length guard, and it counts the send
before the frame goes out:

    atomic_inc(&iucv->msg_sent);
    err = afiucv_hs_send(&txmsg, sk, skb, 0);

With flags == 0, afiucv_hs_send() piggybacks any pending credit:

    if (flags == AF_IUCV_FLAG_WIN || !flags) {
            confirm_recv = atomic_xchg(&iucv->msg_recv, 0);
            phs_hdr->window = confirm_recv;
            if (confirm_recv)
                    phs_hdr->flags = phs_hdr->flags | AF_IUCV_FLAG_WIN;

On the receiving side, afiucv_hs_rcv() then handles it as a pure window
update:

    case (AF_IUCV_FLAG_WIN):
            err = afiucv_hs_callback_win(sk, skb);
            if (skb->len == sizeof(struct af_iucv_trans_hdr)) {
                    consume_skb(skb);
                    break;
            }

The frame never reaches afiucv_hs_callback_rx() or recvmsg(). It does not
set RCV_SHUTDOWN, the receiver never credits it back, and the sender's
msg_sent stays one too high.

If zero-length sends repeat while msg_recv is non-zero, they use up
msglimit_peer. Eventually sendmsg() blocks in iucv_sock_wait() or returns
-EAGAIN.

This patch does not touch that path. The sentence quoted above, though,
does not hold when a credit is piggybacked.

> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index 501e758c5e68a..a5142081bb6a6 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -1317,10 +1317,13 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
>  		}
>  
>  		consume_skb(skb);
> -		if (iucv->transport == AF_IUCV_TRANS_HIPER) {
> +		/* The peer counts only the data it sends against its window;
> +		 * the SHT's empty frame is not among them. Over the window,
> +		 * close without a WARN: a peer reaches this from the network.
> +		 */
> +		if (iucv->transport == AF_IUCV_TRANS_HIPER && rlen) {

[Severity: High]
Can an empty frame read after the over-window close reach
iucv_send_ctrl() while iucv->hs_dev is NULL?

When a data frame pushes msg_recv over msglimit, iucv_sock_close() runs
and clears hs_dev:

iucv_sock_close()
    ...
    skb_queue_purge(&iucv->send_skb_q);
    skb_queue_purge(&iucv->backlog_skb_q);
    ...
    WRITE_ONCE(iucv->hs_dev, NULL);

It does not purge sk_receive_queue, and it does not reset msg_recv.

The next recvmsg() returns -ECONNRESET through sock_error() in
__skb_try_recv_datagram(), and that call also clears sk_err. The
recvmsg() after it dequeues whatever is still in sk_receive_queue, even
though the socket is IUCV_CLOSED.

If that frame is empty (an SHT, for example), rlen == 0 and the new gate
skips the over-window return. backlog_skb_q is empty because close
purged it, and msg_recv is still above msglimit, so this code runs:

    if (iucv->transport == AF_IUCV_TRANS_HIPER &&
        atomic_read(&iucv->msg_recv) >=
                    iucv->msglimit / 2)
            send_win = true;
    ...
    if (send_win) {
            err = iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN);

iucv_send_ctrl() then computes:

    blen = sizeof(struct af_iucv_trans_hdr) +
           LL_RESERVED_SPACE(iucv->hs_dev);

This reads hard_header_len and needed_headroom through a NULL pointer,
before afiucv_hs_send() gets a chance to check the device.

For example, say the receiver has msglimit 2 and a small SO_RCVBUF, and
the peer sends d1, d2, d3 and then SHTs:

1. Reading d1 and d2 moves d3 and S1 into sk_receive_queue.
2. Reading d3 closes the socket.
3. The next read returns -ECONNRESET.
4. The read after that consumes S1.

Before this patch, every frame read after the close went through the
msg_recv > msglimit branch again and returned -EFAULT. send_win could not
be reached on this path.

On s390 with relocate_lowcore this would oops. On a default boot, blen
would be computed from lowcore bytes and afiucv_hs_send() would fail with
-ENODEV. recvmsg() would then move the IUCV_CLOSED socket back to
IUCV_DISCONN.

Could this return early once the socket is closed, or skip the window
update after a close?

>  			atomic_inc(&iucv->msg_recv);
>  			if (atomic_read(&iucv->msg_recv) > iucv->msglimit) {
> -				WARN_ON(1);

[Severity: Medium]
This is a pre-existing issue, but the classic IUCV transport still has a
WARN that a peer can trigger, of the same kind as the one removed here.

alloc_iucv_recv_skb() does:

    WARN_ONCE(!skb,
              "alloc of recv iucv skb len=%lu failed with errcode=%d\n",
              len, err);

len comes from the peer's message via iucv_msg_length(), called from
iucv_callback_rx() or iucv_process_message_q(). iucv_callback_rx() checks
it only against sk_rcvbuf, and iucv_process_message_q() does not check it
at all.

A message larger than MAX_SKB_FRAGS * PAGE_SIZE plus the linear part
makes alloc_skb_with_frags() fail with -EMSGSIZE. A GFP_ATOMIC | GFP_DMA
allocation failure under memory pressure has the same effect.

With panic_on_warn, a peer can turn this into a panic. Should this
WARN_ONCE() be removed as well?

>  				iucv_sock_close(sk);
>  				return -EFAULT;

[Severity: High]
This isn't a bug introduced by this patch, but this read-time check is
the only window enforcement on the receive side. Can a peer that ignores
its window grow iucv->backlog_skb_q without limit?

afiucv_hs_callback_rx() queues frames like this:

    if (skb_queue_empty(&iucv->backlog_skb_q)) {
            if (__sock_queue_rcv_skb(sk, skb))
                    /* handle rcv queue full */
                    skb_queue_tail(&iucv->backlog_skb_q, skb);
    } else
            skb_queue_tail(&iucv_sk(sk)->backlog_skb_q, skb);

Once sk_rcvbuf is full, or once the backlog holds any frames, every later
data, SHT or WIN-with-payload frame goes onto backlog_skb_q. That queue
has no length or memory limit, and these skbs are not charged to
sk_rmem_alloc.

msg_recv is only incremented in iucv_sock_recvmsg(). If the reader is
idle or slow, kernel memory keeps growing until the reader runs or the
system runs out of memory.

[Severity: Medium]
This is a pre-existing issue, but can a conforming peer still reach this
close?

The new comment says "a peer reaches this from the network". However,
the check compares against the current iucv->msglimit, while the peer is
bound by the window advertised in the SYN. afiucv_hs_send() fills that
window in as:

    phs_hdr->window = iucv->msglimit;

iucv_sock_connect() sends the SYN and then waits in IUCV_BOUND. A
blocking connect drops the socket lock inside iucv_sock_wait(), and a
non-blocking connect returns -EAGAIN. In either case
iucv_sock_setsockopt() still accepts SO_MSGLIMIT in that state:

    case IUCV_BOUND:
            if (val < 1 || val > U16_MAX)
                    rc = -EINVAL;
            else
                    iucv->msglimit = val;

So msglimit can be lowered below the window that was already advertised.

While frames wait in backlog_skb_q, recvmsg() sends no WIN, so msg_recv
climbs past the lowered limit. A peer that stayed inside its window then
gets closed: the reader sees -EFAULT and the consumed frame is lost.

The notes below the cut line mention this case and defer it to a rework
that stores the advertised window separately. Could the commit message
and the new comment also say that a conforming peer can still reach this
path?

>  			}

[Severity: Low]
This is a pre-existing issue, but can the RCV_SHUTDOWN set by the
empty-frame read be lost?

iucv_sock_recvmsg() runs without lock_sock() and does a plain
read-modify-write:

    if (!rlen)
            sk->sk_shutdown = sk->sk_shutdown | RCV_SHUTDOWN;

iucv_send_ctrl() saves and restores the whole mask. It can be called from
a repeated shutdown(SHUT_WR) under lock_sock(), or from a concurrent
recvmsg() sending WIN:

    if (sk->sk_shutdown & SEND_SHUTDOWN) {
            /* controlling flags should be sent anyway */
            shutdown = sk->sk_shutdown;
            sk->sk_shutdown &= RCV_SHUTDOWN;
    }
    ...
    if (shutdown)
            sk->sk_shutdown = shutdown;

If the SHT read sets RCV_SHUTDOWN between the save and the restore, the
restore clears it again. The current read still returns 0, but later
reads may block or return -EAGAIN instead of EOF. afiucv_hs_callback_rx()
would also start accepting data frames again.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022-b4-disp-b35a9153-v1-0-d74645876195%40proton.me
