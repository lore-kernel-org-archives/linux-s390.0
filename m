Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3322B9B8;
	Mon,  6 May 2024 02:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714960814; cv=none; b=Nig1PFCopJo+zg8iB1Q3vBecTFXqfT6+nCT6NmXhL66EhccIlAopDgGXWUpMfiXDuvK4VJcDkk/0CJYKDoM+Abi6RQsZakvb0apilq2Bl8ns3MhAsI+sh7avWjdsi6Lpa0owgl8ZCTAcrYCgKBinxOC4OaSVAtfJe5lzOskfoZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714960814; c=relaxed/simple;
	bh=jhTzXXT+FPjZQ5pztBbwg3De5ewUC261fLbR/SBmjRE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LiwRMhVG4NRNPHv3jam7nHR01NYn7iYZJ35cF+++7/FKX5ggifwEuDvN6IcMSdm8n1FRxSBMhRo2z82u6g3IPefg0iQm+9T2M3yDOPBXVIWj4P6eJWooofKPS5Ae4v5ajPBcn4SMEIcW/v66cwE40h+XIKCAt+FBTDi2PMAEzGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RmF0hsN1; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RmF0hsN1"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714960803; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=0y3awyTCfvmpXhlQf3h9Gu7rJ+aU16KQIKj7W928+ms=;
	b=RmF0hsN1vs16GKmTTl3fJNXSaA3WLy7j+xtGEZjPFNpQSA0n0vH5afXgAXryLO8NN36tipM7S/2Bcmyf+qYNh+FoAeKuYGt0KVyFAie4OQHT6bOP7f/gpxhDdOuw13tc9/SFCu8zfQskN6DXQ8HerYrG3bTwBeFA0Cdr3/2knrU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W5pOKbi_1714960479;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W5pOKbi_1714960479)
          by smtp.aliyun-inc.com;
          Mon, 06 May 2024 09:54:41 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net/smc: fix netdev refcnt leak in smc_ib_find_route()
Date: Mon,  6 May 2024 09:54:39 +0800
Message-Id: <20240506015439.108739-1-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A netdev refcnt leak issue was found when unregistering netdev after
using SMC. It can be reproduced as follows.

- run tests based on SMC.
- unregister the net device.

The following error message can be observed.

'unregister_netdevice: waiting for ethx to become free. Usage count = x'

With CONFIG_NET_DEV_REFCNT_TRACKER set, more detailed error message can
be provided by refcount tracker:

 unregister_netdevice: waiting for eth1 to become free. Usage count = 2
 ref_tracker: eth%d@ffff9cabc3bf8548 has 1/1 users at
      ___neigh_create+0x8e/0x420
      neigh_event_ns+0x52/0xc0
      arp_process+0x7c0/0x860
      __netif_receive_skb_list_core+0x258/0x2c0
      __netif_receive_skb_list+0xea/0x150
      netif_receive_skb_list_internal+0xf2/0x1b0
      napi_complete_done+0x73/0x1b0
      mlx5e_napi_poll+0x161/0x5e0 [mlx5_core]
      __napi_poll+0x2c/0x1c0
      net_rx_action+0x2a7/0x380
      __do_softirq+0xcd/0x2a7

It is because in smc_ib_find_route(), neigh_lookup() takes a netdev
refcnt but does not release. So fix it.

Fixes: e5c4744cfb59 ("net/smc: add SMC-Rv2 connection establishment")
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_ib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index 97704a9e84c7..b431bd8a5172 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -210,10 +210,11 @@ int smc_ib_find_route(struct net *net, __be32 saddr, __be32 daddr,
 		goto out;
 	if (rt->rt_uses_gateway && rt->rt_gw_family != AF_INET)
 		goto out;
-	neigh = rt->dst.ops->neigh_lookup(&rt->dst, NULL, &fl4.daddr);
+	neigh = dst_neigh_lookup(&rt->dst, &fl4.daddr);
 	if (neigh) {
 		memcpy(nexthop_mac, neigh->ha, ETH_ALEN);
 		*uses_gateway = rt->rt_uses_gateway;
+		neigh_release(neigh);
 		return 0;
 	}
 out:
-- 
2.32.0.3.g01195cf9f

