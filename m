Return-Path: <SRS0=ar10=RD=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 1/1] net/smc: allow pnetid-less configuration
Date: Thu, 28 Feb 2019 15:10:08 +0100
Message-Id: <20190228141008.16458-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Without hardware pnetid support there must currently be a pnet
table configured to determine the IB device port to be used for SMC
RDMA traffic. This patch enables a setup without pnet table, if
the used handshake interface belongs already to a RoCE port.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_pnet.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 25dfbe343e26..8d2f6296279c 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -754,9 +754,47 @@ static int smc_pnet_find_ndev_pnetid_by_table(struct net_device *ndev,
 	return rc;
 }
 
+/* if handshake network device belongs to a roce device, return its
+ * IB device and port
+ */
+static void smc_pnet_find_rdma_dev(struct net_device *netdev,
+				   struct smc_ib_device **smcibdev,
+				   u8 *ibport, unsigned short vlan_id, u8 gid[])
+{
+	struct smc_ib_device *ibdev;
+
+	spin_lock(&smc_ib_devices.lock);
+	list_for_each_entry(ibdev, &smc_ib_devices.list, list) {
+		struct net_device *ndev;
+		int i;
+
+		for (i = 1; i <= SMC_MAX_PORTS; i++) {
+			if (!rdma_is_port_valid(ibdev->ibdev, i))
+				continue;
+			if (!ibdev->ibdev->ops.get_netdev)
+				continue;
+			ndev = ibdev->ibdev->ops.get_netdev(ibdev->ibdev, i);
+			if (!ndev)
+				continue;
+			dev_put(ndev);
+			if (netdev == ndev &&
+			    smc_ib_port_active(ibdev, i) &&
+			    !smc_ib_determine_gid(ibdev, i, vlan_id, gid,
+						  NULL)) {
+				*smcibdev = ibdev;
+				*ibport = i;
+				break;
+			}
+		}
+	}
+	spin_unlock(&smc_ib_devices.lock);
+}
+
 /* Determine the corresponding IB device port based on the hardware PNETID.
  * Searching stops at the first matching active IB device port with vlan_id
  * configured.
+ * If nothing found, check pnetid table.
+ * If nothing found, try to use handshake device
  */
 static void smc_pnet_find_roce_by_pnetid(struct net_device *ndev,
 					 struct smc_ib_device **smcibdev,
@@ -770,8 +808,10 @@ static void smc_pnet_find_roce_by_pnetid(struct net_device *ndev,
 	ndev = pnet_find_base_ndev(ndev);
 	if (smc_pnetid_by_dev_port(ndev->dev.parent, ndev->dev_port,
 				   ndev_pnetid) &&
-	    smc_pnet_find_ndev_pnetid_by_table(ndev, ndev_pnetid))
+	    smc_pnet_find_ndev_pnetid_by_table(ndev, ndev_pnetid)) {
+		smc_pnet_find_rdma_dev(ndev, smcibdev, ibport, vlan_id, gid);
 		return; /* pnetid could not be determined */
+	}
 
 	spin_lock(&smc_ib_devices.lock);
 	list_for_each_entry(ibdev, &smc_ib_devices.list, list) {
-- 
2.16.4
