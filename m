Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794706163;
	b=XiDCU0S1NBde0MfG19obQHlj5kPuCvDx4LJEruFHAWIJVnQp/651IRafAdvhemg07CvZ
	 DMfU+rTU69Ds7xuSaJvASuaq1o2rGccEgMLt2bOVw3A+Jct0vhPgy8FmU7sMHiuJ3W/v7
	 x0oHRpIwRb0B2eoUB+HK0iMsJilmb1tYYFvVCwcJczhmkTYpTIKg9Z3NoPOeNazhEiVHI
	 L/uBBmUePiNy21f3X/P4VBgWFOJebSDGOmVTOV1M1fkUhYxa91D52eU809ZQevYWtLIAB
	 cailKll5MEVJoh3m28YXf23c+nFhduzl9pVUX1ggZpw41IEOBkoLWFI9hOkbmCs9QwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794706163;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wQFy8t1f9TvGLZZpmc7VNbY9wzyovUDDXPO/6Kt8S54=;
	b=UMQE1MrnF0fEnWpOxFVPL4tw5k+z2wsKC3CEqYZI3DIIa7149C3mED1K1IiAk8b148IV
	 jEh8jCbb2lvvfeoBelp4+tEr2ZSbOxz7T9PaMBNm+05Xl48o9tRfdRxm/SnuFVFMiVWT1
	 LdQFnuE2mhgWwA2dSuavfV5w0PZcU6z2dNnOTFAFg/H1Q2n3LZauItkTUECN38SSGnW7r
	 9u2+IHz9MsyG5m2nuywDthdlTdegUkChl0oOdL4yRnrSCK+o71BhV3FUmIAqHJNpjQO3P
	 Cp62X7i44Bd3FRcdRt5rYl0vATyhKfi+Qt5iglQ/i7qqEqMNFGYRQPwdjar486nvQFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=He6Hxgfb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797AA60A2604;
	Sun, 15 Nov 2026 01:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=He6Hxgfb
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794706163;
	b=b2L6HtLEZOumutoU0O1eCFWzBn4Gxb+wHWRUi3gKWK+K31sQxxi3qPlqNTAHZjp8Wez6
	 4s0Q1xUI9jKCAfVDrzIWG6gMRQ0ISetaoI5xgleQ5W7cLM/wIJXj40hVlU61bK8yRdZXM
	 bfeiC+7MQrCXKtH0BtYlLvJdOqAfH2UP9Drt4ebhJI17hipkyrcEmaVL6kyPOiT+gOsP2
	 6f0ZH2ZjW2p25Nb24jalO2sM1vXChpoGguydOYJEhxDl0BTM0/oHRbO5FSONWgSBrsiaH
	 1QXpttTuTGW/uDsIJ5fFiIG03xC7xUCsE2v4UGMfPI/TbPTvwTy6SbPP0aMoe1A0+jw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794706163;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wQFy8t1f9TvGLZZpmc7VNbY9wzyovUDDXPO/6Kt8S54=;
	b=ukrbvpWyw5RSdbmAIH/ZvdGFYFs/prcaURFz2MrCU74BJZOP/wl0gIOJ4OqeIC9OXtjT
	 rb7aWrOCTD9XgAhVV+pC5tqI17rUIdNZiafO+xn0wI6r1HXaVjuoqLpkXYh4BJvEcrmdB
	 /5gr0x+kDrVHqOkWq2xA+y/sfp9ke4+fQKRz0c0yUiqZwLuo4stlbkAzw7Qo+h2LD50T5
	 /hysq7rjS0VQ7aTaXDCc6e6J+mzjMrZHf9EKbfh9UIsZ5nOV6CC0/weoLvC6A1UZZBhrI
	 UxB7xGeNLukjqkiGe+3vkGiKDOJRG9+FGhJDcFF0DBKga/5sfPKUBWnhuOsRjS8Q+9A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E4EA41F000CC;
	Sun, 15 Nov 2026 01:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794706163;
	bh=wQFy8t1f9TvGLZZpmc7VNbY9wzyovUDDXPO/6Kt8S54=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=He6HxgfbcI/uAK1xKKI4L3Qd5toVf2LtWok5kKqG4Y1sxyHZIbfhjLEYfTG7t4wq0
	 3wnEzKmVNcpBrl5TcX0VECtjHu8C/ubJYrKIz79hyBsVsJpwmP4avvSZCYTTRHrYZy
	 EE4+mqUTflsLp2O3O/iqVBXVJYUvxrEglH0SSyARp6c9e+8nhhlX1RXcxxsVfI2H/e
	 AyIIBABqobqyWbmvdZmv13YIUtCf7w2uhHQqBF5GprKtBCLhoyD7yGeHbJphNbJKv8
	 7zDN3iJbIOqguvEzXqiYVOVP9FZJQgsLroL9HhACOzf8fWLoFe7b6AEHJbdm2WXZqC
	 +8ivgXJZMFLNg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1BC2449F28;
	Sun, 15 Nov 2026 01:29:20 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Sat, 14 Nov 2026 20:29:26 -0500
Subject: [PATCH RFC net v4 8/8] net/iucv: return EOF to a reader parked
 when the peer closes
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
Message-Id: <20261114-b4-disp-fc0634a3-v4-8-f96c506447ce@proton.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794706158; l=5822;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=yIOjUD35xIhM54ZE3C8FaqEc5HDffS6PKYKVECGLmR0=;
 b=rBymyfyUcyjG3Oy/edHNWS5TOMVZqtlJLWmeiT2AQgAwf81q7l+BFB/qg2J2WG1ice9jU8+xe
 qFNVikQcAUlBoV6I2VUR48fFWkc1ltzQmkrXTMuzozAacTGX0d1F6yC
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=xw1AhCtQdvuoQc+bOQIYy9o8G++cp4/VniI2G/tc3G8=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/default with
 auth_id=893
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me
Content-Transfer-Encoding: 7bit

From: Bryam Vargas <hexlabsecurity@proton.me>

A recvmsg() that starts after the peer closed returns 0. One that was
already waiting returns -ENOTCONN: its wait ends on sk_state and does
not ask whether anything is left to read. In a z/VM guest over
HiperSockets that was every parked reader, 13627 of 13627 on net-next
[1]. poll() does not report EPOLLRDHUP for the close either.

Return EOF from the wait too when the socket is IUCV_DISCONN with
nothing left to read. As for a call that starts afterwards, it does not
matter how the socket got there: the peer's FIN, a severed z/VM path, a
transmit error, a window update that could not be sent or the device
going down. EOF does not say that all the peer sent was read: a severed
z/VM path drops the messages not yet received, for either call. Set
RCV_SHUTDOWN where the HiperSockets FIN is applied, as TCP does: poll()
then reports EPOLLRDHUP and EPOLLRDNORM for the close, and EPOLLHUP if
the socket had shut down its own sending. The other ways still report
none of the three.

Fixes: 561e036006dc ("[AF_IUCV]: Implementation of a skb backlog queue")
Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
Reported-by: Hidayath Khan <hidayath@linux.ibm.com>
Closes: https://lore.kernel.org/netdev/82691101-92d7-4838-b16e-2e41a83f65d0@linux.ibm.com/
Link: https://lore.kernel.org/netdev/51a4a40a-f34b-4d41-b049-69aa53f4dcf5@linux.ibm.com/ [1]
Cc: stable@vger.kernel.org # 6.18.x
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
v4: unchanged, was 7/7. The last paragraph of v3's note is gone: since
2/8 the NETDEV_GOING_DOWN notifier no longer writes sk_shutdown, so it
cannot lose the RCV_SHUTDOWN of a FIN.
v3: this was 2/2 of v2. The EOF in the receive wait, which v2 had in
the lock patch, is here now, so both halves of one change in behaviour
are in one patch: the wait returns EOF, and the FIN sets RCV_SHUTDOWN.
v3: https://lore.kernel.org/netdev/20261110-b4-disp-2a6b4364-v3-7-35677b68e697@proton.me/

Each half covers what the other does not. RCV_SHUTDOWN at the FIN gives
the parked reader EOF and poll() EPOLLRDHUP on HiperSockets, but a z/VM
path severed under a sleeping reader sets no RCV_SHUTDOWN; the test in
the wait covers the sever and gives poll() nothing.

In the emulated setup:

- the peer closes under a reader, 40 cycles, half with the reader
  parked and half with the close racing its recv(): -ENOTCONN in 29 on
  net, 35 with 1/8 to 3/8 and 29 with 1/8 to 7/8; EOF in all 40 with
  this patch
- poll() after the peer's close, 10 cycles of three cases (nothing
  queued, a message unread, the socket's own SHUT_WR first): on those
  three kernels no EPOLLRDHUP in any of the 30 and no EPOLLHUP in the
  10 with SHUT_WR; with this patch each case reports what an AF_UNIX
  socketpair reports on the same kernel. With RCV_SHUTDOWN at the FIN
  taken out again the reader still gets EOF, from the wait, and poll()
  reports as before the patch
- a reader parked while its own interface goes down, or while a send of
  its own fails in the adapter (SBALF15 0x10), and a z/VM reader whose
  path is severed (emulated CP): -ENOTCONN on those three kernels, and
  again with the EOF taken out of the wait; EOF with this patch

The interface going down and the TX error change sk_state with no
socket lock, so the test in the wait looks at the receive queue again.
A test kernel has an mdelay() that holds the reader between its look
at the queue and its look at the state; a byte arrives and the
interface goes down in that time. The reader's call returns -ENOTCONN
and its next two the byte and EOF. With the receive queue left out of
the test the first call returns 0 with the byte still queued. FWIW net
returns -ENOTCONN the same way when the skb lands between its own two
tests, a narrower window. The window update that could not be sent is
by inspection.

After 6/8 the FIN is applied under sk_lock.slock on every path, by the
softirq with no owner or by the owner from release_cb, and 7/8 has
shutdown() write the same field under that lock.
---
 net/iucv/af_iucv.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 7a55bf884bc7..dda039bf5158 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -75,6 +75,8 @@ static void afiucv_hs_synfin(struct sock *sk)
 static void afiucv_hs_fin(struct sock *sk)
 {
 	sk->sk_state = IUCV_DISCONN;
+	/* as a TCP FIN: EOF for a reader, EPOLLRDHUP for poll() */
+	WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
 	sk->sk_state_change(sk);
 }
 
@@ -1398,8 +1400,9 @@ static void iucv_process_message_q(struct sock *sk)
  * then and ends the wait.
  *
  * Context: Process context, socket lock held; sleeps with it released.
- * Return: the skb, or NULL with @err set. At RCV_SHUTDOWN the caller
- * returns EOF whatever @err is.
+ * Return: the skb, or NULL with @err set: 0 if the connection is gone with
+ * nothing left to read and the call could still wait. At RCV_SHUTDOWN the
+ * caller returns EOF whatever @err is.
  */
 static struct sk_buff *iucv_sock_recv_skb(struct sock *sk, int flags, int *err)
 {
@@ -1417,7 +1420,16 @@ static struct sk_buff *iucv_sock_recv_skb(struct sock *sk, int flags, int *err)
 		if (!timeo)
 			break;
 		if (sk->sk_state != IUCV_CONNECTED) {
-			*err = -ENOTCONN;
+			/* disconnected and nothing left to read: EOF, as at
+			 * the top of iucv_sock_recvmsg()
+			 */
+			if (sk->sk_state == IUCV_DISCONN &&
+			    skb_queue_empty(&iucv_sk(sk)->backlog_skb_q) &&
+			    skb_queue_empty(&sk->sk_receive_queue) &&
+			    list_empty(&iucv_sk(sk)->message_q.list))
+				*err = 0;
+			else
+				*err = -ENOTCONN;
 			break;
 		}
 		if (signal_pending(current)) {

-- 
2.56.0


