From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 4/4] net/smc: determine vlan_id of stacked net_device
Date: Mon, 30 Apr 2018 16:51:19 +0200
Message-ID: <20180430145119.72479-5-ubraun@linux.ibm.com>
References: <20180430145119.72479-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180430145119.72479-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

An SMC link group is bound to a specific vlan_id. Its link uses
the RoCE-GIDs established for the specific vlan_id. This patch makes
sure the appropriate vlan_id is determined for stacked scenarios like
for instance a master bonding device with vlan devices enslaved.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index d9247765aff3..1f3ea62fac5c 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -360,7 +360,8 @@ void smc_lgr_terminate(struct smc_link_group *lgr)
 static int smc_vlan_by_tcpsk(struct socket *clcsock, unsigned short *vlan_id)
 {
 	struct dst_entry *dst = sk_dst_get(clcsock->sk);
-	int rc = 0;
+	struct net_device *ndev;
+	int i, nest_lvl, rc = 0;
 
 	*vlan_id = 0;
 	if (!dst) {
@@ -372,8 +373,27 @@ static int smc_vlan_by_tcpsk(struct socket *clcsock, unsigned short *vlan_id)
 		goto out_rel;
 	}
 
-	if (is_vlan_dev(dst->dev))
-		*vlan_id = vlan_dev_vlan_id(dst->dev);
+	ndev = dst->dev;
+	if (is_vlan_dev(ndev)) {
+		*vlan_id = vlan_dev_vlan_id(ndev);
+		goto out_rel;
+	}
+
+	rtnl_lock();
+	nest_lvl = dev_get_nest_level(ndev);
+	for (i = 0; i < nest_lvl; i++) {
+		struct list_head *lower = &ndev->adj_list.lower;
+
+		if (list_empty(lower))
+			break;
+		lower = lower->next;
+		ndev = (struct net_device *)netdev_lower_get_next(ndev, &lower);
+		if (is_vlan_dev(ndev)) {
+			*vlan_id = vlan_dev_vlan_id(ndev);
+			break;
+		}
+	}
+	rtnl_unlock();
 
 out_rel:
 	dst_release(dst);
-- 
2.13.5
