Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794372270;
	b=pV3nxnN+5uRtODAyzxyJx7avYqtJN+9GvlTb4uMjMf9eUWJyi9ADMZYRR7eKxpZnBbh3
	 APvJVGOYHOgUhdtMLgL5mdDBcjSdjMIWmiSRfB6asw5FpHixXzxJWlV9H1Dx8H5vlu/iX
	 ZEFzqgXRxwj9edBST2sV/v0o65uCdTYsxLkSdsOWiL7fWbnqXjy9Imb/+Qpf79otB3Xze
	 zGQXJMoXWmLOgpEQ4icWRyBVRmFUGj4Cf+99nzgp4P1cJVLo6KcfmI6Vsiw3+yC2LnSo7
	 RtMZA5ky/a2vTysbK/xQdVbx85Ht+weFvTdjQvXTlDyFc23bVaCm9qdLab6gkVa0rkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794372270;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=WavcqzNW0xlVSgu+BCFTucPDKipD1qdP8JJ4hVzh7hA=;
	b=ufwSj0UEthECf6f0dzhFzYJlgZfjDk6VpROpp0WC4KR2/0RxfE89WrHhsd/IkzMWbaek
	 yyyy0AWE7nUa9njR2XgTHotbVB3rwE0JqaNHOTBhcBvYkrQHG36BRQZ0DrzB6x9w947Cj
	 gPno6OtJC6stLk1c6vASQULkrFSG9pUYhrgSwxBCNfWkk88FGyLO7IJ8Y9eYiaq3KFKnL
	 aHgJZS4Uw2+GLEKSeoA+JfINURo1q/xZDiLfhecJmxdL7Q5S5M0ScvcqtMWUbYB5ZK0ih
	 uJVt54U5zlf2HnGm0UwWTLkxT4hEtUvvu1MplQlN1VbeTFfrBdTJnAfwfq23EeC29ew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W5eAvrD3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7F560A260D;
	Wed, 11 Nov 2026 04:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W5eAvrD3
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794372270;
	b=AVJN3MNGaGPYkMzGp+TEVJbqGNaPkipgWQ7RWlet/Y9dv3x6C1Hj/xpKVvTQ/9EiUEQ4
	 svbTTuWZgK6RNJlsg2w2BSSzqEKEAcWdgM/MaM6Bn4L6xTm76NmJiHam5cv4N1dE0Fnd3
	 HdFnN7l9bCE6a1FGeITKn2fNz3sWtxMDPy2I3ue9FxLdb+UZK4fP6thh6fgaGMTceLnwu
	 S1jFtgryVClFsbTixv0EspxiW8kmCdP8jPhwl5zuQdqFKChmv9CCp8IxWx5TmOL6TacqD
	 FvSEKsBA+IHEgwaptgsQ+CL2/k2aUMqUy+ZaMJZBIO/3aBZu2TaxP52ksuAPVJnowCg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794372270;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=WavcqzNW0xlVSgu+BCFTucPDKipD1qdP8JJ4hVzh7hA=;
	b=WdsguI9K90qHW041v0IByhto2o1JzQXzGFa/dP9VkrFo5SiHAM13s6nS+vB0c4jVpQdR
	 HntlKuYhayWEVUij1JCRlymhnux6PQJ9i1DHc9lg31gqwXIqj+b0Er2pGD3hjyw6uo6A8
	 bwGMh9Txj5FP0pU7qytygbivL7qfjokX8STi3r2D1sJRdLW0rMW3o21MKOzdI2UET9Jbc
	 Dmkoipx5CinlkHBMZUVWElQlySDR2WItNELyh0PXi7TIddBxzqBJJXyvX9kLkXynWy8Gj
	 59+Rlp7nleTTucP5ErQkmU6aGQVZ8+1oRjrOm//Ypu38n+8LzL3XeK/65A6el6V3F2g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AF9661F00A05;
	Wed, 11 Nov 2026 04:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794372269;
	bh=WavcqzNW0xlVSgu+BCFTucPDKipD1qdP8JJ4hVzh7hA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=W5eAvrD3Z0X6BdAj2QY1wNDIBIOGeS96b6lnSeRpSxD6zOBfpKzIsqkBaY0yO7jsj
	 v2veTib0FNII0cKu5XnRFcbI5VKcRi8CEFUiyY+dX5sLJD9Cplu0coc/Q5pxWVvpTf
	 fjCH4dwcjCWGE3acIDfuDVqPfE7AjeIfQk0oT2TzxwXxYvMvt+q0NXpO6ow3UqoqzA
	 Sz3Qdcs9b+mTR7zOykLaDbFtgh2h/YTRpZC17jDbuEjvhCj4IJLhD44aPd+xJ5VXy2
	 wy5lPcyaOtEk0gT1JcrgWUSiskdYAtc/ks/+FZyoFSxEChgDApUcXJvwPHOLfEytyB
	 eDK60ip4FRQPw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3EF7A48D97;
	Wed, 11 Nov 2026 04:44:27 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Tue, 10 Nov 2026 23:44:29 -0500
Subject: [PATCH RFC net v3 4/7] net/iucv: factor out the HiperSockets frame
 dispatch and state changes
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-b4-disp-2a6b4364-v3-4-35677b68e697@proton.me>
References: <20261110-b4-disp-2a6b4364-v3-0-35677b68e697@proton.me>
In-Reply-To: <20261110-b4-disp-2a6b4364-v3-0-35677b68e697@proton.me>
To: "David S. Miller" <davem@davemloft.net>, 
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Alexandra Winter <wintera@linux.ibm.com>, 
 Hidayath Khan <hidayath@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Thorsten Winkler <twinkler@linux.ibm.com>, 
 Nagamani PV <nagamani@linux.ibm.com>, Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, linux-s390@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794372266; l=7470;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=E/tt6JkYGTDUvYsiwbELgDF0AcXX188RCpdMDzsGh2c=;
 b=vAgf0hEPR7Zg3xhUxPJQElRP6TlUPEBKyi4FX9R+xMz+UyzgqZTon16rny5E9Lra0J0CUe8P7
 bf9J+Jx+2VEB6XAFHx7Y+rterT6PUp1bs3xENwfrCZj9w+oAEv2eHaP
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=xw1AhCtQdvuoQc+bOQIYy9o8G++cp4/VniI2G/tc3G8=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/default with
 auth_id=893
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me
Content-Transfer-Encoding: 7bit

From: Bryam Vargas <hexlabsecurity@proton.me>

Move the switch on the frame type out of afiucv_hs_rcv() into
afiucv_hs_dispatch(), and the state changes a SYN|ACK, a SYN|FIN and a
FIN make into afiucv_hs_synack(), afiucv_hs_synfin() and
afiucv_hs_fin(). The three are still called under the bh_lock_sock() of
their callbacks, which now test sk where they tested iucv_sk(sk), a
cast of it. They are defined ahead of iucv_proto: the next patch
reaches them from proto->release_cb. afiucv_hs_synfin() and
afiucv_hs_fin() are the same for now and stay two: a later patch sets
RCV_SHUTDOWN in the second only.

No functional change. The next patch runs the dispatch from a second
place and the three state changes from the task that owns the socket.

Cc: stable@vger.kernel.org # 6.18.x, needed by the next patch
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
New in v3: v2 moved this code and changed it in one diff. Here it only
moves, so that 5/7 shows what changes.

checkpatch asks for a Fixes: tag because of the stable line. There is
none to give: the patch fixes nothing and is marked for stable only so
that 5/7 applies there.

The kernel with 1/7 to 4/7 gives the result of the one with 1/7 to 3/7
in every test: the 53 default ones and the 28 opt-in ones (window,
strays, connect(), leaks).
---
 net/iucv/af_iucv.c | 151 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 97 insertions(+), 54 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 639725917f3f..1677cc65ad06 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -39,6 +39,44 @@
 
 static char iucv_userid[80];
 
+/**
+ * afiucv_hs_synack() - connect a socket, on the SYN|ACK to its SYN
+ * @sk:		the socket, in IUCV_BOUND
+ * @window:	the window in the SYN|ACK: the frames the peer takes from us
+ *
+ * Context: Softirq, under bh_lock_sock().
+ */
+static void afiucv_hs_synack(struct sock *sk, u16 window)
+{
+	iucv_sk(sk)->msglimit_peer = window;
+	sk->sk_state = IUCV_CONNECTED;
+	sk->sk_state_change(sk);
+}
+
+/**
+ * afiucv_hs_synfin() - refuse a socket, on the SYN|FIN to its SYN
+ * @sk:		the socket, in IUCV_BOUND
+ *
+ * Context: As afiucv_hs_synack().
+ */
+static void afiucv_hs_synfin(struct sock *sk)
+{
+	sk->sk_state = IUCV_DISCONN;
+	sk->sk_state_change(sk);
+}
+
+/**
+ * afiucv_hs_fin() - disconnect a socket, on the FIN of its peer
+ * @sk:		the socket, in IUCV_CONNECTED
+ *
+ * Context: As afiucv_hs_synack().
+ */
+static void afiucv_hs_fin(struct sock *sk)
+{
+	sk->sk_state = IUCV_DISCONN;
+	sk->sk_state_change(sk);
+}
+
 static struct proto iucv_proto = {
 	.name		= "AF_IUCV",
 	.owner		= THIS_MODULE,
@@ -2032,17 +2070,13 @@ static int afiucv_hs_callback_syn(struct sock *sk, struct sk_buff *skb)
  */
 static int afiucv_hs_callback_synack(struct sock *sk, struct sk_buff *skb)
 {
-	struct iucv_sock *iucv = iucv_sk(sk);
-
-	if (!iucv || sk->sk_state != IUCV_BOUND) {
+	if (!sk || sk->sk_state != IUCV_BOUND) {
 		kfree_skb(skb);
 		return NET_RX_SUCCESS;
 	}
 
 	bh_lock_sock(sk);
-	iucv->msglimit_peer = iucv_trans_hdr(skb)->window;
-	sk->sk_state = IUCV_CONNECTED;
-	sk->sk_state_change(sk);
+	afiucv_hs_synack(sk, iucv_trans_hdr(skb)->window);
 	bh_unlock_sock(sk);
 	consume_skb(skb);
 	return NET_RX_SUCCESS;
@@ -2053,16 +2087,13 @@ static int afiucv_hs_callback_synack(struct sock *sk, struct sk_buff *skb)
  */
 static int afiucv_hs_callback_synfin(struct sock *sk, struct sk_buff *skb)
 {
-	struct iucv_sock *iucv = iucv_sk(sk);
-
-	if (!iucv || sk->sk_state != IUCV_BOUND) {
+	if (!sk || sk->sk_state != IUCV_BOUND) {
 		kfree_skb(skb);
 		return NET_RX_SUCCESS;
 	}
 
 	bh_lock_sock(sk);
-	sk->sk_state = IUCV_DISCONN;
-	sk->sk_state_change(sk);
+	afiucv_hs_synfin(sk);
 	bh_unlock_sock(sk);
 	consume_skb(skb);
 	return NET_RX_SUCCESS;
@@ -2073,19 +2104,15 @@ static int afiucv_hs_callback_synfin(struct sock *sk, struct sk_buff *skb)
  */
 static int afiucv_hs_callback_fin(struct sock *sk, struct sk_buff *skb)
 {
-	struct iucv_sock *iucv = iucv_sk(sk);
-
 	/* other end of connection closed */
-	if (!iucv) {
+	if (!sk) {
 		kfree_skb(skb);
 		return NET_RX_SUCCESS;
 	}
 
 	bh_lock_sock(sk);
-	if (sk->sk_state == IUCV_CONNECTED) {
-		sk->sk_state = IUCV_DISCONN;
-		sk->sk_state_change(sk);
-	}
+	if (sk->sk_state == IUCV_CONNECTED)
+		afiucv_hs_fin(sk);
 	bh_unlock_sock(sk);
 	consume_skb(skb);
 	return NET_RX_SUCCESS;
@@ -2153,6 +2180,57 @@ static int afiucv_hs_callback_rx(struct sock *sk, struct sk_buff *skb)
 	return NET_RX_SUCCESS;
 }
 
+/**
+ * afiucv_hs_dispatch() - run the callback of a frame
+ * @sk:		the socket the frame is for, or NULL if there is none
+ * @skb:	the frame
+ *
+ * Context: Softirq.
+ * Return: NET_RX_SUCCESS.
+ */
+static int afiucv_hs_dispatch(struct sock *sk, struct sk_buff *skb)
+{
+	struct af_iucv_trans_hdr *trans_hdr = iucv_trans_hdr(skb);
+	int err = NET_RX_SUCCESS;
+
+	switch (trans_hdr->flags) {
+	case AF_IUCV_FLAG_SYN:
+		/* connect request */
+		err = afiucv_hs_callback_syn(sk, skb);
+		break;
+	case (AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_ACK):
+		/* connect request confirmed */
+		err = afiucv_hs_callback_synack(sk, skb);
+		break;
+	case (AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_FIN):
+		/* connect request refused */
+		err = afiucv_hs_callback_synfin(sk, skb);
+		break;
+	case (AF_IUCV_FLAG_FIN):
+		/* close request */
+		err = afiucv_hs_callback_fin(sk, skb);
+		break;
+	case (AF_IUCV_FLAG_WIN):
+		err = afiucv_hs_callback_win(sk, skb);
+		if (skb->len == sizeof(struct af_iucv_trans_hdr)) {
+			consume_skb(skb);
+			break;
+		}
+		fallthrough;	/* and receive non-zero length data */
+	case (AF_IUCV_FLAG_SHT):
+		/* shutdown request */
+		fallthrough;	/* and receive zero length data */
+	case 0:
+		/* plain data frame */
+		IUCV_SKB_CB(skb)->class = trans_hdr->iucv_hdr.class;
+		err = afiucv_hs_callback_rx(sk, skb);
+		break;
+	default:
+		kfree_skb(skb);
+	}
+	return err;
+}
+
 /*
  * afiucv_hs_rcv() - base function for arriving data through HiperSockets
  *                   transport
@@ -2233,42 +2311,7 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struct net_device *dev,
 	 data -> send FIN
 	 SYN|ACK, SYN|FIN, FIN -> no action? */
 
-	switch (trans_hdr->flags) {
-	case AF_IUCV_FLAG_SYN:
-		/* connect request */
-		err = afiucv_hs_callback_syn(sk, skb);
-		break;
-	case (AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_ACK):
-		/* connect request confirmed */
-		err = afiucv_hs_callback_synack(sk, skb);
-		break;
-	case (AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_FIN):
-		/* connect request refused */
-		err = afiucv_hs_callback_synfin(sk, skb);
-		break;
-	case (AF_IUCV_FLAG_FIN):
-		/* close request */
-		err = afiucv_hs_callback_fin(sk, skb);
-		break;
-	case (AF_IUCV_FLAG_WIN):
-		err = afiucv_hs_callback_win(sk, skb);
-		if (skb->len == sizeof(struct af_iucv_trans_hdr)) {
-			consume_skb(skb);
-			break;
-		}
-		fallthrough;	/* and receive non-zero length data */
-	case (AF_IUCV_FLAG_SHT):
-		/* shutdown request */
-		fallthrough;	/* and receive zero length data */
-	case 0:
-		/* plain data frame */
-		IUCV_SKB_CB(skb)->class = trans_hdr->iucv_hdr.class;
-		err = afiucv_hs_callback_rx(sk, skb);
-		break;
-	default:
-		kfree_skb(skb);
-	}
-
+	err = afiucv_hs_dispatch(sk, skb);
 	if (sk)
 		sock_put(sk);
 	return err;

-- 
2.56.0


