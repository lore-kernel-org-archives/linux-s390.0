Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6942C53E18;
	Tue,  7 May 2024 12:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715086426; cv=none; b=MIw909k2SaAO0d0YhsloVwMOUnn6vYc6OC+NyiBd/CFDojhQ4mNKuZN/Q/atqEMX8VziV5LIQLOW8DmV3udRkLK+qQlq8S5YQ65WzgPVyQn0ptccZm6APbxBRATiezwfo5JDXENQkCiYQ9ew4uAyTI8BmgTqFtnezxVUYI/iLNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715086426; c=relaxed/simple;
	bh=Yxnfyeh2IaAdO4T8qDfP6RexxVdxlIo3CQDZRvPFWAU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FodTaw06kIZ7JGgDWU9BHZxpmcERybVKaDCHL7Rv27GziomL/+tvAs+SQFTmKqJVdRY41tml1g607FPKHwWfQwgtmw/eXkZCKQbMRSS8/9JhWw7ri7OCQK+iGoecU7r34DqouFRvGM4EZBBMvNYrUcD/mVughDwFFJgETbZQF9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Oj1I7pDB; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Oj1I7pDB"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715086414; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+8CSt1B3wcEFd+rtPMw0xXAdxHRKF4spwCM9JWpEye4=;
	b=Oj1I7pDBJ4R+a1Zd1TZG5Q6iCAdoJIhz7GZ1dEIylwO0kg6i4owFl+Ys+eUmAg+8k5HJ3RoZl3SBDuBiKwC4i7UAGylLpvTee5CN90MUbzpzaD/c4iWk66mckjJ0OT3oZNz+k8WaLBIVEqGLKWPwHe6dmzLDRuFcumgpc2Z+kog=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W607thJ_1715086411;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W607thJ_1715086411)
          by smtp.aliyun-inc.com;
          Tue, 07 May 2024 20:53:33 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: kgraul@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net/smc: fix neighbour and rtable leak in smc_ib_find_route()
Date: Tue,  7 May 2024 20:53:31 +0800
Message-Id: <20240507125331.2808-1-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In smc_ib_find_route(), the neighbour found by neigh_lookup() and rtable
resolved by ip_route_output_flow() are not released or put before return.
It may cause the refcount leak, so fix it.

Link: https://lore.kernel.org/r/20240506015439.108739-1-guwen@linux.alibaba.com
Fixes: e5c4744cfb59 ("net/smc: add SMC-Rv2 connection establishment")
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
v2->v1
- call ip_rt_put() to release rt as well.
---
 net/smc/smc_ib.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index 97704a9e84c7..9297dc20bfe2 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -209,13 +209,18 @@ int smc_ib_find_route(struct net *net, __be32 saddr, __be32 daddr,
 	if (IS_ERR(rt))
 		goto out;
 	if (rt->rt_uses_gateway && rt->rt_gw_family != AF_INET)
-		goto out;
-	neigh = rt->dst.ops->neigh_lookup(&rt->dst, NULL, &fl4.daddr);
-	if (neigh) {
-		memcpy(nexthop_mac, neigh->ha, ETH_ALEN);
-		*uses_gateway = rt->rt_uses_gateway;
-		return 0;
-	}
+		goto out_rt;
+	neigh = dst_neigh_lookup(&rt->dst, &fl4.daddr);
+	if (!neigh)
+		goto out_rt;
+	memcpy(nexthop_mac, neigh->ha, ETH_ALEN);
+	*uses_gateway = rt->rt_uses_gateway;
+	neigh_release(neigh);
+	ip_rt_put(rt);
+	return 0;
+
+out_rt:
+	ip_rt_put(rt);
 out:
 	return -ENOENT;
 }
-- 
2.32.0.3.g01195cf9f

