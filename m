Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DEE23EAA6
	for <linux-s390@vger.kernel.org>; Sat, 22 Aug 2026 11:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787397461; cv=none; b=cdgG4Ly+KqdJ7DF2hSEgpODJwSfdEk/rUCKEhXBimSKeUiW+tyCHNBLPbF7JDXKJ1+tOkPb982xdCGW25NdMUmXvRQJ2m3bD3eMGVgYpm11P/J8kou85ZN+AevQGuYbth826cH9FUtY04xDKFxNJ4v1s2sI5m6EZx1YuFqpDTQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787397461; c=relaxed/simple;
	bh=8F9jBCdNuuCW3GroKIcFWWCsIG+dkpA96nsNkzeTBBk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UXOXuCDywY+/xzzDJYpRDPp8NVfLgvnrr7z1kmHIAS5CDUertoWnZAy5arEXlfoJrBjq/pJzDcICD4PXygIK1kF9DIMLAYKamx4JKZPZPxl2sjbLpAVU59W+p0zxVVX46mqcwEfDJet7xmUIDuMtaJlTNVD14vLfxxa1qmaKPx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INhkN/8m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INhkN/8m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A491F00A3D;
	Sat, 22 Aug 2026 11:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787397459;
	bh=UMLPKT2pINNpP/YqIaFIdVDcE0K6gfpqwrR3S8YCPbY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=INhkN/8mZxOnskUWCSo5rGxNQ1Fod6AnIHD+RATWrtsGqgOt9wl2GryvNkSHlw0Zd
	 pu7OhiDGXeOpVMgQXU6Ftiu+46ex5/9kIqmqck3s03cxgx9F/e6dpC04ftidMfhYIV
	 xJXpXmOO8qnF6tbKZ6ATKqDxC+Y+D0y/nrPZDsgPVnai87b9qkLb3J09PMKLSbNqDe
	 oqKXxNMAGZOSjNUVZVBwgBM8xh+MPpKTd/O79CXuAXOD4uGEnmDcfoA/4I8tjbJIA/
	 t8OTtrP76vcZj3b7BLsbAvlc8vNLhsdp0nq7xMPntFQUwlvHZVwVsam4W2uhEejPm1
	 3A0/ii8B3tUyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 1/3] net/iucv: only send the window update on
 HiperSockets sockets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260821-b4-disp-3a6e8695-v2-1-37597ff723a8@proton.me>
References: <20260821-b4-disp-3a6e8695-v2-0-37597ff723a8@proton.me>
 <20260821-b4-disp-3a6e8695-v2-1-37597ff723a8@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 11:17:38 +0000
Message-Id: <20260822111739.37A491F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `iucv_sock_recvmsg` and `iucv_send_ctrl` perform unprotected read-=
modify-restore operations on `sk->sk_shutdown`, clobbering concurrent state=
 changes from `shutdown()`.
- [High] Concurrent execution within `iucv_sock_recvmsg()` can cause a data=
 race leading to a NULL pointer dereference of `iucv->hs_dev`.
- [High] Iterating over `iucv_sk_list.head` without acquiring the associate=
d lock leads to race conditions and potential use-after-free or list corrup=
tion.
--

--- Patch [1]: [PATCH net v2 1/3] net/iucv: only send the window update on =
HiperSockets sockets ---
commit 50e666866fa1b6d2153e6efa369820e5171cf305
Author: Bryam Vargas <hexlabsecurity@proton.me>

net/iucv: only send the window update on HiperSockets sockets

This commit fixes an issue where an unconditional window update on classic
z/VM sockets can result in a spurious disconnect or a fault. It adds a check
to only send the window update if the transport is HiperSockets.

Cc: stable@vger.kernel.org

> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index ea047bab65e7c..0bc4a15f4b565 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -1331,7 +1331,8 @@ static int iucv_sock_recvmsg(struct socket *sock, s=
truct msghdr *msg,
>  		if (skb_queue_empty(&iucv->backlog_skb_q)) {
>  			if (!list_empty(&iucv->message_q.list))
>  				iucv_process_message_q(sk);
> -			if (atomic_read(&iucv->msg_recv) >=3D
> +			if (iucv->transport =3D=3D AF_IUCV_TRANS_HIPER &&
> +			    atomic_read(&iucv->msg_recv) >=3D
>  							iucv->msglimit / 2) {
>  				err =3D iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN);

[Severity: High]
This is a pre-existing issue, but could concurrent execution within
iucv_sock_recvmsg() cause a data race leading to a NULL pointer dereference
of iucv->hs_dev?

If multiple threads execute recvmsg() concurrently on the same socket, they
can dequeue packets and increment iucv->msg_recv without mutual exclusion
earlier in the function:

    if (atomic_read(&iucv->msg_recv) > iucv->msglimit) {
        WARN_ON(1);
        iucv_sock_close(sk);
        return -EFAULT;
    }

Calling iucv_sock_close() acquires the socket lock, drops the device
reference, and sets iucv->hs_dev =3D NULL.

Another concurrent thread executing recvmsg() might evaluate the send_win
condition as true and subsequently call iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN=
).

Since iucv_send_ctrl() accesses iucv->hs_dev via LL_RESERVED_SPACE() without
holding the socket lock:

    blen =3D sizeof(struct af_iucv_trans_hdr) +
           LL_RESERVED_SPACE(iucv->hs_dev);

wouldn't this dereference NULL if the first thread nullified the device
pointer?

[Severity: High]
This is a pre-existing issue, but is it possible for concurrent updates to
sk_shutdown to be lost?

Looking at iucv_sock_recvmsg(), we modify sk_shutdown directly without
holding the socket lock:

    if (!rlen)
        sk->sk_shutdown =3D sk->sk_shutdown | RCV_SHUTDOWN;

Additionally, in iucv_send_ctrl(), the stale state is saved, modified, and
blindly restored without locking:

    shutdown =3D sk->sk_shutdown;
    sk->sk_shutdown &=3D RCV_SHUTDOWN;
    ...
    if (shutdown)
        sk->sk_shutdown =3D shutdown;

If Thread A executes recvmsg() while Thread B concurrently executes shutdow=
n(),
could Thread A overwrite and erase the flags (e.g., SEND_SHUTDOWN) set by
Thread B?

[Severity: High]
This is a pre-existing issue, but does iterating over iucv_sk_list.head
without acquiring the associated lock in afiucv_netdev_event() lead to
race conditions?

net/iucv/af_iucv.c:afiucv_netdev_event() {
    ...
    case NETDEV_GOING_DOWN:
        sk_for_each(sk, &iucv_sk_list.head) {
            iucv =3D iucv_sk(sk);
            if ((iucv->hs_dev =3D=3D event_dev) &&
    ...
}

Concurrently, if a socket is created (iucv_sock_bind) or destroyed
(iucv_sock_kill), the list is mutated under write_lock_bh(&iucv_sk_list.loc=
k).

Could this lockless traversal dereference invalid pointers or freed socket
structures during a NETDEV_GOING_DOWN or NETDEV_REBOOT event?

>  				if (err) {
>  					sk->sk_state =3D IUCV_DISCONN;
>  					sk->sk_state_change(sk);
>  				}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-b4-disp-3a=
6e8695-v2-0-37597ff723a8@proton.me?part=3D1
