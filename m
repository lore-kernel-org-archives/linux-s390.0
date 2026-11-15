Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794706161;
	b=Dh63Mrh9DV7SQRBKPUEiUAw9/LZYjBJzmxkepoPS4ketm5BG3p0xSwj6Rh57V1//VI5X
	 a6aqlWUcZiyHjpTGA4BCWncr//+s4MycQh01g7DNpRH33SjUXA+vPZku2JwbdcGqGxJbD
	 0gAWN1ygPRvoJkaC/52KiqLsov8+p9di2xrOQEUnJ1E3A1dAudiMinVQeaUImSCDYoMio
	 ok/B1Ly/dDbvOfl2MJy5VMGyHAhgkuJvfd/Gz7oAquCQOn7p5twjU8HUtxmF4NhZ8tAYs
	 IkyGX+Fh/Fa/NqARNFWN6y9NmzyD0pBn9bzesKr/BK4F2K0K/UxWCf6qs4ezgzaGgtw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794706161;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GXiewsrwXHEqHKssXIWsZxjImmzf+wuY5sA2h0Y2vrg=;
	b=xE7Q3dSh5gf9+2tPCbVBlTWdFYIo4GUIUjNBsoiNZXi+ORGFHmDcgGKKIGvsEBYsZ2wu
	 ypO5z3TrTf6i7BqwnVDG7rVObBv6NipviS0fVuDJ+DOTPogxUTYle4VkToQPJXslq8Rwn
	 Whctp+ILuuhF/tLxR0wN+yjTxBYv+oFjzzRMa2g9dCfq6mKWGg38Wg6XvHNW1GuQ73wfm
	 QMKtydYWoiFAs9iiG7zEVrUtSYkgZ0gtYp42EhJIJ+ONikV4mmaUKvIhGiEdqLpRG7ijd
	 iz5tBI6LAParWIXNJOngimP2aoA96eeADQ0szjgh8B++Bf/LVcLIsLSI/RAYYoWFgcQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DS9xspk2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D9E606A331;
	Sun, 15 Nov 2026 01:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DS9xspk2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794706161;
	b=bv5BGXzZwAC/z7eYvGsvmxjxTf+lljcmWYRL5lIeXEpZpj8KjEPaIFZEEpipfjUt/Y/C
	 ImNMmoI6b+XPehj19BOY31TnpBuc0DCCEimIPhCxiHE8UWJqiGewAs+EMH7E5Zogwzio4
	 SiAWWgqPhClaOVzupgQNHhRsySNwtklARNfU8m6lg1CgFMe2CfPwXUOt/T67VnqNvdgXB
	 v33PpBLHtniJXsVqVwHAl2CKBf8NQpTGBXys0+MiycDehIi9M4XYBXVXAiI/3DsYN2ipo
	 469tN7T+BX6+m2FW8kvgUCoaEouLAFX7kkHKf+6lVfXo7yFyVAwOCNbTwAdySfoN0lA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794706161;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GXiewsrwXHEqHKssXIWsZxjImmzf+wuY5sA2h0Y2vrg=;
	b=3gvkYnvGC30a0YsCxGp4myUkNU8yITd2ZtvQNjCrGjtihnlX34uzKSq/bKcp5//nl1Px
	 RoNyhi/XIyNIyqjcmzHtOcQ1IyDvT70ngjLGLVuQ2fKbKp9vrlHg9KgcbY8n49vCOkQ1N
	 420gg390dxMWV9t6oHapuNjonJqZ0RyShDsQINQFaguhJvSQGBRCCWCmJSO8ErVDfKRPX
	 9lpg4WdapjtG8uBrfJuPSPD/MPIrnrIu+Nzgaq5iJqPYRZOWzmDM7dEnFsKFUg8rvYocs
	 i+tjGSyhipRNFYS2gBWgOxCHSh7iYfZPUmtVbCC1PbIQr44HvgEvjpEjdB8SZ1cqFbw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2323B1F000C7;
	Sun, 15 Nov 2026 01:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794706161;
	bh=GXiewsrwXHEqHKssXIWsZxjImmzf+wuY5sA2h0Y2vrg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=DS9xspk2dOVPAhF4Jd3p2Ehb92d50liU8RGXYIej1fOtA8fprUhqXhoVna9lwGXeQ
	 3cc8eGGjQOUrzDm4WCn9ZjLddJbRdsBdB+hNikTl2+iRWsE63A1i4S0RKhXsOZrh5o
	 k6pn43UTVXGIvyLXt/KBLXmHFNzV5XLOV799fgS00Tpmul5R56cwwy36yAyio8pF57
	 LIypbM5/ojB9pkQoOlu3C74Vm1/te/2dh0ccWfr8jpIZ5lF1/6dDD6LOVoZxfGpdFH
	 dBHluxj34i3iC7DmxuGr0Ipxi0kz6CGHhPw2aKbIu5uoBzcrFLtn5piYWvOXH1Kpb6
	 Zoe9EGabJiv4Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A09D549F14;
	Sun, 15 Nov 2026 01:29:19 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Sat, 14 Nov 2026 20:29:21 -0500
Subject: [PATCH RFC net v4 3/8] net/iucv: fail sendmsg() with EPIPE once
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
Message-Id: <20261114-b4-disp-fc0634a3-v4-3-f96c506447ce@proton.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794706158; l=2927;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=eFvlFTHXbJiOGhWbQc9xS9npNxJ3DnULBhzpHra8NGk=;
 b=v5RrJ95tu0iMgAiQdDzS8ILt9W4ALLhsEUMf6zgJtzfucF5BK117j9CqQYKSZnAUbCiipzlc2
 kgE6rQbjSjsBeLuax13T0PzR6XkMtIf4YuXhw6+ySSmldN8aXMmP0nt
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
v4: unchanged, was 2/7. What v3's note left open here, a caller of
iucv_send_ctrl() without the socket lock hiding SEND_SHUTDOWN from the
new test, is closed by 2/8.
v3: https://lore.kernel.org/netdev/20261110-b4-disp-2a6b4364-v3-2-35677b68e697@proton.me/

It goes before 4/8, which lets sendmsg() wait for send memory without
the socket lock and would otherwise open the same gap a second time.

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
---
 net/iucv/af_iucv.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 92468293f7c1..d2d47f33d08b 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -1064,10 +1064,16 @@ static int iucv_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 
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


