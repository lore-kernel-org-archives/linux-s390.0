From: frank.blaschka@de.ibm.com
Subject: [patch 4/6] [PATCH] qeth: Clarify card type naming for virtual NICs
Date: Mon, 19 Nov 2012 13:46:48 +0100
Message-ID: <20121119124659.721024655@de.ibm.com>
References: <20121119124644.679089322@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline; filename=603-qeth-card-naming.diff
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Stefan Raspl <raspl@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Raspl <raspl@linux.vnet.ibm.com>

So far, virtual NICs whether attached to a VSWITCH or a guest LAN were always
displayed as guest LANs in the device driver attributes and messages, while
in fact it is a virtual NIC.

Signed-off-by: Stefan Raspl <raspl@linux.vnet.ibm.com>
Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
Reviewed-by: Ursula Braun <ursula.braun@de.ibm.com>
---
 drivers/s390/net/qeth_core_main.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -73,13 +73,13 @@ static inline const char *qeth_get_cardn
 	if (card->info.guestlan) {
 		switch (card->info.type) {
 		case QETH_CARD_TYPE_OSD:
-			return " Guest LAN QDIO";
+			return " Virtual NIC QDIO";
 		case QETH_CARD_TYPE_IQD:
-			return " Guest LAN Hiper";
+			return " Virtual NIC Hiper";
 		case QETH_CARD_TYPE_OSM:
-			return " Guest LAN QDIO - OSM";
+			return " Virtual NIC QDIO - OSM";
 		case QETH_CARD_TYPE_OSX:
-			return " Guest LAN QDIO - OSX";
+			return " Virtual NIC QDIO - OSX";
 		default:
 			return " unknown";
 		}
@@ -108,13 +108,13 @@ const char *qeth_get_cardname_short(stru
 	if (card->info.guestlan) {
 		switch (card->info.type) {
 		case QETH_CARD_TYPE_OSD:
-			return "GuestLAN QDIO";
+			return "Virt.NIC QDIO";
 		case QETH_CARD_TYPE_IQD:
-			return "GuestLAN Hiper";
+			return "Virt.NIC Hiper";
 		case QETH_CARD_TYPE_OSM:
-			return "GuestLAN OSM";
+			return "Virt.NIC OSM";
 		case QETH_CARD_TYPE_OSX:
-			return "GuestLAN OSX";
+			return "Virt.NIC OSX";
 		default:
 			return "unknown";
 		}
