Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961A31D63E4;
	Sat, 15 Aug 2026 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786808583; cv=none; b=nVoOICGDWd0vIMcZRs8dxntvwRdvhCHm39NtdIR7vThwa6K/3EOEe4p1pz8FRvTYVChxnq3YDnWVNxLek8vCtGDXsESp9afd2NhieBVnntU0wbOohHTQ0yx5LhFXZ3LVb64r5WNJHPtjGpcXiZPQTQIV2+Rk+jqNHWPdzKCJ1A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786808583; c=relaxed/simple;
	bh=BWCZ2X/1VT3PdM+LjY7UOytBkyHNl2/Fm1Z4pGlxvI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aEAezmXE8tj7iRu5RdRwO5lWuAfuMtcKOQJybVB1UfJ/eLeTwxe3ob2nSBzetymowPKUu82HAUfc5dbKg870SNkWekaHyQvInVqIKz5L+dyIL7mwYUV8Wgi6Wa7ajemIgpNuWaPyUA8W0eYehiIkzp4mvMlYHSTKiGw/jpyu7Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMK3FP5Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMK3FP5Y"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC665C19425;
	Sat, 15 Aug 2026 15:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786808583;
	bh=BWCZ2X/1VT3PdM+LjY7UOytBkyHNl2/Fm1Z4pGlxvI0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=mMK3FP5Y4vbrmCU+WnFv1p8zX+tw2lMmmOqufwYlB5L9JaB7oFK/B8zu/mq5yxJLm
	 LU6NuxHsejRBWujs6j8NzR+HQljjrZDmEmpeJRP41JzGRQ7yMY9Sf+xClys+0UfjcC
	 MAVpA4pKYutdpq4QrSMoWOpPuKiJ781222tR1qMsxUcpl+vfVge+817YDM/Yis+Whp
	 ud/rxdhZes50KHVIMMywnL1CPFMHptKFupeOumYNl+OY3kg+Vv3mCp4jDwdqbrNn6S
	 1HNkF/g36qTPCM89vColv08eLk7SV23Gsqd4RifjjLYgCikA3mI8iD6QuoaP6jCZ3k
	 0qsg5RUAtygHw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63F8C5DF67;
	Sat, 15 Aug 2026 15:43:02 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Sat, 15 Aug 2026 10:43:02 -0500
Subject: [PATCH net] net/iucv: reconcile the socket state when connect()
 severs the path
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260815-b4-disp-e1faf4b7-v1-1-2a8a143a0055@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQrCMBAFf6W8swtNaKz4K+KhyW50PcSSbUUo/
 XejHmdgZoNJVTGcuw1VXmr6LA3coUO6T+UmpNwYvvfH/uQCxYFYbSZxecpDHCkLM7swhpQ8WjZ
 Xyfr+LS8osuD6l7bGh6TlO8O+fwDkNDHQeQAAAA==
X-Change-ID: 20260815-b4-disp-e1faf4b7-feddd1575cc2
To: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Alexandra Winter <wintera@linux.ibm.com>, 
 Thorsten Winkler <twinkler@linux.ibm.com>
Cc: Hidayath Khan <hidayath@linux.ibm.com>, Simon Horman <horms@kernel.org>, 
 linux-kernel@vger.kernel.org, Ursula Braun <ursula.braun@de.ibm.com>, 
 netdev@vger.kernel.org, linux-s390@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786808581; l=2023;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=xg2T8X/93kYWUwtNOGjFli4SpGp2mm4ZLBCYx1XjSFA=;
 b=lSuE/MFy/O++A92aXw597sb0wJdNPWpSqh8l9FqDhTq89laeBcMKN1hnOeB55tTvLQH0qQ8HX
 pfvr1RVy8++Dl0IASIigHHL4T2zSBNbEvJEHvuVuQpl4zYPo5S+rT24
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=xw1AhCtQdvuoQc+bOQIYy9o8G++cp4/VniI2G/tc3G8=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/default with
 auth_id=893
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

A connack can land between iucv_sock_wait() returning an error and the
sever at the end of iucv_sock_connect(): iucv_callback_connack() writes
IUCV_CONNECTED from the iucv tasklet with no socket lock, and lock_sock()
does not exclude it. The sever clears iucv->path and leaves the state, so
connect() fails on a socket still claiming a connection it no longer has,
and a later sendmsg() reaches iucv->path->msglim through the NULL pointer
inside iucv_below_msglim(). The sever runs on every failed classic
connect, O_NONBLOCK included.

Reconcile only that case, so an ordinary failed connect still returns the
socket to its pre-connect state. The sever is a barrier against a later
connack: iucv_path_sever() clears the path from iucv_path_table[] under
the lock the tasklet holds across dispatch.

Fixes: 18becbc5479f ("af_iucv: avoid left over IUCV connections from failing connects")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 net/iucv/af_iucv.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index ea047bab65e7..6fb0041c4c98 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -778,8 +778,16 @@ static int iucv_sock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 	if (sk->sk_state == IUCV_DISCONN || sk->sk_state == IUCV_CLOSED)
 		err = -ECONNREFUSED;
 
-	if (err && iucv->transport == AF_IUCV_TRANS_IUCV)
+	if (err && iucv->transport == AF_IUCV_TRANS_IUCV) {
 		iucv_sever_path(sk, 0);
+		/* A connack may have landed while the wait was unwinding; the
+		 * path is gone, so the socket must not still claim it.
+		 */
+		if (sk->sk_state == IUCV_CONNECTED) {
+			sk->sk_state = IUCV_DISCONN;
+			sk->sk_state_change(sk);
+		}
+	}
 
 done:
 	release_sock(sk);

---
base-commit: a59f57e2aa127c5354168d2ec4bac920df1be4f4
change-id: 20260815-b4-disp-e1faf4b7-feddd1575cc2

Best regards,
--  
Bryam Vargas <hexlabsecurity@proton.me>


