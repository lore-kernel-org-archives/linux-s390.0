Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E6142640A;
	Sat, 15 Aug 2026 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786810046; cv=none; b=sQeo7koTV498Elf5v94AxHwflGZ4lheHh9Mxk5/9s/eqwscgdudfxOJFCZmPp3ZL+OjOTvZa5D0VienU+ySxVtW3/Jzeea6C0qDrWI4E6w+8YG7azmTf/FTWWNH7a8B9fDyh131hX6Dqfdqz1Ug4mnKu2zsd2S46U1Po1sU5CYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786810046; c=relaxed/simple;
	bh=Dsgxdv5jxR7WDeUi5Yh8uc2gmE3EicLMknakZyC1rXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JcdD2i+Ht4DgC9Wl1mlgbZ7oONUAVCAO/e0kBA6yxIUep9767dyhXH3ryxD9hN73s7xbKvSlmh84B9UGTUqjmxTbN0GfPHh//u0ewhJwTlqLryvvHgK5RqUmi+OMT2+Z5joq0gaM4ZLQeTx5MbTV4jPbs07WuK6LocXhjpfBuUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxfnWDx/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxfnWDx/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E974C2BCF6;
	Sat, 15 Aug 2026 16:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786810046;
	bh=Dsgxdv5jxR7WDeUi5Yh8uc2gmE3EicLMknakZyC1rXk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JxfnWDx/Vj89p+CVfZ3IH+XxcjueQW7UPTN9EkSuapVymlVxJpeqskHCmkIuQd4JQ
	 SVej1hg5kUL/yAjBQN+pukVjqOQ9NDILm20RKr9KmYN9kF7Xi0b88TObydTZJ31AxJ
	 E/m455W8ICO1GYwRJBp/U0P/gN9o8fCJn+PuySwt1xvgOKvR5we0k33qU35DfmyBmp
	 tHgA8C8QEgl683VQi2GDCPM452fRca7aOhfZ5OBmQC7Jkqv/3vCmAhqAU45AF2mvRy
	 YZeLp/USrNcK2hfWPmQZB6VEmnCFJJy0YXdp/AFu1oDQDX8rMaLElLVLy+gfKkU1l3
	 Dz12OXw4NxSWA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EADAC5CFDB;
	Sat, 15 Aug 2026 16:07:26 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Sat, 15 Aug 2026 11:07:26 -0500
Subject: [PATCH net 1/2] net/iucv: drop HiperSockets frames from other
 network namespaces
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260815-b4-disp-dc82fde4-v1-1-e83b10b22ce9@proton.me>
References: <20260815-b4-disp-dc82fde4-v1-0-e83b10b22ce9@proton.me>
In-Reply-To: <20260815-b4-disp-dc82fde4-v1-0-e83b10b22ce9@proton.me>
To: Thorsten Winkler <twinkler@linux.ibm.com>, 
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Alexandra Winter <wintera@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ursula Braun <ursula.braun@de.ibm.com>, Simon Horman <horms@kernel.org>, 
 Hidayath Khan <hidayath@linux.ibm.com>, linux-s390@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786810045; l=1465;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=+i2AgKp/ZjTfUK6HdWlXZJX/pS4StiSoANqdxYojTkk=;
 b=BuLoDOmzIn0S4VKpqh1WYiwaOJBHGdNtDPQP/gu4GIp9H49XsOt+f10dJKKrFgGCf5kHRpLA/
 lJ/mgMrpQfoDE3pBCTdkJivzh3qswm4AkJqMjxmqdrXp4gjJv0hO+yg
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=xw1AhCtQdvuoQc+bOQIYy9o8G++cp4/VniI2G/tc3G8=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/default with
 auth_id=893
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

iucv_packet_type sets neither .dev nor .af_packet_net, so it lands in the
machine-global ptype_base[] that __netif_receive_skb_core walks for every
frame in every namespace, and afiucv_hs_rcv() ignores its dev argument.
An ETH_P_AF_IUCV frame sent from any namespace holding CAP_NET_RAW is
therefore matched against the global iucv_sk_list and can move a socket
owned by the initial namespace: afiucv_hs_callback_synfin() and _fin()
overwrite its sk_state, and _syn() builds an accept-queue child.

Filter on the namespace. The core does not do it for ptype_base[] --
net/core/dev.c leaves namespace filtering to the ptype owner -- and
net/x25/x25_dev.c and net/ieee802154/socket.c both test dev_net(dev) at
exactly this point.

Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 net/iucv/af_iucv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index ea047bab65e7..e3ec965d96ca 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -2064,6 +2064,11 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struct net_device *dev,
 	int err = NET_RX_SUCCESS;
 	char nullstring[8];
 
+	if (!net_eq(dev_net(dev), &init_net)) {
+		kfree_skb(skb);
+		return NET_RX_SUCCESS;
+	}
+
 	if (!pskb_may_pull(skb, sizeof(*trans_hdr))) {
 		kfree_skb(skb);
 		return NET_RX_SUCCESS;

-- 
2.55.0


