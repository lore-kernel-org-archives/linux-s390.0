Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794372270;
	b=ph1i6iThPXSyrTrTs5kGDj4UF2dQf83v5JK1w1RqzwFf1CYeLY1RKeczM9xtbqpDS6CX
	 wVcxZFdMeYc00np9rVwLY72GgAQthYyFkVtpMga5X6oqTtd2F235TpoQHM7diG6ycyejX
	 fG+ZFxT54j7a4Mt0dXDEUVtXbFjCdtim2nYhMsJ8ymFDgt98Ik1xaira0xvysB9DPY83L
	 VpWj1aMUOseZ7Yvf7QvJEFNGsQ1809vz9uoZ7K7CNM0rTgWkYaMJweUDE7ngzDD/JHmYT
	 EvjMjdang+Sl11zI1hmwW2ehbAiwamqui0dc5PoCPG5s4o7Oi3uClq2c0x1ZhRCJrrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794372270;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=u9VPUbc4izH7FEkkdaizdNKqOr4utPacR2ZoWDb0/vY=;
	b=Gr+zrgoX4BhKDCQkOHOckjyXY1v6ZgVLFBOJ5TzHbi/ateAtzlVi2YTjPQpVI9Pg7dfm
	 xRnmf7p+7pTWNcjn2YxQXhgEuYhtqt0rRTNIBGXK4V8GFcOkYEttrUhz+vWvFdx5oot8F
	 WN2kX5DiTP5/b7UImQ37CI+pqBx5yqmdnFg6xW8uHuMsbCFBugFuj4ukOUKnQLETjxIAz
	 yYkDXeAPkR5rOg4sOVqaUbRMgrRsE0FOmHQQUXj7NnC4RiRT9vFuiLL0I1/p5yx1tqbrV
	 byLSpcRCjA+8RZBitBRbDNJNT0LWZdDqtGzEsdHDYoAsFu4QaVqU0lncKN97C0SsOEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mBnGfX8d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28CD60A2626;
	Wed, 11 Nov 2026 04:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mBnGfX8d
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794372270;
	b=IvjRaoo7irbSRVsnfWsc4AboPW27s4fn4ASj0AqCvaAE6C0Z0KYlDsVV/lIM8bnnngak
	 003ytG/l7f4gpv1CiazFw4G2IDHxJhZSWUfM8xDRjQDRX1Wu5CLQKo7QmQJxk4qz6kev/
	 D/IMOUnWfHncwjuNcaQ3QmMrEHygjKjl9kDhuaOTMeyka1XcJhS3fsQaJbzNR2om5fcI4
	 c77pHLxadVw5MUygtg9d9C93epYqs1b2rliEHtDf9uDJ9F1yGeMf5p/3ergWnZz327C97
	 1ULfDlA11bTU8UxslKhauX4UhT8dt9pzPMOknX0H1oxF+3YTmhE/d0Ge0afX0F4LfoA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794372270;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=u9VPUbc4izH7FEkkdaizdNKqOr4utPacR2ZoWDb0/vY=;
	b=JJgC19otGTI0kciZ40VhkHIyAg5nJAKuWMWbWZw2BFPkjzkx4r8c4QJRrsfLoSlX1gGm
	 cdgbrXKTcCTcufyN9E/sU6EyiTK3KXNGpzT5sin/iss/G31vv2NmOhKtRY9qKG3C4Uiu6
	 92l+WWih3j1RR8X9zX0cxdAgyg0Y/HGB6SBxMG+vhBbSh4Hhic8tHwXkbKoQneoiaGUik
	 +pj7en/hIjna++nsk7+t5OBD/BJceMuZBBjmQqST/bRgHrKkpjmydZ+dmf7fp0VR3EnRv
	 vuIjIqgrdK201grnFjqoEb7dkhdSw+bYr2y52UkzMFwiT26PDo6+G/8QP3dcPbmaS3w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E15F21F00A07;
	Wed, 11 Nov 2026 04:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794372270;
	bh=u9VPUbc4izH7FEkkdaizdNKqOr4utPacR2ZoWDb0/vY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=mBnGfX8dj+qDarZRPafzPP21ct5CviUQ2NbuFKan8RctKYxjl2xWMF4YGrtVcfS+x
	 HewMRfM01kGiirRxPhFpYKnU8WQKXt/0WoPVe8wxsJZk0HGzl3Eg1NM38IR78yzs44
	 IcJYCWAs2avN51ndMDsd26IcVbdb+X+aHRpKpUe8gbd9VDPNqxpovYQjHFSaCFcSCy
	 hXm0SeiIsJdy4HL9x0wYPKxnN0uy3QTlJumcsv9QZ7uifkXc5leshIGhSQj9wdXX7h
	 z7R2UwqlmR+Pu2ikw0OrnwAv62wAEB/as7ZfHvG+J6p/V/pGPyo3TR3cNIZN9V6Dm1
	 FXx1Z5VYxOF5w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 65F9748D9F;
	Wed, 11 Nov 2026 04:44:27 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Tue, 10 Nov 2026 23:44:31 -0500
Subject: [PATCH RFC net v3 6/7] net/iucv: set RCV_SHUTDOWN under the socket
 spinlock
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
Message-Id: <20261110-b4-disp-2a6b4364-v3-6-35677b68e697@proton.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794372266; l=5238;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=Ep0RU8oUAggO7JaKWdU5cfb9fSG5mTAN7Flxu2cQnGk=;
 b=1uaZ4vEDcvq+y2324j8c33XJEQ5U5mcRtRVfyIYuZuG/2PE8C0GisaPntzRS3GumlH8UetPTB
 UGY+lo1ZDRCBeu0uOUeyrJ+tpx1fBhrqsftjUBy1GiJSxw741llz+35
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=xw1AhCtQdvuoQc+bOQIYy9o8G++cp4/VniI2G/tc3G8=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/default with
 auth_id=893
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me
Content-Transfer-Encoding: 7bit

From: Bryam Vargas <hexlabsecurity@proton.me>

shutdown(SHUT_RD) sets RCV_SHUTDOWN and purges the receive queue under
lock_sock() alone, and nothing orders that against a HiperSockets data
frame: a frame that tested RCV_SHUTDOWN before the bit was set is
queued after the purge, and recvmsg() returns its data after
shutdown(SHUT_RD) returned.

Since the previous patch such a frame is received under sk_lock.slock,
also while a task owns the socket; one that waited for the owner runs
when it releases the socket, which shutdown() does only after the purge.
On HiperSockets, set the bit and purge under that lock. recvmsg() sets
the same bit under lock_sock() only, when it reads a zero-length record,
which is how the peer's SHT arrives; that write and the frame's test are
marked WRITE_ONCE() and READ_ONCE(), and only a frame the peer sent
after that record can race with it. iucv_send_ctrl() still clears and
restores SEND_SHUTDOWN in that byte with plain writes. The z/VM branch
is unchanged, less a line that was commented out.

Without the previous patch this one changes nothing: the frame then
takes no lock that shutdown() could share with it.

Fixes: 82492a355fac ("af_iucv: add shutdown for HS transport")
Reported-by: Hidayath Khan <hidayath@linux.ibm.com>
Closes: https://lore.kernel.org/netdev/b3fea2ca-25ff-42c0-812c-f8cc6bb6667e@linux.ibm.com/
Cc: stable@vger.kernel.org # 6.18.x, with the previous patch only
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
New in v3 as a patch: the hunk was in the lock patch of v2.

This is the first of the two races KCSAN reported on v1 in the mail
the Closes: tag points at, afiucv_hs_callback_rx() against
iucv_sock_shutdown() on sk_shutdown. The second there, on hs_dev, is
fixed by 1/2 of the two fixes posted for net on 28 Oct ([7] in the
cover letter), which are not in this series.

In the emulated setup, 200 cycles a run and four runs a kernel (QEMU's
default slice and three seeded short ones): net, the kernel with 1/7
and 2/7 and the one with 1/7 to 3/7 read data after shutdown(SHUT_RD)
in 0 to 7 cycles of a run, 39 of 2400 in all. The series reads none.
Nor does the series minus this spinlock: since 5/7 only a frame that
takes sk_lock.slock between shutdown()'s lock_sock() and its write gets
through, and no run had one. With udelay(50) added after lock_sock() in
shutdown() and after the frame's test, the series minus this spinlock
reads late data in 10 to 28 of 200 cycles and the series in none.

On the hardware Hidayath could not get that window to fire with v1
either, and KCSAN cannot show it closed: shutdown()'s write is now
WRITE_ONCE(), which the readers that take no lock need, and that alone
silences the report. IOW only the udelay() kernels above show what the
spinlock does.

The z/VM branch is unchanged; what is open there is under "Seen while
reviewing v3" in the cover letter.
---
 net/iucv/af_iucv.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index f31b037f28c1..2118effc137f 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -1462,7 +1462,7 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	rlen   = skb->len - offset;		/* real length of skb */
 	copied = min_t(unsigned int, rlen, len);
 	if (!rlen)
-		sk->sk_shutdown = sk->sk_shutdown | RCV_SHUTDOWN;
+		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
 
 	cskb = skb;
 	if (skb_copy_datagram_msg(cskb, offset, msg, copied)) {
@@ -1665,16 +1665,28 @@ static int iucv_sock_shutdown(struct socket *sock, int how)
 			iucv_send_ctrl(sk, AF_IUCV_FLAG_SHT);
 	}
 
-	sk->sk_shutdown |= how;
-	if (how == RCV_SHUTDOWN || how == SHUTDOWN_MASK) {
-		if ((iucv->transport == AF_IUCV_TRANS_IUCV) &&
-		    iucv->path) {
-			err = pr_iucv->path_quiesce(iucv->path, NULL);
-			if (err)
-				err = -ENOTCONN;
-/*			skb_queue_purge(&sk->sk_receive_queue); */
+	if (iucv->transport == AF_IUCV_TRANS_HIPER) {
+		/* Set the bit and purge under sk_lock.slock: a frame handled
+		 * on arrival tests RCV_SHUTDOWN under it, also while this
+		 * task owns the socket, and one that passed the test would
+		 * be queued after the purge. A frame that waited runs when
+		 * the owner releases the socket, not in between.
+		 */
+		spin_lock_bh(&sk->sk_lock.slock);
+		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | how);
+		if (how == RCV_SHUTDOWN || how == SHUTDOWN_MASK)
+			skb_queue_purge(&sk->sk_receive_queue);
+		spin_unlock_bh(&sk->sk_lock.slock);
+	} else {
+		sk->sk_shutdown |= how;
+		if (how == RCV_SHUTDOWN || how == SHUTDOWN_MASK) {
+			if (iucv->path) {
+				err = pr_iucv->path_quiesce(iucv->path, NULL);
+				if (err)
+					err = -ENOTCONN;
+			}
+			skb_queue_purge(&sk->sk_receive_queue);
 		}
-		skb_queue_purge(&sk->sk_receive_queue);
 	}
 
 	/* Wake up anyone sleeping in poll */
@@ -2208,7 +2220,7 @@ static int afiucv_hs_callback_rx(struct sock *sk, struct sk_buff *skb)
 		return NET_RX_SUCCESS;
 	}
 
-	if (sk->sk_shutdown & RCV_SHUTDOWN) {
+	if (READ_ONCE(sk->sk_shutdown) & RCV_SHUTDOWN) {
 		kfree_skb(skb);
 		return NET_RX_SUCCESS;
 	}

-- 
2.56.0


