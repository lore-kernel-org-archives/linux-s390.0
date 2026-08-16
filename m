Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BCB12FF69
	for <linux-s390@vger.kernel.org>; Sun, 16 Aug 2026 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786896456; cv=none; b=k1toynibVxJW0Mk53Mlp0JywrToSUsS9j/JT45qkBPJFfVlI1uvyWHP7VRUhzc1Pj1yPjE0ie5pL45eZgjl0n4lN0SsBNFrmK36KOwV3XCs+mhUBk8gYEaMcE5ncuc+bzG+pA7m6C2X7IVIzuD/uAlx8A91C2D53aJQPQqyQxP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786896456; c=relaxed/simple;
	bh=8T3DyOdyul4rt3Q+0sIRJnlAzYiVGCIKnKBmYr/BNwQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pk/aCGGx3WomeM458qBBGqfsgtboi+DaZwfKqtCQU62xT9rcLqg+NDjj0Vm4NDutOZs7OLoA6mD5SbvFVPxoW1h1M9Bp0EPriScPZ6rULp5cXycgzMch8Q9ewyhZ3YRvJbUv9zp3qJuPyPU7UPd7g4CMqRJL/15zy+N/E3Gk4Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3kKUoHI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3kKUoHI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFE11F00A3A;
	Sun, 16 Aug 2026 16:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786896454;
	bh=p7j+l5qZXCMJu3Va0kLqVEzSM8JblI9jvL0MQZERhSQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N3kKUoHIKv/Rm2HT9lCajcjAVmIn0KLFdEp+8dYytKtSXqn0cV2ileJyEJulGeuKB
	 /fN/pIfMnAJaia6KTXm+h68HdY6v+bT/0ZmZ0RUBKAFHAnUrTtMm0Cj9iZbsXvVdZ5
	 phYRarNxbSCy6MxyYTf9WVVe/uog4ZGahqsDHZZNIaeGuwCOn1YD1dzv3XgcRCL6sG
	 JxpVauX0vwoAyUfUuf6oMKEwLDT4NkwxzYzPRASQNbflTGBKC/MDDzHKnSpssPHV94
	 DVYn4t2Lkg98G7tJQHMpumq3DGGtiqAT+4LM0YVV5Uw9tHgVZR4upcS56sB9LL4//e
	 8Qtn7pdQTGFRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/2] net/iucv: drop HiperSockets frames from other
 network namespaces
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260815-b4-disp-dc82fde4-v1-1-e83b10b22ce9@proton.me>
References: <20260815-b4-disp-dc82fde4-v1-0-e83b10b22ce9@proton.me>
 <20260815-b4-disp-dc82fde4-v1-1-e83b10b22ce9@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 16:07:33 +0000
Message-Id: <20260816160733.CCFE11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] AF_IUCV allows unprivileged users in non-initial network names=
paces to create sockets in the initial network namespace, bypassing namespa=
ce isolation.
- [High] Netdevice reference count leak during NETDEV_UNREGISTER leads to k=
ernel hangs.
- [High] Bypass of `lock_sock()` mutual exclusion in softirq receive path l=
eads to data corruption.
- [High] TOCTOU race in `afiucv_hs_callback_rx` leads to silent SKB memory =
leak.
- [High] Newly allocated IUCV sockets leak memory and references when an er=
ror occurs during connection request processing.
- [High] Incoming packets bypass `sk_rcvbuf` limits via unbounded queuing t=
o `backlog_skb_q`, leading to OOM.
--

--- Patch [1]: [PATCH net 1/2] net/iucv: drop HiperSockets frames from othe=
r network namespaces ---
commit f9050fb5eddf9fc6d107045a06d53a731b334db3
Author: Bryam Vargas <hexlabsecurity@proton.me>

net/iucv: drop HiperSockets frames from other network namespaces

This commit adds a namespace check to afiucv_hs_rcv() to drop HiperSockets
frames from other network namespaces. Because iucv_packet_type lacks specif=
ic
namespace bindings, it previously landed in the global ptype_base[], allowi=
ng
frames from namespaces holding CAP_NET_RAW to interact with sockets owned by
the initial namespace.

> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index ea047bab65e7c..e3ec965d96ca7 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -2064,6 +2064,11 @@ static int afiucv_hs_rcv(struct sk_buff *skb, stru=
ct net_device *dev,
>  	int err =3D NET_RX_SUCCESS;
>  	char nullstring[8];
> =20
> +	if (!net_eq(dev_net(dev), &init_net)) {
> +		kfree_skb(skb);
> +		return NET_RX_SUCCESS;
> +	}
> +
>  	if (!pskb_may_pull(skb, sizeof(*trans_hdr))) {
>  		kfree_skb(skb);
>  		return NET_RX_SUCCESS;

[Severity: Critical]
This is a pre-existing issue, but does iucv_sock_create() bypass namespace
isolation?

A process in a non-initial network namespace calling socket(AF_IUCV, ...)
ignores the passed network namespace and unconditionally allocates the sock=
et
in init_net:

net/iucv/af_iucv.c:iucv_sock_create() {
    ...
    sk =3D iucv_sock_alloc(sock, protocol, GFP_KERNEL, kern);
    // inside iucv_sock_alloc:
    sk =3D sk_alloc(&init_net, PF_IUCV, prio, &iucv_proto, kern);
    ...
}

Subsequently, iucv_sock_bind() iterates through init_net devices and binds =
the
socket to them. This appears to allow local users in containers with socket
creation privileges to bypass namespace isolation and communicate over init=
_net
devices.

[Severity: High]
This isn't a bug introduced by this patch, but is there a netdevice referen=
ce
count leak during NETDEV_UNREGISTER?

When an AF_IUCV socket binds to a HiperSockets device via iucv_sock_bind(),
it takes a reference to the device using dev_hold(dev). The netdevice
notifier explicitly ignores the NETDEV_UNREGISTER event:

net/iucv/af_iucv.c:afiucv_netdev_event() {
    ...
    case NETDEV_DOWN:
    case NETDEV_UNREGISTER:
    default:
        break;
    ...
}

If a device is unregistered while a socket remains open, it seems the
unreleased reference could prevent the device from being fully removed,
causing the kernel to hang indefinitely in netdev_wait_allrefs().

[Severity: High]
This is a pre-existing issue, but does afiucv_hs_callback_syn() bypass
lock_sock() mutual exclusion?

The HiperSockets receive path (afiucv_hs_rcv) executes in softirq context.
Callbacks acquire bh_lock_sock(sk) but fail to check sock_owned_by_user(sk):

net/iucv/af_iucv.c:afiucv_hs_callback_syn() {
    ...
    bh_lock_sock(sk);
    if ((sk->sk_state !=3D IUCV_LISTEN) || ...
    ...
}

If user context is currently holding lock_sock() (e.g., executing close()),
sk->sk_lock.owned is 1, but the softirq ignores this and modifies the socket
state concurrently. Could this lead to data races and socket state corrupti=
on?

[Severity: High]
This isn't a bug introduced by this patch, but is there a TOCTOU race in
afiucv_hs_callback_rx() leading to a silent SKB memory leak?

The code locklessly checks sk->sk_state:

net/iucv/af_iucv.c:afiucv_hs_callback_rx() {
    ...
    if (sk->sk_state !=3D IUCV_CONNECTED) {
        kfree_skb(skb);
        return NET_RX_SUCCESS;
    }
    ...
}

Concurrently, iucv_sock_close() can execute, set the state to IUCV_CLOSED,
and purge backlog_skb_q. If the softirq reads the state as IUCV_CONNECTED
before it is updated, but queues the SKB after iucv_sock_close() has purged
the queue, the SKB lands in backlog_skb_q of a closing socket.

Since iucv_sock_destruct() fails to purge backlog_skb_q, is the SKB
permanently leaked?

[Severity: High]
This is a pre-existing issue, but do newly allocated IUCV sockets leak memo=
ry
and references when an error occurs during connection request processing?

In afiucv_hs_callback_syn(), a new socket is allocated via iucv_sock_alloc(=
),
which clears its SOCK_ZAPPED flag. On the error path, it calls
iucv_sock_kill(nsk):

net/iucv/af_iucv.c:afiucv_hs_callback_syn() {
    ...
    err =3D dev_queue_xmit(skb);
    if (nsk)
        iucv_sock_kill(nsk);
    ...
}

However, iucv_sock_kill() returns immediately if !sock_flag(sk, SOCK_ZAPPED=
):

net/iucv/af_iucv.c:iucv_sock_kill() {
    ...
    if (!sock_flag(sk, SOCK_ZAPPED) || sk->sk_socket)
        return;
    ...
}

Since the socket is neither unlinked nor freed, can a remote sender exploit
this by spamming AF_IUCV SYN packets to exhaust kernel memory?

[Severity: High]
This isn't a bug introduced by this patch, but do incoming packets bypass
sk_rcvbuf limits?

Incoming data packets are appended to the socket's receive queue via
__sock_queue_rcv_skb(). If this fails because the receive buffer limit is
exceeded, the packet is queued to iucv->backlog_skb_q:

net/iucv/af_iucv.c:afiucv_hs_callback_rx() {
    ...
    if (__sock_queue_rcv_skb(sk, skb))
        /* handle rcv queue full */
        skb_queue_tail(&iucv->backlog_skb_q, skb);
    ...
}

Since backlog_skb_q lacks length limits, could a remote attacker sending a
continuous stream of packets force the kernel to continuously allocate SKBs
and bypass flow control limits?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815-b4-disp-dc=
82fde4-v1-0-e83b10b22ce9@proton.me?part=3D1
