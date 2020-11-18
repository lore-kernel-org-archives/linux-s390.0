Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4640 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726468AbgKRVkx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Nov 2020 16:40:53 -0500
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 2/2] net/smc: fix direct access to ib_gid_addr->ndev in smc_ib_determine_gid()
Date: Wed, 18 Nov 2020 22:40:38 +0100
Message-Id: <20201118214038.24039-3-kgraul@linux.ibm.com>
In-Reply-To: <20201118214038.24039-1-kgraul@linux.ibm.com>
References: <20201118214038.24039-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, raspl@linux.ibm.com

Sparse complaints 3 times about:
net/smc/smc_ib.c:203:52: warning: incorrect type in argument 1 (different address spaces)
net/smc/smc_ib.c:203:52:    expected struct net_device const *dev
net/smc/smc_ib.c:203:52:    got struct net_device [noderef] __rcu *const ndev

Fix that by using the existing and validated ndev variable instead of
accessing attr->ndev directly.

Fixes: 5102eca9039b ("net/smc: Use rdma_read_gid_l2_fields to L2 fields")
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_ib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index 1c314dbdc7fa..fc766b537ac7 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -198,9 +198,9 @@ int smc_ib_determine_gid(struct smc_ib_device *smcibdev, u8 ibport,
 		rcu_read_lock();
 		ndev = rdma_read_gid_attr_ndev_rcu(attr);
 		if (!IS_ERR(ndev) &&
-		    ((!vlan_id && !is_vlan_dev(attr->ndev)) ||
-		     (vlan_id && is_vlan_dev(attr->ndev) &&
-		      vlan_dev_vlan_id(attr->ndev) == vlan_id)) &&
+		    ((!vlan_id && !is_vlan_dev(ndev)) ||
+		     (vlan_id && is_vlan_dev(ndev) &&
+		      vlan_dev_vlan_id(ndev) == vlan_id)) &&
 		    attr->gid_type == IB_GID_TYPE_ROCE) {
 			rcu_read_unlock();
 			if (gid)
-- 
2.17.1
