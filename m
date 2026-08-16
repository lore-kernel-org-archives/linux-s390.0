Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ED52475E3
	for <linux-s390@vger.kernel.org>; Sun, 16 Aug 2026 16:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786896297; cv=none; b=q7GQXoi6eZDj6PV9TrAB4VxuIX9YMsWPIoURsPyM5jLbWvFiyJ3BCkRK+WYOggfHRjxv+X0tdsUT4V3jzWK7hUA/liyCWMvpl5LwJz2e3fy+A+PMLVeBfZeSSRsw1nl7L9eWIdH7s68/UtoeN9jHkESqrg3bQbMTHttSp2brYzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786896297; c=relaxed/simple;
	bh=ZWx09KUg4VsTS39TmY8ljFJLaIuvxaSFq8S7ytXjBRM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=niZ0CcvYBTH/3ouxxoMLWAFAEaWYwG0UXHAGRTjuAlDAh1J6cwSAOFroedEwAX3JSmFP0k/pftsw7IqBzv20NcV+92YYrdhraUX7fv1vIVhPDWpb09UCR0x1HaRC9bwBYV0fJNNBw9XXkkEEGxlGqDFyOCnDAiag6EXZ6OT1SDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=no71DwA3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="no71DwA3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EA31F00A3A;
	Sun, 16 Aug 2026 16:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786896295;
	bh=h6KF/MNuY/QdmBp3c/Pwp/WGbWUzrpEANtUwJswWbB8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=no71DwA3LSKryfoZUtpNrzy0j4W+Zdp8rKTHGiGoDnBcUoPSGQXFl3Q8qOx05y1NM
	 aLopPT9VEj5ExAMl5xk/Gt601wzNXok5nHncA8SByY5YwxVEuQcaGzE8c0AHofximE
	 oGViehjV+EzDVRc1LqyTOhLcq1J49auhTMvVv4wPJEaLqwHtnUESk4nL+WPMqEEBM2
	 +bZD+ewTAnZSAOeYDdqizPwJ7ELxvIgSW45Te4smRQhpwyvpw35BDwXOa1vMdzOmWv
	 zv1QGnzVYOCMUdt3XabjAOOHRRB3YGUcFffe/3nt30TprsyFZpxzCuBIZHe4EYN1NM
	 oNDMh6Pj5BTnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/2] net/iucv: only send the window update on
 HiperSockets sockets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260815-b4-disp-8a791503-v1-1-fbae9a511144@proton.me>
References: <20260815-b4-disp-8a791503-v1-0-fbae9a511144@proton.me>
 <20260815-b4-disp-8a791503-v1-1-fbae9a511144@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 16:04:54 +0000
Message-Id: <20260816160455.55EA31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calling a sleeping memory allocation function (`sock_alloc_send_sk=
b`) while holding a spinlock (`spin_lock_bh`) causes a sleep-in-atomic bug.
- [High] Concurrent `recvmsg` calls can trigger a Use-After-Free or NULL po=
inter dereference of the network device.
- [High] Iterating over the global socket list `iucv_sk_list` without holdi=
ng the required read lock leads to list corruption and data races.
--

--- Patch [1]: [PATCH net 1/2] net/iucv: only send the window update on Hip=
erSockets sockets ---
commit 8751dd7a500553e40dc5fbd7b9476a646ff45fb5
Author: Bryam Vargas <hexlabsecurity@proton.me>

net/iucv: only send the window update on HiperSockets sockets

> iucv_sock_recvmsg() sends AF_IUCV_FLAG_WIN without testing the transport,
> but that flag exists only on HiperSockets. On a classic z/VM socket
> iucv->hs_dev is NULL and iucv_send_ctrl() sizes the skb from
> LL_RESERVED_SPACE(iucv->hs_dev), so the read goes through NULL;
> afiucv_hs_send() then returns -ENODEV and recvmsg() moves the socket to
> IUCV_DISCONN. Reaching it takes an application that sets SO_MSGLIMIT to 1
> on its own socket, since msg_recv is incremented only on the HiperSockets
> path, so this is a correctness fix rather than a security one.
>=20
> Test the transport. Three of the other four iucv_send_ctrl() callers do;
> the fourth, afiucv_netdev_event(), selects on hs_dev instead. Without
> relocate_lowcore the NULL read lands in mapped lowcore and the symptom is
> the spurious disconnect; with lowcore relocation it faults.

[Severity: High]
This is a pre-existing issue, but does iterating over the global socket list
iucv_sk_list locklessly in afiucv_netdev_event() lead to list corruption and
data races?

afiucv_netdev_event() traverses the iucv_sk_list.head list using sk_for_eac=
h()
while holding only the RTNL lock:

net/iucv/af_iucv.c:afiucv_netdev_event() {
	...
	sk_for_each(sk, &iucv_sk_list.head) {
		iucv =3D iucv_sk(sk);
		if ((iucv->hs_dev =3D=3D event_dev) &&
	...
}

However, sockets can be created (via iucv_sock_bind() -> iucv_sock_link()) =
or
destroyed (via iucv_sock_kill() -> iucv_sock_unlink()) concurrently. These
modify the list while holding write_lock_bh(&iucv_sk_list.lock), but NOT the
RTNL lock.

Iterating a mutated hlist locklessly without acquiring
read_lock(&iucv_sk_list.lock) or rcu_read_lock() could violate locking
invariants and lead to list corruption, infinite loops, or a Use-After-Free.

>=20
> Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
>=20
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
This isn't a bug introduced by this patch, but doesn't calling
iucv_send_ctrl() here cause a sleep-in-atomic bug?

Since iucv_sock_recvmsg() is holding spin_lock_bh(&iucv->message_q.lock):

net/iucv/af_iucv.c:iucv_sock_recvmsg() {
	...
	spin_lock_bh(&iucv->message_q.lock);
	...
	if (iucv->transport =3D=3D AF_IUCV_TRANS_HIPER && ...) {
		err =3D iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN);
	...
}

And iucv_send_ctrl() calls sock_alloc_send_skb():

net/iucv/af_iucv.c:iucv_send_ctrl() {
	...
	skb =3D sock_alloc_send_skb(sk, blen, 1, &err);
	...
}

Which can sleep because sk->sk_allocation defaults to GFP_KERNEL (retaining
__GFP_DIRECT_RECLAIM).

Could this trigger a kernel panic from might_sleep() or a soft lockup?


[Severity: High]
This is also a pre-existing issue, but could concurrent recvmsg calls trigg=
er
a Use-After-Free or NULL pointer dereference of the network device?

sys_recvmsg() can be called concurrently by multiple threads on the same
socket since iucv_sock_recvmsg() does not hold the socket lock.

If Thread A reads enough messages to hit
atomic_read(&iucv->msg_recv) > iucv->msglimit, it calls iucv_sock_close(sk).
This acquires the socket lock, drops the reference to iucv->hs_dev, and sets
it to NULL:

net/iucv/af_iucv.c:iucv_sock_close() {
	...
	dev_put(iucv->hs_dev);
	iucv->hs_dev =3D NULL;
	...
}

Concurrently, if Thread B hits the check below and calls iucv_send_ctrl():

net/iucv/af_iucv.c:iucv_send_ctrl() {
	...
	blen =3D sizeof(struct af_iucv_trans_hdr) +
	       LL_RESERVED_SPACE(iucv->hs_dev);
	...
}

It reads and dereferences iucv->hs_dev locklessly, which could result in a =
UAF
or NULL pointer dereference.

>  				if (err) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815-b4-disp-8a=
791503-v1-0-fbae9a511144@proton.me?part=3D1
