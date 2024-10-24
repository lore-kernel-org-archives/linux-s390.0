Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6081BC8F0;
	Thu, 24 Oct 2024 05:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729748705; cv=none; b=KvZonnM96gW214/Qmy1QzAZOav5+FM0c+1xBEN0OfrMtQbuDENubCon8BW6+H2ZO4E18T8WvPzw2f524J4wSmqBJzUUxslDxUCvmPKrMHtb0T+eNb8qn/XIDKf+k/WvhJOgEGttQXhZ/pDJpfxCQXSp6rg7GsPsu44g91eonev0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729748705; c=relaxed/simple;
	bh=AO9kzHVqu6CkS7PKlwu6V4JxdUz5AE3Z/e1V0l0sLPI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=faFnNKbxN9khr7GMn/s472msJ6IDvApi0fJeNp0aN7U9YNc3AB52wUR159KvDXdHggcMTIe7gdeu0tNAlTHCINR8EoJA9u4t4SI5VsfZrtERpMqI+5uJBQo8yV1KKcaxBBPfHcFF8pTKwyDjVa0s05yRE7FDwVAB/7hlqEn0fDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pC66RixE; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pC66RixE"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729748698; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=6e+vage7Syc/ckTeGnwMXWcLKLUNAWjPBIjR0sU7HoM=;
	b=pC66RixEjkLL6sYJzh6vV3mul5y/BvP5eIrdTvmU3vngJAa9XsIC/R5vo+SRSO3nqlvF0NyiN0DHYsU/8t7WkSEj1+uezoJF+ICuYsG3/DqbrjUs4U//852F6tKzjZHXRHvMoMa2khjyv5m5Gj6gdjrhJrCF3IiaQa5a7/aXq1U=
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WHnzPxs_1729748696 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 24 Oct 2024 13:44:58 +0800
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
Subject: [PATCH net-next] net/smc: use new helper to get the netdev associated to an ibdev
Date: Thu, 24 Oct 2024 13:44:56 +0800
Message-Id: <20241024054456.37124-1-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch [1] provides common interfaces to store and get net devices
associated to an IB device port and removes the ops->get_netdev()
callback of mlx5 driver. So use the new interface in smc.

[1]: 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and get_netdev functions")

Reported-by: D. Wythe <alibuda@linux.alibaba.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_ib.c   | 8 ++------
 net/smc/smc_pnet.c | 4 +---
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index 9297dc20bfe2..9c563cdbea90 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -899,9 +899,7 @@ static void smc_copy_netdev_ifindex(struct smc_ib_device *smcibdev, int port)
 	struct ib_device *ibdev = smcibdev->ibdev;
 	struct net_device *ndev;
 
-	if (!ibdev->ops.get_netdev)
-		return;
-	ndev = ibdev->ops.get_netdev(ibdev, port + 1);
+	ndev = ib_device_get_netdev(ibdev, port + 1);
 	if (ndev) {
 		smcibdev->ndev_ifidx[port] = ndev->ifindex;
 		dev_put(ndev);
@@ -921,9 +919,7 @@ void smc_ib_ndev_change(struct net_device *ndev, unsigned long event)
 		port_cnt = smcibdev->ibdev->phys_port_cnt;
 		for (i = 0; i < min_t(size_t, port_cnt, SMC_MAX_PORTS); i++) {
 			libdev = smcibdev->ibdev;
-			if (!libdev->ops.get_netdev)
-				continue;
-			lndev = libdev->ops.get_netdev(libdev, i + 1);
+			lndev = ib_device_get_netdev(libdev, i + 1);
 			dev_put(lndev);
 			if (lndev != ndev)
 				continue;
diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index a04aa0e882f8..716808f374a8 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -1054,9 +1054,7 @@ static void smc_pnet_find_rdma_dev(struct net_device *netdev,
 		for (i = 1; i <= SMC_MAX_PORTS; i++) {
 			if (!rdma_is_port_valid(ibdev->ibdev, i))
 				continue;
-			if (!ibdev->ibdev->ops.get_netdev)
-				continue;
-			ndev = ibdev->ibdev->ops.get_netdev(ibdev->ibdev, i);
+			ndev = ib_device_get_netdev(ibdev->ibdev, i);
 			if (!ndev)
 				continue;
 			dev_put(ndev);
-- 
2.32.0.3.g01195cf9f

