Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E2023AE87;
	Fri, 21 Aug 2026 11:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787311052; cv=none; b=dGE85BVXh6piXmtJV6x4/925XyGSr1nM6eK6xd/fv7nZ5iukJl9MAZk9ImwzVOZNH9oaAmdGn0smwIcvZUvvW3cu3ORysYrz0gwmAJMUEEaRzqQZpsH/EYCPCRIp6nv80bZbwde9PxgKyO+b/+lF3cesJ1RMGWCSDrJcJwxtlvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787311052; c=relaxed/simple;
	bh=Z2qkCOW6uOoE4Tcm2xkjLfssvPh/evtQRuReVm29Y1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W1FwKZhxYPGJVvUAbVBWu9h336SGOSADWE8f+ZiemnUX8seIqgXSAefhCUAQ+3WYPJK1LBCRp0tNiIjS4K0buXMqxUy78JwXAL85sa6e2deq6ulZLngBBtpaSKvRMEtcXNCjQvjTTcZgmnLXAhkHcvtf8PJPErb/49L/5nNKvkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2EQMrOW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2EQMrOW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C12D6C2BCF6;
	Fri, 21 Aug 2026 11:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787311051;
	bh=Z2qkCOW6uOoE4Tcm2xkjLfssvPh/evtQRuReVm29Y1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=T2EQMrOWrgXqTt3S7iNddF3R1H0t/Tt/l2N7LOxdV6S3pUZzR2mc6FWd9mu4kOc3Y
	 4tLvVRgB4WLPj8pwOKIsqUSjzQIRDgplzw2U/QFXt8R1IGB2MR7u3gczqUGKc7KDNx
	 nPfgUL/JvIMhhP7cs70ENhhOO93vthbFKhpsYAcELbg7wl6g8u1a/DwlyKt5ogzw5p
	 AvSfsIKEKh9mW3tWihc8UH5s+AHYRSg6sA09ntUkVfklSzJhPf89ZUnO+igxzcs/YR
	 mBm/jTxOsuXHlVeDQTAeYZAZMEf+XfyLXr8nvds3D6Oy+CxYa9lKJNsRUKiAci1sCQ
	 fQP+HfzAkWuoQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04C6C5DF87;
	Fri, 21 Aug 2026 11:17:31 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Fri, 21 Aug 2026 06:17:32 -0500
Subject: [PATCH net v2 2/3] net/iucv: claim the receive credit atomically
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-b4-disp-3a6e8695-v2-2-37597ff723a8@proton.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787311050; l=2680;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=gdWnKR2zta/pTzLbRUr1dcaH2AxxQQj7YNfOq5qNvR4=;
 b=zqGOlGCSiF/k0bUYBWLokM3x49KYfuMD+pmlbvhvcEII4VXlHTl0qCJo0NIbd5XnvkfOp8YJ/
 EFnXIm3r+q4AZxHrn3GA3SNQsI59sg8NHDGkBTGUKAUY5qtboegyOn1
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=xw1AhCtQdvuoQc+bOQIYy9o8G++cp4/VniI2G/tc3G8=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/default with
 auth_id=893
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

afiucv_hs_send() samples msg_recv, advertises it to the peer as the window,
and subtracts it once dev_queue_xmit() has returned. Nothing owns the
counter across the two: iucv_sock_sendmsg() reaches it under lock_sock()
and iucv_sock_recvmsg() reaches it under no socket lock, so an unprivileged
process running both on one socket can have them subtract the same value.
msg_recv goes negative and trips the WARN_ON(); the same interleaving puts
that credit on the wire twice, and the peer's afiucv_hs_callback_win()
subtracts the wire value from msg_sent unchecked.

Claim it with atomic_xchg(), after the last error exit so the counter reads
zero only while the transmit is in flight, and hand it back if that fails.
Nothing subtracts now, so the WARN_ON() goes too.

Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 net/iucv/af_iucv.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 0bc4a15f4b56..492a45bb2bba 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -210,12 +210,6 @@ static int afiucv_hs_send(struct iucv_message *imsg, struct sock *sock,
 	phs_hdr->flags = flags;
 	if (flags == AF_IUCV_FLAG_SYN)
 		phs_hdr->window = iucv->msglimit;
-	else if ((flags == AF_IUCV_FLAG_WIN) || !flags) {
-		confirm_recv = atomic_read(&iucv->msg_recv);
-		phs_hdr->window = confirm_recv;
-		if (confirm_recv)
-			phs_hdr->flags = phs_hdr->flags | AF_IUCV_FLAG_WIN;
-	}
 	memcpy(phs_hdr->destUserID, iucv->dst_user_id, 8);
 	memcpy(phs_hdr->destAppName, iucv->dst_name, 8);
 	memcpy(phs_hdr->srcUserID, iucv->src_user_id, 8);
@@ -250,13 +244,22 @@ static int afiucv_hs_send(struct iucv_message *imsg, struct sock *sock,
 	}
 	skb->protocol = cpu_to_be16(ETH_P_AF_IUCV);
 
+	/* Claim the receive credit here, not while building the header: every
+	 * way this frame can be dropped has now been ruled out, so the window
+	 * is zeroed only for as long as the transmit itself takes.
+	 */
+	if (flags == AF_IUCV_FLAG_WIN || !flags) {
+		confirm_recv = atomic_xchg(&iucv->msg_recv, 0);
+		phs_hdr->window = confirm_recv;
+		if (confirm_recv)
+			phs_hdr->flags = phs_hdr->flags | AF_IUCV_FLAG_WIN;
+	}
+
 	atomic_inc(&iucv->skbs_in_xmit);
 	err = dev_queue_xmit(skb);
 	if (net_xmit_eval(err)) {
 		atomic_dec(&iucv->skbs_in_xmit);
-	} else {
-		atomic_sub(confirm_recv, &iucv->msg_recv);
-		WARN_ON(atomic_read(&iucv->msg_recv) < 0);
+		atomic_add(confirm_recv, &iucv->msg_recv);
 	}
 	return net_xmit_eval(err);
 

-- 
2.55.0


