Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4C72DCF61
	for <linux-s390@vger.kernel.org>; Sat, 22 Aug 2026 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787403325; cv=none; b=Ow21BAbWTiU8FHoF1jXBcIqQtUI5WPa83ocwMf2hlmaIUdehyT0+lsTVl5r3gIj8GF5Q29Wr8uJ4nIFuN+f0Nweo2oVfV53Z3j4qGXNV9jy1HcId9sasFgaK1NNhOarH86aiesQGMav6S3fsLa5Qz2lnI84/8dnviJ3Nah9gl0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787403325; c=relaxed/simple;
	bh=1FVGeEDQE3pTfGRwjwHLyevKqUMhuFwkuBJ3BQ7krfI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TQEBvLRAMqSdHccI8d0oEfJptJ79pG4KNfiZEt4O9xjnFj1J/iFpWOKTTVoUXoySwJvnY/CgD0kcUqNrIaC5stKr2PlAqCtkQXACgYCdASIcod04XAEV0ZVKFxnHGrATL/qWUEeiEHtCiWocbAcDirDR1Zmja1QGivfW/3b9pw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKdxockT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKdxockT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4822C1F000E9;
	Sat, 22 Aug 2026 12:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787403324;
	bh=r9+JDApt6DaCyIru+Qi1SfzwcGZrS/PDvYqMz9G8Cew=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oKdxockT6ljol7pOpcgE4KCLpy0kjNdjuq/Efhu4YpcJOhB12GoAIqivyGjuGYXc/
	 WZPYKHCBZQ0ZUDjVGniGhLW8GJ7dE1SD87rBVaYYEJAyYA/bGDpms/jPfogl5IBLTE
	 QW9mN9BMy5zQeKpuQBSQO7UIUxgYyUkVxxnnm66KXkylPAu1R681MIJkNegnvhEZFc
	 LUGLwcu853AFT3OOUJxHAAbe8RLpFKH/pdCLzoC5d6AoYHvJGLrCWw9kuqissaRicu
	 ijnA2Cckmee+yuNbOVt2tMZ3UbN8orC4JX8+7W1U//PW7/H9n3iLGbsf5wbq9UFQ3K
	 aroiKZDbH/EZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net/iucv: filter frames in afiucv_hs_rcv() by
 ingress device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexandra Winter" <wintera@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260821125501.3718748-1-wintera@linux.ibm.com>
References: <20260821125501.3718748-1-wintera@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 12:55:23 +0000
Message-Id: <20260822125524.4822C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [High] In-place modification of a potentially shared or cloned SKB withou=
t unsharing corrupts memory for concurrent readers.
- [High] Blind reuse of RX SKB for TX without verifying headroom causes skb=
_under_panic (DoS) and malformed frames.
- [High] Unprotected list traversal in afiucv_netdev_event() risks list cor=
ruption and use-after-free.
- [High] Socket and netdev reference leak during incoming connection errors=
 causes unbounded memory consumption and device unregister hangs.
- [High] AF_IUCV RX handlers modify socket state from SoftIRQ context witho=
ut checking if the socket is currently owned by the user.
- [High] Unprivileged processes in restricted network namespaces can create=
 AF_IUCV sockets bound to host interfaces, bypassing network isolation.
--

--- Patch [1]: [PATCH net] net/iucv: filter frames in afiucv_hs_rcv() by in=
gress device ---
commit c0a4d18765a00aae7fc517041e61031313bfee8c
Author: Alexandra Winter <wintera@linux.ibm.com>

net/iucv: filter frames in afiucv_hs_rcv() by ingress device

This commit fixes several issues in afiucv_hs_rcv() where frames arriving
on any net_device could be delivered to an AF_IUCV socket purely based on
transport header fields. It resolves problems with delivering HiperSockets
frames to classic z/VM IUCV sockets, cross-device injection, and network
namespace isolation bypass by strictly checking the ingress device against
the socket's bound device.

Link: https://lore.kernel.org/netdev/20260813-b4-disp-60433a46-v1-1-509e120=
0533e@proton.me/ [1]
Link: https://lore.kernel.org/netdev/20260815-b4-disp-dc82fde4-v1-1-e83b10b=
22ce9@proton.me/ [2]

> Third, all AF_IUCV sockets live in init_net, as iucv_sock_alloc() calls
> sk_alloc(&init_net, ...). But even frames arriving on netdev devices in a
> namespace can be delivered to an IUCV socket. So a process in an
> unprivileged user and network namespace holding only the CAP_NET_RAW
> capability valid within that namespace can send a raw ETH_P_AF_IUCV frame
> on its own lo device and have it matched against init_net sockets.

[Severity: High]
This is a pre-existing issue, but does creating the socket directly in
init_net without validating the caller's namespace allow unprivileged
processes to escape isolation?

In iucv_sock_create(), the socket is allocated unconditionally in init_net:

sk =3D iucv_sock_alloc(sock, protocol, GFP_KERNEL, kern);

Then in iucv_sock_bind(), it scans and allows binding to devices in
init_net regardless of the caller's actual namespace:

for_each_netdev_rcu(&init_net, dev) {

Could this allow an unprivileged container to create an AF_IUCV socket
and bind it to a physical host device?

> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index ea047bab65e7c..4e5cc9da6e068 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -2079,6 +2079,8 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struc=
t net_device *dev,
>  	sk =3D NULL;
>  	read_lock(&iucv_sk_list.lock);
>  	sk_for_each(sk, &iucv_sk_list.head) {
> +		if (iucv_sk(sk)->hs_dev !=3D dev)
> +			continue;
>  		if (trans_hdr->flags =3D=3D AF_IUCV_FLAG_SYN) {
>  			if ((!memcmp(&iucv_sk(sk)->src_name,
>  				     trans_hdr->destAppName, 8)) &&

[Severity: High]
This is a pre-existing issue, but does afiucv_hs_rcv() modify a potentially
shared or cloned SKB in-place without unsharing it?

Earlier in afiucv_hs_rcv(), the payload is modified directly:

net/iucv/af_iucv.c:afiucv_hs_rcv() {
    ...
    trans_hdr =3D iucv_trans_hdr(skb);
    EBCASC(trans_hdr->destAppName, sizeof(trans_hdr->destAppName));
    ...
}

Since this SKB is received from packet_type delivery, could modifying it
without calling skb_unshare() or skb_cow() corrupt data for concurrent
readers like packet sniffers?

Furthermore, afiucv_swap_src_dest() also prepends data using skb_push()
and memset() on this same SKB.

[Severity: High]
This is another pre-existing issue, but is there a risk of an
skb_under_panic when rejecting a connection?

When an incoming SYN frame is rejected, the unmodified RX SKB is passed
to afiucv_swap_src_dest() via afiucv_hs_callback_syn():

net/iucv/af_iucv.c:afiucv_swap_src_dest() {
    ...
    skb_push(skb, ETH_HLEN);
    ...
}

If the incoming frame was crafted with zero or limited headroom, could
this skb_push() without checking skb_headroom() cause a kernel panic?
The SKB is then handed directly to dev_queue_xmit() without further
scrubbing.

[Severity: High]
This isn't a bug introduced by this patch, but does afiucv_netdev_event()
traverse the socket list safely?

When a netdev event occurs, the list is traversed without a lock:

net/iucv/af_iucv.c:afiucv_netdev_event() {
    ...
    sk_for_each(sk, &iucv_sk_list.head) {
    ...
}

Since other threads can concurrently modify this list during socket
creation or destruction, could this unprotected traversal lead to a
use-after-free or list corruption?

[Severity: High]
This is a pre-existing issue, but does rejecting an incoming connection
result in a socket and netdev reference leak?

If afiucv_hs_callback_syn() rejects a connection, it attempts to clean up:

net/iucv/af_iucv.c:afiucv_hs_callback_syn() {
    ...
    if (nsk)
        iucv_sock_kill(nsk);
    ...
}

However, the new socket was initialized with the SOCK_ZAPPED flag cleared,
which causes iucv_sock_kill() to exit early:

net/iucv/af_iucv.c:iucv_sock_kill() {
    ...
    if (!sock_flag(sk, SOCK_ZAPPED) || sk->sk_socket)
        return;
    ...
}

Could this early return skip unlinking the socket and dropping references,
leading to unbounded memory consumption and preventing device
unregistration?

[Severity: High]
This is a pre-existing issue, but do the AF_IUCV RX handlers safely
mutate socket state from SoftIRQ context?

Callbacks like afiucv_hs_callback_synack() acquire the bottom-half lock
and change the state directly:

net/iucv/af_iucv.c:afiucv_hs_callback_synack() {
    ...
    bh_lock_sock(sk);
    ...
    sk->sk_state =3D IUCV_CONNECTED;
    sk->sk_state_change(sk);
    bh_unlock_sock(sk);
    ...
}

If a user process is concurrently calling close() and holding lock_sock(),
could mutating the state here without checking sock_owned_by_user()
corrupt the state machine?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821125501.3718=
748-1-wintera@linux.ibm.com?part=3D1
