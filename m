Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793594857;
	b=wDhtxjVis2PQf1YN0ruyRkwIqtK3FYOk542Pu4LjJ7AoUuFYQ2e7uvnWpvl6QcmTA8g9
	 GbIJjChhB53vmGJrcesBtb9h4CaA6QjqsV3YRL9t9sdrIT8CPYJ8otA2LwyQs2UukRiGD
	 kkzsNKa5wKcR+9n/NS8zgqTlzXD3OsxLws4x7xsCrNSHoPwpQx+rMJJCn3hsuVqoxDPgN
	 GYGbxb84jQfCbggOKWj53iKr+6z6gw03DHAvQkc+bMvs2KMLO88KhGKu0FrfPoY8QZIN3
	 CNsvwF3Dvv0fOsmbqbewU1RN4xdmAB6ovAiZ28+adUryNeckdlNL93CaXp2a0p/xYJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793594857;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=9ouneipARGjGX7bBxDJKhDjEfYrzEfeGMFSmtVlNjBk=;
	b=p8BhEQ1x8/vmkjdhRZqg3YZslyNFAuEj2IV3W9Lt5hfpjlFLDi1VF5PeRbKqfcbjcROb
	 xiN7SjFQ6FkkF7UtdYovhPunv0vuEizoHmisxRzN/wutPzhZ1j7e0zjKneROHf6GE7V2m
	 iK0sn07KcQbt0P1c2eBtW069j7daAPhvkjrAv6rDHRPL4Y1BbbGk2TQmjLs8DC4grALVH
	 bhPq+lreZfPcPw7V5qZhabRxEIAVVmeQ+uo+wkTcqV57sUbdNXhrgRovqWtJWqWb1AoC0
	 1/7uN14uVAUJS5d3qxOGvzMWV8xxvQJ+0+2OLZ3DWFiNRBhXHo/FkeqAmN/bcghQDrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WC0tosiE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B66606A330;
	Mon,  2 Nov 2026 04:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WC0tosiE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABB11F00919;
	Mon,  2 Nov 2026 04:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793594856;
	bh=9ouneipARGjGX7bBxDJKhDjEfYrzEfeGMFSmtVlNjBk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WC0tosiEyWzCyAbDVlZb4EqZx9Xa5WgEjYdOJcX8cP7Dp7zUc44EhtBAyBOEWi2rI
	 P3Ll5NmRJUJjd8MudU4uN+o9uY4H2D5AVxmscAawQqhsDYjyJPnLWOVduGVa7Tk+7Q
	 Kv1uE5SpBtyYaZ1fqarTZpgIiNfD+X0bjXQvS/8Hkz4ykWt68mTIcEC4NtbRpI099E
	 qlKViFo09rCtR3pqfBsc4OQ+U4kAiqc1PChK8G/A+FX7NyaGhr5Ra/GSfAb9n9SCrc
	 GRh8sNX35mBKmWtxpO2oVqAMQdFVIFzSueDi3tp2KYeEPX6GOTvbavMMXzafkrBTrv
	 cyRDjJUnvkfkw==
Subject: Re: [PATCH net v2 2/2] net/iucv: do not count the SHT frame against
 the receive window
From: netdev-bot+sashiko@kernel.org
To: hexlabsecurity@proton.me
Cc: twinkler@linux.ibm.com, davem@davemloft.net, kuba@kernel.org,
 wintera@linux.ibm.com, edumazet@kernel.org, pabeni@redhat.com,
 linux-s390@vger.kernel.org, nagamani@linux.ibm.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, hidayath@linux.ibm.com,
 horms@kernel.org
Date: Mon, 02 Nov 2026 04:47:35 +0000
Message-ID: <179359485562.3131.14348679558796943829@kernel.org>
In-Reply-To: <20261028-b4-disp-dd3e4ebb-v2-2-3747658d59bd@proton.me>
References: <20261028-b4-disp-dd3e4ebb-v2-2-3747658d59bd@proton.me>
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

Critical: 0 · High: 0 (1) · Medium: 1 (1) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The window update in iucv_sock_recvmsg() is now gated by
  `send_win && sk->sk_state == IUCV_CONNECTED`.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but frames a
  HiperSockets peer sends that do not fit in sk_receive_queue are…
- [Medium] Mismatch between the advertised window and the enforced limit.
- [Low] Mismatch in HiperSockets window accounting in the other direction
  (sender over-counts).

--

net/iucv: do not count the SHT frame against the receive window

This patch stops iucv_sock_recvmsg() from counting zero-length HiperSockets
frames, such as the SHT, in msg_recv. It also drops the WARN_ON(1) on the
over-window close. The window update is now sent only while sk_state is
IUCV_CONNECTED, so no update goes out through the hs_dev that
iucv_sock_close() cleared.

Closes: https://lore.kernel.org/netdev/179183431327.434549.446348148837850426@kernel.org/

> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index 5bab6aea910e1..266563fb0e0cb 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -1325,10 +1325,13 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
>  		}
>  
>  		consume_skb(skb);
> -		if (iucv->transport == AF_IUCV_TRANS_HIPER) {
> +		/* The peer counts only the data it sends against its window;
> +		 * the SHT's empty frame is not among them. Over the window,
> +		 * close without a WARN: a peer reaches this from the network.
> +		 */
> +		if (iucv->transport == AF_IUCV_TRANS_HIPER && rlen) {

[Severity: Low]
This is a pre-existing issue, but the sender side has the opposite
mismatch. iucv_sock_sendmsg() increments msg_sent for a zero-length send
as well:

    atomic_inc(&iucv->msg_sent);
    err = afiucv_hs_send(&txmsg, sk, skb, 0);

If the sender has receive credit pending (msg_recv > 0), afiucv_hs_send()
sets AF_IUCV_FLAG_WIN on that frame. afiucv_hs_rcv() then consumes it as
a credit only:

    case (AF_IUCV_FLAG_WIN):
        err = afiucv_hs_callback_win(sk, skb);
        if (skb->len == sizeof(struct af_iucv_trans_hdr)) {
            consume_skb(skb);
            break;
        }

The frame never reaches recvmsg(), so the receiver never counts it and
never credits it back.

Does the sender lose one slot of msglimit_peer on each such send? If so,
iucv_below_msglim() eventually stays false and its own sendmsg() blocks.

Only the local sender's socket is affected. The v2 notes already say
that this frame "is a window update to afiucv_hs_rcv() and never reaches
recvmsg()", and this patch does not touch that path.

>  			atomic_inc(&iucv->msg_recv);
>  			if (atomic_read(&iucv->msg_recv) > iucv->msglimit) {
> -				WARN_ON(1);
>  				iucv_sock_close(sk);
>  				return -EFAULT;
>  			}

[Severity: High]
This isn't a bug introduced by this patch, but the new comment says a
peer reaches this from the network. Is the window enforced anywhere on
the receive side before this read-time check?

Once the receive queue is full, afiucv_hs_callback_rx() appends to
backlog_skb_q with no length or memory limit:

    if (skb_queue_empty(&iucv->backlog_skb_q)) {
        if (__sock_queue_rcv_skb(sk, skb))
            /* handle rcv queue full */
            skb_queue_tail(&iucv->backlog_skb_q, skb);
    } else
        skb_queue_tail(&iucv_sk(sk)->backlog_skb_q, skb);

The backlog skbs are not charged to sk_rmem_alloc. msglimit is checked
only here, when the local application reads, and backlog_skb_q is only
purged by the close that follows.

Can a connected peer that ignores its window keep growing backlog_skb_q
while the application is not reading, until the system runs out of
memory?

The commit message leaves a per-socket backlog budget to the separate
socket-locking rework.

[Severity: Medium]
This is also a pre-existing issue. This check uses the current
iucv->msglimit, but the peer enforces the window it got in the SYN:

afiucv_hs_send():
    if (flags == AF_IUCV_FLAG_SYN)
        phs_hdr->window = iucv->msglimit;

afiucv_hs_callback_syn():
    niucv->msglimit_peer = trans_hdr->window;

iucv_sock_setsockopt(SO_MSGLIMIT) accepts IUCV_BOUND. A connecting socket
stays in that state until the SYN|ACK arrives, so msglimit can be lowered
after the SYN has gone out.

Can a peer that stays within its granted window then push msg_recv past
the lowered msglimit while frames wait in backlog_skb_q? That would close
the socket with -EFAULT.

Removing the WARN makes this less severe. The commit message says the
rework "keeps the advertised window in a field of its own for that".

> @@ -1357,7 +1360,11 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
>  		}
>  		spin_unlock_bh(&iucv->message_q.lock);
>  
> -		if (send_win) {
> +		/* iucv_sock_close() clears hs_dev but leaves sk_receive_queue
> +		 * readable: a frame read after the over-window close must not
> +		 * send a window update.
> +		 */
> +		if (send_win && sk->sk_state == IUCV_CONNECTED) {
>  			err = iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN);

[Severity: Medium]
Is this state check serialized against the over-window close?

iucv_sock_recvmsg() never takes lock_sock(), and message_q.lock is
dropped just above. __iucv_sock_close() runs under lock_sock_nested()
from iucv_sock_close(). After the state changes, it clears hs_dev:

    WRITE_ONCE(iucv->hs_dev, NULL);
    WRITE_ONCE(sk->sk_bound_dev_if, 0);
    dev_put(dev);

Consider two threads reading the same HiperSockets socket while msg_recv
goes over msglimit (a peer sending past its window, or a lowered
SO_MSGLIMIT):

reader A                            reader B
iucv_sock_recvmsg()
  send_win = true
  sk->sk_state == IUCV_CONNECTED
                                    iucv_sock_recvmsg()
                                      msg_recv > msglimit
                                      iucv_sock_close()
                                        __iucv_sock_close()
                                          hs_dev = NULL
  iucv_send_ctrl()
    LL_RESERVED_SPACE(iucv->hs_dev)

Wouldn't reader A still dereference a NULL hs_dev in iucv_send_ctrl()?
Then afiucv_hs_send() returns -ENODEV, and recvmsg() moves the CLOSED
socket back to IUCV_DISCONN.

The NULL check in afiucv_hs_send() reloads hs_dev. It also runs only
after LL_RESERVED_SPACE() has already dereferenced the pointer.

If A loads hs_dev just before B clears it, A also keeps using the
net_device after B's dev_put(), without holding a reference.

The same race existed before this patch, when the call was
unconditional. Here, sk_state is also read with a plain load.

Would taking lock_sock(sk) around the state test and iucv_send_ctrl()
close this? message_q.lock is already released at this point, and
__iucv_sock_close() already calls iucv_send_ctrl() under lock_sock.

>  			if (err) {
>  				sk->sk_state = IUCV_DISCONN;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028-b4-disp-dd3e4ebb-v2-0-3747658d59bd%40proton.me
