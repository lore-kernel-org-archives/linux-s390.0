Return-Path: <SRS0=Yw43=QB=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 4/8] s390/qeth: register MAC address earlier
Date: Fri, 25 Jan 2019 15:44:19 +0100
In-Reply-To: <20190125144423.81443-1-jwi@linux.ibm.com>
References: <20190125144423.81443-1-jwi@linux.ibm.com>
Message-Id: <20190125144423.81443-5-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

commit 4789a2188048 ("s390/qeth: fix race when setting MAC address")
resolved a race where our initial programming of dev_addr into the HW
and a call to ndo_set_mac_address() could run concurrently. In this
case, we could end up getting confused about which address was actually
set in the HW.

The quick fix was to introduce additional locking that blocks any
ndo_set_mac_address() while the device is being set online. But the race
primarily originated from the fact that we first register the netdevice,
and only then program its dev_addr. By re-ordering this sequence,
userspace will only be able to change the MAC address _after_ we have
finished with setting the initial dev_addr.

Still, the same MAC address race can also occur during a subsequent call
to qeth_l2_set_online(). So keep around the locking for now, until a
follow-up patch fully resolves this.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 8b9181c8bc7e..3aa11f32dcd5 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -97,8 +97,7 @@ static int qeth_l2_send_setmac(struct qeth_card *card, __u8 *mac)
 	rc = qeth_l2_send_setdelmac(card, mac, IPA_CMD_SETVMAC);
 	if (rc == 0) {
 		dev_info(&card->gdev->dev,
-			 "MAC address %pM successfully registered on device %s\n",
-			 mac, card->dev->name);
+			 "MAC address %pM successfully registered\n", mac);
 	} else {
 		switch (rc) {
 		case -EEXIST:
@@ -458,6 +457,15 @@ static int qeth_l2_request_initial_mac(struct qeth_card *card)
 	return 0;
 }
 
+static void qeth_l2_register_dev_addr(struct qeth_card *card)
+{
+	if (!is_valid_ether_addr(card->dev->dev_addr))
+		qeth_l2_request_initial_mac(card);
+
+	if (!IS_OSN(card) && !qeth_l2_send_setmac(card, card->dev->dev_addr))
+		card->info.mac_bits |= QETH_LAYER2_MAC_REGISTERED;
+}
+
 static int qeth_l2_validate_addr(struct net_device *dev)
 {
 	struct qeth_card *card = dev->ml_priv;
@@ -845,8 +853,6 @@ static int qeth_l2_setup_netdev(struct qeth_card *card, bool carrier_ok)
 				       PAGE_SIZE * (QDIO_MAX_ELEMENTS_PER_BUFFER - 1));
 	}
 
-	if (!is_valid_ether_addr(card->dev->dev_addr))
-		qeth_l2_request_initial_mac(card);
 	netif_napi_add(card->dev, &card->napi, qeth_poll, QETH_NAPI_WEIGHT);
 	rc = register_netdev(card->dev);
 	if (!rc && carrier_ok)
@@ -901,14 +907,12 @@ static int __qeth_l2_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 		dev_info(&card->gdev->dev,
 		"The device represents a Bridge Capable Port\n");
 
+	qeth_l2_register_dev_addr(card);
+
 	rc = qeth_l2_setup_netdev(card, carrier_ok);
 	if (rc)
 		goto out_remove;
 
-	if (card->info.type != QETH_CARD_TYPE_OSN &&
-	    !qeth_l2_send_setmac(card, card->dev->dev_addr))
-		card->info.mac_bits |= QETH_LAYER2_MAC_REGISTERED;
-
 	if (qeth_is_diagass_supported(card, QETH_DIAGS_CMD_TRAP)) {
 		if (card->info.hwtrap &&
 		    qeth_hw_trap(card, QETH_DIAGS_TRAP_ARM))
-- 
2.16.4
