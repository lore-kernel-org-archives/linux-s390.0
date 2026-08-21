Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F60366061;
	Fri, 21 Aug 2026 11:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787311052; cv=none; b=tTEGzrHL4fM6zLjdRKBir6wySCCnnaBmcYy9xp5GuH9AzOkMUJf3iR3pV8uXY1jzOBQSqGl+jQLVsAk4GwRG3WlwJqUgvVu4pX8L+CVM8ryChdFdfl8A0pZUtw4QT0e/UW83WrF/ZkDnRBsZ/VauKwMIhM2qt8DIWDTjdiu1dk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787311052; c=relaxed/simple;
	bh=rAjTQEtLsLV9kFA7GO/RMTn5HEOTkBpQ/dZay1kXX58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KWDizvVXfcly9bWrF5ywFnzATx0OyZ0Spd62Dk0DRzKMvVJ3yZjDmykTGDfNaVThMSZ5zYJb4iWQI/YjgHnyNLV8eLb0JABO72GtldvI9DNpHO5xEc6Pbbxy3FDEGauvGDPYd3lRkhxUA8Vx7FeFOcEciNC88BmSW9LgF+e5QWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uel5cNk9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uel5cNk9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC45AC2BCF7;
	Fri, 21 Aug 2026 11:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787311051;
	bh=rAjTQEtLsLV9kFA7GO/RMTn5HEOTkBpQ/dZay1kXX58=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uel5cNk9QGdQl3mIBL6FAQIAWDNSYRPJgeDj1FrLqIuxz92/UlegvcLiKEawiwaO8
	 PNHkjEIbSbP/OKi+GQOr7/Q3hDmraE7yQn5u9FZK/DypTHC6qMU/0XdGoDsXE6oVYF
	 J0N12mcnnk3cABvIbUe4APxKz1BF+OXgJ0jiPYW3n1tdJvKO606N00pVUo6GWZJx1K
	 2BSFWKqCxCT9cjKiABTpM3zqlwG/mSmvde2Ks9nZ19UgoQWmexZ9W4yQImPL2g14/c
	 RUlIfQMzspVFi4/N/Mjba/CmpXy2HF3thlG3IdnW8jGxXTsJJLLez9HRMZurNEserB
	 ZPKPGpwheYOog==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7B9C5DF7D;
	Fri, 21 Aug 2026 11:17:31 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Fri, 21 Aug 2026 06:17:31 -0500
Subject: [PATCH net v2 1/3] net/iucv: only send the window update on
 HiperSockets sockets
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-b4-disp-3a6e8695-v2-1-37597ff723a8@proton.me>
References: <20260821-b4-disp-3a6e8695-v2-0-37597ff723a8@proton.me>
In-Reply-To: <20260821-b4-disp-3a6e8695-v2-0-37597ff723a8@proton.me>
To: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, Alexandra Winter <wintera@linux.ibm.com>, 
 Thorsten Winkler <twinkler@linux.ibm.com>, 
 "David S. Miller" <davem@davemloft.net>
Cc: Hidayath Khan <hidayath@linux.ibm.com>, Simon Horman <horms@kernel.org>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-s390@vger.kernel.org, Ursula Braun <ursula.braun@de.ibm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787311050; l=1571;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=UV3NZoQuo/NUMIXZzEpsfVb35DP1P1HpuhR4s+1zr/s=;
 b=nRbIFg0Vj+2He+x6Njfa7xtOheMIN5cIuHP7k6WwIHI0wPSs5mir5dLB3ha5chqfh4C3g//YY
 08Z9Bs6RQPGCySJCrvoQlABTgdD/zITernQUTM2qDRFFMwQIAa1/Zt7
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=xw1AhCtQdvuoQc+bOQIYy9o8G++cp4/VniI2G/tc3G8=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/default with
 auth_id=893
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

iucv_sock_recvmsg() sends AF_IUCV_FLAG_WIN without testing the transport,
but that flag exists only on HiperSockets. On a classic z/VM socket
iucv->hs_dev is NULL and iucv_send_ctrl() sizes the skb from
LL_RESERVED_SPACE(iucv->hs_dev), so the read goes through NULL. It is one
recvmsg() away for an unprivileged process on a socket of its own:
SO_MSGLIMIT accepts 1, so msglimit / 2 is 0 and msg_recv never leaves 0 on
a classic socket. The read lands in mapped lowcore on a default kernel and
the socket takes a spurious disconnect; with relocate_lowcore it faults.

Test the transport. The unconditional send is older than that, but stayed
harmless while iucv_send_ctrl() used a constant ETH_HLEN.

Fixes: 238965b71b96 ("net/af_iucv: build proper skbs for HiperTransport")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 net/iucv/af_iucv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index ea047bab65e7..0bc4a15f4b56 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -1331,7 +1331,8 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 		if (skb_queue_empty(&iucv->backlog_skb_q)) {
 			if (!list_empty(&iucv->message_q.list))
 				iucv_process_message_q(sk);
-			if (atomic_read(&iucv->msg_recv) >=
+			if (iucv->transport == AF_IUCV_TRANS_HIPER &&
+			    atomic_read(&iucv->msg_recv) >=
 							iucv->msglimit / 2) {
 				err = iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN);
 				if (err) {

-- 
2.55.0


