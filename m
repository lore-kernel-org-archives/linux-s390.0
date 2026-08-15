Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFB1314A83;
	Sat, 15 Aug 2026 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786809886; cv=none; b=O+z6Ws9MzE5T62YsjR4lfo8jFUJdh7P5F9rH0Ry2mVg1EfTOZONuzrUyrcDfhdzQkR1UVxNmqKLhHCIWElKoB+3ZXM/Kx1Zq92x7Lbj9jvaQwHWsJxT7tdjJOp+PLsfP5qNktzVbYejBqOg4Mpc/xFbFoLW6LBtbLw6pMzVdmsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786809886; c=relaxed/simple;
	bh=DqnT8yFaOelu2ToDTUnhBtzASwZswokNdLgoGEj/vqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jzxDpsacd0yxXq/7kOPs3u8/rmx52EXte8VBVNbs3+pNOVSix4ZG9EVsaEqwiSz0KpVEKpSB8tFRv+C5xwyCWk0KOo0kxvXstC1Zte1g6hND78sqp1oMRvxYvmb9Hru6VOW2T9Em8GsQ2HxNEyGchAeBwTewsulMKQy7XxzIt5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEU9x2Uo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEU9x2Uo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFD70C2BCC7;
	Sat, 15 Aug 2026 16:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786809885;
	bh=DqnT8yFaOelu2ToDTUnhBtzASwZswokNdLgoGEj/vqw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZEU9x2UoOXldEMjY3CX3zg2V6+F+db3aoGIpsIlzZSyLKXW+tIc6J6n1ZFikMkLAh
	 owcSwU+h4Jf80gHwo1wFh/GMEn13mcYriHZQXH5quzbyUVgKS0hpWqNebIuMH1rN7b
	 PHi3byBvaXFL1vfZ9v3qrP3d4Rau9dxsK8UUKfgDQY6+1G7MLYoKVI08xPjF6ybXxU
	 ZD1FeUeZCQF7sYSY52nUnkdHAdBHW9n9ssMJk8UwZmMzpU+5/dr4NGJdKzzZp1oiEq
	 5tDO+6ikrSXmzzUbYGZ5sEQ6/IO8/tCfQlrR/v/zDUZPVwyE3gAwKx6xjSoOws1NSO
	 t4hSwJF0r9ptQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE07C5DF6A;
	Sat, 15 Aug 2026 16:04:45 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Sat, 15 Aug 2026 11:04:45 -0500
Subject: [PATCH net 1/2] net/iucv: only send the window update on
 HiperSockets sockets
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260815-b4-disp-8a791503-v1-1-fbae9a511144@proton.me>
References: <20260815-b4-disp-8a791503-v1-0-fbae9a511144@proton.me>
In-Reply-To: <20260815-b4-disp-8a791503-v1-0-fbae9a511144@proton.me>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
 Thorsten Winkler <twinkler@linux.ibm.com>, 
 Alexandra Winter <wintera@linux.ibm.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Ursula Braun <ursula.braun@de.ibm.com>, 
 linux-s390@vger.kernel.org, Hidayath Khan <hidayath@linux.ibm.com>, 
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786809884; l=1687;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=WnxZgTaOhpPitiiiLaLvwFQWVkmqD2AinGJexdA9fUA=;
 b=VfcjCeTe0PnK0zFvAdcxQaHl1YwL3Uz0N1TOdAxv+IXmfOkO+FtPu0L+C+ZT0589Af1aNDq0g
 YdMd98ZoQrhCAdqOZJP+VbbQ+9cP4oVdJP0/bcogNK2uUJp09CwiV0E
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=xw1AhCtQdvuoQc+bOQIYy9o8G++cp4/VniI2G/tc3G8=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/default with
 auth_id=893
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

iucv_sock_recvmsg() sends AF_IUCV_FLAG_WIN without testing the transport,
but that flag exists only on HiperSockets. On a classic z/VM socket
iucv->hs_dev is NULL and iucv_send_ctrl() sizes the skb from
LL_RESERVED_SPACE(iucv->hs_dev), so the read goes through NULL;
afiucv_hs_send() then returns -ENODEV and recvmsg() moves the socket to
IUCV_DISCONN. Reaching it takes an application that sets SO_MSGLIMIT to 1
on its own socket, since msg_recv is incremented only on the HiperSockets
path, so this is a correctness fix rather than a security one.

Test the transport. Three of the other four iucv_send_ctrl() callers do;
the fourth, afiucv_netdev_event(), selects on hs_dev instead. Without
relocate_lowcore the NULL read lands in mapped lowcore and the symptom is
the spurious disconnect; with lowcore relocation it faults.

Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 net/iucv/af_iucv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index ea047bab65e7..0bc4a15f4b56 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -1331,7 +1331,8 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 		if (skb_queue_empty(&iucv->backlog_skb_q)) {
 			if (!list_empty(&iucv->message_q.list))
 				iucv_process_message_q(sk);
-			if (atomic_read(&iucv->msg_recv) >=
+			if (iucv->transport == AF_IUCV_TRANS_HIPER &&
+			    atomic_read(&iucv->msg_recv) >=
 							iucv->msglimit / 2) {
 				err = iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN);
 				if (err) {

-- 
2.55.0


