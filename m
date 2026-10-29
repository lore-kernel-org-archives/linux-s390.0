Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793249183;
	b=sq5dlpuvnjZOZ9qRrMnyDKlad1UmHJh7sVmkeUEdLjr6u7M7KVJFCEMhc+9T1piWSnD4
	 YrDdYjxJDL5jnShExcT7hjA4uk/V2QWYmwUzAYJ4/eVsIXBjO4GSnghtwNhBw/6ZV+3Vm
	 Hr4XyJ2wfqKDDBjvpSV2wo8i8ia/z4zOxo90f6q6/JeNWdOe9oeIWKrj4wayVXZpoHL0W
	 z2T/Y0PyPwjldz3pEdQgvvaCj7auV9qjG+gnSw+GTyiTRE6rE6npGz49mazJ6QTYBpxWU
	 GQ+3/6c73V3geNwUzcijrh/yyTUFeTEBDmRG6qLXJiMiB5bJ/M399hmgiS4a3UooQTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249183;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tJ0TzXV8h1ttgac3FZDUql+FUi0wPPZOj8UIKlhUOsw=;
	b=h7dlrKQ3/PuuW3XtBJAMG4NoWjd/v01Zu3QJyaU4ZHUUGqlBAMhruvzbzSphxQd37yCa
	 kXmMLM6YsWnG+c2OQILUsDK11aqi/Rt4HGYmmuX5oeo80LGikaBShGOk8xprv8qsCHzFl
	 MHjwKI2A0c7uBKJPCu8nWTe/W5wv5hxGLGAEsmw0YWVAvlr+WnSmjAkTdsi/lo8G62Th1
	 YG9dYq2Td0dT4i51NpVAdVMTMzSGwawaATTqGiAzgRIqxIdxUKQSJEiqAmobNJ++G+LfD
	 Dxula7fJ4yxNDpMTuXbQuuPQDSHUJe8aQobE+N3uL5Y11oAiYsqdDjyNG171l1F4bAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AXzpGmwz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60344606A31A;
	Thu, 29 Oct 2026 04:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AXzpGmwz
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793249182;
	b=kkMEjkp5gYLzcohFDjMiGiSxj9whOKjHXkYxHJKAI0d+OiQBhidOTCqI45DUw8iOBVPq
	 SaqrlACdKIWJva1wFlPXXU1B+iRnz+eRGJVobH4cwInrsENTvxPqEBkW+hkpD9CL/pWPY
	 J3aB4/yZziaOh4mYMTeDLLD/pGu1pNYai52NSjgQDXjtoHEL5epG8wlaMElYxV1xszs0K
	 3PG+DxO5DVxF2PPEQz/E9lmuqZDtRZiaIt5hno3D7hlM1KhEjG7Tzar/svHMZB33deuuu
	 Acv2RGwVpfk0DyA5oK59/+2hiivhF9lTHS7R0zHQq/Uh5A5ZwfGkufe/B5FbYqvCeoA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793249182;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tJ0TzXV8h1ttgac3FZDUql+FUi0wPPZOj8UIKlhUOsw=;
	b=DwBvSzOfQF7tuXP6AoGb0AipDgJCHo5GHDM/7Zagj1zp2ufwwOKrfFfD076mpvcLwY/u
	 +6nH0/2XwNvapgjq9jEQtOEtHewNn6p1xttIor3quYx/kdFOUJIL8da5gIxb1J7CrVJLg
	 +VZtYBxVtPoDlwytrewa7yAYASbYUIgkYT2jAL+MxPdVrZ0RE3VXuFEKOCKd0b6FSaDG+
	 JpkIUebqVv+WXRZ/A6BMja7+6FchT8GI19tXji9NPsNtbWcwp4S1SatI2ZEFBR0TEuukK
	 7hZ8wXqZvuImkkJeJnUNcDLUvTf4VhDlq72ayDgeCgp5d3eCX5TgwC6XJQIC0VZfsnQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2157E1F01829;
	Thu, 29 Oct 2026 04:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793249182;
	bh=tJ0TzXV8h1ttgac3FZDUql+FUi0wPPZOj8UIKlhUOsw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=AXzpGmwzDZVT4hB0mqBdd4OrEI4Zv994S7NfxOj9pxBkioKBZ/pwzhsd5Dao2z3jU
	 AqdE9lrbaNL+l0bdCAh2+xjI3Andfb36YmlDSUPsSbV/IsEkhtVU7+sDaDLC/UEbDe
	 u7fGEbXEkSu1hq6NUOb+GnUJ23mmDdhwBhPlEUAlK8H+TO2danpTbB5EmV15uetePy
	 jmrLm5XkHZgJC2U0Jv0wLSR7UFz5KllIgVWmIXDhHyQ9nIgfPdQQw+E81GRQ8jRf96
	 1bTp4sXb58nrrDIYYUTQe8tBcnlWWD9kR6V/d9UxWjxfsUSjLIX5sCorwGH1SXXtJv
	 uadj+6y+lEI+Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 97D5F456AE;
	Thu, 29 Oct 2026 04:46:21 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Wed, 28 Oct 2026 23:46:21 -0500
Subject: [PATCH net v2 1/2] net/iucv: clear hs_dev before dropping its
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
Message-Id: <20261028-b4-disp-dd3e4ebb-v2-1-3747658d59bd@proton.me>
References: <20261028-b4-disp-dd3e4ebb-v2-0-3747658d59bd@proton.me>
In-Reply-To: <20261028-b4-disp-dd3e4ebb-v2-0-3747658d59bd@proton.me>
To: Thorsten Winkler <twinkler@linux.ibm.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Alexandra Winter <wintera@linux.ibm.com>, 
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-s390@vger.kernel.org, Nagamani PV <nagamani@linux.ibm.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Hidayath Khan <hidayath@linux.ibm.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793249180; l=6879;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=2K1l00p9eGIRHcd7EMw9H8SIVBens2dgUViXoV4z0UY=;
 b=zwWc04fzcCDzi3F6Lxk9vLg8LYEe4Gah3g0lr4VuMdcZb98NUDsspY6PoF0St5slechMDfciP
 Kj5yhSrrpD/By5b+G7S0kTusEPS58pQOUZHYIdpae8WIXgwR4UM1ZFm
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
compare from 80230a18c164. No user-visible effect is known: the receive
path holds the ingress device, so the stale pointer is compared, never
dereferenced.

Clear the pointer first, through a local, then drop the reference, and
mark the lookup's read and the two stores that race with it: the clear
in close() and the child's store in afiucv_hs_callback_syn() (the child
is in iucv_sk_list from iucv_sock_alloc() on). The child now takes its
device and sk_bound_dev_if from the frame the lookup matched, held
before it is published, instead of reading the listener's fields:
close() clears them under lock_sock(), which the bh_lock_sock() in
afiucv_hs_callback_syn() does not exclude, so the callback can pass its
IUCV_LISTEN check and then read a field close() has cleared. That a SYN
can be accepted while the listener closes is left to the socket-locking
rework; this is its KCSAN-visible part. bind()'s hs_dev store runs
under the list's write lock and stays plain. sk_bound_dev_if, which
getsockopt() reads without the lock, is marked where close(), bind()
and the child store it; annotation only.

Tested on s390x under QEMU TCG with a patched QEMU: an emulated
HiperSockets adapter under the real qeth and qdio drivers. The
socket-locking rework's test set gives the same results with and
without this patch; the race itself shows under KCSAN only.

Fixes: 800c5eb7b5eb ("af_iucv: change net_device handling for HS transport")
Fixes: 80230a18c164 ("net/iucv: filter frames in afiucv_hs_rcv() by ingress device")
Reported-by: Hidayath Khan <hidayath@linux.ibm.com>
Closes: https://lore.kernel.org/netdev/b3fea2ca-25ff-42c0-812c-f8cc6bb6667e@linux.ibm.com/
Suggested-by: Hidayath Khan <hidayath@linux.ibm.com>
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
Nagamani PV's "net/iucv: fix races in afiucv_netdev_event()" [1] marks
the same store in close(); Alexandra Winter asked him to hold it for the
locking series and he agreed [2]. This one goes out now, on a new and
independent KCSAN report, and its close() hunk subsumes his, which marks
the store but keeps dev_put() first; once this is applied, the
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
index 5ba875798aa4..5bab6aea910e 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -450,9 +450,16 @@ static void __iucv_sock_close(struct sock *sk)
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
@@ -638,7 +645,7 @@ static int iucv_sock_bind(struct socket *sock, struct sockaddr_unsized *addr,
 				__iucv_auto_name(iucv);
 			else
 				memcpy(iucv->src_name, sa->siucv_name, 8);
-			sk->sk_bound_dev_if = dev->ifindex;
+			WRITE_ONCE(sk->sk_bound_dev_if, dev->ifindex);
 			iucv->hs_dev = dev;
 			dev_hold(dev);
 			sk->sk_state = IUCV_BOUND;
@@ -1920,9 +1927,14 @@ static int afiucv_hs_callback_syn(struct sock *sk, struct sk_buff *skb)
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
@@ -2095,7 +2107,11 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struct net_device *dev,
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


