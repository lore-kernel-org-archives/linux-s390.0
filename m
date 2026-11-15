Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794706161;
	b=b5HaUJ0mY6w9QbEQ4kN1b0GcZeHQEpDU9v/axiyAa8bdHfP0rITm7mYmmK4bpvbcux7/
	 2AUFAozjwyoJG2hWAa/IRTio4tmaJD1zYjsKAJWn2xveZB5f1RZ/3VaFefmUrJHjNAQuS
	 n7n4w4OUVLkci78wzdKwXy5pjETYL9vltlP7KyUygUfVLBZwVZjFkk31bnX7Y48Jro7RX
	 tJFgwaqDoik2x9J7/LJAoSJVStRqNBqUmyKNEkNZkOSbH3gpxfBwSYJR1PC2UDUxwREZt
	 iR+VNOgzXN0eG/QFqefQzXT038QKcz6q5xl6dbWUMI0QTPQipCNR+FVy6G1gQQnSy7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794706161;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7oJ6+wWL8z6sE4p0YH3fKjp8zrTRu+r2QNGshd9hGqQ=;
	b=RNqCs1f/3Mq+cVjGk/Amv0WsXgkQI8G/n50yObpk3htYifr3IcLsDHWGnizoJp+YrY6j
	 NnzivQ1w1VhMrZJfgIkI2qrp3Sk/wIv8Tqdlvy4W08S+A4pwo06em46onpNqNborOd4hk
	 I5iOszDqHqIRYcDp8iootPXb0U3Qpf65oYAdeV7+19dT44b7gL2PKFtxfNNe8ApIjHyng
	 rg+tH8byK0TpHcMzXyWAV8p6XDIZ+bEajBkh0+l38lfjb9CtlBh533mQ14k0F7dgkF8Sh
	 mz6YGwapok4l1ttfVbgHXRsCBr71oclqCS3KdN9m9knoLGscicwn+HJpK+fKYkCDAUg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J1IOQZnE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03903606A327;
	Sun, 15 Nov 2026 01:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J1IOQZnE
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794706160;
	b=ggnbF/DHTpZ+1n5LIdV5IlqJdCwj+zGqqxzykjl2oC9zAu1tf56XGOv4eqmwH0Zg22Ha
	 WILwAOmbbLHBrfqHNGhhLXYDwg7RDaj8YrMwIgpck6QqjGdBuIcfCWNYo2Zz/dJHKYHTM
	 QXneIBgnbVC4feTDc1+CwkdBUmN1sj+DGBb/Mj6TWtsS8+1Ev1up9LjdT6mJp3yqCL1bw
	 e3myVgjiJKbQKkHoMqibY6mp7K7Bn2RGKoS2vM/5Dq+CXL7dkjjRns0SqumwZU63UViMV
	 WfZGd2O5oWqzo5ROs49hrlsicPZ5elFGoe38NithXV/MDHcTdDF4meC0ZBwMdE/WsAA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794706160;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7oJ6+wWL8z6sE4p0YH3fKjp8zrTRu+r2QNGshd9hGqQ=;
	b=Tx0UR6i/0uf/Z0nH5E9AQPi1X+acLfrwnUS6xGmovB/jJoVKub8+Vn+EfVkCagTfA8Wf
	 urYMklXI/gMSfMxvtwQek3Ox1KFWm0mzkLh8boI8uAna3L5Vb6n9wBXeUWe6l4PmRfjgX
	 UWLT3LDEuZO/d5vwHmuzsEQtWwY2VT0WyKWsxh7HOZLYe+/hA/0dZB0Kvy9f6GOWiPRoF
	 Fj7xKG2jE0FFFhQtWtoNEq+5/+dyJDkOS1Wo3OvI2l2+8u+Vl3i8Urky8fj7w4pW7m8SD
	 wFsJ6Z5A3XqpbapJsPXT+McFOAE6887lQaE6nD9YiymVJI2EEkV6P/oIpd7SRrU+/ow==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E7EE11F000C5;
	Sun, 15 Nov 2026 01:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794706160;
	bh=7oJ6+wWL8z6sE4p0YH3fKjp8zrTRu+r2QNGshd9hGqQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=J1IOQZnEjNcBe3I1h3Ud8Qf+fWCpB9lSSSe9UyS2FJ9vIc/LA8b4bjr4R1ROfqru3
	 38yKTqEzRvIU11ETTGqzU5Wya1okm/JhWyUX81zh+S5YAJ3rhJnSA8Kg2agKwBme9k
	 nT+sIgthDNA0kvvTe7sDaPz6Uz0k39TbLpIGfIpOg62/ghfCl6eM0IKMcYozw4ogYI
	 WTYEjwMxAsLAmF/MOE7TeBP4lmp+jwkzVCrT++/ayAEBa3iy2rWH3e1+LYkC6cY/Qd
	 5EgmpqmxzZVCamQlhCMdMtzdI4owGVcCkgPA2P6eHIHwS3+BTBHEgEum9wClggZra1
	 2dQ5r0K9aAxLg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 741D749EDF;
	Sun, 15 Nov 2026 01:29:19 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Sat, 14 Nov 2026 20:29:19 -0500
Subject: [PATCH RFC net v4 1/8] net/iucv: keep the window given to the peer
 in a field of its own
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
Message-Id: <20261114-b4-disp-fc0634a3-v4-1-f96c506447ce@proton.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794706158; l=9899;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=tBktRCECV16AHemJJkc5PXWZncgcV3fTC9Z/nR+0JNo=;
 b=0SnjfkybWNKJu8o/FZrTS+z+dlRC+PjjG9tdDyvwce95iQMZHPM0AfmiZSJDPp2mtwCsOPW1N
 zif6Zx7LNf9C01kZ0hgh2nO+m+Qe7u97AlVTcSsi0DJ63vDc0F8Hptz
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=xw1AhCtQdvuoQc+bOQIYy9o8G++cp4/VniI2G/tc3G8=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/default with
 auth_id=893
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me
Content-Transfer-Encoding: 7bit

From: Bryam Vargas <hexlabsecurity@proton.me>

A HiperSockets SYN carries msglimit as the receive window, and
SO_MSGLIMIT is accepted while the socket is IUCV_BOUND, which it is
until the SYN|ACK arrives. A msglimit changed in between leaves the peer
with the window the SYN carried, while recvmsg() counts the frames it
reads against the new value:

- Lowered, a peer that keeps to its window has the socket closed on it
  once the receive buffer is full and frames wait in backlog_skb_q,
  where no window update resets the count: WARN_ON(), -EFAULT, the rest
  of the stream lost.
- Raised far enough, the threshold of the window update lies above the
  window: the count never reaches it, the peer uses up its window and
  its writer waits for an update that only a data frame from us would
  carry.

Record the window when the first SYN of a socket leaves, and in a
listener's SYN|ACK, and let recvmsg() count frames against it and take
the window-update threshold from it. A SYN that is not sent records
nothing, and a later SYN of the socket carries the recorded window. A
msglimit set after the first SYN no longer changes anything for that
socket; getsockopt() still returns it. A socket connected by a SYN|ACK
without having sent a SYN keeps msglimit as its window.

Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
Fixes: 800c5eb7b5eb ("af_iucv: change net_device handling for HS transport")
Cc: stable@vger.kernel.org # 6.18.x
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
v4 (AI review of v3, [3] in the cover letter):
- a later SYN of the socket carries the window the first one gave and
  records nothing. v3 wrote the field for every SYN, so a second
  connect() in IUCV_BOUND after a SO_MSGLIMIT change left the peer of
  the first SYN with a window the socket no longer counted against
- the window is recorded when the first SYN is handed to the device,
  after the device and MTU tests, and forgotten if that transmit fails.
  v3 recorded it while building the header: a connect() that failed
  with -ENETDOWN left a window nobody had received
- not changed: connect() still tests sk_state before lock_sock(), the
  last case of that review. A SYN sent that way does not move the
  window: it is recorded by then, or the socket was connected by a
  SYN|ACK it never asked for and the SYN records the msglimit the
  socket already counts against
v3: https://lore.kernel.org/netdev/20261110-b4-disp-2a6b4364-v3-1-35677b68e697@proton.me/

It goes first because the backlog of 6/8 counts against this window: on
the live msglimit it would drop data without a trace, as in Hidayath's
SO_MSGLIMIT scenario on v1.

Both cases in the message repro in the emulated setup, with the SYN|ACK
held back in the adapter while the limit changes:

- SO_MSGLIMIT 8 when the SYN goes out, lowered to 2, minimum SO_RCVBUF,
  the peer sends its 8 frames. net reads 2, then takes the WARN_ON() in
  iucv_sock_recvmsg() and returns -EFAULT; with this patch all 8 arrive.
  With the default SO_RCVBUF net delivers the 8 as well: a window update
  goes out after each read and resets the count.
- SO_MSGLIMIT 2 when the SYN goes out, raised to 8. The peer sends 2 and
  the socket reads both. On net no window update leaves and the peer's
  next send returns -EAGAIN; with this patch the update leaves and the
  send goes through. With the limit left at 2 both kernels send the
  update.

The v4 items, same setup:

- The lowered case with a second connect() after the limit changed, so
  that a second SYN leaves with the SYN|ACK of the first still held. The
  child the first SYN made sends its 8 frames: net reads 2, WARN_ON()
  and -EFAULT; this patch reads all 8. With the field written by every
  SYN again the socket reads 2 and takes the -EFAULT whichever child
  sends. net and this patch read all 8 from the child the second SYN
  made; with the second SYN carrying the live msglimit that child stops
  after 2 frames, as the socket counts against 8 and owes it no update.
- connect() with the interface down and SO_MSGLIMIT 1: -ENETDOWN, no SYN
  leaves. Interface up, the limit raised to 8, then a forged SYN|ACK and
  three frames. net and this patch read all three; with the window
  recorded ahead of the device test, as in v3, the socket reads one and
  the next read takes the WARN_ON() and returns -EFAULT.
- For a transmit that fails after the record I have no qdisc that drops
  on demand, so a test kernel drops the SYN to a destination name that
  begins with DSY: it frees the skb where dev_queue_xmit() would be
  called and hands back NET_XMIT_DROP. The sequence above with that
  SYN: the three frames are read; with the record left in place the
  second read fails as above.

Not changed, and for the maintainers to call: once a first SYN has
left, SO_MSGLIMIT is still accepted while the socket is IUCV_BOUND and
no longer moves the window, even when the next connect() names another
peer. The window given and the window counted agree, which is all this
patch is after. Refusing SO_MSGLIMIT once a SYN has left, or forgetting
the window when the destination changes, would each be a change of its
own.

The last sentence of the message is the third item of the AI review of
v2. net connects an IUCV_BOUND socket on any SYN|ACK, whether or not it
sent a SYN. The series leaves that as it is. With a forged SYN|ACK and
one byte for a socket that never called connect(), net and this patch
return the byte; with the window left at 0, as in v2, the read takes
the WARN_ON() and returns -EFAULT.

With afiucv_hs_window() back on the live msglimit, the lowered case
loses data in the backlog of 6/8 and the raised one stalls as on net.
None of this shows in the 53 default tests: with this patch the same
eight fail as on net, with the same result.
---
 include/net/iucv/af_iucv.h |  1 +
 net/iucv/af_iucv.c         | 35 ++++++++++++++++++++++++++++++++---
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/include/net/iucv/af_iucv.h b/include/net/iucv/af_iucv.h
index df85d19fbf84..6decbb1f34b3 100644
--- a/include/net/iucv/af_iucv.h
+++ b/include/net/iucv/af_iucv.h
@@ -130,6 +130,7 @@ struct iucv_sock {
 	u8			flags;
 	u16			msglimit;
 	u16			msglimit_peer;
+	u16			msglimit_adv;	/* window given to the peer */
 	atomic_t		skbs_in_xmit;
 	atomic_t		msg_sent;
 	atomic_t		msg_recv;
diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index ce13fe3c85b5..daed2a3cfd66 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -176,6 +176,22 @@ static inline int iucv_below_msglim(struct sock *sk)
 			(atomic_read(&iucv->pendings) <= 0));
 }
 
+/**
+ * afiucv_hs_window() - the window a HiperSockets socket gave its peer
+ * @iucv:	the socket
+ *
+ * The msglimit carried by its first SYN that was handed to the device, or
+ * by its SYN|ACK. A socket that sent neither has msglimit as its window:
+ * one about to send its first SYN, or one connected by a SYN|ACK it did not
+ * ask for.
+ *
+ * Return: the frames the peer may send before it needs a window update.
+ */
+static u16 afiucv_hs_window(const struct iucv_sock *iucv)
+{
+	return iucv->msglimit_adv ?: iucv->msglimit;
+}
+
 /*
  * iucv_sock_wake_msglim() - Wake up thread waiting on msg limit
  */
@@ -200,6 +216,7 @@ static int afiucv_hs_send(struct iucv_message *imsg, struct sock *sock,
 	struct iucv_sock *iucv = iucv_sk(sock);
 	struct af_iucv_trans_hdr *phs_hdr;
 	int err, confirm_recv = 0;
+	bool first_syn = false;
 
 	phs_hdr = skb_push(skb, sizeof(*phs_hdr));
 	memset(phs_hdr, 0, sizeof(*phs_hdr));
@@ -209,7 +226,7 @@ static int afiucv_hs_send(struct iucv_message *imsg, struct sock *sock,
 	phs_hdr->version = 1;
 	phs_hdr->flags = flags;
 	if (flags == AF_IUCV_FLAG_SYN)
-		phs_hdr->window = iucv->msglimit;
+		phs_hdr->window = afiucv_hs_window(iucv);
 	memcpy(phs_hdr->destUserID, iucv->dst_user_id, 8);
 	memcpy(phs_hdr->destAppName, iucv->dst_name, 8);
 	memcpy(phs_hdr->srcUserID, iucv->src_user_id, 8);
@@ -255,11 +272,21 @@ static int afiucv_hs_send(struct iucv_message *imsg, struct sock *sock,
 			phs_hdr->flags = phs_hdr->flags | AF_IUCV_FLAG_WIN;
 	}
 
+	/* The first SYN to leave: its window is what the peer may send us,
+	 * whatever msglimit becomes. A later SYN carries it.
+	 */
+	if (flags == AF_IUCV_FLAG_SYN && !iucv->msglimit_adv) {
+		iucv->msglimit_adv = iucv->msglimit;
+		first_syn = true;
+	}
+
 	atomic_inc(&iucv->skbs_in_xmit);
 	err = dev_queue_xmit(skb);
 	if (net_xmit_eval(err)) {
 		atomic_dec(&iucv->skbs_in_xmit);
 		atomic_add(confirm_recv, &iucv->msg_recv);
+		if (first_syn)
+			iucv->msglimit_adv = 0;
 	}
 	return net_xmit_eval(err);
 
@@ -1320,7 +1347,8 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 		consume_skb(skb);
 		if (iucv->transport == AF_IUCV_TRANS_HIPER) {
 			atomic_inc(&iucv->msg_recv);
-			if (atomic_read(&iucv->msg_recv) > iucv->msglimit) {
+			if (atomic_read(&iucv->msg_recv) >
+			    afiucv_hs_window(iucv)) {
 				WARN_ON(1);
 				iucv_sock_close(sk);
 				return -EFAULT;
@@ -1345,7 +1373,7 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 				iucv_process_message_q(sk);
 			if (iucv->transport == AF_IUCV_TRANS_HIPER &&
 			    atomic_read(&iucv->msg_recv) >=
-							iucv->msglimit / 2)
+						afiucv_hs_window(iucv) / 2)
 				send_win = true;
 		}
 		spin_unlock_bh(&iucv->message_q.lock);
@@ -1926,6 +1954,7 @@ static int afiucv_hs_callback_syn(struct sock *sk, struct sk_buff *skb)
 	afiucv_swap_src_dest(skb);
 	trans_hdr->flags = AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_ACK;
 	trans_hdr->window = niucv->msglimit;
+	niucv->msglimit_adv = niucv->msglimit;
 	/* if receiver acks the xmit connection is established */
 	err = dev_queue_xmit(skb);
 	if (!err) {

-- 
2.56.0


