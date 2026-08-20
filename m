Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257AE3A8744;
	Thu, 20 Aug 2026 19:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787254700; cv=none; b=DcHztLY0yOGC90MbNrCD7pePrTmB3yA+vRu+jaGIc+1d2pN2SHl6b+fD81gjflegpKnGYrXLCuDSMconjxeIti7C3TlEEuXnqFScR6WWH/ir2VAwyvscpRKm3fRge16vYTvMsTHqmDcVkOdSokFcBQXf03AiAKbGXZ3xATIJQg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787254700; c=relaxed/simple;
	bh=CidQNYatH9N2Pkv+BLfb4wV7pTXzdh+2CGiwnDlirX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2F7If5cLQBBqbEA1Z3aiVkO1CCeGvP/uHS4YbaTsxRsKi1uYamN3AeuuNmQDMQOdKMDQnA0VRRP3x1wC/qWBXMVRNNnE2Pzq23hzmlhu696K8pZIEFkHbPohQw+CfU+pXbzw3nk8b4iw2XXDSNXvrI4Eoyc7YKwX/A2nIkSK6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnIWFBs/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnIWFBs/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787D31F000E9;
	Thu, 20 Aug 2026 19:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787254698;
	bh=jd05/T6XOx8+PsGvJHhZ5lO54VPfdCsg2wRzOdeNY6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WnIWFBs/vZVKPvQRZPzFuT6uhCKgTXnGXMxJxgPc1JFETJJ3+5qYiQyUgEgPzMUrA
	 kt0l2fvMBdQ/ieVKHYu0MNa2rY29iYrYtPKu73V/kLVZ015aFXAThAYb6ZY/QIAUXg
	 GNtNJ1XbNX7Jfbkh8Y9dSfULzn6TUtI3NU7M5mzzsq6AEukZ3YbkoEjE8wMM5fLG+W
	 p+VGgj9Z+1BNL673aFU/978bd+XZXcm8ja68qwH4yQphGGtv1RCaqnUskGO1N7QEN0
	 HWOutGy9AD2qFd1cYkSEckWj6dLox8eV0jcGcHUz52NFQ28vq7ISSA/kK7yXs7Q/gm
	 iN9uutq1ifVXQ==
From: Jakub Kicinski <kuba@kernel.org>
To: hexlabsecurity@proton.me
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	wintera@linux.ibm.com,
	twinkler@linux.ibm.com,
	hidayath@linux.ibm.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	ursula.braun@de.ibm.com,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH net] net/iucv: reconcile the socket state when connect() severs the path
Date: Thu, 20 Aug 2026 12:37:53 -0700
Message-ID: <20260820193752.1074271-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815-b4-disp-e1faf4b7-v1-1-2a8a143a0055@proton.me>
References: <20260815-b4-disp-e1faf4b7-v1-1-2a8a143a0055@proton.me>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/iucv: reconcile the socket state when connect() severs the path

When a classic AF_IUCV connect() fails and severs the path, the socket
could be left in IUCV_CONNECTED with iucv->path already NULL. The patch
adds a state reconciliation to IUCV_DISCONN right after iucv_sever_path()
so that a later sendmsg() does not walk the NULL path pointer.

> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index ea047bab65e7c..6fb0041c4c987 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -778,8 +778,16 @@ static int iucv_sock_connect(struct socket *sock, struct sockaddr_unsized *addr,
>  	if (sk->sk_state == IUCV_DISCONN || sk->sk_state == IUCV_CLOSED)
>  		err = -ECONNREFUSED;
>  
> -	if (err && iucv->transport == AF_IUCV_TRANS_IUCV)
> +	if (err && iucv->transport == AF_IUCV_TRANS_IUCV) {
>  		iucv_sever_path(sk, 0);
> +		/* A connack may have landed while the wait was unwinding; the
> +		 * path is gone, so the socket must not still claim it.
> +		 */
> +		if (sk->sk_state == IUCV_CONNECTED) {
> +			sk->sk_state = IUCV_DISCONN;
> +			sk->sk_state_change(sk);
> +		}
> +	}

[Severity: Critical]
This isn't a bug introduced by this patch, but it should probably be
fixed at the same time. Does the same CONNECTED-with-NULL-path state
remain reachable from the HiperSockets receive path, so that the NULL
dereference described in the changelog survives?

afiucv_hs_rcv() matches sockets on the global iucv_sk_list by name only:

net/iucv/af_iucv.c:afiucv_hs_rcv() {
	...
	sk_for_each(sk, &iucv_sk_list.head) {
		if (trans_hdr->flags == AF_IUCV_FLAG_SYN) {
			...
		} else {
			if ((!memcmp(&iucv_sk(sk)->src_name,
				     trans_hdr->destAppName, 8)) &&
			    ...
			    (!memcmp(&iucv_sk(sk)->dst_user_id,
				     trans_hdr->srcUserID, 8))) {
				iucv = iucv_sk(sk);
				break;
	...
}

There is no check of iucv->transport, no check of iucv->hs_dev and no
network namespace check, and iucv_packet_type is registered globally in
afiucv_init() with dev_add_pack(&iucv_packet_type) and no .dev filter.

afiucv_hs_callback_synack() then only requires IUCV_BOUND before writing
the connected state:

net/iucv/af_iucv.c:afiucv_hs_callback_synack() {
	if (!iucv || sk->sk_state != IUCV_BOUND) {
		kfree_skb(skb);
		return NET_RX_SUCCESS;
	}

	bh_lock_sock(sk);
	iucv->msglimit_peer = iucv_trans_hdr(skb)->window;
	sk->sk_state = IUCV_CONNECTED;
	sk->sk_state_change(sk);
	...
}

So a classic-transport socket that has only been bound, or one whose
connect() failed with the wait timing out or being interrupted (path
severed to NULL, state left at IUCV_BOUND, which the new code does not
reconcile), can end up at IUCV_CONNECTED with iucv->path == NULL.

Once that happens, iucv_below_msglim() dereferences the NULL path:

net/iucv/af_iucv.c:iucv_below_msglim() {
	if (sk->sk_state != IUCV_CONNECTED)
		return 1;
	if (iucv->transport == AF_IUCV_TRANS_IUCV)
		return (atomic_read(&iucv->skbs_in_xmit) < iucv->path->msglim);
	...
}

and it is called from iucv_sock_poll():

	if (sock_writeable(sk) && iucv_below_msglim(sk))

which the sk_state_change() above has just woken, as well as from
iucv_sock_sendmsg() via iucv_sock_wait(sk, iucv_below_msglim(sk), timeo).
iucv_sock_sendmsg() also reads iucv->path->flags:

	if (((iucv->path->flags & IUCV_IPRMDATA) & iucv->flags) &&

and passes iucv->path to pr_iucv->message_send().

The changelog says:

    The sever is a barrier against a later connack: iucv_path_sever()
    clears the path from iucv_path_table[] under the lock the tasklet
    holds across dispatch.

Is that statement complete? It holds for the classic iucv tasklet, where
iucv_tasklet_fn() holds iucv_table_lock across dispatch, but the
HiperSockets callbacks run from the netdev RX softirq under
bh_lock_sock() only, and are not excluded by iucv_table_lock.

Would it make sense to also check iucv->transport (and iucv->hs_dev)
in the afiucv_hs_rcv() socket lookup or in afiucv_hs_callback_synack(),
and/or to have iucv_below_msglim() and iucv_sock_sendmsg() test
iucv->path before dereferencing it?
-- 
pw-bot: cr
