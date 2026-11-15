Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794706162;
	b=g6SoY+AiziTaa4RfG/+ZPxW6nQOX3UlhvA8LCx0oPfW/UahZYSXUZGrpexUhXT63WAQV
	 rmgpi9DGKoecX59bLQy5rtea0sKRu+0suB0wHOLQ6N+jnX6hNQQyYNhxxb40bCo2++mnX
	 QSzrqKWEtgkpUxTsMARWqmUSm/FGFiqXsgCBr//28IkoohdjDnSlg6zgdUqf9pDbakaJ7
	 JuQtwWLe8ft//ORZUYZZHy5K6S/jSggvtXGTEDAHm5eUQxVpq7Ke8P+UWx/nXsmLq2LCG
	 Wm7SbRo+Vikh6oQrQNMqxuso2XqeOzX5NAQRebB4PO5HMX5+4mek6w2qcuohk5ei+zQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794706162;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=mT40bKyW0u0WOY7XlPRVT6yQTk7LxdFdLJ70C6kIqfg=;
	b=sM4dgo8Qc54AC97sc5PLUlWLhZaiL4pBsH2RY/Y6QZTMwlA1oDQuM32tR6yNzZmy/nNf
	 F4qIWnycbcxWFY0nUdDkyufzCXl1Zux0MRE+iA84OANgdmfaJo5Vx4BfsEjPgpQP0UoMp
	 ANnG9L3YibcAJiTF+RSRiSeDzZxCj41iVCres0qTIrLvEmp5SkSZ4V01KMaAB+FdQd6il
	 pa+XxiL/dbg4zmfyOQUI5gAIpCwn/ENP83H7pU4M7ri33+9mb7rTZcmroDL0i7+RmO6zA
	 JLJ7aFynrbDsHBIUIB68ppDGyLhLUwrao2xNJZP0pcNv7pCql7G0wst0aiD4EJvEQbg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lJ/dXxzg";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0B5606A8A8;
	Sun, 15 Nov 2026 01:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lJ/dXxzg
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794706162;
	b=RHPawRy6Xd/sbhZUY5VgJ2uuN3vJcdryx8tZiA03QmV5QoGlDovSK2Y5yWfmbA0VNLFA
	 ueoBFsNd5mG9OJYNZ2M1lhnXiKkRiVgLBkmIv5P1n5dS6cWZ8DcIU6eHVEM7zi6k3M2Qy
	 YC0ML4U70JDRIxooMZMNUt73rt+ZSPW11WaVlv0NIUzFWStgwzx4cz3Io/07/AQPFOULc
	 QP6cuJbnz9SDlVEag6QpT84vgbpHXrUr41IUGG5HsxyWML2OV031M6XZvqXMT8ufxEada
	 hlvK92hVhuJhGhQoP3mwPOvDVKuUQV746TFWxWmVVmLfSC2KkSsLYLEbPrFhOUpJvbg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794706162;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=mT40bKyW0u0WOY7XlPRVT6yQTk7LxdFdLJ70C6kIqfg=;
	b=zpQTdIU9E0fy7PxpG1CVM2GrSHKZ+i60uTxbN069e11rbxL09E4gja5d7pqzVL0YbJjr
	 91h3jKcXwQQ2W/D4tOgISHKc/LaPlJLI+TGd2NZS7ZpNh7nH9DfTxts5LgXp8fCFXWhoN
	 cRDgo3le4BQFL6hybWzl+SFz61mxHW+tIMIfjMyJax9cvO/xtzBOqpZ2RqmjqNB3Fl9fl
	 VAem/saZNRYqexGnDFUtM9fiegwk0d3hZaHFoKComrskwRQv0gBK/K3fRiSfuH8vceHvm
	 D+eSfZf2OSRfwhj8LLAN8VOJqgQpEn2RshuWjpQrAAHFYe9TCCJS4NIC+3GHTlCGNRw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5A9531F000C9;
	Sun, 15 Nov 2026 01:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794706162;
	bh=mT40bKyW0u0WOY7XlPRVT6yQTk7LxdFdLJ70C6kIqfg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=lJ/dXxzgKH/LYYxfO9qknkuN5e4M8XDzCiyTNX0gZSetHg/cW7uGkoFM0CrMKBYYK
	 QcS5gA+RB5A36GB2SU+6dCKy+y2WOg7cK40R/iXcKUpsBZJ8eREUf4tvFqsQAFQgsU
	 dABoZHM08eH+NOunyUTO6faNJHFuFSOBCbGXGryrIngKK545LjYR1tASnSNe4DxhFg
	 ZGfEGonL8UGdsCA9EgTQxhoiNMm759HN5c63Ci6AhdruYnGIex2pCmzf+S009PqnZv
	 nEaudKrWZ2NNhsc/dIO4GqlKTy89WoBcw4fHjN/huJYznVeRpJ5WzZ0SJKC641ppau
	 keqFyzuQVVzLg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CEE9C49F1C;
	Sun, 15 Nov 2026 01:29:19 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Sat, 14 Nov 2026 20:29:23 -0500
Subject: [PATCH RFC net v4 5/8] net/iucv: factor out the HiperSockets frame
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
Message-Id: <20261114-b4-disp-fc0634a3-v4-5-f96c506447ce@proton.me>
References: <20261114-b4-disp-fc0634a3-v4-0-f96c506447ce@proton.me>
In-Reply-To: <20261114-b4-disp-fc0634a3-v4-0-f96c506447ce@proton.me>
To: Jakub Kicinski <kuba@kernel.org>, 
 Alexandra Winter <wintera@linux.ibm.com>, Paolo Abeni <pabeni@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Hidayath Khan <hidayath@linux.ibm.com>, Eric Dumazet <edumazet@kernel.org>
Cc: Thorsten Winkler <twinkler@linux.ibm.com>, 
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nagamani PV <nagamani@linux.ibm.com>, 
 linux-s390@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794706158; l=7474;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=BNAZtikCBJei0ASy2WgzatfOm8YeIdFf9/iGDFegDGE=;
 b=v9r8wsBSEJ+0vY0TkPxfLeNVfcaTN6qXU346I+rouF+9JEbcekGF95oVXvhqkXKlajmJ3erQr
 VXF6+psv5cBBd0UE2cjETWL1jzhn68zDAYP9LoJ5tldc9ZifbQI2u/T
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
v4: unchanged, was 4/7.
v3: https://lore.kernel.org/netdev/20261110-b4-disp-2a6b4364-v3-4-35677b68e697@proton.me/

checkpatch asks for a Fixes: tag because of the stable line. There is
none to give: the patch fixes nothing and is marked for stable only so
that 6/8 applies there.

The kernel with 1/8 to 5/8 gives the result of the one with 1/8 to 4/8
in every test: the 53 default ones and the 28 opt-in ones (window,
strays, connect(), leaks).
---
 net/iucv/af_iucv.c | 151 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 97 insertions(+), 54 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 80eb90b1ef3c..957315bec2b4 100644
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
@@ -2041,17 +2079,13 @@ static int afiucv_hs_callback_syn(struct sock *sk, struct sk_buff *skb)
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
@@ -2062,16 +2096,13 @@ static int afiucv_hs_callback_synack(struct sock *sk, struct sk_buff *skb)
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
@@ -2082,19 +2113,15 @@ static int afiucv_hs_callback_synfin(struct sock *sk, struct sk_buff *skb)
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
@@ -2162,6 +2189,57 @@ static int afiucv_hs_callback_rx(struct sock *sk, struct sk_buff *skb)
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
@@ -2242,42 +2320,7 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struct net_device *dev,
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


