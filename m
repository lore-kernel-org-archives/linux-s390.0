Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCDF35F60E;
	Thu, 20 Aug 2026 20:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787258015; cv=none; b=AUE2ImdJxSDYrYRu5+3lY/LPH8QBcunnM3WGWTH+rOMqzwAp/Uob+3PYk4qEdlBVlPsRArfQFX3vHBJ+jX79qQvNOoZq28pwkDr+qJZu1zchjzMiz83gVvZT7xkDwPZzUg5iKtywoA2xmurI3D9mQlv/tzwqJU8D40+hWkgA1h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787258015; c=relaxed/simple;
	bh=j5ZXd8WDoQmtK2FrFtRa7/S2VFIp2mEoliRRV42z0LI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSHmCVu0rNj414LIcQ7bOh/8+KGECiChxtAAhWEpbU5s9a1TzombzmeksIhxBjUk6EupiH7+fg++V6a7a1CFxlTaxqYyPz0T61l91C0CWLJAtoAJRa/V7PvcPmcl+gLcncWIGCN/7tCP6LdU6x5xa0981gPS0SqPW3hbKIWREjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVzagaxU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVzagaxU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B2C1F000E9;
	Thu, 20 Aug 2026 20:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787258011;
	bh=4Usis3W5GrUY82sHVqQbcsOz1keJU0fMLlmN1n9n7SM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XVzagaxURvyrZZJWEGcMXTZ7TFyf4EgRPYQIQnhoE7g+GumP3fr5zpbtzFEHWNV99
	 pDHwi/f83YJooU+PmirFZU7RVUa9Rj4ravdbFMQ/h9kO9eD0s1MFXQ6Z8fW0lmU746
	 iKB/gptFF3jdPq1aoGQkg2mO8M8cv3Lo8M4NNWYexj38dQ2Y/lUs+/TgdBCN/zP7Ar
	 GFFr0mI2MoHIOXaygfLU1Q/GtWst320OTpUyb1QK6ZZE6OU5+VE6qmlL9bl52qM8cd
	 C1UAKOzA3DTIh35zxrH9r6Av+ul+Qtto59yT2x926SUOuaM3wM9b+Fh1jiGIiy88cu
	 p1VKdy03CpCEQ==
From: Jakub Kicinski <kuba@kernel.org>
To: hexlabsecurity@proton.me
Cc: Jakub Kicinski <kuba@kernel.org>,
	pabeni@redhat.com,
	twinkler@linux.ibm.com,
	wintera@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	netdev@vger.kernel.org,
	ursula.braun@de.ibm.com,
	linux-s390@vger.kernel.org,
	hidayath@linux.ibm.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net/iucv: only send the window update on HiperSockets sockets
Date: Thu, 20 Aug 2026 13:33:30 -0700
Message-ID: <20260820203330.1134874-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815-b4-disp-8a791503-v1-1-fbae9a511144@proton.me>
References: <20260815-b4-disp-8a791503-v1-1-fbae9a511144@proton.me>
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
net/iucv: only send the window update on HiperSockets sockets

This adds a transport test before iucv_sock_recvmsg() sends
AF_IUCV_FLAG_WIN, so that iucv_send_ctrl() is no longer called on classic
z/VM sockets where iucv->hs_dev is NULL.  Two questions below, one about
the impact statement in the changelog and one about the surrounding
msg_recv accounting.

>     iucv_sock_recvmsg() sends AF_IUCV_FLAG_WIN without testing the transport,
>     but that flag exists only on HiperSockets. On a classic z/VM socket
>     iucv->hs_dev is NULL and iucv_send_ctrl() sizes the skb from
>     LL_RESERVED_SPACE(iucv->hs_dev), so the read goes through NULL;
>     afiucv_hs_send() then returns -ENODEV and recvmsg() moves the socket to
>     IUCV_DISCONN. Reaching it takes an application that sets SO_MSGLIMIT to 1
>     on its own socket, since msg_recv is incremented only on the HiperSockets
>     path, so this is a correctness fix rather than a security one.

[Severity: Medium]
The bug being fixed here is pre-existing (3881ac441f64) and is not
introduced by this patch, but is the concluding sentence, "so this is a
correctness fix rather than a security one", accurate for a patch carrying
Cc: stable?

The trigger is entirely under the control of an unprivileged local process
using the ordinary socket API.  SO_MSGLIMIT accepts 1 in iucv_setsockopt():

	if (val < 1 || val > U16_MAX)
		rc = -EINVAL;
	else
		iucv->msglimit = val;

msg_recv stays at 0 on a classic socket, so msglimit / 2 == 0 makes the
old predicate 0 >= 0 on every successful non-PEEK recvmsg(), and
iucv_send_ctrl() then evaluates:

net/iucv/af_iucv.c:iucv_send_ctrl() {
	blen = sizeof(struct af_iucv_trans_hdr) +
	       LL_RESERVED_SPACE(iucv->hs_dev);

with hs_dev == NULL, before afiucv_hs_send() gets a chance to return
-ENODEV on its !skb->dev test.

The changelog itself then says "with lowcore relocation it faults", and
relocate_lowcore is a supported s390 boot parameter.  On such kernels an
ordinary recvmsg() from an unprivileged process oopses, which reads like a
local denial of service rather than a correctness issue.  Would it be worth
restating the impact so stable maintainers can prioritise and tag it
accordingly?

> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index ea047bab65e7c..0bc4a15f4b565 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -1331,7 +1331,8 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
>  		if (skb_queue_empty(&iucv->backlog_skb_q)) {
>  			if (!list_empty(&iucv->message_q.list))
>  				iucv_process_message_q(sk);
> -			if (atomic_read(&iucv->msg_recv) >=
> +			if (iucv->transport == AF_IUCV_TRANS_HIPER &&
> +			    atomic_read(&iucv->msg_recv) >=
>  							iucv->msglimit / 2) {
>  				err = iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN);
>  				if (err) {

[Severity: High]
This is a pre-existing issue and is not introduced by this patch, but since
the patch touches this exact accounting block, can the WARN a few lines
above be reached from remote input on the HiperSockets path?

Just before the hunk, iucv_sock_recvmsg() does:

		consume_skb(skb);
		if (iucv->transport == AF_IUCV_TRANS_HIPER) {
			atomic_inc(&iucv->msg_recv);
			if (atomic_read(&iucv->msg_recv) > iucv->msglimit) {
				WARN_ON(1);
				iucv_sock_close(sk);
				return -EFAULT;
			}
		}

The only place msg_recv is decremented is afiucv_hs_send() with
atomic_sub(confirm_recv, &iucv->msg_recv), reached through the
iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN) call in this hunk, and that call sits
under:

		if (skb_queue_empty(&iucv->backlog_skb_q)) {

Meanwhile afiucv_hs_callback_rx() queues every accepted frame without
enforcing the window it advertised to the peer:

net/iucv/af_iucv.c:afiucv_hs_callback_rx() {
	spin_lock(&iucv->message_q.lock);
	if (skb_queue_empty(&iucv->backlog_skb_q)) {
		if (__sock_queue_rcv_skb(sk, skb))
			skb_queue_tail(&iucv->backlog_skb_q, skb);
	} else
		skb_queue_tail(&iucv_sk(sk)->backlog_skb_q, skb);

So if a non-conforming peer floods the socket, the receive queue hits
sk_rcvbuf, __sock_queue_rcv_skb() keeps failing in the drain loop above,
the skb is re-queued at the head of backlog_skb_q and the loop breaks.
backlog_skb_q then stays non-empty, no window update is sent, and msg_recv
keeps incrementing on each recvmsg() until it passes msglimit
(IUCV_HIPER_MSGLIM_DEFAULT is 128) and the WARN fires.  With panic_on_warn
that would be a panic driven by a remote peer.

The same WARN also looks reachable locally with SO_MSGLIMIT set to 1 and
two concurrent recvmsg() threads, since recvmsg() does not hold the socket
lock across the atomic_inc.

Would a rate-limited message plus a drop or reset be a better response to a
peer protocol violation here than WARN_ON(1)?
-- 
pw-bot: cr
