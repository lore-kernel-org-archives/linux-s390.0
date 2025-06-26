Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC5A2D3EE8
	for <linux-s390@vger.kernel.org>; Thu, 26 Jun 2025 08:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750926877; cv=none; b=Mjic1SNbZ7I9slKpDO8azUzk4ZwJftv1BzTqbcOf3/ZhOdAoHSnoYmDuxOpmNqORFU3BelIAMBIPF9rtRKPzKHprSEMzuAnqyl9hBgfv+OQg18RliV6IgWuMj1dFeARkHYH6ianJ+e9cBHgDLwJw2pdUvHqJ3SAbQQUlcs0MtqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750926877; c=relaxed/simple;
	bh=7h+/r7ZtMJq1dvKCjGhVatzMhyp/ApkTbFKk+cSkUPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BytcPhm3swipV/7W1fR52bbS84aJSky1O4gyfdoK+4QzHCUS3Xs1cHWfnmdNSpSf97IwhdEl7y4CsXCUnmUEg6pyWKTj2l7t4yrfa6pVc1h+SW1FiVXIzc+WKpuw5wMSryffBAbFwJzqUHcm2tMta2Yl61zRi1YKYVAGJm2cgE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=jHRd3wtQ; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="jHRd3wtQ"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uUi42-00GFki-Hr; Thu, 26 Jun 2025 10:34:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=+2QJ2vK3aC9RmVaDqJqvoTd0vBNxxH4J4lY+mVdjibA=; b=jHRd3wtQoqHYsQcE5sg03XYmYi
	QDKRMIK/Me3iH+8BurUMVt4whIybimNQP8R/VhBHY79zK3AX4GsGP0Dgj5Gc2ds0SCdDmRG1EdDRs
	dfTLySNVofxPciNZrcLa2dIjQkkr1M1tify/2MeX8vsCW+qw4XpbWKQkfNokWWjE/0fLDUbNd9uMw
	l6heAg8atTSfANajnruOOPrn9HszxzkfYw24y52aHM0rzo479kS26fZDdNdOEEPdW6+o389sGUXeP
	jSEnr5vU1PuOxUHW5anrCl1EDKcv3YDg9VAQ5r+wHSB4ySGkjjZ066r5XTRtADnFmY4kLI68A2PBf
	/v6CFrtg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uUi42-0002Kq-6U; Thu, 26 Jun 2025 10:34:34 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uUi3T-009Fh5-9i; Thu, 26 Jun 2025 10:33:59 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 26 Jun 2025 10:33:42 +0200
Subject: [PATCH net-next v2 9/9] net: skbuff: Drop unused @skb
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-splice-drop-unused-v2-9-3268fac1af89@rbox.co>
References: <20250626-splice-drop-unused-v2-0-3268fac1af89@rbox.co>
In-Reply-To: <20250626-splice-drop-unused-v2-0-3268fac1af89@rbox.co>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 David Ahern <dsahern@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Ayush Sawal <ayush.sawal@chelsio.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, 
 "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, 
 Wen Gu <guwen@linux.alibaba.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Since its introduction in commit 6fa01ccd8830 ("skbuff: Add pskb_extract()
helper function"), pskb_carve_frag_list() never used the argument @skb.
Drop it and adapt the only caller.

No functional change intended.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/core/skbuff.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b5f685b6611c177c199f70bb16fd3940bce8cded..f8553c674fe5052e7c1ea53022e252a54a9d6c72 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6756,8 +6756,7 @@ static int pskb_carve(struct sk_buff *skb, const u32 off, gfp_t gfp);
 /* carve out the first eat bytes from skb's frag_list. May recurse into
  * pskb_carve()
  */
-static int pskb_carve_frag_list(struct sk_buff *skb,
-				struct skb_shared_info *shinfo, int eat,
+static int pskb_carve_frag_list(struct skb_shared_info *shinfo, int eat,
 				gfp_t gfp_mask)
 {
 	struct sk_buff *list = shinfo->frag_list;
@@ -6862,7 +6861,7 @@ static int pskb_carve_inside_nonlinear(struct sk_buff *skb, const u32 off,
 		skb_clone_fraglist(skb);
 
 	/* split line is in frag list */
-	if (k == 0 && pskb_carve_frag_list(skb, shinfo, off - pos, gfp_mask)) {
+	if (k == 0 && pskb_carve_frag_list(shinfo, off - pos, gfp_mask)) {
 		/* skb_frag_unref() is not needed here as shinfo->nr_frags = 0. */
 		if (skb_has_frag_list(skb))
 			kfree_skb_list(skb_shinfo(skb)->frag_list);

-- 
2.49.0

