From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 13/13] s390/qeth: improve fallback to random MAC address
Date: Thu, 26 Apr 2018 09:42:24 +0200
Message-ID: <20180426074224.100432-14-jwi@linux.ibm.com>
References: <20180426074224.100432-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180426074224.100432-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>

If READ MAC fails to fetch a valid MAC address, allow some more device
types (IQD and z/VM OSD) to fall back to a random address.
Also use eth_hw_addr_random(), for indicating to userspace that the
address type is NET_ADDR_RANDOM.

Note that while z/VM has various protection schemes to prohibit
custom addresses on its NICs, they are all optional. So we should at
least give it a try.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 810d69bd9991..a7cb37da6a21 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -439,7 +439,6 @@ static int qeth_l2_process_inbound_buffer(struct qeth_card *card,
 static int qeth_l2_request_initial_mac(struct qeth_card *card)
 {
 	int rc = 0;
-	char vendor_pre[] = {0x02, 0x00, 0x00};
 
 	QETH_DBF_TEXT(SETUP, 2, "l2reqmac");
 	QETH_DBF_TEXT_(SETUP, 2, "doL2%s", CARD_BUS_ID(card));
@@ -459,16 +458,20 @@ static int qeth_l2_request_initial_mac(struct qeth_card *card)
 	    card->info.type == QETH_CARD_TYPE_OSX ||
 	    card->info.guestlan) {
 		rc = qeth_setadpparms_change_macaddr(card);
-		if (rc) {
-			QETH_DBF_MESSAGE(2, "couldn't get MAC address on "
-				"device %s: x%x\n", CARD_BUS_ID(card), rc);
-			QETH_DBF_TEXT_(SETUP, 2, "1err%04x", rc);
-			return rc;
-		}
-	} else {
-		eth_random_addr(card->dev->dev_addr);
-		memcpy(card->dev->dev_addr, vendor_pre, 3);
+		if (!rc)
+			goto out;
+		QETH_DBF_MESSAGE(2, "READ_MAC Assist failed on device %s: x%x\n",
+				 CARD_BUS_ID(card), rc);
+		QETH_DBF_TEXT_(SETUP, 2, "1err%04x", rc);
+		/* fall back once more: */
 	}
+
+	/* some devices don't support a custom MAC address: */
+	if (card->info.type == QETH_CARD_TYPE_OSM ||
+	    card->info.type == QETH_CARD_TYPE_OSX)
+		return (rc) ? rc : -EADDRNOTAVAIL;
+	eth_hw_addr_random(card->dev);
+
 out:
 	QETH_DBF_HEX(SETUP, 2, card->dev->dev_addr, card->dev->addr_len);
 	return 0;
-- 
2.13.5
