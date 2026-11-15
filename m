Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794706163;
	b=BoZdQR1QInnCwJyPOQxY0vHqUiX+0fLfXZQvBdaQHQAYQ4OT0j2KCzzOTYBVwii9APXJ
	 ikwu6DveqlexbEJ6o9LssxjeHuY7wkpk2zwiCAWhlPcE1YwnAq4DCewpXwKnOv0QoGTj+
	 KQC0/xgcgTSZ5Zkb6/CIKJId2vQuHZGEf0hqLZscIiAI7KJp17wQRMZyH+Rm4OoD4F3V6
	 EU3aZXQe+e+vmSMrSeKg42f9rOf2Rt0XjaW/EFXM9BIKb/o9+jsfrUJU/jTWGh+XONJwj
	 LUJod8uPU6Zt0Va6g2ES+K6JHRdN5q9X4fAcCplBkgbIefPbBOHhxZKXBAYKxn7G6Cw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794706163;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=c3htWKJ75xJuBRQtsw484cp2Y+pRipf2DlvL2KK5470=;
	b=Ylv5U88FlJ4QnLP5TUcFgt51RYIWioYSu/TEGG6Edg5dk3qX4vbhcWSYzyKbxEN/QKfd
	 TwhOJ1eEGa+eKcj0X6l6tsbx4TzwLohTxlj8DhZL9d+whKKPy5IX8q3oDUs+n4PjpK4Fb
	 CdaNEYwz6e1NCHhwK9Lo1tJUfq6h3jETTP0tAibvQKswrQcIRWhzdCf4dmiNp7h5B2cWf
	 gVTC9+AhdLvDvGMwdSGR5odG/mK995PRe9MSEQ49gA5m+XX22PvU2/tztrI1Atcixfg64
	 dCjpTrjS2uuU2MScufxVvWem+R3mH03AwZZ+HY+MxzkhiJuAp7w6sMuC0XJqB1JYFHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ljl7zLBa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB59360A261C;
	Sun, 15 Nov 2026 01:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ljl7zLBa
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794706163;
	b=dqHv5eV3oIIVOmVuizvZtIcSxhrLTNdQeGBsOu47yaVxcss4Qxl7uMUdYguf63EBVrxi
	 pwzPF9pz4PsououdNPKRrwMUWq/Aj2qh67gPOH/R6wxsXnfcHKY0mn+usCbSIsdn6vfPA
	 r4rweu4tTKjV4rZSJfoc8jj6z+cdS8tt/XPG0/9m5An2vafMKuC9NbA/vR4ShYLDZlApw
	 1boDFmCKuroURWm2U4FZB6i8eGYlMNB8awlD01EAjGK1joSk7b5LMhCWagChH4A0cK3tT
	 bK/UdrrevfZrdmQTJmp1w+zpwHkl56l+pOWr/ubc21Jjv3WsLm8FnIY5InY2lP7Zhvw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794706163;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=c3htWKJ75xJuBRQtsw484cp2Y+pRipf2DlvL2KK5470=;
	b=AGneEm13Lj0s6COyLsxNedw6NvSyjaD4eiCSeOaTk8Hq4dc/xD0yfGKUZiKg4cujwzff
	 WrEyKJJRdXzc/W8kJ/iFdV5BhlWpveZ6er6dBeLxdwyW/Lvgkdr8sYaOD/Cjj3yirk2Rk
	 Bp0nJFb+QHY5FpmufQByA/mGT5gQnfpgKweySIlnuqDbVIu8M62UU5PwXb0ZHax75B6xU
	 SBN+eqklouiS9Kd/nsKkmC817jj+LWYbILLrUmnmqssBEHMMmi0A6VLp0p6cctoK0NWjt
	 4b4fh8J66qA9pnbJ2QBrRnrLf0Ne8p2lH29taFIofCnYjkEaQ61uO3Ve9Ec5PoNEyzg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5A7411F000C5;
	Sun, 15 Nov 2026 01:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794706163;
	bh=c3htWKJ75xJuBRQtsw484cp2Y+pRipf2DlvL2KK5470=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ljl7zLBaePXyLQhiL3GpbG4Q0GCkBhJJF8KNsd94Da2eCLMxdwzU1ph98oIISFFtg
	 vD08yNFTf3Tz4j7X48bdQ0jZI1NBX++oFCbrX44/ZLvePBnw5AqkBuhmowDQM5vd6U
	 5E5PUZvxUQFh5TEob2/MAbERIJO4q/8K/bmmFpkdpeh2eL8xF85fRJHq30V82BLfuM
	 LlgQYm0MkBN7IILltlnVNB5uGADmnXmoB93+DaU7PUClK9nwPmN531Dbc1Z7mbbFfg
	 0MKy0z6UZ7kCgt4FDZ5Y8xKo5QN8ZRQu9M9njgpMsU8oUXXtap4io+2RfByxwjkD28
	 E0bZyGC2cr89w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E479A49F20;
	Sun, 15 Nov 2026 01:29:19 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Sat, 14 Nov 2026 20:29:24 -0500
Subject: [PATCH RFC net v4 6/8] net/iucv: serialize HiperSockets receive
 with the socket lock
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
Message-Id: <20261114-b4-disp-fc0634a3-v4-6-f96c506447ce@proton.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794706158; l=26182;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=rUqaD/RafqHz0/oBZmjuo4syd8i2ujVZgg7XDPO+y2A=;
 b=xoDOjpQpD/WqQqeynopn+helpjlO8OgDACYD0TUsYquFSLfYTOiQ0MjMWWvUexIDEhegGYGaW
 A2NVW5GR3HACkbyY0e8gIjPg2Q3YG0TLahPvJBeg/vhm+TTOAEsDiQ+
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=xw1AhCtQdvuoQc+bOQIYy9o8G++cp4/VniI2G/tc3G8=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/default with
 auth_id=893
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me
Content-Transfer-Encoding: 7bit

From: Bryam Vargas <hexlabsecurity@proton.me>

The HiperSockets receive callbacks change sk_state under bh_lock_sock()
without testing sock_owned_by_user(). A SYN|ACK, SYN|FIN or FIN that
arrives during a system call on the socket is applied under the task
that holds lock_sock(), which goes on with the state it read. A SYN is
answered for a listener that close() is emptying: the child is left on
the accept queue of a socket that is then freed, and nothing can close
it. It keeps the listener's name, so bind() to that name fails with
-EADDRINUSE from then on, and it keeps its reference on the net device.

Either needs only a frame from the peer at the wrong moment. No
memory-safety report is known.

Take bh_lock_sock() once in afiucv_hs_rcv(), for every frame that finds
a socket. While a task owns it:

- A SYN|ACK, SYN|FIN or FIN is recorded in the socket and applied by
  the owner from proto->release_cb. It is not queued: nothing resends a
  control frame, and the socket backlog can refuse one under memory
  pressure, since it does not take a pfmemalloc skb.
  connect() applies a recorded reply before it tests the state, so a
  non-blocking connect() still sees a reply that is already in.
- Data, SHT and WIN frames do not change sk_state and are handled on
  arrival, as before. They wait in the socket backlog only while the
  reply to our SYN is recorded and not applied yet, and behind frames
  that wait already, up to the window given to the peer plus one.
- A SYN for a listener waits in the backlog, cut to its header, up to
  the accept queue plus one. Past that, or if the listener closed or
  its queue filled meanwhile, it is refused without a child.

A frame that no state of the socket can use is freed in afiucv_hs_rcv()
and such a SYN refused there: a SYN|ACK or SYN|FIN outside IUCV_BOUND,
a FIN for a socket neither connected nor about to be, and data, SHT and
WIN frames behind a recorded FIN. A SYN for a socket that does not
listen was refused only after a child had been allocated for it, and
that child was never freed; it is now refused without one. A listener
whose accept queue is full still leaks the child when no task owns it,
as before.

Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
Suggested-by: Alexandra Winter <wintera@linux.ibm.com>
Link: https://lore.kernel.org/all/20260724222917.134769-1-hexlabsecurity@proton.me/
Cc: stable@vger.kernel.org # 6.18.x: f38bce9af9e2: net/iucv: take a private, writable frame before rewriting it in place
Cc: stable@vger.kernel.org # 6.18.x
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
v4:
- the SYN that waits in the backlog holds its device with netdev_hold()
  and netdev_put(), the tracker in the skb's cb; v3 had dev_hold() and
  dev_put() there (the deprecated_api check of the netdev CI)
v3:
- only the softirq side of the lock is left here; the other patches
  took the rest. Up to this patch the parked reader still gets
  -ENOTCONN at the peer's FIN, as on net; 8/8 changes that
- afiucv_hs_stray() calls a FIN a stray unless the socket is
  IUCV_CONNECTED or a recorded SYN|ACK is about to connect it. v2
  recorded a FIN that reached a socket in IUCV_BOUND and applied it
  after the SYN|ACK (AI review of v2, first item)
- data, SHT and WIN frames behind a recorded FIN are strays too, as
  afiucv_hs_callback_rx() frees them once the FIN is applied. v2 handled
  them as connected (second item)
- connect() applies a recorded reply to its SYN before it tests the
  state. v1 and v2 left the reply for release_sock(): a non-blocking
  connect() returned -EAGAIN with the SYN|ACK, or the SYN|FIN, already
  in, where net returns 0 or -ECONNREFUSED
- kernel-doc on every function added, with its context; the comment on
  afiucv_hs_defer() is rewritten (the reason v2 gave there was stale),
  the one on afiucv_hs_backlog_add() says why frames are counted
- on net, with nothing under it
v3: https://lore.kernel.org/netdev/20261110-b4-disp-2a6b4364-v3-5-35677b68e697@proton.me/
v2: https://lore.kernel.org/netdev/20261022-b4-disp-1d26b87a-v2-1-7ee1264d812a@proton.me/
v1: https://lore.kernel.org/netdev/20261011-b4-disp-410518f4-v1-1-753bf3258292@proton.me/

Repro of the listener in the message's first paragraph. The window is a
few instructions wide, between the last child taken off the accept
queue and the listener's IUCV_CLOSED, so the test kernels have an
mdelay(400) there and a SYN is sent 100 ms into the close(). net with
the delay: connect() returns 0, nothing ever accepts or closes the
child, one socket stays in use after both ends are closed, and a new
bind() to the listener's name fails with -EADDRINUSE. The series with
the same delay: the SYN waits in the listener's backlog, is refused
when the close is done, and connect() returns -ECONNREFUSED; nothing is
left and the name binds again. With the SYN sent before the close()
both kernels free the child. No KASAN splat with the delay.

Strays are freed in afiucv_hs_rcv(): a FIN with consume_skb(), as
afiucv_hs_callback_fin() frees it on net, the rest as NO_SOCKET drops.
With the drop trace on, a second FIN for a socket the first one
disconnected leaves no kfree_skb event, on net and here; the series
with that FIN dropped like the other strays leaves one NO_SOCKET drop.
A data byte sent the same way is a drop on every kernel.

The SYN for a socket that does not listen, measured: 16 connect() calls
to a socket that is bound and does not listen, each refused. On net and
up to 5/8 they leave 16 sockets in use after everything is closed, from
this patch on none. The full accept queue is not fixed: 1056 SYNs
refused by a listener whose queue is full leave 1056 sockets in use, on
net and with the series.

The backlog's budget is the window of 1/8 plus one, so a socket
connected by a SYN|ACK without a SYN of its own counts against msglimit
there too. With the socket held, three one-byte messages behind such a
SYN|ACK are all read after the release. With the budget read from
msglimit_adv alone, one is read and two are SOCKET_BACKLOG drops.

The first two items of the AI review of v2 repro on v2 as sent and are
gone here. Both hold the socket with a task parked in setsockopt(), its
filter a userfaultfd page, and send it one forged frame over the
emulated adapter. First: the socket's SYN is held back, so it is
IUCV_BOUND and no SYN|ACK exists; a FIN arrives, then the SYN is
released and the SYN|ACK comes in. v2 connects and disconnects at the
release; the series frees the FIN as it arrives and a byte goes each way
afterwards. With the FIN sent after the SYN|ACK instead, both apply it.
Second: the peer sends one byte and closes, then a forged data frame
arrives behind its FIN. v2 delivers the forged byte after the real one;
the series frees it and the reader gets EOF. net and v1 behave as the
series in both. v1 queued control frames and ran them in order, so both
came in when v2 began to record them instead. With any FIN recorded
again the first test fails; with frames let through behind a recorded
FIN, the second.

With any one of these pieces taken out, at least one test fails: the
release callback that applies what was recorded, the wait for the
owner, the reply to our SYN applied before the backlog runs, connect()
applying that reply, either half of afiucv_hs_stray()'s rule for a FIN,
its rule for frames behind one, the whole of afiucv_hs_stray(), the
budget read through the window helper, and the stray FIN consumed. Of
the 53 default tests the kernel with 1/8 to 6/8 fails six: the five in
the cover letter and the parked reader's -ENOTCONN, which 8/8 changes.

The device reference of a waiting SYN, on a build with
CONFIG_NET_DEV_REFCNT_TRACKER=y: 600 SYNs wait in the backlog of a
listener that is closing and are refused when it is done, then the
device is removed. With the series the tracker reports nothing and the
device is freed. With the netdev_put() of a refused SYN taken out the
removal waits, "Usage count = 601", and ref_tracker lists 600 users
at afiucv_hs_rcv_owned(). One boot of each, read off the console; that
kernel is a build of its own, not one of the 25 in the cover letter.

By inspection only, no repro: a pfmemalloc skb refused by the backlog
and the SOCK_ZAPPED test in afiucv_hs_apply().
---
 include/net/iucv/af_iucv.h |   7 +
 net/iucv/af_iucv.c         | 338 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 322 insertions(+), 23 deletions(-)

diff --git a/include/net/iucv/af_iucv.h b/include/net/iucv/af_iucv.h
index 6decbb1f34b3..a48ec2022661 100644
--- a/include/net/iucv/af_iucv.h
+++ b/include/net/iucv/af_iucv.h
@@ -15,6 +15,7 @@
 #include <linux/list.h>
 #include <linux/poll.h>
 #include <linux/socket.h>
+#include <net/net_trackers.h>
 #include <net/iucv/iucv.h>
 
 #ifndef AF_IUCV
@@ -128,14 +129,19 @@ struct iucv_sock {
 	struct sock_msg_q	message_q;
 	unsigned int		send_tag;
 	u8			flags;
+	u8			hs_pending;	/* AF_IUCV_PEND_*, af_iucv.c */
 	u16			msglimit;
 	u16			msglimit_peer;
 	u16			msglimit_adv;	/* window given to the peer */
+	u16			hs_pending_window;
 	atomic_t		skbs_in_xmit;
 	atomic_t		msg_sent;
 	atomic_t		msg_recv;
 	atomic_t		pendings;
 	int			transport;
+	/* frames in sk_backlog since it was empty */
+	unsigned int		hs_backlog_data;
+	unsigned int		hs_backlog_syn;
 	void			(*sk_txnotify)(struct sock *sk,
 					       enum iucv_tx_notify n);
 };
@@ -144,6 +150,7 @@ struct iucv_skb_cb {
 	u32	class;		/* target class of message */
 	u32	tag;		/* tag associated with message */
 	u32	offset;		/* offset for skb receival */
+	netdevice_tracker	dev_tracker;	/* SYN in the socket backlog */
 };
 
 #define IUCV_SKB_CB(__skb)	((struct iucv_skb_cb *)&((__skb)->cb[0]))
diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 957315bec2b4..2dd9f12bce62 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -44,7 +44,8 @@ static char iucv_userid[80];
  * @sk:		the socket, in IUCV_BOUND
  * @window:	the window in the SYN|ACK: the frames the peer takes from us
  *
- * Context: Softirq, under bh_lock_sock().
+ * Context: sk_lock.slock held: softirq with no task owning the socket, or
+ * the owner in afiucv_hs_apply().
  */
 static void afiucv_hs_synack(struct sock *sk, u16 window)
 {
@@ -77,10 +78,58 @@ static void afiucv_hs_fin(struct sock *sk)
 	sk->sk_state_change(sk);
 }
 
+/* iucv_sock.hs_pending: control frames recorded for the owner */
+#define AF_IUCV_PEND_SYNACK	0x01
+#define AF_IUCV_PEND_SYNFIN	0x02
+#define AF_IUCV_PEND_SYNREPLY	(AF_IUCV_PEND_SYNACK | AF_IUCV_PEND_SYNFIN)
+#define AF_IUCV_PEND_FIN	0x04
+#define AF_IUCV_PEND_ALL	(AF_IUCV_PEND_SYNREPLY | AF_IUCV_PEND_FIN)
+
+/**
+ * afiucv_hs_apply() - apply the control frames afiucv_hs_record() kept
+ * @sk:		the socket, owned by the caller
+ * @mask:	the AF_IUCV_PEND_* bits to apply
+ *
+ * A socket closed meanwhile takes none. The test is SOCK_ZAPPED, since
+ * __iucv_sock_close() leaves IUCV_BOUND as it is.
+ *
+ * Context: Process context, under sk_lock.slock.
+ */
+static void afiucv_hs_apply(struct sock *sk, u8 mask)
+{
+	struct iucv_sock *iucv = iucv_sk(sk);
+	u8 pending = iucv->hs_pending & mask;
+
+	iucv->hs_pending &= ~pending;
+	if (sock_flag(sk, SOCK_ZAPPED))
+		return;
+	if ((pending & AF_IUCV_PEND_SYNACK) && sk->sk_state == IUCV_BOUND)
+		afiucv_hs_synack(sk, iucv->hs_pending_window);
+	if ((pending & AF_IUCV_PEND_SYNFIN) && sk->sk_state == IUCV_BOUND)
+		afiucv_hs_synfin(sk);
+	if ((pending & AF_IUCV_PEND_FIN) && sk->sk_state == IUCV_CONNECTED)
+		afiucv_hs_fin(sk);
+}
+
+/**
+ * afiucv_hs_release_cb() - proto->release_cb, apply what was recorded
+ * @sk:		the socket, still owned by the caller
+ *
+ * Runs after the backlog, so a recorded FIN follows the data before it.
+ *
+ * Context: Process context, under sk_lock.slock.
+ */
+static void afiucv_hs_release_cb(struct sock *sk)
+{
+	if (iucv_sk(sk)->hs_pending)
+		afiucv_hs_apply(sk, AF_IUCV_PEND_ALL);
+}
+
 static struct proto iucv_proto = {
 	.name		= "AF_IUCV",
 	.owner		= THIS_MODULE,
 	.obj_size	= sizeof(struct iucv_sock),
+	.release_cb	= afiucv_hs_release_cb,
 };
 
 static struct iucv_interface *pr_iucv;
@@ -131,6 +180,7 @@ static void iucv_sock_kill(struct sock *sk);
 static void __iucv_sock_close(struct sock *sk);
 
 static void afiucv_hs_callback_txnotify(struct sock *sk, enum iucv_tx_notify);
+static int afiucv_hs_backlog_rcv(struct sock *sk, struct sk_buff *skb);
 
 static struct iucv_sock_list iucv_sk_list = {
 	.lock = __RW_LOCK_UNLOCKED(iucv_sk_list.lock),
@@ -571,6 +621,8 @@ static struct sock *iucv_sock_alloc(struct socket *sock, int proto, gfp_t prio,
 		iucv->transport = AF_IUCV_TRANS_HIPER;
 
 	sk->sk_destruct = iucv_sock_destruct;
+	/* not from iucv_proto: sk_alloc() does not copy proto->backlog_rcv */
+	sk->sk_backlog_rcv = afiucv_hs_backlog_rcv;
 	sk->sk_sndtimeo = IUCV_CONN_TIMEOUT;
 
 	sock_reset_flag(sk, SOCK_ZAPPED);
@@ -845,6 +897,15 @@ static int iucv_sock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 	if (err)
 		goto done;
 
+	/* The reply may be in already, recorded while we own the socket:
+	 * apply it, or a non-blocking connect() misses it.
+	 */
+	if (iucv->transport == AF_IUCV_TRANS_HIPER) {
+		spin_lock_bh(&sk->sk_lock.slock);
+		afiucv_hs_apply(sk, AF_IUCV_PEND_SYNREPLY);
+		spin_unlock_bh(&sk->sk_lock.slock);
+	}
+
 	if (sk->sk_state != IUCV_CONNECTED)
 		err = iucv_sock_wait(sk, iucv_sock_in_state(sk, IUCV_CONNECTED,
 							    IUCV_DISCONN),
@@ -1333,7 +1394,8 @@ static void iucv_process_message_q(struct sock *sk)
  * @err:	set when no skb is returned
  *
  * skb_recv_datagram() would sleep with the socket lock held. This sleeps in
- * sk_wait_event(), which drops it.
+ * sk_wait_event(), which drops it; a FIN recorded for the owner is applied
+ * then and ends the wait.
  *
  * Context: Process context, socket lock held; sleeps with it released.
  * Return: the skb, or NULL with @err set. At RCV_SHUTDOWN the caller
@@ -2027,7 +2089,6 @@ static int afiucv_hs_callback_syn(struct sock *sk, struct sk_buff *skb)
 	}
 
 	nsk = iucv_sock_alloc(NULL, sk->sk_protocol, GFP_ATOMIC, 0);
-	bh_lock_sock(sk);
 	if ((sk->sk_state != IUCV_LISTEN) ||
 	    sk_acceptq_is_full(sk) ||
 	    !nsk) {
@@ -2037,7 +2098,6 @@ static int afiucv_hs_callback_syn(struct sock *sk, struct sk_buff *skb)
 		err = dev_queue_xmit(skb);
 		if (nsk)
 			iucv_sock_kill(nsk);
-		bh_unlock_sock(sk);
 		goto out;
 	}
 
@@ -2068,7 +2128,6 @@ static int afiucv_hs_callback_syn(struct sock *sk, struct sk_buff *skb)
 		sk->sk_data_ready(sk);
 	} else
 		iucv_sock_kill(nsk);
-	bh_unlock_sock(sk);
 
 out:
 	return NET_RX_SUCCESS;
@@ -2084,9 +2143,7 @@ static int afiucv_hs_callback_synack(struct sock *sk, struct sk_buff *skb)
 		return NET_RX_SUCCESS;
 	}
 
-	bh_lock_sock(sk);
 	afiucv_hs_synack(sk, iucv_trans_hdr(skb)->window);
-	bh_unlock_sock(sk);
 	consume_skb(skb);
 	return NET_RX_SUCCESS;
 }
@@ -2101,9 +2158,7 @@ static int afiucv_hs_callback_synfin(struct sock *sk, struct sk_buff *skb)
 		return NET_RX_SUCCESS;
 	}
 
-	bh_lock_sock(sk);
 	afiucv_hs_synfin(sk);
-	bh_unlock_sock(sk);
 	consume_skb(skb);
 	return NET_RX_SUCCESS;
 }
@@ -2119,10 +2174,8 @@ static int afiucv_hs_callback_fin(struct sock *sk, struct sk_buff *skb)
 		return NET_RX_SUCCESS;
 	}
 
-	bh_lock_sock(sk);
 	if (sk->sk_state == IUCV_CONNECTED)
 		afiucv_hs_fin(sk);
-	bh_unlock_sock(sk);
 	consume_skb(skb);
 	return NET_RX_SUCCESS;
 }
@@ -2137,6 +2190,7 @@ static int afiucv_hs_callback_win(struct sock *sk, struct sk_buff *skb)
 	if (!iucv)
 		return NET_RX_SUCCESS;
 
+	/* also runs while a task owns the socket, see afiucv_hs_defer() */
 	if (sk->sk_state != IUCV_CONNECTED)
 		return NET_RX_SUCCESS;
 
@@ -2157,6 +2211,7 @@ static int afiucv_hs_callback_rx(struct sock *sk, struct sk_buff *skb)
 		return NET_RX_SUCCESS;
 	}
 
+	/* also runs while a task owns the socket, see afiucv_hs_defer() */
 	if (sk->sk_state != IUCV_CONNECTED) {
 		kfree_skb(skb);
 		return NET_RX_SUCCESS;
@@ -2189,12 +2244,174 @@ static int afiucv_hs_callback_rx(struct sock *sk, struct sk_buff *skb)
 	return NET_RX_SUCCESS;
 }
 
+/**
+ * afiucv_hs_stray() - test for a frame that no state of the socket can use
+ * @sk:		the socket the frame is for, under bh_lock_sock()
+ * @flags:	the flags of the frame
+ *
+ * A stray never waits for the owner. A SYN is one outside IUCV_LISTEN and a
+ * SYN|ACK or SYN|FIN outside IUCV_BOUND, the state tests of their
+ * callbacks; a full accept queue is not tested here. A FIN is one unless
+ * the socket is connected or a recorded SYN|ACK is about to connect it.
+ * Data, SHT and WIN are strays once the peer's FIN is recorded: the socket
+ * stays IUCV_CONNECTED until the owner applies it.
+ *
+ * Context: Softirq, under bh_lock_sock().
+ * Return: true if the frame is to be freed or, for a SYN, refused.
+ */
+static bool afiucv_hs_stray(struct sock *sk, u8 flags)
+{
+	struct iucv_sock *iucv = iucv_sk(sk);
+
+	switch (flags) {
+	case 0:
+	case AF_IUCV_FLAG_SHT:
+	case AF_IUCV_FLAG_WIN:
+		return iucv->hs_pending & AF_IUCV_PEND_FIN;
+	case AF_IUCV_FLAG_FIN:
+		return sk->sk_state != IUCV_CONNECTED &&
+		       !(iucv->hs_pending & AF_IUCV_PEND_SYNACK);
+	case AF_IUCV_FLAG_SYN:
+		return sk->sk_state != IUCV_LISTEN;
+	case AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_ACK:
+	case AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_FIN:
+		return sk->sk_state != IUCV_BOUND;
+	}
+	return true;
+}
+
+/**
+ * afiucv_hs_defer() - test whether a data, SHT or WIN frame has to wait
+ * @sk:		the socket, owned by a task, under bh_lock_sock()
+ *
+ * These frames do not change sk_state and are handled on arrival, also
+ * while a task owns the socket. They wait in the socket backlog only if:
+ *
+ * - the reply to our SYN is recorded and not applied yet: the socket is
+ *   still IUCV_BOUND, where data is freed and a WIN ignored;
+ * - frames wait already: a later one must not overtake them, and
+ *   sk_backlog.len stays non-zero until __release_sock() has run them all.
+ *
+ * Context: Softirq, under bh_lock_sock().
+ * Return: true if the frame has to wait in the backlog.
+ */
+static bool afiucv_hs_defer(struct sock *sk)
+{
+	return (iucv_sk(sk)->hs_pending & AF_IUCV_PEND_SYNREPLY) ||
+	       sk->sk_backlog.len != 0;
+}
+
+/**
+ * afiucv_hs_record() - keep a control frame for the task that owns the socket
+ * @sk:		the socket, owned by a task, under bh_lock_sock()
+ * @skb:	the frame, consumed here
+ * @flags:	the flags of the frame: SYN|ACK, SYN|FIN or FIN
+ *
+ * Not queued: nothing resends a control frame, and the socket backlog has
+ * to refuse a pfmemalloc skb. A bit in hs_pending is kept instead, and the
+ * window of a SYN|ACK. The first reply to our SYN decides; a FIN is applied
+ * after it.
+ *
+ * Context: Softirq, under bh_lock_sock().
+ */
+static void afiucv_hs_record(struct sock *sk, struct sk_buff *skb, u8 flags)
+{
+	struct iucv_sock *iucv = iucv_sk(sk);
+
+	switch (flags) {
+	case AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_ACK:
+		if (!(iucv->hs_pending & AF_IUCV_PEND_SYNREPLY)) {
+			iucv->hs_pending_window = iucv_trans_hdr(skb)->window;
+			iucv->hs_pending |= AF_IUCV_PEND_SYNACK;
+		}
+		break;
+	case AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_FIN:
+		if (!(iucv->hs_pending & AF_IUCV_PEND_SYNREPLY))
+			iucv->hs_pending |= AF_IUCV_PEND_SYNFIN;
+		break;
+	case AF_IUCV_FLAG_FIN:
+		iucv->hs_pending |= AF_IUCV_PEND_FIN;
+		break;
+	}
+	consume_skb(skb);
+}
+
+/**
+ * afiucv_hs_backlog_add() - make a frame wait for the task that owns the socket
+ * @sk:		the socket, owned by a task, under bh_lock_sock()
+ * @skb:	the frame
+ * @flags:	the flags of the frame: a SYN, or a data, SHT or WIN frame
+ *
+ * sk_add_backlog() is not used: its limit is in bytes and counts the
+ * receive queue too, while the window is in frames. So frames are counted:
+ *
+ * - data, SHT and WIN up to the window given to the peer plus one. They
+ *   wait only from the reply to our SYN until the owner has run them, and
+ *   a peer that keeps to its window sends at most that many data frames
+ *   and its SHT by then, and no WIN;
+ * - SYNs up to the accept queue plus the one sk_acceptq_is_full() admits.
+ *
+ * The counts restart only when __release_sock() has run every frame, so a
+ * peer cannot keep the owner in its loop. Past the limit a frame is
+ * dropped and a SYN refused; so is a pfmemalloc skb, on which
+ * __sk_backlog_rcv() BUG()s unless the socket is SOCK_MEMALLOC. A waiting
+ * SYN is cut to its header, all the reply needs, and holds its device:
+ * close() drops hs_dev before the release runs the SYN.
+ *
+ * Context: Softirq, under bh_lock_sock().
+ */
+static void afiucv_hs_backlog_add(struct sock *sk, struct sk_buff *skb,
+				  u8 flags)
+{
+	struct iucv_sock *iucv = iucv_sk(sk);
+	unsigned int *count;
+	unsigned int limit;
+
+	if (!sk->sk_backlog.len) {
+		iucv->hs_backlog_data = 0;
+		iucv->hs_backlog_syn = 0;
+	}
+	if (flags == AF_IUCV_FLAG_SYN) {
+		count = &iucv->hs_backlog_syn;
+		limit = sk->sk_max_ack_backlog + 1;
+	} else {
+		count = &iucv->hs_backlog_data;
+		limit = afiucv_hs_window(iucv) + 1;
+	}
+	if (*count >= limit ||
+	    (skb_pfmemalloc(skb) && !sock_flag(sk, SOCK_MEMALLOC)))
+		goto refuse;
+	if (flags == AF_IUCV_FLAG_SYN) {
+		if (pskb_trim(skb, sizeof(struct af_iucv_trans_hdr)))
+			goto refuse;
+		BUILD_BUG_ON(sizeof(struct iucv_skb_cb) >
+			     sizeof_field(struct sk_buff, cb));
+		netdev_hold(skb->dev, &IUCV_SKB_CB(skb)->dev_tracker,
+			    GFP_ATOMIC);
+	}
+	__sk_add_backlog(sk, skb);
+	/* a window of 65535 frames of 64K each would wrap the int */
+	sk->sk_backlog.len = min_t(u32, sk->sk_backlog.len + skb->truesize,
+				   INT_MAX);
+	(*count)++;
+	return;
+
+refuse:
+	if (flags == AF_IUCV_FLAG_SYN) {
+		afiucv_hs_callback_syn(NULL, skb);
+	} else {
+		sk_drops_inc(sk);
+		kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_BACKLOG);
+	}
+}
+
 /**
  * afiucv_hs_dispatch() - run the callback of a frame
  * @sk:		the socket the frame is for, or NULL if there is none
  * @skb:	the frame
  *
- * Context: Softirq.
+ * Context: BH disabled. @sk is under bh_lock_sock(), or owned by the caller
+ * in afiucv_hs_backlog_rcv().
  * Return: NET_RX_SUCCESS.
  */
 static int afiucv_hs_dispatch(struct sock *sk, struct sk_buff *skb)
@@ -2240,6 +2457,74 @@ static int afiucv_hs_dispatch(struct sock *sk, struct sk_buff *skb)
 	return err;
 }
 
+/**
+ * afiucv_hs_backlog_rcv() - sk_backlog_rcv, run a frame that waited
+ * @sk:		the socket, owned by the caller
+ * @skb:	the frame
+ *
+ * Frames run in the order of arrival. The reply to our SYN came before any
+ * of them, so it is applied first. A SYN is refused if the listener was
+ * closed or its accept queue filled meanwhile.
+ *
+ * Context: Process context, socket owned by the caller, no sk_lock.slock.
+ * Return: 0.
+ */
+static int afiucv_hs_backlog_rcv(struct sock *sk, struct sk_buff *skb)
+{
+	struct net_device *dev = NULL;
+	netdevice_tracker tracker;
+
+	spin_lock_bh(&sk->sk_lock.slock);
+	afiucv_hs_apply(sk, AF_IUCV_PEND_SYNREPLY);
+	spin_unlock_bh(&sk->sk_lock.slock);
+	if (iucv_trans_hdr(skb)->flags == AF_IUCV_FLAG_SYN) {
+		/* held by afiucv_hs_backlog_add(); the reply uses up the skb */
+		dev = skb->dev;
+		tracker = IUCV_SKB_CB(skb)->dev_tracker;
+		if (sk->sk_state != IUCV_LISTEN || sk_acceptq_is_full(sk)) {
+			afiucv_hs_callback_syn(NULL, skb);
+			netdev_put(dev, &tracker);
+			return 0;
+		}
+	}
+	/* BH off: the callbacks take message_q.lock with spin_lock() */
+	local_bh_disable();
+	afiucv_hs_dispatch(sk, skb);
+	local_bh_enable();
+	netdev_put(dev, &tracker);
+	return 0;
+}
+
+/**
+ * afiucv_hs_rcv_owned() - handle a frame while a task owns the socket
+ * @sk:		the socket, under bh_lock_sock()
+ * @skb:	the frame
+ * @flags:	the flags of the frame
+ *
+ * A SYN|ACK, SYN|FIN or FIN is recorded, a SYN waits in the backlog, and a
+ * data, SHT or WIN frame is handled now unless afiucv_hs_defer() says wait.
+ *
+ * Context: Softirq, under bh_lock_sock().
+ * Return: NET_RX_SUCCESS.
+ */
+static int afiucv_hs_rcv_owned(struct sock *sk, struct sk_buff *skb, u8 flags)
+{
+	switch (flags) {
+	case AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_ACK:
+	case AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_FIN:
+	case AF_IUCV_FLAG_FIN:
+		afiucv_hs_record(sk, skb, flags);
+		return NET_RX_SUCCESS;
+	case AF_IUCV_FLAG_SYN:
+		break;
+	default:
+		if (!afiucv_hs_defer(sk))
+			return afiucv_hs_dispatch(sk, skb);
+	}
+	afiucv_hs_backlog_add(sk, skb, flags);
+	return NET_RX_SUCCESS;
+}
+
 /*
  * afiucv_hs_rcv() - base function for arriving data through HiperSockets
  *                   transport
@@ -2311,18 +2596,25 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struct net_device *dev,
 	if (!iucv)
 		sk = NULL;
 
-	/* no sock
-	how should we send with no sock
-	1) send without sock no send rc checking?
-	2) introduce default sock to handle this cases
-
-	 SYN -> send SYN|ACK in good case, send SYN|FIN in bad case
-	 data -> send FIN
-	 SYN|ACK, SYN|FIN, FIN -> no action? */
+	/* no socket: a SYN is refused, anything else freed */
+	if (!sk)
+		return afiucv_hs_dispatch(NULL, skb);
 
-	err = afiucv_hs_dispatch(sk, skb);
-	if (sk)
-		sock_put(sk);
+	bh_lock_sock(sk);
+	if (afiucv_hs_stray(sk, trans_hdr->flags)) {
+		if (trans_hdr->flags == AF_IUCV_FLAG_SYN)
+			afiucv_hs_callback_syn(NULL, skb);
+		else if (trans_hdr->flags == AF_IUCV_FLAG_FIN)
+			consume_skb(skb);
+		else
+			kfree_skb_reason(skb, SKB_DROP_REASON_NO_SOCKET);
+	} else if (sock_owned_by_user(sk)) {
+		err = afiucv_hs_rcv_owned(sk, skb, trans_hdr->flags);
+	} else {
+		err = afiucv_hs_dispatch(sk, skb);
+	}
+	bh_unlock_sock(sk);
+	sock_put(sk);
 	return err;
 }
 

-- 
2.56.0


