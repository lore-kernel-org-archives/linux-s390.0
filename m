Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2083515EC;
	Sat, 15 Aug 2026 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786809886; cv=none; b=Hwr1dW2uj+t1NctG2ZzT9gLf4hVlTw4ZKyjHhJ9LIy4qJrqu0PIY+zyLtrMa8y1zDnMxoH1ImIjBz6UXfRNFxWcIjZDRCm2hYariMjY0Pi5gYZ9rdSGJY/DDcxhWMFtmx3KRVq9T07ZNqxGz2cNAKfRwo64sQ+mfxHneO3ECAuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786809886; c=relaxed/simple;
	bh=h0mv/mHUsRdebTwdXxQWtLZTmqzLRjwcWnVP15r4cJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dt55qzNeDN/krfW3EdEhZDgDKcNqkOmb4o1GhDs6BBKZ+SpzZeiQDlMV7NNwOZhCFYvcEOvNw2mPxL7IjR8MUAgWdJ6oR7BF+2gW2M06eZQr6Ei9kb6UIQJs+2p3IihAX874ojG5eTrYOWrpLXlxtEf9PCyNFs8eTTVOlc0Nkdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2IqzGTK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2IqzGTK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE0A3C2BCF6;
	Sat, 15 Aug 2026 16:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786809885;
	bh=h0mv/mHUsRdebTwdXxQWtLZTmqzLRjwcWnVP15r4cJ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Y2IqzGTKuofj93WiZFNhNSQo8BeMwFO0vQmrYdsba9Z+UCr92u1Eh7AGg8z+kS0xI
	 pMAL9Y829Jasf4M4iqjGOqHrEdrpV2VorLjhieFUIK/2NYqf1qhbP1gsotHuZGAdGA
	 l0jcdc8g/7MfgMRufeF/3DSLTMZ5juL6QK5Go1SBXU1wMyhmP7B5tSfwb2qOgRN9ln
	 g0y+UkR0D+wj1qhg6TkxuINIqUbQLmChbe5ThVRc9etELH9OiIK8JnxRLZ1wVg03W4
	 ez8UtifDgvmxtlnpzoTV2l2WAWil0QR0roPIYh9xW/h4mh1fJs5D14AeF6iVQF3Z06
	 cIsRbRX11uu/g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08CBC5DF6E;
	Sat, 15 Aug 2026 16:04:45 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Sat, 15 Aug 2026 11:04:46 -0500
Subject: [PATCH net 2/2] net/iucv: send the window update outside
 message_q.lock
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260815-b4-disp-8a791503-v1-2-fbae9a511144@proton.me>
References: <20260815-b4-disp-8a791503-v1-0-fbae9a511144@proton.me>
In-Reply-To: <20260815-b4-disp-8a791503-v1-0-fbae9a511144@proton.me>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
 Thorsten Winkler <twinkler@linux.ibm.com>, 
 Alexandra Winter <wintera@linux.ibm.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Ursula Braun <ursula.braun@de.ibm.com>, 
 linux-s390@vger.kernel.org, Hidayath Khan <hidayath@linux.ibm.com>, 
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786809884; l=2272;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=L56L5SgoTNqaUSYL7t66jKwxwKt6Vsm3YTGtl+pA+g8=;
 b=c62iVuhmkLGiW0Ajgwi+6seVbKKOqFeHWRq9Hi5CLUk24XWvph6FVli+LN/G5GceIiFkDRMeY
 hrnL1M9eNzDD8iGbpo07XckKbaxcczLtchTLMS6U674yA9J9hQEcxi4
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=xw1AhCtQdvuoQc+bOQIYy9o8G++cp4/VniI2G/tc3G8=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/default with
 auth_id=893
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

iucv_sock_recvmsg() calls iucv_send_ctrl() with message_q.lock held, and
iucv_send_ctrl() allocates through sock_alloc_send_skb() with
sk->sk_allocation -- GFP_KERNEL here -- so the allocation may sleep inside
the spin_lock_bh() section; noblock suppresses only the wait for send
buffer space, not the allocation flags. The section's other allocation,
alloc_iucv_recv_skb() under iucv_process_message_q(), uses GFP_ATOMIC.

Note that the update is due and send it after the lock is dropped. The
lock protects backlog_skb_q and message_q.list, neither of which the send
touches. It does widen an existing msg_recv race -- afiucv_hs_send() reads
the counter and subtracts it later, and recvmsg holds no socket lock, so
two recvmsg can now interleave where before only recvmsg and sendmsg
could. Both trip the same WARN_ON.

Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 net/iucv/af_iucv.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 0bc4a15f4b56..e31ef3a87ec5 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -1241,6 +1241,7 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	struct iucv_sock *iucv = iucv_sk(sk);
 	unsigned int copied, rlen;
 	struct sk_buff *skb, *rskb, *cskb;
+	bool send_win = false;
 	int err = 0;
 	u32 offset;
 
@@ -1332,16 +1333,18 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 			if (!list_empty(&iucv->message_q.list))
 				iucv_process_message_q(sk);
 			if (iucv->transport == AF_IUCV_TRANS_HIPER &&
-			    atomic_read(&iucv->msg_recv) >=
-							iucv->msglimit / 2) {
-				err = iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN);
-				if (err) {
-					sk->sk_state = IUCV_DISCONN;
-					sk->sk_state_change(sk);
-				}
-			}
+			    atomic_read(&iucv->msg_recv) >= iucv->msglimit / 2)
+				send_win = true;
 		}
 		spin_unlock_bh(&iucv->message_q.lock);
+
+		if (send_win) {
+			err = iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN);
+			if (err) {
+				sk->sk_state = IUCV_DISCONN;
+				sk->sk_state_change(sk);
+			}
+		}
 	}
 
 done:

-- 
2.55.0


