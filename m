Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794706161;
	b=SCQUZ+y16tPw2EclmrGlln1gJu2NHtNbucW1lhi/zbJHYr8vIio3rgTEA7zjaN8t9+Pe
	 XwxTbHqrx0QYIF7yALhfUj0+UwAM5Vt3/dZcpASgAZ2VMKiCks05f/tGg8yijh4LKNJkr
	 VrlVTpwYsW3dsEL08jCtBmNKJLnA7UwupZNpY1DooYggl6+gQe5Zlf+rHDPJPqONF3prU
	 +mODsbuimkw7sYF8KJI6uReELQwZllSz5N+FXLSdli6D8x867RCaPungoTZ1dcxvqk2/i
	 Z57TjWofIyF5cfj86lRcgaB0vySbBEw8ZRVWBN3ZyvgLwdM4PwjBmnZQMAWqaJYjtaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794706161;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=2iqmL6iOJMo3g565VJI0+HoAhWzhBx4D71mFA2rHpQU=;
	b=sHVlfNkL/GIkbZX96C3Qs5YD9JumzpGpqpK22sUS8xDg8VHymf+xofg4ekIneCNzlzW4
	 RttQOQB8c4hjJx9mXBcIICFAEPGLoLAdk0KuIDqWRC2ixS8hlBzYGdBgWDogU7hxuHYjS
	 bZbZRQongp5tjFL3enZWuR0UxzsPxDB7IHX1d2khPl251poVDgWshbo8dhm5wLSWViWRf
	 YA9kcOvoWDATFDZDwK4nmcT4GtF1jLHV7jYaSjjvqwBKiHrxiRkaVNRd6iKYRI5xgQ9+r
	 RKY/z07o6GVmiHBKohrbnSWH2vF8VpzuwIb+K9lMP+v+LuHF4vcpbHU08s4HlTRhlIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fTj7kHYb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D108E606A33F;
	Sun, 15 Nov 2026 01:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fTj7kHYb
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794706161;
	b=wm4l7SjYmEdyYK4iSQnhFuXsppn+UPkM89sWRJqSGBCMeweNEvTJsoXm4QLJO9zIWfSn
	 0Pjlm6R3B+mR0R6jTHLmdRbbgcALKYe+zpKXNUdmqlEkmslfizIC/juDMJ205R8lQxVIw
	 vRNtEOnlOK3OqrrtgWzcyFZHPCMu4mQfqcZ59AejYNYRqneuV9BdK+lUyK/kxshjxtF82
	 M3hcFxflJwIwGqcLG9TUdiHJt23eL5PyEVF90jPVRX+ejxJwkpN3PCGirRyvcv/s0RmlH
	 M5G9xaK1iksNKAG5ttf45k6uEdUfFZtyHepTErNU6q2PugxPPfGLHp4eMF5q0GVG+PA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794706161;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=2iqmL6iOJMo3g565VJI0+HoAhWzhBx4D71mFA2rHpQU=;
	b=kvRyc//kqodMnZPaJu5Ic+G1BcKpa03z4+jMPCCFAxhDrGZqF6LFiU7iXb0zXyiDj8vH
	 HCC8BQzxv/lLyiayW8jzVdg3aJq91uM0ur7uR0R08daGqQY22KEATC05Pa9OMekC+un6w
	 YycmbbdblNDJbmmAg2YkirmEQOVp7oIOcaDATliHXN7fRHZ/dmghUf/ZtmtVfD+jZc8qs
	 L+VC8irlvQaGkLCYrGbMP3EW+/T2i+9th+PO9Ayn8cXYfa6oHKvHB9fduzHhOEhOqUsDr
	 dN7vc3hfPHYykZagvIasBltNlyIDEGapUo20EujMJUm9cKMM5pYehmc/hCB5JstKNDw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0AD281F000C6;
	Sun, 15 Nov 2026 01:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794706161;
	bh=2iqmL6iOJMo3g565VJI0+HoAhWzhBx4D71mFA2rHpQU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=fTj7kHYbZ2k0FG6zC6fb2DcwcGsF5flCvmqS69FKgyDyB9e3Rsr0BMpoipjVLimjE
	 +0ozCaMXjEfTTDThovC84dYBSelqh/jh4pgHGqnMDuCjyAN2kx+ajq3aUCfzHXwiEr
	 69YxV6MvziR0bcgMsu7apaIFty+95X8EpvbEFvgscmC0VlhHOiCcVR6ZRh89n1LF/H
	 AkDg8HMPZycLMcGb9qz6URTzFknt563mm/pvJkPFoW6+yodjluMqfVlVaj8ydzHtSr
	 mhrPLDrErnan1ZmR4KwtdDeYMIlf14L8a73ss9A0cZq7Aean9LPMhft0zcMqX/4u8O
	 PKO819uT+G64g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8AA7E49F10;
	Sun, 15 Nov 2026 01:29:19 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Sat, 14 Nov 2026 20:29:20 -0500
Subject: [PATCH RFC net v4 2/8] net/iucv: do not clear SEND_SHUTDOWN to
 send a control frame
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
Message-Id: <20261114-b4-disp-fc0634a3-v4-2-f96c506447ce@proton.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794706158; l=4835;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=B0pcVs5Hy8pGhGv4ssAFevhx+TtT3x9fnZV79eL5Myk=;
 b=kjWnMMaH391XKhaNxRPLC+8ay25iNjrng9/kRN9eRWRQmvStNbnSxI61QVHQ2jaGzFhWNihNZ
 tJl7VnQwKDxCF41/HZEENC7Bm38xDazdmgA/10wNkrzt7hnzS9UmD/V
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=xw1AhCtQdvuoQc+bOQIYy9o8G++cp4/VniI2G/tc3G8=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/default with
 auth_id=893
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me
Content-Transfer-Encoding: 7bit

From: Bryam Vargas <hexlabsecurity@proton.me>

iucv_send_ctrl() allocates with sock_alloc_send_skb(), which fails once
SEND_SHUTDOWN is set, so it clears the bit first and writes a copy of
sk_shutdown back afterwards. recvmsg() calls it for a window update and
the NETDEV_GOING_DOWN notifier for a FIN, both without the socket lock.
On a socket that has shut down sending:

- A shutdown(SHUT_RD) done in between is undone when the copy is
  written back: the call returned 0 and the socket still receives.
- sendmsg() can find SEND_SHUTDOWN clear and send data after the SHT of
  a shutdown(SHUT_WR) that already returned.

Allocate the control frame with sock_wmalloc() behind the test of
sk_sndbuf that sock_alloc_send_skb() makes, and leave sk_shutdown alone.

Fixes: 4e0ad3221691 ("Subject: [PATCH] af_iucv: enable control sends in case of SEND_SHUTDOWN")
Cc: stable@vger.kernel.org # 6.18.x
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
New in v4. iucv_send_ctrl() clearing SEND_SHUTDOWN is what the AI
review of v3 3/7 is about ([4] in the cover letter), what the notes of
v3 2/7 and 7/7 left open, and where my copy of Hidayath's sk_shutdown
test loses its bit. v2 rewrote the function and v3 dropped that on
Alexandra's review. This is only the part about sk_shutdown; the
allocation that ignores sk_sndbuf for a FIN and the first SHT stays out
(cover letter, "Not in v4"). It goes ahead of 3/8 and 4/8: the test 3/8
adds and the wait 4/8 moves out of the socket lock both rely on the bit
staying set.

The first item, in the emulated setup: a task reads on a socket shut
down for sending, with SO_MSGLIMIT 2 so that nearly every read sends a
window update, and another calls shutdown(SHUT_RD). Over four runs of
200 cycles poll() then shows no EPOLLRDHUP in 12 to 57 cycles of a run
on net and with 1/8, and in none from this patch on.

The wake-up the AI review describes is the one for the memory wait of
4/8, and missing it takes two waits that overlap, so a test kernel on
top of the series has them: the writer sleeps 1000 ms between releasing
the socket and its wait for send memory, a window update waits 1500 ms
in iucv_send_ctrl() ahead of its allocation, and the sk_state_change()
that recvmsg() calls when its window update finds no room is taken out,
as it would wake the writer. A writer blocks with the send memory full
and SO_SNDTIMEO 8 s, shutdown(SHUT_WR) follows at 200 ms, and at 300 ms
a recv() that owes a window update. The writer returns -EPIPE after
1803 ms, when the reader lets go of the socket lock. With the clear and
the restore put back around that delay it sleeps until its timeout,
9193 ms. Without the reader the writer returns on both kernels when the
1000 ms are over.

By inspection:
- the second item of the message
- poll() on a socket shut down both ways reported no EPOLLHUP while
  the bit was clear
- sock_alloc_send_skb() also returned and cleared a pending sk_err,
  which af_iucv sets only at the end of close(), after its FIN
- SOCK_NOSPACE is no longer set; SOCKWQ_ASYNC_NOSPACE still is, for a
  socket with O_ASYNC
- I have no KCSAN build: of Hidayath's reports on net-next, the 6
  between afiucv_hs_rcv() and iucv_send_ctrl() and the 2 between
  iucv_send_ctrl() and iucv_sock_shutdown() are on these writes
---
 net/iucv/af_iucv.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index daed2a3cfd66..92468293f7c1 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -401,26 +401,25 @@ static void iucv_sever_path(struct sock *sk, int with_user_data)
 static int iucv_send_ctrl(struct sock *sk, u8 flags)
 {
 	struct iucv_sock *iucv = iucv_sk(sk);
-	int err = 0;
 	int blen;
 	struct sk_buff *skb;
-	u8 shutdown = 0;
 
 	blen = sizeof(struct af_iucv_trans_hdr) +
 	       LL_RESERVED_SPACE(iucv->hs_dev);
-	if (sk->sk_shutdown & SEND_SHUTDOWN) {
-		/* controlling flags should be sent anyway */
-		shutdown = sk->sk_shutdown;
-		sk->sk_shutdown &= RCV_SHUTDOWN;
-	}
-	skb = sock_alloc_send_skb(sk, blen, 1, &err);
-	if (skb) {
-		skb_reserve(skb, blen);
-		err = afiucv_hs_send(NULL, sk, skb, flags);
+	/* Control frames go out after a shutdown too, so this is not
+	 * sock_alloc_send_skb(), which fails on SEND_SHUTDOWN. sk_shutdown is
+	 * left alone: it is read without the socket lock, and not every
+	 * caller here holds it.
+	 */
+	if (sk_wmem_alloc_get(sk) >= READ_ONCE(sk->sk_sndbuf)) {
+		sk_set_bit(SOCKWQ_ASYNC_NOSPACE, sk);
+		return -EAGAIN;
 	}
-	if (shutdown)
-		sk->sk_shutdown = shutdown;
-	return err;
+	skb = sock_wmalloc(sk, blen, 1, sk->sk_allocation);
+	if (!skb)
+		return -ENOBUFS;
+	skb_reserve(skb, blen);
+	return afiucv_hs_send(NULL, sk, skb, flags);
 }
 
 /**

-- 
2.56.0


