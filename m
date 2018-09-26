From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 15/15] s390/qeth: remove duplicated carrier state tracking
Date: Wed, 26 Sep 2018 18:29:16 +0200
Message-ID: <20180926162916.102720-16-jwi@linux.ibm.com>
References: <20180926162916.102720-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180926162916.102720-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The netdevice is always available, apply any carrier state changes to it
without caching them.
On a STARTLAN event (ie. carrier-up), defer updating the state to
qeth_core_hardsetup_card() in the subsequent recovery action.

Also remove the carrier-state checks from the xmit routines. Stopping
transmission on carrier-down is the responsibility of upper-level code
(eg see dev_direct_xmit()).

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  1 -
 drivers/s390/net/qeth_core_main.c | 12 +++++-------
 drivers/s390/net/qeth_core_sys.c  |  7 +++----
 drivers/s390/net/qeth_l2_main.c   |  6 +-----
 drivers/s390/net/qeth_l3_main.c   |  6 +-----
 5 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 64bcb1237db0..cd44ff2df6fe 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -763,7 +763,6 @@ struct qeth_switch_info {
 struct qeth_card {
 	struct list_head list;
 	enum qeth_card_states state;
-	int lan_online;
 	spinlock_t lock;
 	struct ccwgroup_device *gdev;
 	struct qeth_channel read;
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 9cbdc6760aba..0078b5d217cc 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -652,16 +652,13 @@ static struct qeth_ipa_cmd *qeth_check_ipa_data(struct qeth_card *card,
 				 "The link for interface %s on CHPID 0x%X failed\n",
 				 QETH_CARD_IFNAME(card), card->info.chpid);
 			qeth_issue_ipa_msg(cmd, cmd->hdr.return_code, card);
+			netif_carrier_off(card->dev);
 		}
-		card->lan_online = 0;
-		netif_carrier_off(card->dev);
 		return NULL;
 	case IPA_CMD_STARTLAN:
 		dev_info(&card->gdev->dev,
 			 "The link for %s on CHPID 0x%X has been restored\n",
 			 QETH_CARD_IFNAME(card), card->info.chpid);
-		netif_carrier_on(card->dev);
-		card->lan_online = 1;
 		if (card->info.hwtrap)
 			card->info.hwtrap = 2;
 		qeth_schedule_recovery(card);
@@ -5133,13 +5130,14 @@ int qeth_core_hardsetup_card(struct qeth_card *card)
 		if (rc == IPA_RC_LAN_OFFLINE) {
 			dev_warn(&card->gdev->dev,
 				"The LAN is offline\n");
-			card->lan_online = 0;
+			netif_carrier_off(card->dev);
 		} else {
 			rc = -ENODEV;
 			goto out;
 		}
-	} else
-		card->lan_online = 1;
+	} else {
+		netif_carrier_on(card->dev);
+	}
 
 	card->options.ipa4.supported_funcs = 0;
 	card->options.ipa6.supported_funcs = 0;
diff --git a/drivers/s390/net/qeth_core_sys.c b/drivers/s390/net/qeth_core_sys.c
index 970f6c71a66e..30f61608fa22 100644
--- a/drivers/s390/net/qeth_core_sys.c
+++ b/drivers/s390/net/qeth_core_sys.c
@@ -31,10 +31,9 @@ static ssize_t qeth_dev_state_show(struct device *dev,
 	case CARD_STATE_SOFTSETUP:
 		return sprintf(buf, "SOFTSETUP\n");
 	case CARD_STATE_UP:
-		if (card->lan_online)
-		return sprintf(buf, "UP (LAN ONLINE)\n");
-		else
-			return sprintf(buf, "UP (LAN OFFLINE)\n");
+		return sprintf(buf, "UP (LAN %s)\n",
+			       netif_carrier_ok(card->dev) ? "ONLINE" :
+							     "OFFLINE");
 	case CARD_STATE_RECOVER:
 		return sprintf(buf, "RECOVER\n");
 	default:
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index ed475b4ddd3e..c810d53fff51 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -694,7 +694,7 @@ static netdev_tx_t qeth_l2_hard_start_xmit(struct sk_buff *skb,
 	int tx_bytes = skb->len;
 	int rc;
 
-	if ((card->state != CARD_STATE_UP) || !card->lan_online) {
+	if (card->state != CARD_STATE_UP) {
 		card->stats.tx_carrier_errors++;
 		goto tx_drop;
 	}
@@ -997,10 +997,6 @@ static int __qeth_l2_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 		goto out_remove;
 	}
 	card->state = CARD_STATE_SOFTSETUP;
-	if (card->lan_online)
-		netif_carrier_on(card->dev);
-	else
-		netif_carrier_off(card->dev);
 
 	qeth_set_allowed_threads(card, 0xffffffff, 0);
 
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 86c89338b1a2..80893481bb85 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2233,7 +2233,7 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 			goto tx_drop;
 	}
 
-	if (card->state != CARD_STATE_UP || !card->lan_online) {
+	if (card->state != CARD_STATE_UP) {
 		card->stats.tx_carrier_errors++;
 		goto tx_drop;
 	}
@@ -2573,10 +2573,6 @@ static int __qeth_l3_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 
 	qeth_set_allowed_threads(card, 0xffffffff, 0);
 	qeth_l3_recover_ip(card);
-	if (card->lan_online)
-		netif_carrier_on(card->dev);
-	else
-		netif_carrier_off(card->dev);
 
 	qeth_enable_hw_features(card->dev);
 	if (recover_flag == CARD_STATE_RECOVER) {
-- 
2.16.4
