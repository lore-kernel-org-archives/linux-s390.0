Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16CC377A97;
	Sat, 15 Aug 2026 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786810046; cv=none; b=NhCp0Xm5ha3+3CR5yHNbLf5Mjv2IATzcEC55YD1Cq5MKWbo8qC+pmxMzkAb1Bx7P8zbt6OXYgpMZVuhr6TisTuuTvwIYLppP+TQcNcag+mlv0h8wbzBO5b8fICbm9WFgOmNYlfBgxumGeKSWcpbVIbIAbpzI2iqoi9e1Qd6E7bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786810046; c=relaxed/simple;
	bh=jtwkUIn8ceH+vA96g0u8zEJUX4AKgWeX/6MS4v8zx/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Io7e4vUmNJzUmen6/SdhfjRsXZq7U3s+OgNb91NqxGf2rfIvR3aRGfpMfO2JvL11n/tSo9Ej/EvbHKis6ln0hRdyjAS2KvTJfZUOhHH6VbUqfYVAScHJAy1+F5OFq9ZHyttkyst0v5KdPCXYwLmCTvRkZV0NElIbYkWr23RsY+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUfFZFZy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUfFZFZy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D6F2C2BCC7;
	Sat, 15 Aug 2026 16:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786810046;
	bh=jtwkUIn8ceH+vA96g0u8zEJUX4AKgWeX/6MS4v8zx/g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZUfFZFZyTIWUTh+iYqkKytgIF59u09JpT70SZwasFqB+wQ9ofEfslffLJm8QCt6in
	 OO3ytHwzjk8k/WOsKrkZ8sF7rFNzZ95H1em6MOPOostcbSvQhuOUZ4yYvPho73jemo
	 W0uRtrORpng+vH/z9mVVsO4EWoyD9QCFNqOQ+8cBFTzmtEbLSJr9qZwZV7D07iH4/d
	 P0LigqVIcPzzL26ITcZp0yLrUIzKXmxHmF6OMhHOF4bYeM8yagUolUWqb+PPTR7/lj
	 c6gYNCjvpPMxsn+r4vILqLTJyGKLELcHJBIb7oCQUdxS+tn05FbG8SyJHKPZBUbvDy
	 CcvGBFGemySjw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F4CC5AD5A;
	Sat, 15 Aug 2026 16:07:26 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Sat, 15 Aug 2026 11:07:27 -0500
Subject: [PATCH net 2/2] net/iucv: take a private, writable frame before
 rewriting it in place
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260815-b4-disp-dc82fde4-v1-2-e83b10b22ce9@proton.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786810045; l=1834;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=tsDMGsCItYL7yGu9iox8Y2HomWMGmH4vOL9gyPjm2GY=;
 b=iPwsieAZOfqGqomsQKlBiFLG94t+SwU+dzIZVVfjU8mETwPrjWD9heRwtLzT+FM1Z7vqmL5RQ
 t3ZDazceEsKBPkWggR439tMlOz3W5VUDXwxD3JFrhGFvrOq2H1l8Vky
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=xw1AhCtQdvuoQc+bOQIYy9o8G++cp4/VniI2G/tc3G8=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/default with
 auth_id=893
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

afiucv_hs_rcv() rewrites the frame in place -- EBCASC() converts four name
fields in the transport header, afiucv_swap_src_dest() swaps them and
pushes an Ethernet header back on -- without taking a private, writable
copy. It sits on the global ptype_base[], so a packet socket (tcpdump is
enough) has packet_rcv() clone every frame first, and net/core/dev.c has
warned since 1998 that such a handler "is not able to sense, that packet
is cloned and should be copied-on-write".

Unshare, then cow the head, in that order: skb_cow_head() can reach
pskb_expand_head(), which has BUG_ON(skb_shared()). Asking for ETH_HLEN
also covers the unchecked push in afiucv_swap_src_dest() --
eth_type_trans() has already pulled that much on the ordinary path, so the
call compares and returns.

Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
Closes: https://sashiko.dev/#/patchset/20260813-b4-disp-60433a46-v1-1-509e1200533e@proton.me?part=1
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 net/iucv/af_iucv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index e3ec965d96ca..10cfc5e82f04 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -2069,11 +2069,20 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struct net_device *dev,
 		return NET_RX_SUCCESS;
 	}
 
+	skb = skb_share_check(skb, GFP_ATOMIC);
+	if (!skb)
+		return NET_RX_SUCCESS;
+
 	if (!pskb_may_pull(skb, sizeof(*trans_hdr))) {
 		kfree_skb(skb);
 		return NET_RX_SUCCESS;
 	}
 
+	if (skb_cow_head(skb, ETH_HLEN)) {
+		kfree_skb(skb);
+		return NET_RX_SUCCESS;
+	}
+
 	trans_hdr = iucv_trans_hdr(skb);
 	EBCASC(trans_hdr->destAppName, sizeof(trans_hdr->destAppName));
 	EBCASC(trans_hdr->destUserID, sizeof(trans_hdr->destUserID));

-- 
2.55.0


