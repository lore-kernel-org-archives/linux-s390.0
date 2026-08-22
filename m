Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7C223EAA6
	for <linux-s390@vger.kernel.org>; Sat, 22 Aug 2026 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787397459; cv=none; b=JkWsbJAuF5xU0HKTuLusIbr5vrxebw2OLNCSY0iLlvj0tY6mjrz3AEYQO8GVUBquzDgWCppIYNBcaGdbFy+IFV4JdpOUHCdeTWA/LC6vpvVlo5kMR0zSOPEJCbXhNpf1QkBO0Y0vsNXBWSx02WcqMXd+L0tGQZQW+SWxtjVaw8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787397459; c=relaxed/simple;
	bh=idXHMgn7aZXzkPySqJocQrnCunv0/MN0gxn0WzT14sQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qQnhNT/qJ6SNGxsdZvmaXqZiYgiW20oAzZICpc6vcqWIqQ7RnSr6i1EJ9L298et6CnXhYpvq+ka88aXy4ibM6AiQm8rXH/UBi4Q+e+DRNBkxOMYimsKSJ335m2HeQQ4rXCCDbCgYbkwtjuv+/x8j7RP2eZTeVbJD+FCr/KHHHFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2atYaZX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2atYaZX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB721F000E9;
	Sat, 22 Aug 2026 11:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787397457;
	bh=G2jMC5npKS9xKZfkdRYr83FvW4KOuRGS225TDHQrefk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z2atYaZXIMaXPyvjaVs/M7Gt/zsBIgpF88D1je6ou9fizsHJlln/HfSrs4zxQgQxI
	 gO/pOJQj3EJ8UNMOCl4EAq/1Zf4SZWYvRSTnqZipASjtGCCCegXGXAph8w+ML0HVDl
	 q2QCxofN99myyUdzoN8xUNG+SIst4uMQCVAQAt2FqdppvfRd61EMPntsBOvz+C3OVF
	 mZuZRqEug/xWsBFpDxJ1ttoDRt+W7bYGtaF5X0sXumMd+60hTnlRTl8pVoKy1+WaX3
	 lduBDq5QlGBxlZLG+LoobemBZW1sxYWLB1u5pAC3D+wPIrtyvr7HbhSP5Qckaut8WB
	 MZ/uSCopwMxwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 3/3] net/iucv: send the window update outside
 message_q.lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260821-b4-disp-3a6e8695-v2-3-37597ff723a8@proton.me>
References: <20260821-b4-disp-3a6e8695-v2-0-37597ff723a8@proton.me>
 <20260821-b4-disp-3a6e8695-v2-3-37597ff723a8@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 11:17:37 +0000
Message-Id: <20260822111737.8DB721F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Redundant concurrent window updates cause spurious socket disconne=
ctions due to transient errors.
- [High] Lockless modification of `sk->sk_state` to `IUCV_DISCONN` in error=
 path corrupts the socket state machine.

Pre-existing issues:
- [Critical] Concurrent execution of `iucv_sock_recvmsg` and `iucv_sock_clo=
se` can lead to a NULL pointer dereference of `iucv->hs_dev`.
- [High] Lockless read-modify-write sequence on `sk->sk_shutdown` in `iucv_=
send_ctrl` permanently loses concurrent state updates.
--

--- Patch [3]: [PATCH net v2 3/3] net/iucv: send the window update outside =
message_q.lock ---
commit 38dc50c2f4dfcebf699da12476bf1a5fb529484e
Author: Bryam Vargas <hexlabsecurity@proton.me>

net/iucv: send the window update outside message_q.lock

This patch moves the window update control message dispatch outside the
message_q.lock in iucv_sock_recvmsg(). It avoids sleeping in atomic context
since iucv_send_ctrl() performs a GFP_KERNEL allocation. A boolean flag is
used to defer the send until after the lock is released.

> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
[ ... ]
> @@ -1336,15 +1337,18 @@ static int iucv_sock_recvmsg(struct socket *sock,=
 struct msghdr *msg,
>  				iucv_process_message_q(sk);
>  			if (iucv->transport =3D=3D AF_IUCV_TRANS_HIPER &&
>  			    atomic_read(&iucv->msg_recv) >=3D
> -							iucv->msglimit / 2) {
> -				err =3D iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN);
> -				if (err) {
> -					sk->sk_state =3D IUCV_DISCONN;
> -					sk->sk_state_change(sk);
> -				}
> -			}
> +							iucv->msglimit / 2)
> +				send_win =3D true;
>  		}
>  		spin_unlock_bh(&iucv->message_q.lock);
> +
> +		if (send_win) {
> +			err =3D iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN);

[Severity: High]
Because atomic_read(&iucv->msg_recv) is checked inside the lock, but the
counter is reset later inside afiucv_hs_send() without holding
message_q.lock, can multiple concurrent calls to iucv_sock_recvmsg() set
send_win to true and trigger redundant window updates?

If redundant updates are sent, could transient send buffer exhaustion cause
the socket to unintentionally hit the error path below and disconnect?

[Severity: Critical]
This isn't a bug introduced by this patch, but calling iucv_send_ctrl()
concurrently here exposes a pre-existing race condition.

In iucv_send_ctrl(), LL_RESERVED_SPACE() dereferences iucv->hs_dev:

iucv_send_ctrl()
    blen =3D sizeof(struct af_iucv_trans_hdr) +
           LL_RESERVED_SPACE(iucv->hs_dev);

If a concurrent thread executes iucv_sock_close() and sets iucv->hs_dev
to NULL, does this cause a NULL pointer dereference?

[Severity: High]
This is a pre-existing issue, but there appears to be a concurrency
regression in iucv_send_ctrl() when it caches sk->sk_shutdown.

iucv_send_ctrl()
    if (sk->sk_shutdown & SEND_SHUTDOWN) {
        shutdown =3D sk->sk_shutdown;
        sk->sk_shutdown &=3D RCV_SHUTDOWN;
    }
    skb =3D sock_alloc_send_skb(sk, blen, 1, &err);
    ...
    if (shutdown)
        sk->sk_shutdown =3D shutdown;

Since sock_alloc_send_skb() can sleep, if another thread updates
sk->sk_shutdown (for example, via shutdown(fd, SHUT_RD)) during the
allocation, does the unconditional restore of the cached shutdown state
overwrite and permanently lose the concurrent update?

> +			if (err) {
> +				sk->sk_state =3D IUCV_DISCONN;
> +				sk->sk_state_change(sk);
> +			}
> +		}

[Severity: High]
Does modifying sk->sk_state and calling sk->sk_state_change(sk) locklessly
outside of message_q.lock or lock_sock() corrupt the socket state machine?

If multiple threads hit this error path simultaneously, could it lead to
unordered execution of state change callbacks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-b4-disp-3a=
6e8695-v2-0-37597ff723a8@proton.me?part=3D3
