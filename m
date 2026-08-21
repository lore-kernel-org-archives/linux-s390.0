Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B8D38DC5F;
	Fri, 21 Aug 2026 11:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787311052; cv=none; b=oGZjdMwLzPGQNAdenoogiDO5XDwi2n5U9fNAA+JWOXOwJ6zweTft0Gn0ZFqiYYb1cAZve8rYnHXT+EgPu/VLIHr9xMS4Bde82v073NBIyeBjZfyr9GuR85/fd7ynOY+ZoAGHNWkQ106Y99Ypb6gA6IoUrVbsXITnz7oc0+hOgp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787311052; c=relaxed/simple;
	bh=NiWBE4yx44puwWourTxNjWuihHkf6cPGspOXQsKtJwM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aXnd75qo+1vWVaAzE/khbZ7a2QDhPjjq6E+EqtIKPj5ZXlvbDDIhwLXGfzZUrQyIm8DeQ2ajz0I6HhSOJU4l8A6lzjUoZQVyKUzo+pJrRhAD7b0vsen1FlQztJVM+0O/zmpiI1aypQmqB12CR7wUeGbNav43iyhpQq1pZgMf4/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jo6l07MU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jo6l07MU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEDCDC2BCFA;
	Fri, 21 Aug 2026 11:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787311051;
	bh=NiWBE4yx44puwWourTxNjWuihHkf6cPGspOXQsKtJwM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Jo6l07MUB6A6dW2p5jHvmodbDiFdtx5NyayhEDzKavDJH1gWphm4kv0llzulEE51s
	 5GVzsas13bIw0qmGNE4erH9fvZcU0EPCeNzscoWDIMY/Zw3V0kE6ZfB1+ULZvFOUUr
	 xrt45/XNXe8GxWaNrh2Gmldiv6RLOalkF0sE9CO+mIdkNPlTS0BBd4ntrAmKlySB5O
	 BCFXzocyjBWKtO0sQ4D3aqBWjZxAKElj/EPkOoz4UN1V0fDGnxDRYJHH702rbrcSXH
	 OYCW+XyUKCXAmpBJrMgq/dcrSq3MHo8DnDhaPQajURcU8X0qjqHQD0w2UupFAxKKpI
	 etjw/ewYf1m8Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B1DC5DF91;
	Fri, 21 Aug 2026 11:17:31 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Fri, 21 Aug 2026 06:17:33 -0500
Subject: [PATCH net v2 3/3] net/iucv: send the window update outside
 message_q.lock
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-b4-disp-3a6e8695-v2-3-37597ff723a8@proton.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787311050; l=1987;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=EWiW3Q06PiBKk4QOZ/RVbzwZ2pT/eM2TGSityU6WPw0=;
 b=X9RlmlLOvvGwqBAvQgiE+Xzah8fMZJkCoUV4zOd7BiKwfb1FAPYx0Cv8NLpJpHCUm9vQUIz5C
 eK46Z1Eu3/WBBRLhhNiwGqkWES0Bigm9XjJTKs7Us/2ZuaiSBJITdJW
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
buffer space, not the allocation flags. CONFIG_DEBUG_ATOMIC_SLEEP reports
it.

Note that the update is due and send it once the lock is dropped. That
leaves two recvmsg() able to reach afiucv_hs_send() concurrently, which
message_q.lock used to prevent; the preceding patch is what makes that
safe, so do not apply this one without it.

Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 net/iucv/af_iucv.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 492a45bb2bba..a7c0f60bb5bf 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -1244,6 +1244,7 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	struct iucv_sock *iucv = iucv_sk(sk);
 	unsigned int copied, rlen;
 	struct sk_buff *skb, *rskb, *cskb;
+	bool send_win = false;
 	int err = 0;
 	u32 offset;
 
@@ -1336,15 +1337,18 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 				iucv_process_message_q(sk);
 			if (iucv->transport == AF_IUCV_TRANS_HIPER &&
 			    atomic_read(&iucv->msg_recv) >=
-							iucv->msglimit / 2) {
-				err = iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN);
-				if (err) {
-					sk->sk_state = IUCV_DISCONN;
-					sk->sk_state_change(sk);
-				}
-			}
+							iucv->msglimit / 2)
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


