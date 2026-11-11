Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794372269;
	b=e2fXDApc3MStFQt9/CmTSoA+95T//dvsZF8kniDPDU+nh/y5LSwkdN9Wo7bY1nzFb8Hn
	 fsJzmkNb7rYOxCq+5iULlqpEWKeE3/7FU0LUJ15+5Nwc2EDp5obnUmAbZJitZ8EA70BBX
	 otT8rVvPsmqd70g5drPRbmpXvKYyJk+a7OWltMv/UBjqnFBeUOBHoFMfTWiqxR9TVAGK2
	 ziGaqqEb3BPHS1Qgp3+YeZnsBk5iXaOBz6cAHygwpnTQpF2ZwkC+2gJzgdUwqXyaH2fXo
	 5J9Amq6+nAwpYfyj1mz+qr+/5OYR06Qw6uhbYhHfzK/2l//LpFUpnq/qXDRW8Ek8s8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794372269;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=n7Ml7fuo5YQNy3RP7RmS1mPqd8y/+2cm5W2qNSpp1bk=;
	b=ASJQDCi5eS8YCFnc3TfmafRds8lqjhMTWKhphRCF+Phrk9mm8D8jS7X+2abDs61Hn1jn
	 SllX5iUD+PU4xWv2rXwbOdUjoIGjp2KtGb3TbIEkRpM4MyFQJ1AZDgiS2eAW0a+9Y4zSa
	 qTJPCDZV9gmYL8EnYhW4Yx0eoFCx5BAzSCB3O0B4LjPaT93W1GDB1RpgMxCU24KI5hSmX
	 F3s4m8b3D4LT+72YT/dXHqSlRP3L1rh3Ra+Ju+CntIB0j/wvf4gJCW6fTZO3gkHxafNzI
	 fKhSgiHfxjHDN/WlwOUuo1SE9owvSZiLZGI2zXdpfR5JEmhhOJnfKtBe3Pl54bE1PEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QXFDFXme;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EB8606A32E;
	Wed, 11 Nov 2026 04:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QXFDFXme
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794372269;
	b=QkgffZIPVC8+LcoJyRhJ9w4qJOlhiX5UEv7doO4Kc4PUU+TS77yg2UbnFjX+zVP2ziKC
	 +h4fuyi7VHl0r9bV7J62CthZmU2hP2Qljt5cneX50gWudbphiFSDCFns+Mmn3PFT8HNW4
	 qRkqFsOtUtcst4WKtHu7VfpcWFwiYvr7+sHy2doxpyDy94dKGLQNNrl5rtW53CU+C+3DQ
	 3UZaUeKDYCS5wiltsp+M034y89ZfA8cvPYwmmKD72NtapdFNTcRtB7A3/BIxFER4KbzqY
	 X2/k7iD1KUVMTmDPHwlwOnTHqy4eToc7Ka9v0+g77uqtsr9DAq/PLPOiIcb3iNwrf7Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794372269;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=n7Ml7fuo5YQNy3RP7RmS1mPqd8y/+2cm5W2qNSpp1bk=;
	b=Qfk28FHecvskZQ6sHY7xNniacnrKreQ4ydxfL+jk78qreMKGznVVFnKmSyOKfwZ/Ccjv
	 SF0azEFCIZcD/R6NtcxsV7FU/KPFO4wP7BU8IgqbXwNWji8edF3z4mJaGRQVdcS+Ajkwp
	 3MJnH7ybn8NFMb6rxlO1jOA5zchrVkP4X/IhnqdOXC60aKRM0bESDspnGOYnfl05qmPWS
	 BHXvC07wK4oXiEc3JObNVzDerz+6uBa79ny4hKCztqVw/qIAqDHzv4B2leI+oxpPCrCty
	 fjJzTTyVwZIS58gwlqf66h3h/e0jTt3qJOdyA6ikwQ453wQZ8OAHbbQeY9je4BZ2j/A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8CBEF1F00A00;
	Wed, 11 Nov 2026 04:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794372269;
	bh=n7Ml7fuo5YQNy3RP7RmS1mPqd8y/+2cm5W2qNSpp1bk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=QXFDFXmeHmRtpwiurKu1A0Uzrwy8+V/qzdA68FRb2yGNOpuosfHOpownV1JdRfgn2
	 dCpQvxLdmKOQ7Ahht0kRqdwQ45O8XhhoSv+iuu0kQHnAKXBIYWSsQ0ZoGh2uP+QHSZ
	 fnOLBdMAj+gvKzD9kRgQk1FiuvILcdhVxZ00p68T/ZXWP0g2xDfRqLL38QwfPb22eY
	 cBKX1YreyLe6HiL+gNGMo3S5OpU2fDxHvS5w/bp4nI3WrcDTP3LqgBX0k5TZPXO0Vf
	 g6jVhecxjTPURba8UWCRxk3qUwtv4jj2sRs8cif2lW7OolQQ0FkZPQTQrKpvXwuCFT
	 BSwk5cRsPSXpQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1B36F48D8F;
	Wed, 11 Nov 2026 04:44:27 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Tue, 10 Nov 2026 23:44:27 -0500
Subject: [PATCH RFC net v3 2/7] net/iucv: fail sendmsg() with EPIPE once
 sending is shut down
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
Message-Id: <20261110-b4-disp-2a6b4364-v3-2-35677b68e697@proton.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794372266; l=3220;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=7649mWdFyPHHdznp9ibYDQHg6sWSCfctd7MGqW+sc1A=;
 b=i7P/l0LC962NTn0Fm3gYmrcALMUuHVrQ1hbwWls5Cz9PfsuKudOUOg0naDAJydSSgNCs4+9Xf
 tyUMcD6oLtYC6DNDxv+166xH2+WbC2mFjaeFEd/enIv2kAOscxzhikq
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=xw1AhCtQdvuoQc+bOQIYy9o8G++cp4/VniI2G/tc3G8=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/default with
 auth_id=893
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me
Content-Transfer-Encoding: 7bit

From: Bryam Vargas <hexlabsecurity@proton.me>

sendmsg() tests SEND_SHUTDOWN on entry only, then waits for the peer's
window without the socket lock. When sending is shut down during that
wait, by shutdown(SHUT_WR) in another thread or by the peer's quiesce
over z/VM, the wait does not end and the call does not fail: the writer
waits out SO_SNDTIMEO, or, when the window opens first, sends its
record after the socket's SHT and the peer reads data after EOF. With
the peer's FIN in as well it returns -ECONNRESET for a stream its own
socket shut down.

End the wait when sending is shut down and test SEND_SHUTDOWN again
after it, ahead of the sk_state test, so the call fails with -EPIPE as
it does on entry.

Fixes: 0ea920d211e0 ("af_iucv: Return -EAGAIN if iucv msg limit is exceeded")
Cc: stable@vger.kernel.org # 6.18.x
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
New in v3 as a patch of its own: the new condition of sendmsg()'s
window wait and the test after it, placed ahead of the state test, were
in the lock patch. It goes before 3/7, which lets sendmsg() wait for
send memory without the socket lock and would otherwise open the same
gap a second time.

Three of the 53 default tests are about this, and net fails all three.
A writer parked on a full window sends its record after the socket's
own SHT when the window opens, so the peer reads data after EOF; it
waits out SO_SNDTIMEO when the window stays shut; and with the peer's
FIN in as well it gets -ECONNRESET. With this patch the first and the
third pass and the second returns -EPIPE; that test still fails, as its
SHT finds no room in sk_sndbuf (one of the five in the cover letter).
With only the wait changed the writer sends after the shutdown in the
first two and gets -ECONNRESET in the third; with only the test after
it, it waits out SO_SNDTIMEO again; with the test placed after the
state test it gets -ECONNRESET again.

Not changed: iucv_send_ctrl() still clears SEND_SHUTDOWN while it
allocates a control frame, so a caller without the socket lock can make
the new test miss a shutdown. On a connected socket there are two:
recvmsg()'s window update, until 3/7 puts recvmsg() under the lock, and
the NETDEV_GOING_DOWN notifier, which sets IUCV_DISCONN right after, so
the call then fails with -ECONNRESET.
---
 net/iucv/af_iucv.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 657c61161dbd..133c1d1886b2 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -1055,10 +1055,16 @@ static int iucv_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	/* wait if outstanding messages for iucv path has reached */
 	timeo = sock_sndtimeo(sk, noblock);
-	err = iucv_sock_wait(sk, iucv_below_msglim(sk), timeo);
+	err = iucv_sock_wait(sk, iucv_below_msglim(sk) ||
+			     (sk->sk_shutdown & SEND_SHUTDOWN), timeo);
 	if (err)
 		goto fail;
 
+	/* return -EPIPE if sending has been shut down meanwhile */
+	if (sk->sk_shutdown & SEND_SHUTDOWN) {
+		err = -EPIPE;
+		goto fail;
+	}
 	/* return -ECONNRESET if the socket is no longer connected */
 	if (sk->sk_state != IUCV_CONNECTED) {
 		err = -ECONNRESET;

-- 
2.56.0


