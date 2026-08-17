Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D88364959;
	Mon, 17 Aug 2026 20:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786998340; cv=none; b=cI9hui1JkqD3CiQa9nnYzJYEfKTavOoKGPp5aKes/TjbvnDqa/EMy4kFwTdGloeb6uLR6w5fAcydPoV0Qgff9+lchzdLPsW60qFrKJn0/dWruBl/QOol4FzOAi7aTtjPPcE/cfXuBClP5rPzwIvF38evN3Cpc5cduT4pNj0u7rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786998340; c=relaxed/simple;
	bh=j+m8FScNrw6S3HokBQxtCXfgWKNRDLKE8fVX42I3UE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPPpTcrTv1nmMz2+qfdwJB7e3YjUeQ+/KGvF5/D6xZh9RuB+sYxN6eVBANGZ/XIap/5YimpwmiNcpfzfY2U+LtGqfVeeTAHCVcVOncX28gjrGHhNkmhDemFABvzCcrJHSxchRoaQkk13cnFxpCIB4llzuJOAsHJFaEm3qTpiFd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9L6NIC5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9L6NIC5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2A51F000E9;
	Mon, 17 Aug 2026 20:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786998338;
	bh=ek0FA+cvrSAiDanlRV/DKW5uqrXQgg5nOVKUL7iey9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K9L6NIC5IHPF0/NzTLSEE5luHA78JEZR4hc2Z/ya/dIYXx4l+IrS0+Iv0JT9+sBTn
	 +RsLnctVQk+C0YvIMq3e17XEJC7oeGXTcBikxt4eemrZgXQXM5M+qCaXv5ar+IV33k
	 ynk7ZRyFdGY13Ksm0D1jGyGd694crrFBMeryqQgUeWEZUGQqqBG1i8jZ5TzG0bW8Ul
	 4HCUxIM5o6NMgbBUveYfmo642L+HZeoV4CuZ2KAb57uojOAyMGbH/uFmGrMfwog5qv
	 RGwmnYNbSTij/d9xVpEI2ahn0U/sJA2SvPGItTM9ifUN2tTbq3dk17SC3lyPB5+3dF
	 rQmKHF6EjBjSQ==
From: Jakub Kicinski <kuba@kernel.org>
To: hexlabsecurity@proton.me
Cc: Jakub Kicinski <kuba@kernel.org>,
	wintera@linux.ibm.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	twinkler@linux.ibm.com,
	linux-s390@vger.kernel.org,
	hidayath@linux.ibm.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/iucv: only deliver HiperSockets frames to HiperSockets sockets
Date: Mon, 17 Aug 2026 13:25:36 -0700
Message-ID: <20260817202536.3590565-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813-b4-disp-60433a46-v1-1-509e1200533e@proton.me>
References: <20260813-b4-disp-60433a46-v1-1-509e1200533e@proton.me>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email says "Looks like other places need a fix, too. Please fix them
in one patch, failing that in one series."
---
net/iucv: only deliver HiperSockets frames to HiperSockets sockets

This adds a transport test to the socket lookup in afiucv_hs_rcv() so that
an inbound HiperSockets frame skips sockets bound to the classic z/VM IUCV
transport.  Selection previously used only the four 8-byte name fields from
the frame header.

> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index ea047bab65e7c..5fb6793b9a64a 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -2079,6 +2079,8 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struct net_device *dev,
>  	sk = NULL;
>  	read_lock(&iucv_sk_list.lock);
>  	sk_for_each(sk, &iucv_sk_list.head) {
> +		if (iucv_sk(sk)->transport != AF_IUCV_TRANS_HIPER)
> +			continue;

[Severity: Medium]

This isn't a bug introduced by this patch, but should the other lookup over
iucv_sk_list get the same treatment?  iucv_callback_connreq(), which handles
inbound classic z/VM IUCV connect requests, still matches on name alone:

net/iucv/af_iucv.c:iucv_callback_connreq() {
	sk_for_each(sk, &iucv_sk_list.head)
		if (sk->sk_state == IUCV_LISTEN &&
		    !memcmp(&iucv_sk(sk)->src_name, src_name, 8)) {
			iucv = iucv_sk(sk);
			break;
		}
}

On the configuration the commit message describes (pr_iucv set and a
HiperSockets device present, so both transports coexist), can a socket bound
through the HIPER branch of iucv_sock_bind() be picked here?

If so, the child it builds looks inconsistent:

net/iucv/af_iucv.c:iucv_callback_connreq() {
	niucv->transport = AF_IUCV_TRANS_IUCV;
	...
	memcpy(niucv->src_user_id, iucv->src_user_id, 8);
}

That is transport AF_IUCV_TRANS_IUCV with src_user_id copied from a HIPER
parent, i.e. the device hsuid, while the vm_bind path of iucv_sock_bind() and
iucv_sock_autobind() always set src_user_id to iucv_userid for classic
sockets.

After this change the two directions disagree about whether transport is part
of the demux key.  Was making only the HiperSockets side transport-aware
intentional?

[Severity: High]

This is a pre-existing issue, but since this hunk is the lookup in question:
should the ingress device and its namespace also be checked here?

afiucv_hs_rcv() never uses its dev or orig_dev arguments, and the handler is
registered globally:

net/iucv/af_iucv.c
	static struct packet_type iucv_packet_type = {
		.type = cpu_to_be16(ETH_P_AF_IUCV),
		.func = afiucv_hs_rcv,
	};
	...
	dev_add_pack(&iucv_packet_type);

With no .dev and no .af_packet_net, ptype_head() files this in the global
ptype_base[], and __netif_receive_skb_core() delivers ETH_P_AF_IUCV frames
from any net_device in any namespace:

net/core/dev.c:__netif_receive_skb_core() {
	deliver_ptype_list_skb(skb, &pt_prev, orig_dev, type,
			       &ptype_base[ntohs(type) &
					   PTYPE_HASH_MASK]);
}

Meanwhile every AF_IUCV socket lives in init_net:

net/iucv/af_iucv.c:iucv_sock_alloc() {
	sk = sk_alloc(&init_net, PF_IUCV, prio, &iucv_proto, kern);
}

Comparable ptype handlers filter at exactly this point (net/x25/x25_dev.c and
net/ieee802154/socket.c both test the namespace).

After this patch, is the only selection criteria still transport plus the four
attacker-supplied 8-byte header fields, with no comparison against
iucv->hs_dev or sk->sk_bound_dev_if, both of which iucv_sock_bind() sets for
HIPER sockets?

	sk->sk_bound_dev_if = dev->ifindex;
	iucv->hs_dev = dev;

Two things seem to follow.  First, can a matching frame arriving on device B
be delivered to a socket bound to device A, with afiucv_hs_callback_syn()
then creating a child that inherits the listener's device and replies out
through A?

net/iucv/af_iucv.c:afiucv_hs_callback_syn() {
	nsk->sk_bound_dev_if = sk->sk_bound_dev_if;
	niucv->hs_dev = iucv->hs_dev;
}

Second, can a process holding CAP_NET_RAW in an unprivileged user and net
namespace send a raw frame with ethertype 0xFBFB on its own lo and reach host
HIPER sockets?  loopback_xmit() re-derives skb->protocol via
eth_type_trans(), and a destination MAC of all zeros matches loopback's
dev_addr so pkt_type is PACKET_HOST.  Reaching the callbacks would mean
afiucv_hs_callback_synfin() and afiucv_hs_callback_fin() forcing
sk_state = IUCV_DISCONN with sk_state_change(), afiucv_hs_callback_rx()
queueing injected bytes on a connected socket:

net/iucv/af_iucv.c:afiucv_hs_callback_rx() {
	if (skb_queue_empty(&iucv->backlog_skb_q)) {
		if (__sock_queue_rcv_skb(sk, skb))
	...
}

plus afiucv_hs_callback_win() applying a caller-chosen window through
atomic_sub() on iucv->msg_sent, and afiucv_hs_callback_syn() adding children
to a listening socket's accept queue.

Given the subject line says "only deliver HiperSockets frames to HiperSockets
sockets", would it be worth either adding a dev_net(dev) and device test in
the same loop, or noting in the commit message that this path stays open?

The submission's own trailing notes rely on this vector when arguing that
reach extends beyond the HiperSockets LAN, so the recorded message and the
code appear to differ on what is being closed.
-- 
pw-bot: cr
