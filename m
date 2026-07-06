Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3255313A86C;
	Mon,  6 Jul 2026 03:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783308277; cv=none; b=I5eYrmwLrf4bTXnsNJZzwb+ZsHkJXqYUAmKBKpbS28JH2QB6rHh/WZqGvjxV8XRFU0nM6YfRArxHb2b05k9qOxCODBtCMg+pSKrxiNSUxv6KXQQDqGYvCEYi6rGce3OJ01GVo8rk9+cDAoZwnbP44KBjCYR7dVQNUQiAdXtNL+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783308277; c=relaxed/simple;
	bh=CnrCS3xzqkXWJNspjGxukIUTKd7Qt32YPSS9xjBQme8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AA92mLUBmknh7XCnfCrd+LO+UcNcZulnl7LDbHqMP6klqHba00EG0RY2wgcHobBgMLKOBGOBY5OdqfiYFlg4HJBKcgKsRRUDeoiEqbErkXkriNk1J4yGJkDBpLQx7+9mEUYjq/0sUHH0waPvJnDF8zOLdCHXx4GRyRuHQvwbkIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAwEY9ZS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAwEY9ZS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A554AC2BCB8;
	Mon,  6 Jul 2026 03:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783308276;
	bh=CnrCS3xzqkXWJNspjGxukIUTKd7Qt32YPSS9xjBQme8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=dAwEY9ZSj0BU1mKEB0mr0K9Xp7HbFNMntWyZUgqH8W/75wGLJLtDVEKxId/DlhVVQ
	 zWpm7ujKOEhritQyAtRhosQ4rIvzWcZSi44akXByFM8koPBJ5T/JOXn3tha043Khhz
	 Kvoh8eJK5sLP8BCJV/wRidwUjUUIrBy46KYWdgaQ7KaK8rLH294tq/4wRsO6lKK0f+
	 3iBpsKmZvzpZGp5w93cPA/q33ITr9C1ElDINpOztgSJEUxVJwAblGOWSnvf2R8TkUG
	 +PzX2mKgIrGWBOIi8aNNFpqS0vlvHM8vt+bBNm2E+Za1cIT58lU5O41VW3wDP6d5jF
	 5F7Ud1Byoiviw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEB2C43458;
	Mon,  6 Jul 2026 03:24:36 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Sun, 05 Jul 2026 22:24:36 -0500
Subject: [PATCH net] net/iucv: take a reference on the socket found in
 afiucv_hs_rcv()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-b4-disp-fc79c0dc-v1-1-d2cdcb57afa9@proton.me>
X-B4-Tracking: v=1; b=H4sIAPMfS2oC/x2MQQqAIBAAvxJ7bmETU+or0aF0q72YaEQQ/j3pO
 AwzL2ROwhnG5oXEt2Q5Q4WubcAdS9gZxVcGRcqQpR5XjV5yxM3ZwZF3SN1gbLVKWwU1i4k3ef7
 lBIEvmEv5ACdZ+3BnAAAA
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
 Thorsten Winkler <twinkler@linux.ibm.com>, 
 Alexandra Winter <wintera@linux.ibm.com>
Cc: Nagamani PV <nagamani@linux.ibm.com>, Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-s390@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783308275; l=2220;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=Cm/xe4O+TSWFJ/AEyzNeIJNe6xtikMnB2Bp/3kQXcy8=;
 b=cSkRDDBTHSAhSaz7Obcwozgj1qGGIduMb5BUznx+g+g91Yx+di+G1GLBvekSxC8S3yqinvfIh
 R3LnALR+STgBQEuDArfqcCgWfpMzF815NlfzcTeMRGxG7cOrqqdfbNN
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

afiucv_hs_rcv() looks up the destination socket under iucv_sk_list.lock,
drops the lock, and then passes the socket to the afiucv_hs_callback_*()
handlers without holding a reference. AF_IUCV sockets are not
RCU-protected and are freed synchronously by iucv_sock_kill() ->
sock_put(), so a concurrent close can free the socket in the window
between read_unlock() and the handler, which then dereferences freed
memory (for example sk->sk_data_ready() in afiucv_hs_callback_syn()).

Take a reference with sock_hold() while the socket is still on the list
and release it with sock_put() once the handler has run.

Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
afiucv_netdev_event() has the same iucv_sk_list use-after-free and is
being fixed separately by Nagamani PV:
  https://lore.kernel.org/all/20260508170534.2208812-1-nagamani@linux.ibm.com/
This patch covers the receive path, afiucv_hs_rcv(), which that fix does
not touch.

Verified with an LKMM/herd7 litmus (the missing sock_hold() is the only
delta between a flagged data race and none) and with an in-kernel KASAN
model that reproduces the afiucv_hs_rcv() lookup-without-hold path (the
freed socket's sk_data_ready pointer is read after the callback runs);
adding the reference clears it. af_iucv is s390-only, so this is the
model rather than the driver. Reproducer available on request.
---
 net/iucv/af_iucv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index fed240b453bd..b85fb9767dec 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -2089,6 +2089,8 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struct net_device *dev,
 			}
 		}
 	}
+	if (sk)
+		sock_hold(sk);
 	read_unlock(&iucv_sk_list.lock);
 	if (!iucv)
 		sk = NULL;
@@ -2138,6 +2140,8 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struct net_device *dev,
 		kfree_skb(skb);
 	}
 
+	if (sk)
+		sock_put(sk);
 	return err;
 }
 

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260705-b4-disp-fc79c0dc-019670262472

Best regards,
-- 
Bryam Vargas <hexlabsecurity@proton.me>


