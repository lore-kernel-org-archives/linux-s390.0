Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A801A8F84
	for <linux-s390@vger.kernel.org>; Sun, 16 Aug 2026 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786896296; cv=none; b=i8H++0sX87AkwRlqko6jHRQIMy5eouBrYA+7nCtG7PHXGpLmRP7rTtqwPelPRA4pbbogtFvnHs3gi2pOdPkOCwW+oLnZDyALjReFR28H8snEcZV+KTMW8/Gaik8NvhsuGWwyK2JlyynBWJbt1I3L+qX9DP8S3nSVpDEjcYuzag8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786896296; c=relaxed/simple;
	bh=y1l8E7R3zS9lCnzrMKX3a7vU5k1u/JMbYWwKxP1OgqU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CgoVIeDQT/xwMv699aurjv9yCq9bbWzY6xzM0A+2aBzAjOXJDXfSvTL03+ZwGm/nOb3t3Y22KEcYZu3REoAvFnAd6Z1fERLVb7A3g5PdQ0D71AcGDTWSLFkiHJ7WQ1PwG1MJL+KFSO+vlgLpTbT3Xplip3PgurWiFbMQOPZAri4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbtR++QN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbtR++QN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755221F000E9;
	Sun, 16 Aug 2026 16:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786896294;
	bh=4BF1DkZ5w41jJ/RFP93ZUYf3ktJ4GEuW2CdsBBEQ8eY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IbtR++QNLAwS251X5Gy6mQRUb2j+nJWQWpc7EIpSRiDAZjEsiooTuzzTCdlgcdkvY
	 yxdHlwyhyGSpAo3Sv01kewv221xHEu9kZg+Oq62nrKfVbeN7AGuJKAljW0ecQg8MEg
	 Nd3u7woBhZTHIGNiqUcQ7ykfcQirkW1TY5DP3gRBub2ijLHdi5/K/IUMmjkQrjk4xY
	 XcjW0YCuo2JoLznRH5q0htsT/0gBuNlOyZVa2+XZVYkNtfxXC1usa0wI1vmwy9wfi9
	 Qph8l4bV4nCSKQ7Grccg5e94qR/WYe3VKTwV7+m3uAgj/V6hxjXB/kdHZBCJXkwdRu
	 BB+24nzDMy0Gg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/2] net/iucv: send the window update outside
 message_q.lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260815-b4-disp-8a791503-v1-2-fbae9a511144@proton.me>
References: <20260815-b4-disp-8a791503-v1-0-fbae9a511144@proton.me>
 <20260815-b4-disp-8a791503-v1-2-fbae9a511144@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 16:04:53 +0000
Message-Id: <20260816160454.755221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Moving iucv_send_ctrl() outside of message_q.lock introduces a sev=
ere TOCTOU race between concurrent recvmsg calls, allowing unprivileged use=
rspace to bypass flow control and trigger a WARN_ON DoS.

Pre-existing issues:
- [High] Executing iucv_send_ctrl() and modifying sk_state outside of lock =
protection causes spurious -EPIPE connection drops and corrupted socket sta=
tes.
- [High] Concurrent execution of iucv_sock_close() and iucv_send_ctrl() lea=
ds to a NULL pointer dereference on iucv->hs_dev.
- [High] Unbounded backlog_skb_q allows a malicious peer to exhaust host me=
mory (OOM).
- [High] Missing lock acquisition in afiucv_netdev_event() allows list corr=
uption and kernel crashes.
--

--- Patch [2]: [PATCH net 2/2] net/iucv: send the window update outside mes=
sage_q.lock ---
commit 77dbc2e0a9dfbb0a0cd09842d89b0c9e75001a8e
Author: Bryam Vargas <hexlabsecurity@proton.me>

net/iucv: send the window update outside message_q.lock

This commit moves iucv_send_ctrl() outside the message_q.lock in
iucv_sock_recvmsg() to avoid sleeping in an atomic context. The allocation
in iucv_send_ctrl() uses GFP_KERNEL which can sleep, whereas the lock
section is protected by spin_lock_bh.

> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index 0bc4a15f4b565..e31ef3a87ec50 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -1332,16 +1333,18 @@ static int iucv_sock_recvmsg(struct socket *sock,=
 struct msghdr *msg,

[ ... ]

> -			if (iucv->transport =3D=3D AF_IUCV_TRANS_HIPER &&
> -			    atomic_read(&iucv->msg_recv) >=3D
> -							iucv->msglimit / 2) {
> -				err =3D iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN);
> -				if (err) {
> -					sk->sk_state =3D IUCV_DISCONN;
> -					sk->sk_state_change(sk);
> -				}
> -			}
> +			if (iucv->transport =3D=3D AF_IUCV_TRANS_HIPER &&
> +			    atomic_read(&iucv->msg_recv) >=3D iucv->msglimit / 2)
> +				send_win =3D true;
>  		}
>  		spin_unlock_bh(&iucv->message_q.lock);
> +
> +		if (send_win) {
> +			err =3D iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN);

[Severity: High]
Does moving this outside the lock introduce a race condition between
concurrent iucv_sock_recvmsg() calls?

Since send_win is evaluated under the lock but executed after dropping it,
could two threads concurrently evaluate send_win to true and both call
iucv_send_ctrl()?

Looking at afiucv_hs_send(), it locklessly reads and subtracts msg_recv:

confirm_recv =3D atomic_read(&iucv->msg_recv);
...
atomic_sub(confirm_recv, &iucv->msg_recv);
WARN_ON(atomic_read(&iucv->msg_recv) < 0);

If two threads execute this concurrently, could they read the exact same
value, send multiple window updates to the peer, and subtract the same
value multiple times? It appears this would drive msg_recv negative and
trigger the WARN_ON, allowing unprivileged userspace to bypass flow control.

[Severity: High]
This isn't a bug introduced by this patch, but does calling iucv_send_ctrl()
without the socket lock expose a race with device teardown?

Looking at iucv_sock_close(), it nullifies hs_dev concurrently:

if (iucv->hs_dev) {
        dev_put(iucv->hs_dev);
        iucv->hs_dev =3D NULL;

Inside iucv_send_ctrl(), it accesses hs_dev without checking for NULL:

blen =3D sizeof(struct af_iucv_trans_hdr) +
       LL_RESERVED_SPACE(iucv->hs_dev);

Could a concurrent close() racing with iucv_sock_recvmsg() lead to a NULL
pointer dereference here?

> +			if (err) {
> +				sk->sk_state =3D IUCV_DISCONN;
> +				sk->sk_state_change(sk);
> +			}
> +		}
>  	}

[Severity: High]
This is a pre-existing issue, but does modifying sk_state without holding
lock_sock() corrupt the socket state machine?

If iucv_send_ctrl() fails, we locklessly set sk->sk_state =3D IUCV_DISCONN.
Could this corrupt state transitions if racing with a concurrent close()
call?

Additionally, iucv_send_ctrl() performs a non-atomic read-modify-write on
sk_shutdown:

shutdown =3D sk->sk_shutdown;
sk->sk_shutdown &=3D RCV_SHUTDOWN;
...
if (shutdown)
        sk->sk_shutdown =3D shutdown;

Because it is called from iucv_sock_recvmsg() without lock_sock(), could a
concurrent shutdown() call that sets RCV_SHUTDOWN have its update
permanently overwritten and lost when the old state is restored?

[Severity: High]
This is a pre-existing issue, but does the queueing in afiucv_hs_callback_r=
x()
lack bounds checking?

In afiucv_hs_callback_rx():

if (__sock_queue_rcv_skb(sk, skb))
        /* handle rcv queue full */
        skb_queue_tail(&iucv->backlog_skb_q, skb);

If __sock_queue_rcv_skb() rejects the packet because the receive buffer is
full, it is unconditionally appended to backlog_skb_q. Without length
limits or memory accounting on this queue, could a remote peer exhaust
host memory by sending an unlimited stream of packets?

[Severity: High]
This isn't a bug introduced by this patch, but does afiucv_netdev_event()
iterate the socket list safely?

In afiucv_netdev_event():

sk_for_each(sk, &iucv_sk_list.head) {
        iucv =3D iucv_sk(sk);

This iterates over the global iucv_sk_list.head, but it fails to acquire
the required lock before iterating. Could concurrent calls to
iucv_sock_bind() or iucv_sock_kill() modifying the list trigger corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815-b4-disp-8a=
791503-v1-0-fbae9a511144@proton.me?part=3D2
