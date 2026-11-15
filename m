Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794706163;
	b=2R3UupN6EqrILxIZU906WBrCHtzOP3ImvhqUI7QivO8DE3doq7YynmQTWeCiqK1FwRnQ
	 Ko+3cYj0m8rqGT/ZB4AIE3B8IYvxDoBwKuyfRuaO+owcXQF4rpG6KHP8fG0JBKTklbt3u
	 8ByT6BTeq5wpy6QanUqE35JeR5j2xicQvUm2jj/0QcSgEVZM+artb69JiLvMB1kxPBGI+
	 5MZcWWxt7/OiV3XAv67If5kcB+7/RaP92rViuBoiSpMHfijGoDDid6IKR9E8Vqc9ANZNT
	 zFgPre7fgqFNh0j/YmJCahqxhiZw2w9vqtdsYi3nSYX95e+D5gheTxW2nQa6yXhIzwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794706163;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NdPK4zIvsum6LVV7bt5sulpK0UewV96pycd8Jh8Qs5Q=;
	b=q2lvnXoNqyrNcUM1vLO/jNSnN7mtovEqmtsAIB6w2onKNuXB3aSTZdg2UW1iuL7Y6/2I
	 tJbtrt5JfzPIq9UFAPg85KlHAY8EZl3WRUaxcb7ZKYN5CZmCldTvFK7Eat3VK7WGtZCZ9
	 YBEqX84cfmkJrPF1tiQFslnjB1lsvY5eD82OtMCqumI6udqzfMDdMY4Qom8UK0yj7iUNg
	 hp46DhyrrnGvF3wT7rK9M1HPq4aooo2Lo8nMA/113JAJapxAx6vkhXLPvalmiKUb43n96
	 CKr1IjUmzRKBOtODSv+aqolNcg2tFGujf/PFiPVXk4VhUhsKdQkwH6BszLWwQkpjADw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BLMPrHR0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE7960A260C;
	Sun, 15 Nov 2026 01:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BLMPrHR0
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794706163;
	b=WK7YTypiOZH9ownOikZk1EWElIYajjDjeKHmiGSzRt/Y6Yl+6KSw6sYAdpKrRV6WT8On
	 f9LpeNaJjpGSzgrTeM2C7ugFYY7f//s+EBmqYOoGZUTenm07L1cPR4mJ7duXhiA3UFsW0
	 E4SRs1PaKBzC3PXLf2WrdNGtVMczOMii5UaD2on5uaBFkTwoaa4ETzndYQEJwgWths6d2
	 qWDiN+oNvfuFLI5ye0jm3plhsV3gn3HVyBtYjsbzT8qhvTAksDZy4LwwpzdDvzbqhAfjl
	 Zh9Ty4LjT6HABjExaqhuOUYeZra34Iz73Tafuasg2ugx6pt9S7pHUjSjhzLtG7qgBTA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794706163;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NdPK4zIvsum6LVV7bt5sulpK0UewV96pycd8Jh8Qs5Q=;
	b=uQWzK08s/p9QaOBjEn/G6VU0u6E7/aKetDgFS6Rv0FwRpuusAxUKQd7Bx423rnMB0zXJ
	 fKD6+HL5hnflzBUgxl4tEXQ9S59k69KWlA3qTst4pYHZRiSSUdWUEYjdxV6RqF8YpehZr
	 v1ZVYGyZ9fNsOL1qvSvuwO9kRhXO924d4t3PyLf0j1cu6Dt2ZnDTGqhQK5PP1SzA1XXNB
	 +I8PzLlcJRFcOAs9G8Gnk9E2vFQ7qRUERJy5/S+8YLdk9yfv9RIu7JYqC+SE+DUypHosD
	 Td5U8JrPdozKxa1/d7ZaOqyCTn/fiS3/4tH76aPNuuAt36Nbw5v2/zCHH6K73xM6d4A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3B77B1F000C8;
	Sun, 15 Nov 2026 01:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794706163;
	bh=NdPK4zIvsum6LVV7bt5sulpK0UewV96pycd8Jh8Qs5Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=BLMPrHR0ZV6ERTMY6aAlUOX5mfpAzvWYC7Xq1SHTyuAp5ebtcTdJO6UxDY0YWH0xX
	 p2ingj83hGkqs+B7m4Ol1zNM0fJzrzchdHbaWcWqTAxnYoK0Lu0z3wIG1jcIFF2NtF
	 NcWWRwBQKFk7aPshICuSAnpwwEy+r1gNQ0MWweArasv8XFlo30ZimJy+LRVJow0Dq5
	 F4XYGkhggOwzDVIyiJWr1FYxbM0BQjlbN7g09qPC64n2XckjJd/103Cy7QC0VVQ6X9
	 zJ6/CEEvnLHa/NnSZaiBg4c6Mm6buiPpI3KfJ3CEm2QHSkbnSI4w0KObkXDCFqXqIA
	 1lWsSR41ctHlQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B8DAD49F18;
	Sun, 15 Nov 2026 01:29:19 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Sat, 14 Nov 2026 20:29:22 -0500
Subject: [PATCH RFC net v4 4/8] net/iucv: run recvmsg() under the socket
 lock
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
Message-Id: <20261114-b4-disp-fc0634a3-v4-4-f96c506447ce@proton.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794706158; l=9157;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=cvQd+g34cXrwlhTYJFvEJ2ofwQ9+z2Zr6o5MiT0Zg74=;
 b=+vlrIgEyTfyW+EOfZTN6pqTtT5gLoqC5aMVZbkRQO0KGTz2pKHYDxkyUV6nQnQ7Xn+abA+xfF
 21mwu0kaMiqCMpgfW7FldnyUX3gT85iXfOUP6+IaXp4z7gVH7Vfw1aJ
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=xw1AhCtQdvuoQc+bOQIYy9o8G++cp4/VniI2G/tc3G8=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/default with
 auth_id=893
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me
Content-Transfer-Encoding: 7bit

From: Bryam Vargas <hexlabsecurity@proton.me>

recvmsg() takes no socket lock, on either transport:

- Two threads reading one socket get its data out of order.
- A read that finds the peer's SHT sets RCV_SHUTDOWN with a plain
  read-modify-write of sk_shutdown, and can lose the SEND_SHUTDOWN that
  a shutdown(SHUT_WR) set meanwhile.
- A MSG_PEEK read leaves its skb on the receive queue and holds a
  reference to it. When a second reader consumes the skb meanwhile,
  that reference is the last one and skb_unref() frees nothing: the skb
  and its receive memory leak, and iucv_sock_destruct() warns.

All three need only a second thread at the wrong moment. No
memory-safety report is known from any of them.

Take lock_sock() in recvmsg(). It sleeps for data without the lock, in
sk_wait_event(), so a reader with nothing to read keeps no other call
on the socket waiting.

sendmsg() now waits for send memory without the socket lock as well:
recvmsg() needs that lock, and over z/VM the memory comes back only when
the peer reads, which may wait for our own reader. That wait is one more
point at which shutdown(SHUT_WR) can find the send memory used up:
iucv_send_ctrl() then has no room for the SHT and the peer reads no EOF,
as before this patch whenever the memory is used up when shutdown()
runs. The writer itself returns -EPIPE: iucv_send_ctrl() does not
clear SEND_SHUTDOWN, so the wait cannot miss it.

Fixes: eac3731bd04c ("[S390]: Add AF_IUCV socket support")
Suggested-by: Alexandra Winter <wintera@linux.ibm.com>
Link: https://lore.kernel.org/all/20260724222917.134769-1-hexlabsecurity@proton.me/
Cc: stable@vger.kernel.org # 6.18.x: aa5ec571b93f: net/iucv: Add lock nesting annotation in iucv_sock_close()
Cc: stable@vger.kernel.org # 6.18.x
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
v4: no code change, was 3/7. Two changes to the message, both for what
2/8 does under this patch:
- the second item was the sk_shutdown bit lost around a window update.
  That is 2/8's now; what is left here is recvmsg()'s own write of
  RCV_SHUTDOWN
- the last paragraph says what the writer gets when shutdown(SHUT_WR)
  runs during its memory wait. v3's note had that wait missing the
  wake-up, by inspection (AI review of v3, [4] in the cover letter)
v3: new as a patch of its own, the half of v2's lock patch that does
not touch the softirq side. Without 6/8 the softirq still changes
sk_state under a task that owns the socket, as on net.
v3: https://lore.kernel.org/netdev/20261110-b4-disp-2a6b4364-v3-3-35677b68e697@proton.me/

In the emulated setup: two readers on one socket under MTTCG, three runs
of 838 messages each. On net, on the kernel with 1/8 and 2/8 and on the
one with 1/8 to 3/8 every run has reads that go backwards, 9 to 20 of
them; on the one with 1/8 to 4/8 and with the series there are none.

The second item is by inspection. The test that loses the bit on net
(notes of 2/8) loses none from 2/8 on, and I have no test where the
peer's SHT is read while shutdown(SHUT_WR) runs.

Repro of the MSG_PEEK item: one process is parked in the copy of a
recv(MSG_PEEK), its buffer a userfaultfd page, and a second one reads
the same message. On net and on the kernels with 1/8, with 1/8 and 2/8
and with 1/8 to 3/8 the second read returns the byte while the first is
still parked; once both are back the socket has receive memory charged
and nothing to read, and iucv_sock_destruct() takes its WARN_ON() at
close. From 4/8 on the second reader waits for the first, then reads the
byte, and nothing stays charged. With the two reads one after the other
every kernel is clean.

sendmsg()'s memory wait: with it left under the socket lock, a
non-blocking read is held up for as long as a writer waits for send
memory, 5830 ms in the test.

shutdown(SHUT_WR) during that wait: a writer blocks with the send memory
full and SO_SNDTIMEO 8 s, and shutdown(SHUT_WR) is called 200 ms later.
On net and on the kernels with 1/8, with 1/8 and 2/8 and with 1/8 to 3/8
the shutdown() waits for the socket lock until the writer's timeout,
8028 to 8445 ms, and the writer returns -EAGAIN. With 1/8 to 4/8 and
with the series shutdown() returns at once and the writer
returns -EPIPE, 202 ms after it blocked. The case where the wake-up
could be missed is under 2/8.

The prerequisite on the stable line, aa5ec571b93f, brings
__iucv_sock_close(), which recvmsg() now calls with the lock held where
it used to close the socket on a peer that overran its window.

Hidayath's 19 KCSAN reports of recvmsg() against shutdown() on net-next
are what this patch should end; the READ_ONCE() in the receive wait
against shutdown()'s plain write stays reportable until 7/8 (cover
letter).
---
 net/iucv/af_iucv.c | 94 ++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 78 insertions(+), 16 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index d2d47f33d08b..80eb90b1ef3c 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -1050,7 +1050,17 @@ static int iucv_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 		}
 	}
 	skb = sock_alloc_send_pskb(sk, headroom + linear, len - linear,
-				   noblock, &err, 0);
+				   1, &err, 0);
+	if (!skb && err == -EAGAIN && !noblock) {
+		/* Wait without the socket lock: recvmsg() takes it, and over
+		 * z/VM the memory comes back only when the peer reads, which
+		 * may wait for our own reader.
+		 */
+		release_sock(sk);
+		skb = sock_alloc_send_pskb(sk, headroom + linear,
+					   len - linear, 0, &err, 0);
+		lock_sock(sk);
+	}
 	if (!skb)
 		goto out;
 	if (headroom)
@@ -1277,6 +1287,54 @@ static void iucv_process_message_q(struct sock *sk)
 	}
 }
 
+/**
+ * iucv_sock_recv_skb() - get the next skb for recvmsg(), waiting for one
+ * @sk:		the socket, locked by the caller
+ * @flags:	recvmsg() flags; MSG_PEEK leaves the skb queued and returns
+ *		it with a reference
+ * @err:	set when no skb is returned
+ *
+ * skb_recv_datagram() would sleep with the socket lock held. This sleeps in
+ * sk_wait_event(), which drops it.
+ *
+ * Context: Process context, socket lock held; sleeps with it released.
+ * Return: the skb, or NULL with @err set. At RCV_SHUTDOWN the caller
+ * returns EOF whatever @err is.
+ */
+static struct sk_buff *iucv_sock_recv_skb(struct sock *sk, int flags, int *err)
+{
+	long timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
+	struct sk_buff_head *queue = &sk->sk_receive_queue;
+	DEFINE_WAIT_FUNC(wait, woken_wake_function);
+	struct sk_buff *skb;
+
+	for (;;) {
+		skb = skb_recv_datagram(sk, flags | MSG_DONTWAIT, err);
+		if (skb || *err != -EAGAIN)
+			break;
+		if (sk->sk_shutdown & RCV_SHUTDOWN)
+			break;
+		if (!timeo)
+			break;
+		if (sk->sk_state != IUCV_CONNECTED) {
+			*err = -ENOTCONN;
+			break;
+		}
+		if (signal_pending(current)) {
+			*err = sock_intr_errno(timeo);
+			break;
+		}
+		add_wait_queue(sk_sleep(sk), &wait);
+		sk_wait_event(sk, &timeo,
+			      !skb_queue_empty_lockless(queue) ||
+			      READ_ONCE(sk->sk_err) ||
+			      (READ_ONCE(sk->sk_shutdown) & RCV_SHUTDOWN) ||
+			      sk->sk_state != IUCV_CONNECTED, &wait);
+		remove_wait_queue(sk_sleep(sk), &wait);
+	}
+	return skb;
+}
+
 static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 			     size_t len, int flags)
 {
@@ -1288,24 +1346,25 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	int err = 0;
 	u32 offset;
 
+	lock_sock(sk);
 	if ((sk->sk_state == IUCV_DISCONN) &&
 	    skb_queue_empty(&iucv->backlog_skb_q) &&
 	    skb_queue_empty(&sk->sk_receive_queue) &&
-	    list_empty(&iucv->message_q.list))
-		return 0;
+	    list_empty(&iucv->message_q.list)) {
+		copied = 0;
+		goto unlock;
+	}
 
-	if (flags & (MSG_OOB))
-		return -EOPNOTSUPP;
+	if (flags & (MSG_OOB)) {
+		err = -EOPNOTSUPP;
+		goto err_unlock;
+	}
 
-	/* receive/dequeue next skb:
-	 * the function understands MSG_PEEK and, thus, does not dequeue skb
-	 * only refcount is increased.
-	 */
-	skb = skb_recv_datagram(sk, flags, &err);
+	skb = iucv_sock_recv_skb(sk, flags, &err);
 	if (!skb) {
 		if (sk->sk_shutdown & RCV_SHUTDOWN)
-			return 0;
-		return err;
+			err = 0;
+		goto err_unlock;
 	}
 
 	offset = IUCV_SKB_CB(skb)->offset;
@@ -1355,8 +1414,9 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 			if (atomic_read(&iucv->msg_recv) >
 			    afiucv_hs_window(iucv)) {
 				WARN_ON(1);
-				iucv_sock_close(sk);
-				return -EFAULT;
+				__iucv_sock_close(sk);
+				err = -EFAULT;
+				goto err_unlock;
 			}
 		}
 
@@ -1398,7 +1458,8 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 		copied = rlen;
 	if (flags & MSG_PEEK)
 		skb_unref(skb);
-
+unlock:
+	release_sock(sk);
 	return copied;
 
 err_out:
@@ -1406,7 +1467,8 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 		skb_queue_head(&sk->sk_receive_queue, skb);
 	else
 		skb_unref(skb);
-
+err_unlock:
+	release_sock(sk);
 	return err;
 }
 

-- 
2.56.0


