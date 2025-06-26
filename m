Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCBF29CB32
	for <linux-s390@vger.kernel.org>; Thu, 26 Jun 2025 08:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750926867; cv=none; b=mM5jwicrg0HZQXsDkFXEIP9XnqHlhhheO215/uCCosgSnL2K1zupR8a8Je9Kiga5/9PlNC6avsH9HVWZIIqaReBjEPr7hqQev03lM0mWeDdoGt0kjUgHXpaEW3lRQISldte7j5etAvL+B1lYIh5LFCYhznX5FHRy2YeojGDfuRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750926867; c=relaxed/simple;
	bh=KoLoukJP9Wdf7d/xGVHRq8r0xufqBPjo9boP/ddJ+Dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P5VwR6r60Cg1xb458ep5rFAC93CQb6odujhFiuc7aYnLau8aZDp15hS8dVwnBvI9EnO2/l7liHyZ8mbrxN53oiQTdzYmbDKifBLISxnTpANZv3JV7p20IBKx/0q4bdbnu2EPhQolq3X7syAAL2clDoRPNji8pZ7wXFWnpH4gLaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=wvCkAu4u; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="wvCkAu4u"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uUi3r-00GcG3-BU; Thu, 26 Jun 2025 10:34:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=zBfuN6N3HY8iGusk+SEa2crM2b4w1ff2SIeD8NcQqzk=; b=wvCkAu4u5c2KM/Ot0YAwzlocGC
	K7lUgafppOq5IYmj1xh2jSRkkSO++kri3BpPHZXpIIMPWzX0AGwL8Xn4ACbYquP0YCNqmrMhIWpZJ
	mJ2AjhZOvVOdTPnqxOnxx2PKXwDOVy1U+yk/8cpAy25RwAHicLPlOUX1jHyKwGL0LxIAyqxv0psmd
	GqIcslFm/MsdxY/LA+DDaMwG50GYphGg8XKn95g16RMVjrB5TG4W28FxKhTejTfwTQIIwIIROnDRb
	hIIDEDKzUfS/Bb4XQJiGW2jGwDpDOzkgADyLzXXjMaN0VYXCkoAq7Dvap3h0+pnyEIOBU38vrDBHV
	yNnr1IcA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uUi3q-0002Hk-VG; Thu, 26 Jun 2025 10:34:23 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uUi3S-009Fh5-A7; Thu, 26 Jun 2025 10:33:58 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 26 Jun 2025 10:33:41 +0200
Subject: [PATCH net-next v2 8/9] net: skbuff: Drop unused @skb
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-splice-drop-unused-v2-8-3268fac1af89@rbox.co>
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

Since its introduction in commit ce098da1497c ("skbuff: Introduce
slab_build_skb()"), __slab_build_skb() never used the @skb argument. Remove
it and adapt both callers.

No functional change intended.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/core/skbuff.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b4f7843430a3f8f84aed387bf41ae761d97687ad..b5f685b6611c177c199f70bb16fd3940bce8cded 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -384,8 +384,7 @@ static inline void __finalize_skb_around(struct sk_buff *skb, void *data,
 	skb_set_kcov_handle(skb, kcov_common_handle());
 }
 
-static inline void *__slab_build_skb(struct sk_buff *skb, void *data,
-				     unsigned int *size)
+static inline void *__slab_build_skb(void *data, unsigned int *size)
 {
 	void *resized;
 
@@ -418,7 +417,7 @@ struct sk_buff *slab_build_skb(void *data)
 		return NULL;
 
 	memset(skb, 0, offsetof(struct sk_buff, tail));
-	data = __slab_build_skb(skb, data, &size);
+	data = __slab_build_skb(data, &size);
 	__finalize_skb_around(skb, data, size);
 
 	return skb;
@@ -435,7 +434,7 @@ static void __build_skb_around(struct sk_buff *skb, void *data,
 	 * using slab buffer should use slab_build_skb() instead.
 	 */
 	if (WARN_ONCE(size == 0, "Use slab_build_skb() instead"))
-		data = __slab_build_skb(skb, data, &size);
+		data = __slab_build_skb(data, &size);
 
 	__finalize_skb_around(skb, data, size);
 }

-- 
2.49.0

