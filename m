Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD16846982A
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 12:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711919; cv=none; b=jrVr0+ev7XLPNG3TXFnPoact52VvGPgrjyAwl2WC40JcRmipn4nBHrp0fgP8ApflXfCypzw1l5jWKOWS8BMPu3KbS2UVwJsx1MAKmhrW0j9cSNXvTrj+lTyOvh82AG0rR1Vv7A7vLKHlRVLAaopoZIl95jJ5nrAuuvQpRjq3VGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711919; c=relaxed/simple;
	bh=h6Ygxy3TthbYP0Ld9lYtaxIRFGtETgU9gqXPLiChbvE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LHwpuV0GOCWHxW1Nx6CFUpbp9KYkCxweBAQvyQcwtGhWurdw5fqN+P9qgetoxIUMaziWeVVtF+Nm2jDeDAhzdXfeDEhpMMEKELHgPhwICeNXH3Lt9gmlKfD17r3Q0Ccq9Mpt2d04AoBFcK3UzTBf6BSuOlFolv/HZ8/N3a+67N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERB3xnBN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERB3xnBN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03BC1F000E9;
	Fri, 14 Aug 2026 12:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786711915;
	bh=rtl0BfhHWsZNBjhftTxvkRFAfn+uZtMctFdbmi7an3A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ERB3xnBNeLryYBqhN2qm/5iAVo3MK68XjxP4B2QKvnNOV9Dl1BVdsfhEENujCCsbS
	 DoP2aHUIYyx1ojbjN/HXMGpzMQQhz4QKT/nwfCMyG5YsvK8c+Fo1SuQ+4R2TBhGGNJ
	 0mJGKa0vKo+TIS+zyhiinEprjmTRAJ6xxR4u910ni+W1SnXr8Xucw4/b+1OWA6+ZEL
	 PbIdBBAfyqaI9Eq8omDPC/0xnUABpSIxKegJXF04jKB2Be+MtCojhDORs6b2EkWIVF
	 YCZ9MYo09nNaiFXC6s1G0b3J4/Kq4FXOs8UBi/ZWy7VPDvhErEuqPJ9XM1cxc78gQo
	 KUCGyIhkkOsgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net/iucv: only deliver HiperSockets frames to
 HiperSockets sockets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260813-b4-disp-60433a46-v1-1-509e1200533e@proton.me>
References: <20260813-b4-disp-60433a46-v1-1-509e1200533e@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 12:51:54 +0000
Message-Id: <20260814125154.A03BC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unchecked `skb_push()` in `afiucv_swap_src_dest()` causes kern=
el panic (`skb_under_panic`) due to insufficient headroom.
- [High] In-place modification of potentially shared or cloned SKB payload =
in `afiucv_hs_rcv()`.
- [High] Invalid transmission of a shared/cloned RX SKB directly via `dev_q=
ueue_xmit()`.
- [High] Missing network namespace validation allows cross-namespace packet=
 injection and processing.
- [High] Unprotected list iteration in `afiucv_netdev_event` without acquir=
ing `iucv_sk_list.lock`.
- [High] `afiucv_hs_callback_txnotify` modifies socket state without holdin=
g the socket lock.
--

--- Patch [1]: [PATCH net] net/iucv: only deliver HiperSockets frames to Hi=
perSockets sockets ---
commit c7ea9342df754a7a4600b67180607cae05a3e24c
Author: Bryam Vargas <hexlabsecurity@proton.me>

net/iucv: only deliver HiperSockets frames to HiperSockets sockets
   =20
afiucv_hs_rcv() selects a socket out of iucv_sk_list by the four name
fields alone, with no test on iucv->transport, so a frame arriving over
HiperSockets can be delivered to a socket bound to the classic z/VM IUCV
transport. iucv_sock_bind() makes that reachable rather than theoretical:
a bind to the local guest userid always takes the classic path, even on a
guest that also carries a HiperSockets device with the same identifier.

> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index ea047bab65e7c..5fb6793b9a64a 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -2079,6 +2079,8 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struc=
t net_device *dev,
>  	sk =3D NULL;
>  	read_lock(&iucv_sk_list.lock);
>  	sk_for_each(sk, &iucv_sk_list.head) {
> +		if (iucv_sk(sk)->transport !=3D AF_IUCV_TRANS_HIPER)
> +			continue;
>  		if (trans_hdr->flags =3D=3D AF_IUCV_FLAG_SYN) {
>  			if ((!memcmp(&iucv_sk(sk)->src_name,
>  				     trans_hdr->destAppName, 8)) &&

[Severity: High]
This is a pre-existing issue, but I noticed afiucv_hs_rcv() modifies the SKB
in-place without checking if it is shared or cloned:

net/iucv/af_iucv.c:afiucv_hs_rcv() {
    ...
    trans_hdr =3D iucv_trans_hdr(skb);
    EBCASC(trans_hdr->destAppName, sizeof(trans_hdr->destAppName));
    ...
}

Does this corrupt the payload for other consumers if the networking core
delivered the SKB as shared or cloned?

[Severity: High]
This is a pre-existing issue, but I noticed afiucv_hs_rcv() does not check =
the
network namespace before processing the packet:

net/iucv/af_iucv.c:afiucv_hs_rcv() {
    static int afiucv_hs_rcv(struct sk_buff *skb, struct net_device *dev,
                             struct packet_type *pt, struct net_device *ori=
g_dev)
    {
        ...
    }
}

Could an unprivileged user with CAP_NET_RAW in a container namespace craft =
and
send ETH_P_AF_IUCV packets on their local dummy or loopback device, bypassi=
ng
namespace isolation?

[Severity: Critical]
This is a pre-existing issue, but I noticed an unchecked skb_push() that co=
uld
cause a panic:

net/iucv/af_iucv.c:afiucv_swap_src_dest() {
    ...
    skb_push(skb, ETH_HLEN);
    memset(skb->data, 0, ETH_HLEN);
}

When afiucv_hs_callback_syn() bounces unmatched SYN packets, it passes the
newly received SKB to afiucv_swap_src_dest(). If an attacker injects a SYN
packet with less than 14 bytes of headroom, will this unconditionally push =
into
the SKB headroom and trigger skb_under_panic()?

[Severity: High]
This is a pre-existing issue, but does afiucv_hs_callback_syn() pass a rece=
ived
RX SKB directly to the TX path?

net/iucv/af_iucv.c:afiucv_hs_callback_syn() {
    ...
    afiucv_swap_src_dest(skb);
    trans_hdr->flags =3D AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_FIN;
    err =3D dev_queue_xmit(skb);
    ...
}

If the SKB was delivered as shared or cloned, will modifying and transmitti=
ng
it trigger a WARN_ON(1) in __dev_queue_xmit() and violate buffer handoff
safety?

[Severity: High]
This is a pre-existing issue, but does afiucv_netdev_event() iterate over t=
he
socket list without acquiring the read lock?

net/iucv/af_iucv.c:afiucv_netdev_event() {
    ...
    case NETDEV_GOING_DOWN:
        sk_for_each(sk, &iucv_sk_list.head) {
            iucv =3D iucv_sk(sk);
            ...
}

While this callback runs with the RTNL lock held, can concurrent socket cre=
ation
or destruction (which only hold the iucv_sk_list.lock) modify the list and
cause a use-after-free or infinite loop here?

[Severity: High]
This is a pre-existing issue, but does afiucv_hs_callback_txnotify() modify=
 the
socket state locklessly?

net/iucv/af_iucv.c:afiucv_hs_callback_txnotify() {
    ...
    if (sk->sk_state =3D=3D IUCV_CONNECTED) {
        sk->sk_state =3D IUCV_DISCONN;
        sk->sk_state_change(sk);
    }
    ...
}

Since this is called by the underlying driver outside of process context, d=
oes
modifying the state without holding bh_lock_sock(sk) create data races with
other socket operations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813-b4-disp-60=
433a46-v1-1-509e1200533e@proton.me?part=3D1
