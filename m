Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794706163;
	b=jdwlpAr8yJuBVM/0gxCiLdkFtCALmKFGlNt3X6fYT+TkmnvXy3VDccAqsF1dq3z7Yelt
	 JwuMdD5co1hsc60LJN9RMUoLKIP5Pevf44+GfZWlIDcq0m+XK5X9Ah5UPiQSeueMvMMjz
	 /2TmN3FjANBWrTixeznX8665QtqK1AujjrIYJdiWuoniGEEK6mZzXPQch1ZWy4oZAU66s
	 jpRRFdmUs1AX7i7r5O0n7UgKjmF+6XeYMtR0kT04nFqGRrhvh+vXxBFBH1MwZD+BOWB9h
	 /8+DSz39w7e+jrKLhe0MoKOoVn5nHAxONTBRjxJ4DbjSu+81KBKgTBJMs5WiUOAPcsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794706163;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ku97m2HZX8XQ8h+IcE61M8ZBXOi6ocu69VX5UiSdO1s=;
	b=XfD6bW0fXnQsqyHQrXX+IzeN+tp4oaH+8+JHY4bfBL3adEa3tmnoNnGJ0kKGkns9BiQt
	 Hus63066p7PmoSY5DM66piYvvzbwwmVzTzO6YB5fKJG6/lxH0xUOsHL2M3+4/2K1ZqC83
	 VLCqgQTdCI/tsjb4Y5qxkwRnz+p14Mk6mYdu6JlQGLX4pXqcBY52ruY2BRsdS4EumyPxF
	 Vb8RckZRApMs2hae3FHeLHaopP0IDlVs4Sm37N5MVi91ChXDB+VG0qWCJkXBj91rfGO/5
	 EHfqxYJtK0ODqOlEC13HWev4ZCJR8apz37s1l0TDCUyXd+gXz1Bv1M58ms5D47f7x+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZIeQZ/Dx";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2C8606A8B6;
	Sun, 15 Nov 2026 01:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZIeQZ/Dx
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794706163;
	b=EBvXclSEKYACp3t1Dofkb4DCQzIvU+PIkV5PgnG+nGzhN3Sq/nSsGeETsk8PicPd5Cfs
	 ecjGrGOwGEvwNT8Gp8PBxkU/hiRFAzzJzjB8JEKFx8vvnYktHAMKNUf3w7QC5H/gTylHW
	 4IsF8mxnhY2kNnJxFeTTq4yBrAkqOGUu2bfLQAG3RxFwZLXu7+kKJQsgJ2a9gtNDpj4fE
	 MFACbda5rEva5/KBgH54eJbM8Dz9LH3efkk4WC4UQ6KRXjPlKikvDMBFCs97p71EyoJmg
	 zym5h/1sSHGQjgW4R/icpObCT6C7kgHrwSMS73l1kRy/HuEPW2y6WL/t9B5Wm6NUaYg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794706163;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ku97m2HZX8XQ8h+IcE61M8ZBXOi6ocu69VX5UiSdO1s=;
	b=PiQU5t0usQcl/9cokrtG+vLQVlJg81qcOaed9oifCIKqWbnRECwUOLXr946cf+pKm1Tt
	 y4Md2C69TSzxj86yegY2tWwStQ9XaMhEPX4XqI0WKBxplhJ90kWAr5o52w1R2G6UYVfmc
	 HaGLvU1Nw5Rc1PXCyvS0m63mRzkoTKKnub1uD7K9BraNi1ugoa+IJ8Rmop+1zH6fFrd6J
	 BMcm9Awrh7JFSeSPUEMS8M88oWkMTdKXPBtVaufPGfegJrq9tA5DNh4uZ2t/ei4dLQhPR
	 3YReq4ede7Qs0Bf4jcvvhwyWSg5r8cP2kI/4GZn85Qxknc8x3pdOys6bIOTd2ZO4Yyg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D107C1F000CA;
	Sun, 15 Nov 2026 01:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794706162;
	bh=ku97m2HZX8XQ8h+IcE61M8ZBXOi6ocu69VX5UiSdO1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ZIeQZ/DxfHkolM97m/94dmQC/4CGW4cBPVMerdJytrVvPXBhPCeUq4TAcWH2toQmV
	 hYdo0FmALtuY6pdSGYUDCLZFuTQ86wrP4U/bLUKVM2TAWKmImPJARGy5fFoagYGYfy
	 xfTgWa7pzQ0IpUriBNPR9NCRWbVfnFQbf61cQOu9Oc9eHZdr8BuP0S+oHey/OR3DEJ
	 3p6Vepz0ruZdKJlB3v4cyDUCB8ys/fAckAHQJjlbmL4KoOzqZhj55F9e8/hI+YV/oP
	 llaGPCYrRLjNsgGxnsT3H+FOSuyPrDwIr+EcayuQzGYAJYZRCgxXQ6rURE1x5340Yf
	 eJH5oHEittrFQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 055B749F24;
	Sun, 15 Nov 2026 01:29:20 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Sat, 14 Nov 2026 20:29:25 -0500
Subject: [PATCH RFC net v4 7/8] net/iucv: set RCV_SHUTDOWN under the socket
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
Message-Id: <20261114-b4-disp-fc0634a3-v4-7-f96c506447ce@proton.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794706158; l=5330;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=m39ElHOtimEHpJnEH0tmuya4JnxKhIFGK22KOVCFRLQ=;
 b=l2+CmF42DpW6F7IbF96n6TbT04TbQTe0W2xaZrcznvFcgh0Xkf53nsDWPx6f1KgzwuMF9dWxc
 GvDt89wg5vWCcK9wERqokar1me+aMYLi2kIuzY7jb6spdFpLvZ8tlQE
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
after that record can race with it. The z/VM branch is unchanged, less
a line that was commented out.

Without the previous patch this one changes nothing: the frame then
takes no lock that shutdown() could share with it.

Fixes: 82492a355fac ("af_iucv: add shutdown for HS transport")
Reported-by: Hidayath Khan <hidayath@linux.ibm.com>
Closes: https://lore.kernel.org/netdev/b3fea2ca-25ff-42c0-812c-f8cc6bb6667e@linux.ibm.com/
Cc: stable@vger.kernel.org # 6.18.x, with the previous patch only
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
v4: the message no longer says that iucv_send_ctrl() clears and restores
SEND_SHUTDOWN in this byte; since 2/8 it does not. No code change.
v3: https://lore.kernel.org/netdev/20261110-b4-disp-2a6b4364-v3-6-35677b68e697@proton.me/

This is the first of the two races KCSAN reported on v1 in the mail
the Closes: tag points at, afiucv_hs_callback_rx() against
iucv_sock_shutdown() on sk_shutdown. The second there, on hs_dev, is
fixed by 1/2 of the two fixes posted for net on 28 Oct ([7] in the
cover letter), which are not in this series.

In the emulated setup, 200 cycles a run and four runs a kernel (QEMU's
default slice and three seeded short ones): net and the kernels with
1/8, with 1/8 and 2/8, with 1/8 to 3/8 and with 1/8 to 4/8 read data
after shutdown(SHUT_RD) in 0 to 9 cycles of a run, 68 of 4000 in all.
The series reads none. Nor does the series minus this spinlock: since
6/8 only a frame that takes sk_lock.slock between shutdown()'s
lock_sock() and its write gets through, and no run had one. With
udelay(50) added after lock_sock() in shutdown() and after the frame's
test, the series minus this spinlock reads late data in 9 to 19 of 200
cycles and the series in none.

On the hardware Hidayath could not get that window to fire with v1
either, and KCSAN cannot show it closed: shutdown()'s write is now
WRITE_ONCE(), which the readers that take no lock need, and that alone
silences the report. IOW only the udelay() kernels above show what the
spinlock does.

The z/VM branch is unchanged; what is open there is under "Still open"
in the cover letter.
---
 net/iucv/af_iucv.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 2dd9f12bce62..7a55bf884bc7 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -1471,7 +1471,7 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	rlen   = skb->len - offset;		/* real length of skb */
 	copied = min_t(unsigned int, rlen, len);
 	if (!rlen)
-		sk->sk_shutdown = sk->sk_shutdown | RCV_SHUTDOWN;
+		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
 
 	cskb = skb;
 	if (skb_copy_datagram_msg(cskb, offset, msg, copied)) {
@@ -1674,16 +1674,28 @@ static int iucv_sock_shutdown(struct socket *sock, int how)
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
@@ -2217,7 +2229,7 @@ static int afiucv_hs_callback_rx(struct sock *sk, struct sk_buff *skb)
 		return NET_RX_SUCCESS;
 	}
 
-	if (sk->sk_shutdown & RCV_SHUTDOWN) {
+	if (READ_ONCE(sk->sk_shutdown) & RCV_SHUTDOWN) {
 		kfree_skb(skb);
 		return NET_RX_SUCCESS;
 	}

-- 
2.56.0


