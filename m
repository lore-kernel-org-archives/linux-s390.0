From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 07/10] s390/qeth: clean up qeth_set_ecmd_adv_sup()
Date: Tue, 11 Apr 2017 16:11:16 +0200
Message-ID: <20170411141119.82526-8-jwi@linux.vnet.ibm.com>
References: <20170411141119.82526-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170411141119.82526-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

In preparation for moving to get_link_ksettings(), clean up how
we build the supported and advertised port/speed masks.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 57 +++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 44d15c967c7d..41fe9631e24e 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -6024,57 +6024,56 @@ void qeth_core_get_drvinfo(struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(qeth_core_get_drvinfo);
 
-/* Helper function to fill 'advertizing' and 'supported' which are the same. */
-/* Autoneg and full-duplex are supported and advertized uncondionally.	     */
-/* Always advertize and support all speeds up to specified, and only one     */
+/* Helper function to fill 'advertising' and 'supported' which are the same. */
+/* Autoneg and full-duplex are supported and advertised unconditionally.     */
+/* Always advertise and support all speeds up to specified, and only one     */
 /* specified port type.							     */
 static void qeth_set_ecmd_adv_sup(struct ethtool_cmd *ecmd,
 				int maxspeed, int porttype)
 {
-	int port_sup, port_adv, spd_sup, spd_adv;
+	u32 sup, adv;
+
+	sup = SUPPORTED_Autoneg;
+	adv = ADVERTISED_Autoneg;
 
 	switch (porttype) {
 	case PORT_TP:
-		port_sup = SUPPORTED_TP;
-		port_adv = ADVERTISED_TP;
+		sup |= SUPPORTED_TP;
+		adv |= ADVERTISED_TP;
 		break;
 	case PORT_FIBRE:
-		port_sup = SUPPORTED_FIBRE;
-		port_adv = ADVERTISED_FIBRE;
+		sup |= SUPPORTED_FIBRE;
+		adv |= ADVERTISED_FIBRE;
 		break;
 	default:
-		port_sup = SUPPORTED_TP;
-		port_adv = ADVERTISED_TP;
+		sup |= SUPPORTED_TP;
+		adv |= ADVERTISED_TP;
 		WARN_ON_ONCE(1);
 	}
 
-	/* "Fallthrough" case'es ordered from high to low result in setting  */
-	/* flags cumulatively, starting from the specified speed and down to */
-	/* the lowest possible.						     */
-	spd_sup = 0;
-	spd_adv = 0;
+	/* fallthrough from high to low, to select all legal speeds: */
 	switch (maxspeed) {
 	case SPEED_10000:
-		spd_sup |= SUPPORTED_10000baseT_Full;
-		spd_adv |= ADVERTISED_10000baseT_Full;
+		sup |= SUPPORTED_10000baseT_Full;
+		adv |= ADVERTISED_10000baseT_Full;
 	case SPEED_1000:
-		spd_sup |= SUPPORTED_1000baseT_Half | SUPPORTED_1000baseT_Full;
-		spd_adv |= ADVERTISED_1000baseT_Half |
-						ADVERTISED_1000baseT_Full;
+		sup |= SUPPORTED_1000baseT_Half | SUPPORTED_1000baseT_Full;
+		adv |= ADVERTISED_1000baseT_Half | ADVERTISED_1000baseT_Full;
 	case SPEED_100:
-		spd_sup |= SUPPORTED_100baseT_Half | SUPPORTED_100baseT_Full;
-		spd_adv |= ADVERTISED_100baseT_Half | ADVERTISED_100baseT_Full;
+		sup |= SUPPORTED_100baseT_Half | SUPPORTED_100baseT_Full;
+		adv |= ADVERTISED_100baseT_Half | ADVERTISED_100baseT_Full;
 	case SPEED_10:
-		spd_sup |= SUPPORTED_10baseT_Half | SUPPORTED_10baseT_Full;
-		spd_adv |= ADVERTISED_10baseT_Half | ADVERTISED_10baseT_Full;
-	break;
+		sup |= SUPPORTED_10baseT_Half | SUPPORTED_10baseT_Full;
+		adv |= ADVERTISED_10baseT_Half | ADVERTISED_10baseT_Full;
+		/* end fallthrough */
+		break;
 	default:
-		spd_sup = SUPPORTED_10baseT_Half | SUPPORTED_10baseT_Full;
-		spd_adv = ADVERTISED_10baseT_Half | ADVERTISED_10baseT_Full;
+		sup |= SUPPORTED_10baseT_Half | SUPPORTED_10baseT_Full;
+		adv |= ADVERTISED_10baseT_Half | ADVERTISED_10baseT_Full;
 		WARN_ON_ONCE(1);
 	}
-	ecmd->advertising = ADVERTISED_Autoneg | port_adv | spd_adv;
-	ecmd->supported = SUPPORTED_Autoneg | port_sup | spd_sup;
+	ecmd->supported = sup;
+	ecmd->advertising = adv;
 }
 
 int qeth_core_ethtool_get_settings(struct net_device *netdev,
-- 
2.10.2
