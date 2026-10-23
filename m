Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792723716;
	b=EoFb4oza7PNirOVMDOSa8SgzUitmXI1q30NYFjhtVQi2I1qs6t7/NnINavsnFBojgFq4
	 nKA/GfRg4SPnbexSMP2fUhGEm3/g5S4OENoIlZS+zN1URtxDLuNBwRh7JPlqPCtWxLqW5
	 m1s4mdjCRtmTCNol90jfhEs/paq0oJpTyneaHbMe6M45WLZ7a1AouMLKV8YYk7NmSSCTn
	 Fng7BooZVxeev/CMdcvs3OM9Zu0fghiWhhYMc7Qk9dHPYuTkRxjS6/IQ/3KB5earIWyHo
	 O+jjRZQUmqjnBtZhYV/jpEFBPsUwEUWtCsq9aZsuk2nGhzvCNmIzYqNw8mFWmcI+Pyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792723716;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lrU730Els0hfEGGQZCap4U8KFDwD9XsljqNXbEBQEXI=;
	b=W9injlAel7YaYIIrI3tQX4Sq7ss0WY6K1sg2vXaUnZPWMf/AVaRVlk/zCS1DZdP9YrtX
	 oekcZS6iG69H/sGg3CDY7U8P4jkdoLmY5tDiNUYIrR0YF2rW0gpE7xNm+ZZ/f/9HA6QPJ
	 EfxH3Ul9zsLaoEL6PBsalghplVCaKlabprEw2n41hwcwB3DUJwP6EhNIAPjnxW9Sps5nC
	 VHjmhli+ZJmd0y8UhpZjXS533B9fPuUHSez+RcKNRnUFHhEZ7NZ5sLyIja6toXDJ5TSXj
	 lIAJmssnvTh2O46s32Tyu9VU9RIxSI7X5uUfZ18rZR4fZ58PaVcj70fs+x2Khd8jS+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EEMcxoGp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D5F606A31A;
	Fri, 23 Oct 2026 02:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EEMcxoGp
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792723715;
	b=mjYRZjMmRH/pRz9gKWRagtCXdvrDyaJpg6FpqMYygjndOPQfpXXhBif31NlBBBTRwFdt
	 /RdPj3bQMzHd2xUDASkiyISq+ltjXoH+ABBFAe0/u3y5MkJfCSgJ5R8HtH8w0gR18OsHN
	 OwXnZeaAkqqU58FdvsUUSYEaiSXTBgB2qxQVyaMA0MHoyHlGVdi2fcSzUDKAz/olRCNC2
	 WCcqXtv7mo+NqZcPCTQAA0f9EgGjpY/Yrn1O1BPGAdCo/Ni1m4oGLWu2EwF1zl0svn1bn
	 6Yp8ClnIruIm8Zc1h3vxn0sIW0YZVHazpttc9QHKzjb2I/1fMnQ3bUMz6qX415hMw6Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792723715;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lrU730Els0hfEGGQZCap4U8KFDwD9XsljqNXbEBQEXI=;
	b=wlWjgb2AkfAMmTm88K7fnDzXUqr+nrbqsHbrRc7FXOfTUw94vWOLjEdC8twdrBPBIokL
	 h8WvUqBP1z9cRW0/WbTbVrElIa6mO1l3sMYjWvkgOeqc4Mcp23h45Z0Eb4DvUPbxz9Ddr
	 jdUELzQi/sASsFjd6g566zVEtMMXBhv+YYD+b6gjMCnGyAgTO23rE1JGt/eq37kVrZ1O4
	 nILja/JhDU49o6/Hb89kMucEbZhezVHpa19iaL8OwGNalAs0iKCJrtKKKQc99TtqclFW3
	 9R40NMy7yN0ewDI3i2X8jn5GZn5azw9aIo7Rv+E2zykLwz6iHgShSdPSjw98qtY9uRg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 11E6C1F01829;
	Fri, 23 Oct 2026 02:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792723715;
	bh=lrU730Els0hfEGGQZCap4U8KFDwD9XsljqNXbEBQEXI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=EEMcxoGpOMoCgBbOqWm3wpXXrOGnmGNrmAWQ7jFwNYmwCfZr6vI+Juai3ALSe17Nr
	 tyzHvdvPumPQtTfL0xFhoC6268fCmUIw+GmR2xx1Fmdmpg/B7LVPLybEYBuP+FoyMG
	 d+OZu0WdlhPg3tRkxmR7eq/yd0jZW4nsU+pKVJJqmE5esKSh9CyLb8g2M4zbpyiTw1
	 rs9yUhNDqeMKCpx/RvLhd6V5HBIUbw2FM5O43q4wLSLshfkN8yOZoAmdeEAgY+fdmo
	 B/fB3itmHog8dgDk/sLba6qGsmXvNPh2YBIj1SQ4REUNT2ZGdykZK9rQlFm55U+av5
	 8OMQtcgtvW0PQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6E5D2421A6;
	Fri, 23 Oct 2026 02:48:34 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Thu, 22 Oct 2026 21:48:34 -0500
Subject: [PATCH net 1/2] net/iucv: clear hs_dev before dropping its
 reference
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
Message-Id: <20261022-b4-disp-b35a9153-v1-1-d74645876195@proton.me>
References: <20261022-b4-disp-b35a9153-v1-0-d74645876195@proton.me>
In-Reply-To: <20261022-b4-disp-b35a9153-v1-0-d74645876195@proton.me>
To: Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
 Alexandra Winter <wintera@linux.ibm.com>, 
 Thorsten Winkler <twinkler@linux.ibm.com>
Cc: Nagamani PV <nagamani@linux.ibm.com>, netdev@vger.kernel.org, 
 Hidayath Khan <hidayath@linux.ibm.com>, linux-s390@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792723713; l=6587;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=P+HCe6jSRQ3Dc8YpOmP3IA+B+Jzvut22mF+psyFknnI=;
 b=FIYU02GkQh+Mk/dq1thsKlF0OzyxEs4HhydLLNysGrRzMu32q4niTJeDBLXKV0UlBDVCKfGFF
 4d0JEWJzh/zBhfDeBah966rPJG/LgLh6WFd//HbrUDb0U+iO9Rs7EfZ
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=xw1AhCtQdvuoQc+bOQIYy9o8G++cp4/VniI2G/tc3G8=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/default with
 auth_id=893
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me
Content-Transfer-Encoding: 7bit

From: Bryam Vargas <hexlabsecurity@proton.me>

iucv_sock_close() drops the socket's reference on its HiperSockets
device and only then clears iucv->hs_dev, while afiucv_hs_rcv() compares
that field against the ingress device for every socket in the list,
under iucv_sk_list.lock and not the socket lock. Between the two it
compares a pointer the socket no longer holds; KCSAN reports the plain
read against the plain write. The order dates from 800c5eb7b5eb, the
compare from 80230a18c164. Nothing user-visible is known from it: the
receive path holds the ingress device, so the stale pointer is compared,
never dereferenced.

Clear the pointer first, through a local, then drop the reference, and
mark the lookup's read and the two stores that race with it: the clear
in close and the listener's child's, which is in iucv_sk_list from
iucv_sock_alloc() on. The child now takes its device and
sk_bound_dev_if from the frame the lookup matched, held before it is
published, instead of reading the listener's fields: close() clears
them under lock_sock(), which the bh_lock_sock() in
afiucv_hs_callback_syn() does not exclude, so the callback can pass its
IUCV_LISTEN check and then read a field close() has cleared. That a SYN
can be accepted while the listener closes is left to the socket-locking
rework; this is its KCSAN-visible part. bind()'s hs_dev store runs
under the list's write lock and stays plain. sk_bound_dev_if, which
getsockopt() reads without the lock, is marked where close(), bind()
and the child store it; annotation only.

Fixes: 800c5eb7b5eb ("af_iucv: change net_device handling for HS transport")
Fixes: 80230a18c164 ("net/iucv: filter frames in afiucv_hs_rcv() by ingress device")
Reported-by: Hidayath Khan <hidayath@linux.ibm.com>
Closes: https://lore.kernel.org/netdev/b3fea2ca-25ff-42c0-812c-f8cc6bb6667e@linux.ibm.com/
Suggested-by: Hidayath Khan <hidayath@linux.ibm.com>
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
Nagamani PV's "net/iucv: fix races in afiucv_netdev_event()" [1] marks the
same store in close(); Alexandra Winter asked him to hold it for the
locking series and he agreed [2]. This one goes now on a new, independent
KCSAN report, and its close() hunk subsumes his, which marks the store
but keeps dev_put() first; once this is applied, the
afiucv_netdev_event() read is what remains for his patch.

The loop's memcmp()s on the name fields are plain as well, against
connect()'s stores under lock_sock(); they were not in Hidayath's report
and are not touched here. The child that afiucv_hs_callback_syn() leaks
on its error paths (iucv_sock_kill() on a socket that was never closed
is a no-op), with the device reference it holds when dev_queue_xmit()
fails, is pre-existing; Hidayath flagged it in August [3] and his fix
for it is pending. A child the callback enqueues after
iucv_sock_cleanup_listen() has drained the accept queue is never
accepted or killed either; it now holds the device the frame arrived on,
where before it held the listener's device or nothing, depending on
which side of the clear it read.

Tested on s390x under QEMU TCG (net-next 8df0638138d3, KASAN +
PROVE_LOCKING) with an emulated HiperSockets adapter under the real qeth
and qdio drivers. The rework's test set, 53 tests, gives the same result
with and without this patch: the 8 that fail on net-next are the bugs
the rework fixes, and they fail the same way. That setup has no KCSAN
and nothing that drives afiucv_hs_rcv()'s lookup against a close() at
the right instant. Hidayath's KCSAN report covers the lookup's read and
proposed the clear-before-put order through a local; the child's device
source comes from reading the code.

[1] https://lore.kernel.org/netdev/20260917071706.23831-1-nagamani@linux.ibm.com/
[2] https://lore.kernel.org/netdev/1d9d3cc1-24fb-40e0-a4c7-6fbfbcf4dc37@linux.ibm.com/
[3] https://lore.kernel.org/netdev/5f88daf4-cd8e-4464-b132-ac45be205121@linux.ibm.com/
---
 net/iucv/af_iucv.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index db261ecd19af..501e758c5e68 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -447,9 +447,16 @@ static void iucv_sock_close(struct sock *sk)
 	}
 
 	if (iucv->hs_dev) {
-		dev_put(iucv->hs_dev);
-		iucv->hs_dev = NULL;
-		sk->sk_bound_dev_if = 0;
+		struct net_device *dev = iucv->hs_dev;
+
+		/* afiucv_hs_rcv() matches frames on hs_dev under
+		 * iucv_sk_list.lock, not the socket lock: clear it before the
+		 * reference goes, so the match can no longer find a device
+		 * this socket does not hold.
+		 */
+		WRITE_ONCE(iucv->hs_dev, NULL);
+		WRITE_ONCE(sk->sk_bound_dev_if, 0);
+		dev_put(dev);
 	}
 
 	/* mark socket for deletion by iucv_sock_kill() */
@@ -630,7 +637,7 @@ static int iucv_sock_bind(struct socket *sock, struct sockaddr_unsized *addr,
 				__iucv_auto_name(iucv);
 			else
 				memcpy(iucv->src_name, sa->siucv_name, 8);
-			sk->sk_bound_dev_if = dev->ifindex;
+			WRITE_ONCE(sk->sk_bound_dev_if, dev->ifindex);
 			iucv->hs_dev = dev;
 			dev_hold(dev);
 			sk->sk_state = IUCV_BOUND;
@@ -1912,9 +1919,14 @@ static int afiucv_hs_callback_syn(struct sock *sk, struct sk_buff *skb)
 	memcpy(niucv->dst_user_id, trans_hdr->srcUserID, 8);
 	memcpy(niucv->src_name, iucv->src_name, 8);
 	memcpy(niucv->src_user_id, iucv->src_user_id, 8);
-	nsk->sk_bound_dev_if = sk->sk_bound_dev_if;
-	niucv->hs_dev = iucv->hs_dev;
-	dev_hold(niucv->hs_dev);
+	/* skb->dev is the device the lookup matched against the listener's
+	 * hs_dev; the listener's own fields are cleared by close() under
+	 * lock_sock(), which this softirq does not hold. nsk is in
+	 * iucv_sk_list already: hold, then publish.
+	 */
+	WRITE_ONCE(nsk->sk_bound_dev_if, skb->dev->ifindex);
+	dev_hold(skb->dev);
+	WRITE_ONCE(niucv->hs_dev, skb->dev);
 	afiucv_swap_src_dest(skb);
 	trans_hdr->flags = AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_ACK;
 	trans_hdr->window = niucv->msglimit;
@@ -2087,7 +2099,11 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struct net_device *dev,
 	sk = NULL;
 	read_lock(&iucv_sk_list.lock);
 	sk_for_each(sk, &iucv_sk_list.head) {
-		if (iucv_sk(sk)->hs_dev != dev)
+		/* Cleared before iucv_sock_close() drops the reference:
+		 * whichever value is read is a device the socket still
+		 * holds, or NULL.
+		 */
+		if (READ_ONCE(iucv_sk(sk)->hs_dev) != dev)
 			continue;
 		if (trans_hdr->flags == AF_IUCV_FLAG_SYN) {
 			if ((!memcmp(&iucv_sk(sk)->src_name,

-- 
2.56.0


