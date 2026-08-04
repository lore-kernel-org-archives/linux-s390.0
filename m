Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C9A381EA8
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 18:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785867682; cv=none; b=c/YD+Bvk18vasEgHzlHXcTIN0vc+vxO08RG7IWAksDVPr4Vn5eawtRxNewo+/DUGmpZ/KcMnkCM2/uaiF3IApZKJ/FetbZQkNUJwYLJ/opbZDxgCy34AP551mYF82MaXILVxatsHqLYgS6aHPJ2DD/J1HOAYH0BWv6RCQ5kQBQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785867682; c=relaxed/simple;
	bh=dLXjkSOQyCqRaGMqGUOMxrJDVQM6ZsNgoa9Dm8/n1UM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WDVvtek3/ihP48901ZVFLeiEf+1uVQ5cqBDbwTVtt9A98FuEVZ+zTc53lNpbUpGEuUHH8cwMWcs+b4hnn6y1oh1Gmy145xOWayyj/NQdAMjqWueuTqYJSlQHsviE03TolB0vXGbGxT31fogRdjNCQmcuhopkiVZ1yViprynA/I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQsUQg7U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQsUQg7U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535961F00A3F;
	Tue,  4 Aug 2026 18:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785867680;
	bh=Du1bFCnOtaYutJHoUwP78rVAgx+P5NuGbrili6eMMGo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PQsUQg7UCrIlATDr8pVdkh5rcz8FBxFmYefCrdRJiJ1sn47Q/eXDE8gzot46nJb4f
	 0TPP7iJNEQo5pU2fKoPV+0cHiaa5VM3SbBvsfKzdhPqKqjOo5jIgVCVOk/ZT0KL6/I
	 ijAgyZsUk6x0+/Xa8eHgel0XK/BQV5S/orsay0dNfkTqMieXhF/ZU1m8zSk1XlZbKN
	 OIaIqp++D60w+ztXZS4WhuPQItanCbG1455UtyPh08mzi6g3W7YLBoZdS7X2wqdAd7
	 mwoIQCPtwft8RpmFbd+O3MbHPtXFU+UhjbwzyN4u3cw86kir7aA4VxPKH99TBRDvlx
	 DO7BCVXPaaazQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next] net/iucv: fix UAF in afiucv_netdev_event()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nagamani PV" <nagamani@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260803182053.2355882-1-nagamani@linux.ibm.com>
References: <20260803182053.2355882-1-nagamani@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 18:21:19 +0000
Message-Id: <20260804182120.535961F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch introduces a sleep-in-atomic-context bug by calling a sl=
eepable memory allocation function while holding a spinlock (`read_lock_bh`=
) that disables bottom halves.

Pre-existing issues:
- [High] Socket state, shutdown flags, and transmissions are manipulated lo=
cklessly, leading to data races, lost state updates, and a potential NULL p=
ointer dereference if the socket is orphaned concurrently.
--

--- Patch [1]: [PATCH net-next] net/iucv: fix UAF in afiucv_netdev_event() =
---
commit 295060a75254f1d540b1b59d065d45ebee09c8e8
Author: Nagamani PV <nagamani@linux.ibm.com>
Subject: net/iucv: fix UAF in afiucv_netdev_event()

This commit aims to fix a KASAN slab-use-after-free in afiucv_netdev_event(=
) by
protecting the socket list traversal with read_lock_bh() / read_unlock_bh().
This prevents concurrent socket teardown from freeing the socket during
iteration.

> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index ea047bab65e7c..034039c509418 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c

[ ... ]

> @@ -2213,6 +2213,7 @@ static int afiucv_netdev_event(struct notifier_bloc=
k *this,
>  	switch (event) {
>  	case NETDEV_REBOOT:
>  	case NETDEV_GOING_DOWN:
> +		read_lock_bh(&iucv_sk_list.lock);
>  		sk_for_each(sk, &iucv_sk_list.head) {
>  			iucv =3D iucv_sk(sk);
>  			if ((iucv->hs_dev =3D=3D event_dev) &&
>  			    (sk->sk_state =3D=3D IUCV_CONNECTED)) {

[Severity: High]
This isn't a bug introduced by this patch, but does checking and modifying
the socket state here without taking the socket lock create a data race?

If a concurrent iucv_sock_release() sets the state to closed and calls
sock_orphan(sk) (which sets sk->sk_socket =3D NULL) before waiting on
iucv_sk_list.lock, could this event loop read the old state, get delayed,
and invoke iucv_send_ctrl() after the socket is orphaned?

When sock_alloc_send_pskb() is subsequently called inside iucv_send_ctrl(),
if the socket's write buffer is full, it tries to set SOCK_NOSPACE via
set_bit(SOCK_NOSPACE, &sk->sk_socket->flags). Would this result in a NULL
pointer dereference since sk->sk_socket was cleared?

The iucv_send_ctrl() function also directly manipulates sk->sk_shutdown
temporarily without locking the socket:

iucv_send_ctrl() {
    if (sk->sk_shutdown & SEND_SHUTDOWN) {
        shutdown =3D sk->sk_shutdown;
        sk->sk_shutdown &=3D RCV_SHUTDOWN;
    }
    ...
}

Does this create a race window that loses concurrent shutdown updates?

>  				if (event =3D=3D NETDEV_GOING_DOWN)
>  					iucv_send_ctrl(sk, AF_IUCV_FLAG_FIN);

[Severity: High]
Does this introduce a sleep-in-atomic-context bug?

By acquiring read_lock_bh() earlier in afiucv_netdev_event(), the code now
executes in an atomic context. However, iucv_send_ctrl() performs a memory
allocation that can block:

afiucv_netdev_event()
   read_lock_bh(&iucv_sk_list.lock)
   iucv_send_ctrl()
      sock_alloc_send_skb()

The allocation relies on sk->sk_allocation (which defaults to
GFP_KERNEL | GFP_DMA for AF_IUCV sockets). Since these flags contain
__GFP_DIRECT_RECLAIM, will this allow the allocator to sleep and trigger
a "scheduling while atomic" panic?

>  				sk->sk_state =3D IUCV_DISCONN;
>  				sk->sk_state_change(sk);
>  			}
>  		}
> +		read_unlock_bh(&iucv_sk_list.lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803182053.2355=
882-1-nagamani@linux.ibm.com?part=3D1
