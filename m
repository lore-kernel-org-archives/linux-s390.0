Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794372268;
	b=a2ZyHPb/Ag6skNifrpmJSZdHxACjo88CPBVAYQ6fVLijz7O3LBWdPij1vtksgHQl9Bp0
	 D8DZejQxplIVWrtyKbNc1GdljIRUDGmj0RZhR4HNNA2lpRzWPU72M0ifwOmjPVckGsIlT
	 20Y9Q6Su6DPfSR9hpi3cghej8297JRrF10dv4wZv8UvR+MoCYEoA6Yr3qqnG1Gdx7A0GB
	 EgeU6U9xpM7KAFlkilx0dCalCjf8702141Y9jeRsrRJFn7hOO+ikYfr9kgF8cWZE8MGsc
	 SoVVtOYxUchl8eOQfDO1q2SkFrRVAvHJQiuLF95zIzijv5hiqqaQyZlc3HM92JDb6xA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794372268;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YL2Gn/VBuzo3bpz+Gar3XFz6Jf2fQq2pQHYq/74rSfI=;
	b=BZ2IvQ2+BUb9a2o5Mpg2b5mYRWNVLwkzp4lq2J+14k08rMznOXMTRy3B3dcEpOiE9sdC
	 aox2GcVNRYt/J1j3gWFjvbht+6qPGD9oBQG5TAELhWOCkJ+nLgIkuVQGHVkE2Bz/VesqL
	 rj7Rx2PVU5HmWpcFAnejN48yKLLMD58HbEAiGa9UGU6r5dVz221Ykxm6XtZJ6G88iNPpr
	 Pgm7znFWd2NoZ3vjje9P4GBcs3ECNeJv2YaAZhbY7hpoJSi/18I2NRCaQClYIyRH0D4a6
	 rvZLSxgEJAulQ/UVrUQYiWqm2aXE7FA6Nck+asmekrR5S/BvTPE9yvdo5BamHrBhVkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GuIpdHDb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E25606A31C;
	Wed, 11 Nov 2026 04:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GuIpdHDb
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794372268;
	b=JXGEatHVA1DLZ1SS4nwdNoHaTn1oWSumwFRcX4ABnb9iYSeQjpbL4j2/8AVeo9mFyd1o
	 YaJTWm5qby4PZvxzoGA3VMr1/zytEkLZ7IBIEQKHdQ8eOU2Y9VpSlvmKQC9TDI2WdiU+a
	 jc4WLnW7HhbHzM+cvvaI6fkbanaWSp9CrbhHF4R36bSh5fmoYLgDZDYd21Sh5x6WN3kjY
	 nqviHhfUW3QDgluBXPzsGMIa2vX0f+9NNub/cDphQ2/pbuBfJNlC4G0u3608zq6oYP0x+
	 D9Tao3UL1wUUdh1TQmebsRQ8E8vXcbqAd65K6n2wDZtU9gMuKR1NUbfvaWMTUAtBJmw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794372268;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YL2Gn/VBuzo3bpz+Gar3XFz6Jf2fQq2pQHYq/74rSfI=;
	b=ZnikEj3PEf0v+6uiscaWqBjZfRCI4xr+1+hr02+4sGqRBZHTKW89OL72Kexcc06tXRFN
	 OyKyAJmtmGX27lnu8BQfJ4PV/xn5TWSVF3RaAy9B0Iu8Kq+CCyzrt0nOwK6g26KFfz8H8
	 6O3MSZ+cPLVbMQxCtQshosZU0dkBU/We1X574+oBbeYkVarL7fm/N5D7v4tLtaEiFqHUz
	 dvcvuhjLiZI+2B3LOsH200cARdEQom7bnwCRhtbvifVSl2yHFasDM9SDsDhvNYxING6iS
	 lBQiOSQmFEt+wfZtdRZearqMTd1n25P9KNed006Sy7IT+4OYLcBRskBgnYtc+QW+xpQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8C99E1F0089F;
	Wed, 11 Nov 2026 04:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794372268;
	bh=YL2Gn/VBuzo3bpz+Gar3XFz6Jf2fQq2pQHYq/74rSfI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=GuIpdHDbWIkZsy3GTOn3JluahobaJCC9rmSBQCGM4mn7pe/kWodxlywfdBkxHA/tV
	 qdy0OGeAAG3o53EW7L2Mvf8S4O6xqq6Xdj3nACTn6KnJeP5d0rd4+Webcl39doJBgt
	 PQr3efHGNZdUjigsu3moN1APUlUr/axr3JcIInJVdWrkwAvvvDdhg8OWoEiVROB3Hf
	 HQdDL+fPITzZyCNo+BExoY5aC8/XPs3OeaCIAUdmC2eILPHz+Bk31/GsxY7H0wC+Il
	 d50iSzjP1vgvv3xutu/huxOAuOa2oJVEDfss6OhnBOGikfYkpdj6yIIUcGM6D72JWG
	 iZqf5Z6mlD5dg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 064F148D83;
	Wed, 11 Nov 2026 04:44:27 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Tue, 10 Nov 2026 23:44:26 -0500
Subject: [PATCH RFC net v3 1/7] net/iucv: keep the window given to the peer
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
Message-Id: <20261110-b4-disp-2a6b4364-v3-1-35677b68e697@proton.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794372266; l=6172;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=dP9tWoaCJerEwmfDgRNHSm2FFayxgt3K3Jl/oDfEa04=;
 b=dWIyXI0vjR6Mi29KJ/uQ9RynSOHkgwkWC55KYK5JbVIQwqibQ1imKZlzuuBmvVNBebLd9mGW0
 5byDuzkVjXXB8ffZqPwXGpPgAlMV6uWa2cckR4m1EcMKUDlUH96HCXZ
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

Record the window where it goes out, in the SYN and in a listener's
SYN|ACK, and let recvmsg() count frames against it and take the
window-update threshold from it. A msglimit set after the SYN no longer
changes anything for that connection; getsockopt() still returns it. A
socket connected by a SYN|ACK without having sent a SYN keeps msglimit
as its window.

Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
Fixes: 800c5eb7b5eb ("af_iucv: change net_device handling for HS transport")
Cc: stable@vger.kernel.org # 6.18.x
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
New in v3 as a patch of its own (Alexandra); v2 had it inside the lock
patch. It goes first because the backlog of 5/7 counts against this
window: on the live msglimit it would drop data without a trace, as in
Hidayath's SO_MSGLIMIT scenario on v1.

Both cases repro in the emulated setup, with the SYN|ACK held back in
the adapter while the limit changes:

- SO_MSGLIMIT 8 when the SYN goes out, lowered to 2, minimum SO_RCVBUF,
  the peer sends its 8 frames. net reads 2, then takes the WARN_ON() in
  iucv_sock_recvmsg() and returns -EFAULT; with this patch all 8 arrive.
  With the default SO_RCVBUF net delivers the 8 as well: a window update
  goes out after each read and resets the count.
- SO_MSGLIMIT 2 when the SYN goes out, raised to 8. The peer sends 2 and
  the socket reads both. On net no window update leaves and the peer's
  next send returns -EAGAIN; with this patch the update leaves after
  the first read and the send goes through. With the limit left at 2
  both kernels send the update.

The last sentence of the message is the third item of the AI review of
v2. net connects an IUCV_BOUND socket on any SYN|ACK, whether or not it
sent a SYN. v3 leaves that as it is; against v2 it changes what such a
socket reads afterwards. With a forged SYN|ACK and one byte for a socket
that never called connect(), net and this patch return the byte; with
the window left at 0, as in v2, the read takes the WARN_ON() and returns
-EFAULT.

With afiucv_hs_window() back on the live msglimit, the lowered case
loses data in the backlog of 5/7 and the raised one stalls as on net.
None of this shows in the 53 default tests: with this patch the same
eight fail as on net, with the same result.
---
 include/net/iucv/af_iucv.h |  1 +
 net/iucv/af_iucv.c         | 25 ++++++++++++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

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
index ce13fe3c85b5..657c61161dbd 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -176,6 +176,20 @@ static inline int iucv_below_msglim(struct sock *sk)
 			(atomic_read(&iucv->pendings) <= 0));
 }
 
+/**
+ * afiucv_hs_window() - the window a HiperSockets socket gave its peer
+ * @iucv:	the socket
+ *
+ * The msglimit its SYN or SYN|ACK carried. A socket that sent neither, but
+ * was connected by a SYN|ACK, has msglimit as its window.
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
@@ -208,8 +222,11 @@ static int afiucv_hs_send(struct iucv_message *imsg, struct sock *sock,
 	phs_hdr->magic = ETH_P_AF_IUCV;
 	phs_hdr->version = 1;
 	phs_hdr->flags = flags;
-	if (flags == AF_IUCV_FLAG_SYN)
+	if (flags == AF_IUCV_FLAG_SYN) {
 		phs_hdr->window = iucv->msglimit;
+		/* what the peer may send us, whatever msglimit becomes */
+		iucv->msglimit_adv = iucv->msglimit;
+	}
 	memcpy(phs_hdr->destUserID, iucv->dst_user_id, 8);
 	memcpy(phs_hdr->destAppName, iucv->dst_name, 8);
 	memcpy(phs_hdr->srcUserID, iucv->src_user_id, 8);
@@ -1320,7 +1337,8 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 		consume_skb(skb);
 		if (iucv->transport == AF_IUCV_TRANS_HIPER) {
 			atomic_inc(&iucv->msg_recv);
-			if (atomic_read(&iucv->msg_recv) > iucv->msglimit) {
+			if (atomic_read(&iucv->msg_recv) >
+			    afiucv_hs_window(iucv)) {
 				WARN_ON(1);
 				iucv_sock_close(sk);
 				return -EFAULT;
@@ -1345,7 +1363,7 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 				iucv_process_message_q(sk);
 			if (iucv->transport == AF_IUCV_TRANS_HIPER &&
 			    atomic_read(&iucv->msg_recv) >=
-							iucv->msglimit / 2)
+						afiucv_hs_window(iucv) / 2)
 				send_win = true;
 		}
 		spin_unlock_bh(&iucv->message_q.lock);
@@ -1926,6 +1944,7 @@ static int afiucv_hs_callback_syn(struct sock *sk, struct sk_buff *skb)
 	afiucv_swap_src_dest(skb);
 	trans_hdr->flags = AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_ACK;
 	trans_hdr->window = niucv->msglimit;
+	niucv->msglimit_adv = niucv->msglimit;
 	/* if receiver acks the xmit connection is established */
 	err = dev_queue_xmit(skb);
 	if (!err) {

-- 
2.56.0


