Return-Path: <linux-kernel-owner+w=401wt.eu-S1752612AbZL1XjY@vger.kernel.org>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [PATCH] drivers/s390/net/qeth_l2_main.c: use %pM to shown MAC address
Date: Mon, 28 Dec 2009 18:39:26 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE19090200F4CF@mi8nycmail19.Mi8.com>
From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-s390@vger.kernel.org
Cc: blaschka@linux.vnet.ibm.com, David Miller <davem@davemloft.net>
List-ID: <linux-s390.vger.kernel.org>

Use the %pM kernel extension to display the MAC address.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Frank Blaschka <blaschka@linux.vnet.ibm.com>
Cc: David S. Miller <davem@davemloft.net>

---

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 0b76339..038299a 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -486,22 +486,14 @@ static int qeth_l2_send_setmac_cb(struct qeth_card *card,
 		case IPA_RC_L2_DUP_MAC:
 		case IPA_RC_L2_DUP_LAYER3_MAC:
 			dev_warn(&card->gdev->dev,
-				"MAC address "
-				"%2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x "
-				"already exists\n",
-				card->dev->dev_addr[0], card->dev->dev_addr[1],
-				card->dev->dev_addr[2], card->dev->dev_addr[3],
-				card->dev->dev_addr[4], card->dev->dev_addr[5]);
+				"MAC address %pM already exists\n",
+				card->dev->dev_addr);
 			break;
 		case IPA_RC_L2_MAC_NOT_AUTH_BY_HYP:
 		case IPA_RC_L2_MAC_NOT_AUTH_BY_ADP:
 			dev_warn(&card->gdev->dev,
-				"MAC address "
-				"%2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x "
-				"is not authorized\n",
-				card->dev->dev_addr[0], card->dev->dev_addr[1],
-				card->dev->dev_addr[2], card->dev->dev_addr[3],
-				card->dev->dev_addr[4], card->dev->dev_addr[5]);
+				"MAC address %pM is not authorized\n",
+				card->dev->dev_addr);
 			break;
 		default:
 			break;
@@ -512,12 +504,8 @@ static int qeth_l2_send_setmac_cb(struct qeth_card *card,
 		memcpy(card->dev->dev_addr, cmd->data.setdelmac.mac,
 		       OSA_ADDR_LEN);
 		dev_info(&card->gdev->dev,
-			"MAC address %2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x "
-			"successfully registered on device %s\n",
-			card->dev->dev_addr[0], card->dev->dev_addr[1],
-			card->dev->dev_addr[2], card->dev->dev_addr[3],
-			card->dev->dev_addr[4], card->dev->dev_addr[5],
-			card->dev->name);
+			"MAC address %pM successfully registered on device %s\n",
+			card->dev->dev_addr, card->dev->name);
 	}
 	return 0;
 } 
