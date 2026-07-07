Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACE421CC44;
	Tue,  7 Jul 2026 07:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783407655; cv=none; b=LoAIx8I0FggaomR9lhaKf7TbK5uMN/JGfo8E5EbepNHO/Kl510Cb39MkXMYtcmDLKizGhkCT5KVW5N9BzKnfOQtMdnWwkjz9FRNd+NYmJkaIGZ/4uU0pDlIDLaiH68ryK2tS7drHToicuSTs2zyVf+5U/HNN+aMcxyhlhbJh5Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783407655; c=relaxed/simple;
	bh=TwbKP6+4zJvrHidj2Q8b4AKuEITUZKIamAjzqzXlhTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mDa+FlZotY3+ExKGmA7EOH/qa+peO0FLFGSajogoF9EmnJwtL1PXJ831a+SJ1Y8FzNrNUeQAKNvL4RG4Fe9y2wgOjoB6Q+np5WsXLzlteJFh8h9NLuI0x1BiDstRoQ2Pu3egJWdC1M3ZBwL7MDfbe9pa00CxHcSTXXeKTQHyf84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOiK2d4X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOiK2d4X"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5C75C2BCC9;
	Tue,  7 Jul 2026 07:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783407655;
	bh=TwbKP6+4zJvrHidj2Q8b4AKuEITUZKIamAjzqzXlhTo=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=qOiK2d4X3wcblAral/hysyKmFq3G0Me5KJA7WpW+cOuv54XnwApo/pQbplCYNl+5e
	 IwKMXjbPPW9XHcghhfbwwL7nFSNzhxyq0hfOXLiTcVW/XrTINd2Q+zQfnZvwrMUlnK
	 572Cudc7x2BJt9FaNVNlofcl5LbdrFCZ2mlpfXnfrWC3cj/i/1X1/HrSUdfeWXqUaG
	 4KE/C8isdhf+7thU8fZuVhR1K+tPsRwVSsQFWhzwb8dBpBVJl6rBd0m1Z+yyyfPcAM
	 yyi9kK5WiAu4EnTnnuUcJxzsGJgU44EBAh8dBRN80sCM9lgEMjEWfQvp16YRH48558
	 fjQc+oCzrLFMw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA9CC43458;
	Tue,  7 Jul 2026 07:00:54 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Tue, 07 Jul 2026 02:00:54 -0500
Subject: [PATCH net] net/iucv: fix use-after-free of a severed iucv_path
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-b4-disp-783fedbb-v1-1-463b9dbda2ea@proton.me>
X-B4-Tracking: v=1; b=H4sIACWkTGoC/x3MQQqAIBBA0avErBtQi6yuEi0anWo2JhoRRHdPW
 r7F/w9kTsIZxuqBxJdkOUKBritw+xI2RvHFYJTplFUWqUUvOaLtm5U9ETYDOU00+JYVlCwmXuX
 +lxMEPmF+3w/87wdmZwAAAA==
To: Paolo Abeni <pabeni@redhat.com>, 
 Thorsten Winkler <twinkler@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>, 
 Alexandra Winter <wintera@linux.ibm.com>, 
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
Cc: linux-s390@vger.kernel.org, Hidayath Khan <hidayath@linux.ibm.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Nagamani PV <nagamani@linux.ibm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783407653; l=2242;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=Vg8TCtIHTe8jw/nj6SI6vm1zcOrZY1kYN/Xv5b4uIJY=;
 b=yuG+VdpMhHEuqT4wu4JLiu4hiog3H9ZC0+OO7RR9aCidpeppZoRPBOOz3nDloMMxQ0y5X1gxy
 1nTouPPOxmWASwYR7y+IBROMpz4tx/Vwk2AjlWs3r/tXOFmGIj81LYg
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

af_iucv queues not-yet-received message notifications on iucv->message_q,
each holding a raw pointer to the connection's iucv_path.  When the peer
severs the connection, iucv_sever_path() frees that path with
iucv_path_free() but leaves the notifications queued.  A later recvmsg()
drains message_q via iucv_process_message_q() and hands the stale path to
message_receive() -- a use-after-free of the freed iucv_path.

Drop the queued notifications when the path is severed; once the path is
gone they can no longer be received.  This also frees the notifications
leaked when a socket is closed with messages still queued.

Fixes: f0703c80e515 ("[AF_IUCV]: postpone receival of iucv-packets")
Closes: https://sashiko.dev/#/patchset/20260705-b4-disp-fc79c0dc-v1-1-d2cdcb57afa9@proton.me?part=1
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 net/iucv/af_iucv.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index fed240b453bd..2869a103f7fa 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -337,6 +337,7 @@ static void iucv_sever_path(struct sock *sk, int with_user_data)
 	unsigned char user_data[16];
 	struct iucv_sock *iucv = iucv_sk(sk);
 	struct iucv_path *path = iucv->path;
+	struct sock_msg_q *p, *n;
 
 	/* Whoever resets the path pointer, must sever and free it. */
 	if (xchg(&iucv->path, NULL)) {
@@ -348,6 +349,19 @@ static void iucv_sever_path(struct sock *sk, int with_user_data)
 		} else
 			pr_iucv->path_sever(path, NULL);
 		iucv_path_free(path);
+
+		/*
+		 * Message notifications queued on message_q still reference
+		 * the now freed path; drop them, otherwise a later recvmsg()
+		 * would pass the freed iucv_path to message_receive() via
+		 * iucv_process_message_q().
+		 */
+		spin_lock_bh(&iucv->message_q.lock);
+		list_for_each_entry_safe(p, n, &iucv->message_q.list, list) {
+			list_del(&p->list);
+			kfree(p);
+		}
+		spin_unlock_bh(&iucv->message_q.lock);
 	}
 }
 

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260707-b4-disp-783fedbb-39bc1bb9d4e0

Best regards,
-- 
Bryam Vargas <hexlabsecurity@proton.me>


